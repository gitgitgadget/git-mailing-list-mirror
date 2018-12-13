Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A651520A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 15:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeLMP6m (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 10:58:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32969 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbeLMP6k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 10:58:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so14211971wmh.0
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0KBdt/z8IEPfMKjPmxD1UysUXxIPsbP2E0o0WsZlJ0s=;
        b=UhJgeSI43V0x64kowtCxsqrQAPx6ADAuB4rwlT8Ny+1tHZ/Zv+Q0BdPGyjYkoGl6aJ
         sGVfXMIKx9gdRX6glXW17XoefyuJJTP2KZPwp4tcx8Y+wKM714lGO62nBAAodznkORCv
         +Di5O8jX/8mrFsyhPgJSg9DIYUlQIWIIuOfAyE5/+vITOkyu/RjJNSddzBj124OExIWK
         5l4+iJ4NzzSMNcnaip9gUCRlH/5v9kOsoA1a1s2nYn7gPJPFJXhGxn335d5Pj4KgQ4SV
         H6KVAfNApr1smSVj/aVbU9nxH3cv9Wtx+4fwj75SgUWQ55UU131zrxNQMfdfuYWHK3dv
         DHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0KBdt/z8IEPfMKjPmxD1UysUXxIPsbP2E0o0WsZlJ0s=;
        b=eFj3AM/iidhzWrFEmaqLZKj/TznKi4rvKchabSpCFtVwyzVJQca76vJS6nzbQ2Li3c
         0B9tCWyscjI04NjKl4OorFZbJ332xtVLICeD1Sc02YwDA+H2Q6p9Hd6GBCTvg5hWV+g7
         jhwque+Twm3yqebH3i/DacTKOQSsL1WTgAaJqsTn/64+gL49HR+ZyioficdDoXo7W4Ww
         KqDEvaF3EssU+wOmiIyNf1WBYaMVEXufj+H0NesbE5LDOC0rlspINBwP2G9+uKWE3lv6
         N747aT3ZFJIdLk3cO5IGdlN2pWlp0SmUvWcKzHfHmxeBeEBvxqkv8gd6ECflm4OTb6hJ
         YslA==
X-Gm-Message-State: AA+aEWZaffW+pL+oVZO0YFkU750S9W6tSt+T07rO0PZynJs4rgDXBZw0
        VHa/jmRHtJzWyGMCGr9t3NXrgwwAJFo=
X-Google-Smtp-Source: AFSGD/Xnq4463lJPNBLPnUSPZuhi9NdktYKmqZscKJ8NdXgV85WJJwtyuOxmmLIaPYgUcSHtOqOtzQ==
X-Received: by 2002:a1c:13d1:: with SMTP id 200mr10597242wmt.4.1544716717327;
        Thu, 13 Dec 2018 07:58:37 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r69sm4047821wmd.4.2018.12.13.07.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 07:58:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/8] tests: mark & fix tests broken under GIT_TEST_PROTOCOL_VERSION=1
Date:   Thu, 13 Dec 2018 16:58:15 +0100
Message-Id: <20181213155817.27666-7-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's one t5400-send-pack.sh test which is broken under
GIT_TEST_PROTOCOL_VERSION=1. It's easier to just coerce it to run
under protocol 1. The difference in the output is that there'll be a
"version 1" line which'll make the subsequent "test_cmp". See
protocol.version in git-config(1) which notes that "1" is just "0"
with a version number.  the trace output will include fail.

Similarly in t5601-clone.sh we'll be passing an option to ssh, but
since so many tests would fail in this file let's go above & beyond
and make them pass by only testing the relevant part of the output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5400-send-pack.sh |  2 +-
 t/t5601-clone.sh     | 11 +++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index f1932ea431..571d620aed 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -288,7 +288,7 @@ test_expect_success 'receive-pack de-dupes .have lines' '
 	$shared .have
 	EOF
 
-	GIT_TRACE_PACKET=$(pwd)/trace \
+	GIT_TRACE_PACKET=$(pwd)/trace GIT_TEST_PROTOCOL_VERSION= \
 	    git push \
 		--receive-pack="unset GIT_TRACE_PACKET; git-receive-pack" \
 		fork HEAD:foo &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 8bbc7068ac..a7b7ab327c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -325,7 +325,7 @@ copy_ssh_wrapper_as () {
 
 expect_ssh () {
 	test_when_finished '
-		(cd "$TRASH_DIRECTORY" && rm -f ssh-expect && >ssh-output)
+		(cd "$TRASH_DIRECTORY" && rm -f ssh-expect ssh-output.munged && >ssh-output)
 	' &&
 	{
 		case "$#" in
@@ -341,7 +341,14 @@ expect_ssh () {
 			echo "ssh: $1 $2 git-upload-pack '$3' $4"
 		esac
 	} >"$TRASH_DIRECTORY/ssh-expect" &&
-	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
+	(
+		cd "$TRASH_DIRECTORY" &&
+		# We don't care about this trivial difference in
+		# output with GIT_TEST_PROTOCOL_VERSION=[12]
+		sed 's/ssh: -o SendEnv=GIT_PROTOCOL /ssh: /' <ssh-output >ssh-output.munged &&
+		mv ssh-output.munged ssh-output &&
+		test_cmp ssh-expect ssh-output
+	)
 }
 
 test_expect_success 'clone myhost:src uses ssh' '
-- 
2.20.0.405.gbc1bbc6f85

