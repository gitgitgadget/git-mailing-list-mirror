Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D3A1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeFZVdO (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:33:14 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39496 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbeFZVdN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:33:13 -0400
Received: by mail-ua0-f195.google.com with SMTP id n4-v6so11880809uad.6
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 14:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1q8aWgqWsN6JNrmzavEIDkXYT5/tQtjG0PpZXWsx+W8=;
        b=EZVVKuV12KNazMTardvb+hszq32lUTj8DPPR+ZRqmErPkErY0wk5TmzzXN4IEm67zS
         ayyNjVIdG7PhIqzIHYG+2cmW+dO0VBSyNNYe1CPcZFStuYgxOaGAkP/eZaJxdklto1uc
         nic4k5TLh4gYmrK0gXsp8k6vkAOQML6DG0FhCPLwAhifptLjRqwqZpj3bZSINXlSlzWf
         mvbAvvHTtYvzSzwuTDqIhgQ9OFihJS/y31fs8i+ta5WxBRisbPAI+Q4bi0q6S9iTN2yg
         sKLfEDOXcd68x69wR765lM5USm+D0PY+pb3Kr9JqXWlX2oFmq/XerIhEGaShpPGuGmij
         yK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1q8aWgqWsN6JNrmzavEIDkXYT5/tQtjG0PpZXWsx+W8=;
        b=JpNzYWpiWle7qGCKnIhMcvm7SAp5//ZrQ1rvKP3pxGkPH4L1dMeB19et2LSusS5Pem
         FnMQwMau6j+vcVpMJLhx+LMpKUC/Qw4pLNiHESsvX/6XQz9k/OIw6A0QTi5+x0ssfDsM
         O/RCWWKW+OiOStVH5J4j2gCqH0nf44zhVDhWjCb2hoIfKeWFwaPiOg7xnASUn0wzZwu1
         VTN/Ir8e+hY1lgc2/2Z5sSZB1gtS91Jaq/WuarcqLOto/RdqGPA/obdBh+t0yLwaA/8G
         G1RukOLjtZqnksgRE9TzkB9JDKCYL+mjrj6fu2KZjSZP2FVVpttu7ZBTsoZXYMCO59rZ
         krNA==
X-Gm-Message-State: APt69E2MU+luFAOC9fpTBjk8aD/DUcsBlCdvKaU8KeuFEzoOfrt70Xqg
        m+WF8KWtzPmJIZjVY4YNTbxStZTyNB2cd7Rau/A=
X-Google-Smtp-Source: AAOMgpcqn2dzFKgK5B2882z5QDcVpf2syRzFUyAyAlaGB8w8SKYG12ylxmBoc6FizM+FRjO9XljrJFRYvm0fl2eLBuk=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr2092913uae.199.1530048792475;
 Tue, 26 Jun 2018 14:33:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2310:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 14:33:11
 -0700 (PDT)
In-Reply-To: <20180626202244.GB2341@sigill.intra.peff.net>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com> <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
 <20180626201708.GA2341@sigill.intra.peff.net> <20180626202244.GB2341@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 26 Jun 2018 14:33:11 -0700
Message-ID: <CABPp-BGP2OFYgP5Xm0PMj_NPH2f_UmtMpoHYzcgo544V0e-_Zg@mail.gmail.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 1:22 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 26, 2018 at 04:17:08PM -0400, Jeff King wrote:
>
>> I'm not sure if there's a good solution, though. Even if you retained
>> the subshells and instead did a chain-lint inside each subshell, like
>> this:
>
> So obviously that means "I don't think there's a good solution with this
> approach".
>
> That whole final patch simultaneously impresses and nauseates me. Your
> commit message says "no attempt is made at properly parsing shell code",
> but we come pretty darn close. I almost wonder if we'd be better off
> just parsing some heuristic subset and making sure (via review or
> linting) that our tests conform.
>
> Another option is to not enable this slightly-more-dangerous linting by
> default. But that would probably rob it of its usefulness, since it
> would just fall to some brave soul to later crank up the linting and fix
> everybody else's mistakes.

This may be a dumb question, but why can't we run under errexit?  If
we could do that, we wouldn't need the &&-chaining, and bash would
parse the shell for us and exit whenever one command failed.  (Is the
reason for this documented somewhere?  I couldn't find it...)
