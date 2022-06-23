Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864D5C433EF
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 19:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiFWTRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiFWTRV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 15:17:21 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69FE81519
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 11:21:49 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id cp20-20020a17090afb9400b001ec75748019so153036pjb.6
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 11:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Wautne8xVeFInyr3b9Lx3uKB8As59FhQ9ARdHCfx1mA=;
        b=aky+mLZIg7vYUIlbnwR+sbt7G/DpoTE+pJxA4HfMDWNXIm4PdQTJfpB8CNbfFe+X8i
         cKlq3xz+4nWI/6IlwFidqvsEhMoxEbYj/OILgH/GisNnihmYG/dBd7Ygu7trt86L6qKx
         2qVIfc5X0K2Ydairr7X0vrf2I0xSLR+/tHciRiuzs4BUIbGocpTNEILJc4JXqdDRNDUB
         IwEDho3k2tdn+av8HsWFGBesYSDGVx6gATH4oYpwO+xk7Mym/H3qUxP/nHathqE8zRy/
         MxWbgiacP0prm+YKsorSdwzBNghH3Zdjt0mtagD28l0PplSM1y2RlQ/MakQY4iYeX05N
         ikXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Wautne8xVeFInyr3b9Lx3uKB8As59FhQ9ARdHCfx1mA=;
        b=mwddb1LwPT3juD6Ri2XZCZm1/Tq0rZvQhjQSAun5YJzugMTS7TTLh680Vemx0l6eV4
         3D4kHrd7RM9pt+EQLSnuhj9lwrHFMkuR8kWVWO6cZHwSciUzEaqKxdAQISLKVNj3G9u5
         S5VJ2srtfmmTw7KP08n2Hg0YA7kVtX4iBXrC5q5NumC5DTaWMWlrZ1uWLOAkewyw5/ag
         b0zr2vWrU6f4DTA5JxKHfxIrUkelGIj7aQlNh6Pc76T0ZxlxIxlBGBNPlXpyyMJAamcG
         0t9Fnd+2tPWsePYMNjBQmUNPkS5+a4CutvLFEOG7LAR3XtKtvBSiQO0XFS+TuSFXancV
         5LpA==
X-Gm-Message-State: AJIora9Y4uH/xRuxN3808VaMzsgslrxpck12x7twN2DszGqSK8Q7t9T3
        95POkNvV3T8StrR3VwGoWChc0ANseUypog==
X-Google-Smtp-Source: AGRyM1sSAz59oxtf39kd7eK4Qbf4c0ij/I3E4C9t9W+Mq/zrh6ZX98VUoj8gUsiZ2xV170JYWJLOhCFeAc3ZYA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:6b82:0:b0:40d:6a2a:c795 with SMTP id
 g124-20020a636b82000000b0040d6a2ac795mr2007695pgc.111.1656008509218; Thu, 23
 Jun 2022 11:21:49 -0700 (PDT)
Date:   Thu, 23 Jun 2022 11:21:40 -0700
In-Reply-To: <20220622215848.3733308-1-jonathantanmy@google.com>
Message-Id: <kl6lo7yji6kr.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220622215848.3733308-1-jonathantanmy@google.com>
Subject: Re: [PATCH v4 2/5] Documentation: define protected configuration
From:   Glen Choo <chooglen@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> From: Glen Choo <chooglen@google.com>
>> 
>> For security reasons, there are config variables that are only trusted
>> when they are specified in extra-trustworthy configuration scopes, which
>
> Probably better to delete "extra-trustworthy", or at least "extra-" -
> it's better to explain why and how they're trustworthy, which you have
> already done in the commit message.

Hm, do you find it superfluous, misleading or something else entirely?

The use of "extra-" was quite intentional. I'm afraid that if we
describe protected config as "trustworthy", we insinuate that
local/worktree config is "untrustworthy" (but of course this isn't
always true, Git usually uses repo config.)

>> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
>> index 5e4c95f2423..2b4334faec9 100644
>> --- a/Documentation/git-config.txt
>> +++ b/Documentation/git-config.txt
>
> [snip]
>
>> +Protected config refers to the 'system', 'global', and 'command' scopes. Git
>> +considers these scopes to be especially trustworthy because they are likely
>> +to be controlled by the user or a trusted administrator. An attacker who
>> +controls these scopes can do substantial harm without using Git, so it is
>> +assumed that the user's environment protects these scopes against attackers.
>> +
>> +For security reasons, certain options are only respected when they are
>> +specified in protected config, and ignored otherwise.
>
> Also "especially trustworthy" here.

