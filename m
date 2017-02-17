Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A819D201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935044AbdBQWSw (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:18:52 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34528 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934963AbdBQWSI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:18:08 -0500
Received: by mail-pg0-f66.google.com with SMTP id v184so5895601pgv.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DZhnHXDBa7DQj/EA9+6xgd7EthqU4zBSSluvtfJgFAM=;
        b=SOXkVjGXigPbm7cwxjTYeZnoeIXUTSwbKE8YTmavYh6DQ4hrOQhZArNaU9kBMeuI5o
         wwmQnWploRPIynu5/WoXII8aDlF17KSTEl9RXy4sUkF/REUR+/vxNgyZ0PvvFBfWtdSb
         lnmKYkiIys4RKDM5+R4xCoReXLt0r5rVTysQuUMUUIWomRxb7sexv1msiLuRsgxFut5f
         a45pZEVppc47VXXKt6t7ts2uGtXmPxrpF8h4+9qGK7FL03PqKEpR43WITe+JgFKd09VD
         FGy3QFy82KiQP/3cOPSLIQDCRcjej3ViQ7sjM8Sfs1RrLRVATD/Sls542qGYD289QXbC
         wWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DZhnHXDBa7DQj/EA9+6xgd7EthqU4zBSSluvtfJgFAM=;
        b=eVBXIIDM31YVjrrN6atTMGTNkyiW3yo84hnHZtaT7/Bu8aUD+7RGN5ZGZfbtFhnBsl
         OzAh5QgBDUA11lGiinjxcCqPGrBzAHsWZtzvrS8zj4N0sXsmm/7hDMvYyHy4VwOZnIGD
         q+pkyvpK35zcERWREYJoPLgN6WJRkJeDA6I4TX6xj/u6TbstgWTmwnSGh2CrI48MTAg1
         wNmG/BNiYZI0W/Rx45NNszvl+ig+EYm60RmZJA4OXYrRNwg1kSBgM2SciBl1M2wfwXsP
         bJGJa0QxmU2f/Qb9eigdCA6KyeMr7oX/j/KHAKPXp7HJCs6ijLPfvTb/KnkOc7EvHQXn
         v3DQ==
X-Gm-Message-State: AMke39mAAKm4TWVQN/mn2gEAqdktkAjmSPMXdfYvGfnqsmLZRzg+dh4VxKux5fEVe9tVOA==
X-Received: by 10.84.238.1 with SMTP id u1mr14466647plk.174.1487369887886;
        Fri, 17 Feb 2017 14:18:07 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id l25sm21366330pfb.24.2017.02.17.14.18.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 14:18:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rename_ref: replace empty deletion message in HEAD's log
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
        <20170217035800.13214-1-kyle@kyleam.com>
        <20170217035800.13214-4-kyle@kyleam.com>
        <20170217083112.vn7m4udsopmlvnn5@sigill.intra.peff.net>
        <xmqqk28ou2o1.fsf@gitster.mtv.corp.google.com>
        <20170217194350.prhp5joh33cbvwsd@sigill.intra.peff.net>
        <20170217195549.z6uyy7hbbhj5avh7@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 14:18:06 -0800
In-Reply-To: <20170217195549.z6uyy7hbbhj5avh7@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 17 Feb 2017 14:55:49 -0500")
Message-ID: <xmqqino8qx5t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Thinking on it more, we probably _do_ want two entries. Because the
> operations are not atomic, it's possible that we may end up in a
> half-way state after the first entry is written. And when debugging such
> a case, I'd much rather see the first half of the operation logged than
> nothing at all.

Yes, that sounds right.
