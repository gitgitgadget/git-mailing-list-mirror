Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4EF1F597
	for <e@80x24.org>; Fri, 27 Jul 2018 14:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbeG0QAC (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 12:00:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43650 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732267AbeG0QAB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 12:00:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id b15-v6so5272000wrv.10
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T2IuQfnF/HMkvFdNa7L3U4iOqEdlYV4tsZ95vzU05bk=;
        b=nVfIHeAHMBwzkgMeUD7y4qvZBmBpyHi9K8i6eGGQ7fDv7TyoN/3/vwFAoLfT6f1kAh
         j96KGBpnS/+ksfRaRRKdDanSkndvV69UgY2wQFSsoMozhTOR+u9X0R5+v/fcHwVDv9Uz
         eMxEpErRcGr4vMY/7N6FcexGXPi8lyR1IBILeoA/kihO1Fu+xRuO3vLGRiDAjhd8gSYl
         GGCaEwWjAoDtB2nwzKjNHFmYkh8Kl6GwbtWZdLlrtcl3SVXZluB7pqKOGxv6lnts1PFt
         0w3vOalvl5ebulVN7XPvTqlpBHX2S+17LCtn2oZ72vdyJ2gqD5lQ3Ut7het3BDMFJTGT
         u5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2IuQfnF/HMkvFdNa7L3U4iOqEdlYV4tsZ95vzU05bk=;
        b=gf7Z5zfMN29kbrYppnNqhYwXyVJVOJagqtqd3ptztujeqr0rQYK9dgBDJf1aow5kPP
         W9QIwruTW9nmYVRG/qv4X/xSgtyRnVxw78No7lPU/urQgf+VqwvZKOpPkoXAHSLwidMV
         YMRQ3H/f8ZMUn2q5zndnc3PSUDPC2V/HQAWQPA23ayvdGe2hEm96X4o1LjVM36FmUUo6
         Nn5TAui56A6V56a1k6oaeQG3di8kKig2UZsjdamMhjohJZg3k9tynCi0uKTsfDCLoRpx
         MuQQGN8yiAGLlBFYBwVsAwK7cBnzQRRsnCx/ipn9Au8TNdguCcktrt5osTlfsr6dCRGT
         C6Hw==
X-Gm-Message-State: AOUpUlH6nRMSiB7gSoXDdX2o7ud/IoQqfNP+BTqJzPimr0WoDmaq+fUS
        6YlDoEQQDDeGu7tBOF1t3CXF1l5+cnw=
X-Google-Smtp-Source: AAOMgpefWAU8H6ymjFnfuucytWgBzrwMOANLSsHR8vmK6CyNSaiutjJXffA7EL1BXb9dZ45mI9j9Jw==
X-Received: by 2002:adf:9d46:: with SMTP id o6-v6mr4927533wre.51.1532702267588;
        Fri, 27 Jul 2018 07:37:47 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j16-v6sm3005479wme.8.2018.07.27.07.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 07:37:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/10] fetch: implement fetch.fsck.*
Date:   Fri, 27 Jul 2018 14:37:17 +0000
Message-Id: <20180727143720.14948-8-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement support for fetch.fsck.* corresponding with the existing
receive.fsck.*. This allows for pedantically cloning repositories with
specific issues without turning off fetch.fsckObjects.

One such repository is https://github.com/robbyrussell/oh-my-zsh.git
which before this change will emit this error when cloned with
fetch.fsckObjects:

    error: object 2b7227859263b6aabcc28355b0b994995b7148b6: zeroPaddedFilemode: contains zero-padded file modes
    fatal: Error in object
    fatal: index-pack failed

Now with fetch.fsck.zeroPaddedFilemode=warn we'll warn about that
issue, but the clone will succeed:

    warning: object 2b7227859263b6aabcc28355b0b994995b7148b6: zeroPaddedFilemode: contains zero-padded file modes
    warning: object a18c4d13c2a5fa2d4ecd5346c50e119b999b807d: zeroPaddedFilemode: contains zero-padded file modes
    warning: object 84df066176c8da3fd59b13731a86d90f4f1e5c9d: zeroPaddedFilemode: contains zero-padded file modes

The motivation for this is to be able to turn on fetch.fsckObjects
globally across a fleet of computers but still be able to manually
clone various legacy repositories by either white-listing specific
issues, or better yet whitelist specific objects.

The use of --git-dir=* instead of -C in the tests could be considered
somewhat archaic, but the tests I'm adding here are duplicating the
corresponding receive.* tests with as few changes as possible.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt        | 20 +++++++++++---
 fetch-pack.c                    | 32 +++++++++++++++++++++--
 t/t5504-fetch-receive-strict.sh | 46 +++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7ff453c53b..8dace49daa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1467,6 +1467,16 @@ fetch.fsckObjects::
 	checked. Defaults to false. If not set, the value of
 	`transfer.fsckObjects` is used instead.
 
+fetch.fsck.<msg-id>::
+	Acts like `fsck.<msg-id>`, but is used by
+	linkgit:git-fetch-pack[1] instead of linkgit:git-fsck[1]. See
+	the `fsck.<msg-id>` documentation for details.
+
+fetch.fsck.skipList::
+	Acts like `fsck.skipList`, but is used by
+	linkgit:git-fetch-pack[1] instead of linkgit:git-fsck[1]. See
+	the `fsck.skipList` documentation for details.
+
 fetch.unpackLimit::
 	If the number of objects fetched over the Git native
 	transfer is below this
