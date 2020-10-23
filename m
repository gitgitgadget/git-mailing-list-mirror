Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF85CC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F48621527
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 14:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465243AbgJWOoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 10:44:54 -0400
Received: from dovecot.mat.umk.pl ([158.75.2.81]:54019 "EHLO
        poczta1.mat.umk.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375361AbgJWOoy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 10:44:54 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Oct 2020 10:44:53 EDT
Received: from dovecot.mat.umk.pl (localhost.localdomain [127.0.0.1])
        by poczta1.mat.umk.pl (Postfix) with ESMTP id 9CDBD9568BA;
        Fri, 23 Oct 2020 16:39:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mat.umk.pl
Received: from poczta1.mat.umk.pl ([127.0.0.1])
        by dovecot.mat.umk.pl (poczta1.mat.umk.pl [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id xHV1ZihGF5p6; Fri, 23 Oct 2020 16:39:31 +0200 (CEST)
Received: from [192.168.0.4] (host-89-229-7-83.dynamic.mm.pl [89.229.7.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jnareb)
        by poczta1.mat.umk.pl (Postfix) with ESMTPSA id C057B9568EA;
        Fri, 23 Oct 2020 16:39:30 +0200 (CEST)
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: ak/corrected-commit-date, was Re: What's cooking in git.git (Oct
 2020, #03; Mon, 19)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqr1put77h.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <685afed6-f01f-5d22-80d4-00fdc11caf0a@gmail.com>
Date:   Fri, 23 Oct 2020 16:39:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <xmqqr1put77h.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19.10.2020 at 20:13, Junio C Hamano wrote:

> * ak/corrected-commit-date (2020-10-08) 10 commits
>   - doc: add corrected commit date info
>   - commit-reach: use corrected commit dates in paint_down_to_common()
>   - commit-graph: use generation v2 only if entire chain does
>   - commit-graph: implement generation data chunk
>   - commit-graph: implement corrected commit date
>   - commit-graph: add a slab to store topological levels
>   - commit-graph: return 64-bit generation number
>   - commit-graph: consolidate fill_commit_graph_info
>   - revision: parse parent in indegree_walk_step()
>   - commit-graph: fix regression when computing Bloom filters
> 
>   The commit-graph learned to use corrected commit dates instead of
>   the generation number to help topological revision traversal.
> 
>   How ready is this?

I am reviewing this patch series; it looks good, in a few places 
explanation in the commit message needs improvement.

I think we could in patch 07/10 get a better performance for GDOV 
(overflow chunk for generation numbers) writing with an alternate 
approach, but that might wait for subsequent patch series.

Best,
-- 
Jakub Narębski
