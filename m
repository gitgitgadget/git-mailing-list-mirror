Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5150620282
	for <e@80x24.org>; Mon, 12 Jun 2017 05:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbdFLFYO (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 01:24:14 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34456 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbdFLFYN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 01:24:13 -0400
Received: by mail-pf0-f170.google.com with SMTP id 15so19907161pfc.1
        for <git@vger.kernel.org>; Sun, 11 Jun 2017 22:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BoG6FiNWF44N0Z+uQy1+lzQqPD+pDBXaqlLcYwMS+k8=;
        b=r3gJp5dlj/+6ZxV5PNFHL6WMATh0pd63i6WUTyhbbmWGvWKANK6FJOmTEiW6unqxIU
         1HlcjJ2+489aDw1sniDwWwbAoAc32BvlFV5UWI7HQi2GWMtLMlcC9vTMcroj3bg0RodQ
         sGMI1Lc8x4Lzca3aFhu6ZjGlVewJnOUsu/SH+wOOszPALLvSWjEovOUC2oPIAibejHNm
         ep5x/gGHbBg6zEqBbrbY9xRkMagpc0yWia/aF2la6gu90bVVYHCAA1xxJF2c+S3CJniV
         hUn5rIlYMMlQNdkzFk4/krf8ZbARrGEqlBHK1oecN0BFtUuVmqE9p6pv6OyZxo8hHyg7
         8Jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BoG6FiNWF44N0Z+uQy1+lzQqPD+pDBXaqlLcYwMS+k8=;
        b=E7w+lvp2sHa90YP805v9zcgSR521qet+OHV+Un39xYOzyAaLUbIgvJmN36YsFrGPfX
         sI+gpdchvwuuNKawaGzGHejWydPO146DH9wBSjbTL9ObQlK5AQKK/FKPCOcw0IBJZP+Z
         FuD8dDS23daLX+h8DLLMairY85OrNW0CM7jQbnp97DY3MgN1/CJMGbZMuRw2s+34I/Z0
         meowhbQnTnj1OInmsHTEk0qnTUkJUEdd57F6HRuV3i+owck9M02RuzAN/l9EE5i9foz8
         RVIYw/7eGLOmXtl5mAB/jSPO0Z1v2lcw4WUzBN0WXOI6JPQ6s8xwyjKKwLs80tSO+Jyu
         fMcw==
X-Gm-Message-State: AODbwcCtXSfEneajhgQkjKpsRFwjAghs7LbLuOHipTDEmqQTC2tVAaj8
        GApTR7uZtANpCMvj5RFb27ni8dHfGbYZ
X-Received: by 10.84.209.228 with SMTP id y91mr54423240plh.210.1497245053107;
 Sun, 11 Jun 2017 22:24:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Sun, 11 Jun 2017 22:24:12 -0700 (PDT)
In-Reply-To: <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
References: <20170531214417.38857-1-bmwill@google.com> <20170608234100.188529-1-bmwill@google.com>
 <20170609174034.61889ae8@twelve2.svl.corp.google.com> <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Sun, 11 Jun 2017 22:24:12 -0700
Message-ID: <CAGZ79kbtZJd3O1vZBEkqU5_VRs5LmJhxUKtWu4RWTyk5M1r__Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/32] repository object
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ben Peart <peartben@gmail.com>, Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 9, 2017 at 11:07 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 09, 2017 at 05:40:34PM -0700, Jonathan Tan wrote:
>
>> Before I get into the details, I have some questions:
>>
>> 1. I am concerned that "struct repository" will end up growing without
>> bounds as we store more and more repo-specific concerns in it. Could it
>> be restricted to just the fields populated by repo_init()?
>> repo_read_index() will then return the index itself, instead of using
>> "struct repository" as a cache. This means that code using
>> repo_read_index() will need to maintain its own variable holding the
>> returned index, but that is likely a positive - it's better for code to
>> just pass around the specific thing needed between functions anyway, as
>> opposed to passing a giant "struct repository" (which partially defeats
>> the purpose of eliminating the usage of globals).
>
> I think the repository object has to become a kitchen sink of sorts,
> because we have tons of global variables representing repo-wide config.

AFAICT we want to operate on struct 'the_repo' and struct 'the_cmd_options'
eventually. In our use case of submodules the submodules would ignore the
settings of the main repo, but still accept guidance of the_cmd_config or
'the_config.

> So I have a feeling that we're always going to need some
> big object to hold all that context when doing multi-repo operations in
> a single process.

Well not just one big struct, but two. (or more?)
