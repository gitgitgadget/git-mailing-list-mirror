From: Marco Stornelli <marco.stornelli@gmail.com>
Subject: Re: [PATCH v4] Thunderbird: fix appp.sh format problems
Date: Tue, 4 Sep 2012 08:37:55 +0200
Message-ID: <CANGUGtBk7DME4pkhJhcYoaM-q_S+i9_6u_Ku-9N6D41Mx50ghg@mail.gmail.com>
References: <5040C59A.6090303@gmail.com>
	<50412E2D.7070503@kdbg.org>
	<5041BC94.7000304@gmail.com>
	<504214AA.9080706@kdbg.org>
	<50425F8B.5020406@gmail.com>
	<7voblognny.fsf@alter.siamese.dyndns.org>
	<5044D162.1010608@gmail.com>
	<7voblmeua3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 08:38:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8mlx-00064s-81
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 08:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125Ab2IDGh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 02:37:57 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56258 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172Ab2IDGh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 02:37:56 -0400
Received: by eaac11 with SMTP id c11so1810590eaa.19
        for <git@vger.kernel.org>; Mon, 03 Sep 2012 23:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=osN4te74CjR9Pi95VaOP44ZjX6kb/VsHHwaDwx/M3y4=;
        b=DxKioE8/l9CxAnxsbcw/4xP6207YZ3Cl0fBa1f19ZbcNGCj1AgqfSntSaUqYifJ+34
         SEr3KUUzAmHeA00v2jFq0KJXuGRSeKHU1dTW8jdgBJsQrmjro/RtqVhH5N1iDCrjJFfm
         zkHjiPgyWuMqrPx5PvhdIeO2u7HmbWp4IpMEEgKfA5zKh2xaQ3hhG/5fnx+gKnZVFsm2
         s5kz988fdpDE/zrOKgBuh3wUshP78YfmybtlGCyDPfwfYoMOYFRvkNSBakB8oLNTftFM
         U0thgTazeGtGMEo+x/pBfoFB+aZO0XU47jehODcJ61PEIm4Sw8Va3rDzpAbEngTQ18XP
         8FDA==
Received: by 10.14.203.73 with SMTP id e49mr24734839eeo.27.1346740675322; Mon,
 03 Sep 2012 23:37:55 -0700 (PDT)
Received: by 10.14.68.129 with HTTP; Mon, 3 Sep 2012 23:37:55 -0700 (PDT)
In-Reply-To: <7voblmeua3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204718>

2012/9/3 Junio C Hamano <gitster@pobox.com>:
> Marco Stornelli <marco.stornelli@gmail.com> writes:
>
>> I tried the Johannes's script, but it seems it doesn't work well with
>> the pattern of format-patch (To: <mail1>,\n   <mail2>,\n
>> <mailN>). The multilines are not well managed.
>
> I am guessing that the reason why Jonahhes's "copy our headers out
> with continuation lines intact" approach does not work is because
> Thunderbird does not want to see its own header part (i.e. that
> which comes before that $SEP) contain RFC-2822 style continuation
> lines.
>
> Can you grab a typical input (i.e. the contents of what is passed as
> $1 to the appp.sh script) and show us how it looks like here so that
> we can take a look?  It would be fine to paste the contents, but we
> might want to protect it from MUA by doing an attachment or a
> pastebin URL.

I don't have thunderbird now but actually it's really simple:

Subject:
To:
Cc:
$SEP

Each data must be in a signle line, for example "Cc: <mail1>,.....,<mailN>"

>
> It appears that the original script tries very hard to keep the
> Subject: line at the beginning, but I am not sure if that is because
> Thunderbird wants to read its "$1" that way, or it is just that
> original appp.sh script happened to be written that way without real
> reason.  If I were updating this script, what I would do would be
> more like:

Ok, good coding then.

Regards,

Marco
