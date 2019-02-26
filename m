Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4541B20248
	for <e@80x24.org>; Tue, 26 Feb 2019 20:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbfBZU4y (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 15:56:54 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41842 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfBZU4y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 15:56:54 -0500
Received: by mail-io1-f66.google.com with SMTP id i5so11662049ioq.8
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 12:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JRbXTzbxUdmtD33cgH/QdEKmXxh7NwIzB+q3e8tYFRw=;
        b=sL0RNwbU4MuGoAYB5KKAsE0Gzbv5UvL4pJUGIK5y9dsryht5OEVPg2hAU61eppNvZS
         6QX4FJr8pv9PjASsTvHAD4RBXs8qcFbX77fFyqbBVwvTa7Cjm9XDy9YGlJIPQQuknM5D
         /r8Pv7d8UWHbwW/AVJisSezuxNnn4KGaurvKPECPJsCdRHp0Gn6lkFT2DG5exaIMtbQT
         RqTBGf8MCL9heCe2aatBeCr0+wDLlQm99EPladwTvLgINkc9TLxEBdtuIjHjJp2lXKBW
         ZbLDHhtK1hHCM1Z4u25+uZRdP1F7RjNlJET4Iw5/O4hm3T73dIVZgmvhZGDb/UJRzVP8
         eGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JRbXTzbxUdmtD33cgH/QdEKmXxh7NwIzB+q3e8tYFRw=;
        b=eXBmbkFsJsvW1utud6nmhqHcwH/6EIClkDWmDaFC6N0wSZFcDiYZVsZ6MpVLSiSwdW
         tdxINk2C9f336TRrt9f1EMJvU33Y1h5aBaRvu5hwoFfugn8zHWI9AGa261Pt2v6zCHCb
         pJOBCQ3Fa1fuVCiTn60d9PFd6dWTvnLZGH1zp9Sv9RdytwFaoyFPVHFmxgJRWpEwQgPT
         17YKyJLmrkFrbVDK+xE3V0BOTptfJcaDInBtWUsZyCa0d62fnpUC7YNOIfRFuWt/yuCt
         6C1ax67/O+SNyqebPK6cZ1XO6IoI0/+wwHQXl5UUuufW1l4gYznIquXP50tWiTFpS5ec
         A3Dg==
X-Gm-Message-State: APjAAAXyoURh8hi7kwEM7qldBuiMpDwyocNJMh7DcJju5xbFAUCVTYsd
        a1gvfi8ywtNDGzZnVT2nrJJVk6rmVY7RZiwZIngWoQ==
X-Google-Smtp-Source: APXvYqzAXQgkI/0rRxRYerGk9qBdNYy/pLHrPqyTpRXQVPNeCBJIvqFAfpaQYNiaAYUNaIMcVsu5ppUsMmvXde5QTwE=
X-Received: by 2002:a6b:1447:: with SMTP id 68mr22870iou.293.1551214612885;
 Tue, 26 Feb 2019 12:56:52 -0800 (PST)
MIME-Version: 1.0
References: <20190226051804.10631-1-matheus.bernardino@usp.br> <20190226122829.19178-1-avarab@gmail.com>
In-Reply-To: <20190226122829.19178-1-avarab@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 26 Feb 2019 17:56:41 -0300
Message-ID: <CAHd-oW6+Q86F3D8wzVJngRU8CFq5qXPfiV+t_0kuCR1RioSmHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/5] clone: dir iterator refactoring with tests
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, =C3=86var

Thank you for helping me out on this series and, especially, for the tests =
part.

Now that we've come to a consensus on what the overall series' "shape"
should be, can I refine what's still needed and resubmit it, in the
upcoming days, as a patch set with the test included?

Best,
Matheus Tavares


On Tue, Feb 26, 2019 at 9:28 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> There's still active review going on for the "v2"[1], in particular
> Duy's comments coming in as I write this. This doesn't address any of
> that.
>
> What it does do is have a better version of my patch to add tests for
> the current behavior. It now doesn't reply the on SHA1 prereq anymore,
> and we can test the dotfiles without needing the SYMLINK prereq.
>
> I also moved it to the front of the series just to document/make sure
> that we start by asserting testing functionality. I ran a full test
> suite run for each of these patches and they all pass.
>
> The only other change is getting rid of an unused "struct stat st"
> variable which errored out under DEVELOPER=3D1.
>
> 1. https://public-inbox.org/git/20190226051804.10631-1-matheus.bernardino=
@usp.br/
>
> Matheus Tavares (4):
>   dir-iterator: add flags parameter to dir_iterator_begin
>   clone: copy hidden paths at local clone
>   clone: extract function from copy_or_link_directory
>   clone: use dir-iterator to avoid explicit dir traversal
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
>   clone: test for our behavior on odd objects/* content
>
>  builtin/clone.c            |  69 ++++++++++-------
>  dir-iterator.c             |  28 ++++++-
>  dir-iterator.h             |  40 ++++++++--
>  refs/files-backend.c       |   2 +-
>  t/t5604-clone-reference.sh | 151 +++++++++++++++++++++++++++++++++++++
>  5 files changed, 249 insertions(+), 41 deletions(-)
>
> --
> 2.21.0.rc2.261.ga7da99ff1b
>
