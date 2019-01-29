Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89E81F453
	for <e@80x24.org>; Tue, 29 Jan 2019 21:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfA2Vbl (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 16:31:41 -0500
Received: from ma1-aaemail-dr-lapp03.apple.com ([17.171.2.72]:37326 "EHLO
        ma1-aaemail-dr-lapp03.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727488AbfA2Vbl (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 16:31:41 -0500
X-Greylist: delayed 6722 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 16:31:40 EST
Received: from pps.filterd (ma1-aaemail-dr-lapp03.apple.com [127.0.0.1])
        by ma1-aaemail-dr-lapp03.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJasc2029331;
        Tue, 29 Jan 2019 11:39:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=oZCsS/F6M56rBE3XIcTB+LABoJ8tHK6cuDWLKKxe/L4=;
 b=UTLtRqCkzKr9SX9vAUdt/QOhheAmmF2rU7ZPNVPkSHdLIaW/ZimJ1KP4jOkl/hjuvsBi
 +Vha2SD2R/Bh10sSHs5GYMapeZwSCE23LaVHZd2cXrcOakw4ecNK4BphQkhJADczhSPf
 N4m2m3oqc3TYsJY5RYvTzuWM/E+/e772ok8wfsaJiwKtP0A0c1AqU/rVMya5655Pv+d9
 98llzxAIYEkTtkz4pq4rEr8V/kdyjTkzUVWHBv9oyP9ZSaPTKAW62r49lUc8px+EcOYu
 w7rrB3Qnkz16xUTztzq3Vl+q9SmxNlNVhgC2bAJDuy1uFeK2yG0TsjsL7CcVwUx4Aep9 qg== 
Received: from mr2-mtap-s01.rno.apple.com (mr2-mtap-s01.rno.apple.com [17.179.226.133])
        by ma1-aaemail-dr-lapp03.apple.com with ESMTP id 2q8qe37s2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:37 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by mr2-mtap-s01.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM300L5TYM0BND0@mr2-mtap-s01.rno.apple.com>; Tue,
 29 Jan 2019 11:39:37 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300D00Y9OJD00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:36 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: 20253dfa3f84e566887060199d60e0a4
X-Va-R-CD: 5941725aa36e7881aa01cb4c3b14f216
X-Va-CD: 0
X-Va-ID: cdd3993b-ba54-4e63-832f-7f7b36d2e44c
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: 20253dfa3f84e566887060199d60e0a4
X-V-R-CD: 5941725aa36e7881aa01cb4c3b14f216
X-V-CD: 0
X-V-ID: abc977ae-4d02-452f-8d5c-77cf71cea422
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300000YJS3N00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:36 -0800 (PST)
Authentication-results: corp.apple.com; spf=softfail
 smtp.mailfrom=jeremyhu@apple.com;      dmarc=quarantine header.from=apple.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_15:,, signatures=0
Received: from tifa.apple.com (unknown [17.114.130.22])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTP id <0PM30080GYLYQX50@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:36 -0800 (PST)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: [PATCH (Apple Git) 12/13] Enable support for Xcode.app-bundled
 gitconfig
Date:   Tue, 29 Jan 2019 11:38:18 -0800
Message-id: <20190129193818.8645-13-jeremyhu@apple.com>
X-Mailer: git-send-email 2.20.0 (Apple Git-115)
In-reply-to: <20190129193818.8645-1-jeremyhu@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Useful for setting up osxkeychain in Xcode.app's gitconfig

Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
---
 config.c | 13 +++++++++++++
 config.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/config.c b/config.c
index ff521eb27a..656bfef8ab 100644
--- a/config.c
+++ b/config.c
@@ -1631,6 +1631,14 @@ const char *git_etc_gitconfig(void)
 	return system_wide;
 }
 
+const char *git_xcode_gitconfig(void)
+{
+	static const char *xcode_config;
+	if (!xcode_config)
+		xcode_config = system_path("share/git-core/gitconfig");
+	return xcode_config;
+}
+
 /*
  * Parse environment variable 'k' as a boolean (in various
  * possible spellings); if missing, use the default value 'def'.
@@ -1673,6 +1681,11 @@ static int do_git_config_sequence(const struct config_options *opts,
 	else
 		repo_config = NULL;
 
+	current_parsing_scope = CONFIG_SCOPE_XCODE;
+	if (git_config_system() && git_xcode_gitconfig() && !access_or_die(git_xcode_gitconfig(), R_OK, 0))
+		ret += git_config_from_file(fn, git_xcode_gitconfig(),
+					    data);
+
 	current_parsing_scope = CONFIG_SCOPE_SYSTEM;
 	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK, 0))
 		ret += git_config_from_file(fn, git_etc_gitconfig(),
diff --git a/config.h b/config.h
index ee5d3fa7b4..f848423d28 100644
--- a/config.h
+++ b/config.h
@@ -115,6 +115,7 @@ extern int git_config_rename_section_in_file(const char *, const char *, const c
 extern int git_config_copy_section(const char *, const char *);
 extern int git_config_copy_section_in_file(const char *, const char *, const char *);
 extern const char *git_etc_gitconfig(void);
+extern const char *git_xcode_gitconfig(void);
 extern int git_env_bool(const char *, int);
 extern unsigned long git_env_ulong(const char *, unsigned long);
 extern int git_config_system(void);
@@ -131,6 +132,7 @@ enum config_scope {
 	CONFIG_SCOPE_GLOBAL,
 	CONFIG_SCOPE_REPO,
 	CONFIG_SCOPE_CMDLINE,
+	CONFIG_SCOPE_XCODE,
 };
 
 extern enum config_scope current_config_scope(void);
-- 
2.20.0 (Apple Git-115)

