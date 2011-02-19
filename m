From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [RFC/PATCH 0/3] Thinning the git toplevel directory
Date: Sat, 19 Feb 2011 10:24:53 +0100
Message-ID: <AANLkTikb0W-yLihPtvm5LDUKgxgRg_a5Rsq7pjnpZLCt@mail.gmail.com>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
	<1297304069-14764-1-git-send-email-pclouds@gmail.com>
	<20110218022701.GA23435@elie>
	<AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
	<20110218092518.GB30648@elie>
	<4D5F0A7C.1080507@gmail.com>
	<7v39nkooem.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 10:25:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqj3n-00044t-3n
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 10:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab1BSJY6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 04:24:58 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52480 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab1BSJYz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 04:24:55 -0500
Received: by vws12 with SMTP id 12so50701vws.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 01:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mnZzFQfTTh7ZhStbAlX4bB6JLLmi4JcmECNLyUCUTKo=;
        b=FVr2l/JNBcxkTb/QjYIRCylzVI6UlkXUz9HAy0aSkL45p1osbUa8uyYXJOo3cN7vf6
         BovmeZGNI6NJHvrC2SvDuZyDN/XrbpP4HsOp4g0sQUM5gJD7MntFkWzRjCvdj/i9gx0O
         lJt9i5l7Sw0Eb5XXySSZ/luFY1rqQXdPSbrdo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EYLgIW27VrWYSliJcPYkT1rtE2gUav2jFRv5QQJAJ+RvTHV4cFoZzPafcXRL+/HJIZ
         JaWUsw9mdFGMa3/YUYs2ij6jo9/X7/CZGYKMH60AHt99FDGu9NoEZdWwlH0ceZ0m8e97
         M4R4fEi5QSagetWhINsEN+QHbHGHADsxz1ybY=
Received: by 10.52.158.66 with SMTP id ws2mr2924329vdb.177.1298107493813; Sat,
 19 Feb 2011 01:24:53 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Sat, 19 Feb 2011 01:24:53 -0800 (PST)
In-Reply-To: <7v39nkooem.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167261>

On Sat, Feb 19, 2011 at 1:31 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
>
>> My suggestions - put each category in their own dir/name space:
>>
>> - sources - developer related files you can hack
>>
>> - technical/developer documentation like format descriptions,
>> =A0 coding guidelines etc.
>>
>> - end user documentation like command documentation, howtos, faqs et=
c
>
> Mild nak. =A0We are talking about a source tree; there is no end-user
> documentation. =A0Only the sources to it.

That's what I was talking about. Examples of what I consider "end user =
docs":

   - git-add.txt, git-bisect.txt etc - probably for all commands in
command-list.txt.
     Not sure about porcelain vs plumbing, but since division is not
clear I'd put
     them all together.

     Note that not everyone compiles docs into man pages - for example =
I don't
     have needed tools on my laptop and it's not that fast too. I just
have to use
     raw .txt files instead.

   - config.txt, probably some of howto/*


Examples of "devel docs": howto/maintain-git.txt, technical/*, CodingGu=
idelines


>> - build result - objects, final binaries, generated documentation et=
c
>> =A0 The advantage besides unclutterting is possibility to have sourc=
es on
>> =A0 read-only medium.
>
> This is somewhere between a meh to mild nak. =A0"git grep" knows to i=
gnore
> untracked cruft, so this does not help nor hinder "finding" at all. E=
ven

It requires me to use git-grep. I might be used to plain "grep". I
might not have
git installed yet. I might use some other tool for browsing/searching
the source.

Having "cruft" mixed with sources gives you restrictions without giving=
 any
advantages (at least I don't see any - if you do please tell me) .


--=20
Piotrek
