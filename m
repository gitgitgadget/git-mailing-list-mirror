Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892261F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 01:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfHPBZ0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 21:25:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41431 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfHPBZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 21:25:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so2233075pfz.8
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 18:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ihtrZSsbHwbfcywQAChe8Qk+HxOHszeO/XukRCOIWdg=;
        b=ubufkTPHHopBakFVDKBl501m4f88Ct4WBUglQQEUDMUbfxwfLci/24JwVpLlnDoX6m
         YP48pzuAKALn3d85VFbBdP+K++FqttsSjjp6p16ktsXjFzgc7rspvfLrecrA9DMPHvw7
         5t5u60KgYWzEba7XMtm/erkFx05vkZQP79xj4C5mt+oMz0HTDBFi12aVTH4QnfHi2al+
         RAYQZoT7SyhD8X6GYsoRAzKpb2k4mHfjZb0NKC9b7yy3rBLx8VNQBP4uxVdDNd3IF3Tj
         O9QnqgXCKDNxBq9cC/5dK5URdkufouJdO1fave8j927sG23huRt3H1T7nOakf6XHgWok
         NBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ihtrZSsbHwbfcywQAChe8Qk+HxOHszeO/XukRCOIWdg=;
        b=D1q73AxSqkH7dvqMFScANy7sKAtW+1RgoupPRQAeZjxtd5+YUv7qMXFMT0Oumhj/PV
         8KFgNVVqt17s0htD7jXf1tzkXszXOV/Wj92DEguED4rDtrcGEpVWAtHmLiZQGgEVP2VW
         2NU3seCQdWyXRIdGno+FjRG2oE2izBr6GZNWq1AuV6AzSXoJlwt360XPWQjyFc7XVU/p
         5ld1QbnQ0QFjP3Cu4PnV4dbZSIknNgkn6aadUCXiTS8Ttl1NZl60vAvvYszMcKFGHeCa
         7xfiDHKsyTzrmNxxK2TeQKs++DFjwyIH7Kt6MlfIWcn9zCAaxLy5JJ9B2dXlguUHpeDZ
         GN/g==
X-Gm-Message-State: APjAAAXW+t5nwTKpCDTs7CPijEznAh2XMCcgc7v2uFxRWeUZlpqKAv6c
        f8I/yHxPDgNsx5SvOUdQLUzGyQ==
X-Google-Smtp-Source: APXvYqzqYoRTIrcSB/6PEWmRTDXjkZPWHsNIzvwouTsR0Q+oCQ4ocJt2AMkUBYChNn4owqwO2doSew==
X-Received: by 2002:a65:5202:: with SMTP id o2mr5413181pgp.29.1565918724991;
        Thu, 15 Aug 2019 18:25:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 203sm4773220pfz.107.2019.08.15.18.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 18:25:24 -0700 (PDT)
Date:   Thu, 15 Aug 2019 18:25:19 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
Message-ID: <20190816012519.GF208753@google.com>
References: <20190815023418.33407-1-emilyshaffer@google.com>
 <e6d56d97-99c9-064a-71b5-2b7eb9b71e01@gmail.com>
 <xmqqy2zu4hrq.fsf@gitster-ct.c.googlers.com>
 <20190815225231.GD208753@google.com>
 <xmqqwofe0zgd.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwofe0zgd.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 04:40:50PM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > I think a whitelist of config options to print would grow stale
> > immediately, and the options we're missing would be very likely to be
> > configs to turn on new experimental features - which is probably what we
> > most want the bugreport for.
> 
> The implementation of your "git bugreport" command comes from the
> same version of Git as such an experimental feature you want
> feedback to is shipped with, so I am not sure where your concern
> about staleness comes from.
> 
> If you really care about getting quality reports, you need to earn
> users' trust (one way of doing so would be to maintain a good "list
> of benign configuration knobs whose values help diagnosing issues"),
> and you need to make sure we obtain relevant pieces of information.
> Both of these things are something you need to actively work on.
> 
> We have trained ourselves to the point that we consider it a bug if
> you add a new command git-bugreport without adding a corresponding
> pattern in the .gitignore file.  And thanks to that discipline, we
> have been fairly good at keeping .gitignore up to date.  I do not
> see a reason why we cannot do something similar to the registry of
> configuration variables that we care about, which may be shipped as
> part of "git bugreport" command.

I think comparing this habit to the .gitignore isn't quite fair -
.gitignore tells me I forgot to add my new command binary to it, when I
run `git status` to see what I need to add to my commit with new
command.

But, I agree that it's not going to be possible to create a completely
leakproof blacklisting heuristic here. So I'll use a whitelist for the
next patchset.

 - Emily
