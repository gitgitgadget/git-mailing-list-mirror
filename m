Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69A41F403
	for <e@80x24.org>; Tue, 12 Jun 2018 21:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933999AbeFLVg1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 17:36:27 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35283 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933696AbeFLVg0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 17:36:26 -0400
Received: by mail-yw0-f195.google.com with SMTP id v131-v6so171053ywg.2
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 14:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OvUcGFLgiDS63t2OsWHP6/ZWcRVh9FuKCG8ImneKyMo=;
        b=b3oht/D2mF1A12JhpnkGsW1JzzrZ65zO4IZ0B6aI1t8hmWh3eroSOuUIVX5iuldv8C
         ipqq2M/diTIVU918EEfn16uDozcuVZVyVJ8zrox3VHPRrQhPuk7+a9eQ1coEvR6FzxUZ
         r+wNpFU9t091m0reDReHu5OcvKCSPTuph5aCvwGh11svhVsL+zFGH/uy+iE106Vz9fu4
         uHDrXCz0lCp0eRqOCVtVw388oV2jz+1k9gfAPpLQA/bBhEkHvNPER8GnuFMIxOanfw4P
         0sRHzGGngFAyfRtkDbbCH7zWahZa4zcRYSNT8lF6R/nLsvmRrYLF32ugihJ8/evUJPt4
         V6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OvUcGFLgiDS63t2OsWHP6/ZWcRVh9FuKCG8ImneKyMo=;
        b=EpNhiEkDO4OM5h540i0aRFA9+0a3orqegJ+tDwzLf3uuXJ8wCn9zUfnO1Y4zUyHXvl
         tJS+UqdN7Qc1GX0wIj1gy3PFris7b/vBox/ANOy03JpfUOEE/RTUJ0L0nuRSiIEo7QVo
         s7KvVkK/rhGU801Ks1Lqf9Lx2I6RRipCcp88zSqVZdddYpmD9RTx3NftkrzKuYhRckzV
         jJoWzBT0mX4Z2Z/J2Zv0r4xBUrv4ZETOja3dRp0JPosZyznhowWWYbOsOxgIDuRDNzLA
         dOeBFqMKvnIPPQL7JMMU67MPimHfeuUTImmHO4q+ya3/OgbPPLn1TCPkFoIGUV7kJYiB
         4HdA==
X-Gm-Message-State: APt69E2FXs0Zk4n8UaI+yZ96JLlg7BbJGejBBoDdVNUVI+FP9cPgan95
        dCcUpSFTHL8lyT8q8bA3a5UDa+sy14cgsD4/si8=
X-Google-Smtp-Source: ADUXVKLdmnEbu2YXxjkL5J4QX9XL1qYRk5gwaKvUmSySsrGzw0QF9e0GDAVlgaYqw2ugOJ8PdN74nTxACkt+wgMZ/Ks=
X-Received: by 2002:a81:6088:: with SMTP id u130-v6mr1117600ywb.418.1528839386157;
 Tue, 12 Jun 2018 14:36:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 14:36:25
 -0700 (PDT)
In-Reply-To: <20180612212540.200142-1-sbeller@google.com>
References: <20180612212540.200142-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Jun 2018 17:36:25 -0400
X-Google-Sender-Auth: Rb1MHYsbLCU1PbJLXPpg-J-ooRc
Message-ID: <CAPig+cQM-DXc3sK_Eb7xaaTxNk=0yu9Q3oYtx7M4EinS04AYHA@mail.gmail.com>
Subject: Re: [PATCH] t7400: encapsulate setup code in test_expect_success
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 5:25 PM, Stefan Beller <sbeller@google.com> wrote:
> When running t7400 in a shell you observe more output than expected:
>     ...
>     ok 10 - submodule add
>     [master (root-commit) d79ce16] one
>      Author: A U Thor <author@example.com>
>      1 file changed, 1 insertion(+)
>      create mode 100644 one.t
>     ok 11 - redirected submodule add does not show progress
>     ...
> Fix the output by encapsulating the setup code in test_expect_success
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> @@ -126,8 +126,10 @@ test_expect_success 'submodule add' '
> -test_create_repo parent &&
> -test_commit -C parent one
> +test_expect_success 'setup parent and one repository for further tests' '

Nit: "for further tests" is implied for actions performed by a "setup"
function, so a bit redundant to say so.

> +       test_create_repo parent &&
> +       test_commit -C parent one
> +'
