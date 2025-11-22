Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4677D211A05
	for <git@vger.kernel.org>; Sat, 22 Nov 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763776849; cv=none; b=swlWdQ7RVS864LQONQW3XnV9YauYBmGezMVBrjnbgoLepOrKTae/mdzH/nj9S2GMkqHnmCHXTmyScicVaZydQPpP+kS1dBrSt2pNLCtGODPsuKNhiP8KaeHLjuRmblk1BqkJmbVe5zLMyv4gIXuWZj6dhCnCpU+TQ3SsHr2L8jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763776849; c=relaxed/simple;
	bh=g1KnVaaa59++/mRA2yD/BK+PAYtKC3jxt2/s7Nq9pUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2Wx1B53A3I51rPZqXGNpRbMKZYi0+Q3rhL1SGPT3x8nMegEHHP0av/AmKj7NVnw4vcRMfDRxtFP2NAbzmzgYzSBD/HNHBAPUNaY16+UIhFY5gVNHrMc/8fvyrh7O8+UWqInvRYMeRiBJgpfpB8ixTMfJnNkbKapAkFLwM+ihgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jpfv8RX/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jpfv8RX/"
Received: by linux.microsoft.com (Postfix, from userid 1227)
	id D9E4A2120707; Fri, 21 Nov 2025 18:00:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9E4A2120707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763776847;
	bh=/EIJSg90Fn3IS76kHnK5Mx+GCWM9KedjNSmWsNIKaeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jpfv8RX/9gNxtWD5MKKaxhGtZlQiwDhrS1FvULqn8A3nZaMxHM64GUYubTke/v1bZ
	 SZyU3trfoE/yv7kD/3xY61peSCrQW22wOGEyIivvxTiq3entZVrZ68/nlilVpAAimO
	 SVmOC+jQIoERy6lSrohUd82XqHObehhFEiv/sL1k=
Date: Fri, 21 Nov 2025 18:00:47 -0800
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Delilah Ashley Wu via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Delilah Ashley Wu <delilahwu@microsoft.com>,
	Derrick Stolee <stolee@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH/RFC 0/4] config: read both home and xdg files for --global
Message-ID: <20251122020047.GB3947@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
 <xmqqbjkyccae.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjkyccae.fsf@gitster.g>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Nov 19, 2025 at 06:44:25AM -0800, Junio C Hamano wrote:
> "Delilah Ashley Wu via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > As reported in [1]: `$HOME/.gitconfig` and `$XDG_CONFIG_HOME/git/config` are
> > both valid global config locations, but `git config list --global` only
> > includes the former in its output.
> 
> ... while "git config list" includes both, which is an inconsistency
> without good reason.

Good point! Will add above to the v2 cover letter.

> What is the reason behind [RFC] in the title?  Are there things that
> are iffy yourself in the patches that reviewers want to pay special
> attention to?

There wasn't any reason; I accidentally left the GitHub PR in draft
mode when I submitted it. I'll drop the [RFC] in v2.

And thanks for the review! You covered the points that I also felt
iffy about, e.g. introducing a regression in the middle of the patch
series. I'll address your feedback in v2.

Delilah :)
