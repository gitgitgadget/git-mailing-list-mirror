Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08FC61F461
	for <e@80x24.org>; Thu, 22 Aug 2019 03:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfHVDDW (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Aug 2019 23:03:22 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45460 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbfHVDDW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Aug 2019 23:03:22 -0400
Received: by mail-vs1-f66.google.com with SMTP id j25so2852024vsq.12
        for <git@vger.kernel.org>; Wed, 21 Aug 2019 20:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XVXasEaTl8ezFgsC04UwLtZjRD42WTAdpKgoPTfYg9g=;
        b=LAaLxvA6E5YXjRN8fh+zoI5BzdN9pYgi4FAJRJptD0Iq/g1yIffcAGclxSXViknAGr
         Zn1NR7NBkmicq4Y8uWUNyp2UhCbbDgNLkJ6BsvFsyZz5WVF4cnRVi6EDPnBNTWb4MIeF
         hsc2nU3xXdZVzU+8Clx2F0XjO3eeGn7/maRmHxxBD2sLPSBqGC2QCiImilEQFhqevAG2
         YLLDf8DfygTi173kuLRspY5+yJTzsDPeDpyvhF4fg6qfVwfaW3gEMaVDxzWiw6a66JZw
         is8qQV85cpatZzdKrTktc6BS4Sgfp3zQzRrfuBdIf9vjIIsc/yC8RC6uN4ph+03BooSO
         XHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVXasEaTl8ezFgsC04UwLtZjRD42WTAdpKgoPTfYg9g=;
        b=HEeGCjNKZ4WxN5tSiYLlqG5W65twDzBU70ee1APiK/74iImtTTvNXyiAKISUuNVvP4
         ATIKFCg/HChmuuDyK2/alSG/Naqih21/zmXvRXUEEr5UddW3FuJBhc1bsDAj7vzOtk00
         kwze6gM1/s0ebsrg4zIcClFVn2a2DWLgjFnlVgeWLy0+YC3iXrGGXpZc50sNsUoBJYqs
         iYYYBZKB23BS7uFROXrXrNrw8ZcM+J5GfbTmUB+lYQkbVZA0MAEkS9M/h2227WvJHHN4
         Gk7YLOlDzgODUb3pYS0LqrQy/vUWtyT2hMfwfTWskP4olBTQnt8iA5k9iHeClWTRzOdz
         hVDA==
X-Gm-Message-State: APjAAAWs7SNixQjD0w87UBbL2/rIdARXjBAQ39l8N5MW6+B7VwfLjZZh
        FYuz+cJRP8BDf6vsR3TxvClcKRR7M50jzKhw9Pw=
X-Google-Smtp-Source: APXvYqwmvSpesCVS0D7a4COttVklnBRl8uDh19bEWf1gslPMfaQzbCsUez8g+Ft2q7825dJAUN1S/CnQcCfmHPRB9OQ=
X-Received: by 2002:a67:6244:: with SMTP id w65mr23599809vsb.117.1566443001109;
 Wed, 21 Aug 2019 20:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.317.git.gitgitgadget@gmail.com> <dd3b5120077dd0414c62b8deaeaaffa40bc47736.1566415112.git.gitgitgadget@gmail.com>
In-Reply-To: <dd3b5120077dd0414c62b8deaeaaffa40bc47736.1566415112.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 21 Aug 2019 20:03:10 -0700
Message-ID: <CABPp-BHwhXVz7+GXdTdBQ-0POcr7Mh7A9ut_gw7syxE7rcXx+A@mail.gmail.com>
Subject: Re: [PATCH 2/2] DEPRECATION: warn about 'git checkout -b'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 21, 2019 at 12:21 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Recommend that users use 'git switch -c' instead.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/.checkout.c.swp | Bin 77824 -> 0 bytes
>  builtin/checkout.c      |   9 ++++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>  delete mode 100644 builtin/.checkout.c.swp
>
> diff --git a/builtin/.checkout.c.swp b/builtin/.checkout.c.swp
> deleted file mode 100644
> index f6dad4abb02c265ee66b3f6f76d00d59b9b524a4..0000000000000000000000000000000000000000
> GIT binary patch
> literal 0
> HcmV?d00001
>
> literal 77824
> zcmeIb37F(pRrf#a46<X03c_z1GgCe3>dYjdA(>2=r6*}KnI2}zLK2GV?&_Y(bXPT1
> z)icux34uRC00rR{;pJ5jL_ico7FiV85d;D8CG1O3By6%HioE<k-*fK$ZB^AXi9sKq
> zXXeQ_-ThncdhWSryXQB(>5|Edle5P+t>NE&*Q|N(#aCVRsr$ZX%_F;O)^vOAg+@a+
<snip>

You may want to add a local commit hook that prevents commiting vim
swp files, or adding them to a global excludes file or something.  :-)
