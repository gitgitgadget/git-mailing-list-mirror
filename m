Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A6E1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 21:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeILCLQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 22:11:16 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:43848 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeILCLP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 22:11:15 -0400
Received: by mail-yb1-f195.google.com with SMTP id k5-v6so9924738ybo.10
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8x9bhxDtkSvVwk9k7TKYsH9r8tpsQaU7vJtZHqGDA8=;
        b=oxhwP6Q4NADQCLw5qRAdDAeLc3Y/uD1jtyIeLwamKyQzBdGVBMNWXlqhAiqj7/A0Br
         RHs7V5FM8AeHM10LvyRR8WR0eqb9s6MukpGcMvoMBrohPbnAdBBaH+05I7NpGzwnl4Us
         heW2LCNI7xPs5FONg0/ZpVJU1E3WQOwnvrhfyCjKeW+OQMcB/lX4mvSOTsS4sV+MGMQ5
         hkWnpKgEoXsUzy+oTwIU1+YO5KkLCVCnJD49oI2QOMYcGjj1Yk4DtsyhDBH430qocqH2
         cl4oreg4YO4JDSNNTTKE06Vmk2DxY3xMwXQuptik44cGl8lSLx6CXimk/Ro17FCggbGy
         ZM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8x9bhxDtkSvVwk9k7TKYsH9r8tpsQaU7vJtZHqGDA8=;
        b=VoOJAUgOVMrCC245HX8ERDr2uuxl0IqFwj9UigVDP4uXcoSeOS4Y3PtKGc0v6sdoYZ
         CNqzNnUAHm9Igglyq+VqJMDzm49XDhuEDP1eubXkyHkLhvGU5gSGf2G39i7g0DOErHCj
         8RyZq7iYELMYym53/8icrmFI/qD75TYWgvuB52fQbBIOx7IjLr5i7WsLcA+c2XqEK6v6
         kPpX5lVNmfIHptXloj/EUAsNqal2ttz+c/PcdgacGfs6h10g1I2QVRt8rUntv8hzxUHz
         7Tblv+iQHuMs716BFjJEErLdEW2+G8AQUPC/vGaGjVxz1AVLFvgeBh1HKFFmqKHGKUCl
         TIcw==
X-Gm-Message-State: APzg51CbG/b87fpAOwLSrtuIYhHSenZnPVeuyZ73usmOAVbq/lsh8Adc
        O5Vwuy/UVjPCZRPdTn2xPOfAj3Fw2bIs6V3z0l3++w==
X-Google-Smtp-Source: ANB0VdbLPCPKQUf0wWTStkAsNesnafWQYIG3/OtwNpGtoLhU3yOqlXdIUISos6Ivm+uTkBf4R4MVJd4AK9mHkzqC8q8=
X-Received: by 2002:a81:5710:: with SMTP id l16-v6mr13466782ywb.3.1536700206974;
 Tue, 11 Sep 2018 14:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.37.git.gitgitgadget@gmail.com> <58347a962438852be0d37c3957686ea5000b2dbd.1536697263.git.gitgitgadget@gmail.com>
In-Reply-To: <58347a962438852be0d37c3957686ea5000b2dbd.1536697263.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 11 Sep 2018 14:09:55 -0700
Message-ID: <CAGZ79kYZWRS3p+dP-3AtDSs0JqCCOd1rycugRZawpbkB0ydw3A@mail.gmail.com>
Subject: Re: [PATCH 1/1] t3206-range-diff.sh: cover single-patch case
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 1:21 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The commit 40ce4160 "format-patch: allow --range-diff to apply to
> a lone-patch" added the ability to see a range-diff as commentary
> after the commit message of a single patch series (i.e. [PATCH]
> instead of [PATCH X/N]). However, this functionality was not
> covered by a test case.
>
> Add a simple test case that checks that a range-diff is written as
> commentary to the patch.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t3206-range-diff.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 3d7a2d8a4d..05ef3263d2 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -154,4 +154,9 @@ do
>         '
>  done
>
> +test_expect_success 'format-patch --range-diff as commentary' '
> +       git format-patch --stdout --range-diff=HEAD~1 HEAD~1 >actual &&

This is an interesting use of range-diff, as it basically tells us
"Range-diff: This is a new patch", but it works to make sure
there is a range diff section. (I shortly wondered if we would
ever omit the range diff for "obvious" cases or word it differently)

> +       grep -A 1 -e "\-\-\-" actual | grep "Range-diff:"

So the first grep finds the three dashes, presumably those
after the commit message/ but others as well, e.g. in
    --- a/<path>
    +++ b/<path>
and then the second grep should find the string "Range-diff".
By having the greps chained with a pipe, only one return
code can be delivered to the test suite, and as we get the last
commands return code, we get reported if we found the string
in the preselected part.

I was wondering if we could get away with just one command to
check for that multi line pattern

    sed -n -e '/---/,/^Range/p' actual

seems to detect that pattern, and prints from there on to the
rest of the file.


> +'
> +
>  test_done
> --
> gitgitgadget
