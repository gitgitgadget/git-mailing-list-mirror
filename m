Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2096F202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 15:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932348AbdGKPAL (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 11:00:11 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:47745 "EHLO mail.cixit.se"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755967AbdGKPAK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 11:00:10 -0400
X-Greylist: delayed 646 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Jul 2017 11:00:09 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
        by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id v6BEnLOM032554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 11 Jul 2017 16:49:21 +0200
Received: from localhost (peter@localhost)
        by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id v6BEnLqf032550;
        Tue, 11 Jul 2017 16:49:21 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Date:   Tue, 11 Jul 2017 15:49:21 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Git Mailing List <git@vger.kernel.org>
Subject: git config --help not functional on bad config
Message-ID: <alpine.DEB.2.00.1707111541150.18163@ds9.cixit.se>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Tue, 11 Jul 2017 16:49:21 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, I set the wrong value for a configuration option, and git tells me:

   $ git config branch.autoSetupRebase false
   $ git log
   error: malformed value for branch.autosetuprebase
   fatal: bad config variable 'branch.autosetuprebase' in file '.git/config' at line 24

That's fine. However, when trying to look for help, it is not that 
useful:

   $ git config --help
   error: malformed value for branch.autosetuprebase
   fatal: bad config variable 'branch.autosetuprebase' in file '.git/config' at line 24

Perhaps it should allow "--help" to go through even if the 
configuration is bad?

After a "git config --unset branch.autosetuprebase" everything works 
again, but I had to look that up manually calling "man git-config" 
(afterwards I realized I could go out of the repo to be unaffected 
by the config, but that probably wouldn't have helped if I had put 
this in my global config).

-- 
\\// Peter - http://www.softwolves.pp.se/
