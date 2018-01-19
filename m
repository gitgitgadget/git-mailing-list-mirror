Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD9D01F404
	for <e@80x24.org>; Fri, 19 Jan 2018 17:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeASRet (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 12:34:49 -0500
Received: from sonic310.consmr.mail.bf2.yahoo.com ([74.6.135.253]:39758 "EHLO
        sonic310-17.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932529AbeASReW (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jan 2018 12:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516383261; bh=BLneq2Dd5eTyoLHS5Vkc7ftANCW3T1msXBSFa91l5Hk=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=TY9Sd0aGVXAk83ayH51IdAVeFOpqz2JSRN1Rpw/hHWcYKL5CzIjOZX7EVX/tIB256Ax7EKJQWRbReCRK901fTArad2Y2MfpfrvffoLy10oyuokukqmmMcNLQ56lDavYb7RGQCjbcA3g3b2jlU20yeLDlMas1wkf2f14LEqOqiaHcrM2sid8EdwPYaS7/trpKLaUplv1D/NNNOqdVJUFtVhsuVgSWfEoTsKocJnpsaTkcfkqNzWHgl9rIH1m6n5ynNITF2bfJu/h4arzo7R+7nIdKmW45NFH+wSHhRP7Io7Z//wQQVdsBksSFHieZ2ZfJVrP0CYCr4wKQVf+eIwdc8A==
X-YMail-OSG: Gk1TmpsVM1k17TevTi7kBGgyduexjWaHXZxhRQGoedmuyuWxIxFa9Fd.N9HnIo.
 UhKwmsFJYTOIH1Hu2XQZ2zt6cMmoMtoqaeuZy5p8BlltwG4DJZPRum7Gp_HMTm3.8QsBoemGm592
 KiakhUwgsOAxM8une9Q8m9Fqj0zapZgpziiv5boJq1BAcq336ewCS0Mqtq38Z9lGgq0FaSEqsYvh
 0r8rxTe0mLfhOKORfUUttEckOSesRjy.o9_InAPkR72ZhwXD_LI9JkeObhoIyG0WHoDIcZtH06sN
 DA34sD.d9CoJ7xMETh2sRC9.zz2yl.uyYqLDpwm0T2kPUdIfvq8YHu5T4Fxf81_1lVVuf814xtHN
 Ywc7H9RNx7Nl1wWx38MuIccYaiI9maM_XIOT5A5UW6MBu.6g_3_4k4.orohR7zgyRVBDdN8hYGmw
 aZAzH6TKRUpsKyi6BeyJWU.oaUaTpmjAvhUpjE9tyT0SPS8oXePBejA7n4O.ZiCGhTSPr9KPg5cF
 UTy7q2oW6Pe8obYRL_m26c.8Vfooa_VLdlWBDsGcVpYjPB.SZxQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Fri, 19 Jan 2018 17:34:21 +0000
Received: from smtpgate102.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([72.30.28.113])
          by smtp406.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID e78d06b6c08cf8709c5b5470ad5cf24d;
          Fri, 19 Jan 2018 17:34:20 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 5/6] Bring NonStop platform definitions up to date in git-compat-util.h
Date:   Fri, 19 Jan 2018 12:34:05 -0500
Message-Id: <20180119173406.13324-7-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180119173406.13324-1-randall.s.becker@rogers.com>
References: <20180119173406.13324-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

* git-compat-util.h: add correct FLOSS definitions to allow correct
  emulation of non-platform behaviour. Add NSIG definition that is
  not explicitly supplied in signal.h on platform.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 git-compat-util.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index 68b2ad531..1e13f050a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -378,6 +378,21 @@ static inline char *git_find_last_dir_sep(const char *path)
 #define find_last_dir_sep git_find_last_dir_sep
 #endif
 
+#ifdef __TANDEM
+#if !defined(_THREAD_SUPPORT_FUNCTIONS) && !defined(_PUT_MODEL_)
+/* #include <floss.h(floss_read,floss_write,floss_fsync,floss_fork)> */
+/* #include <floss.h(floss_fork)> */
+#endif
+#include <floss.h(floss_execl,floss_execlp,floss_execv,floss_execvp)>
+#include <floss.h(floss_getpwuid)>
+#if ! defined NSIG
+/* NonStop NSE and NSX do not provide NSIG. SIGGUARDIAN(99) is the highest
+   known, by detective work using kill -l as a list of all signals
+   instead of signal.h where it should be. */
+# define NSIG 100
+#endif
+#endif
+
 #if defined(__HP_cc) && (__HP_cc >= 61000)
 #define NORETURN __attribute__((noreturn))
 #define NORETURN_PTR
-- 
2.16.0.31.gf1a482c

