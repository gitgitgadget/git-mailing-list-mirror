Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A12091F42D
	for <e@80x24.org>; Fri, 25 May 2018 18:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967587AbeEYSih (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 14:38:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53056 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967453AbeEYSig (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 14:38:36 -0400
Received: by mail-wm0-f67.google.com with SMTP id 18-v6so11174551wml.2
        for <git@vger.kernel.org>; Fri, 25 May 2018 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=10GL0RuX0LWoKEplihBYtb2gejHyLMn9BxNiPqrNnkc=;
        b=lqCOfxRhItpT4pstZ+3v99mAkY2DnjAbD7wB2/rSiqGexbPEeIvNKhGpPaxHr82yrN
         M0MoZl1dmCEsuIFpiLA3x+C/1MWTDe2VrzjPYTztbEyR0pJQ71aR78QJUb+hwu5b53RI
         64xssiwCLden8cyq/nhhnboBwIgomFqtM5IsejFPLmaqlsI5bf2qr+JzATK8rhUfamQY
         zlkyCYcp0Itm5OcxT+bAebj1ur40hg3mnw4Tlgjy0mVoUDb6QSarWh1+gu7sft9whYDM
         QCAKbMYDEoXYE3nejlizvIM5XgED3WuNgAWoBpcUDA64AqvuZTVj4Bqn4IqpSGq2mnOo
         sZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=10GL0RuX0LWoKEplihBYtb2gejHyLMn9BxNiPqrNnkc=;
        b=Ah6SECdl5vtzONu0o3ztVROdbLrekTu+nwJFLJvOt96TznvEhJOOSqpDV06rpdfTwE
         EJb2ibq1vVCrHEO9EahvKuyE/bsqP7DW5huYttth44ZRagQnK3SxAz0YiC/jz+ztwF6z
         grMxRDtvZxpa9hLEV7Nrp0YRh03cSXeScXcMJS+1xaPPmp14UpRVOJ9QT6AZH/lwHOCg
         9diQKNOf3eUmccaO3CVsx/scTglQAiv9sh0nHgfazT1PyvXC7zRoSsZ7rJUe9WZADuZb
         AJVlfiuv20X9dD6cCEvJ9Dec4CLr6mib3r5CkZ5QR178VZNeXNQV1hDNzZI3QiHeQcS0
         h0jg==
X-Gm-Message-State: ALKqPwfn1PQdJGGCe2vBGTw5xVM3/Mozmud9xDoPTOkc4t/slumn0umw
        MEK+FvdEV1MQaEsdo8sVZqplmdXR
X-Google-Smtp-Source: AB8JxZqVLVWHd4bdSL/ZvBDTYMaiGIWmXUBK9KWs+HreqHJpXKDJ7ehz+CDilBOx/k9WtX+C3k/UIg==
X-Received: by 2002:a50:aa3d:: with SMTP id o58-v6mr4075701edc.186.1527273515110;
        Fri, 25 May 2018 11:38:35 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y14-v6sm13470956ede.56.2018.05.25.11.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 11:38:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] checkout & worktree: introduce checkout.implicitRemote
References: <CAPig+cR59-OEDL7GDNZF2v7a-NOrUH2zC9EwDvuog8QLRtvKTA@mail.gmail.com>
        <20180524194704.936-1-avarab@gmail.com>
        <xmqqpo1knog0.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BjdiNF623vygUkp_1T82X5DwQiCQP9T55mATzFHuH1RQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8BjdiNF623vygUkp_1T82X5DwQiCQP9T55mATzFHuH1RQ@mail.gmail.com>
Date:   Fri, 25 May 2018 20:38:33 +0200
Message-ID: <87k1rr7f86.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 25 2018, Duy Nguyen wrote:

> On Fri, May 25, 2018 at 10:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> +Currently this is used by linkgit:git-checkout[1] when 'git checkout
>>> +<something>' will checkout the '<something>' branch on another remote,
>>> +and by linkgit:git-worktree[1] when 'git worktree add' refers to a
>>> +remote branch. This setting might be used for other checkout-like
>>> +commands or functionality in the future.
>>
>> Hmph, that is an interesting direction.  You foresee that you'll
>> have a single repository with multiple remotes to grab and share
>> objects from different people working on the same project, and use
>> multiple worktrees to work on different branches, yet you are happy
>> to declare that each worktree is to work with one particular remote?
>>
>> We'd need a per-worktree config file to make it work, I guess, or
>> a three-level checkout.$worktree_id.defaultRemote configuration
>> variable, perhaps?
>
> I still plan to revisit per-worktree config support [1] at some point
> and finish it off. Or is it decided that we don't need a generic
> mechanism and will add a new level like this for each config var that
> is per-worktree? If defaultRemote sets a precedence, then it'll be the
> way to go from now on or we'll have another mess when some config does
> "foo.$worktree.bar" while others use per-worktree config files.

What do you think about including worktree in this at this time? I'm not
very familiar with it and just included it because I worked my way
backwards from the DWIM function, but I could exclude it if you think
it's too much trouble, i.e. if you'd like to hold out for some facility
like the per-worktree config Junio mentioned.
