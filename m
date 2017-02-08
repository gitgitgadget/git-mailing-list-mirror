Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8D61FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 18:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdBHSSK (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 13:18:10 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34633 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdBHSSH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 13:18:07 -0500
Received: by mail-pg0-f68.google.com with SMTP id v184so15809518pgv.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=WORbJvt3IWIIULzNJ9JkcjUZC4horCORUpcV4/egQ8w=;
        b=KQ4ulni9Z3Te0JXJvkhBk6L2vf7ND8idNZuHSU4qvzcD9PNSfaGede9kCp+eD4aGKC
         +/iPDV+ZVM5raiCAhyvGAeru4IAlAcKADVMUYaCEZ46hRwpIWZZzNTiT3GvdpxO2S7+4
         +4rH4kjqQx2+1iJmuBbhd+Kd5wXc/OHf9PBfYbDpFoiKJ17cu0WLabyaq6ptt1evbMtY
         OFYSBG31mCd6/UzwrnV3/Qm9CLD2r0UvQyaoIBRqXCuu4DxnedBv6gFMGSClsMzE5KNQ
         ibf1EOBr6b2r4n1z5GNKWwuvxsuffvHC06sntxBGYPUd0aS+CCKXbXpmTdW71pXpjgP/
         ypSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WORbJvt3IWIIULzNJ9JkcjUZC4horCORUpcV4/egQ8w=;
        b=g6mPoPGbhke5JQCo/mu4ah2GYzTK3VpJFtivZf1laG/K0I17k94IKXoDT6pbp1dLFg
         0IVsjNjXq7DKRucQI96JN1PxH4qmPEK0Y3+mRX8RTAU/3oufdL3ZHae60J6vm/jwBpuR
         Glj3wktuywL9T5XiMREAFU74zhxIEmsxUSjpwbPyN1eamcvYEUrNW2063a6fseudLoYC
         hC6RCmx0PtCP5AEcKnYQRxODugvd14hr2P1PodIo8CB9artfiRluQfYXx4awdwY8R9dF
         pL/z6ftX6YkbXFC/GD0ZbMA1q7OLS/xF6y3jTgQJ7DpGEpS6fdV/LsBgPSERa5/M9b5p
         KKtQ==
X-Gm-Message-State: AIkVDXK+1TyXZVzCSu6Lk8chj3UJPARoO7b9CyECzeADHQ7RPU762vxwUFOCeXDnfDqPGQ==
X-Received: by 10.98.14.84 with SMTP id w81mr27864289pfi.168.1486577887005;
        Wed, 08 Feb 2017 10:18:07 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id 64sm22090896pfz.48.2017.02.08.10.18.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 10:18:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH RFC 0/2] Kill manual ref parsing code in worktree.c
References: <20170208113144.8201-1-pclouds@gmail.com>
Date:   Wed, 08 Feb 2017 10:18:05 -0800
In-Reply-To: <20170208113144.8201-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Wed, 8 Feb 2017 18:31:42 +0700")
Message-ID: <xmqqlgtgwnqa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> A hundred years ago I added this code because a "standalone" ref
> parsing code was not available from refs.c and the file was going through
> some heavy changes that refactoring its ref parsing code out was not
> an option. I promised to kill this parse_ref() eventually. I'm
> fulfilling it today (or soon).

;-)  

Thanks.  And thanks for looping Michael in.  I'd appreciate his
input in this area.

> I would really like to you double check the approach I'm using here
> (using submodule interface for accessing refs from another worktree)
> since that may be the way forward to fix the "gc losing objects" in
> multi worktrees. I've given it lots of thoughts in the last 24 hours.
> Still can't find any fundamental flaw...

I see that you posted a separate message outlining the idea
yesterday and I didn't see any response (and I was sick and lacked
energy to think it through); I think the basic approach to use "an
API to bring set of refs hidden from your normal view" is sensible.
Except for the unfortunate naming of the interface that makes it
sound as if it is only to access submodules, but that is where the
feature original came from, so let's not complain too loudly ;-)

> Nguyễn Thái Ngọc Duy (2):
>   refs.c: add resolve_ref_submodule()
>   worktree.c: use submodule interface to access refs from another worktree
>
>  branch.c   |  3 +-
>  refs.c     | 20 +++++++++----
>  refs.h     |  3 ++
>  worktree.c | 99 +++++++++++++++-----------------------------------------------
>  worktree.h |  2 +-
>  5 files changed, 44 insertions(+), 83 deletions(-)
