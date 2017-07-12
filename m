Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFE2E1F661
	for <e@80x24.org>; Wed, 12 Jul 2017 21:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbdGLVIp (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:08:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33662 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdGLVIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:08:44 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so4353783pgb.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CidlpKTRQU2xWaRkhVsGvoIJf4MzoKExkm18E/C8iG0=;
        b=qmQjMPKge17HFo+dWDPGKTF/b1JW3RCkbKJ0qkxL78pedjSTTtFLNYx5GMPxom65QL
         UmaIX+ZZP0ncb5fv5OYY3JmK9Z8yz63uiDNdLDuSNP4qvHHLwa8pEeBZQX5FKZ0cmhRj
         oucns/GoVNa9Sa328hCFPOfpjywR2Et68o/V/MfCozjnSC5ybBiThMNz6dRp8e3pdRGw
         3tdw/dKzehoMnwP1wYMDYs4s7jhvf9fffxhPlw8TB624sbpP3AjWtQkp1+pCI4DcdYuM
         nrAehugiRWoY/xKl2Uw3cLI+IMO/e3zEb/z4ePdn9tYAs0X3jg8jEcteTc7lCnnKfd3V
         1n3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CidlpKTRQU2xWaRkhVsGvoIJf4MzoKExkm18E/C8iG0=;
        b=sTbPGgD77f6YahjItFh2Z2PkguUYbryfQLqiiFK5zq5apLyppEMx18yCw0h49ZcL2n
         ZLXZY6rjKvnvQvHcKPBXoJEuu3ADONxWLiCFBT5kYTGejYiigOW/PH8Y5FHKsHauEZjS
         cBbrPs5gAvm+hQadiSmRuN96OidMAqCQD2UykUTveOIZfkK//dNbF9dYHNIw6pvsYmiI
         cZpYq7cYQxrBLTCaocuz61n84e36jv0rBW+gIFplSWNsYAvnx5yBMB/kmbBsNB5HatJl
         BXVcY5g3JlZjpdVkfW24NhiSmtFqfcKO85Y5QnYGXSmZm7VKSvaxeqhlqc1rSvbgjYPv
         99bQ==
X-Gm-Message-State: AIVw111MAvrHESKD/9/gzp1polnx7XeBMCeIE02EXfRDHrpNRxZcoexM
        eFbQWQxsE9yNy18pp3o=
X-Received: by 10.99.168.5 with SMTP id o5mr5644892pgf.207.1499893723365;
        Wed, 12 Jul 2017 14:08:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id z86sm7840001pfl.40.2017.07.12.14.08.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 14:08:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] strbuf: use designated initializers in STRBUF_INIT
References: <20170710070342.txmlwwq6gvjkwtw7@sigill.intra.peff.net>
        <4d4f2af7-60b9-5866-50bc-ecf002f74cba@gmail.com>
        <xmqqeftn3s7t.fsf@gitster.mtv.corp.google.com>
        <87d195zcy0.fsf@gmail.com>
Date:   Wed, 12 Jul 2017 14:08:41 -0700
In-Reply-To: <87d195zcy0.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Wed, 12 Jul 2017 21:12:55 +0200")
Message-ID: <xmqqd1951hye.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, Jul 11 2017, Junio C. Hamano jotted:
>
>> Just so that people do not misunderstand, it is not our goal to
>> declare that now you need a fully C99 compiler to build Git.
>> ...
>
> I think in the context of this desire Johannes Sixt's "Actually, I'm
> serious [about let's compile with c++]"[1] should be given some more
> consideration.
> ...
> Most of his patch is just avoiding C++ keywords, e.g. new -> wen, try ->
> try_, this -> this_, namespace -> name_space, template -> templ
> etc. It's going to be relatively easy to avoid a few keywords as
> variable names, especially if we set up CI for it via Travis.

I am not interested at all in building the binary I personally use
with any C++ compiler, but I do not mind too much if people made it
easier for other people to do so, but only if the did it the right
way.

I do like the fact that we call two things we are comparing with a
pair of matching words, 'old' and 'new'.  When two variables or
fields have certain relationship, they should be named with words
that have constrasting meaning that explains what they are.

I would very much mind if a "let's make it buildable with C++"
effort made the code compare 'old' and 'wen'.  C++ is not that
interesting to sacrifice the readability of the code.  Don't invent
non-words like wen; don't truncate a word like 'template' in the
middle to 'templ' to make it unreadable and invite inconsistencies
(e.g. "was it templ, templa, or something else?").

If a "let's make it buildable with C++" effort needs to avoid 'new',
replace *both* 'old' and 'new' to a matching pair of words (perhaps
'pre' and 'post'?  but it is making it worse by choosing a pair with
different length.  'one' vs 'two' would be OK if there is no strong
connotation that the 'old' side is always truly older in the
function in question).

I would not mind the result of such an update that much.  We already
do use different pair of words in places that we could have used
<old, new> after all.

Having to review too many updates like that in a single sitting
would be annoying, though.

The same thing for where we use 'this'; if the existing code is
contrasting 'this' with 'that', and if your C++ effort wants to
replace 'this', you MUST replace 'that' as well so that we would
still be contrasting a pair of variables appropriately named.
