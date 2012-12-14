From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH] Documentation/git-clean: Document --force --force
Date: Thu, 13 Dec 2012 17:46:55 -0800
Message-ID: <b48ad5f0-25f7-45c3-b2dc-c0c01645a247@CO9EHSMHS031.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Soren Brinkmann <soren.brinkmann@xilinx.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 02:47:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjKNE-0008BW-Bv
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 02:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149Ab2LNBrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2012 20:47:20 -0500
Received: from co9ehsobe004.messaging.microsoft.com ([207.46.163.27]:8365 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753485Ab2LNBrT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2012 20:47:19 -0500
Received: from mail53-co9-R.bigfish.com (10.236.132.247) by
 CO9EHSOBE034.bigfish.com (10.236.130.97) with Microsoft SMTP Server id
 14.1.225.23; Fri, 14 Dec 2012 01:47:18 +0000
Received: from mail53-co9 (localhost [127.0.0.1])	by mail53-co9-R.bigfish.com
 (Postfix) with ESMTP id 6D3CD26016C	for <git@vger.kernel.org>; Fri, 14 Dec
 2012 01:47:18 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:149.199.60.83;KIP:(null);UIP:(null);IPV:NLI;H:xsj-gw1;RD:unknown-60-83.xilinx.com;EFVD:NLI
X-SpamScore: 1
X-BigFish: VPS1(zzzz1de0h1202h1e76h1d1ah1d2ahzz8275bhz2fh95h668h839hd24hf0ah119dh1288h12a5h12a9h12bdh12e5h137ah139eh13b6h1441h14ddh1504h1537h162dh1631h1758h906i1155h)
Received-SPF: pass (mail53-co9: domain of xilinx.com designates 149.199.60.83 as permitted sender) client-ip=149.199.60.83; envelope-from=soren.brinkmann@xilinx.com; helo=xsj-gw1 ;helo=xsj-gw1 ;
Received: from mail53-co9 (localhost.localdomain [127.0.0.1]) by mail53-co9
 (MessageSwitch) id 1355449636365239_4165; Fri, 14 Dec 2012 01:47:16 +0000
 (UTC)
Received: from CO9EHSMHS031.bigfish.com (unknown [10.236.132.231])	by
 mail53-co9.bigfish.com (Postfix) with ESMTP id 526432800C4	for
 <git@vger.kernel.org>; Fri, 14 Dec 2012 01:47:16 +0000 (UTC)
Received: from xsj-gw1 (149.199.60.83) by CO9EHSMHS031.bigfish.com
 (10.236.130.41) with Microsoft SMTP Server id 14.1.225.23; Fri, 14 Dec 2012
 01:47:12 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
 helo=xsj-smtp1.xilinx.com)	by xsj-gw1 with esmtp (Exim 4.63)	(envelope-from
 <soren.brinkmann@xilinx.com>)	id 1TjKMq-0000rA-BT	for git@vger.kernel.org;
 Thu, 13 Dec 2012 17:47:12 -0800
X-Mailer: git-send-email 1.8.0.2
X-RCIS-Action: ALLOW
X-OriginatorOrg: xilinx.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211484>

This patch documents the behavior of 'git clean' when
encountering nested git repositories.
Such repositories are only deleted if '-f' is passed twice
to 'git clean'.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 Documentation/git-clean.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 9f42c0d..0b31454 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -23,6 +23,9 @@ example, be useful to remove all build products.
 If any optional `<path>...` arguments are given, only those paths
 are affected.
 
+Nested git repositories are not removed unless the '-f' option is
+passed to 'git clean' twice.
+
 OPTIONS
 -------
 -d::
@@ -35,6 +38,8 @@ OPTIONS
 --force::
 	If the git configuration variable clean.requireForce is not set
 	to false, 'git clean' will refuse to run unless given -f or -n.
+	Pass this option twice to 'git clean' in order to also remove
+	nested git repositories.
 
 -n::
 --dry-run::
-- 
1.8.0.2
