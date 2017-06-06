Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 354A520D09
	for <e@80x24.org>; Tue,  6 Jun 2017 11:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbdFFLwr (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 07:52:47 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36223 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbdFFLwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 07:52:47 -0400
Received: by mail-pf0-f194.google.com with SMTP id y7so5597617pfd.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 04:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=G3A6aWjGGRQQsYTiNzUndDAlTyXxyncBZuF5HUUe4rA=;
        b=YNGEY0xFjjISdaBYUdY3A9V5XkXaSJK5FR8LafajJdcPQULyxMSlc1ZcH8DP6HQCrz
         l/o84eYmMA+H6e2jo39DzKsYPPxKzadPgL30FlTU/b9EGkSbays9Rzl5DnBK7rLismzR
         4FfoiEMIyDY5QA3h2LP9/zumm7Yn1UE4XFl33auW6dwl69YE5mkKID7bGcxPjos8ubH1
         Nv7qqQsIciB14DTo2frUr/QpHbx9CGO9vvViTDX4m+of+SxZPSqZMi5DUC9b9OZIBkQo
         TBbCNkelkxRpg+Un8G2+S85N+z2pk0YUpJtbB/7/6s78jpEibLQxqw3P4b5Dems9DQQD
         CIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=G3A6aWjGGRQQsYTiNzUndDAlTyXxyncBZuF5HUUe4rA=;
        b=E9DYaA9gERysdqi/LWHXlVfesog+o8tnVNtMwWuIAVO7X0yyvnNYTl5aN7hidKHicz
         OWAXSt/CZsgmgvYzv8igwQSBFEtQwXLmOGeMxMy6aFjeBAalUjBius+xvq8Vi5llQ0Oe
         ORalmddwSU1U3VPLzzpixOhugLOS8KClT/sw8HpC32Wg7rDh9yd6I8WZNhW3mUEg3ByU
         Oi60aYJANB5seSnmy5n4MIsIqLsf3Z3PBmMWJyDlZfcVDjPuCLsYh6IFwIFVep1x3e4P
         /3OUQ+SahChXcYXhPiRo4sazcTLZG2wSn30nyThBytQ3ZmmBqh07HBLZ5YBEFVo6A+MT
         OI7w==
X-Gm-Message-State: AODbwcCy4ko+P6gBSf6a7VCX2jrbqzvDnkAjG5OfS1SLVbq9nL6/dTQB
        Mt2dVbj/vlkvWw==
X-Received: by 10.99.98.6 with SMTP id w6mr10348798pgb.207.1496749966198;
        Tue, 06 Jun 2017 04:52:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:411:1ad6:6716:25ff])
        by smtp.gmail.com with ESMTPSA id j11sm66332744pgn.38.2017.06.06.04.52.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 04:52:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "David" <bouncingcats@gmail.com>,
        "Samuel Lijin" <sxlijin@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Stefan Beller" <sbeller@google.com>,
        "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: What does this output of git supposed to mean ?
References: <1496671452.4809.2.camel@gmail.com>
        <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>
        <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com>
        <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com>
        <20170606011151.qe5ycih77vqlqgme@genre.crustytoothpaste.net>
        <CAJZjrdWoK__rZVCG3vRSSEOPgxK7b_wWjpJ3YUQcLxw+J8KfGQ@mail.gmail.com>
        <xmqqvao9991r.fsf@gitster.mtv.corp.google.com>
        <CAMPXz=oorE7MQa4a_1eC-+Huf1Tf2XQFjEBcQxsOdso9BJ1S-A@mail.gmail.com>
        <D0E8FF50F1E74043AA0BD71E80C365E5@PhilipOakley>
Date:   Tue, 06 Jun 2017 20:52:44 +0900
In-Reply-To: <D0E8FF50F1E74043AA0BD71E80C365E5@PhilipOakley> (Philip Oakley's
        message of "Tue, 6 Jun 2017 12:07:21 +0100")
Message-ID: <xmqqr2yx8h9v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "David" <bouncingcats@gmail.com>
>
>> Perhaps say something like "Repository is empty." there.
>
> <bikeshed>
> I like that. I think that is a very appropriately descriptive statement.
>
> An alternative ,with slightly less textual change, could be "Waiting
> for initial commit"
> </bikeshed>

I can buy that one.  

I do not want to see "Repository is empty", as that will open us up
to criticism that we are being sloppy and technically incorrect to
cater to newbies (i.e. we will give the message if you do "checkout
--orphan", and repository is definitely not empty in that case).

"Waiting for the initial commit", or "No commits yet", can be
explained to describe the state of the current branch (not the state
of the repository), and it is correct that we do not have any commit
on the branch, and the branch is waiting for the initial commit.

