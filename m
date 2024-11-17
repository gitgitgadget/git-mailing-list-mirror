Received: from mariecurie.slightlybroken.com (mariecurie.slightlybroken.com [116.203.185.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2061CBE8C
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 14:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.185.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731852408; cv=none; b=GfdIc/WnG79Aj7vGVNw9qCQD6RLMVnwC93eE9RjAKMILkITDqUraiinVoc/8a+jOjXV90NV83YDyk7WjdYmWYqSRLgFoJxe8hEYmreJSSZfr8CjTw5z93wWF0JbUVB/2spVCUz06gOSBEMPF/hbMZtk9R2ZgTGwdXlf4IIrGwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731852408; c=relaxed/simple;
	bh=nTjtJgUCR+Lfrx8iAmrjdPvaybkc1b/buGhxxyVcwvQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZOmyUKwc1nflgfsohSvoXuBz+VYxavDUxfi2Pi4z3Dl5qU8ely/B46o5I05pzTSAGDLME+tM63lIICQZBxINK5eP6V3GPhQYHZSiz3suwt8TbpVWptZXZXwoSWpCsI99Rp0MCfn5FwWuSsXa+CKcXRZ4V0uJ7TkrjHQDevKOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=labrat.space; spf=pass smtp.mailfrom=labrat.space; dkim=pass (2048-bit key) header.d=labrat.space header.i=@labrat.space header.b=Pvl98TZD; arc=none smtp.client-ip=116.203.185.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=labrat.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=labrat.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=labrat.space header.i=@labrat.space header.b="Pvl98TZD"
Received: from labrat.space (46-126-49-17.dynamic.hispeed.ch [46.126.49.17])
	by mariecurie.slightlybroken.com (Postfix) with ESMTPSA id 5103C60DBE05
	for <git@vger.kernel.org>; Sun, 17 Nov 2024 15:00:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=labrat.space;
	s=201904; t=1731852049;
	bh=nTjtJgUCR+Lfrx8iAmrjdPvaybkc1b/buGhxxyVcwvQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From:To:CC:Date:
	 Subject:Content-Type:Content-Disposition:Reply-To:In-Reply-To:
	 MIME-Version:Message-ID:References;
	b=Pvl98TZDYhWaQwbI0DaNgIKCnyn9C0W+AZlknV3D2KHcPgctCyxIrlK6oDBxEh08e
	 hjNz+YlGOdPN2FYCNFERosWsCS924AiVjqEGpR4k4/EevzU8ZKNnEWhzPepM0t+vYy
	 2be/2ERL3IiEWePkEC40NPKPNCpxT5MdMDzRTsMmw8ipRxwyx+6N029rZEZBI+IzNS
	 ngFAcokSC2FArijW2x8Zh627jIKqUGTmma1eeEgxZFSosYSxXySF6eBTwG9b4+lZX0
	 lrsH18SY+fI8PDgKvlycDbeDqfwsSyz/+3NNjfBA4yRm+SP81ZW1uWTjhgbZrJ9Bl1
	 BdgNFfYfX3y1g==
Date: Sun, 17 Nov 2024 15:00:41 +0100
From: Reto <reto@labrat.space>
To: git@vger.kernel.org
Subject: Re: [Question] OAuth Integration with git
Message-ID: <rjnm7xkk764fqvjl43qtchqapmcqgfw3ia5brpsocfotwm3x2d@uexpitxb532x>
Mail-Followup-To: git@vger.kernel.org
References: <014301db3839$bdfa7240$39ef56c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014301db3839$bdfa7240$39ef56c0$@nexbridge.com>

On Sat, Nov 16, 2024 at 10:10:53AM -0500, rsbecker@nexbridge.com wrote:
> Hi Team,
> I was wondering whether there are any good discussions about integrating
> OAuth with git using a custom credential helper. A process flow would be
> very helpful.

Not sure I understand the question fully... such a thing already exists:
* https://github.com/hickford/git-credential-oauth
* https://github.com/git-ecosystem/git-credential-manager

The "process" is the usual git credential protocol, and you can look at
the two implementations above if you like to get an example.

Is there something more specific you had in mind?
