Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3120C433EF
	for <git@archiver.kernel.org>; Wed,  6 Jul 2022 18:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiGFSWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jul 2022 14:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbiGFSV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jul 2022 14:21:56 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5048625EA3
        for <git@vger.kernel.org>; Wed,  6 Jul 2022 11:21:55 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o21-20020a17090aac1500b001ef977190efso3595282pjq.7
        for <git@vger.kernel.org>; Wed, 06 Jul 2022 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QvmVDqj2lzQi6Q6LBQclK2exhTO5lWjAbJ0aF8dWpbk=;
        b=RyCpDruCMFRVnaVmpVOAH0YfDSd3m+E3V3l3h0QYIKiRBQdjn/bjubZ20GJrfxKiDi
         0GemMCU6KSqAIdPABGk0ErDD2pSKf5JdXPz45Ft23ir9e4K63DmysU2mlDsqpb/FP4DU
         ybWaY0NOH4TewGeGStSXJmURBUGYvGm+oy/WqYG9VcCCl0pdLYLoUbsnjYJpYR4768is
         LhPlt5iCFZEv1FrwYubkGMbywiGzk8+ADfbL5X3AL3X2fVlKOa4rgDBzOatW8iAEMTJ+
         q2BDjGcI0m+fp8JTuAZxny5M/7Wv4IFMIw0FuRPBLMThKEA3GkhQmidCL0HezHRnOXOq
         uaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QvmVDqj2lzQi6Q6LBQclK2exhTO5lWjAbJ0aF8dWpbk=;
        b=ZEkccnuycccAY90HKtWvbfrG5WyT0QNmW6CCv267mVNIzqOEt4lcm2SLn5ox3tuLht
         kfabsQYKEl0IvOo6YoWzm2cS/uDEDBmxexKql5IctyxR4BzZbZQuMKhlk1mEbBe5mmiY
         4HKnER/t8LPVBh1VD8N3TM4ebdKWtvrajeJrhxQ5zOiNmbOKYG0h3tI7Xts/x29/OUX4
         lspfTSl4cZcNjtVlosL0RB0d9A1+gsdXkQlQE3OhQ4/58+KtY5vsNllTtfC17+5zQJ05
         GkQmUogqibHzm7ANtvUtfSgwHD1skvHWl+5coZ7tEPclGuVpRClZ62TaZ/UosWf8wuE4
         ThZg==
X-Gm-Message-State: AJIora8hpJY5Hiu0v0VClmmBQ3w0/B1ila0PyvRl8Cvsvg7C67rrSVSB
        V9IKmxIDLc14Y7Q370takq3JPlY0Z+/Lnw==
X-Google-Smtp-Source: AGRyM1tmB9Sd9lbtE3xOWvUnNd9mMJwRZvU6vq7HQbOSceXn1RRbciWsEAj7VIXLuhAHkJLm5LfStJ4cklRV6g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:cecc:b0:16b:da4d:7e8d with SMTP
 id d12-20020a170902cecc00b0016bda4d7e8dmr21786573plg.82.1657131714658; Wed,
 06 Jul 2022 11:21:54 -0700 (PDT)
Date:   Wed, 06 Jul 2022 11:21:53 -0700
In-Reply-To: <Yr42b+MYsuw8ihgG@nand.local>
Message-Id: <kl6lfsjertj2.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com>
 <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com> <43627c05c0b997ea407c865b04994cba630297d6.1656612839.git.gitgitgadget@gmail.com>
 <Yr42b+MYsuw8ihgG@nand.local>
Subject: Re: [PATCH v6 2/5] Documentation: define protected configuration
From:   Glen Choo <chooglen@google.com>
To:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Jun 30, 2022 at 06:13:56PM +0000, Glen Choo via GitGitGadget wrote:
>> @@ -380,6 +381,18 @@ Most configuration options are respected regardless of the scope it is
>>  defined in, but some options are only respected in certain scopes. See the
>>  option's documentation for the full details.
>>
>> +Protected configuration
>> +~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +Protected configuration refers to the 'system', 'global', and 'command' scopes.
>> +For security reasons, certain options are only respected when they are
>> +specified in protected configuration, and ignored otherwise.
>> +
>> +Git treats these scopes as if they are controlled by the user or a trusted
>> +administrator. This is because an attacker who controls these scopes can do
>> +substantial harm without using Git, so it is assumed that the user's environment
>> +protects these scopes against attackers.
>> +
>
> I think this description is a good starting point, but I think I would
> have liked to see some more from the commit description make it into the
> documentation here.

Yeah, there's a bit of a tradeoff here. Glossing over some of the
details helps keep the documentation briefer and easier to understand
for the less experienced/invested, but is bound to frustrate others. I'd
appreciate any wording suggestions if you have any.

> One thing that I didn't see mentioned in either is that the list of
> protected configuration is far from exhaustive. There are dozens upon
> dozens of configuration values that Git will happily execute as a
> subprocess (core.editor, core.pager, core.alternateRefsCommand, to name
> just a few).
>
> I don't think we should try and enumerate every possible path from
> configuration to command execution. But it is worth noting in the
> documentation that the list of configuration values which are only read
> in the protected context is non-exhaustive and best-effort only.

By referencing command execution, I think you are alluding to Stolee's
Security Boundary discussion thread [1], and in particular, the "Example
Security Boundary Question: Unprotected Config and Executing Code"
section?

That section discusses the problem of arbitrary command execution based
on repository-local config, and how protected configuration might give
us a way to prevent that. That's a reasonable extension to this series,
though it seems a little premature to include allusions to command
execution, especially since I don't think we're anywhere close to a
long-term direction on what should/shouldn't be inside protected
configuration. For example, Stolee noted that, most of the command
execution options really do want per-repository customization, so if we
want to continue to support that, we'll need to use protected
configuration in a somewhat sophisticated manner (and not, e.g. only
respect command execution options in protected configuration). Perhaps
we could shelve this wording change until we've committed to such a
direction.

[1] https://lore.kernel.org/git/6af83767-576b-75c4-c778-0284344a8fe7@github.com

> Thanks,
> Taylor
