From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git-imap-send bugfix: Allow lines starting with "From " 
	in body
Date: Mon, 22 Mar 2010 08:07:23 +0530
Message-ID: <f3271551003211937p37d37816wacfe67faacb09add@mail.gmail.com>
References: <f3271551003211147x538d7682wc67dcc4f914ed97c@mail.gmail.com> 
	<7vwrx5gwjz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, me@mutt.org,
	ossi@users.sf.net, tytso@mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 03:38:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtXWY-0000CK-0V
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 03:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772Ab0CVChp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Mar 2010 22:37:45 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43957 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab0CVCho convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 22:37:44 -0400
Received: by gwaa18 with SMTP id a18so766674gwa.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 19:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bFIKt9oTxSH5HiOzQnhc4Y0FqBdR3hlTufS1JWiQM3s=;
        b=QEvK8wub5OkT/s6giKa+YaGievmkdHQogSUnZUABEmHJM4MfZ7fNioXHlmLIODvvnK
         om6vgJxB79shUbObE5P8THx5xPL6qUtLerxUDm11HcfPkaL1Ips6fFcrSbqG8mrIOltj
         2JGNPAXKccGx/FAdf55UGixbOOj5umvedsMUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NTCNWM83qK+xPKQQuW2iOU9mWFcV9PDJgzLB3XY7ILqlTzsEo4jqUqQzwHmT9Os2xr
         65SG81JxiRlkvwgzjhmywr6UmXAIqqsauzfG+GKpLvNy97xuayQlrqW8i6QIJYrY1XFP
         /9j2LTq/U5K/+phet8wGho7RsUQJA15unvxQo=
Received: by 10.91.164.27 with SMTP id r27mr3660063ago.20.1269225463356; Sun, 
	21 Mar 2010 19:37:43 -0700 (PDT)
In-Reply-To: <7vwrx5gwjz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142884>

[Culling mike@codeweavers.com from CC]

> As "git help imap-send" clearly says that this command is intended to=
 be
> used on output from format-patch (but it actually does not say "and
> nothing else", which it should for your patch to make sense), I think=
 the
> code is allowed to assume _some_ fixed order of the header fields. =A0=
It
> would break people's existing abuse to use imap-send to stuff random
> pieces of messages in mbox to their IMAP server, though.

Yes, it would. Don't you think the bug it fixes justifies the break?
Perhaps we should mention in the documentation that it accepts
mailboxes where emails must have those three mandatory fields in that
order?

> But does format-patch _always_ start each message with these and only=
 with
> these fields in this order? =A0Where would Message-Id:, References:, =
and Cc:
> come when the user told format-patch to add them?

Yes. From, Date, and Subject are the minimum set of fields for any
general patch produced by git-format-patch, and they always appear in
that order. For example, see this header:

=46rom 20f0cf89fb9508f9e5197a3cf47a872053d4941d Mon Sep 17 00:00:00 200=
1
Message-Id: <20f0cf89fb9508f9e5197a3cf47a872053d4941d.1269224757.git.ar=
tagnon@gmail.com>
In-Reply-To: <42ef3f8cebd4d34e24b1544036cd48f56110c2d4.1269224756.git.a=
rtagnon@gmail.com>
References: <13132>
	<42ef3f8cebd4d34e24b1544036cd48f56110c2d4.1269224756.git.artagnon@gmai=
l.com>
=46rom: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Sun, 21 Mar 2010 23:58:25 +0530
Subject: [PATCH 2/2] git-imap-send bugfix: Allow lines starting with
"From " in body
Cc: gitster@pobox.com

Thanks,
Ramkumar
