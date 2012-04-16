From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (Apr 2012, #05; Thu, 12)
Date: Mon, 16 Apr 2012 10:50:55 -0700
Message-ID: <CA+55aFyZYnAxJc8YT=GEnq-fdXbHCXyx937KNBngn69Zuxmcgg@mail.gmail.com>
References: <20120416082641.5d239ef6@mkiedrowicz.ivo.pl> <CA+55aFwkf2bOLmUCU+_pSg0OzGyfQ1x-Cy_CiczpJN3zsThNWg@mail.gmail.com>
 <7vehrnwpoi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 19:51:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJq5C-0008Dy-Ii
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 19:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab2DPRvR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 13:51:17 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:40739 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab2DPRvR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 13:51:17 -0400
Received: by wejx9 with SMTP id x9so3509363wej.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 10:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=p9K+MMNYSrTenQwNykY4oCyNkCEtHyRRmu8EdfGq0Zs=;
        b=yGjy/jxU5Mwwf+qVgkrFWnkB5T0LwCHcE1a24PTkrEctKVemI7b6TI09zK0Hk++w1e
         0hbAG/IYIIhmLJpv6WPTgFgslZgQDeHVqbvn+Gd3pvWdQ8yBk4OVZgPp3n0t6Ue8MV6A
         koWj24U6OYCWsHmoJo8Jk3JLR4ds/qsCbCNbCOthvQ4kb1YUxyl8oSqstyHWMJ95IigL
         UnHrs4O0lrSiRiULC1AafnvumYyoCyA46q/07A68O9X8efnnkIP0S4tND+JzmkQ2KEYf
         h0JnRe+/ZlUJmZJ0CxhAHZDyL/XZL8r20KLOja/WfRvrlbJbq6fd3IvHrPi2xwwfGZT5
         uSqg==
Received: by 10.180.101.136 with SMTP id fg8mr20959197wib.4.1334598676045;
 Mon, 16 Apr 2012 10:51:16 -0700 (PDT)
Received: by 10.216.221.167 with HTTP; Mon, 16 Apr 2012 10:50:55 -0700 (PDT)
In-Reply-To: <7vehrnwpoi.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: Ko809OIrFUwsU73omGgii4HVUdk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195672>

On Mon, Apr 16, 2012 at 10:29 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> I wonder if use of remoteheads later in the same function are correct=
,
> though. =A0We equate "!remoteheads->next" and "We are not doing octop=
us",
> for example.

I do think it would generally be a great idea to never use
"remoteheads" at all. An octopus merge that has been simplified to
just two parents isn't really an octopus merge any more.

So I think you're probably right - we should try to avoid using
remoteheads entirely, and any use is suspect

                 Linus
