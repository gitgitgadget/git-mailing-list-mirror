Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E5026F44D
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754058985; cv=none; b=rJJfwmLtm/MQAcszSMxxfToCU0nDa9N/FyALCski/TymsYY4uoEH2IKWz3GL+1Y6itsO8J64i8Qoi/MCGjI0tnVxX4HwrjC/Q4asaWqHhOKkmilmt2sTsrZ1dMGNuxF+vk/4gqLirn6rUYVHa52Ou6kvw/tIsHuQho6yssQEnEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754058985; c=relaxed/simple;
	bh=aITkJfL2tghZMeHPDbs3XUiQyinKHPG1NTENf+R3hFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPIOuR/sFE0LYZ0vKkjb4rgm9w2b0Rn8gSx3JWdLvb1//YsrXrMkWP3JT450byVzYa2n7xhS+oRAUq+ksxEGTk6MxYKz2JszfTue1Coc35MqFZRNhNBZ1UEri8XukB3YvlF690AK2Sd9VftKt8A2O/ye7/8fcTPriBk/4cXMNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=GzvOuPGj; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="GzvOuPGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754058979; x=1754663779;
	i=oswald.buddenhagen@gmx.de;
	bh=aITkJfL2tghZMeHPDbs3XUiQyinKHPG1NTENf+R3hFc=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GzvOuPGjQ+HZUsmg0a4ZRrHCttq5ftL9O3yvbO5TgEdP0df7VQCHLrplfPpeXJ8d
	 9fY9jppCrDGuNnTItWKfpvVYa/GiGopBPgMSfkqqDVaTR6gOBp32zqfL38iK66jbb
	 4E6Vp2ngOVgRIkGHeWFo/AX6kgjLhjOQg8Ixd11SiJt8m9qKivFwzoRktjW92jXLb
	 axv6E4F3f5bn6SAiqSqHPfJaR6I2pQcBgZrv9gPQqWcSfBgh7yQVAYpQNQPvtGkbi
	 JbOyPW2qQoEQwpQDLQYE26A2aSjePJ44HROUfVCx3GYxmSRd5Xp12Sq+5ZfekhFjA
	 OJtpy+stzGuEMLCbDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.115]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1uq8rE3qMQ-008W2H; Fri, 01
 Aug 2025 16:36:18 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1uhqrq-gnU-00; Fri, 01 Aug 2025 16:36:18 +0200
Date: Fri, 1 Aug 2025 16:36:18 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Ayush Chandekar <ayu.chandekar@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/3] config: warn on core.commentString=auto
Message-ID: <aIzQ4tw8Xp7upyo3@ugly>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <cover.1753975294.git.phillip.wood@dunelm.org.uk>
 <8b57598042642dd0c56e39be03c1c45a62accfb0.1753975294.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8b57598042642dd0c56e39be03c1c45a62accfb0.1753975294.git.phillip.wood@dunelm.org.uk>
X-Provags-ID: V03:K1:sjE11mJhQzeVTcStzk/gQyOBQAMJpEXKYx+WbxBaArwolXzglgL
 M0kHLlHqukO+Vke0Tw9RSiEGUm24haDMwwFyq686Q7Sy4s6MyMajKUD6PZ2u+Doj4fpy7Fm
 Xspbt0cR0jXcqmTYO5Rw6y3Ua37oIp1/kddLkStxmR5QXF2yG1Uq/uz7PDrmYM6gpPhMVMe
 gjyZtWZaTbiq8+mdVdVmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RJWDWyZjclo=;pp13dU3PU2POJAYeJSnlAAuqwBy
 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
 vim/iA9B5tA==

On Thu, Jul 31, 2025 at 04:21:54PM +0100, Phillip Wood wrote:
>From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>As support for this setting was deprecated in the last commit print a
>warning (or die when WITH_BREAKING_CHANGES is enabled) if it is set.
>When printing a warning avoid bombarding the user by only printing it

>when running commands commands that run "git commit" and only only
>
something is very wrong with this line.

>once per command. Some scaffolding is added to repo_read_config()
>to allow it to detect deprecated config settings and warn about
>them. As both "core.commentChar" and "core.commentString" set the
>comment character we record which one of them is used and tailor the
>warning message appropriately.
>
