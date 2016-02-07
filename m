From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 04/11] test-regex: expose full regcomp() to the command line
Date: Sun, 7 Feb 2016 03:44:29 -0500
Message-ID: <CAPig+cQ2yFvM_YeeN+OObo+jZaxtiaLi+URE3USB2v4fUyC9tw@mail.gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
	<1454724190-14063-1-git-send-email-pclouds@gmail.com>
	<1454724190-14063-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 09:44:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSKxP-0000Hv-1H
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 09:44:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbcBGIoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2016 03:44:30 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:32789 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcBGIoa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 03:44:30 -0500
Received: by mail-vk0-f66.google.com with SMTP id c3so1664419vkb.0
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 00:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ZhcN7U9h37zrg2YtMlva7WdFSHYM2id3Cvb7qbXpymo=;
        b=VoqBFFbOVrSsocaAcOKlVigme73OExBabsvHF2XFEhDAcOfKT4mncoKMyS6rI4OvCY
         6syQR4R1WpDhaAvh1Qu963B/yHJ/qrs7L+hWxekjL+aETCvQVsC/y/gWuOP7iO7NjZGf
         lMYtjlBhYKTLnSWkuVbu1aeTLpvNWjfSOWsekJsj6YSfDymUU0TBr1X4kfpBP3gUW97s
         47pNIbA7cS+mUhsdPdhAoA+eVmhxePzaZc+C6Mf6FIHaowqt74X2mGQ7bvNnpk9CiL8b
         8i6I5tsVF6KsPrpp/l6nqK7GYCODRkGQhO9xSgmelTJoBssaTbYWaaxTSwcQvk0d96II
         3bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZhcN7U9h37zrg2YtMlva7WdFSHYM2id3Cvb7qbXpymo=;
        b=kl5aE8Zjsk9zzmbWGv8LX49EE/bk9RzXQqNkWx7WrRtQmokUXGdzRPONU5jhJl3DVW
         qMTt+B6pdtvFVJ2pehKnX3nlZkvWa67g6W+9u8cO63lsBSP2lxVyhdm0n8wWq3Lberb2
         KtNem7r/IZWe/b5BuOOti+kvkTb2LWm5J7Gp2wbs8ADNRfR2xYOh3R0jBETUwW0tdGhG
         YijU0WYp9rpyDQPe7QRHfvrgF7xytKqUVaADMYRTXkuKlJV8epq9R1e5GpancF3bufPk
         L1Ap3QXXJOt0zI44VxTz6Qhp2gy+If+1WHf6aPyiNwL5wFWDfBQodm4BtwPRVQ2G8NWj
         B57Q==
X-Gm-Message-State: AG10YORHs9ZB88QXvRvLa7HbG9T8H8FYqjQ/KdiFidtm186kqaeGrHpFQA5uwX1Yhml+dTBesuLPCT5hDBt7mA==
X-Received: by 10.31.47.135 with SMTP id v129mr15691544vkv.115.1454834669496;
 Sun, 07 Feb 2016 00:44:29 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 7 Feb 2016 00:44:29 -0800 (PST)
In-Reply-To: <1454724190-14063-5-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: UJZoU_1p8VGJ6THrvielHVkAq4Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285718>

On Fri, Feb 5, 2016 at 9:03 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> diff --git a/test-regex.c b/test-regex.c
> @@ -21,8 +38,38 @@ static int test_regex_bug(void)
>  int main(int argc, char **argv)
>  {
> +       const char *pat;
> +       const char *str;
> +       int flags =3D 0;
> +       regex_t r;
> +       regmatch_t m[1];
> +
>         if (argc =3D=3D 2 && !strcmp(argv[1], "--bug"))
>                 return test_regex_bug();
> -       else
> -               die("must be used with --bug");
> +       else if (argc < 3)
> +               die("usage: test-regex --bug\n"
> +                   "       test-regex <pattern> <string> [<options>]=
");

This is just a test program, so it probably isn't that important, but
die() automatically prepends "fatal: " which means the alignment of
the second line will be wrong. Perhaps you want to use usage() instead
which automatically prepends "usage: " (and drop the literal "usage: "
from the above string).

> +       argv++;
> +       pat =3D *argv++;
> +       str =3D *argv++;
> +       while (*argv) {
> +               struct reg_flag *rf;
> +               for (rf =3D reg_flags; rf->name; rf++)
> +                       if (!strcmp(*argv, rf->name)) {
> +                               flags |=3D rf->flag;
> +                               break;
> +                       }
> +               if (!rf->name)
> +                       die("do not recognize %s", *argv);
> +               argv++;
> +       }
> +       git_setup_gettext();
> +
> +       if (regcomp(&r, pat, flags))
> +               die("failed regcomp() for pattern '%s'", pat);
> +       if (regexec(&r, str, 1, m, 0))
> +               return 1;
> +
> +       return 0;
>  }

This version is much easier to read without the "bug" special case
spread throughout the code. Thanks.
