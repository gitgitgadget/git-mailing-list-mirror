Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F90BC433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 07:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C1B21556
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 07:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIGHGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:06:11 -0400
Received: from mail-gateway-shared10.cyon.net ([194.126.200.61]:41496 "EHLO
        mail-gateway-shared10.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726384AbgIGHGL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 7 Sep 2020 03:06:11 -0400
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared10.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <dev+git@drbeat.li>)
        id 1kFBE7-00066U-Ib
        for git@vger.kernel.org; Mon, 07 Sep 2020 09:06:09 +0200
Received: from [10.20.10.232] (port=8001 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.93)
        (envelope-from <dev+git@drbeat.li>)
        id 1kFBE6-003PFg-Dp; Mon, 07 Sep 2020 09:06:06 +0200
Subject: Re: [PATCH] pretty: allow to override the built-in formats
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
References: <20200905192406.74411-1-dev+git@drbeat.li>
 <20200905195218.GA892287@generichostname>
 <xmqqeene36t7.fsf@gitster.c.googlers.com>
 <8bb68268-8e4c-749e-b2e0-21b38b70c8bf@drbeat.li>
 <xmqqtuwa13gt.fsf@gitster.c.googlers.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <259819c3-4d6c-e9ed-80c9-15ffa8feb6ad@drbeat.li>
Date:   Mon, 7 Sep 2020 09:06:05 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqtuwa13gt.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-OutGoing-Spam-Status: No, score=-3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07.09.20 08:54, Junio C Hamano wrote:
> Finally, a non-built-in name to express the format specific to a
> project can already be defined and used pretty easily; e.g. the
> "pretty.kernel" format may say %h ("%s") and can be used like
> 
>     $ git show -s --pretty=kernel HEAD
> 
> with the same ease as the 'reference' format.
> 
>     $ git show -s --pretty=reference HEAD

This would work fine if there wasn't also gitk, which has a "Copy commit
reference" function. Without a common name for the format in Git and
gitk, we lose the single point of truth.

The one alternative I can see is to make the format name configurable in
gitk.
