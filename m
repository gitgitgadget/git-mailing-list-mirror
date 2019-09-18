Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBC551F463
	for <e@80x24.org>; Wed, 18 Sep 2019 14:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfIRO4l (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 10:56:41 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40855 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731139AbfIRO4l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 10:56:41 -0400
Received: by mail-ua1-f65.google.com with SMTP id i17so2426320ual.7
        for <git@vger.kernel.org>; Wed, 18 Sep 2019 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvf4vwJOEuahXhP/56BWRczrugVmMoyqZE8wGb1VjoM=;
        b=EZxjMh8v9LQOkaxCE4SKA/ZO++Qf6R9a/ZxT4YXJVUhQcNRAXaHJZ39A2a6kVKzIRl
         MUt7n6O+uzUTxg9iisofhTBpk0qh6z7eE68wSwRFLA6zjmEPkGdsyrHGfhL4LYtHGku3
         VobYyDMlqJsPF0QsDDRP6bmxdAeeWNO2H7tOHTyw77JccxMSUdeInwIIOe9vVHTEl8De
         wy6w48E2IDkeVpM1fH9GMOLO9e/XXwqsXdRiYCsyPcGedpgplsJjOcS3xoRpwGTxeJmZ
         m2kOjP2iTdxGXJ7ij+zVM9pzutoi8jz+ZchLynnXSnJADfC1s+xsiJ9m7BFCR458c8Y1
         VPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvf4vwJOEuahXhP/56BWRczrugVmMoyqZE8wGb1VjoM=;
        b=Lb/n29iiLzjWsWwLkPDdheajVW5k5xMCvWhOQWYskFZjVLapHhal0mFkv7cUhjeKAV
         Gpu9v8hvpv3mTmXiBrOBQY/xQQJmH4QT6mgwRsg23hS3PGjUULnQzuakDkbM8HxC6mow
         WxEu/kQS8lJfz9cKykxe0DQe7HEa2hMvQcZ+NINAlrwSWc8Y9o2dnG+xWicBpLzUD3hh
         MwtVjWf36AtqCi1yNoVNLfxO17XI82z1948TzTpu5NcrroKyt3LIDqxo96mXGTH+NXDl
         WVo5mp/OQ8Oy91Wz9GliRgflqrx9kfwB6WoWlEksZCbhVpJpYgZaYausTt4Po1xUWsPD
         fzuQ==
X-Gm-Message-State: APjAAAVkXpHzBFJVo4QhS51XbqZZfqvZ7v5+JeUtg8bOgYU3PyQ3TSyP
        iGsaGlga5kJrOwa0HC5t6Ux09EJqaN2jyJKHLa8=
X-Google-Smtp-Source: APXvYqxxzJsT8XKG9jILNI6mEF8T4hMBVh47VqJEzQ/0Y31YPnViu76u85TW55GveCErwsmiKGhFaGsAPcThMSXa1S0=
X-Received: by 2002:ab0:734f:: with SMTP id k15mr2624493uap.18.1568818599222;
 Wed, 18 Sep 2019 07:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <pull.316.git.gitgitgadget@gmail.com> <0f095e85d5bf29346bdc5bf1707bb51eaf2202ae.1566313865.git.gitgitgadget@gmail.com>
 <CABPp-BEhc00g3CwKg13wDrtFHM-sw9tSy75UEbTvugKkdwTyeA@mail.gmail.com> <52c5b7cc-eab1-a74d-2abb-be8f125df9bf@gmail.com>
In-Reply-To: <52c5b7cc-eab1-a74d-2abb-be8f125df9bf@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 18 Sep 2019 07:56:26 -0700
Message-ID: <CABPp-BGcPkbLfDQDBMrG+5PK9o67kq62c1TPiEwLpwZQXcZTCg@mail.gmail.com>
Subject: Re: [PATCH 4/9] sparse-checkout: 'add' subcommand
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 18, 2019 at 6:55 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/23/2019 7:30 PM, Elijah Newren wrote:
> > On Tue, Aug 20, 2019 at 8:12 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
...
> >> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> >> index b7d5f15830..499bd8d6d0 100755
> >> --- a/t/t1091-sparse-checkout-builtin.sh
> >> +++ b/t/t1091-sparse-checkout-builtin.sh
> >> @@ -100,4 +100,24 @@ test_expect_success 'clone --sparse' '
> >>         test_cmp expect dir
> >>  '
> >>
> >> +test_expect_success 'add to existing sparse-checkout' '
> >> +       echo "/folder2/*" | git -C repo sparse-checkout add &&
> >
> > I've always been using '/folder2/' in sparse-checkout, without the
> > trailing asterisk.  That seems more friendly for cone mode too.  Are
> > there benefits to keeping the trailing asterisk?
>
> I think I've been seeing issues with pattern matching on Windows without
> the trailing asterisk. I'm currently double-checking to make sure this
> is important or not.

Can you try with the en/clean-nested-with-ignored topic in pu to see
if that fixes those issues?
