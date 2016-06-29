Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB9F20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 18:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbcF2Sku (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 14:40:50 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:36428 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbcF2Sku (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 14:40:50 -0400
X-Greylist: delayed 631 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jun 2016 14:40:49 EDT
Received: from [91.113.179.170] (helo=[192.168.92.22])
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim 4.84)
	(envelope-from <marc.strapetz@syntevo.com>)
	id 1bIKFP-0001GD-PW
	for git@vger.kernel.org; Wed, 29 Jun 2016 20:30:03 +0200
From:	Marc Strapetz <marc.strapetz@syntevo.com>
Subject: topological index field for commit objects
To:	git@vger.kernel.org
Message-ID: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
Date:	Wed, 29 Jun 2016 20:31:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is no RFE but rather recurring thoughts whenever I'm working with 
commit graphs: a topological index attribute for commit objects would be 
incredible useful. By "topological index" I mean a simple integer for 
which following condition holds true:

if commit C is part of the history of commit D,
   then C's topological index is smaller than D's index

This would allow topological sorting of commits (e.g. in queues) on the 
fly and quickly give a "no" answer on the question whether D is part of 
C's history.

-Marc

