From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 10/10] t/t9001-send-email.sh: get rid of unnecessary backquotes
Date: Fri, 8 Jan 2016 23:29:56 +0100
Message-ID: <CA+EOSB=jVho9XCAG0Q3P6dvH6A99b5yB7FcyxkS3DtxupBeoFA@mail.gmail.com>
References: <1452251188-12939-1-git-send-email-gitter.spiros@gmail.com>
	<1452251188-12939-11-git-send-email-gitter.spiros@gmail.com>
	<vpqa8ogdsyr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 08 23:30:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHfXo-0002b9-Js
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 23:30:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776AbcAHW37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 17:29:59 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34297 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756216AbcAHW35 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 17:29:57 -0500
Received: by mail-vk0-f67.google.com with SMTP id a123so4024432vkh.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 14:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GxRcMEeyaLRXaq3OPoQjNA01ZyvBaFCp5+Gie1CMO9I=;
        b=FAH4lRCcCPogCmVN+FccQOso2d7Ael60HUgWq1gS8xCiN2htJw0a7Wd4K9kXPEeGfz
         KZMHmTBM1IAOuQr/C1CRAccWHgBLRjKHtZMIJJbKL3r+cQoDuLPoMNSJGVm0KBWL8cEP
         TPk8QUYXktcEQ2GiKfVUfCk8n9BI2k0atnzAXm4/kjsFWFnLxUUHX0YNX7Ex+Uq7MB+0
         v42kk4Wf+oNDYDzoO+uqBxFY4/Jvh2dz10tSzkijljQtvyrBnZ0uJzdlYOrL1tWUvrmo
         zDtkGCevyIN+i7Ig2BpBAe4mvuDHPkAuuUXtlmsDkE3dsweJVLunVkDNLOC3v3VbEx9w
         eq6w==
X-Received: by 10.31.52.147 with SMTP id b141mr72770688vka.82.1452292196529;
 Fri, 08 Jan 2016 14:29:56 -0800 (PST)
Received: by 10.31.56.209 with HTTP; Fri, 8 Jan 2016 14:29:56 -0800 (PST)
In-Reply-To: <vpqa8ogdsyr.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283586>

2016-01-08 15:52 GMT+01:00 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> Instead of making the shell expand 00* and invoke 'echo' with it,
>> and then capturing its output as command substitution, just use
>> the result of expanding 00* directly.
>
> This is not actually how it happens. cover=`echo *` expands the * before
> the assignment to $cover, while cover="*" assigns a litteral * to
> $cover.
>
> Then, when you use $cover, the variable is expanded to * and then it is
> expanded to filenames here:
>
>>       mv $cover cover-to-edit.patch &&
>
> On the other hand, this instance of $cover is quoted, hence the
> *-expansion won't happen:
>
>>       perl -pe "s/^From:/$header: extra\@address.com\nFrom:/" cover-to-edit.patch >"$cover" &&
>
> So, I believe this patch is not correct.
>
> OTOH, patches 1 to 9 look good to me.
>

Yup. I am really sorry. I was not aware of the particular case,
despite having tested the patch.

Thanks for the review. Junio you kindly remove this patch?

Thank you all very much.

Sorry about the noise

Best regards

> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
