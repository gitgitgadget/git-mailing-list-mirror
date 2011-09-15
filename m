From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 2/4] cleanup: use internal memory allocation wrapper
 functions everywhere
Date: Thu, 15 Sep 2011 10:39:50 -0500
Message-ID: <CA+sFfMdVntk+U13UeMO=k1SCKJGhPfTpC9_i9kFOkbUJXrF-qg@mail.gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
	<1316051979-19671-1-git-send-email-drafnel@gmail.com>
	<1316051979-19671-3-git-send-email-drafnel@gmail.com>
	<4E71A0C7.8080602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	sunshine@sunshineco.com, bharrosh@panasas.com,
	trast@student.ethz.ch, zapped@mail.ru
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 15 17:39:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4E2e-0000oA-Jv
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 17:39:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934065Ab1IOPjw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 11:39:52 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62373 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934046Ab1IOPjv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 11:39:51 -0400
Received: by fxe4 with SMTP id 4so752060fxe.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CvUZ3GF/ixr9MAreANELYMiOTIaWUn0sx7shkn5q4iY=;
        b=tLCkVhav/Pmaxhy98lSgUJf1Fai6oDKT6TA7zeCVRUwnEQXJAXbyMQYGgJzBoUH7iB
         uRcIXwUV5apbtX/koJQ3V1BE1vbFI3XhTz9FPr1fZwtmthSIbxNAGxnSVm2Yc00VBi+8
         pTaPRSJTmGxtiXG6icseRXTHQcafkk62IhrBU=
Received: by 10.223.63.8 with SMTP id z8mr1071114fah.84.1316101190069; Thu, 15
 Sep 2011 08:39:50 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Thu, 15 Sep 2011 08:39:50 -0700 (PDT)
In-Reply-To: <4E71A0C7.8080602@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181473>

On Thu, Sep 15, 2011 at 1:52 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 9/15/2011 3:59, schrieb Brandon Casey:
>> The "x"-prefixed versions of strdup, malloc, etc. will check whether=
 the
>> allocation was successful and terminate the process otherwise.
>>
>> A few uses of malloc were left alone since they already implemented =
a
>> graceful path of failure or were in a quasi external library like xd=
iff.
>>
>> Signed-off-by: Brandon Casey <drafnel@gmail.com>
>> ---
>> =C2=A0...
>> =C2=A0compat/mingw.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A0compat/qsort.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A0compat/win32/syslog.c | =C2=A0 =C2=A02 +-
>
> There is a danger that the high-level die() routine (which is used by=
 the
> x-wrappers) uses one of the low-level compat/ routines. IOW, in the c=
ase
> of errors, recursion might occur. Therefore, I would prefer that the
> compat/ routines do their own error reporting (preferably via return
> values and errno).

Thanks.  Will do.

-Brandon
