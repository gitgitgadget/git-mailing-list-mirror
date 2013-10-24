From: james.moger@gitblit.com
Subject: Re: RFE: support change-id generation natively
Date: Thu, 24 Oct 2013 08:11:05 -0400
Message-ID: <1382616665.23343.37953397.70FB76CB@webmail.messagingengine.com>
References: <2127507934.9293293.1382367063640.JavaMail.root@openwide.fr>
 <201310212029.01589.thomas@koch.ro>
 <1382380858.25852.36711509.53CF173C@webmail.messagingengine.com>
 <201310211249.49568.mfick@codeaurora.org>
 <xmqqy55lrsoo.fsf@gitster.dls.corp.google.com>
 <CACsJy8A7r-gsbru0eLxtJbFk2vgqvBH9akHn6e53k=UJbZ1K7Q@mail.gmail.com>
 <xmqqzjq0q8nl.fsf@gitster.dls.corp.google.com>
 <CACsJy8CuEvdTu+P-P-kYC0dKQKnjh5sRoevd_hsbqF0796i0xw@mail.gmail.com>
 <8D1AF6D7-F7AA-4E64-B6B3-3C8C931312C3@codeaurora.org>
 <CACsJy8BoqWMqGPM8JDny6mxkxZzhWrQ6RYZiNK=vzdwXL4a=vQ@mail.gmail.com>
 <5268B7D6.5050106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Thomas Koch <thomas@koch.ro>,
	Jeremy Rosen <jeremy.rosen@openwide.fr>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>,
	Duy Nguyen <pclouds@gmail.com>,
	Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Thu Oct 24 14:18:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZJs2-00089Z-Ki
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 14:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891Ab3JXMSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 08:18:30 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46164 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754763Ab3JXMS3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Oct 2013 08:18:29 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Oct 2013 08:18:29 EDT
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 57E3521981;
	Thu, 24 Oct 2013 08:11:05 -0400 (EDT)
Received: from web5 ([10.202.2.215])
  by compute1.internal (MEProxy); Thu, 24 Oct 2013 08:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=gitblit.com; h=
	message-id:from:to:cc:mime-version:content-transfer-encoding
	:content-type:in-reply-to:references:subject:date; s=mesmtp; bh=
	INeRGeKA3G4je/x64HQCgLQXmgA=; b=RqGOlxc0N/aZEjd99EBUX7tNF1j2TX0m
	kjds8sl3WzfQpBZJCJWsfecL3ANmK+kZi9I+DTKv5ju/xj3ePP1vpc34uCQAfkDB
	dhQiTgvSAqH5T5WmX0TXGuO6a91eZ8wHrZRGbbQPjZDKiqD87wIiYVD/OcwU05ji
	wUpXuOALvqo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:from:to:cc:mime-version
	:content-transfer-encoding:content-type:in-reply-to:references
	:subject:date; s=smtpout; bh=INeRGeKA3G4je/x64HQCgLQXmgA=; b=LGN
	DmrEgp7FCSHbM/WD0Vf4AFT8/VoRmKCC5Pu69kw5QyHfgWVM4fLcOe4YQZkbtuqO
	TLieoASVuvBBuPTwZvqv7Oba/Z20VFCeiQimfG0k+ZM9CypLfBGEfgmcL2tDIhRa
	RUyVw//jw3579jfXimCQ1kIWQZbyzUyO6ySFclsw=
Received: by web5.nyi.mail.srv.osa (Postfix, from userid 99)
	id 2ACF2A7DAD8; Thu, 24 Oct 2013 08:11:05 -0400 (EDT)
X-Sasl-Enc: B4VRBukXEZFCH4p+krbZeuk4Zs+MTyAxUHFiWvaIps38 1382616665
X-Mailer: MessagingEngine.com Webmail Interface - ajax-25c9bdb0
In-Reply-To: <5268B7D6.5050106@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236582>

> That said, I don't think that --change-id option that the user must not
> forget to use is any better than a hook that the user must not forget to
> install.

Having a --change-id option, to my mind, simplifies use of the patch
workflow as it does not require downloading, copying and setting
executable a hook script per-repository or globally.  I agree that
forgetting to add it on the command-line is a potential problem.  This
could be improved by honoring the "gerrit.createchangeid" value (or
whatever setting name is appropriate).  Of course that still requires
configuring the repo after clone, but it's clean and straight-forward
since it is all plain "git config".

-J
