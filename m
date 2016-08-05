Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295101F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbcHFUmx (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:42:53 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:17806 "EHLO bsmtp5.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbcHFUmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:42:52 -0400
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 3s5hGl6SrQz5vFj
	for <git@vger.kernel.org>; Sat,  6 Aug 2016 00:26:07 +0200 (CEST)
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3s5hGh4Lgcz5tl9;
	Sat,  6 Aug 2016 00:26:04 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id A61415062;
	Sat,  6 Aug 2016 00:26:03 +0200 (CEST)
Cc:	Git Mailing List <git@vger.kernel.org>
To:	Michael Haggerty <mhagger@alum.mit.edu>
From:	Johannes Sixt <j6t@kdbg.org>
Subject: Forward declaration of enum iterator_selection?
Message-ID: <933f540f-7752-cfce-5785-b67728fea987@kdbg.org>
Date:	Sat, 6 Aug 2016 00:26:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When refs.c is being compiled, the only mention of enum 
iterator_selection is in this piece of code pulled in from 
refs-internal.h (have a look at the preprocessed code):

typedef enum iterator_selection ref_iterator_select_fn(
		struct ref_iterator *iter0, struct ref_iterator *iter1,
		void *cb_data);

This looks like a forward declarations of an enumeration type name, 
something that I thought is illegal in C. Am I wrong? (That may well be 
the case, my C-foo is quite rusty.)

My compiler does not complain (it's gcc 4.8), but I thought I mention it 
before someone with a pickier compiler stumbles over it...

-- Hannes
