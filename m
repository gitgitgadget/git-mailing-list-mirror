Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC94F1F404
	for <e@80x24.org>; Sun, 21 Jan 2018 11:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750961AbeAULvT (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 06:51:19 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46247 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750919AbeAULvS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 06:51:18 -0500
Received: by mail-oi0-f67.google.com with SMTP id d124so4099541oib.13
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 03:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F05jOyvEdH6NnCMJQh3mSbbWspYeofrJINyoC3ZJJkw=;
        b=KJmYeXe+ybhTJZlmP4tEa9XF7jkwkwpp6oySiVtNJmImtwjOWtPc+BTauGkfsumZHW
         7c5PO4yD1u+l4IPGt9YOcx3QEViYzQtNRvCreQFAn0EUQn2GQvpAGC7/KDv9gLodFJzo
         D7eSO7MaZNRMI9zEohhhSX+CZa+C9dwbE6vh8rpMiv2nZrrnCuMWfB+q/2LOimtkXNdg
         HcqzntBDe6SHf/NQli5OzpcS6vVkx10QMxRwhkzO6Ll3agbPbRWQ42lfmpMkslT1IZji
         rNq+sl9Tb8VhERT38epdQhXWeSjtrwSIB1H2+KH1hHA24Oyf/mA61AvsZtCN0TKlQuEA
         nSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F05jOyvEdH6NnCMJQh3mSbbWspYeofrJINyoC3ZJJkw=;
        b=J1BAgP63sJ2fHRrSGcEJ1qbcIJ922VeAm759vLmCnC2DSa+JI8yUOIyJhbZo9zXKVe
         tVI7AYBj+KmIGQExJ+qDDCA5pKatVysNSi5nI2+GSP1sic4W8CrJtY55gS7sJczMiEz7
         2qW9qe9fPzL7B3g4X+DEtgDdyhoPQHMemir4t4rK0jnrpXk1TIeO20Vpc9kjCTxKYqx1
         2+Emcbmp5PVLmAHv7NR+aErsrd/0HLcCiCPwHEFua7PLLz5sACt9yg4U7ijj75JnDzP4
         1BQf4wY6IYXugwd5O+ez47rnySuMHLxrJzCk9zjxu5/FDq2v9HNCtjO7Sr6jyidQLqbi
         XqVQ==
X-Gm-Message-State: AKwxytfzC2QqPO10fC/HH5OWBijz/ebIo0Xbe6GjKodgIYmpnokKdDN9
        KtcoZksmfB5+TARJSFuZ26B99AFyFTSVCgwMkUE=
X-Google-Smtp-Source: AH8x226+c867remTssk7dx7AdNCjuJ9f4wkv51FUpxY7yXTdzbKZEpUzvMRW6IKgRaR3sZxBn/DmBN16RUwqCCUd5qY=
X-Received: by 10.202.177.136 with SMTP id a130mr477772oif.252.1516535477225;
 Sun, 21 Jan 2018 03:51:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.27.3 with HTTP; Sun, 21 Jan 2018 03:50:46 -0800 (PST)
In-Reply-To: <20180120203324.112522-1-sandals@crustytoothpaste.net>
References: <20180119041825.727904-1-sandals@crustytoothpaste.net> <20180120203324.112522-1-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 21 Jan 2018 18:50:46 +0700
Message-ID: <CACsJy8CpfVb546caxP-HGjk9uXa805uayF0A7oMzh+fzEFS_Qw@mail.gmail.com>
Subject: Re: [PATCH] t: add clone test for files differing only in case
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 21, 2018 at 3:33 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> We recently introduced a regression in cloning repositories onto
> case-insensitive file systems where the repository contains multiple
> files differing only in case.  In such a case, we would segfault.  This
> segfault has already been fixed (repository: pre-initialize hash algo
> pointer), but it's not the first time similar problems have arisen.
> Introduce a test to catch this case and ensure the behavior does not
> regress.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  t/t5601-clone.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> I've verified that the test does fail without the patch on a vfat file
> system.  However, many other tests also fail on a vfat file system on
> Linux, so unfortunately that doesn't look like a viable testing strategy
> going forward.

vfat is not very UNIXy. I suspect we need a bunch of tweaks that
cygwin/mingw uses to make the test suite pass. There are other
case-insensitive filesystems on linux though. JFS (with "mkfs.jfs -O"
to make it case-insensitive) seems to pass the test suite and crash
git without your fix so it's a good candidate if someone wants to test
this behavior on linux in future. HFS+ fails some unicode test in
t0050 and I didn't check further.

> +test_expect_success 'clone on case-insensitive fs' '

We have CASE_INSENSITIVE_FS prereq. Should we use it here? I know it
does not harm running this test on case-sensitive filesystem, but the
prereq could be useful for grepping.

> +       o=$(git hash-object -w --stdin </dev/null | hex2oct) &&
> +       t=$(printf "100644 X\0${o}100644 x\0${o}" |
> +               git hash-object -w -t tree --stdin) &&
> +       c=$(git commit-tree -m bogus $t) &&
> +       git update-ref refs/heads/bogus $c &&
> +       git clone -b bogus . bogus
> +'
> +
>  test_done
-- 
Duy
