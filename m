Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA1801F453
	for <e@80x24.org>; Tue, 29 Jan 2019 22:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfA2Wub (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 17:50:31 -0500
Received: from nwk-aaemail-lapp02.apple.com ([17.151.62.67]:47044 "EHLO
        nwk-aaemail-lapp02.apple.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbfA2Wub (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 17:50:31 -0500
Received: from pps.filterd (nwk-aaemail-lapp02.apple.com [127.0.0.1])
        by nwk-aaemail-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id x0TJbBew031277;
        Tue, 29 Jan 2019 11:39:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=mime-version :
 content-transfer-encoding : content-type : from : to : cc : subject : date
 : message-id : in-reply-to : references; s=20180706;
 bh=tXqg4DvTpKqYzsMuSdOEUNy5EFXkrQjCwc74WAnmBEI=;
 b=u+tBAm+OKccTyl5fBsVSova4qYMFWKrFqxBoSC/dSvJ/cdPgWERZcuznzjK//zgx5kyQ
 ZHREXKIK2voDAzMkwf34DgJMVfq7Yj54DMpIdJR4pWWiEgaIxde3mlJWsVWvP3+h8qJ1
 1pTLRtd9BW9gFh8yb/8l6v4x5apV5JkejMwyFIL47MyYG0EcZ9KNo9+hhhe/Qh1uCL8/
 +3UECTAfP8SPNev7Nbm0SCZK3DY767NuuCUaZIfC2MMTHZbZ3sN8Dczzh2I9nvLBA2Xe
 gtkyuO3ez2uo+46SeuSxKzOtMHxd78wptR0XeM7RVzUb2eGuM9Sjh+lApPh/RV6AlI6D Qw== 
Received: from ma1-mtap-s03.corp.apple.com (ma1-mtap-s03.corp.apple.com [17.40.76.7])
        by nwk-aaemail-lapp02.apple.com with ESMTP id 2q8n0rt9dm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 29 Jan 2019 11:39:37 -0800
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: TEXT/PLAIN
Received: from nwk-relayp-sz03.apple.com
 (nwk-relayp-sz03.apple.com [17.128.113.11]) by ma1-mtap-s03.corp.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) with ESMTPS id <0PM300DUDYM0TQE0@ma1-mtap-s03.corp.apple.com>; Tue,
 29 Jan 2019 11:39:37 -0800 (PST)
Received: from process_viserion-daemon.nwk-relayp-sz03.apple.com by
 nwk-relayp-sz03.apple.com
 (Oracle Communications Messaging Server 8.0.2.3.20181024 64bit (built Oct 24
 2018)) id <0PM300D00Y9OJB00@nwk-relayp-sz03.apple.com>; Tue,
 29 Jan 2019 11:39:36 -0800 (PST)
X-Va-A: 
X-Va-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-Va-E-CD: ffe9239ee5336c79bdae8b021a3b2470
X-Va-R-CD: e1e9935b7f56b73d09788c6c2f952525
X-Va-CD: 0
X-Va-ID: fe55461a-ac14-44c8-8cf7-c059218a33c1
X-V-A:  
X-V-T-CD: ff40b79dc1582ca1bb0a38bbb8b21c87
X-V-E-CD: ffe9239ee5336c79bdae8b021a3b2470
X-V-R-CD: e1e9935b7f56b73d09788c6c2f952525
X-V-CD: 0
X-V-ID: 695bfd83-34de-401d-a7fc-0eaf592893a2
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
Cc:     peff@peff.net, Matt Wright <mww@apple.com>
Subject: [PATCH (Apple Git) 11/13] Fix problem found from running the test
 suite.
Date:   Tue, 29 Jan 2019 11:38:17 -0800
Message-id: <20190129193818.8645-12-jeremyhu@apple.com>
X-Mailer: git-send-email 2.20.0 (Apple Git-115)
In-reply-to: <20190129193818.8645-1-jeremyhu@apple.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_15:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Wright <mww@apple.com>

Signed-off-by: Matt Wright <mww@apple.com>
---
 git-svn.perl | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/git-svn.perl b/git-svn.perl
index 050f2a36f4..d29730be3b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1815,6 +1815,36 @@ sub complete_url_ls_init {
 
 sub verify_ref {
 	my ($ref) = @_;
+
+	if ($ref =~ /^(.*)\^0$/) {
+		my $baseref = $1;
+		my $p = "$ENV{GIT_DIR}/$baseref";
+		$p = "$ENV{GIT_DIR}/refs/remotes/$baseref" unless -e $p;
+		$p = "$ENV{GIT_DIR}/refs/$baseref" unless -e $p;
+		$p = "$ENV{GIT_DIR}/refs/heads/$baseref" unless -e $p;
+
+		my $resolved = undef;
+		if (-e $p) {
+			open FH, $p;
+			$resolved = <FH>;
+			chomp $resolved;
+			close FH;
+		} elsif (-e "$ENV{GIT_DIR}/packed-refs") {
+			open FH, "$ENV{GIT_DIR}/packed-refs";
+			while (<FH>) {
+				if ($_ =~ /^([0-9a-fA-F]+) ((refs\/)?(remotes\/|heads\/|\/)?$baseref)$/) {
+					$resolved = $1;
+					last;
+				}
+			}
+		}
+
+		if (defined($resolved)) {
+			return verify_ref("$1^0") if $resolved =~ /^ref: (.*)$/;
+			return $resolved
+		}
+	}
+
 	eval { command_oneline([ 'rev-parse', '--verify', $ref ],
 	                       { STDERR => 0 }); };
 }
-- 
2.20.0 (Apple Git-115)

