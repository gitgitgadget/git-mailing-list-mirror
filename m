Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42161208CD
	for <e@80x24.org>; Wed, 23 Aug 2017 08:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753556AbdHWIRy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 23 Aug 2017 04:17:54 -0400
Received: from 7.mo64.mail-out.ovh.net ([46.105.63.1]:51154 "EHLO
        7.mo64.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753509AbdHWIRx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 04:17:53 -0400
Received: from ex2.mail.ovh.net (gw1.ex2.mail.ovh.net [164.132.80.186])
        by mo64.mail-out.ovh.net (Postfix) with ESMTPS id F1B678A867
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 10:10:50 +0200 (CEST)
Received: from [10.0.2.127] (86.200.152.136) by EX7.indiv2.local (172.16.2.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 23
 Aug 2017 10:10:50 +0200
To:     Git Mailing List <git@vger.kernel.org>
From:   Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Subject: sequencer status
Openpgp: preference=signencrypt
Message-ID: <8e25c42f-80f2-e0d4-38e4-b4fe9c8074e0@morey-chaisemartin.com>
Date:   Wed, 23 Aug 2017 10:10:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Originating-IP: [86.200.152.136]
X-ClientProxiedBy: CAS3.indiv2.local (172.16.1.3) To EX7.indiv2.local
 (172.16.2.7)
X-Ovh-Tracer-Id: 4074068816363186141
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeelledrtddvgddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've created a small tool to display the current sequencer status.
It mimics what Magit does to display what was done and what is left to do.

As someone who often rebase large series of patches (also works with am, revert, cherry-pick), I really needed the feature and use this daily.

It's available here:
https://github.com/nmorey/git-sequencer-status
SUSE and Fedora packages are available here:
https://build.opensuse.org/package/show/home:NMoreyChaisemartin:git-tools/git-sequencer-status

It's not necessary very robust yet. Most of the time I use simple rebase so there are a lot of untested corner cases.

Here is an example output:
$ sequencer-status
# Interactive rebase: master onto rebase_conflict
exec    true
pick    e54d993 Fourth commit
exec    true
*pick   b064629 Third commit
exec    true
pick    174c933 Second commit
onto    773cb23 Alternate second


Two questions:
- Could this be a candidate for contrib/ ?
- Would it be interesting to add the relevant code to sequencer.c so that all sequencer based commands could have a --status option ?

Nicolas



