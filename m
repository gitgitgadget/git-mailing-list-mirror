Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63F751F89D
	for <e@80x24.org>; Fri, 28 Jul 2017 17:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752236AbdG1R73 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 13:59:29 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37916 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdG1R72 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 13:59:28 -0400
Received: by mail-it0-f65.google.com with SMTP id h199so10991052ith.5
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=y8nPiJ1jrJw+iQDpypnQ8aNi1yhLzjrsGASyzVOQ+ys=;
        b=iQ12bs3PUL5aR75YE8vztYLzsqeiWYg/9xFo3llmC3Tb7RUCPUTXiEhE/CNAymXFc6
         eLWspSy+P6AMH/WkiD3Rx/UwEWWvNxq1YeWqwU35oBbq3gDN7OsAn56PoKn6JVcRL9Jt
         Ca+htBztdbW8yZu6W/Qz9dVDiWcYi6+uyqU0u1lJh1IfLHDigyPf6Ei8DJ7RIqSSe+PM
         Adm2aBz09Nzm5e7ZYqdwfCqPMWRyEyDFcs2/j71J3g+lGL1ZSkJHxod/Pg7Wl3E/TM80
         kfEesn6gsJ1scszkOInq2SYTYm3NvpcxnsUiJjOVZRVZA7fozp219FiLrXdB5hfMg5S8
         oeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=y8nPiJ1jrJw+iQDpypnQ8aNi1yhLzjrsGASyzVOQ+ys=;
        b=Ir59OorjSdNo/TANq0AVCVA7iFcjxGKVIHYhE8TxrAFA9WRIUQ6O8wsPmWD4kMua3F
         /zhb/JyRA29Ryzjgedhp/xpQdF/inliZP+PT5o9V/AbTkAyoyDTH2iU6b+Yr+QisF8l7
         PvWuofiHjulWh+7E/VHnQeGpwZKVOgbN153gxv0ay0PQtDGdRGy0riOfqSNEW8itCcMy
         U1WqyZMTjBfpyjJr0R9obruvg9hvWRmP3osSVSASyHWnNqgZ4bTr9P2MbQPX/p0OAU5J
         Gymx11PF2sR2U5mYBcFKf/Py0HZnj20Nar9V+CgYBmYpklstTZJ13UBUFkb+Gb+iy7Td
         6XjA==
X-Gm-Message-State: AIVw110nHc4kN5QP0Gr7TMlfPzI9+gKaeqlpDPNwLOWPN1ldbzDCJdGr
        FffEiqICAakRUAwU24E+EBIKchfm0g==
X-Received: by 10.36.103.69 with SMTP id u66mr10475344itc.46.1501264767902;
 Fri, 28 Jul 2017 10:59:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.131.97 with HTTP; Fri, 28 Jul 2017 10:59:07 -0700 (PDT)
In-Reply-To: <20170728171817.21458-3-sbeller@google.com>
References: <20170728171817.21458-1-sbeller@google.com> <20170728171817.21458-3-sbeller@google.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Fri, 28 Jul 2017 10:59:07 -0700
X-Google-Sender-Auth: wchp3Tq1FU-vcvwz-hcKB0Fg41k
Message-ID: <CAPc5daXgXpwOKB2J7cz7fFYNd3GuRK7fqeROhwouyaCCGU1ToA@mail.gmail.com>
Subject: Re: [PATCH 2/2] t6500: mark tests as SHA1 reliant
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is another one that is better suited for this demonstration patch,
whose sole point is about creating bunch of objects that prefix conflicts
with each other to test the abbreviation machinery.



On Fri, Jul 28, 2017 at 10:18 AM, Stefan Beller <sbeller@google.com> wrote:
> The first test marked relies on hard coded sha1:
>
>         # We need to create two object whose sha1s start with 17
>         # since this is what git gc counts.  As it happens, these
>         # two blobs will do so.
>         test_commit 263 &&
>         test_commit 410 &&
>
> The next two seem to rely on state from the first one, I did not
> investigate.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t6500-gc.sh | 6 +++---
>  t/test-lib.sh | 4 ++++
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index 41b0be575d..3900baa01d 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -43,7 +43,7 @@ test_expect_success 'gc is not aborted due to a stale symref' '
>         )
>  '
>
> -test_expect_success 'auto gc with too many loose objects does not attempt to create bitmaps' '
> +test_expect_success SHA1 'auto gc with too many loose objects does not attempt to create bitmaps' '
>         test_config gc.auto 3 &&
>         test_config gc.autodetach false &&
>         test_config pack.writebitmaps true &&
> @@ -77,7 +77,7 @@ run_and_wait_for_auto_gc () {
>         doesnt_matter=$(git gc --auto 9>&1)
>  }
>
> -test_expect_success 'background auto gc does not run if gc.log is present and recent but does if it is old' '
> +test_expect_success SHA1 'background auto gc does not run if gc.log is present and recent but does if it is old' '
>         test_commit foo &&
>         test_commit bar &&
>         git repack &&
> @@ -95,7 +95,7 @@ test_expect_success 'background auto gc does not run if gc.log is present and re
>         test_line_count = 1 packs
>  '
>
> -test_expect_success 'background auto gc respects lock for all operations' '
> +test_expect_success SHA1 'background auto gc respects lock for all operations' '
>         # make sure we run a background auto-gc
>         test_commit make-pack &&
>         git repack &&
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1b6e53f78a..a5a54c6d4a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1127,6 +1127,10 @@ test_lazy_prereq JGIT '
>         type jgit
>  '
>
> +test_lazy_prereq SHA1 '
> +       false
> +'
> +
>  # SANITY is about "can you correctly predict what the filesystem would
>  # do by only looking at the permission bits of the files and
>  # directories?"  A typical example of !SANITY is running the test
> --
> 2.14.0.rc0.3.g6c2e499285
>
