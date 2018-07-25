Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0FD51F597
	for <e@80x24.org>; Wed, 25 Jul 2018 21:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbeGYWq1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 18:46:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40969 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbeGYWq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 18:46:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so8687620wrr.8
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=clV/6O+fmyQrQFSbL7ar8wijR2vSGIi2J78rmveCwC4=;
        b=qIO9M7voKphZF9saFl+6llFhgJpYu2Oe4ZFphtC4fsrxHP/EnhAqT6lsy0II7rDwf4
         58MB0KpFTYKOQTautiDNoBtB4jg3TokUbVNF3h+ZKKybvJ5Uoli43WHxex8r6NwP7J9d
         XmNj/OcqThoDWF9o9hR3YX7CY4i6grBZszhMc22hpRV3SDkP80ngrRc0kikvMbiaw5RS
         G88CsGoyeqhwBTNbyEoLITO2Pj7z1Z7Bdp3jUg1o3kt2uJtvA0D1se7RUZg1nKZ6bdN5
         WrD4FIdsDuvXrk7tCgNK7LgOjszzfP5W0SHXmt2SFi9U6fAHZ/RvOM+SAO/GBCut5h18
         PLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=clV/6O+fmyQrQFSbL7ar8wijR2vSGIi2J78rmveCwC4=;
        b=CrGYO+TFz7kCba0If5AXZHhPhVWhuItl8mTGkB23o3oUsZGHgTIZ9/NlmsbAM5Zltd
         L2n8zwHtO7nfMqE8t2w/ZhmYvKWsvxnM4w7Q1BbmsGbcDSJNQx1g5yZ7ucepNql+faEH
         2lZ6vkS/nYNKRDnqwLKgYX5kwowMC5CR0CcHTlhdfBN+bJ/KVbIFkx42hMS7We587cVz
         Tz3lByUprAxVQQwhezGmya+xQ/0MkOVK2p0HuumEsO8YSIsKgaWOpfjice0tjF0InDDG
         KR9XqFZXeSbp3rNDxcB0pAS2EoBYx6jPUpiWZuLz122kG1VsVHJf+to0fUERV/yI+zNo
         EhCg==
X-Gm-Message-State: AOUpUlG51lNSfehVp6q3BBkyL/CIIYZ2mCPwUxZQ9AxkJaPIt3KrnW6T
        lmjg/KEmaC+QqLpnCs2rPbU=
X-Google-Smtp-Source: AAOMgpe7wHispmAVispTSdVHjFNzsvrQhysBPR63JlFwXFlpUnyFu58nHln1FVC6qyTr5eexKzjUlg==
X-Received: by 2002:a5d:494c:: with SMTP id r12-v6mr15693449wrs.66.1532554371939;
        Wed, 25 Jul 2018 14:32:51 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x14-v6sm13694331wrv.21.2018.07.25.14.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 14:32:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Subject: Re: [PATCH 2/2] doc hash-function-transition: pick SHA-256 as NewHash
References: <20180725083024.16131-1-avarab@gmail.com>
        <xmqqzhygwd5o.fsf@gitster-ct.c.googlers.com>
        <20180725083024.16131-3-avarab@gmail.com>
        <xmqq4lgnw9fj.fsf@gitster-ct.c.googlers.com>
        <20180725172537.GA176329@aiede.svl.corp.google.com>
Date:   Wed, 25 Jul 2018 14:32:50 -0700
In-Reply-To: <20180725172537.GA176329@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Wed, 25 Jul 2018 10:25:37 -0700")
Message-ID: <xmqqin53t30d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Regardless of how we spell it in prose, I think `sha256` as an
> identifier in configuration is the spelling people will expect.  For
> example, gpg ("gpg --version") calls it SHA256.

OK.

> For what it's worth, I would be in favor of modifying the section
> more heavily.  For example:
> ...
> Changes:
>
> - retitled since the hash function has already been selected
> - added some notes about sha1dc
> - when discussing wide implementation availability, mentioned
>   CommonCrypto too, as an example of a non-OpenSSL library that the
>   libgit2 authors care about
> - named which function is chosen
>
> We could put the runners up in the "alternatives considered" section,
> but I don't think there's much to say about them here so I wouldn't.

All interesting ideas and good suggestions.  I'll leave 2/2 in the
mail archive and take only 1/2 for now.  I'd expect the final
version, not too soon after mulling over the suggestions raised
here, but not in too distant future to prevent us from forgetting
;-)

Thanks.
