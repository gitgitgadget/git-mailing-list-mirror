Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555741F461
	for <e@80x24.org>; Tue,  3 Sep 2019 18:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfICSwC (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 14:52:02 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:33012 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfICSwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 14:52:02 -0400
Received: by mail-lf1-f50.google.com with SMTP id d10so5863704lfi.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AULD7PLu9SPpQdLLUeec47RhiZ2q3IvEp7NUR1Abzhc=;
        b=dPg98rQ5ArnuJ58GEOjpfs6wSsL3Pset1ZziIzPszOLOHFtHeyvSobAPqDwDXtTQri
         7L7Q5k58eGoY9vQNN4SYFv0SiD0jcd5A4JObr6elgU+gPjCndlEaKszrsNwwwRSzLt1K
         eP/3hiKicROZHL0DdnbUA6gDZN0Ox3BRhNTbiF0uN+ICoc3OrjPyy6zoJUmX4XEkjEBt
         lV9GAxfqdTBiEjBKO+vZ2JTTGpwLRpiTP6IegLMvam0VaI1LvrnNZ8VkL3kexhAW4dbM
         B/FywMJkVydQZ7BJXqbmqxcwfQr1fe+1ZnqrNgoMcGpj7Y0omEy7f9FbtwKqVpJOex93
         I3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AULD7PLu9SPpQdLLUeec47RhiZ2q3IvEp7NUR1Abzhc=;
        b=cSA/XtuZDPjiZs4otKTxXRe/Z4L1yGrg6AXA+CYPupZVsNyTURe74wQS0WhPbG4sC5
         PuSdql6rTxsdW7url0x+s6VL49cp4F4DVxWbScnEC8hBZdTyaMRyBMl90tcbFxTpO2lh
         8js/GoHyylfiYTEQqx79DLZW99IUe42lFaqMB64NAJwXjLsMhpivih2oaMAnDfPUAm9v
         gwLRExT+NWR4Dw8FsBuxLEQpY7CIiI74hzNAp8ppx4cIvF/cH8gDdnyd7kTy7ZXobDgj
         Ok12d8YyoULm7Cbk+MRyRTDL3xnn0ZVCnIwqPOVjjEV+mc77Gf1jpXrRZlTZZew/n+nF
         synw==
X-Gm-Message-State: APjAAAXGoPYcvv6PbpyUKVo34oefsx7zbUL83i/4TEHTNfu2X+gNqa8k
        JrHqj9ZMfwVNgtY80tH/6hSA51sJ
X-Google-Smtp-Source: APXvYqyJLBwooxdpbQ/bMSQnt/A+96DskuNNS0ulyNsScPa0cdtQUnjvyFrK5LRo8bm2+FAbWyZ1gg==
X-Received: by 2002:ac2:531b:: with SMTP id c27mr9179048lfh.107.1567536719516;
        Tue, 03 Sep 2019 11:51:59 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id s21sm2971443ljm.28.2019.09.03.11.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 11:51:58 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/2] doc-diff: replace --cut-header-footer with --cut-footer
Date:   Tue,  3 Sep 2019 20:51:21 +0200
Message-Id: <40f3c4c3a9ce5e9152477b66016831be0b040310.1567534373.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1567534373.git.martin.agren@gmail.com>
References: <CAN0heSr2zCQMM6wOM0UnD28qj_VygQ5CQHGHhMR9+H23snpt5Q@mail.gmail.com> <cover.1567534373.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After the previous commit, AsciiDoc and Asciidoctor render the manpage
headers identically, so we no longer need the "cut the header" part of
our `--cut-header-footer` option. We do still need the "cut the footer"
part, though. The previous commit improved the rendering of the footer
in Asciidoctor by quite a bit, but the two programs still disagree on
how to format the date in the footer: 01/01/1970 vs 1970-01-01.

We could keep using `--cut-header-footer`, but it would be nice if we
had a slightly smaller hammer `--cut-footer` that would be less likely
to hide regressions. Rather than simply adding such an option, let's
also drop `--cut-header-footer`, i.e., rework it to lose the "header"
part of its name and functionality.

`--cut-header-footer` is just a developer tool and it probably has no
more than a handful of users, so we can afford be aggressive.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/doc-diff | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 3355be4798..88a9b20168 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -21,7 +21,7 @@ asciidoc		use asciidoc with both commits
 to-asciidoc		use asciidoc with the 'to'-commit
 to-asciidoctor		use asciidoctor with the 'to'-commit
 asciidoctor		use asciidoctor with both commits
-cut-header-footer	cut away header and footer
+cut-footer		cut away footer
 "
 SUBDIRECTORY_OK=1
 . "$(git --exec-path)/git-sh-setup"
@@ -31,7 +31,7 @@ force=
 clean=
 from_program=
 to_program=
-cut_header_footer=
+cut_footer=
 while test $# -gt 0
 do
 	case "$1" in
@@ -55,8 +55,8 @@ do
 	--asciidoc)
 		from_program=-asciidoc
 		to_program=-asciidoc ;;
-	--cut-header-footer)
-		cut_header_footer=-cut-header-footer ;;
+	--cut-footer)
+		cut_footer=-cut-footer ;;
 	--)
 		shift; break ;;
 	*)
@@ -118,8 +118,8 @@ construct_makemanflags () {
 from_makemanflags=$(construct_makemanflags "$from_program") &&
 to_makemanflags=$(construct_makemanflags "$to_program") &&
 
-from_dir=$from_oid$from_program$cut_header_footer &&
-to_dir=$to_oid$to_program$cut_header_footer &&
+from_dir=$from_oid$from_program$cut_footer &&
+to_dir=$to_oid$to_program$cut_footer &&
 
 # generate_render_makefile <srcdir> <dstdir>
 generate_render_makefile () {
@@ -169,12 +169,11 @@ render_tree () {
 		make -j$parallel -f - &&
 		mv "$tmp/rendered/$dname+" "$tmp/rendered/$dname"
 
-		if test "$cut_header_footer" = "-cut-header-footer"
+		if test "$cut_footer" = "-cut-footer"
 		then
 			for f in $(find "$tmp/rendered/$dname" -type f)
 			do
-				tail -n +3 "$f" | head -n -2 |
-				sed -e '1{/^$/d}' -e '${/^$/d}' >"$f+" &&
+				head -n -2 "$f" | sed -e '${/^$/d}' >"$f+" &&
 				mv "$f+" "$f" ||
 				return 1
 			done
-- 
2.23.0

