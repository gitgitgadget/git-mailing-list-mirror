Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDDA25DD08
	for <git@vger.kernel.org>; Sat, 26 Apr 2025 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745691135; cv=none; b=ozzh7Py2NqDrzL4E/ODg8xuCW25svBfbMBWoqvhDWPvdsusi9KdZzsLlb8pq0EVPe1PIIL0cAfdJBZkJacFxj0oS4Ahx69muTI9Ymb3nYINkAP3/NR0o9/S+lWOMoqBgQILUIimNdhajAqSCcE6AzusEaKWieOTEAqM8uX/A/cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745691135; c=relaxed/simple;
	bh=ufwdN+0oaLsRCbaxsYHT3NUu/WcfOLKQ55P05l9cjXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cepVGxCrFKuFWgB1UMFyQiZ6tGLrCJizPPrpIy7RiCCLYYHZoPrApDgkqEAwlr0bt4ulqD4BGjZA4XJxlg9oz5QzeeZE89sS3x13s0DSX2ZNdZ/fmdfXzpWAF0+ftI/JCY2KLMxRoVmKzq8E20SacjKe9jJnxJ3DdKTeFTo/F0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=MEZ3Xq59; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="MEZ3Xq59"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id EA67025E01;
	Sat, 26 Apr 2025 20:12:02 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Psgff964Mwya; Sat, 26 Apr 2025 20:12:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1745691122; bh=ufwdN+0oaLsRCbaxsYHT3NUu/WcfOLKQ55P05l9cjXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MEZ3Xq59g2jMwB0AEoEIapeJPG9ED9HHTVCUwt8yt0bQ5uxQelLTSy5Ltgo6kVH7h
	 qK6DZKLvAD02wd3kS2DdPypP2bD7CcBrno0LVad5CtBiHQXG5YAUnc6DMkGS6RdjhX
	 MaSBCr6S2pDCqmMqoP/wj/CaBqX6hE7Rf0U4nO8svhmnx/uGRXAi/S42kDPJy2yfpQ
	 sG3dFrw0ZMbTVjkQyocB5n7fx26a//NQ1WhJ1lSkaAK2G+ewuu9U6swyEmZiuUIkB1
	 kRiFLFzu4fT6yGp4nfZDIrVBoPwY0KDjB+vyvOy2sLXt4EhhG/oSksDeDNLY0cnekw
	 lAnH4pTypl2Uw==
Date: Sat, 26 Apr 2025 18:11:50 +0000
From: Yao Zi <ziyao@disroot.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>,
	Erik Huelsmann <ehuels@gmail.com>
Subject: Re: [PATCH v5 2/3] send-email: retrieve Message-ID from outlook SMTP
 server
Message-ID: <aA0h5t0M2XZLUtvi@pie.lan>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB9588861EB2B9589C8BA6A8EBB8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <2025042437-photo-header-2d0d@gregkh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042437-photo-header-2d0d@gregkh>

On Thu, Apr 24, 2025 at 03:09:20PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Apr 24, 2025 at 07:53:54AM +0000, Aditya Garg wrote:
> > The script generates a Message-ID alongwith the other headers when
> > gen_header is called, and is sent alongwith the email. For most email
> > providers, including gmail, the Message-ID goes unchanged to the
> > recipient.
> > 
> > But, this does not seem to be a case with Outlook. In Outlook, when we
> > send our own Message-ID as a part of the headers, it discards it. Then
> > it generates a new random Message-ID and that is what the recipient
> > gets.
> > 
> > This is a problem because the Message-ID is crucial when we are sending
> > multiple emails in a thread. The current implementation for threads in
> > the script replies to the Message-ID it generated, but due to Outlook's
> > behavior, it is not the same as the one that the recipient got, thus
> > breaking threads. So a need arises to retrieve the Message-ID from the
> > server response and set it in the In-Reply-To and References email
> > headers instead of using the self generated one for the purpose of
> > replies.
> > 
> > The $smtp->message variable in this script for outlook is something like
> > this:
> > 
> > 2.0.0 OK <Message-ID> [Hostname=Some-hostname]
> > 
> > The Message-ID here is the one the recipient gets, rather than the one
> > the script generated.
> > 
> > This patch uses the fact above and retrieves the Message-ID from the
> > server response. It then changes the value of the $message_id variable
> > to the one received from the server. This value will be used when next
> > and subsequent messages are sent as replies to the message, thus
> > preserving the threading of the messages.
> > 
> > Signed-off-by: Aditya Garg <gargaditya08@live.com>
> > ---
> >  git-send-email.perl | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index 9ba47a6f38..8c8544f120 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1643,6 +1643,11 @@ sub gen_header {
> >  	return ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header);
> >  }
> >  
> > +sub is_outlook {
> > +	my ($host) = @_;
> > +	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
> > +}
> 
> No real objection here, but what about all of the company-hosted outlook
> server systems out there?  Do they need this same type of "flag"?  And
> if so, why not make it a config variable?

Not only Outlook comes with such quirk, AFAIK the mail service that
Tencent provides for personal usage does as well. I don't think it's a
good idea to hardcode the problematic providers.

Not sure whether similar ideas have been proposed earlier: since this
quirk affects only following e-mails but not the coverletter which
doesn't have a In-reply-to field, is it possible to detect the quirk
with the response of sending the coverletter by comparing the desired
Message-ID and the one in response? We could throw a warning and
automatically fixes following mails if the bad case really happens.

This could avoid a broken thread for newcomers and should play well with
an option introduced together for specifying dedicated behaviour.

> thanks,
> 
> greg k-h

Please Cc me on future updates of the series, thank you Aditya.

Best regards,
Yao Zi
