Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 070CD2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 19:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbcGMTHR (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 15:07:17 -0400
Received: from smtprelay03.ispgateway.de ([80.67.29.28]:39283 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbcGMTHP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2016 15:07:15 -0400
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jul 2016 15:07:15 EDT
Received: from [204.148.29.50] (helo=[10.12.6.135])
	by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.84)
	(envelope-from <beanie@benle.de>)
	id 1bNPKg-0004HG-9l; Wed, 13 Jul 2016 20:56:30 +0200
From:	Benjamin Fritsch <beanie@benle.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3200\))
Subject: Multiple Keys in ssh-agent, fail to clone
Message-Id: <CFA91608-1F29-4631-BABC-258404A62A3B@benle.de>
Date:	Wed, 13 Jul 2016 14:56:28 -0400
Cc:	Brendan Fosberry <brendan@codeship.com>
To:	git@vger.kernel.org
X-Mailer: Apple Mail (2.3200)
X-Df-Sender: YmVhbmllQGJlbmxlLmRl
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey all,

We recently upgraded from Git 2.8 to 2.9 and saw an issue when there are multiple keys added to my ssh-agent.

I have two keys. 
- KeyA (my company that has access to the repository I want to clone)
- KeyB (just my personal key with access to my personal stuff)

Having both keys in loaded and listed in `ssh-add -L` fails to clone the repository. I tried to change the order of the key in the agent but neither KeyA, KeyB nor KeyB, KeyA will work. The only case that works if I have KeyA loaded an no other key is added to the ssh-agent.

Having multiple Keys loaded works with Git 2.8 and Git 2.7 (I didn’t try older versions)
Cloning fails with “Unauthorized Access” of our Git provider. (It’s Bitbucket in this case)

I read the Changelog for 2.9 and couldn’t find any reference to changed key handling. Is there anything that I can add to the `git clone` command to get the old behavior?

Thank you for your help,
Best
Ben