Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08CD620951
	for <e@80x24.org>; Fri, 17 Mar 2017 19:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbdCQTST (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 15:18:19 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34861 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbdCQTSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 15:18:16 -0400
Received: by mail-pg0-f43.google.com with SMTP id b129so47694370pgc.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IkYuUNUp3WEDGL40m6iesc6RS1/aoF4GK55DRzuY51o=;
        b=AIX4LLJwklfpT4bFr/yO0WyxWBGsmtrjs5o9eVG0mDRrUX34gbxeINyohQ6wELjb4i
         hT5Y2j1IA1gK9TZzYPkaT23AKT9+2OO6ehwFw4Du2JUO1qgqx68XPN+SYb5Dgn7RFTZc
         7DHRuLKxtwPxAVntQQGeC1PzO6RF8xfoHZwFsY53bDLq3msVDgQotn3bofTfG/DVqevZ
         V2tSG+qrOlVPoHytfHqDs5zAlWV/HjM4ct3JHJ9C9TQm5J3DAFG0sKkz1DGKeWmHIfMi
         kbonTDZR63vm8AkOYKZyWFm+5oN/zMY4opIcMcUI7CGIv3aFJhp8XTL45M1Wh3xcmCvo
         bk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IkYuUNUp3WEDGL40m6iesc6RS1/aoF4GK55DRzuY51o=;
        b=UWkSW/DszYwzLEoFr5vrhqVZJDqrNwSF2NAr5Supq4QVXKEiU8uxEb3WKqW+WvCtFH
         f723Be1J05gfhEH+t8K7DB7w30C2FxJseBPCkhg32y9AhZQLbnBWJorBSEDqtWhKGRp5
         cPaeloO4YA5YTf1Ezj+sXgfBDOtHPOAaE2kGWUNHPJJOgifimycNomGyvV/3JYyVrFHC
         k9xNaJ8C5pDoRJTphorszDDyDc/NgOwZ+nMaaIX7TFSTW9gr4tb2w2KSgwU6uZ2O3rL6
         mp+9TK/mNEj2FUJIYwirRFZccfqD1y5/wsKAy+J8rTzK5yo4mcRo4QAmjqvlsrLhBbNE
         8XXw==
X-Gm-Message-State: AFeK/H2nSlX/f4PVJhKEiuDqx8H9FBo4OIfJj7FzC52YDIfz5NNSVn7mjhKD+Ewp7D495qprHx+Tz2n5IFwiz5p2
X-Received: by 10.99.140.69 with SMTP id q5mr17493642pgn.179.1489777840143;
 Fri, 17 Mar 2017 12:10:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Fri, 17 Mar 2017 12:10:39 -0700 (PDT)
In-Reply-To: <20170317190856.GC110341@google.com>
References: <20170314221100.24856-1-bmwill@google.com> <20170317172257.4690-1-bmwill@google.com>
 <20170317172257.4690-3-bmwill@google.com> <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
 <20170317190856.GC110341@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 17 Mar 2017 12:10:39 -0700
Message-ID: <CAGZ79kaTNVZBZg5jiVzAKdu96pENcRJmvZ1WR37TP2MXLR-nUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] setup: allow for prefix to be passed to git commands
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 12:08 PM, Brandon Williams <bmwill@google.com> wrote:
> On 03/17, Stefan Beller wrote:
>> >         prefix = setup_git_directory_gently_1(nongit_ok);
>> > +       env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
>> > +
>> > +       if (env_prefix)
>> > +               prefix = env_prefix;
>> > +
>> >         if (prefix)
>> >                 setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
>>
>> so we load that GIT_TOPLEVEL_PREFIX_ENVIRONMENT prefix
>> first, such that we essentially copy it into GIT_PREFIX_ENVIRONMENT,
>> such that e.g. aliased commands will know about the superprefix, too.
>
> I don't follow, this doesn't have anything to do with super-prefix.
>

s/superprefix/prefix as passed in via GIT_TOPLEVEL_PREFIX_ENVIRONMENT/

sorry for the confusion.
