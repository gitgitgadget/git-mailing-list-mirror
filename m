Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB1520899
	for <e@80x24.org>; Tue, 15 Aug 2017 00:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752836AbdHOAql (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 20:46:41 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36579 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbdHOAqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 20:46:40 -0400
Received: by mail-pg0-f54.google.com with SMTP id i12so6502482pgr.3
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 17:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XN+PlKGzuYOzHrdMUPnwnf2SR4OpIC0QpSGET4LB/Vg=;
        b=dCctpic7G+Bh6n5KXfb54vk/viM5QKRNa2M1qvtXsm/Z9mjDtjZCfGRgQi11Ibehsn
         m7Kn/og7gRc9QHW2iHpewa6g9IRqHpF4yE4MvrdcJD2NOj9i1H0Di6+fetjXRxuJqOrG
         YqxoaW/gIXsptiCQAXMDD7xG5iZIa4lqG4lXectYTep40rRK/lsNxabXR26Kzk0DSjUt
         bh0+HcmwhuLnEsDYY9sCDNUgT3nOqP+Wj6+ALeAEEaudxFKGfWJFGqwiYTESt++9vvpg
         MIs9g2XinJCcYpwniSkryiDrVfBO7DiD2T992dvoZopDQBQhyt7OS8eEqEzjmylTCu5C
         /Mqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XN+PlKGzuYOzHrdMUPnwnf2SR4OpIC0QpSGET4LB/Vg=;
        b=cqHzY1oLwul/g/43AyGKw0GmxJ8a+ENtvYvAbNxK0epy3egCG/XQOQd0bo8BGBkHR9
         A0tpzwkV7rQ3suWi7W31wtX3w2B4BNAt51q99HlOaFePUWBOOOBjFYIbgxl81LCXMvk9
         sOy3w6ZTWWw2V/o+vGn1ZXn7gN9sAcQnX1llmC10t9N/DUR8wZ+901fZlv+jTHL12loA
         EU2E6NNXjetjmJucW7Vgg6vI8IXIk+068rUPMFHjAlpXsLs4m8lzffPPaEdgkHEHiEcH
         Okf6ymUqrQaX57HvCsICtaKYmQsSfYgUmt4q3/JN7AWggvDtVnROEYQp4svUVuZTUi2k
         kdJA==
X-Gm-Message-State: AHYfb5jwVrm8iVzAMJbgFFo5Z9XxjaR7YhozCpgjJtiwMOGLCg6lrtXO
        uXdBCYfyt1TWzw==
X-Received: by 10.84.167.2 with SMTP id c2mr29965741plb.369.1502757999736;
        Mon, 14 Aug 2017 17:46:39 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5181:69ef:a50:cd47])
        by smtp.gmail.com with ESMTPSA id e198sm14859559pfh.36.2017.08.14.17.46.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 17:46:38 -0700 (PDT)
Date:   Mon, 14 Aug 2017 17:46:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Benoit Lecocq <benoit@openbsd.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1002: stop using sum(1)
Message-ID: <20170815004546.GA78174@aiede.mtv.corp.google.com>
References: <9f6e13d3-07ff-1eaa-9453-05ca26a3c1ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f6e13d3-07ff-1eaa-9453-05ca26a3c1ff@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

René Scharfe wrote:

