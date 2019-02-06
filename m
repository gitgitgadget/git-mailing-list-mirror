Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871E81F453
	for <e@80x24.org>; Wed,  6 Feb 2019 10:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfBFKdZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 05:33:25 -0500
Received: from mout.gmx.net ([212.227.15.18]:44525 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbfBFKdY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 05:33:24 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MJSLz-1gorPd2BKN-0034zd; Wed, 06
 Feb 2019 11:33:22 +0100
Date:   Wed, 6 Feb 2019 11:33:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Diamand <luke@diamand.org>
cc:     git@vger.kernel.org
Subject: Weird (seemingly flakey) p4 breakage in t9833
Message-ID: <nycvar.QRO.7.76.6.1902061004110.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wpSbHI95mVqB9LIj86E3myf2uHP0kUuqz9gJ+mHKICwDD7ADfKe
 9+lpjFyFVH6SvpzT/4423EVJNi15vJATPcLrF970bi8FGkR+m844KEyruUszhTC6TLyJJb7
 ac5O5I+FNsj6bI/mG1pHKH9ogjqV6JDPjvR2S8kvZS3VsGwigrdqdUY4QzNTKMOmNt7mrWx
 DV/qmjseK2qbQRRC40Www==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kHKcU4w1NKc=:DueMn/KJoTtNKZvv4E4+W4
 mogMFVZ0NJ9yF5hjQPBMaFsT+zxXO08B9p8sdOT6Har736T4VSqcpwQEI904Y5YPZPTBy/0fE
 EN3szKh8QdtDWoe1kF+ZkQZI5rrlPfAJT+Cw1Wv18KK73FIhwdmJbvrvMKYeI4FeGAMF8rgD8
 qz1cfWPEs2iua+WOR6Nu/GmqMsyBTsmgBMJRZTqAozWVDfwobn63wLw1w3hrEJzZO2P0o6eI9
 bwyouXC6rTPLZxLnvnNaw7SibG7Jb2plfIRdUNbORfPhnfpUZwNrUTEmPCcu+w/m1ZmC6dHdZ
 pKNkNJun1lzBAj3IdTJZIEoHLpyHbT1wtiEOPH1rG68qS/qEFpoYd4gU5YkD5v+rrkgXLaLgw
 S1BfeeKdT1AsGMZx+Xj+SLTy9Dj82rJ8ZYYu5g82zjTJ02r85aYwwcdch30+1+AmSTeH6QvsK
 0p6cJfgPhmDlEJuQ3BvWInRXsaiIVRhWVkjjaaDi1grQstzAodOIDndxNEPm7bl0bc8a/F4Oh
 TYZ0KZihYXeuD1uJdQvpzgXY+v0vosJmwE7O9ilCpUr+N/8zdnc5GDUVnsH03F4VpFaEfBKh4
 mxfFiOBcPO9qNm0n7r5xu1iacGmZoYeW5WvV1eZP77paYncgamjsrNDllKhC5N7Hs/1Owy3Zh
 f61rdV0SlMXxNT+OEw114gzLYyhApkbf8sYj6WPKgj6aYTJAbFO12HKhoPebB3weJtLsKxCmd
 h8Q3GWAs64529BWcEAhNhkptvR/NA6U8h+aUgZFKVpXVlMTXEl+TfQWA2IOefcBk4l1Qd6rDT
 Ntb5t/FSzxJ9tVD2juIe67i4ANf0gpB8ETaMm2QBsvpckaboLhK7aMAZl7WUrBex5rCbfMwKj
 OxYqPjOxHgApDjDLvF0VrCiXCvHyvMo6HHXpZXNhbXk9q5AAiTNFEWQWZ8Wq2+ckG6UNOo3xy
 f8VRmcAhjHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

in a private Azure Pipeline (sorry...) I noticed an intermittent problem
in the p4 tests on osx-gcc.

I would point you to a public log, but the Azure Pipelines support *just*
made it to next, so I *just* set up a public one targeting anything else
than my `vsts-ci` branch, at
https://dev.azure.com/gitgitgadget/git/_build/index?definitionId=6. And
those builds do not show that problem, so it must be a flakey test.

But maybe you can spot anything familiar from the log?

-- snip --
[...]
++ P4TICKETS='/Users/vsts/agent/2.146.0/work/1/s/t/trash
directory.t9833-errors/cli/tickets'
++ P4USER=short_expiry_user
++ echo password
++ p4 login
Enter password: 
User short_expiry_user logged in.
Perforce db files in '.' will be created if missing...
++ cd '/Users/vsts/agent/2.146.0/work/1/s/t/trash
directory.t9833-errors/git'
++ git p4 sync
++ true
+++ time_in_seconds
+++ cd /
+++ /usr/bin/python -c 'import time; print(int(time.time()))'
++ test 1549411312 -gt 1549411605
++ sleep 1
Perforce db files in '.' will be created if missing...
failure accessing depot: perforce ticket expires in 1 seconds
Performing incremental import into refs/remotes/p4/master git branch
Depot paths: //depot/
error: last command exited with $?=1
++ true
+++ time_in_seconds
+++ cd /
+++ /usr/bin/python -c 'import time; print(int(time.time()))'
++ test 1549411314 -gt 1549411605
++ sleep 1
not ok 6 - git operation with expired ticket
#	
#		P4TICKETS="$cli/tickets" &&
#		P4USER=short_expiry_user &&
#		echo "password" | p4 login &&
#		(
#			cd "$git" &&
#			git p4 sync &&
#			sleep 5 &&
#			test_must_fail git p4 sync 2>errmsg &&
#			grep "failure accessing depot" errmsg
#		)
#	
-- snap --

BTW I find it very odd to see a `sleep 1` in the trace but not in the
snippet (there is only a `sleep 5` instead, which I fail to see in the
trace). Odd?

Ciao,
Johannes
