Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13B0E2035F
	for <e@80x24.org>; Tue,  8 Nov 2016 23:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbcKHXra (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 18:47:30 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33581 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbcKHXra (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 18:47:30 -0500
Received: by mail-yw0-f196.google.com with SMTP id s68so7601314ywg.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 15:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=naQueziCHqLm9YeT+xuI5stwpuvMppOxbCnKhxZAriM=;
        b=rPTncJv6Gy5hcQFgVaQpKZfO8WMqoYvuNt+lReAn0TA0eJoQiDatXet6f1GuGF1rl1
         VQUtdoDmxL+cd7+G+jfHWc+t/4j6nU+ffD/0XSNNf6pNbI7X+JzwznZZ3lqpA1ZiE8v5
         C1RUpMKdOYYbVZPdJLIRp9sousnV0Y2YRCPS8kcRHHdJ2z219gsahwyjaIZqMurEC5J/
         jDc+iT+SzTG/2GB6237ScY87UII5pB9GosuMIMW7kGVgVdFxVgZolWotrHssxTNo9keB
         4mDFZTI5BUsaR6Q8HBIynmwyKaPlbXpRSSGOHESS2z4BZoyT2Mudoyxy00Mxo6pvL+dy
         ou5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=naQueziCHqLm9YeT+xuI5stwpuvMppOxbCnKhxZAriM=;
        b=J5pprr+9vX4LpXzbyXn1bSZIwhKA/mZ62/Po0EKBul0IAW47MFOUMUgrfiFtKT+6SE
         k3zuAPIe1uLFQRo+xqh+OCHQ4aTQSG3S5+XxhYLbv82LhEUIIqqUrptydcFxfm5gOgtz
         1YlnkGZ6MABywiw1hb3GyE3mCkwmxr0FxpTihvdxhW/OoHkrYdaFA+K1ItLGDHGgjpTi
         68IprsiBdsAjJSPro/YmYY8ebbMM1AmUvziT4XhTnL6WjH/HsAXgwiH9gSl1xcVBUDMn
         e+eohBGwuJQvendXycTYjc8p+WyjZfqDuWdU9fMPYbZ4Rkj+ndC8Fh/bZAQhldwKoSgC
         bc0g==
X-Gm-Message-State: ABUngvdZQKpycUYY1Uyka9xU0vieNkJGXdsE6FPaB4bag6yhJbvnQYlSOk26OLLSLRclIn5lq+qwEwB9w1XybQ==
X-Received: by 10.129.102.132 with SMTP id a126mr14088091ywc.160.1478648824908;
 Tue, 08 Nov 2016 15:47:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 15:46:44 -0800 (PST)
In-Reply-To: <20161108201211.25213-10-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-10-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 15:46:44 -0800
Message-ID: <CA+P7+xoRgHiCxMs1+AT8jHg-mRS8ap3KyKV_jCaoRa_ikaBH4Q@mail.gmail.com>
Subject: Re: [PATCH v7 09/17] ref-filter: make "%(symref)" atom work with the
 ':short' modifier
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 12:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> The "%(symref)" atom doesn't work when used with the ':short' modifier
> because we strictly match only 'symref' for setting the 'need_symref'
> indicator. Fix this by using comparing with valid_atom rather than used_atom.
>

Makes sense.

> Add tests for %(symref) and %(symref:short) while we're here.
>

Nice to see more tests around this.

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  ref-filter.c            |  2 +-
>  t/t6300-for-each-ref.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 4d7e414..5666814 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -338,7 +338,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
>                 valid_atom[i].parser(&used_atom[at], arg);
>         if (*atom == '*')
>                 need_tagged = 1;
> -       if (!strcmp(used_atom[at].name, "symref"))
> +       if (!strcmp(valid_atom[i].name, "symref"))
>                 need_symref = 1;
>         return at;
>  }
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 2c5f177..b06ea1c 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -38,6 +38,7 @@ test_atom() {
>         case "$1" in
>                 head) ref=refs/heads/master ;;
>                  tag) ref=refs/tags/testtag ;;
> +                sym) ref=refs/heads/sym ;;
>                    *) ref=$1 ;;
>         esac
>         printf '%s\n' "$3" >expected
> @@ -565,4 +566,27 @@ test_expect_success 'Verify sort with multiple keys' '
>                 refs/tags/bogo refs/tags/master > actual &&
>         test_cmp expected actual
>  '
> +
> +test_expect_success 'Add symbolic ref for the following tests' '
> +       git symbolic-ref refs/heads/sym refs/heads/master
> +'
> +
> +cat >expected <<EOF
> +refs/heads/master
> +EOF
> +
> +test_expect_success 'Verify usage of %(symref) atom' '
> +       git for-each-ref --format="%(symref)" refs/heads/sym > actual &&
> +       test_cmp expected actual
> +'
> +
> +cat >expected <<EOF
> +heads/master
> +EOF
> +
> +test_expect_success 'Verify usage of %(symref:short) atom' '
> +       git for-each-ref --format="%(symref:short)" refs/heads/sym > actual &&
> +       test_cmp expected actual
> +'
> +
>  test_done
> --
> 2.10.2
>
