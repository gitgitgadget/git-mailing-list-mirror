Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5585207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966538AbdDZT1H (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:27:07 -0400
Received: from mout.gmx.net ([212.227.17.22]:55229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966084AbdDZT1G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:27:06 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgqEs-1drJeg162g-00oF9R; Wed, 26
 Apr 2017 21:26:48 +0200
Date:   Wed, 26 Apr 2017 21:26:33 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v6 3/8] t0006 & t5000: skip "far in the future" test when
 time_t is too limited
In-Reply-To: <cover.1493234408.git.johannes.schindelin@gmx.de>
Message-ID: <b914a7e5689991edd275086ba299894c2ba4e2f8.1493234408.git.johannes.schindelin@gmx.de>
References: <cover.1493042239.git.johannes.schindelin@gmx.de> <cover.1493234408.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4Fd1AUtUugvd8sNLa7y9HZ5zFWbXiBZOhgJDACyyx48EAFtIz1I
 wbJPOjR8P9XrP26dpNMi8LEgvTxui1BclIKOOMY+u8t8WmNt/VzjluFX5Ps9D9nFsKNWFiX
 LXK654q8oULHVWPnlHk/IxMfA8RSgL5ncn87+9xTf1N1wMYHbPypHSjhbft+sq8PNDrpCzf
 i3Iew5P+s+bABp29l56kg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ve0atz+iJ7Q=:TmHJU/R7e//R+Be+nAGSZs
 ORi00aIpuYKa15yJlBEoUvUXQx2FytpgPhxT5mvgH0OX/EAMo9vCzjHQD28O5LQRGRKLA+T93
 um58ed+VhBy6XHXN8zmHJrpbmGqHedhMakEj0lQEE4I9DELxQ8fCWzKYCTHAOpajGe3b1BgVb
 CVLmbO4uXfLNrBmKF/ZFnmmaZgwLFU+CqZ1v7c19rfrmPF5pL198xcUofaxsVvtdXv6WnR6gZ
 fRZu88JTsDBtzKpZG5raxRbT7onAazgV5YBqXyflLMEQBPk4LKDeWvExbOOZTAcgH5mXyhpva
 1+mNMmPrQDmerDXmPDilwheq1q68ktlymwjHxNPUp2b8+1Wwg9KPGn85BRItO1l8MXb0O70FR
 XghX+TtyjPetDINPEeHAhzjWWBXeIFgWMrLto3mq4rDqZw0/hvM13uCoUTu51khnzN5Z657hr
 RYrwg4Sdsbpgt5vgPMVP8teQzkwpjBF1Z6nNq6al1DRzlTUL5NP+AWUEnalu5s8DpbrFGTfFE
 n62+JO3KlTE9LuBF5Q30y4H1kgH9xcB6N7cUyCXs959dFZvUJqBNqUXD43nfRyrfSzurwSnl1
 +1jai0rBuhN5QVnEhgBQTU/At2lnwo+qnP/pGxsmHwnMxv3MGu61mjSBXf6Cco+eFR5sSTpSE
 KN1/kab5cDChEl1AQskqvG2k7gC/fQOw4b8ZjjjAncKUZx2wRRTsdQAz8fqDpWFmteomJY2OA
 S3h4qcz12ny2xqL514LlRkGNMciT3l6/njy8N6L394BVkBe93DVlVvrZgiOK/GWfyxEevlGOt
 PdRPoLh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git's source code refers to timestamps as unsigned long, which is
ill-defined, as there is no guarantee about the number of bits that
data type has.

In preparation of switching to another data type that is large enough
to hold "far in the future" dates, we need to prepare the t0006-date.sh
script for the case where we *still* cannot format those dates if the
system library uses 32-bit time_t.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 t/helper/test-date.c | 5 ++++-
 t/t0006-date.sh      | 4 ++--
 t/t5000-tar-tree.sh  | 2 +-
 t/test-lib.sh        | 1 +
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 4727bea255c..ac7c66c733b 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -5,7 +5,8 @@ static const char *usage_msg = "\n"
 "  test-date show:<format> [time_t]...\n"
 "  test-date parse [date]...\n"
 "  test-date approxidate [date]...\n"
-"  test-date is64bit\n";
+"  test-date is64bit\n"
+"  test-date time_t-is64bit\n";
 
 static void show_relative_dates(const char **argv, struct timeval *now)
 {
@@ -96,6 +97,8 @@ int cmd_main(int argc, const char **argv)
 		parse_approxidate(argv+1, &now);
 	else if (!strcmp(*argv, "is64bit"))
 		return sizeof(unsigned long) == 8 ? 0 : 1;
+	else if (!strcmp(*argv, "time_t-is64bit"))
+		return sizeof(time_t) == 8 ? 0 : 1;
 	else
 		usage(usage_msg);
 	return 0;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index 9539b425ffb..42d4ea61ef5 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -53,8 +53,8 @@ check_show unix-local "$TIME" '1466000000'
 
 # arbitrary time absurdly far in the future
 FUTURE="5758122296 -0400"
-check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT
-check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT
+check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400" TIME_IS_64BIT,TIME_T_IS_64BIT
+check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000" TIME_IS_64BIT,TIME_T_IS_64BIT
 
 check_parse() {
 	echo "$1 -> $2" >expect
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 997aa9dea28..fe2d4f15a73 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -402,7 +402,7 @@ test_expect_success TIME_IS_64BIT 'generate tar with future mtime' '
 	git archive HEAD >future.tar
 '
 
-test_expect_success TAR_HUGE,TIME_IS_64BIT 'system tar can read our future mtime' '
+test_expect_success TAR_HUGE,TIME_IS_64BIT,TIME_T_IS_64BIT 'system tar can read our future mtime' '
 	echo 4147 >expect &&
 	tar_info future.tar | cut -d" " -f2 >actual &&
 	test_cmp expect actual
diff --git a/t/test-lib.sh b/t/test-lib.sh
index beee1d847ff..8d25cb7c183 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1166,3 +1166,4 @@ test_lazy_prereq LONG_IS_64BIT '
 '
 
 test_lazy_prereq TIME_IS_64BIT 'test-date is64bit'
+test_lazy_prereq TIME_T_IS_64BIT 'test-date time_t-is64bit'
-- 
2.12.2.windows.2.406.gd14a8f8640f


