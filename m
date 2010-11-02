From: Pat Notz <patnotz@gmail.com>
Subject: Re: git commit -C vs. prepare-commit-msg hook
Date: Tue, 2 Nov 2010 14:11:33 -0600
Message-ID: <AANLkTimdjAc1ZKNkWAO_KU8CqorShMv0TNDvsy5qmSDw@mail.gmail.com>
References: <20101102145059.GB2116@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 02 21:12:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDNDA-0007cQ-0F
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 21:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822Ab0KBUL5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 16:11:57 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41392 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0KBUL4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Nov 2010 16:11:56 -0400
Received: by ewy7 with SMTP id 7so4325957ewy.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 13:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FXscxM6cw2fb1DVn6YUxmbNUAsIQ1u8M22pM1laxVGQ=;
        b=pk9tVcFBTQ5aaRrIj2HxCHoInhil589xZj+dtysY4QX5YS/u5qcONcVsYx3A3jBvwD
         5usPZqie6P3QKhxVEPbPc41PlFLH/CMbpc4bcQAyWSkdNtsANvgGGtVSyhbMXXS/aon5
         13YXqfxy3jkTPwQ/W19h1IUoxwroKjPiOgstQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=wUtdzv88uWztwMI7o7aV/4zL2JLn6vXfzxfngaE8R91s11ZqIvG5iRK72qTYfnpRwz
         CBIP6Si+0vFEmPzAff/IcH653yc/Nj28y2iyA+aAIxKu6WDFJmzxKz1yC5ZnTiAZIOCk
         sP87yt3xUIOrgGqjH8krfZtQ92iJ1dkSRb3CM=
Received: by 10.204.33.85 with SMTP id g21mr14926056bkd.55.1288728713979; Tue,
 02 Nov 2010 13:11:53 -0700 (PDT)
Received: by 10.204.70.140 with HTTP; Tue, 2 Nov 2010 13:11:33 -0700 (PDT)
In-Reply-To: <20101102145059.GB2116@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160551>

2010/11/2 SZEDER G=E1bor <szeder@ira.uka.de>:
> Hi,
>
> Just noticed (read: got bitten by ;) that 'git commit' runs the
> prepare-commit-msg hook even if it was invoked with the -C option.
> This seems contradictory to me, because 'git commit -C' is to reuse a=
n
> already existing log message (and author info) as is, whereas
> prepare-commit-msg is there to automatically edit the commit message.
>

Can your hook look for the presence of the third command line argument
to catch this case?  Granted, you won't be able to tell the difference
between -C and -c or --amend.

> Is this desired and I'm missing something, or is this a bug? =A0(or j=
ust
> accidental, but we can't do anything about it anyway because of
> backward compatibility?)
>
> Thanks.
>
>
> Best,
> G=E1bor
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
