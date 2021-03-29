Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F94C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 01:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916A361942
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 01:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhC2Brp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 21:47:45 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36180 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhC2Brp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 21:47:45 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C70F81F5AF;
        Mon, 29 Mar 2021 01:47:44 +0000 (UTC)
Date:   Mon, 29 Mar 2021 01:47:44 +0000
From:   Eric Wong <e@80x24.org>
To:     Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v5] gitweb: redacted e-mail addresses feature.
Message-ID: <20210329014744.GA2813@dcvr>
References: <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
 <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com> wrote:
> Gitweb extracts content from the Git log and makes it accessible
> over HTTP. As a result, e-mail addresses found in commits are
> exposed to web crawlers and they may not respect robots.txt.
> This can result in unsolicited messages.

> Introduce an 'email-privacy' feature which redacts e-mail addresses
> from the generated HTML content

A general reply to the topic: have you considered munging
addresses in a way that is still human readable, but obviously
obfuscated?

On some other project, I settled on HTML "&#8226;" as a replacement
for '.' for admins who enable that option.  The $USER@$NO_DOT
remains as-is for easy identification+recognition of hosts.

I also considered Unicode homographs which can look identical
to replacement characters, too; but rejected that idea since
it would cause grief for legitimate users who would not notice
the homograph when pasting into their mail client.

Anyways, here's the list of candidates I tried:

homograph∂80x24.org
homograph@80x24ͺorg
homograph@80x24·org
homograph@80x24•org
homograph＠80x24.org
homograph﹫80x24.org

https://en.wikipedia.org/wiki/Ano_Teleia#Similar_symbols
https://en.wikipedia.org/wiki/Enclosed_A

homographⒶ80x24.org
homograph@80x24 org
homograph@80x24․org
homograph@80x24ꓸorg
