Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3FEC20899
	for <e@80x24.org>; Mon,  7 Aug 2017 11:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbdHGLEy (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 07:04:54 -0400
Received: from mout.web.de ([217.72.192.78]:59267 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752960AbdHGLEx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 07:04:53 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MT8o6-1e6h631OT8-00S980; Mon, 07
 Aug 2017 13:04:21 +0200
Subject: [PATCH] t0001: skip test with restrictive permissions if getpwd(3)
 respects them
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        David Coppa <dcoppa@openbsd.org>
References: <20170806233850.14711-1-avarab@gmail.com>
 <20170807011832.oy6lxf2ewkmzg65s@genre.crustytoothpaste.net>
 <56fd58d6-acc7-042a-1b68-9854ed54361b@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cde6c1a5-3dfc-9710-bab9-b847a5dd960b@web.de>
Date:   Mon, 7 Aug 2017 13:04:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <56fd58d6-acc7-042a-1b68-9854ed54361b@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:8RX7eSXJ8zrSAuNogl9zgEXu+gpO4y/KObuG8SwvA5dzs1D+aCX
 JkZuqdT38aB5Up3XxKZuLIO38Eg+jZCU8c3Pe2Xnjw2cHQAHXCl3yiNBzIPKqtCwTV2z0Mo
 aMnVJKv2rX2CC/hOiAdXASHvTTes74w/RzX2aHoEIkyTCkduYP+IDOlM8beXN2baWjWzhJq
 atNwEibXtGrvVt5zUbfrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yl9qJhcGXxs=:zZk9+xbK1HB1JP3A7iYSDn
 47LDhMTBO3vv4SsW2vrUjDYZTED7mVNwk+xspqiUEQmrzpymeJaxETU2QTffKo+LQjiC3M3Kw
 ZYu/er8Dr3BPlN/U0OSQMMQEuHxVWD09qNIYuUkQLZ2ICboUeDYeXLnzFzTKQY89WI+ts94AR
 TTkBfS+ooXJSiNEUyS1XUc0XVL1D3lpmyDCuVj88oTDX+vuxrKKIKiwqYtTnGS0Luc1gbdCbh
 ylYu01Bg2t21RjEEaJLiy4fqVtNPGflyB2KAlzcEiNhyBdGxNfvTy7ptvyB0hLyWXkK0u9lzH
 gXWEIVmI3EWEDrN/nfgPd8ZgVxS9w3uT7qqcCMnFe4z0OrtKFa3cSHT6pFdOKNUcMyvW0fH4W
 J4ZAMSkmg4X4M45r3QjFpEHOAqieKexVY/Y7H9J7me5hZ4745jj2FGWUwg1WyyMpYGQ2a7evX
 nKrpiK0msZHdp3+WPiz+4arU2/NDV5QCWoFh4BkHaDkwSswDP2hg0BrFcsxCE4b0NHWw/mFR0
 SbQffdCwpxJP3k39pQ/YfDyD2N5Mj7O4dl6Qmmkb2nTl0ILn3O4jTWIQ2U8VeFjj9lfPfyRfn
 mezsJuZVbZ/R0L/I3KsnSx4B/QMBDfDx+kB6uxlrCcAqZG9AOuFFiFN2W9xpnJemlQ5FaDvzc
 N7mC2kqyJzXiHCrbFEi1gm2J8MQn4KnvP22tN0sNYpycPm91C9mEeh2gU0tduhdRCPL6lnz2J
 6gRXwfMF40m4fZ1UjJHYcWew/OyKtYlAHBE6mUAnG8ypUXsToxWQcWAws02yS0gfn8tTiKrMF
 YtK8L86/eAUNt6MfhSoJxOZmG/E45Z2EthjTMhyTd9Oz65Zzug=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sub-test "init in long base path" in t0001 checks the ability to
handle long base paths with restrictive permissions (--x).  On OpenBSD
getcwd(3) fails in that case even for short paths.  Check the two
aspects separately by trying to use a long base path both with and
without execute-only permissions.  Only attempt the former if we know
that getcwd(3) doesn't care.

Original-patch-by: David Coppa <dcoppa@openbsd.org>
Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: René Scharfe <l.s.r@web.de>
---
 t/t0001-init.sh | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index c4814d248f..86c1a51654 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -315,18 +315,44 @@ test_expect_success 'init with separate gitdir' '
 	test_path_is_dir realgitdir/refs
 '
 
-test_expect_success 'init in long base path' '
+test_lazy_prereq GETCWD_IGNORES_PERMS '
+	base=GETCWD_TEST_BASE_DIR &&
+	mkdir -p $base/dir &&
+	chmod 100 $base ||
+	error "bug in test script: cannot prepare $base"
+
+	(cd $base/dir && /bin/pwd -P)
+	status=$?
+
+	chmod 700 $base &&
+	rm -rf $base ||
+	error "bug in test script: cannot clean $base"
+	return $status
+'
+
+check_long_base_path () {
 	# exceed initial buffer size of strbuf_getcwd()
 	component=123456789abcdef &&
 	test_when_finished "chmod 0700 $component; rm -rf $component" &&
 	p31=$component/$component &&
 	p127=$p31/$p31/$p31/$p31 &&
 	mkdir -p $p127 &&
-	chmod 0111 $component &&
+	if test $# = 1
+	then
+		chmod $1 $component
+	fi &&
 	(
 		cd $p127 &&
 		git init newdir
 	)
+}
+
+test_expect_success 'init in long base path' '
+	check_long_base_path
+'
+
+test_expect_success GETCWD_IGNORES_PERMS 'init in long restricted base path' '
+	check_long_base_path 0111
 '
 
 test_expect_success 're-init on .git file' '
-- 
2.14.0
