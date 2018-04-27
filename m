Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E201F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758908AbeD0RPV (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:15:21 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:36552 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758271AbeD0RPT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:15:19 -0400
Received: by mail-ot0-f182.google.com with SMTP id p2-v6so2837412otf.3
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yIVwE0hR179b6DxTk6oJYeyz283pS2So/0VXXeaGY94=;
        b=ef4gT+twFJcSthWohWfEnql/FohDk/KFy1nfZxvNgYYzw4OLE1YrnZKxMFEsNXlatz
         JSWDuIgUvPD6kTEbPbp3kM82HHMY6n0B7kdISlsJZ7aZdeS0Xk+Co7SwBINrU+MrpgbN
         xtE/+/6OwpW0hN/oK94NaSVLN3zaDl3wR4fZyn1bfI0HfsLpsacDbdlpZ8C1GAgJKlMf
         qv37nxeHpEjHK1Vhg1uRyO3X+pJ9RX9cj+qz9XzVC/vfMKDSavI3FB4jsbFqc1wV1Bf6
         IyJe+hLDU0W6defCpEDmsTmYAGtfv2cLREhRRHt2Loklwkzs+AaO3rv6ykq8NVo0Ie/e
         v+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yIVwE0hR179b6DxTk6oJYeyz283pS2So/0VXXeaGY94=;
        b=CDajN+bIxlXwwcIh4Vc2w6iIxvmizfSAyguIGnGa5AVddk1khdCNxGgsUTUw8sDAsL
         qTdfktLxn67AX1Q4SHf3QvFh0mTPiAR9IRvEoiTdGvehZcqtWu78eUYE5EJDXRoogV7n
         fb7NluVNJif9XAyJasRkCrvi1t20FpNSt3Gc/crPJUFlN0l5NCSGKXdAJM6QN/rKAIeH
         qIaYMZlt+vhGA7Jh4h7t3p5dwH6PU2CexKRzrF8+EIpgR2HktLqENsBz2PAhVIeohyoy
         xm0hmtRUooPBtsUKfysicrqXRc9vkcDm+/rdTiSTUUHz5gh/hl3V3NJ7zxq7cDhSAQ2x
         oKHw==
X-Gm-Message-State: ALQs6tBfi0QU2ppYpG3CBbVQgq5+95tc0g0F51ZYkr+rYT5LkeW/jNtM
        bviesb7lls1ffBa2PKc+Gx332htWFFMcETg1g3s=
X-Google-Smtp-Source: AB8JxZpFohtVTEi8So0E8Wwb2q5QRiNVLISrCTfkg7ymAW2sZbmIqWEoyJhxafV4kSBolm8TQVTrqYRVWmzwY6+WVhQ=
X-Received: by 2002:a9d:5220:: with SMTP id e32-v6mr1932375oth.110.1524849318893;
 Fri, 27 Apr 2018 10:15:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.97.70 with HTTP; Fri, 27 Apr 2018 10:14:58 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804270939400.72@tvgsbejvaqbjf.bet>
References: <CAFW+GMAJcCG4mKe4TxFXXrfdRhZKXv8ffC-rNShFLW2J1_FANA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804270939400.72@tvgsbejvaqbjf.bet>
From:   William Chargin <wchargin@gmail.com>
Date:   Fri, 27 Apr 2018 10:14:58 -0700
Message-ID: <CAFW+GMC5ST5tuSJAShDGkPeZ2ifLV1M9R3j_L+usPn+=+tAYaw@mail.gmail.com>
Subject: Re: In some rebases, `exec git -C ...` has wrong working directory
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Thanks for your reply.

Part of my confusion was regarding the interaction between `-C` and
`--git-dir`. For instance, we have

    $ git --git-dir target -C /tmp/tmp.Cl4aXMSVis init
    Initialized empty Git repository in /tmp/tmp.Cl4aXMSVis/target/

which makes sense and is what I expected: the `-C` and `--git-dir`
values are joined, as suggested by the docs for `-C` in git(1). But with

    $ git --git-dir /tmp/tmp.Cl4aXMSVis/repo -C /tmp/tmp.Cl4aXMSVis init
    Initialized empty Git repository in /tmp/tmp.Cl4aXMSVis/repo/

it appears that the `-C` argument is ignored entirely. Is this because
running `git -C foo ...` is equivalent to running `cd foo; git ...` in a
shell, so when the `--git-dir` is an absolute path the value of `-C` has
no effect? (Assuming that `GIT_WORK_TREE` is unset.)

In your example:

>        exec git -C /somewhere/else show HEAD:some-file >some-other-file

isn't the behavior to copy the version of `some-file` in the repository
being rebased to `some-other-file` in the current working directory,
such that the `-C` has no effect, because the shell redirect is not
affected by the `-C`? (This is what happens for me.) If so, why include
the `-C` in the command?

> I do not think that we can sensibly *remove* GIT_DIR from the environment
> variables passed to the exec'ed command, as we have been doing that for
> ages, and some scripts (as demonstrated above) started relying on that
> behavior. So if we changed it, we would break backwards-compatibility,
> which is something we try to avoid very much in Git.

This makes sense; understood and agreed.

Do you know why `rebase --root` does not set `GIT_DIR`?

> Maybe you could a contribute a patch to the documentation?

Sure; I'd be happy to do that once I understand this a bit better. :-)

Best,
WC
