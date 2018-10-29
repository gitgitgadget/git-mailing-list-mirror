Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A35E1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 04:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbeJ2NE5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 09:04:57 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:34006 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbeJ2NE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 09:04:57 -0400
Received: by mail-wm1-f47.google.com with SMTP id f1-v6so8580660wmg.1
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 21:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V0wXScWVui2A2Kr7Rj7c5ICcdZNo5QAE7IZw428awak=;
        b=gKgqQyFIPh7oC/DWdVltgUtl1lXCzX8VSTPEsJFAn8Teup3RQJbTm7TQLNmbZu96b+
         4FGjl/EQfhtRLwGH8Xp+2sryOVLVKcyQtospMkbGczH6KmTvtk3jWG0BmiA4DZITCiQF
         8NV5U8GdVFdQLcMLv2MgvEXqrv2AbtGVjNNcF5W569r822iikjkWrrsR8g3kTWESC/fj
         jbQQ+vvE9u9Gj1RB4qFi3+D7QC2mlGNmM+7F9gfVxamFzAzY01me+p39pPmmcLbS9igY
         v5E1OuttCTWWG7rNtYR97Ag4AK0d5pArukH+iI5nJR5dK9UaDnluy0JMluvwpLBZvuh1
         5Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V0wXScWVui2A2Kr7Rj7c5ICcdZNo5QAE7IZw428awak=;
        b=mrZ3upkAwMp/XpV02B/Nq06VVANFgYCtg6RdMkncE4sSrQblf9CcGl0FsYYKBuphhf
         0/pXMcQ3F9JDh5ZpMLyBEyMA1PBgBgPUfWNSv9joGs76pZUEke7ZkVUr1iDfgzZoGVGC
         kxOQNDkPKw8plPgZ+B/NKv9SMRblb5ojxKStLmH7ddcr6Jjac/jZhcQKT2bImgEZBJoY
         m4I0ZcZbIkKvdUAseLvRgpj+I5drY74fhWvQebIv12FMBbeI468prMssOsQdxtj5QoBQ
         zGPTcVBLJ0SodRfA/RxyZTZuOakHqmlfZb+aCgKY6iWbLb+gMd9kbxnuHJ6xmqHv5GD4
         a6AA==
X-Gm-Message-State: AGRZ1gJOYcmV8g6Ns5S8gxzbwQyGZ3mVJiPnFXwztsgPC3q4IUTwI4wU
        s4UtCXWh+J/w7c/YooHC2n8=
X-Google-Smtp-Source: AJdET5efSiPs8jdL7FBdmXvrMbayf4PSpqp/f2iG/JgpP+vtxEPuU2P4XjpfkBZi1F3Wi3QiGXW2+w==
X-Received: by 2002:a1c:8e8c:: with SMTP id q134-v6mr12351893wmd.112.1540786679120;
        Sun, 28 Oct 2018 21:17:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 138-v6sm4308070wmr.16.2018.10.28.21.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 21:17:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] push: add an advice on unqualified <dst> push
References: <20181010104145.25610-1-avarab@gmail.com>
        <20181010104145.25610-3-avarab@gmail.com>
        <20181010205505.GB12949@sigill.intra.peff.net>
        <87r2gxebsi.fsf@evledraar.gmail.com>
        <xmqq5zy8f6gr.fsf@gitster-ct.c.googlers.com>
        <87r2gclnjc.fsf@evledraar.gmail.com>
        <xmqq5zxla7nd.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 29 Oct 2018 13:17:57 +0900
In-Reply-To: <xmqq5zxla7nd.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 29 Oct 2018 10:00:54 +0900")
Message-ID: <xmqqy3ah5qtm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> To put it another way, I would think both of these two have at most
> the same probability that the push wants to go to a local branch:
>
> 	git push refs/remotes/foo:foo
> 	git push <any random sha1 expression>:foo
>
> and I would further say that the former is less likely than the
> latter that it wants to create a local branch, because it is more
> plausible that it wants to create a similar remote-tracking branch
> there.

This needs clarification.  I do not mean "it is more plausible that
it wants remote-tracking rather than local".  What I meant was that
between the two cases, pushing refs/remotes/foo:foo is more likely a
sign that the user wants to create a local branch than pushing other
random sha1 expression, like 40eaf9377fe649:foo, is.

