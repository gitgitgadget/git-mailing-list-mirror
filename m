Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2EC51F404
	for <e@80x24.org>; Thu,  5 Apr 2018 14:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeDEOCO (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 10:02:14 -0400
Received: from mail1315.opentransfer.com ([76.162.254.108]:33539 "EHLO
        mail1315.opentransfer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeDEOCN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 10:02:13 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Apr 2018 10:02:13 EDT
Comment: DKIM? See http://www.dkim.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=guiffy.com; s=dkim-shared; x=1523541733; h=Comment:
        DomainKey-Signature:Received:Received:From:To:Cc:Subject:Date:
        Message-Id; bh=HdI4nPrQAPO09vbC8gYvyti0BirmnEfjVrBU1KLsWcc=; b=C
        tHZYkjL0VjOidz4ELl9bK896tw7omxM/1vYPOMrjzi66t+vNkZ/vKPsgMRR3Ks4L
        LPAptmRuBcuaEok+Mhdm9sig/P5x9h9W/6pTnU945umy2W852Z1IFE0A+TXwtT0i
        fOgTZzSiFYuIbEGf/IUpF+peNca0SgXbEBEAT6VLxo=
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=dkim-shared; d=guiffy.com;
        h=Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:Received:X-Originating-IP:From:To:Cc:Subject:Date:Message-Id:X-Mailer;
        b=hL8a+AU+LGYPpJKeIXDQV/yckZWDDwXdve+L2cZ9yWVfNXz9UyNJmh1vqVc8rw
        WSiQTWox//Oh1FxwXb54S89xIniGS7M65BQqMu1HQ6UZ1QkkvJBVZ5pTrOD9xLP7
        Y1TE83/ZVshHxv/lJo1bxpZHzk54hCo4bMkS+tOwvlYF8=;
Received: (qmail 22592 invoked by uid 399); 5 Apr 2018 13:55:32 -0000
Received: from unknown (HELO localhost.localdomain) (Bill?Ritcher@guiffy.com@99.113.245.148)
  by mail1315.opentransfer.com with ESMTPAM; 5 Apr 2018 13:55:32 -0000
X-Originating-IP: 99.113.245.148
From:   Bill Ritcher <Bill_Ritcher@guiffy.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, Bill Ritcher <Bill_Ritcher@guiffy.com>
Subject: [PATCH] mergetools: add support for guiffy
Date:   Thu,  5 Apr 2018 08:55:01 -0500
Message-Id: <20180405135501.12836-1-Bill_Ritcher@guiffy.com>
X-Mailer: git-send-email 2.15.1.windows.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add guiffy as difftool and mergetool

guiffy is available on Windows, Linux, and MacOS

Signed-off-by: Bill Ritcher <Bill_Ritcher@guiffy.com>
---
 mergetools/guiffy | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 mergetools/guiffy

diff --git a/mergetools/guiffy b/mergetools/guiffy
new file mode 100644
index 000000000..8b23a13c4
--- /dev/null
+++ b/mergetools/guiffy
@@ -0,0 +1,18 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE"
+}
+
+merge_cmd () {
+	if $base_present
+	then
+		"$merge_tool_path" -s "$LOCAL" \
+		"$REMOTE" "$BASE" "$MERGED"
+	else
+		"$merge_tool_path" -m "$LOCAL" \
+		"$REMOTE" "$MERGED"
+	fi
+}
+
+exit_code_trustable () {
+	true
+}
-- 
2.15.1.windows.2

