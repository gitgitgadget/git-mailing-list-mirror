From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 4/6] verify-tag: add sha1 argument to verify_tag()
Date: Mon, 18 Apr 2016 13:41:04 -0400
Message-ID: <CAPig+cSGR-AZPzPRenm8RkOa7XpUOqMAgUw_8p-OUL=qP0Hy6w@mail.gmail.com>
References: <1460932021-27633-1-git-send-email-santiago@nyu.edu>
	<1460932021-27633-5-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Mon Apr 18 19:41:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asDAg-0004ql-4F
	for gcvg-git-2@plane.gmane.org; Mon, 18 Apr 2016 19:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbcDRRlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2016 13:41:08 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33783 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbcDRRlF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2016 13:41:05 -0400
Received: by mail-io0-f194.google.com with SMTP id g185so24373930ioa.0
        for <git@vger.kernel.org>; Mon, 18 Apr 2016 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=jLyXa1TgkIDDCx5P3ZY0LK/sEk08WUnv4pBvIZUAVA4=;
        b=PoNx7Ig0MXPVBnxXVWIxCYiJIqH2nNJpubD+E9lHRL+1FMWR/nnI29+sUAYS6PbBFO
         T8SHxO0IysrxMjAupVrQc+3CmmByFAcuvxna0zD0hi0xqx5PDVtYeuzrCMNaeo5EXRVL
         5W5a0TA5vHI9DABmrfEKxHg+cEbUG1MxEUODv52VHPAt33Lp5duOO81niWMn2pPGUMDY
         cMPt2r019CctXJZ0z+YYmx9jjpy4W/gdi7I1dcE5yW23Qid2frqgW1PFF0P/Ds9cemMb
         tRX/beseRI8bCRT8HzuTVbz60UMy9SXko8IfUUhsRWHarXtuYVhCzrUFJTQtgCDdgFlo
         7I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jLyXa1TgkIDDCx5P3ZY0LK/sEk08WUnv4pBvIZUAVA4=;
        b=M8UMUjWRDjxIdKSGUVTbJZl3BX4yEOgMMeQdIeFbRqpr0VU7dEX4osl6OgtyCRWkFh
         TGA1Ceevf0FfDaQHsTxPBtmR20ibSQ729ZXhujeHOu9S7F/Il8pZF1VuJL+5djHcsRSI
         2c/ANrJfLI6i8V5VvP5x6KDzAH0fjVHRBEh/HtxXIk8CUGzHD14TMiBTjWm5JHXz1D4e
         SJBxdrwzu+beEGo5dLjRv9nNXOFrey+j821tPALbDcgvFmFkR/OaqS+K+Hz0LdeUwUfh
         2+sw+DBoTnR05UOXG1Q2tK3HY9mz+6NLqNc5N+PsgF951IM1xiUucnKzm70csF2sjXoe
         +S2Q==
X-Gm-Message-State: AOPr4FXkpNRyNrJlZDn9gGNeylWJB5GQUENSEmotjQhvh7jTkVYWoxzc/notM9vEN0MnRGnkgdkJ1DiGuCUMIQ==
X-Received: by 10.107.47.10 with SMTP id j10mr22427833ioo.168.1461001264369;
 Mon, 18 Apr 2016 10:41:04 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 18 Apr 2016 10:41:04 -0700 (PDT)
In-Reply-To: <1460932021-27633-5-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: Ni8MxXcNIO5Z32kdz2NPfNtMbps
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291813>

On Sun, Apr 17, 2016 at 6:26 PM,  <santiago@nyu.edu> wrote:
> verify-tag: add sha1 argument to verify_tag()

Mentioned previously[1]: This subject is talking about low level
details of the change rather than giving a high-level overview. A
suggested replacement[1] would be:

    verify-tag: prepare verify_tag() for libification

> The current interface of verify_tag() resolves reference names to SHA1,
> which might be redundant as future callers may resolve the refname to
> SHA1 beforehand.

There is no mention here that the plan is to libify verify_tag() and
"might be redundant" is a somewhat weak way to argue in favor of this
change. The commit messages proposed in the previous review[1] was
more explicit:

    verify_tag() accepts a tag name which it resolves to a SHA1
    before verification, however, the plan is to make this
    functionality public and it is possible that future callers will
    already have a SHA1 in hand. Since it would be wasteful for them
    to supply a tag name only to have it resolved again, change
    verify_tag() to accept a tag SHA1 rather than a name.

> Add a SHA1 parameter to use instead of the name parameter. We also
> replace the name argument to report_name and use it for error reporting
> only.

The patch itself looks okay, though see a few nits below (which may
not be worth a re-roll).

[1]: http://article.gmane.org/gmane.comp.version-control.git/290829

> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> @@ -80,6 +79,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  {
>         int i = 1, verbose = 0, had_error = 0;
>         unsigned flags = 0;
> +       unsigned char sha1[20];
> +       const char *name;

Nit: These could have been declared in the scope of the while-loop
(below) since you've added braces to it.

> @@ -96,8 +97,14 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
> -       while (i < argc)
> -               if (verify_tag(argv[i++], flags))
> +       while (i < argc) {
> +               name = argv[i++];
> +               if (get_sha1(name, sha1)) {
> +                       error("tag '%s' not found.", name);
>                         had_error = 1;

These lines could be combined:

    had_error = !!error("tag '%s' not found.", name);

which would allow you to drop the braces.

> +               }
> +               else if (verify_tag(sha1, name, flags))
> +                       had_error = 1;

Style: cuddle '}' and else:

    } else

> +       }
>         return had_error;
>  }
