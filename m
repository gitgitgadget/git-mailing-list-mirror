Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57E0E1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 16:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934271AbeAXQUS (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 11:20:18 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33550 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934264AbeAXQUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 11:20:17 -0500
Received: by mail-wm0-f45.google.com with SMTP id x4so27292052wmc.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 08:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=6P8snSpIISceHZg71jbcIBxZJzVGz1pqNDn5fI1rRws=;
        b=o195fHHKvRON+SUWQgyear5S4jIhQuMi4hJZQAdQEM2OruUR6xdwX58E01MXQ0nI8J
         pVg3/CdN3t4DgCYiA5UNAKyTOcwDoxhnIbBgiEjOhBjnOEliYrlQAfkoD9TGMhk4TfZL
         USX3S2xwpLb8MK03hL0CHBXo72eUgy8JJoI8LSQaT+Ewp9vjOQpf6otZKTJHsPPK2lOy
         sXiNEaO1Z/hfzAa+5ZKtxUeRUCzkBlcu8frc5CSs/pk1F+2rBROj9f2NvRxecqCtv0pm
         Majg3zmx9ZgKRHaLVqquUv7MEPBMJs8UZaq61WwDxyb4APF1a2V5d+82/MSiaHM54dpV
         cjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=6P8snSpIISceHZg71jbcIBxZJzVGz1pqNDn5fI1rRws=;
        b=hm4pjxQ16CTswhT5AzRJgmkSmiGaceZp/6jr4GoAYWqtCnFXvZiiDDNftlKJclzs9m
         uXwrvs5v/lNcoj7ol1OqZFiRGys5MzF3s/jXrtdwj9Mx+A3UORzGH34qc+s7Cs83YtcN
         EkuWg0s1+8ABOMitSy/attsM6Ek9kbfeshe1iaK+eV2Ln3tj6EzKReUtAtdTq7k+9ISr
         VETKdqImHBLuy16qlx0qvvSkAhQ9tdigJYC4TNKiryfyCBO7Jr0OLlomm0EmsBBvP1wC
         v8lfOI+H9g2sHYfozd6w+5XR8GrR1lrAmxIa1GIWb11VP9Z4pZaU6sCiNRE7JG47JS0E
         8Rjw==
X-Gm-Message-State: AKwxytdvOiqe2pfTIjHvT7nlMW0zf3h3PaOewQdkjfCOk4Af+QPRivBv
        mTCHacdwzPDTo8NlnmPV14g=
X-Google-Smtp-Source: AH8x224dyMM8wywaCtDo4lum525wgBxKw4KjFvf+X7pRFPwDzjfYZkgBlz3154XOpWfgFlpCoakmAQ==
X-Received: by 10.80.219.75 with SMTP id b11mr26362219edl.220.1516810816152;
        Wed, 24 Jan 2018 08:20:16 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id s8sm364357edk.94.2018.01.24.08.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 08:20:14 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andreas Krey <a.krey@gmx.de>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Speed of git branch --contains
References: <20180123203656.GA27016@inner.h.apk.li>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180123203656.GA27016@inner.h.apk.li>
Date:   Wed, 24 Jan 2018 17:20:13 +0100
Message-ID: <87607rgreq.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 23 2018, Andreas Krey jotted:

> I'm just looking at some scripts that do a 'git branch --contains $id --remote'
> for each new commit in a repo, and unfortunately each invokation already
> takes four minutes.
>
> It feels like git branch does the reachability detection separately
> for each branch potentially listed. The alternative would be to
>
> - invert the parent map to a child map,
> - use that to compute the set of commits that contain $id,
> - then use that as predicate whether to show a given branch
>   (show iff its head is in the set)
>
> That would speed things up considerably,
> but what are the chances to see that change in git?
>
> I can do that as well within the script, with the additional
> benefit that I only need to do the inversion once, but I might
> instead take a stab at git branch.

I posted something similar to the list the other day, and Derrick had a
great follow-up to that which summarized the current work on this:
https://public-inbox.org/git/87608bawoa.fsf@evledraar.gmail.com/

Junio mentioned an edge case in that thread which you may not have
thought of (I didn't). I.e. that one problem with such a mapping is that
a new branch may at any point push new history which includes your
commit as a merge, forcing you to re-compute this child map.

That can be optimized by checking whether some commits come after others
timestamp wise, but that brings us to the problem that timestamps aren't
guaranteed to be monotonically increasing (and may even be years off) by
git, which is another optimization challenge for things like --contains.
