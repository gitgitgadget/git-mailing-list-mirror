Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A04FA1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 06:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755042AbeDCGqR (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 02:46:17 -0400
Received: from mailhost.frm2.tum.de ([129.187.179.12]:47526 "EHLO
        mailhost.frm2.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755014AbeDCGqQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 02:46:16 -0400
X-Greylist: delayed 747 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Apr 2018 02:46:16 EDT
Received: from mailhost.frm2.tum.de (localhost [127.0.0.1])
        by mailhost.frm2.tum.de (8.15.2/8.15.2) with ESMTP id w336XlCg046500
        for <git@vger.kernel.org>; Tue, 3 Apr 2018 08:33:47 +0200 (CEST)
        (envelope-from jens.krueger@frm2.tum.de)
X-Virus-Scanned: at mailhost.frm2.tum.de
Received: from taco23.ictrl.frm2 (taco23.ictrl.frm2 [172.25.2.23])
        (authenticated bits=0)
        by mailhost.frm2.tum.de (8.15.2/8.15.2) with ESMTPSA id w336XanZ046490
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Tue, 3 Apr 2018 08:33:37 +0200 (CEST)
        (envelope-from jens.krueger@frm2.tum.de)
From:   =?UTF-8?Q?Jens_Kr=c3=bcger?= <Jens.Krueger@frm2.tum.de>
Subject: Test t2028 failes
To:     git@vger.kernel.org
Message-ID: <dfb01281-2ffb-a0ac-a44d-74ccd304a7ea@frm2.tum.de>
Date:   Tue, 3 Apr 2018 08:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mailhost.frm2.tum.de [129.187.179.12]); Tue, 03 Apr 2018 08:33:38 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test 2028 failes:

Git version: 2.17.0 (checked out from github repository)

OS: Debian9(9.4), Debian 8 (8.10) and xubuntu 14.04(14.04.5 LTS)

gcc: gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
      gcc (Debian 4.9.2-10+deb8u1) 4.9.2
      gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4


configure generated with:

autoreconf

build with:

./configure
make

test running:

make test

Error:

*** t2028-worktree-move.sh ***
ok 1 - setup
ok 2 - lock main worktree
ok 3 - lock linked worktree
ok 4 - lock linked worktree from another worktree
ok 5 - lock worktree twice
ok 6 - lock worktree twice (from the locked worktree)
ok 7 - unlock main worktree
ok 8 - unlock linked worktree
ok 9 - unlock worktree twice
ok 10 - move non-worktree
ok 11 - move locked worktree
not ok 12 - move worktree
#
#               toplevel="$(pwd)" &&
#               git worktree move source destination &&
#               test_path_is_missing source &&
#               git worktree list --porcelain >out &&
#               grep "^worktree.*/destination" out &&
#               ! grep "^worktree.*/source" out &&
#               git -C destination log --format=%s >actual2 &&
#               echo init >expected2 &&
#               test_cmp expected2 actual2
#
ok 13 - move main worktree
ok 14 - move worktree to another dir
ok 15 - remove main worktree
ok 16 - remove locked worktree
ok 17 - remove worktree with dirty tracked file
ok 18 - remove worktree with untracked file
ok 19 - force remove worktree with untracked file
ok 20 - remove missing worktree
ok 21 - NOT remove missing-but-locked worktree
# failed 1 among 21 test(s)
1..21


