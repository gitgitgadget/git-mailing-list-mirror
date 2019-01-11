Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DDC11F803
	for <e@80x24.org>; Fri, 11 Jan 2019 00:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfAKAhx (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 19:37:53 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33952 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbfAKAhw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 19:37:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so845023wmd.1
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 16:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5Dgg2DZ4aPbtoPr7+gRfGjS262E6Eux8/OhL+hW77XM=;
        b=TgkmPiyuYupu0XlNgW/16/c+rtPR4/gRsKmoqGH3nvfNn0Fbhm0wee8uRZw1nK9Z4s
         TtFaSJcX31uYVRaVxxmQgS4alYpNGpqK3E5FnhHKeAIEezUhCONo9EpRlZiknduv4Q3z
         N3uiBQywE5eZOhVZxw4k1UQaBymtpYjWR0wr29DKb73xVc6US+EWeWWUVCp69viN2lSt
         Yr6KEQnpmOsGG0UkWu/eEW+CzA3wlNZmH+YAwHH8Cm08wDizlb628TilC79piI2qYK44
         Ey0gTrW5ryrdReL8gNvrarrdv3IzmbaWX7gIUGE5Bd0Ecq4YSdoA09NmiN4acMNArejO
         cucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5Dgg2DZ4aPbtoPr7+gRfGjS262E6Eux8/OhL+hW77XM=;
        b=SyMKJ/sSheUFR6Xg/FxKE2Wd/Cz1JAxZQbyUUTLkBbay00opQ2RXJVDWRUWc8C4ugC
         +AymIZ3uhlaZmmmft5qF7qoX4V5yd00H8js4T7pOEmK+90lXyhrrlZPsfQaSRO8iD6D4
         Q2Gd+BFIstjGRICDh6YLtw0XJiJNvV1qk+bPaCjk2QuYkg0P3rhcemSTx1JrHeca9MNY
         JIT3nt8zaqSYWyNnw/padQ9WraC3AqblIuCDQ3gaxt6em2QtBCWB0RWK5YRkiUHkF3CM
         ii4diPkkKip21szUe8Pp1cpskrsBMnIB8p2F81cdIeuimGLMc/tzf4J59SzkATTGebEo
         BgQA==
X-Gm-Message-State: AJcUukdjLRiPDtFW6DYwzrJ/3lFZ/12z2tOZepkfZlp7bF8E8A1ZPFrR
        yUWZhzq46tlStd3rFfIJNcg=
X-Google-Smtp-Source: ALg8bN45MjYlCPg0u2ekiY49hwYQbNNaJonBHINGaYyo2hRettJw/AKWrHIKK8n2zTxLy+v/qF9b9A==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr205879wmk.47.1547167071044;
        Thu, 10 Jan 2019 16:37:51 -0800 (PST)
Received: from szeder.dev (x4d0cf90e.dyn.telefonica.de. [77.12.249.14])
        by smtp.gmail.com with ESMTPSA id v16sm51322014wrs.75.2019.01.10.16.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 16:37:50 -0800 (PST)
Date:   Fri, 11 Jan 2019 01:37:43 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/5] compat/obstack: fix -Wcast-function-type warnings
Message-ID: <20190111003743.GA840@szeder.dev>
References: <20181220162452.17732-1-szeder.dev@gmail.com>
 <20181220162452.17732-2-szeder.dev@gmail.com>
 <87zhszeqsr.fsf@evledraar.gmail.com>
 <xmqqef9k1a4n.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqef9k1a4n.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 01:22:00PM -0800, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > On Thu, Dec 20 2018, SZEDER Gábor wrote:
> >
> >> When building Git with GCC 8.2.0 (at least from Homebrew on macOS,
> >> DEVELOPER flags enabled) one is greeted with a screenful of compiler
> >> errors:
> >>
> >>   compat/obstack.c: In function '_obstack_begin':
> >>   compat/obstack.c:162:17: error: cast between incompatible function types from 'void * (*)(long int)' to 'struct _obstack_chunk * (*)(void *, long int)' [-Werror=cast-function-type]
> >>      h->chunkfun = (struct _obstack_chunk * (*)(void *, long)) chunkfun;
> >>                    ^
> >>   compat/obstack.c:163:16: error: cast between incompatible function types from 'void (*)(void *)' to 'void (*)(void *, struct _obstack_chunk *)' [-Werror=cast-function-type]
> >>      h->freefun = (void (*) (void *, struct _obstack_chunk *)) freefun;
> >>                   ^
> >>   compat/obstack.c:116:8: error: cast between incompatible function types from 'struct _obstack_chunk * (*)(void *, long int)' to 'struct _obstack_chunk * (*)(long int)' [-Werror=cast-function-type]
> >>       : (*(struct _obstack_chunk *(*) (long)) (h)->chunkfun) ((size)))
> >>           ^
> >>   compat/obstack.c:168:22: note: in expansion of macro 'CALL_CHUNKFUN'
> >>      chunk = h->chunk = CALL_CHUNKFUN (h, h -> chunk_size);
> >>                         ^~~~~~~~~~~~~
> >>   <snip>
> >
> > We originally got this from now-discontinued eglibc, but I notice that
> > glibc.git's malloc/obstack.[ch]'s diff also changes these lines. If you
> > backport those do does that fix this warning?
> >
> > I.e. is this another case where we're blindly fixing bugs but should
> > just re-import upstream's code instead?
> 
> Good point.  I am inclined to queue the remainder of the series
> without this one for now.

Note that without this first patch the linux-gcc build job will fail
with the above compiler error, and that's the only build job that runs
the test suite with all the misc test knobs (split-index,
commit-graph, etc.) enabled.

