Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EBC820285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbdH3RVR (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:21:17 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34888 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdH3RVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:21:16 -0400
Received: by mail-yw0-f173.google.com with SMTP id s187so34409829ywf.2
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8dSa4adqzZgOuc14LTE6Gb/w1m3TMSavz5c0Waz1dKI=;
        b=BMrItJURKHoVWBgS7+DhUmPxUA6/zG8l9kL1mNIWPYx7Lt+bqLBMgRlQWqper0sTRs
         wi1tqEBunsntr0VBEiGBGLsveyP6Mu33Npz5IVnDuDvRk1m/18TKS+JxA4Efl2sjM2ZP
         XyJ6MNMkONHPW/MHRUSxYvYVZFDTylpGqJa2RZXDdT0cZ5BMNEx1ipH84GkhOH7zaQHH
         d2HtwtCPlXwU4bcbD100g2yisMMUlGutCTWm8gBBaq4iCK6/RcxG4pMIf3WcZiqvhHYS
         dH604Q8d6wi0OzJoLs/HGwjOlMlPBk1CrnWaNkors2K+f8jfFCZ5ROG41h29DzzeHBiW
         PkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8dSa4adqzZgOuc14LTE6Gb/w1m3TMSavz5c0Waz1dKI=;
        b=ByKHuFj62+cCszpyBbrJ+quF5L9xmnJjbgd9mMNDfB31jH4O0sbCFMpjd1wtSlLzSo
         cLWFpR8x16uOrwGwpeiNdVpfb38jYxIzggkomHmtOUJ0BvAaMZgybSTgItV/P4cTxdSq
         p5dZd5pV2ejpgv7h2jqz7MdL3Cq2RnocrEIOIaSOKRW79QSsKNr+fyyidmfl5JV7kfIF
         8ZEdGhAsBW+jIt0mhhUSMrXFLTMohVnOvWm9dbidKGAD5aOzRR4eEYRmdisL55nHwuYU
         Gd6M+f1ylmQqJ3p9DCKlDpGf2Kkv2lmKNxDUf2dwkHBgwJZridiVHbDlzYcsJtzY9iO8
         w3pA==
X-Gm-Message-State: AHYfb5jHIfuEl1T6S9wyX9ub5mCfwuG2xQ8p3IehTJ19hOqjhVzoXyiQ
        vpdWWkvVyLUWL9Vc4iOD6jgmK5c1uXqT
X-Google-Smtp-Source: ADKCNb4I4YXCGBTEutEf6XLu3yl8PrTwTD4Ju4gsskhjFG+y0oe2QErtnsIOMnaC5CmwbFS8Dr1ILoVSz16nlGvwMp4=
X-Received: by 10.129.79.196 with SMTP id d187mr1831951ywb.29.1504113675225;
 Wed, 30 Aug 2017 10:21:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.248.26 with HTTP; Wed, 30 Aug 2017 10:21:14 -0700 (PDT)
In-Reply-To: <caaa44126f18869158872e5473e53478db780ba9.1503993268.git.mhagger@alum.mit.edu>
References: <cover.1503993268.git.mhagger@alum.mit.edu> <caaa44126f18869158872e5473e53478db780ba9.1503993268.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 Aug 2017 10:21:14 -0700
Message-ID: <CAGZ79ka+uaBD_1xk6sx9J83KuP4A_mUWVqtyniNusbDeQiUZyQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] t1404: demonstrate two problems with reference transactions
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 1:20 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Currently, a loose reference is deleted even before locking the
> `packed-refs` file, let alone deleting any packed version of the
> reference. This leads to two problems, demonstrated by two new tests:
>
> * While a reference is being deleted, other processes might see the
>   old, packed value of the reference for a moment before the packed
>   version is deleted. Normally this would be hard to observe, but we
>   can prolong the window by locking the `packed-refs` file externally
>   before running `update-ref`, then unlocking it before `update-ref`'s
>   attempt to acquire the lock times out.
>
> * If the `packed-refs` file is locked so long that `update-ref` fails
>   to lock it, then the reference can be left permanently in the
>   incorrect state described in the previous point.
>
> In a moment, both problems will be fixed.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> The first of the new tests is rather involved; it uses two background
> processes plus a foreground process that polls the value of a
> reference. But despite sensitivity to timing, I think it should be
> robust even in this broken state. Once the functionality being tested
> is fixed, this test should never produce false positives, though
> really bad timing (e.g., if it takes more than a second for
> `update-ref` to get going) could still lead to false negatives.
>
> Each of the new tests takes about a second to run because they
> simulate lock contention.
>
> If anybody has suggestions for better ways to test these things,
> please speak up :-)
>
>  t/t1404-update-ref-errors.sh | 71 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/t/t1404-update-ref-errors.sh b/t/t1404-update-ref-errors.sh
> index c34ece48f5..752f83c377 100755
> --- a/t/t1404-update-ref-errors.sh
> +++ b/t/t1404-update-ref-errors.sh
> @@ -404,4 +404,75 @@ test_expect_success 'broken reference blocks indirect create' '
>         test_cmp expected output.err
>  '
>
> +test_expect_failure 'no bogus intermediate values during delete' '
> +       prefix=refs/slow-transaction &&
> +       # Set up a reference with differing loose and packed versions:
> +       git update-ref $prefix/foo $C &&
> +       git pack-refs --all &&
> +       git update-ref $prefix/foo $D &&
> +       git for-each-ref $prefix >unchanged &&
> +       # Now try to update the reference, but hold the `packed-refs` lock
> +       # for a while to see what happens while the process is blocked:
> +       : >.git/packed-refs.lock &&
> +       test_when_finished "rm -f .git/packed-refs.lock" &&
> +       {
> +               sleep 1 &&
> +               rm -f .git/packed-refs.lock &
> +       } &&
> +       pid1=$! &&
> +       {
> +               # Note: the following command is intentionally run in the
> +               # background. We extend the timeout so that `update-ref`
> +               # tries to acquire the `packed-refs` lock longer than it
> +               # takes the background process above to delete it:
> +               git -c core.packedrefstimeout=2000 update-ref -d $prefix/foo &
> +       } &&
> +       pid2=$! &&
> +       ok=true &&
> +       while kill -0 $pid2 2>/dev/null

    If sig is 0, then no signal is sent, but error checking is still
    performed; this can be used to check for the existence of a
    process ID or process group ID.

