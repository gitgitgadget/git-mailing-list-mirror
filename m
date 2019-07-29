Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980C61F462
	for <e@80x24.org>; Mon, 29 Jul 2019 23:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfG2Xn0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 19:43:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46502 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbfG2XnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 19:43:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id k189so9989312pgk.13
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 16:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FJpTLCwexYHRWK01cAECdMJYywrDtCuMU3W8/0K0fhg=;
        b=GLbPI0rHrRlcGAk2b0qmRV1qG96pk2wUVB1RIjUlVQR87fRPlYzNqvHQSJzyWBVjZP
         gwGyl9n2ALGmhqwt3zlGYklJ2MDSGua+fQLSorD2fLVHuIhYPdvTd6lkMvnGO8Hl4tCN
         wKp42eE7il1QFBkqISgsah9epbMLSbOVBWGSPiEafuJup0sTVaPvDZXQmYeyCTEdzaIF
         JYZQxiokH2OoOH/qNcF0e0cXj5zvIUqssKAvu39irj5yO4nPDEoCyen2dX47bKkfh0/M
         amFbOVpE/ECC4Kz2VTB/sNQPQchYHqUZpsb4qD7XYUbDGbkDCcN8zoOpTwYoXg2AyWiG
         YSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FJpTLCwexYHRWK01cAECdMJYywrDtCuMU3W8/0K0fhg=;
        b=h3d+CtnmOle1BXV2sqq6gx9Vbvd04aHuUKPj7uoFRBfBKPZhPscSDG6VL817tJpfIX
         w4Ew/SaBSCWKYNxggFWhakLYnBfyKyzEk1MpTY9mP6eO5zqufgrWWtTkR5fMZ8fLJpSy
         9NNUx8wulfQ8HJ69+8TGkKXZlTglvupzzJUPFmoMYslBPvWoWZRD34vQHleI9KP2GYb1
         0RAIQ7Ad+8T53p4aK5k5LkzqCAf0kHlrV2cUFbVUZKEIbs0c86BlorduG4c/zqKsdJil
         NS/x8b6Nb5Mg3O7RUIXMfWbrxReyixI1qhLI98HOGCmggP6h34FmuPNTXcdfPXXBxFpZ
         lcmg==
X-Gm-Message-State: APjAAAXOo8DavilaR+G4tgZhnHU3p6IfdvzakM1WIaXTFuLrD1h6XB9b
        5EowkER5QmWzInFf5d95pnj8bQ==
X-Google-Smtp-Source: APXvYqwLjAjZKwd4QloRCBYKOaBr3o4NUPUPEX7A5FaRwI4GA2yi2JiRAmmvvSGONZ3QorgXcp4AOQ==
X-Received: by 2002:a63:5945:: with SMTP id j5mr105874274pgm.452.1564443804557;
        Mon, 29 Jul 2019 16:43:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id k25sm52159217pgt.53.2019.07.29.16.43.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 16:43:23 -0700 (PDT)
Date:   Mon, 29 Jul 2019 16:43:19 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, stefanbeller@gmail.com
Subject: Re: [PATCH v2 4/4] t7503: add tests for pre-merge-hook
Message-ID: <20190729234319.GJ43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, stefanbeller@gmail.com
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com>
 <cover.1563490164.git.steadmon@google.com>
 <69dc3696e715f9be9e545e0142244e16bdd489cc.1563490164.git.steadmon@google.com>
 <CAN0heSoU7XUN8GOFzzBrLG0RbY65hhYUn_-_Ax1DfFsNZ64hpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSoU7XUN8GOFzzBrLG0RbY65hhYUn_-_Ax1DfFsNZ64hpA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.29 22:04, Martin Ågren wrote:
> On Fri, 19 Jul 2019 at 00:57, Josh Steadmon <steadmon@google.com> wrote:
> > +test_expect_success '--no-verify with succeeding hook (merge)' '
> > +
> > +       git checkout side &&
> > +       git merge --no-verify -m "merge master" master &&
> > +       git checkout master
> > +
> > +'
> 
> This test doesn't even try to verify that the hook was actually ignored.
> That left me puzzled for a while...
> 
> > +test_expect_success '--no-verify with failing hook (merge)' '
> > +
> > +       git checkout side &&
> > +       git merge --no-verify -m "merge master" master &&
> > +       git checkout master
> > +
> > +'
> 
> ... but this would then (most likely) fail, so we would notice
> something's wrong.
> 
> This script seems to me like if it passes 100%, we can be fairly sure
> we're ok, but if some individual test fails, we shouldn't be surprised
> if its oneline description is a bit off compared to the bug. Similarly,
> quite a few tests could pass, despite their oneline description inducing
> the thought of "but surely, if /that/ were the problem, /those/ tests
> would fail".
> 
> Anyway, I realize this is just following the existing approach. I guess
> you could argue it has served us well for a long time.
> 
> I would probably prefer seeing the various hunks in this patch being
> squashed into the relevant commits (1/4 vs 3/4) to make those patches
> more self-describing.

Will squash these as you said in V3. Will also think about whether
another test approach would make more sense here.
