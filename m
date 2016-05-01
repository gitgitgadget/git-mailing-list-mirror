From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 08/41] builtin/mailsplit.c: use error_errno()
Date: Sun, 1 May 2016 14:31:43 -0400
Message-ID: <CAPig+cSVQMpA6kp5hH0aeMTBfTRW1m3VY-U8t2qjjSk_TnGV=A@mail.gmail.com>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
	<1462101297-8610-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 20:31:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aww9m-0005ib-GF
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 20:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058AbcEASbp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 14:31:45 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34008 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcEASbo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2016 14:31:44 -0400
Received: by mail-io0-f193.google.com with SMTP id d62so21091787iof.1
        for <git@vger.kernel.org>; Sun, 01 May 2016 11:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=UY3BKBTj34xX34YZyTmnX9wcpM5AMKLD4VefVP/zEo0=;
        b=iVMNFzZwl+kqxGLlEF2FJOy2Idd2CFxLu+vynILvE5i2utiveDxS9kPHCYuUz2/fdV
         MfJ26SgmEef1Eplys7eYsUbqT3KAHXlbquekDREY/+mbZuft0g1zehN6pWmPB4hogVRf
         a0Uw6ltHJgMVq9oaf6HGLpcQoMMmNz3Sfnk6zjBzJtdIeiUsxbbn7cWOJ/1J1rVTNJmZ
         mKuk8nsmNWsYf6Ru+A21FOcgQC/DWq/Un6iYGABa5WaKnKXR05lgYuaEMWJ7cuUtTCIL
         +A4gG0ujuKVvUTrinqBP8KDgMuz0aGsBBr9aR0vwdpEUJiLWYAZmT3UG38MusW9GQ669
         xG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=UY3BKBTj34xX34YZyTmnX9wcpM5AMKLD4VefVP/zEo0=;
        b=COTMqtz1LWsFiFzIgs2wJIRJFKFUVfw1uGERbAWoNCBLQ31C/ZZddlEM7SgIWHmPAU
         nX4NBsi0L43Z3S562+Y3pRnK49Ma/bZQZ2P589zXk//YiMGqBn4L7MzN+SBjDLjQYG6c
         Gn8P3CR/Tlkkvxqj65l2rI1Rb7HwSTTwFW4LYmI+qjLSfVu0ZIlVAt20mM76vuiZN43P
         JaRvaWEP5CCUUjYdohhDpc5r+5cD3r5zvTT+l6vgmzNznsji+ilMAXOzLrwjFn5ybVWr
         J0RaBOfMTF4/pIGF2IwPQgl8cJY02T6IiiFnHkcv4ffdSPmUyScpqf+g7b7dOFJsc7gS
         DnRA==
X-Gm-Message-State: AOPr4FVUYiwWlathlP7obZZbpqN9/F58a8YzQ29zEpfM1TMds+v/dQALUTMrO4YHDvDGv15/uO6WLAufg74TXQ==
X-Received: by 10.107.47.37 with SMTP id j37mr34423623ioo.168.1462127503711;
 Sun, 01 May 2016 11:31:43 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 1 May 2016 11:31:43 -0700 (PDT)
In-Reply-To: <1462101297-8610-9-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: Bkl0y09-DCPbpem3Xj521UJKJxk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293202>

On Sun, May 1, 2016 at 7:14 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> @@ -109,7 +109,7 @@ static int populate_maildir_list(struct string_li=
st *list, const char *path)
>                 if ((dir =3D opendir(name)) =3D=3D NULL) {
>                         if (errno =3D=3D ENOENT)
>                                 continue;
> -                       error("cannot opendir %s (%s)", name, strerro=
r(errno));
> +                       error_errno("cannot opendir %s", name);
>                         goto out;
>                 }
> @@ -210,7 +210,7 @@ static int split_mbox(const char *file, const cha=
r *dir, int allow_bare,
>         int file_done =3D 0;
>
>         if (!f) {
> -               error("cannot open mbox %s", file);
> +               error_errno("cannot open mbox %s", file);

Unlike other cases in this patch which already printed
strerror(errno), this one didn't, and the patch upgrades it to do so,
which is valid since errno will not be clobbered between the preceding
fopen() and this error_errno(). I see other patches in the series do
likewise.

The error("cannot read mbox %s"" just below this code doesn't deserve
the same treatment because strbuf_getwholeline() doesn't promise a
meaningful errno. Okay.
