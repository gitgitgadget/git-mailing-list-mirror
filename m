Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066031F424
	for <e@80x24.org>; Fri, 27 Apr 2018 14:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934407AbeD0OsB (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 10:48:01 -0400
Received: from listserv2.niif.hu ([193.225.14.155]:51245 "EHLO
        listserv2.niif.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934021AbeD0Or7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 10:47:59 -0400
X-Greylist: delayed 1011 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Apr 2018 10:47:58 EDT
Received: from business-188-142-225-206.business.broadband.hu ([188.142.225.206] helo=lant.ki.iif.hu)
        by listserv2.niif.hu with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <wferi@niif.hu>)
        id 1fC4Ot-0008LN-Dz; Fri, 27 Apr 2018 16:31:03 +0200
Received: from wferi by lant.ki.iif.hu with local (Exim 4.89)
        (envelope-from <wferi@lant.ki.iif.hu>)
        id 1fC4On-0004wN-TZ; Fri, 27 Apr 2018 16:30:57 +0200
From:   wferi@niif.hu (Ferenc =?utf-8?Q?W=C3=A1gner?=)
To:     git@vger.kernel.org
Cc:     wferi@niif.hu
Subject: branch --contains / tag --merged inconsistency
Date:   Fri, 27 Apr 2018 16:30:57 +0200
Message-ID: <87fu3g67ry.fsf@lant.ki.iif.hu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm moving the IRC discussion here, because this might be a bug report
in the end.  So, kindly try these steps (103 MB free space required):

$ git clone https://github.com/ClusterLabs/pacemaker.git && cd pacemaker
[...]
$ git branch --contains Pacemaker-0.6.1
* master
$ git tag --merged master | fgrep Pacemaker-0.6
Pacemaker-0.6.0
Pacemaker-0.6.2
Pacemaker-0.6.3
Pacemaker-0.6.4
Pacemaker-0.6.5
Pacemaker-0.6.6

Notice that Pacemaker-0.6.1 is missing from the output.  Kind people on
IRC didn't find a quick explanation, and we all had to go eventually.
Is this expected behavior?  Reproduced with git 2.11.0 and 2.17.0.
-- 
Thanks,
Feri