> sum(1) is a command for calculating checksums of the contents of files.
> It was part of early editions of Unix ("Research Unix", 1972/1973, [1]).
> cksum(1) appeared in 4.4BSD (1993) as a replacement [2], and became part
> of POSIX.1-2008 [3].  OpenBSD 5.6 (2014) removed sum(1).
>
> We only use sum(1) in t1002 to check for changes in three files.  On
> MinGW we use md5sum(1) instead.  We could switch to the standard command
> cksum(1) for all platforms; MinGW comes with GNU coreutils now, which
> provides sum(1), cksum(1) and md5sum(1).  Use our standard method for
> checking for file changes instead: test_cmp.
>
> It's more convenient because it shows differences nicely, it's faster on
> MinGW because we have a special implementation there based only on
> shell-internal commands, it's simpler as it allows us to avoid stripping
> out unnecessary entries from the checksum file using grep(1), and it's
> more consistent with the rest of the test suite.
>
> We already compare changed files with their expected new contents using
> diff(1), so we don't need to check with "test_must_fail test_cmp" if
> they differ from their original state.  A later patch could convert the
> direct diff(1) calls to test_cmp as well.
>
> With all sum(1) calls gone, remove the MinGW-specific implementation
> from test-lib.sh as well.
>
> [1] http://minnie.tuhs.org/cgi-bin/utree.pl?file=V3/man/man1/sum.1
> [2] http://minnie.tuhs.org/cgi-bin/utree.pl?file=4.4BSD/usr/share/man/cat1/cksum.0
> [3] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cksum.html
> ---
>  t/t1002-read-tree-m-u-2way.sh | 67 ++++++++++++++++++++++---------------------
>  t/test-lib.sh                 |  3 --
>  2 files changed, 35 insertions(+), 35 deletions(-)

Nicely analyzed.  May we forge your sign-off?

[...]
> --- a/t/t1002-read-tree-m-u-2way.sh
> +++ b/t/t1002-read-tree-m-u-2way.sh
[...]
> @@ -132,8 +138,8 @@ test_expect_success \
>       git ls-files --stage >7.out &&
>       test_cmp M.out 7.out &&
>       check_cache_at frotz dirty &&
> -     sum bozbar frotz nitfol >actual7.sum &&
> -     if cmp M.sum actual7.sum; then false; else :; fi &&
> +     test_cmp bozbar.M bozbar &&
> +     test_cmp nitfol.M nitfol &&

This one is strange.  What is that '! cmp' trying to check for?
Does the replacement capture the same thing?

E.g., does it need a '! test_cmp frotz.M frotz &&' line?

I haven't looked at the context closely --- another option could be a
note in the commit message about how that '! cmp' line was not testing
anything useful in the first place.

[...]
> @@ -209,11 +217,8 @@ test_expect_success \
>       git ls-files --stage >14.out &&
>       test_must_fail git diff -U0 --no-index M.out 14.out >14diff.out &&
>       compare_change 14diff.out expected &&
> -     sum bozbar frotz >actual14.sum &&
> -     grep -v nitfol M.sum > expected14.sum &&
> -     cmp expected14.sum actual14.sum &&
> -     sum bozbar frotz nitfol >actual14a.sum &&
> -     if cmp M.sum actual14a.sum; then false; else :; fi &&
> +     test_cmp bozbar.M bozbar &&
> +     test_cmp frotz.M frotz &&

Same question here: the preimage seems to be a stricter test than the
postimage.

[...]
> @@ -231,11 +236,8 @@ test_expect_success \
>       test_must_fail git diff -U0 --no-index M.out 15.out >15diff.out &&
>       compare_change 15diff.out expected &&
>       check_cache_at nitfol dirty &&
> -     sum bozbar frotz >actual15.sum &&
> -     grep -v nitfol M.sum > expected15.sum &&
> -     cmp expected15.sum actual15.sum &&
> -     sum bozbar frotz nitfol >actual15a.sum &&
> -     if cmp M.sum actual15a.sum; then false; else :; fi &&
> +     test_cmp bozbar.M bozbar &&
> +     test_cmp frotz.M frotz &&

Likewise.

[...]
> @@ -281,11 +285,8 @@ test_expect_success \
>       git ls-files --stage >19.out &&
>       test_cmp M.out 19.out &&
>       check_cache_at bozbar dirty &&
> -     sum frotz nitfol >actual19.sum &&
> -     grep -v bozbar  M.sum > expected19.sum &&
> -     cmp expected19.sum actual19.sum &&
> -     sum bozbar frotz nitfol >actual19a.sum &&
> -     if cmp M.sum actual19a.sum; then false; else :; fi &&
> +     test_cmp frotz.M frotz &&
> +     test_cmp nitfol.M nitfol &&

Likewise.

The rest looks good.

Thanks,
Jonathan
