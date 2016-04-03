From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 2/5] test-parse-options: print quiet as integer
Date: Sun, 3 Apr 2016 17:30:38 -0400
Message-ID: <CAPig+cQpdr7A7GxKUN3tDs2rQ7z_S5b1WVsk01=BwkCwB2mp0A@mail.gmail.com>
References: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
	<01020153d952be64-9ca893f1-5a7b-4a2c-a0bd-98abf93a17ac-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 23:30:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ampbY-00062a-RJ
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 23:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbcDCVak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 17:30:40 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36726 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbcDCVaj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 17:30:39 -0400
Received: by mail-ig0-f193.google.com with SMTP id kb1so934672igb.3
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=POPCPyB9559s7sSLzAexJeKIQKsn72011ie0KM30C8U=;
        b=xDHmIW79IfQ8I0tNKoEcD89gzMvt0WCRBJVczBprYXW5hXw8v9SYlo/dD9UHGBufzX
         6BF2V+PlbfHzw13FJ5alBnUyIpGDvOsdj/qt1TvUlXtOmkUhUCZL+V4hE4XqaOQ0T+Nb
         mnKvWB3UpeNmhZGwZSnnMENqGNBJdiTR56pUPF9TePHyuSJjjQ9HsyO57rqyGp4iSJTO
         1vzkpw9Ild2olj9/6HAUJmP8u4PhvLb4hp8H65csV/lnuf2B2pb1qqmW9kBUBkssspC7
         NYWc4SoHGC9Iotv4b0QCUen/fvAlDmEHD6k6RO1mBZP9eCtK//MLo1iQbHV01rgnA8NK
         x3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=POPCPyB9559s7sSLzAexJeKIQKsn72011ie0KM30C8U=;
        b=OERoSYpoOi3y3JrfU+hHxEiUmUz+q9gXbWK1dp+yseLKOKouAJsgSiHYBii7lXMnQy
         wX7eY86eSxHa54cN3vhhHAFaLAT/g8h7WNIrzwCv5pR9MT9RG102mr1e+S3GwwMSVDeq
         DA44IT2USKBIGexrJJAePbrCKsGIVPI2EcDGMR2pubIyKzye1uR2CyMppNq22P3jQ5Pk
         KTi0Qg0NbwTZr0Sc+NsNgj3dj3aqtrcPGyagxdDfvnOSIVI7IRxbpu+ELgODFFm3IiN0
         bgJ6Ei7e5hGUm9kbySs2aVsFxUxPGam1BdY3c+8slEEk/ktPWwP6bQ5XFARCK4hV9hsf
         gvtw==
X-Gm-Message-State: AD7BkJJTyT1XZBcQ0PXLZFODve40hGRhu61HIE4bqs5EoEGaINUoO6/BQCGI3/xXbRZtAC+svso/reLnamXVDQ==
X-Received: by 10.50.92.37 with SMTP id cj5mr8488118igb.91.1459719039023; Sun,
 03 Apr 2016 14:30:39 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 14:30:38 -0700 (PDT)
In-Reply-To: <01020153d952be64-9ca893f1-5a7b-4a2c-a0bd-98abf93a17ac-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: uGoSZz9WPOuBHecV3XACGz7LQYs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290655>

On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Current implementation of parse-options.c treats OPT__QUIET() as integer
> and not boolean and thus it is more appropriate to print it as integer
> to avoid confusion.

I can buy this line of reasoning, however, it would be even easier to
sell the change if you cited an existing client (a git command) which
actually respects multiple quiet levels. Are there any?

More importantly, though, this change implies that you should also add
tests to ensure that the quiet level is indeed incremented with each
--quiet, just as "-vv" and "--verbose --verbose" are already tested.
You might be able to include such new tests directly in this patch as
long as the commit message is clear about it, or add them in a
separate patch.

By the way, I don't see any tests to ensure that --no-verbose and
--no-quiet reset those respective values to 0. A separate patch which
adds such tests would be nice (unless such tests already exist and I
merely missed them).

> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  t/t0040-parse-options.sh | 26 +++++++++++++-------------
>  test-parse-options.c     |  2 +-
>  2 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> index c6f205b..302c315 100755
> --- a/t/t0040-parse-options.sh
> +++ b/t/t0040-parse-options.sh
> @@ -64,7 +64,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -164,7 +164,7 @@ timestamp: 0
>  string: 123
>  abbrev: 7
>  verbose: 2
> -quiet: no
> +quiet: 0
>  dry run: yes
>  file: prefix/my.file
>  EOF
> @@ -184,7 +184,7 @@ timestamp: 0
>  string: 321
>  abbrev: 10
>  verbose: 2
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: prefix/fi.le
>  EOF
> @@ -212,7 +212,7 @@ timestamp: 0
>  string: 123
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  arg 00: a1
> @@ -235,7 +235,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -264,7 +264,7 @@ timestamp: 0
>  string: 123
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -303,7 +303,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  arg 00: --quux
> @@ -323,7 +323,7 @@ timestamp: 1
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: yes
> +quiet: 1
>  dry run: no
>  file: (not set)
>  arg 00: foo
> @@ -345,7 +345,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -374,7 +374,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -399,7 +399,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -430,7 +430,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> @@ -449,7 +449,7 @@ timestamp: 0
>  string: (not set)
>  abbrev: 7
>  verbose: 0
> -quiet: no
> +quiet: 0
>  dry run: no
>  file: (not set)
>  EOF
> diff --git a/test-parse-options.c b/test-parse-options.c
> index 2c8c8f1..86afa98 100644
> --- a/test-parse-options.c
> +++ b/test-parse-options.c
> @@ -90,7 +90,7 @@ int main(int argc, char **argv)
>         printf("string: %s\n", string ? string : "(not set)");
>         printf("abbrev: %d\n", abbrev);
>         printf("verbose: %d\n", verbose);
> -       printf("quiet: %s\n", quiet ? "yes" : "no");
> +       printf("quiet: %d\n", quiet);
>         printf("dry run: %s\n", dry_run ? "yes" : "no");
>         printf("file: %s\n", file ? file : "(not set)");
