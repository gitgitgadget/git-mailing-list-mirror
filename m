Return-Path: <SRS0=RB3M=7H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6496C433E0
	for <git@archiver.kernel.org>; Mon, 25 May 2020 23:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 884DD207CB
	for <git@archiver.kernel.org>; Mon, 25 May 2020 23:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388021AbgEYXey (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 May 2020 19:34:54 -0400
Received: from smtp-1.his.com ([216.194.195.13]:38857 "EHLO smtp-1.his.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgEYXex (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 May 2020 19:34:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp-1.his.com (Postfix) with ESMTP id 666ED609AE
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:49 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at smtp-1.his.com
Received: from smtp-1.his.com ([127.0.0.1])
        by localhost (smtp-1.his.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GMMjDJU3ysWd for <git@vger.kernel.org>;
        Mon, 25 May 2020 19:27:49 -0400 (EDT)
Received: from smtp-nf-201.his.com (smtp-nf-201.his.com [216.194.196.93])
        by smtp-1.his.com (Postfix) with ESMTP id 1A99C6090C
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:49 -0400 (EDT)
Received: from cuda201.his.com (cuda201.his.com [216.194.196.22])
        by smtp-nf-201.his.com (Postfix) with ESMTPS id 09A906025F
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:48 -0400 (EDT)
X-ASG-Debug-ID: 1590449267-061c4120542f3530001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.196.20]) by cuda201.his.com with ESMTP id zi9gJuxLtgsruzPL for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:47 -0400 (EDT)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.196.20
Received: from zproxy101.his.com (zproxy101.his.com [18.218.2.49])
        by smtp-nf-202.his.com (Postfix) with ESMTPS id A576D601CD
        for <git@vger.kernel.org>; Mon, 25 May 2020 19:27:47 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 6C6F6177EAC;
        Mon, 25 May 2020 19:27:47 -0400 (EDT)
X-Barracuda-RBL-IP: 18.218.2.49
X-Barracuda-Effective-Source-IP: zproxy101.his.com[18.218.2.49]
X-Barracuda-Apparent-Source-IP: 18.218.2.49
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7FMtDk6IRy00; Mon, 25 May 2020 19:27:47 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy101.his.com (Postfix) with ESMTP id 547B5177EA9;
        Mon, 25 May 2020 19:27:47 -0400 (EDT)
X-Virus-Scanned: amavisd-new at zproxy101.his.com
Received: from zproxy101.his.com ([127.0.0.1])
        by localhost (zproxy101.his.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S_JKme5sGazH; Mon, 25 May 2020 19:27:47 -0400 (EDT)
Received: from wings.local (pool-74-96-209-77.washdc.fios.verizon.net [74.96.209.77])
        by zproxy101.his.com (Postfix) with ESMTPSA id 31A68177EA2;
        Mon, 25 May 2020 19:27:47 -0400 (EDT)
Received: from wings.fios-router.home (localhost [127.0.0.1])
        by wings.local (8.15.2/8.15.2/Debian-10) with ESMTP id 04PNRkUj021148;
        Mon, 25 May 2020 19:27:46 -0400
Received: (from keni@localhost)
        by wings.fios-router.home (8.15.2/8.15.2/Submit) id 04PNRk5p021147;
        Mon, 25 May 2020 19:27:46 -0400
From:   Kenneth Lorber <keni@his.com>
To:     git@vger.kernel.org
Cc:     keni@his.com
Subject: [RFC PATCH v2 0/6] various documentation bits
Date:   Mon, 25 May 2020 19:27:21 -0400
X-ASG-Orig-Subj: [RFC PATCH v2 0/6] various documentation bits
Message-Id: <20200525232727.21096-1-keni@his.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1589681624-36969-1-git-send-email-keni@hers.com>
References: <1589681624-36969-1-git-send-email-keni@hers.com>
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.196.20]
X-Barracuda-Start-Time: 1590449267
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-Scan-Msg-Size: 1006
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=6.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.82102
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Major changes since v1:
- add "doc:" prefix to subjects
- make guidelines file less authoritative; delete $ID concept
and hopefully fix the conflict between my mailer and my git
configuration which resulted in the extra From: line in the body.

Kenneth Lorber (6):
  doc: Tell the glossary about core.hooksPath
  doc: Add bit on extending git to Hacking Git
  doc: Add namespace collision guidelines file
  doc: Add collision doc to gitrepository-layout.txt
  doc: Tell config.txt about namespace collisions
  doc: Add collision reference to Hacking Git

 Documentation/config.txt                      |  4 +-
 Documentation/gitrepository-layout.txt        |  2 +
 Documentation/glossary-content.txt            | 10 +--
 .../technical/namespace-collisions.txt        | 72 +++++++++++++++++++
 Documentation/user-manual.txt                 |  9 +++
 5 files changed, 92 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/technical/namespace-collisions.txt

-- 
2.17.1

