Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A15D1F454
	for <e@80x24.org>; Tue,  6 Nov 2018 12:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbeKFWQs (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 17:16:48 -0500
Received: from smtpout11.ifi.lmu.de ([141.84.214.246]:41789 "EHLO
        smtpout11.ifi.lmu.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeKFWQs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 17:16:48 -0500
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Nov 2018 17:16:47 EST
Received: from empusa.suse (unknown [IPv6:2001:4ca0:0:f235:8219:34ff:feb1:d00f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jost.steffen.tcs)
        by smtpin1.ifi.lmu.de (Postfix) with ESMTPSA id 44DA0171288
        for <git@vger.kernel.org>; Tue,  6 Nov 2018 13:41:54 +0100 (CET)
From:   Steffen Jost <jost@tcs.ifi.lmu.de>
Subject: Checkout deleted semi-untracked file
To:     git@vger.kernel.org
Organization: LMU Munich
X-Tagtoolbar-Keys: D20181106134153510
Message-ID: <d4624773-739c-f698-514d-458ce2ef5503@tcs.ifi.lmu.de>
Date:   Tue, 6 Nov 2018 13:41:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

A brief discussion on the git user mailing list on Google Groups recommended me to file the following as a bug report.

The problem led to an actual file loss, but I suspect that this might be intended:

1) .gitignore is added to the repository (which then causes problems)
2) A file is added, repeatedly edited and comitted to a remote repository.
3) Later on, the file is added to .gitignore and "git rm --cached file" is executed (since the file now contains information private to each developer).
4) Several commits happen.
5) I checkout an old branch which has not yet seen the change in .gitignore in the master branch. The file is reverted to the state of the branch.
6) I checkout master, and the file with all later changes is irrevocably lost.

I usually advise my students to check-in their .gitignore file into the repository. Apparently this is a bad advice, since it now led to a somewhat painful file loss for me.

So what is the actual advice on this? Google turned up mixed advice there, and the git user mailing list on Google Groups recommended me submitting this as a bug here. However, I think this works as intended. However, I don't know either how to avert this problem, apart from not checking in the .gitignore file (or checking it in under a different name and copying it manually).


Thanks for any advice,
  Steffen Jost.

-- 
+49-89-2180-9139
http://www.tcs.ifi.lmu.de/~jost/

Lehr- und Forschungseinheit für Theoretische Informatik
Ludwig-Maximilians-Universität München
Oettingenstr. 67 (E111)
80538 München
BAVARIA
