Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CB2D1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 20:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfA2Uhj (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 15:37:39 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:53290 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727075AbfA2Uhj (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 15:37:39 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJbBev031277;
        Tue, 29 Jan 2019 11:39:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=t18LFcmB4nZOIZxmmaXGdw/drMMtvWyYEmqKTCKdmmA=;
 b=ch0dM/sj55y34aLwYBE8vUU47l2VRWBmgicKtBmCpNTTVlwgAXtNvvOevQPmsSTuVhJA
 Rn+hbr8S25nR0IM7NJcmXVWu0O4LpYtLn8emPh4wbqg9cHHda/JjPTaeaKBHkC20u8fd
 Noq5B7S4TQoaP9wuefUARcs3bSVs5Tn+hmkJrc0zzaytDw2L2BuKhKVai34/Ph5ccvUW
 v4G4WZ5nkF+rJpXnCnwU3dBfZR92KyiRx4Gg78mDdtq9XdPKfWN7sRKqQeLaC5cBF9jP
 v0TYJfUYTMqJQOu6/MCGs04VtgHn6EN5ohLevkStIkDWOFfPFw8LXYklLJpe3hR/cG06 sQ== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com [17.40.76.7])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0rt9dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:37 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM300DUDYM0TQE0@ma1-mtap-s03.corp.apple.com>; Tue,
 29 Jan 2019 11:39:36 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300D00Y9PJE00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:36 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: a324fb39882bde8fb617536cf1a8f873
X-Va-R-CD: d582dc3534525aab2000a3f1402a7161
X-Va-CD: 0
X-Va-ID: fcfbd055-2477-45fd-aa80-e7cfcc75af44
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: a324fb39882bde8fb617536cf1a8f873
X-V-R-CD: d582dc3534525aab2000a3f1402a7161
X-V-CD: 0
X-V-ID: 3bf7a24d-abcd-47ab-a9ab-8ac44ecefa4e
Received: from process_milters-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300100YK85D00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:36 -0800 (PST)
Authentication-results: corp.apple.com; spf=softfail
 smtp.mailfrom=jeremyhu@apple.com;      dmarc=quarantine header.from=apple.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-01-29_15:,, signatures=0
Received: from tifa.apple.com (unknown [17.114.130.22])
 by nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTP id <0PM30080GYLYQX50@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:35 -0800 (PST)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Subject: [PATCH (Apple Git) 10/13] Support for Xcode.app co-exestince and
 relocation
Date:   Tue, 29 Jan 2019 11:38:16 -0800
Message-id: <20190129193818.8645-11-jeremyhu@apple.com>
X-Mailer: git-send-email 2.20.0 (Apple Git-115)
In-reply-to: <20190129193818.8645-1-jeremyhu@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch has been trimmed down significantly from its original version
when rebasing on top of git 2.18 because git 2.18 included support for
runtime prefix support for darwin, making this patch mostly duplicative.

The remaining changes are needed to ensure that git-perl can find the
subversion perl module (which relocates with it) and handle relocation
of python scripts.

Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
---
 Makefile                                      |  3 +++
 .../runtime_prefix.template.pl                | 25 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Makefile b/Makefile
index 60711d6abe..97f46444f5 100644
--- a/Makefile
+++ b/Makefile
@@ -2171,6 +2171,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
 	    -e "s=@@INSTLIBDIR@@=$$INSTLIBDIR=g" \
 	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
+	    -e 's=@@PERLVERSION@@=$(shell grep DEFAULT /usr/local/versioner/perl/versions | sed 's:^.*= *\([^ ]*\)$$:\1:')=g' \
 	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
 	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
 	    $< >$@+ && \
@@ -2206,6 +2207,8 @@ $(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
 $(SCRIPT_PYTHON_GEN): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
+	    -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"@@INSTLIBDIR@@")|' \
+	    -e 's|"@@INSTLIBDIR@@"|os.path.realpath(os.path.dirname(sys.argv[0])) + "/../../share/git-core/python"|g' \
 	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/perl/header_templates/runtime_prefix.template.pl b/perl/header_templates/runtime_prefix.template.pl
index 9d28b3d863..b0b6b0bef1 100644
--- a/perl/header_templates/runtime_prefix.template.pl
+++ b/perl/header_templates/runtime_prefix.template.pl
@@ -1,3 +1,28 @@
+# BEGIN XCODE RUNTIME_PREFIX generated code
+BEGIN {
+    use File::Spec;
+    my $PERLVERSION = "@@PERLVERSION@@";
+    if ($^V =~ m/v([0-9]+).([0-9]+)/) {
+        $PERLVERSION = $1.".".$2;
+    }
+    my $__prefix = File::Spec->rel2abs( __FILE__ );
+
+    if ($__prefix =~ m/\/libexec\/git-core\// ) {
+        $__prefix =~ s/\/libexec\/git-core\/.*//;
+        unshift @INC, $__prefix . "/share/git-core/perl";
+        unshift @INC, $__prefix . "/../Library/Perl/".$PERLVERSION."/darwin-thread-multi-2level";
+    } elsif ($__prefix =~ m/\/bin\// ) {
+        $__prefix =~ s/\/bin\/.*//;
+        unshift @INC, $__prefix . "/share/git-core/perl";
+        unshift @INC, $__prefix . "/../Library/Perl/".$PERLVERSION."/darwin-thread-multi-2level";
+    } elsif ( $__prefix =~ m/\/usr\// ) {
+        $__prefix =~ s/\/usr\/.*/\/usr/;
+        unshift @INC, $__prefix . "/share/git-core/perl";
+        unshift @INC, $__prefix . "/../Library/Perl/".$PERLVERSION."/darwin-thread-multi-2level";
+    }
+}
+# END XCODE RUNTIME_PREFIX generated code.
+
 # BEGIN RUNTIME_PREFIX generated code.
 #
 # This finds our Git::* libraries relative to the script's runtime path.
-- 
2.20.0 (Apple Git-115)

