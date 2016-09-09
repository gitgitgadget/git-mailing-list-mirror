Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A078C207DF
	for <e@80x24.org>; Fri,  9 Sep 2016 23:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbcIIXr5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 19:47:57 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:36008 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbcIIXrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 19:47:47 -0400
Received: by mail-oi0-f49.google.com with SMTP id q188so59170343oia.3
        for <git@vger.kernel.org>; Fri, 09 Sep 2016 16:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h9mHngkt1TaI32HccITccG2KzKFmsm1i4wMJe1YWBHM=;
        b=OAWOOYO+QOMUr3qcz3cPXC3ucrtb/slL77iyuXbftQvvtsbT7+klR8uSXU+J0rES1g
         F7S6Y2IXSFSXWSbRwqJAwykqnzL94XhBmpgn/RiYBl8p7GNbbHKEGToeX+hn4FENFWUM
         wRKRz1lTfWWMXA3k3Wme3uXxdZxhfiK31iWt4EJ+LzW1tczXpQruYO26hd2a+9c1Ryp5
         3eJdRxWlkFYH+EuL+B/BZymqi81iCuAeTAr4VZewh/vprf09dVYknUDxzRWozhsejgQe
         HvBlYVoRZrA9KU2wqV+AcFTHp+M5DaTAFX+rcyTK6A4pN1bT71vD3jwV9ON6EqPyWJuR
         itSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h9mHngkt1TaI32HccITccG2KzKFmsm1i4wMJe1YWBHM=;
        b=mg0w0uH8Of5x2ZBxjswifhWELTuNmy4Ze+0Q2h+J9u6AuzOZKeZtB5vSpp38OOluGM
         pzmG60mpfAa3QlEp2Z3yBf+QFLalbfm8/aCIfumm2XqH4tAgRfdYnlk5fVjj6eQjapmQ
         Wa1TXJ1JhjboBIDCVnyzx5vEb1KHsZsQrYMVS4IYMETvRfL3M30yZT5z9Z0UBHd7HY+v
         FlNUhD2QfGCjyTDh2JC6ncZIsaD85+Zz+5UYSKMpm0x6dvD+yobsAPQxYAxolX/mSOik
         jWCjRusdIMbgqbNI0PEgzajDlsjwG0v34zpC9m+5g0ZYHZ+Ui4xRnasFY8uVOjtqTfOv
         pI1w==
X-Gm-Message-State: AE9vXwP5DV4gheZsAGl7xcnQ0ZOaAcQTNB8qgFYV/VKXvr76WXtuJIwevsu9IY2s+DUPKL53tKErSkVxYiJyr5Ek
X-Received: by 10.157.6.197 with SMTP id 63mr9472536otx.190.1473464866276;
 Fri, 09 Sep 2016 16:47:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 9 Sep 2016 16:47:45 -0700 (PDT)
In-Reply-To: <xmqqh99o8ypm.fsf@gitster.mtv.corp.google.com>
References: <1473458004-41460-1-git-send-email-bmwill@google.com> <xmqqh99o8ypm.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Sep 2016 16:47:45 -0700
Message-ID: <CAGZ79kaWNykEAZcjZ2Y19j2_3TF+qcz+vb8zSi1U+me3k+06LA@mail.gmail.com>
Subject: Re: [RFC/PATCH] ls-files: adding support for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 9, 2016 at 4:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>> Allow ls-files to recognize submodules in order to retrieve a list of
>> files from a repository's submodules.  This is done by forking off a
>> process to recursively call ls-files on all submodules.
>
> While I see why "ls-files --recurse-submodules" sounds nice ("hey, I
> can get list of _all_ the files here"), and I am quite happy with
> the quality of implementation (not just the code but its
> documentation and test)

The plan is to hook the ls-files machinery into
git-grep as the way of obtaining files to grep for a pattern.

As git-grep has a thread pool already, getting the list of files
single threaded  is more beneficial as e.g. calling git-grep recursively
for submodules, as then you may have a fork bomb.

>
>> diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh

> We used to do that when we didn't know better.
>

Oops, a lot of stuff slipped through the first internal review.
