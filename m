Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DE1D1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 18:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfG3SJO (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 14:09:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39618 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfG3SJO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 14:09:14 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so130302017ioh.6
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jU0G11AdupwTbLbjh4TD+k2c2XJASycoPuosMdtKL6E=;
        b=wSSVsTEhOieg9T0Xr/VfPtYKd366TQZT9PX4IAFkAD390gVc5bImavgckY9Jkkg/dG
         zx6GdJ7kagK5wFU6fNNHO6u9+sD55dosfn+FJn6Q07vePVNGNevLWUlBMGEWN/Hb/v/4
         ufHBge7RtyaqB1vAlZ2wyiiWX7L8JbZ9edxjUMdBdmQ5FLMYjB3JPDN6h1ELE2EMdx5d
         km/hlNCNBATdS/WWmsRiSkxf+SaR8ub/vQOSefBnqYqUyZ3Pc91Ozkx/5ftCeYGm/Wx9
         XhGoGV5+FbeE5pSuBVNNf5nD7CwDeyFVCDIHXf+/bJ9dzbfpQw8YiWo6b0l6cNPWvXoJ
         J0bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jU0G11AdupwTbLbjh4TD+k2c2XJASycoPuosMdtKL6E=;
        b=T0tb1TTNffkohiIkX2zRXxL6KjyBh6UTW4ny1yrpNqIMYSzTHddaORjJMbQxgRAEOh
         QzX4cLuPhLnI1bdtgwYarwUVxLRLmWZz+N+xoaYbisZ0kJIj+jKqdtAJVLwmh+Nhuw+y
         f6NPzva4OQy0Cc1uvHsP4UU6C1SipgEAEAxZw5i1Qv4f8ha4/yUc1t5HCdYWtfj45fvv
         979ue2RqQGtoJaq1hPxgjNRnOExB2cfhW37nOg+VlhyKN4bHbPq3OanUw+pV5WmfyDOr
         2QrSZmePLPWA4PurPzD8E6oUJ7XCiFzoUkNoQkFjyjsKAwvfc1fhw7yEep0JcDUEHyDU
         EGmA==
X-Gm-Message-State: APjAAAU9s16xNBPyvpkyLnXk0op2gc9OwRCjumw8UCDAzF23pyr1iebv
        u19eRf/e3EF6wSyGqmPgoVjTZafhyLXtZblHhkzhLw==
X-Google-Smtp-Source: APXvYqw8hCZgPilrfkghk/tEWVjEiQZ+B1lz4mKh+gnZEdwoTAQrnfAcart4o7R66NpXqR5dH9abPohPk8pPx31bi+s=
X-Received: by 2002:a02:c646:: with SMTP id k6mr47339717jan.134.1564510152997;
 Tue, 30 Jul 2019 11:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <049a01d546f9$70be7a30$523b6e90$@nexbridge.com> <xmqq7e7zton5.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e7zton5.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 30 Jul 2019 15:09:01 -0300
Message-ID: <CAHd-oW6unEGZck9jWW9qF7DhXUUxTB=h6Ra8ukLVP+odjs9DrQ@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.23.0-rc0 - Initial test failures on NonStop
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        git <git@vger.kernel.org>, git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio and Randall

On Tue, Jul 30, 2019 at 2:31 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
>
> > t0066: dir-iterator
> >
> > Subtest 4 depends on a non-portable error code. ENOENT is not guaranteed ...
> > Subtest 5 also depends on a non-portable error code. ENOTDIR is not gua...
>
> Yikes, and sorry.  I've become somewhat complacent after relying on
> how good our other reviewers are, pretty much ignored the new code
> in fringes like t/helper/, and failed catch an obvious amateurish
> mistake like this one.
>
> I do not think of a portable way to map an int ENOENT to a string
> "ENOENT", but there are only only two errors test-dir-iterator test
> code cares about, so perhaps a patch like the following may be
> sufficient.

Sorry for that. I totally overlooked the non-portability of error
codes when making the patch. But the proposed fix seems very good. And
having the literal string at the test instead of a number is much more
significant, as well.

> I wonder if a tool like sparse can help us catch a pattern that
> feeds errno to "%d" format.
>
>  t/helper/test-dir-iterator.c | 11 ++++++++++-
>  t/t0066-dir-iterator.sh      |  4 ++--
>  2 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/t/helper/test-dir-iterator.c b/t/helper/test-dir-iterator.c
> index a5b96cb0dc..c7c30664da 100644
> --- a/t/helper/test-dir-iterator.c
> +++ b/t/helper/test-dir-iterator.c
> @@ -4,6 +4,15 @@
>  #include "iterator.h"
>  #include "dir-iterator.h"
>
> +static const char *error_name(int error_number)
> +{
> +       switch (error_number) {
> +       case ENOENT: return "ENOENT";
> +       case ENOTDIR: return "ENOTDIR";
> +       default: return "ESOMETHINGELSE";
> +       }
> +}
> +
>  /*
>   * usage:
>   * tool-test dir-iterator [--follow-symlinks] [--pedantic] directory_path
> @@ -31,7 +40,7 @@ int cmd__dir_iterator(int argc, const char **argv)
>         diter = dir_iterator_begin(path.buf, flags);
>
>         if (!diter) {
> -               printf("dir_iterator_begin failure: %d\n", errno);
> +               printf("dir_iterator_begin failure: %s\n", error_name(errno));
>                 exit(EXIT_FAILURE);
>         }
>
> diff --git a/t/t0066-dir-iterator.sh b/t/t0066-dir-iterator.sh
> index 9354d3f1ed..92910e4e6c 100755
> --- a/t/t0066-dir-iterator.sh
> +++ b/t/t0066-dir-iterator.sh
> @@ -55,13 +55,13 @@ test_expect_success 'dir-iterator should list files in the correct order' '
>  test_expect_success 'begin should fail upon inexistent paths' '
>         test_must_fail test-tool dir-iterator ./inexistent-path \
>                 >actual-inexistent-path-output &&
> -       echo "dir_iterator_begin failure: 2" >expected-inexistent-path-output &&
> +       echo "dir_iterator_begin failure: ENOENT" >expected-inexistent-path-output &&
>         test_cmp expected-inexistent-path-output actual-inexistent-path-output
>  '
>
>  test_expect_success 'begin should fail upon non directory paths' '
>         test_must_fail test-tool dir-iterator ./dir/b >actual-non-dir-output &&
> -       echo "dir_iterator_begin failure: 20" >expected-non-dir-output &&
> +       echo "dir_iterator_begin failure: ENOTDIR" >expected-non-dir-output &&
>         test_cmp expected-non-dir-output actual-non-dir-output
>  '
>
