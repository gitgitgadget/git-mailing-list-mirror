Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E60E5203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbcGVTaU (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:30:20 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38598 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbcGVTaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:30:18 -0400
Received: by mail-it0-f52.google.com with SMTP id j124so56262144ith.1
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 12:30:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EYl0LE8aHcF0AzN8o3tOXw6xTuzzmqaVnR7jlv45Ztc=;
        b=DLdbsqHAuXGnybNZr1+YP+KS3zBHjfDsYLN9wu91mX4mX8lt+GbTdHz6CPWu8+Iigw
         y1RtfinVE3UhmVe3rx4cq3RmXpOpg7SGnoKiJ1idA62xVJblt8iWhLI9FguD6Whv9QuB
         wi+HA4PWRDa6Ue0cPQd2ML6LQ+8b0CkAZmRVWbKqfjO6X4HRKPYCPXOV4pOcDcM5Xman
         NBYfX6n4/pUSniOU9Hy9GeoFgGeSwalGrHYXQ87Wbx/QeDGXGMwsQTijs0CZYBdwvZak
         pEpUwpDiWMlje59ZhITaRXHqzfJdbNpesRTg3f6nj+EYaAd37K8+r7PflrB2DhLZyMDY
         Dyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EYl0LE8aHcF0AzN8o3tOXw6xTuzzmqaVnR7jlv45Ztc=;
        b=hzKrPspRLzxjvDoS9XGXNzaPIjN2rwvBsTAlAjNG5fuCWYQdg5iReiF7qXkZeF4SCh
         QY9MjsEoQmLQVGW3/Hp04sa0A9O3cuwEjVSzIDYTwCFvdIIrXVfqUm9vU/D3zk6ah+en
         73j1fOGqUnArw12BqObeHX0/QpR5GgI8dDTB3UcWnupcpUDiQdg7DgVFM1PEv+VwW9ME
         Z+VQhRWKoaEL2Xx9ZW2wPndn8Q22080ylXQXIK6N0ClUWM9iL9DyLITHDywOOKyV+PpW
         VEjKmwnhx9lgT1l2blEcbxKZNSB78zxmnMRi0tbnqv1o12lfrnFNghefcvjjkBLVuWOp
         aEyg==
X-Gm-Message-State: AEkoouvyPYVO1Ozk1NMLVh+fALn0tq1tn0g5FJtuv5m1J0BagjlGSx/ldgygd5fbydxr/214RhOM+89DLh6nVsGS
X-Received: by 10.36.127.7 with SMTP id r7mr6183762itc.49.1469215817473; Fri,
 22 Jul 2016 12:30:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 22 Jul 2016 12:30:17 -0700 (PDT)
In-Reply-To: <4d40da99-2f66-a380-840f-1828dc5b9324@kdbg.org>
References: <8c0e116b-b604-ee83-197a-538eedf6e0ea@kdbg.org> <4d40da99-2f66-a380-840f-1828dc5b9324@kdbg.org>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 22 Jul 2016 12:30:17 -0700
Message-ID: <CAGZ79kbiVwyyTZLxQP+ioLBoC6r8dcJV4SdDUL_bn58bFUbsWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule-helper: fix indexing in clone retry error
 reporting path
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 22, 2016 at 12:15 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> 'git submodule--helper update-clone' has logic to retry failed clones
> a second time. For this purpose, there is a list of submodules to clone,
> and a second list that is filled with the submodules to retry. Within
> these lists, the submodules are identified by an index as if both lists
> were just appended.
>
> This works nicely except when the second clone attempt fails as well. To
> report an error, the identifying index must be adjusted by an offset so
> that it can be used as an index into the second list. However, the
> calculation uses the logical total length of the lists so that the result
> always points one past the end of the second list.
>
> Pick the correct index.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  builtin/submodule--helper.c | 2 +-
>  t/t5815-submodule-protos.sh | 4 ++--
>  t/t7400-submodule-basic.sh  | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b22352b..6f6d67a 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -795,7 +795,7 @@ static int update_clone_task_finished(int result,
>                 suc->failed_clones[suc->failed_clones_nr++] = ce;
>                 return 0;
>         } else {
> -               idx = suc->current - suc->list.nr;
> +               idx -= suc->list.nr;

The fix is the same as in
http://thread.gmane.org/gmane.comp.version-control.git/299995
There we have an additional check, which may make sense to use here as well,
specifically when having the patch 1 which propagates the exit code.

The approach to tests is different though. I like yours better than mine,
as it doesn't add more tests, but strengthens existing tests.

>                 ce  = suc->failed_clones[idx];
>                 strbuf_addf(err, _("Failed to clone '%s' a second time, aborting"),
>                             ce->name);
> diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
> index 112cf40..06f55a1 100755
> --- a/t/t5815-submodule-protos.sh
> +++ b/t/t5815-submodule-protos.sh
> @@ -18,7 +18,7 @@ test_expect_success 'setup repository with submodules' '
>         git commit -m "add submodules"
>  '
>
> -test_expect_failure 'clone with recurse-submodules fails' '
> +test_expect_success 'clone with recurse-submodules fails' '
>         test_must_fail git clone --recurse-submodules . dst
>  '
>
> @@ -32,7 +32,7 @@ test_expect_success 'update of ssh allowed' '
>         git -C dst submodule update ssh-module
>  '
>
> -test_expect_failure 'update of ext not allowed' '
> +test_expect_success 'update of ext not allowed' '
>         test_must_fail git -C dst submodule update ext-module
>  '
>
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 7c8b90b..b77cce8 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -352,7 +352,7 @@ test_expect_success 'sync should fail with unknown submodule' '
>         test_failure_with_unknown_submodule sync
>  '
>
> -test_expect_failure 'update should fail when path is used by a file' '
> +test_expect_success 'update should fail when path is used by a file' '
>         echo hello >expect &&
>
>         echo "hello" >init &&
> @@ -361,7 +361,7 @@ test_expect_failure 'update should fail when path is used by a file' '
>         test_cmp expect init
>  '
>
> -test_expect_failure 'update should fail when path is used by a nonempty directory' '
> +test_expect_success 'update should fail when path is used by a nonempty directory' '
>         echo hello >expect &&
>
>         rm -fr init &&
> --
> 2.9.0.443.ga8520ad
>