So the kill -0 is the idiomatic form of "while $pid2 is still alive"?
ignoring errors due to the dev/null redirection?

And due to the nature of this test we have to have a busy
loop, we cannot rate limit the cpu usage inside the loop
via some shorter sleeps, as ideally we want to observe
the ref at any time.

    In an ideal world this test would instruct the kernel to interrupt
    the executing program (update-ref) at certain events such as
    touching/writing/deleting files and in each interrupt we could
    inspect the file system in a read only fashion.


> +       do
> +               sha1=$(git rev-parse --verify --quiet $prefix/foo || echo undefined) &&
> +               case "$sha1" in
> +               $D)
> +                       # This is OK; it just means that nothing has happened yet.
> +                       : ;;
> +               undefined)
> +                       # This is OK; it means the deletion was successful.
> +                       : ;;
> +               $C)
> +                       # This value should never be seen. Probably the loose
> +                       # reference has been deleted but the packed reference
> +                       # is still there:
> +                       echo "$prefix/foo incorrectly observed to be C" &&
> +                       break
> +                       ;;
> +               *)
> +                       # WTF?
> +                       echo "$prefix/foo unexpected value observed: $sha1" &&
> +                       break
> +                       ;;
> +               esac
> +       done >out &&
> +       wait $pid1 &&
> +       wait $pid2 &&

oh, you use explicit pids here to check each exit code.

> If anybody has suggestions for better ways to test these things,
> please speak up :-)

I don't think I'd have a satisfactory answer to that, as the timing is inherent
to the things we test. In other software projects that are less low level, I
would have suggested to use a time/clock mock, which can be stopped
and then inspection can be performed at defined states.
