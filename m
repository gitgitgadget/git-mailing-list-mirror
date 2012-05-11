From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] notes: "add -c" refuses to open an editor with non-blobs
Date: Fri, 11 May 2012 08:11:57 +0700
Message-ID: <CACsJy8AhB2fEtTws3rGDi3tQjVa6UivgAZUuQ+yrbp5r10oJUg@mail.gmail.com>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
 <1336658701-9004-1-git-send-email-pclouds@gmail.com> <1336658701-9004-3-git-send-email-pclouds@gmail.com>
 <4FABDE2C.30406@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 11 03:12:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSePM-0003yC-Sc
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 03:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab2EKBMa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 21:12:30 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43307 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab2EKBM3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2012 21:12:29 -0400
Received: by weyu7 with SMTP id u7so79419wey.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 18:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=arcsR6+EiTFrUsjJdlcfxt+9yOGtWiAlvS/zlZlChck=;
        b=UByU2pNpNJEwpKepuqz/FbDbIwHwobri8UOLUouE7oXw7zwYJsaKRFanQi/B5om9UH
         oKi+uNDvrYIIYl60RF0VIOVxGW5w+j9PQLElndDo941zYs9QgB54XaN0mD9e4360wJL0
         JUWw6yQJsCgZ/O8NmBefV0vxWrvLxxBUch/fXJhIclF5dExXMStHLvnaPFBs9oDky5sz
         DQcQ549nmVCVGkNQS+xcXvLQRtQ5GEJBO0lmHM8d1s3UE2+E9hqKj1Or7iegCUW+7zxS
         x7PQFj9QrDVjZqUX7PTJ/tMxsVd21WFo3cybcgAd485uoh0O6kbKaZiVWp+BVWdrCz7r
         tujA==
Received: by 10.180.107.101 with SMTP id hb5mr2713012wib.7.1336698747860; Thu,
 10 May 2012 18:12:27 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Thu, 10 May 2012 18:11:57 -0700 (PDT)
In-Reply-To: <4FABDE2C.30406@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197648>

On Thu, May 10, 2012 at 10:26 PM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
> Am 5/10/2012 16:04, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
:
>> +test_expect_success 'non-blobs cannot be edited using editor' '
>> + =C2=A0 =C2=A0 EDITOR=3Dcat test_must_fail git notes add -f -c HEAD=
^{tree}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_set_edito=
r cat &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail=
 git notes add -f -c HEAD^{tree}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0)
>
> Ditto in 3/4 and 4/4.
>
> (The problem is not that test_set_editor must be used, but that VAR=3D=
value
> in front of a shell function invocation does not do what you want it =
to do
> unless your shell is buggy.)

thanks. I looked again and t3301 already exports GIT_EDITOR, so we can
skip setting EDITOR again.

>
>> +'
>
> -- Hannes



--=20
Duy
