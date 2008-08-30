From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <planche2k@googlemail.com>
Subject: Re: [PATCH/resend] Fix use of hardlinks in "make install"
Date: Sat, 30 Aug 2008 13:39:27 +0200
Message-ID: <60597530-B8AC-421E-84DF-BF241CB799C5@googlemail.com>
References: <81b0412b0808280704h585b6cb4nf03e509de0159a91@mail.gmail.com> <81b0412b0808280717u78c5ccf8ne1413c701ed8edd9@mail.gmail.com> <20080830002032.GA14522@steel.home> <66B007DD-F970-43E5-BA38-6138E553C93A@googlemail.com> <81b0412b0808300308m2d03b94ft8601f02b2fea494e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 13:41:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZOpJ-0007eG-Lh
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 13:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbYH3Lj5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2008 07:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbYH3Lj4
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 07:39:56 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:63432 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbYH3Lj4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2008 07:39:56 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1096915muf.1
        for <git@vger.kernel.org>; Sat, 30 Aug 2008 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=xLZkRcIHt8hdF/InZQvAv8L93g7zlK6fDUUc86B1RtQ=;
        b=MVrOqv82lGp2Pr6UMCz7o3akN4PMNhdlwUleCnIprLRis2vcD8iZsaLl9YXhflz8RM
         0nMWNb57zxzpE94ZX1pI8Mq1367IsZYE/g6Uee0QQ83Cg7O+x3Z5T8kT4e2GcnmwwQvP
         RcuDrBSrozYTLCjDaP+29MDl0LeRz3f5Wt9iE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=NW0EGHuAEFCUnI512qcuy5/B/jWWS/ViaUCLLuRI8js6JS9+lDg+vt+Q7UQqcgU6mC
         E1RDG94NLGbqnyGNXy1HmR4NT98S1cYkeimB5lwPHro2JL5QfeCczka7QkVhM/FXMXgq
         V4fCU7OlsTvBPohEmoz/S2qVt5pBhWZuWEa54=
Received: by 10.103.243.7 with SMTP id v7mr2660909mur.118.1220096393104;
        Sat, 30 Aug 2008 04:39:53 -0700 (PDT)
Received: from ?10.0.1.1? ( [91.18.70.30])
        by mx.google.com with ESMTPS id b9sm5219156mug.13.2008.08.30.04.39.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Aug 2008 04:39:52 -0700 (PDT)
In-Reply-To: <81b0412b0808300308m2d03b94ft8601f02b2fea494e@mail.gmail.com>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94376>


Am 30.08.2008 um 12:08 schrieb Alex Riesen:

> 2008/8/30 Andreas F=E4rber <planche2k@googlemail.com>:
>> Am 30.08.2008 um 02:20 schrieb Alex Riesen:
>>
>>> Well, as usual, simple fix for a trivial typo caused by existence =20
>>> of an
>>> idiotic platform.
>>>
>> Your patch seems to work on Haiku, don't have a MinGW setup to =20
>> test. Sorry
>> for the breakage.
>
> What?! Haiku uses stupid file extensions to mark executables?

No, it doesn't. Like BeOS, it uses MIME types stored as BFS attributes =
=20
as well as the standard POSIX executable bit.

Since no one appeared to have replied yet, I confirmed that your =20
Windows patch does not break things here and looks reasonable to me as =
=20
co-author of the offending commit.

Andreas
