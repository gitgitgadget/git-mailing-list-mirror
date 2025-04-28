Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96FF3FB1B
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 04:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745813785; cv=none; b=Ds4jnLS8C4ZHk57aVTxWJFBA4l3QPhwEw+yrLDy22UBegOV/h70FS3l/16dn+EIk4X3SPp8+phx3vIoc8bEwcL1WstZB4zf472fswYIrdo3XQihPznUNHR7GMKAXYHzPyqpKTgPtec3JD8jR6eAe+YyOUhtfMHWT6nyF4ff1uiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745813785; c=relaxed/simple;
	bh=zGyZ7L95loZz4h+mwqks4ow9U6kex4YBfXdGHsOG9Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Epkw+ym4sPJavTk2X8MKJD4FHk6vP+I6LjgQFwoqhQFaRzihmSLRk7W7O+0yS4oUmN2Eo32FvSNTDS+VwSXoMdAvHmlgOFD1nnCyOsqEro8l/qRJwCWeLdbmNrScDlIPX6ypP7uNUN4yD0CmwN3/WddQ9yRnBjQzJNMMZ244z+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=OYfixT0f; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="OYfixT0f"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 90DEC25DA2;
	Mon, 28 Apr 2025 06:16:13 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i2eJdMGLrlpv; Mon, 28 Apr 2025 06:16:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1745813772; bh=zGyZ7L95loZz4h+mwqks4ow9U6kex4YBfXdGHsOG9Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OYfixT0fdNt+V8gyx66Q4IgZ3Y+BmW3mX+3aFGDcq3f7XlUzjFpREyaPCzLBduh3+
	 L8h99tVE97Exz0q0ctx2tf7dUkEItqQRno6xETDUQLTUichNum7jKOy0HLxK9y4syY
	 WycY4cvXKWvjaQ5gTVZ19dNad+oU8t1DdoIuhg7ZD7ONtSijByOSMMnDcj9pqDjTg0
	 sldOHML4PxYrz+FhvjtiNtKmRAoICh/cfKPHfGT59/lfHGPinBkbtyqyWqT0yGKLKf
	 omnTT0VAEaWer3C4+bYtJ89NkbWPVAAtP3Bk7khT0f5rTxrUB8QIhmRz6X6aDNT9pM
	 HYhb5pkZBETOA==
Date: Mon, 28 Apr 2025 04:16:00 +0000
From: Yao Zi <ziyao@disroot.org>
To: Aditya Garg <gargaditya08@live.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>,
	Erik Huelsmann <ehuels@gmail.com>
Subject: Re: [PATCH v5 2/3] send-email: retrieve Message-ID from outlook SMTP
 server
Message-ID: <aA8BAP-4VM84TRmM@pie>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB9588861EB2B9589C8BA6A8EBB8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <2025042437-photo-header-2d0d@gregkh>
 <aA0h5t0M2XZLUtvi@pie.lan>
 <PN0PR01MB95888DC7CF57D9E8376B1985B8862@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PN0PR01MB95888DC7CF57D9E8376B1985B8862@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>

On Mon, Apr 28, 2025 at 01:35:32AM +0530, Aditya Garg wrote:
> > Not only Outlook comes with such quirk, AFAIK the mail service that
> > Tencent provides for personal usage does as well. I don't think it's a
> > good idea to hardcode the problematic providers.
> > 
> > Not sure whether similar ideas have been proposed earlier: since this
> > quirk affects only following e-mails but not the coverletter which
> > doesn't have a In-reply-to field, is it possible to detect the quirk
> > with the response of sending the coverletter by comparing the desired
> > Message-ID and the one in response? We could throw a warning and
> > automatically fixes following mails if the bad case really happens.
> 
> From what I understand, what you want here is, that
> 
> 1. Irrespective of the email provider, I use the logic I am using for each mail.
> 2. I extract the message-id, and compare it with the intended one.
> 3. Give a warning and fix it.

Yes.

> But, no. Outlook luckily shows the message ID in its response, and is there in
> $smtp->message. In fact you can see the whole server response here:
> 
> https://github.com/marlam/msmtp/issues/190#issuecomment-2794784869
> 
> Now say I use this logic with gmail. The $smtp->message in gmail is similar to
> outlook, but has 2 main differences:
> 
> 1. The angular brackets <> are missing.
> 2. There is no message id! Rather it has a random string of numbers and letters
>    that I also am not aware of what they mean.
> 
> So, different providers have different ways, to respond.

Thanks for explaining this, it's really not that simple as my first
glance. With the explanation, hardcoding the provider seems pretty
reasonable to me.

> What does Tencent do? Have you tried to log the SMTP messages?

Sadly no. I don't really use their services but just have seen guys hit
by the same problem.

> In any case I don't find any way to automatically determine this. And I certainly
> don't think we can poke into receiver's email to see what message id they got.
> 
> I also don't know how corporates work. Is the SMTP server for them the same ultimately?
> Or are they using some Azure server?
> 
> Tbh Microsoft does not like following standards with Outlook. It doesn't even support
> OAUTHBEARER which is supposed to be the standard, rather uses Google's XOAUTH2. So why
> not hardcode? Do you have any other solution?> 
> > This could avoid a broken thread for newcomers and should play well with
> > an option introduced together for specifying dedicated behaviour.
> > 
> >> thanks,
> >>
> >> greg k-h
> > 
> > Please Cc me on future updates of the series, thank you Aditya.
> > 
> > Best regards,
> > Yao Zi
> 

Thanks for the fix,
Yao Zi
