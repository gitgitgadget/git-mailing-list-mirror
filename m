From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 5/7] CRLF: unify the "auto" handling
Date: Tue, 29 Mar 2016 15:42:53 -0400
Message-ID: <CAPig+cQiSaz-NdaenrR8H840S9-BVTqs-HARBvQVgcKpKSvw6A@mail.gmail.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459257937-17350-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:43:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzXX-0000jl-Vj
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010AbcC2Tm4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 15:42:56 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33516 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757993AbcC2Tmz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 15:42:55 -0400
Received: by mail-vk0-f66.google.com with SMTP id a62so3710336vkh.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=klbJ0w9F7iKLIJk9sxg55qbHHTD4HTEvx2Yb2AKGUFs=;
        b=VwK/lGAOrbl96fvMrQ1IPNWoGKAiDwif8T757uPWuEChubzVktAuxgcaTRAOhdZHWo
         m2R0qPWCvkxIOY075uFHUZpqQxeJgRWMHqI8lkm7NppvgyTSr3EUU6hJnn0qQXfiVUBk
         vBsUBZfWYhH4q/rR6tT9eBq5FsdcjVMG57Qrm5tNR7kTPYj2JosBeCUGVUWsMtCAyCHB
         7dqw70oxC9eXdx5Oj/ruiPKPMeMfi5TGuRpNTOLrqaKrbQiEmSKJp4CWnEusdHbg6qtN
         GkNyCMI+M0gIDyIBxqaHnJzQs6qBfbGoYUIZYHXFSK5cd3iLPIF8k0qHGDUR2HnamkbG
         6QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=klbJ0w9F7iKLIJk9sxg55qbHHTD4HTEvx2Yb2AKGUFs=;
        b=JuKjDfok7ZYpVfEpPuH9e8VNKpYK3KQSR0/7zIMktIx8YvxLAAnrrzqRXQRynLgQh3
         7pPMbHUTgIvrbCcvjBaONQGPFVc5I/zIxmp/jTrHiN9pIspzN/J/xQB5mqkQA21VaKJO
         wVO7NvYpfS8xmj4Lcz8m4z55JIKGZnKH55LzydFCL3gQQPSD1jTnnaSZPXf/IdNvy0TX
         fXZGfbe+BoQ7s9xxNPrsJ5BXOvBfNmYCR3si7ZasbrR1mWSbvZ+xGE/pvktiZzN+J+Cp
         NRueNR9rD73WgWk9WN+dPWcjQLHpxgwGGADCtlsfLroW4v5V2UzVoUI8jB/01GSxGxgz
         FEig==
X-Gm-Message-State: AD7BkJKgucdzS8lnVft5tuW1TA/YPx37mMtgEUjNPkwUC0IItoQtRR3j7z9+yDvKgPfznNkmLSvFozUHzkbvcA==
X-Received: by 10.31.150.76 with SMTP id y73mr2593268vkd.84.1459280574050;
 Tue, 29 Mar 2016 12:42:54 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 12:42:53 -0700 (PDT)
In-Reply-To: <1459257937-17350-1-git-send-email-tboegi@web.de>
X-Google-Sender-Auth: Z8KqILcTpkfAQJ7b2kKyMy07_SM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290174>

On Tue, Mar 29, 2016 at 9:25 AM,  <tboegi@web.de> wrote:
> Make .gitattributes "* text=3Dauto eol=3Dcrlf" to do the same as
> setting core.autocrlf=3Dtrue and "* text=3Dauto eol=3Dcrlf" the same
> as core.autocrlf=3Dinput
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -389,14 +389,15 @@ file with mixed line endings would be reported =
by the `core.safecrlf`
>  core.autocrlf::
> -       Setting this variable to "true" is almost the same as setting
> -       the `text` attribute to "auto" on all files except that text
> -       files are not guaranteed to be normalized: files that contain
> +       Setting this variable to "true" is the same as setting
> +       the attributes to "auto eol=3Dcrlf" on all files.
> +       Files are not guaranteed to be normalized: files that contain
>         `CRLF` in the repository will not be touched.  Use this
>         setting if you want to have `CRLF` line endings in your
> -       working directory even though the repository does not have
> -       normalized line endings.  This variable can be set to 'input'=
,
> +       working directory and he repository has normalized line endin=
gs.

s/he/the/

> +       This variable can be set to 'input',
>         in which case no output conversion is performed.
> +       Note: older versions of Git behave different.

Would it make sense to spell out what "different" means since new
readers won't know what the old behavior was?

> diff --git a/convert.c b/convert.c
> @@ -370,12 +369,10 @@ static int crlf_to_worktree(const char *path, c=
onst char *src, size_t len,
>         if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_A=
UTO_INPUT || crlf_action =3D=3D CRLF_AUTO_CRLF) {
> -               if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action=
 =3D=3D CRLF_AUTO_CRLF) {
> -                       /* If we have any CR or CRLF line endings, we=
 do not touch it */
> -                       /* This is the new safer autocrlf-handling */
> -                       if (stats.lonecr || stats.crlf )
> -                               return 0;
> -               }
> +               /* If we have any CR or CRLF line endings, we do not =
touch it */
> +               /* This is the new safer autocrlf-handling */

The comment style violation could have been fixed while outdenting,
but perhaps it's not worth the churn.

> +               if (stats.lonecr || stats.crlf )
> +                       return 0;
