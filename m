Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CFF71F405
	for <e@80x24.org>; Mon, 17 Dec 2018 22:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeLQWQl (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 17:16:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35220 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeLQWQk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 17:16:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so13925589wrb.2
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 14:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B0+eAntMIe5JKkwq9fctCzHxtUh8MySCDtkcBZ17HH8=;
        b=tyoZ4jyrUMi52ZUVgUg5cvnVyd+7g4LYaOvL1L46bs+agWUEcmbovD1gc2YKV4Kk5l
         30sz4RqmOd9d5FFYX+2QmdQJnZ9mO4JuLvKXCMHxuL3e6GyFDCL8BmnF4E01ue1nMu90
         e1tMDP8CnfchrOHwdf1XE33DN6yHlsGMXkCrsigf68UMVLAIFtL4iO1S+BzunIzV8fH8
         WJjKaYTsIXLESnrb0W3b9MynXX0SVrFY52k/YMT00e3U+x4ksd0deUFWeolvOgYlR51Q
         wAIGVu5VuRmIBnmJ6cjTDAgzXa6PQc1L35K9uMK/QYYG2TdnJY4gx35JC05/3EAXNTr6
         ZVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B0+eAntMIe5JKkwq9fctCzHxtUh8MySCDtkcBZ17HH8=;
        b=GVe9MPFwN2D0nudkB07EMlXaNYZqBZBpm+UEEM6LQWTf1V/le6sDJ6ae600qPvBa6p
         PQuACM3k7SFUkOu+QALYh+Atghg2UxlyvINwRRtfd4zKBn++byFs4SDKa0JPsBuKuVkM
         z+4q84xry21l1dpR0kxzy30kpp59tyVAhEt4gMRjRM9F79La82741+1mRXcSm18P96e6
         5imFt2OP4YVLDcDftfrvYsV83Zs0C6kqer+X6Xd0GqvDGoozN2t4eLMsw83x5lxGsgdW
         L2EwQY+TSbBrFeAhT+qVD+yjsEvIYhjgNQhcGWN2iorvha5UMjMqf2EQSYFnU08JoD7R
         jH+Q==
X-Gm-Message-State: AA+aEWbIIAPbNdaEZ7BxtC7lRM9wBYOAJaQoZRfiz8rr4ntwMXNa2GfG
        O4jMiCvFadWLXel9W+rovVOzY54m
X-Google-Smtp-Source: AFSGD/XCFjC687MBH1ZLTXqhVc+MPBsPtreb/fWI9dnP0He+8o8BeLUTXi27fJcrblDlramwjggghw==
X-Received: by 2002:adf:ef0d:: with SMTP id e13mr6734282wro.29.1545084996008;
        Mon, 17 Dec 2018 14:16:36 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o17sm645535wmg.35.2018.12.17.14.16.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 14:16:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Fredrik Medley <fredrik.medley@gmail.com>,
        David Turner <novalis@novalis.org>,
        Matt McCutchen <matt@mattmccutchen.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] upload-pack: turn on uploadpack.allowAnySHA1InWant=true
Date:   Mon, 17 Dec 2018 23:16:25 +0100
Message-Id: <20181217221625.1523-1-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181217195713.GA10673@sigill.intra.peff.net>
References: <20181217195713.GA10673@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unconditionally turn on uploadpack.allowAnySHA1InWant=true which means
that the lesser uploadpack.allow{Tip,Reachable}SHA1InWant settings are
implicitly "true" as well.