@@ -1602,10 +1612,12 @@ fsck.<msg-id>::
 	repositories containing such data.
 +
 Setting `fsck.<msg-id>` will be picked up by linkgit:git-fsck[1], but
-to accept pushes of such data set `receive.fsck.<msg-id>` instead.
+to accept pushes of such data set `receive.fsck.<msg-id>` instead, or
+to clone or fetch it set `fetch.fsck.<msg-id>`.
 +
 The rest of the documentation discusses `fsck.*` for brevity, but the
-same applies for the corresponding `receive.fsck.*` variables.
+same applies for the corresponding `receive.fsck.*` and
+`fetch.<msg-id>.*`. variables.
 +
 When `fsck.<msg-id>` is set, errors can be switched to warnings and
 vice versa by configuring the `fsck.<msg-id>` setting where the
@@ -1628,8 +1640,8 @@ fsck.skipList::
 	can be safely ignored such as invalid committer email addresses.
 	Note: corrupt objects cannot be skipped with this setting.
 +
-Like `fsck.<msg-id>` this variable has a corresponding
-`receive.fsck.skipList` variant.
+Like `fsck.<msg-id>` this variable has corresponding
+`receive.fsck.skipList` and `fetch.fsck.skipList` variants.
 
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
diff --git a/fetch-pack.c b/fetch-pack.c
index 7ccb9c0d45..aea2f6cf26 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -21,6 +21,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "connected.h"
+#include "fsck.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -35,6 +36,7 @@ static int agent_supported;
 static int server_supports_filtering;
 static struct lock_file shallow_lock;
 static const char *alternate_shallow_file;
+static struct strbuf fsck_msg_types = STRBUF_INIT;
 
 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
@@ -937,7 +939,8 @@ static int get_pack(struct fetch_pack_args *args,
 			 */
 			argv_array_push(&cmd.args, "--fsck-objects");
 		else
-			argv_array_push(&cmd.args, "--strict");
+			argv_array_pushf(&cmd.args, "--strict%s",
+					 fsck_msg_types.buf);
 	}
 
 	cmd.in = demux.out;
@@ -1458,6 +1461,31 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	return ref;
 }
 
+static int fetch_pack_config_cb(const char *var, const char *value, void *cb)
+{
+	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
+		const char *path;
+
+		if (git_config_pathname(&path, var, value))
+			return 1;
+		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
+			fsck_msg_types.len ? ',' : '=', path);
+		free((char *)path);
+		return 0;
+	}
+
+	if (skip_prefix(var, "fetch.fsck.", &var)) {
+		if (is_valid_msg_type(var, value))
+			strbuf_addf(&fsck_msg_types, "%c%s=%s",
+				fsck_msg_types.len ? ',' : '=', var, value);
+		else
+			warning("Skipping unknown msg id '%s'", var);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 static void fetch_pack_config(void)
 {
 	git_config_get_int("fetch.unpacklimit", &fetch_unpack_limit);
@@ -1466,7 +1494,7 @@ static void fetch_pack_config(void)
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
 
-	git_config(git_default_config, NULL);
+	git_config(fetch_pack_config_cb, NULL);
 }
 
 static void fetch_pack_setup(void)
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 57ff78c201..004bfebe98 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -145,6 +145,20 @@ test_expect_success 'push with receive.fsck.skipList' '
 	git push --porcelain dst bogus
 '
 
+test_expect_success 'fetch with fetch.fsck.skipList' '
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
+	refspec=refs/heads/bogus:refs/heads/bogus &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config fetch.fsckObjects true &&
+	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
+	git --git-dir=dst/.git config fetch.fsck.skipList dst/.git/SKIP &&
+	echo $commit >dst/.git/SKIP &&
+	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec
+'
+
+
 test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
@@ -163,6 +177,27 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	! grep "missingEmail" act
 '
 
+test_expect_success 'fetch with fetch.fsck.missingEmail=warn' '
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
+	refspec=refs/heads/bogus:refs/heads/bogus &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config fetch.fsckobjects true &&
+	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" $refspec &&
+	git --git-dir=dst/.git config \
+		fetch.fsck.missingEmail warn &&
+	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec >act 2>&1 &&
+	grep "missingEmail" act &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config fetch.fsckobjects true &&
+	git --git-dir=dst/.git config \
+		fetch.fsck.missingEmail ignore &&
+	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec >act 2>&1 &&
+	! grep "missingEmail" act
+'
+
 test_expect_success \
 	'receive.fsck.unterminatedHeader=warn triggers error' '
 	rm -rf dst &&
@@ -174,4 +209,15 @@ test_expect_success \
 	grep "Cannot demote unterminatedheader" act
 '
 
+test_expect_success \
+	'fetch.fsck.unterminatedHeader=warn triggers error' '
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config fetch.fsckobjects true &&
+	git --git-dir=dst/.git config \
+		fetch.fsck.unterminatedheader warn &&
+	test_must_fail git --git-dir=dst/.git fetch "file://$(pwd)" HEAD &&
+	grep "Cannot demote unterminatedheader" act
+'
+
 test_done
-- 
2.18.0.345.g5c9ce644c3

