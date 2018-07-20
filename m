Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E6E21F597
	for <e@80x24.org>; Fri, 20 Jul 2018 21:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbeGTWcn (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 18:32:43 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:38008 "EHLO
        mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbeGTWcn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 18:32:43 -0400
Received: by mail-vk0-f48.google.com with SMTP id b77-v6so6723984vkb.5
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 14:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kE+uHXsog6HzCPAvYqkrzd/Sebc+0w2wVuN7jjk552U=;
        b=oLFrkuAifEiJYLZIW3aEinu8xtHljm89106PKCn/Ywa5tXsXqHPiGWL78RL9xKSybh
         lquqFe93SrjhMV3mJJuB5yUaTviM6CcdqAcw43X7j44HuaAO0sm5azCNFX0oFDrvCTZC
         QR9oXg2KRNuK0YXyIIEu5on00qum8Sj57dgQEqbJb1OC0Qicc4RuI+Fa2d302omvcMUY
         yTdA0baB+7OyRdZ87bHqCZcpORlEUpthThQ5XgxSweEXB4gpqUvWI3hgl63JH8RElWxY
         7Fppe8jLD3lc7OvHsiCn5MqDfDn/DbD+4STdHZ4W3hNS40rkYVQo1QzQTxAwTNFXzVdm
         6KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kE+uHXsog6HzCPAvYqkrzd/Sebc+0w2wVuN7jjk552U=;
        b=VqJSAvow6nM8l1egET0kW956Zi9/iIQRL3bGmEJV8vtok3Z9xL3u5wAD9qd5zlZYOx
         3fO3NKzC+H9iV2GQ3/CvLKVfTSyAWZA3w2ztw+j2z3uMV6if1ZdCXXgar9CWVEm+j4jm
         rEwyWYcotUZxzfFrW74YJC15c/1KAhNGNtCt34sbwwB3JHJMi65nVHkdkq9rNL76FXLx
         6IFI6Yw2yziGgQnbWBQIlUjqJAQS2Atu4WAjFZzLuCGTzLiTCAMzm+vUrMPr/bAmlrnH
         bqPgavAKLSLd5hmmSaqbu0E6NQ1aWYuFgg1xQ8y9vK/+Wxg8Yn60nmIvTGmc60Y3SfTM
         E7Sg==
X-Gm-Message-State: AOUpUlFk53+tG10gUKl4EhThDdE51lJ4iNlwv46w0I8ffo0Yw8q5GA+K
        /gFxCmFAvdUAglC0lQaqLPuNOKI6dwIWn0v9qBQ=
X-Google-Smtp-Source: AAOMgpdmXlG+LTMCpDrXRqTQpl1uanVpRFfBMixL5dzR/9eGVxG3iHhrdmlfXZdSOxPNYvXUMowZdwYzfx+uJDLlOZE=
X-Received: by 2002:a1f:207:: with SMTP id 7-v6mr2416999vkc.0.1532122955750;
 Fri, 20 Jul 2018 14:42:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 14:42:35
 -0700 (PDT)
In-Reply-To: <xmqqsh4da9wd.fsf@gitster-ct.c.googlers.com>
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <CABPp-BF+Vx8YT2KAJQ+szbkYExv-_o5E-ZkywgvzsHWR0QvVEg@mail.gmail.com> <xmqqsh4da9wd.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jul 2018 14:42:35 -0700
Message-ID: <CABPp-BE_OHxMqmhJ8BisG6HFpGQjsPJ1AE4G9m5bpJWznkq-1Q@mail.gmail.com>
Subject: Re: [BUG] merge-recursive overly aggressive when skipping updating
 the working tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 2:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> But that brings up another interesting question.  What if a merge
>> *does* modify a file for which you have skip-worktree set?
>> Previously, it'd clear the bit and write the file to the working tree,
>> but that was by no means an explicit decision;
>
> At least in my mind, the "skip worktree" aka sparse checkout has
> always been "best effort" in that if Git needs to materialize a
> working tree file in order to carry out some operation (e.g. a merge
> needs conflict resolution, hence we need to give a working tree file
> with conflict markers to the end user) Git is free to do so.
>
> Isn't that what happens currently?

Ah, okay, that's helpful.  So, if there are conflicts, it should be
free to clear the skip_worktree flag.  Since merge-recursive calls
add_cacheinfo() for all entries it needs to update, which deletes the
old cache entry and just makes new ones, we get that for free.

And conversely, if a file-level merge succeeds without conflicts then
it clearly doesn't "need to materialize a working tree file", so it
should NOT clear the skip_worktree flag for that path.
(Unfortunately, that means we have to work around add_cacheinfo() for
these cases.)
