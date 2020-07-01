Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB028C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3B772067D
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgGAJqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:46:15 -0400
Received: from smtp01.domein-it.com ([92.48.232.134]:49444 "EHLO
        smtp01.domein-it.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgGAJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 05:46:14 -0400
Received: by smtp01.domein-it.com (Postfix, from userid 1000)
        id D6F988086D69; Wed,  1 Jul 2020 11:37:08 +0200 (CEST)
Received: from ferret.domein-it.nl (unknown [92.48.232.148])
        by smtp01.domein-it.com (Postfix) with ESMTP id E91BA8086D57
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 11:37:06 +0200 (CEST)
Received: from 80-112-22-40.cable.dynamic.v4.ziggo.nl ([80.112.22.40]:48484 helo=ben.dynamic.ziggo.nl)
        by ferret.domein-it.nl with esmtpa (Exim 4.93)
        (envelope-from <ben@wijen.net>)
        id 1jqZAs-00066q-RC; Wed, 01 Jul 2020 11:37:02 +0200
From:   Ben Wijen <ben@wijen.net>
To:     git@vger.kernel.org
Cc:     Ben Wijen <ben@wijen.net>
Subject: [PATCH 0/2] git clone with --separate-git-dir destroys existing directory content
Date:   Wed,  1 Jul 2020 11:36:51 +0200
Message-Id: <20200701093653.3706-1-ben@wijen.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Domein-IT-MailScanner-Information: Please contact the ISP for more information
X-Domein-IT-MailScanner-ID: 1jqZAs-00066q-RC
X-Domein-IT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-Domein-IT-MailScanner-SpamCheck: 
X-Domein-IT-MailScanner-From: ben@wijen.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I found an issue with git clone, when using --separate-git-dir and that directory already exists,
it's content is destroyed.

I have created a patch set on origin/next, but (as I have learned this the hard way) please let me know
if this needs to be backported...


Ben...


Ben Wijen (2):
  git clone: check for non-empty directory
  git clone: don't clone into non-empty directory

 builtin/clone.c  | 12 ++++++++++--
 t/t5601-clone.sh |  3 ++-
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.27.0

