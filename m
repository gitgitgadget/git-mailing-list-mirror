Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CFFF1F404
	for <e@80x24.org>; Wed, 20 Dec 2017 20:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755989AbdLTU7r (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 15:59:47 -0500
Received: from mail-pl0-f49.google.com ([209.85.160.49]:45445 "EHLO
        mail-pl0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755637AbdLTU7q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 15:59:46 -0500
Received: by mail-pl0-f49.google.com with SMTP id o2so9709879plk.12
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 12:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=edto1bK3JBo5kUsWuoYFXPMfXM5inOQoZxpbs5x1juY=;
        b=tbsXDNhGb7ZCan2f2eLDM5sMBBD6CrgoDsC7cyj5QE5hFRSWUWZLQgdzTwcIWBHXln
         QnwGRm9BxFv33SfvZ5Hsql4lj/0mDIKBk55oZdUyuz4rlqyMd/mHbhAvd0huxhRI/sl0
         Z5pN9W4yFwdcqpYcIgFrtkrJEJb6ILd9Rip6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=edto1bK3JBo5kUsWuoYFXPMfXM5inOQoZxpbs5x1juY=;
        b=CRRXQYAyiPMnrcQGt4DCa++DdauqXPeLTg6FEtDnzEEMMUdllf72AmJSYMjc9kjA2L
         hj+kJ5gHzMz2Fwg70xsizwPZJABXhDEGHtDh6smfs34jBMc8+CuSj4GO5kFViBRqJb+C
         WhFqyLZD/Jk+HLIGakip5hXriGDk3ydfLsOs4wUYv8ecCTLV3KYuHjEsCuYZorOqWkoW
         6Ew5J3NK8jLoP2hL5DCmv3coMIBflwD5iGT7qmL5e7WdU0HeMcyUWKDoXO4V+2ukltrQ
         Y8ER72m/tsTJNxMadpCICzdqSx46Zg15Aju/rHXVYRLBgVblGi5vHHk+SNUAQ6p5+XZl
         KzFQ==
X-Gm-Message-State: AKGB3mJV2V0CUdOhQvbI3UQcCn4Gpix1o6DB16shmAFG2ZmVpcJ3naak
        SGh9K+RqXqcAp8dn67EU5ek6yU1oHEA=
X-Google-Smtp-Source: ACJfBouu2slYqkM99Ukhh0uyQ+ILPQ5SaQTNJeR4ZD0t+AEfoIpyjRlrtQP+VQSVCun4zDs3qsKASw==
X-Received: by 10.84.246.140 with SMTP id m12mr8226786pll.74.1513803585648;
        Wed, 20 Dec 2017 12:59:45 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-vrrp2.corp.dropbox.com. [205.189.0.162])
        by smtp.gmail.com with ESMTPSA id c191sm37412525pfg.24.2017.12.20.12.59.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Dec 2017 12:59:45 -0800 (PST)
Date:   Wed, 20 Dec 2017 12:59:31 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
X-X-Sender: alexmv@alexmv-linux
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 2/6] fsmonitor: Add dir.h include, for
 untracked_cache_invalidate_path
In-Reply-To: <xmqqtvwmv5fl.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.10.1712201108190.10810@alexmv-linux>
References: <20171219002858.22214-1-alexmv@dropbox.com> <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com> <c8cf261d9d620d8123e8bfa5aa952fa55685a8db.1513642743.git.alexmv@dropbox.com> <xmqqtvwmv5fl.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 Dec 2017, Junio C Hamano wrote:
> Alex Vandiver <alexmv@dropbox.com> writes:
> 
> > Subject: Re: [PATCH 2/6] fsmonitor: Add dir.h include, for untracked_cache_invalidate_path
> 
> Perhaps
> 
> "Subject: fsmonitor.h: include dir.h"

Certainly more concise.

> But I am not sure if this is a right direction to go in.  If a .C
> user of fsmonitor needs (does not need) things from dir.h, that file
> can (does not need to) include dir.h itself.

Hm; I was patterning based on existing .h files, which don't seem shy
about pulling in other .h files.

> I think this header does excessive "static inline" as premature
> optimization, so a better "fix" to your perceived problem may be to
> make them not "static inline".

Yeah, quite possibly.  Ben, do you recall your rationale for inlining
them in 6a6da08f6 ("fsmonitor: teach git to optionally utilize a file
system monitor to speed up detecting new or changed files.",
2017-09-22) ?

 - Alex
