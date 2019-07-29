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
	by dcvr.yhbt.net (Postfix) with ESMTP id 305D51F462
	for <e@80x24.org>; Mon, 29 Jul 2019 23:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfG2Xd4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 19:33:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45303 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfG2Xd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 19:33:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so29006014pgp.12
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 16:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M1eXLblCVK0ItdB+YlaiWVZz4sII90rv19w+Hfn9f9U=;
        b=NaDkjB+GdMs453s5lOdG9besX2hsh4RsyaYfV8xIUft1rADQKG4HQ7bp9IIqWFgS8Q
         YW3Dp8C4CkKOZtw4Mre6CyE8YL6aq9/g2pWGdAjR6HdZKQZFKtxcvyVj8NRsS3g5G/Y2
         jrp/x1koo68OrNVi+Wm+BvT/aPwqBT4703pd278NRL9SrXHgZ9SaAesCF0qQaRzvbyQ8
         FaTawpsrBGUPk7jK4HkRz5IeZ40xedifZrMijJmiVi4ha0m/ymm8xMvbC8ZQzjv0hhvH
         sSMdy7qBQAMuDZab5/lzXRYQz15KupRa6Pavqvqjr5GjbVyaECSh/pLfND0exSAfUWu9
         298g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=M1eXLblCVK0ItdB+YlaiWVZz4sII90rv19w+Hfn9f9U=;
        b=uDct1rboH17X5uk5OHIE11T0osmMaqa27IlojopFWDjuQWVFxYSDQ4XMgrtnpjhxxc
         JHViNj2es/JQE67B3ZqKJxCY3Dek7J9GIFY3ycpZ8mm+Pe+vdnUAXeble0sZiwCEfjsE
         wYMJpNRlFo15uXbuKSpOmQ9zSjtTf2RQaJCQAhMaGQnmpKNKnMINz4qtDNuQ5sVkVvQv
         9DLiXQsaNAsQRdynNwLHB6SKXNemRFveBA1409m6FwVWqtfEoUkcdyWrVOzfbnnQIWCs
         Ql0OsA5uafXY4TdW9NG6Szlr8Drv+ujoXAitZ+qSgJoNt0alhXItF5SlJjtKqZ4MopYe
         YQSw==
X-Gm-Message-State: APjAAAVPsHfKexPE0rA+oME3cJp93OYc+KAVvfepdJv45GIgDpJHOyx6
        RRiUekM1trYq+6iN4pbujpvHpA==
X-Google-Smtp-Source: APXvYqz/L1NDFVjoASoz8YrB5qaz4i+LwLD2lS9kaCRZ1tNqt6nd8lzSSsfCrDTr12tJU8cx7NFPsQ==
X-Received: by 2002:a63:2148:: with SMTP id s8mr104067313pgm.336.1564443235012;
        Mon, 29 Jul 2019 16:33:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id h13sm29242635pfn.13.2019.07.29.16.33.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 16:33:54 -0700 (PDT)
Date:   Mon, 29 Jul 2019 16:33:49 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, stefanbeller@gmail.com
Subject: Re: [PATCH v2 3/4] merge: --no-verify to bypass pre-merge hook
Message-ID: <20190729233349.GH43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, stefanbeller@gmail.com
References: <xmqqbml6pgfm.fsf@gitster.mtv.corp.google.com>
 <cover.1563490164.git.steadmon@google.com>
 <2440ad35e420db868596435dea3d634e37dbe671.1563490164.git.steadmon@google.com>
 <CAN0heSqNEgFXLOTBssW6wSnqqvWDGfOU+TW7_5T2V6t+GCAm5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqNEgFXLOTBssW6wSnqqvWDGfOU+TW7_5T2V6t+GCAm5A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.29 22:02, Martin Ågren wrote:
> On Fri, 19 Jul 2019 at 00:57, Josh Steadmon <steadmon@google.com> wrote:
> > From: Michael J Gruber <git@grubix.eu>
> >
> > Analogous to commit, introduce a '--no-verify' option which bypasses the
> > pre-merge hook. The shorthand '-n' is taken by the (non-existing)
> > '--no-stat' already.
> 
> I don't understand this "(non-existing)". I realize this message is two
> years old, maybe lots older still, and I haven't dug. But at least
> *now*, "-n" seems to behave like "--no-stat", suppressing "--stat", from
> my simple testing.

Fixed in V3.
