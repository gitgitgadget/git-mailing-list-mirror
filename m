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
	by dcvr.yhbt.net (Postfix) with ESMTP id A261D1F461
	for <e@80x24.org>; Mon,  8 Jul 2019 19:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391644AbfGHTWy (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 15:22:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34723 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbfGHTWy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 15:22:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so14247400qkt.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2019 12:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GjEv3zPzjA0VtEPVairfjdbq5WzEAarWtUbhmyFdoQU=;
        b=pviQ/HWnnEmCdwSzMg93Wzzc16DpQ88yI7QRWnJE7SgesRX8ZE9lOypN333M/ZU9SV
         5rZFMry9Y3hQdEIJthnkVhIyDR210h2zQPcdIrRFUuP5QajGZlhrMzl/Yroe2iFIkT95
         5WFOJxA69vthsHjXyySCvgnp+G3BjR/5GcFswmqsnCxcnWD6iAB+vOBZOpejn4fmCI3c
         7lZ9UiOurSClDTGadEXjoGPE4o58TwFYqe/9fnR9UQMTB/xnjZrrERucP5fzh2Ev8DsY
         +tcNnNlJJUdNmVaGjxwE6kEFfLQr3QDCFaSHlxAPQgQxNYMbT+IxiwSY7uUXPcgehTYh
         UkRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GjEv3zPzjA0VtEPVairfjdbq5WzEAarWtUbhmyFdoQU=;
        b=BTWch4xoODu2hOoAHKYVmayrUFf3ZGeQQGwaIMkegLPLwaZ1utmK/EiZ+8kmovo+2n
         BExKnRi6qLaN7K8+BTHA8JSznhaa07dC9hmyOgvMldzIVF/jN7e31ctLsWvYIKBIqxoH
         569u5PouzL1RBhjmOAHmi2GF6tB0hDFk8/7u2smu0n2czoKSQvFjtRoT1CjDQaQ2JLjz
         LH3qh/5V/Frtc1yO+cu5T2wSHJVhAzlXpEidNEzyPNiikMWfaqHxJxhXeDzpsDyjBCHj
         +i+4POORGcQzW+0udj/FH5X4yhxkw2d+ykMshIhBQtpilOo9rrMShTxervSqNgeKA7lx
         jEXA==
X-Gm-Message-State: APjAAAX1vAEH9rKxM2dNgO8wMTk+x1wacwbjSH/f5Qi7BycBNizCZbFV
        PzGtXFOgNT+I3M2jzzHbH/l+nupZ
X-Google-Smtp-Source: APXvYqyvJvIDuXKoHO0cPOkxoX4oXqQnIb8axFoGbrpxqPiWaV9xhELzt/oDs59RGgvNBNMiklBNQA==
X-Received: by 2002:a05:620a:15e5:: with SMTP id p5mr11516717qkm.409.1562613772904;
        Mon, 08 Jul 2019 12:22:52 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7947:4e73:17b:b8ef? ([2001:4898:a800:1012:2a7b:4e73:17b:b8ef])
        by smtp.gmail.com with ESMTPSA id z18sm8213918qka.12.2019.07.08.12.22.51
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:22:51 -0700 (PDT)
Subject: Re: [PATCH v3 0/3] [RFC] Create 'core.featureAdoptionRate' setting to
 update config defaults
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.254.v2.git.gitgitgadget@gmail.com>
 <pull.254.v3.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <50955e76-8b61-8ffd-b8ee-3621ecbd912b@gmail.com>
Date:   Mon, 8 Jul 2019 15:22:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <pull.254.v3.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/1/2019 10:29 AM, Derrick Stolee via GitGitGadget wrote:
> Here is a second run at this RFC, which aims to create a "meta" config
> setting that automatically turns on other settings according to a user's
> willingness to trade new Git behavior or new feature risk for performance
> benefits. The new name for the setting is "core.featureAdoptionRate" and is
> an integer scale from 0 to 10. There will be multiple "categories" of
> settings, and the intention is to allow more granular levels as necessary.

(Adding people who contributed feedback to CC line.)

It seems that this "Feature Adoption Rate" idea was too simplistic, and
had several issues. Time to take a different stab at this direction, but
with these clear goals in mind:

 1. We want intermediate users to be able to take advantage of new config
    options without watching every release for new config options.

 2. The config name should match the general effect of the implied
    settings.

 3. There are orthogonal settings that may not apply beneficially to
    all repos.

With this in mind, I propose instead a set of "feature.*" config settings
that form groups of "community recommended" settings (with some caveats).
In the space below, I'll list a set of possible feature names and the
implied config options.

First, the main two categories we've discussed so far: many commits and
many files. These two feature sets are for when your repo is large in
one of these dimensions. Perhaps there are other settings to include
in these?

	feature.manyFiles:
		index.version = 4
		index.threads = true
		core.untrackedCache = true

	feature.manyCommits:
		core.commitGraph = true
		gc.writeCommitGraph = true
		(future: fetch.writeSplitCommitGraph = true)

Note: the `fetch.writeSplitCommitGraph` does not exist yet, but could
be introduced in a later release to write a new commit-graph (with --split)
on fetch.

The other category that has been discussed already is that of "experimental
features that we generally think are helpful but change behavior slightly in
some cases".

	feature.experimental:
		pack.useSparse = true
		status.aheadBehind = false
		fetch.showForcedUpdates = false
		merge.directoryRenames = true
		protocol.version = 2
		fetch.negotiationAlgorithm = skipping

We have not discussed anything like the next category, but Dscho thought
a set of configs to make pretty diffs could be a fun "meta-config" setting:

	feature.prettyDiff:
		diff.color = auto
		ui.color = auto
		diff.context = 5
		diff.colorMoved = true
		diff.colorMovedWs = allow-indentation-change
		diff.algorithm = minimal

These are just a first round of suggestions. I'm sure we would enjoy a
debate around an optimal set of diff settings.

Finally, here is a kind of feature that I could imagine being helpful
in the future, but maybe is not a good idea to pursue right now. In
some cases users use "gc.auto = 0" to prevent all user-time blocking
maintenance. This can degrade performance over time as loose objects
and pack-files accumulate. The performance could mostly be recovered
by using a multi-pack-index, but there is not current way to automatically
write the file. This would not solve the space issues that happen here.

	feature.noGC:
		gc.auto = 0
		core.multiPackIndex = true
		(future: fetch.writeMultiPackIndex = true)

What do people think about this general idea? Are there any other
feature.* settings that could be useful? Any additional settings
to add to these groups?

Thanks,
-Stolee