This is because as mentioned in 235ec24352e ("doc: mention transfer
data leaks in more places", 2016-11-14) this has always been leaky,
and thus lulls users into a false sense of security. Better to not
make promises we're not confident we can keep.

Now setting any of uploadpack.allow{Tip,Reachable,Any}SHA1InWant will
warn, to e.g. point users who've explicitly set it to "false" to the
documentation. They're probably relying on behavior that was always
buggy. We may have users who trusted it to be "false" by default, but
warning if it's set seems like a good trade-off.

This change also has the effect of making any operation that needed
uploadpack.allowReachableSHA1InWant=true much faster, since we won't
need any reachability check.

This change doesn't do any of the hard work of extracting the now-dead
ALLOW_* code out of upload-pack.c and fetch-pack.c. Most of that was
changed or added in the following commits:

- 9f9fb57063a ("upload-pack: turn on uploadpack.allowAnySHA1InWant=true", 2018-12-17)
- 6e7b66eebd1 ("fetch: fetch objects by their exact SHA-1 object names", 2013-01-29)
- 7199c093ad4 ("upload-pack: prepare to extend allow-tip-sha1-in-want", 2015-05-21)
- 68ee628932c ("upload-pack: optionally allow fetching reachable sha1", 2015-05-21)
- f8edeaa05d8 ("upload-pack: optionally allow fetching any sha1", 2016-11-11)

That cleanup step can be done later. Starting with a change to switch
the default (and only) value and tweaking the docs makes it easier to
reason about this than fully ripping out the code right away.

See https://public-inbox.org/git/87pnu51kac.fsf@evledraar.gmail.com/
and related messages for further discussion.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/uploadpack.txt   | 48 +++++++++++++++----------
 Documentation/transfer-data-leaks.txt |  8 +++++
 t/t0410-partial-clone.sh              |  2 --
 t/t1090-sparse-checkout-scope.sh      |  1 -
 t/t5500-fetch-pack.sh                 | 10 +++---
 t/t5512-ls-remote.sh                  | 14 ++++++++
 t/t5516-fetch-push.sh                 | 50 +++++++++++++--------------
 t/t5551-http-fetch-smart.sh           |  4 ---
 t/t5601-clone.sh                      |  3 --
 t/t5616-partial-clone.sh              |  8 +----
 t/t5702-protocol-v2.sh                |  1 -
 t/t7406-submodule-update.sh           |  5 +--
 upload-pack.c                         | 18 +++-------
 13 files changed, 87 insertions(+), 85 deletions(-)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index ed1c835695c..854801bd6cc 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -1,31 +1,41 @@
 uploadpack.hideRefs::
 	This variable is the same as `transfer.hideRefs`, but applies
 	only to `upload-pack` (and so affects only fetches, not pushes).
-	An attempt to fetch a hidden ref by `git fetch` will fail.  See
-	also `uploadpack.allowTipSHA1InWant`.
++
+This can be used in some setups to reduce the size of the ref
+advertisement, see also `protocol.version` for using a protocol
+version that allows them to be filtered by the client.
++
+In earlier versions of Git attempts to fetch an object pointed to by a
+hidden ref would fail, this is no longer the case. See
+`uploadpack.allowAnySHA1InWant`.
 
 uploadpack.allowTipSHA1InWant::
-	When `uploadpack.hideRefs` is in effect, allow `upload-pack`
-	to accept a fetch request that asks for an object at the tip
-	of a hidden ref (by default, such a request is rejected).
-	See also `uploadpack.hideRefs`.  Even if this is false, a client
-	may be able to steal objects via the techniques described in the
-	"SECURITY" section of the linkgit:gitnamespaces[7] man page; it's
-	best to keep private data in a separate repository.
+	Depreacted. Used to allow `upload-pack` to accept a fetch
+	request that asked for an object at the tip of a hidden
+	ref. Now always `true`. See `uploadpack.allowAnySHA1InWant`
+	below for details.
 
 uploadpack.allowReachableSHA1InWant::
-	Allow `upload-pack` to accept a fetch request that asks for an
-	object that is reachable from any ref tip. However, note that
-	calculating object reachability is computationally expensive.
-	Defaults to `false`.  Even if this is false, a client may be able
-	to steal objects via the techniques described in the "SECURITY"
-	section of the linkgit:gitnamespaces[7] man page; it's best to
-	keep private data in a separate repository.
+	Depreacted. Used to allow `upload-pack` to accept a fetch
+	request that asked for an object that was reachable from any
+	ref tip. Now always `true`. See
+	`uploadpack.allowAnySHA1InWant` below for details.
 
 uploadpack.allowAnySHA1InWant::
-	Allow `upload-pack` to accept a fetch request that asks for any
-	object at all.
-	Defaults to `false`.
+	Deprecated. Before Git version 2.21 the
+	`uploadpack.allow{Tip,Any,Reachable}SHA1InWant` settings were
+	`false` by default. Now they're unconditionally `true`, which
+	means fetch request that ask for any object in the object
+	store will be accepted, regardless of whether such an object
+	is at the tip of a ref, reachable by no ref etc.
++
+The reason for the change in default is as noted in the "SECURITY"
+section of linkgit:git-fetch[1] a determined client can get to any
+previously forbidden objects the server has access to by manipulating
+the client/server dialog. If you host objects that should be kept
+secret from some clients it's best to keep them in a separate
+repository.
 
 uploadpack.keepAlive::
 	When `upload-pack` has started `pack-objects`, there may be a
diff --git a/Documentation/transfer-data-leaks.txt b/Documentation/transfer-data-leaks.txt
index 914bacc39e0..f8beb334b84 100644
--- a/Documentation/transfer-data-leaks.txt
+++ b/Documentation/transfer-data-leaks.txt
@@ -28,3 +28,11 @@ The known attack vectors are as follows:
   an object Y that the attacker already has, and the attacker falsely
   claims to have X and not Y, so the victim sends Y as a delta against X.
   The delta reveals regions of X that are similar to Y to the attacker.
+
+Before Git version 2.21 the
+`uploadpack.allow{Tip,Any,Reachable}SHA1InWant` allowed for tweaking
+linkgit:git-upload-pack[1] behavior to refuse to serve some refs. As
+noted above this served to lull users into a false sense of security,
+and the fetch protocol will now allow clients to fetch any object in
+the ref store. See `uploadpack.allowAnySHA1InWant` in
+linkgit:git-config[1].
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index ba3887f178b..a9d24a94d9f 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -192,7 +192,6 @@ test_expect_success 'fetching of missing blobs works' '
 	git hash-object repo/foo.t >blobhash &&
 	rm -rf repo/.git/objects/* &&
 
-	git -C server config uploadpack.allowanysha1inwant 1 &&
 	git -C server config uploadpack.allowfilter 1 &&
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "origin" &&
@@ -211,7 +210,6 @@ test_expect_success 'fetching of missing trees does not fetch blobs' '
 	git hash-object repo/foo.t >blobhash &&
 	rm -rf repo/.git/objects/* &&
 
-	git -C server config uploadpack.allowanysha1inwant 1 &&
 	git -C server config uploadpack.allowfilter 1 &&
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "origin" &&
diff --git a/t/t1090-sparse-checkout-scope.sh b/t/t1090-sparse-checkout-scope.sh
index 090b7fc3d35..4de2e2dd1bb 100755
--- a/t/t1090-sparse-checkout-scope.sh
+++ b/t/t1090-sparse-checkout-scope.sh
@@ -68,7 +68,6 @@ test_expect_success 'in partial clone, sparse checkout only fetches needed blobs
 	git clone "file://$(pwd)/server" client &&
 
 	test_config -C server uploadpack.allowfilter 1 &&
-	test_config -C server uploadpack.allowanysha1inwant 1 &&
 	echo a >server/a &&
 	echo bb >server/b &&
 	mkdir server/c &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 086f2c40f68..b639629863d 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -592,8 +592,7 @@ test_expect_success 'fetch-pack can fetch a raw sha1' '
 		test_commit 1 &&
 		test_commit 2 &&
 		git update-ref refs/hidden/one HEAD^ &&
-		git config transfer.hiderefs refs/hidden &&
-		git config uploadpack.allowtipsha1inwant true
+		git config transfer.hiderefs refs/hidden
 	) &&
 	git fetch-pack hidden $(git -C hidden rev-parse refs/hidden/one)
 '
@@ -619,7 +618,7 @@ test_expect_success 'fetch-pack can fetch a raw sha1 overlapping a named ref' '
 		$(git -C server rev-parse refs/tags/1) refs/tags/1
 '
 
-test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised as a ref' '
+test_expect_success 'fetch-pack can fetch a raw sha1 that is not advertised as a ref' '
 	rm -rf server &&
 
 	git init server &&
@@ -628,9 +627,8 @@ test_expect_success 'fetch-pack cannot fetch a raw sha1 that is not advertised a
 	test_commit -C server 6 &&
 
 	git init client &&
-	test_must_fail git -C client fetch-pack ../server \
-		$(git -C server rev-parse refs/heads/master^) 2>err &&
-	test_i18ngrep "Server does not allow request for unadvertised object" err
+	git -C client fetch-pack ../server \
+		$(git -C server rev-parse refs/heads/master^)
 '
 
 check_prot_path () {
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 32e722db2ed..0cd1aad9597 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -195,6 +195,20 @@ do
 		! grep refs/tags/magic/one actual
 	'
 
+
+	test_expect_success "fetching a divergent object hidden by $configsection.hiderefs" "
+		test_when_finished 'test_unconfig $configsection.hiderefs' &&
+		git config --add $configsection.hiderefs refs/tags &&
+		test_when_finished 'git tag -d magic/divergent' &&
+		git tag -a -m'a tag' magic/divergent &&
+		SHA1_TAG=\$(git rev-parse magic/divergent) &&
+		echo \$SHA1_TAG >expect &&
+		git init client &&
+		test_when_finished 'rm -r client' &&
+		git -C client fetch ../ \$SHA1_TAG:refs/tags/magic/divergent &&
+		git -C client rev-parse magic/divergent >actual &&
+		test_cmp expect actual
+	"
 done
 
 test_expect_success 'overrides work between mixed transfer/upload-pack hideRefs' '
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 37e8e80893d..8f2b12c17a5 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1147,26 +1147,14 @@ test_expect_success 'fetch exact SHA1' '
 		git prune &&
 		test_must_fail git cat-file -t $the_commit &&
 
-		# fetching the hidden object should fail by default
-		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
-		test_i18ngrep "Server does not allow request for unadvertised object" err &&
-		test_must_fail git rev-parse --verify refs/heads/copy &&
+		# fetching the object should work
+		git fetch -v ../testrepo $the_commit:refs/heads/copy &&
+		git rev-parse --verify refs/heads/copy &&
 
-		# the server side can allow it to succeed
-		(
-			cd ../testrepo &&
-			git config uploadpack.allowtipsha1inwant true
-		) &&
-
-		git fetch -v ../testrepo $the_commit:refs/heads/copy master:refs/heads/extra &&
 		cat >expect <<-EOF &&
 		$the_commit
-		$the_first_commit
 		EOF
-		{
-			git rev-parse --verify refs/heads/copy &&
-			git rev-parse --verify refs/heads/extra
-		} >actual &&
+		git rev-parse --verify refs/heads/copy >actual &&
 		test_cmp expect actual
 	)
 '
@@ -1190,6 +1178,25 @@ test_expect_success 'fetch exact SHA1 in protocol v2' '
 	git -C child fetch -v ../testrepo $the_commit:refs/heads/copy
 '
 
+for state in true false
+do
+	test_expect_success "Deprecated uploadpack.*=$state settings warn" "
+		mk_empty deprecated-warnings &&
+		test_commit -C deprecated-warnings A &&
+		test_config -C deprecated-warnings uploadpack.allowTipSHA1InWant $state &&
+		test_config -C deprecated-warnings uploadpack.allowReachableSHA1InWant $state &&
+		test_config -C deprecated-warnings uploadpack.allowAnySHA1InWant $state &&
+		mk_empty target &&
+		(
+			cd target &&
+			git fetch ../deprecated-warnings/.git refs/tags/A:refs/tags/A 2>stderr &&
+			test_i18ngrep 'warning: .*uploadpack.allowTipSHA1InWant .*deprecated' stderr &&
+			test_i18ngrep 'warning: .*uploadpack.allowReachableSHA1InWant.* deprecated' stderr &&
+			test_i18ngrep 'warning: .*uploadpack.allowAnySHA1InWant.* deprecated' stderr
+		)
+	"
+done
+
 for configallowtipsha1inwant in true false
 do
 	test_expect_success "shallow fetch reachable SHA1 (but not a ref), allowtipsha1inwant=$configallowtipsha1inwant" '
@@ -1204,8 +1211,6 @@ do
 		mk_empty shallow &&
 		(
 			cd shallow &&
-			test_must_fail git fetch --depth=1 ../testrepo/.git $SHA1 &&
-			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
 			git fetch --depth=1 ../testrepo/.git $SHA1 &&
 			git cat-file commit $SHA1
 		)
@@ -1232,15 +1237,10 @@ do
 		mk_empty shallow &&
 		(
 			cd shallow &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3 &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_1 &&
-			git --git-dir=../testrepo/.git config uploadpack.allowreachablesha1inwant true &&
+			git fetch ../testrepo/.git $SHA1_3 &&
 			git fetch ../testrepo/.git $SHA1_1 &&
 			git cat-file commit $SHA1_1 &&
-			test_must_fail git cat-file commit $SHA1_2 &&
-			git fetch ../testrepo/.git $SHA1_2 &&
-			git cat-file commit $SHA1_2 &&
-			test_must_fail ok=sigpipe git fetch ../testrepo/.git $SHA1_3
+			git cat-file commit $SHA1_2
 		)
 	'
 done
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 8630b0cc390..b8f7c0b5563 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -283,7 +283,6 @@ test_expect_success 'test allowreachablesha1inwant' '
 	test_when_finished "rm -rf test_reachable.git" &&
 	server="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	master_sha=$(git -C "$server" rev-parse refs/heads/master) &&
-	git -C "$server" config uploadpack.allowreachablesha1inwant 1 &&
 
 	git init --bare test_reachable.git &&
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
@@ -302,7 +301,6 @@ test_expect_success 'test allowreachablesha1inwant with unreachable' '
 
 	server="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	master_sha=$(git -C "$server" rev-parse refs/heads/master) &&
-	git -C "$server" config uploadpack.allowreachablesha1inwant 1 &&
 
 	git init --bare test_reachable.git &&
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
@@ -321,13 +319,11 @@ test_expect_success 'test allowanysha1inwant with unreachable' '
 
 	server="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
 	master_sha=$(git -C "$server" rev-parse refs/heads/master) &&
-	git -C "$server" config uploadpack.allowreachablesha1inwant 1 &&
 
 	git init --bare test_reachable.git &&
 	git -C test_reachable.git remote add origin "$HTTPD_URL/smart/repo.git" &&
 	test_must_fail git -C test_reachable.git fetch origin "$(git rev-parse HEAD)" &&
 
-	git -C "$server" config uploadpack.allowanysha1inwant 1 &&
 	git -C test_reachable.git fetch origin "$(git rev-parse HEAD)"
 '
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 8bbc7068acb..ec7a3c46528 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -646,7 +646,6 @@ partial_clone () {
 	test_commit -C "$SERVER" two &&
 	HASH2=$(git hash-object "$SERVER/two.t") &&
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
-	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
 
 	git clone --filter=blob:limit=0 "$URL" client &&
 
@@ -689,7 +688,6 @@ test_expect_success 'batch missing blob request during checkout' '
 	git -C server commit -m x &&
 
 	test_config -C server uploadpack.allowfilter 1 &&
-	test_config -C server uploadpack.allowanysha1inwant 1 &&
 
 	git clone --filter=blob:limit=0 "file://$(pwd)/server" client &&
 
@@ -720,7 +718,6 @@ test_expect_success 'batch missing blob request does not inadvertently try to fe
 	git -C server commit -m x &&
 
 	test_config -C server uploadpack.allowfilter 1 &&
-	test_config -C server uploadpack.allowanysha1inwant 1 &&
 
 	# Make sure that it succeeds
 	git clone --filter=blob:limit=0 "file://$(pwd)/server" client
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 336f02a41a6..213899a690d 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -25,8 +25,7 @@ test_expect_success 'setup normal src repo' '
 # bare clone "src" giving "srv.bare" for use as our server.
 test_expect_success 'setup bare clone for server' '
 	git clone --bare "file://$(pwd)/src" srv.bare &&
-	git -C srv.bare config --local uploadpack.allowfilter 1 &&
-	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
+	git -C srv.bare config --local uploadpack.allowfilter 1
 '
 
 # do basic partial clone from "srv.bare"
@@ -159,7 +158,6 @@ test_expect_success 'partial clone with transfer.fsckobjects=1 uses index-pack -
 	git init src &&
 	test_commit -C src x &&
 	test_config -C src uploadpack.allowfilter 1 &&
-	test_config -C src uploadpack.allowanysha1inwant 1 &&
 
 	GIT_TRACE="$(pwd)/trace" git -c transfer.fsckobjects=1 \
 		clone --filter="blob:none" "file://$(pwd)/src" dst &&
@@ -213,7 +211,6 @@ test_expect_success 'partial clone fetches blobs pointed to by refs even if norm
 	git init src &&
 	test_commit -C src x &&
 	test_config -C src uploadpack.allowfilter 1 &&
-	test_config -C src uploadpack.allowanysha1inwant 1 &&
 
 	# Create a tag pointing to a blob.
 	BLOB=$(echo blob-contents | git -C src hash-object --stdin -w) &&
@@ -229,7 +226,6 @@ test_expect_success 'fetch what is specified on CLI even if already promised' '
 	git init src &&
 	test_commit -C src foo &&
 	test_config -C src uploadpack.allowfilter 1 &&
-	test_config -C src uploadpack.allowanysha1inwant 1 &&
 
 	git hash-object --stdin <src/foo.t >blob &&
 
@@ -257,7 +253,6 @@ test_expect_success 'upon cloning, check that all refs point to objects' '
 	test_create_repo "$SERVER" &&
 	test_commit -C "$SERVER" foo &&
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
-	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
 
 	# Create a tag pointing to a blob.
 	BLOB=$(echo blob-contents | git -C "$SERVER" hash-object --stdin -w) &&
@@ -293,7 +288,6 @@ test_expect_success 'when partial cloning, tolerate server not sending target of
 	test_create_repo "$SERVER" &&
 	test_commit -C "$SERVER" foo &&
 	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
-	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
 
 	# Create an annotated tag pointing to a blob.
 	BLOB=$(echo blob-contents | git -C "$SERVER" hash-object --stdin -w) &&
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 0f2b09ebb8d..af16f139a4a 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -274,7 +274,6 @@ test_expect_success 'setup filter tests' '
 	test_commit -C server message2 a.txt &&
 	git -C server config protocol.version 2 &&
 	git -C server config uploadpack.allowfilter 1 &&
-	git -C server config uploadpack.allowanysha1inwant 1 &&
 	git -C server config protocol.version 2
 '
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index e87164aa8ff..cf5bda08690 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -943,10 +943,7 @@ test_expect_success 'submodule update clone shallow submodule outside of depth'
 		cd super3 &&
 		sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
 		mv -f .gitmodules.tmp .gitmodules &&
-		test_must_fail git submodule update --init --depth=1 2>actual &&
-		test_i18ngrep "Direct fetching of that commit failed." actual &&
-		git -C ../submodule config uploadpack.allowReachableSHA1InWant true &&
-		git submodule update --init --depth=1 >actual &&
+		git submodule update --init --depth=1 &&
 		git -C submodule log --oneline >out &&
 		test_line_count = 1 out
 	)
diff --git a/upload-pack.c b/upload-pack.c
index 5e81f1ff24f..18e4c2d2452 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -54,7 +54,8 @@ static int no_progress, daemon_mode;
 #define ALLOW_REACHABLE_SHA1	02
 /* Allow request of any sha1. Implies ALLOW_TIP_SHA1 and ALLOW_REACHABLE_SHA1. */
 #define ALLOW_ANY_SHA1	07
-static unsigned int allow_unadvertised_object_request;
+static unsigned int allow_unadvertised_object_request = (
+	ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1 | ALLOW_ANY_SHA1);
 static int shallow_nr;
 static struct object_array extra_edge_obj;
 static unsigned int timeout;
@@ -1019,20 +1020,11 @@ static int find_symref(const char *refname, const struct object_id *oid,
 static int upload_pack_config(const char *var, const char *value, void *unused)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
-		if (git_config_bool(var, value))
-			allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
-		else
-			allow_unadvertised_object_request &= ~ALLOW_TIP_SHA1;
+		warning(_("The uploadpack.allowTipSHA1InWant setting is deprecated, and now always 'true'"));
 	} else if (!strcmp("uploadpack.allowreachablesha1inwant", var)) {
-		if (git_config_bool(var, value))
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-		else
-			allow_unadvertised_object_request &= ~ALLOW_REACHABLE_SHA1;
+		warning(_("The uploadpack.allowReachableSHA1InWant setting is deprecated, and now always 'true'"));
 	} else if (!strcmp("uploadpack.allowanysha1inwant", var)) {
-		if (git_config_bool(var, value))
-			allow_unadvertised_object_request |= ALLOW_ANY_SHA1;
-		else
-			allow_unadvertised_object_request &= ~ALLOW_ANY_SHA1;
+		warning(_("The uploadpack.allowAnySHA1InWant setting is deprecated, and now always 'true'"));
 	} else if (!strcmp("uploadpack.keepalive", var)) {
 		keepalive = git_config_int(var, value);
 		if (!keepalive)
-- 
2.20.0.405.gbc1bbc6f85

