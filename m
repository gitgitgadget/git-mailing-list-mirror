Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7F7C6CA
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809804; cv=none; b=f0zf0SHfesIYn4dd2taTSAfX5vr9vwU5uWt+/hkzwjX8BqHJ7Q8gc1AqYTY1sEI29DqhB4QBw/aZvnkipsWRpLrumFfqRsHXgSTPLNyVy9KaURwQvUdM7knbR/tyMZgW+Gd6DXepWjWqnuc0TgsO0j/RbOw+tI5zXfC/k+R/yp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809804; c=relaxed/simple;
	bh=wogAKccdrvoz9GeowoQTHdLOJbmHqhqV07XfJmk9dgA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=maOOByyunxGgHaZ7V+tR9L286cXd7ATgrOB3/9+slXFK9CCDiQ6XkS6fQ7JH22SYenA10EZsAjjUyrFg/WPr6C6cW+nVAka8F2xhHf+Q7403hBaNy95eEAmZE5TLvZOWLYeV1RxpOmmfc4QQRj5llx+TPrUZu9XK7NERoNZ42ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sFuwrI8z; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sFuwrI8z"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706809798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYA1zD8JQf+k5rfHSmuRXXveGVP4aOdhvorGzaUsW7s=;
	b=sFuwrI8zqJakjp2xphPtzApWZ+8yvK537ODhADHt89AWx+AQscguClgKrvbiriC8q6gfgV
	lt1/1ffG0+SxbrJMa5enl3bV30uK7UPYqoPkXFr+wEys2Wcaf5kI5Smm4YBjhhf7C5eRFp
	GFheiXoKwRe+xWCTglxdQcAmaRATgN/289JlALyEwAwSDcM0lHqvuh4XJa7aasNKkxF7Rm
	eGXMNFlJP9cgudZRzGuijiPicgM/TsgQCA829GTnLYtEE5jn8qmg4/JCQIVrt+WSi5Y/uQ
	0RaUAmXv89yv2Kg+9gZVJcbdC1Tr77F7XmW/Xw7Wn3a7ki0+ErK1tHK+FG9XvQ==
Date: Thu, 01 Feb 2024 18:49:58 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Hans Meiser <brille1@hotmail.com>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 git@vger.kernel.org
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
In-Reply-To: <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
Message-ID: <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-01 18:28, Hans Meiser wrote:
> Thank you for enlightening me and elaborating on all of these very
> important facts!
> 
> Just to make sure: So "git" is considered part of the kernel? And the
> "git documentation" is considered part of the kernel, too?

Of course it isn't.

> Shouldn't these topics be separated then into separate repositories,
> particularly the git documentation?
> 
> For people like me, who are contributing to dozens of documentations
> on GitHub (and GitLab) … We don't focus on the kernel alone. We
> receive dozens of important technical, business and financially
> important e-mails from different sources day by day. So, people like
> me need some modern, common channels/tools for contributing. (If
> contribution is considered helpful and valuable by the kernel team at
> all.)

Could you, please, clarify what kind of git documentation are you
referring to?  Are you having git man pages in mind?

> With todays platforms, issues can be created by e-mail and e-mails
> will be received with each issue update. It's even possible to upload
> patches via REST services. No web browser required. So this would keep
> mailing list users acquainted to their habit.
> 
> Setting up a local (on-premise) GitLab or Azure DevOps server for
> long-term use should not be impossible. I'm running each of these
> myself. Once installed on-premise, the installation wouldn't be bound
> to any continuous support. All it needs is a provider for keeping the
> server machine running.

Quite frankly, I think you've missed some important points from the
Konstantin's message.  To sum it up a bit, not having continuous support
is simply unacceptable for any kind of a long-term project.
