Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7514A1F42D
	for <e@80x24.org>; Fri, 25 May 2018 19:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967967AbeEYT2e (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 15:28:34 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:45561 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967587AbeEYT2a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 15:28:30 -0400
Received: by mail-wr0-f194.google.com with SMTP id w3-v6so10927168wrl.12
        for <git@vger.kernel.org>; Fri, 25 May 2018 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UwkE1iC4ffSx1wmqc9g14VBLw2DSUTSKpMbmJpdQl3M=;
        b=NNbdWYH08RkGQ/i4k35EI37Ox1DlakGis95Dq05fdMdQrQbToLisoP5ox8Gq40rAwR
         eqBEw9HZXziuHjMFGNqDLJcviA77albHnWEbPunGBlJ4g5PTU55BtK3tFiRWixT0zV9E
         F7rKee6uDI5DC3Xcm+/gk8ebt62BoNBUHsXzdF8BrinG8Ne4hNAA9OPRjAkELAPigfRn
         9Z34GurxaNXCf4A5eIoFXLQKt1TD+kvmUxCk3Bl+eLcys8N5W4sJjQ5I6c7hxmStZRh5
         3P/JnmdLtj9CN7KBFvL4amloqth5+jF3PZxc0mFlgTZ33nNhf5DRCHFIuwgCk/fSkFhr
         8Izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UwkE1iC4ffSx1wmqc9g14VBLw2DSUTSKpMbmJpdQl3M=;
        b=k+sNRQ07q3Ox/EkcN43+L3gG2uY7lcPOEqVrSc1MpQ/kc4opsOvQpZajAPmUD8VADC
         B7ZWZtFnLIzyd9lOoNtOwMoR3zKuOD7s5M38RAu0f8gCXfhHcq+tFfEc9gAaBCtDlBow
         yzcff4lYSmfHfUEtOR6S8wkQdrIRYBm7Vf4W/pzB0x/TnzKOasov0yYBAmNs/NCfWz91
         wvjb97Rn2Y1ihDgdOl+BglsvGARtpgncD4jYJiXanO8uQfWgLKeFhzmDRR+14Kjl5um9
         GQ7rNjFCGDf5loh6vsUJBKN/sQX3U9eZOLfQebuXhcPJCIgHxZuXS5A/P7T6F1CsD99a
         3zwg==
X-Gm-Message-State: ALKqPwclEvtySmPuk5YQp57C1nO89vhesQ9wF/nYDC9YUjq79nwCCNOQ
        xM3oNJD4I+19vfGGh4UcqbTQk3xv
X-Google-Smtp-Source: AB8JxZp54OotNd0iH/JwWewdyQlKcAh85qsL4U0g2Fs77iqIWWsmRNpVdggCPp9RSd9GUz30tUzWfg==
X-Received: by 2002:adf:c613:: with SMTP id n19-v6mr3077685wrg.177.1527276508830;
        Fri, 25 May 2018 12:28:28 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id a69-v6sm7276518wma.7.2018.05.25.12.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 May 2018 12:28:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] fetch: implement fetch.fsck.*
Date:   Fri, 25 May 2018 19:28:11 +0000
Message-Id: <20180525192811.25680-6-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180525192811.25680-1-avarab@gmail.com>
References: <20180525192811.25680-1-avarab@gmail.com>
In-Reply-To: <20180524193516.28713-1-avarab@gmail.com>
References: <20180524193516.28713-1-avarab@gmail.com>
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
 Documentation/config.txt        | 21 +++++++++++----
 fetch-pack.c                    | 32 +++++++++++++++++++++--
 t/t5504-fetch-receive-strict.sh | 46 +++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 7 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f97f21c022..f69cd31ad0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1426,6 +1426,16 @@ fetch.fsckObjects::
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
@@ -1561,9 +1571,10 @@ fsck.<msg-id>::
 	repositories containing such data.
 +
 Setting `fsck.<msg-id>` will be picked up by linkgit:git-fsck[1], but
-to accept pushes of such data set `receive.fsck.<msg-id>` instead. The
-rest of the documentation discusses `fsck.*` for brevity, but the same
-applies for the corresponding `receive.fsck.*` variables.
+to accept pushes of such data set `receive.fsck.<msg-id>` instead, or
+to clone or fetch it set `fetch.fsck.<msg-id>`. The rest of the
+documentation discusses `fsck.*` for brevity, but the same applies for
+the corresponding `receive.fsck.*` and `fetch.<msg-id>.*`. variables.
 +
 When `fsck.<msg-id>` is set, errors can be switched to warnings and
 vice versa by configuring the `fsck.<msg-id>` setting where the
@@ -1588,8 +1599,8 @@ fsck.skipList::
 	email addresses. Note: corrupt objects cannot be skipped with
 	this setting.
 +
-Like `fsck.<msg-id>` this variable has a corresponding
-`receive.fsck.skipList` variant.
+Like `fsck.<msg-id>` this variable has corresponding
+`receive.fsck.skipList` and `fetch.fsck.skipList` variants.
 
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
diff --git a/fetch-pack.c b/fetch-pack.c
index 490c38f833..9e4282788e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -19,6 +19,7 @@
 #include "sha1-array.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "fsck.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -33,6 +34,7 @@ static int agent_supported;
 static int server_supports_filtering;
 static struct lock_file shallow_lock;
 static const char *alternate_shallow_file;
+static struct strbuf fsck_msg_types = STRBUF_INIT;
 
 /* Remember to update object flag allocation in object.h */
 #define COMPLETE	(1U << 0)
@@ -935,7 +937,8 @@ static int get_pack(struct fetch_pack_args *args,
 			 */
 			argv_array_push(&cmd.args, "--fsck-objects");
 		else
-			argv_array_push(&cmd.args, "--strict");
+			argv_array_pushf(&cmd.args, "--strict%s",
+					 fsck_msg_types.buf);
 	}
 
 	cmd.in = demux.out;
@@ -1409,6 +1412,31 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
@@ -1417,7 +1445,7 @@ static void fetch_pack_config(void)
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
 
-	git_config(git_default_config, NULL);
+	git_config(fetch_pack_config_cb, NULL);
 }
 
 static void fetch_pack_setup(void)
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 49d3621a92..b7f5222c2b 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -135,6 +135,20 @@ test_expect_success 'push with receive.fsck.skipList' '
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
@@ -155,6 +169,27 @@ test_expect_success 'push with receive.fsck.missingEmail=warn' '
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
+	git --git-dir=dst/.git branch -D bogus &&
+	git --git-dir=dst/.git config --add \
+		receive.fsck.missingEmail ignore &&
+	git --git-dir=dst/.git config --add \
+		receive.fsck.badDate warn &&
+	git --git-dir=dst/.git fetch "file://$(pwd)" $refspec >act 2>&1 &&
+	! grep "missingEmail" act
+'
+
 test_expect_success \
 	'receive.fsck.unterminatedHeader=warn triggers error' '
 	rm -rf dst &&
@@ -166,4 +201,15 @@ test_expect_success \
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
2.17.0.290.gded63e768a

