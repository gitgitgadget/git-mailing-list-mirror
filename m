Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5DD1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 16:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeHVTbu (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 15:31:50 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:41147 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbeHVTbu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 15:31:50 -0400
Received: by mail-lf1-f54.google.com with SMTP id l26-v6so1788406lfc.8
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 09:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OSQnmYUFuuzkBKbC+Yg42M7BG4D4ZPWwzoFZZkt9nZ4=;
        b=Orp4j35nUTjVND6nXuK/zFtthPjWg1ox+UbttsMaAEDVmTFUUORehUAJQo36yh1GNx
         pWn/aoQeuNckVHs717++jQepcHNQKqRfgi4/k+clXyvGu/vOrl53dq+WLdPP+0M7jCbk
         doqry/8pafkoZbtVf65nGIyK8PZWPZ+LjH+oh/I8VcVSrvq7z4UoKbVr9vM96g1Sq7ap
         8Z4FhMdc4dtWsc/yE5+gVWUY63iZ68Wnadf6VFcfZokeN9SR3ABad1gZ8IAUH1a6x/20
         zMY3Q5Us71HHTP672YaQyMN6TYZWeOHfQG3eJ6dS/3gvepIPX+ZdnEXNAU4urVUZizDi
         y31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OSQnmYUFuuzkBKbC+Yg42M7BG4D4ZPWwzoFZZkt9nZ4=;
        b=sEzg00NaDt/iJlWa5GVevaSNTPvf5OvnYJZVBn41D6+1nK0UUkV6m0eYdd4k/wrqxG
         EuKjPofcsbpiwFoxuc+vt+c6YQ++4VGGydRam4ElMVMRAgU/GzcQ0oa7FFM7flEWwkAV
         EX6yIYL1u6z4lHPoRxL7G1WvtOOVWS13SaxlTyms1CVFZ3ePwlj1G+LjftySZNev3NC0
         1z8DqQswD0m0SXODfCXtqBLY0UhJEB0CtPcTtenbErEM+OOHJiu6kFmhG/T9RxLDL36+
         QMZFUKxw7iJ0myZu0ZhpzDOuNswNNDRGyShf/le1TWp/wgzzcn2bCveDLtpfSec+1AaS
         J23A==
X-Gm-Message-State: AOUpUlHRg3Y+RaH56x1Z8j5VVKP9BZabeMbvsfRqF9BXauOydxOxPAOn
        p7DRPkKdcjPTK3aAydaW+t+yhBX8
X-Google-Smtp-Source: AA+uWPyv9ptpY51YzawSCDghyyNBOty5uNR2igGILlg3IWrha+lC/SErUrBR0VqC8Bi7loCIxMWFOw==
X-Received: by 2002:a19:430d:: with SMTP id q13-v6mr7318501lfa.77.1534953977789;
        Wed, 22 Aug 2018 09:06:17 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u86-v6sm375213lfi.90.2018.08.22.09.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:06:17 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/11] config.txt: move receive part out to a separate file
Date:   Wed, 22 Aug 2018 18:06:02 +0200
Message-Id: <20180822160605.21864-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.335.ga73d156e9c
In-Reply-To: <20180822160605.21864-1-pclouds@gmail.com>
References: <20180822160605.21864-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt         | 124 +------------------------------
 Documentation/receive-config.txt | 123 ++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 123 deletions(-)
 create mode 100644 Documentation/receive-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2d3baf43fb..ed809dd245 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2555,129 +2555,7 @@ include::push-config.txt[]
 
 include::rebase-config.txt[]
 
-receive.advertiseAtomic::
-	By default, git-receive-pack will advertise the atomic push
-	capability to its clients. If you don't want to advertise this
-	capability, set this variable to false.
-
-receive.advertisePushOptions::
-	When set to true, git-receive-pack will advertise the push options
-	capability to its clients. False by default.
-
-receive.autogc::
-	By default, git-receive-pack will run "git-gc --auto" after
-	receiving data from git-push and updating refs.  You can stop
-	it by setting this variable to false.
-
-receive.certNonceSeed::
-	By setting this variable to a string, `git receive-pack`
-	will accept a `git push --signed` and verifies it by using
-	a "nonce" protected by HMAC using this string as a secret
-	key.
-
-receive.certNonceSlop::
-	When a `git push --signed` sent a push certificate with a
-	"nonce" that was issued by a receive-pack serving the same
-	repository within this many seconds, export the "nonce"
-	found in the certificate to `GIT_PUSH_CERT_NONCE` to the
-	hooks (instead of what the receive-pack asked the sending
-	side to include).  This may allow writing checks in
-	`pre-receive` and `post-receive` a bit easier.  Instead of
-	checking `GIT_PUSH_CERT_NONCE_SLOP` environment variable
-	that records by how many seconds the nonce is stale to
-	decide if they want to accept the certificate, they only
-	can check `GIT_PUSH_CERT_NONCE_STATUS` is `OK`.
-
-receive.fsckObjects::
-	If it is set to true, git-receive-pack will check all received
-	objects. See `transfer.fsckObjects` for what's checked.
-	Defaults to false. If not set, the value of
-	`transfer.fsckObjects` is used instead.
-
-receive.fsck.<msg-id>::
-	Acts like `fsck.<msg-id>`, but is used by
-	linkgit:git-receive-pack[1] instead of
-	linkgit:git-fsck[1]. See the `fsck.<msg-id>` documentation for
-	details.
-
-receive.fsck.skipList::
-	Acts like `fsck.skipList`, but is used by
-	linkgit:git-receive-pack[1] instead of
-	linkgit:git-fsck[1]. See the `fsck.skipList` documentation for
-	details.
-
-receive.keepAlive::
-	After receiving the pack from the client, `receive-pack` may
-	produce no output (if `--quiet` was specified) while processing
-	the pack, causing some networks to drop the TCP connection.
-	With this option set, if `receive-pack` does not transmit
-	any data in this phase for `receive.keepAlive` seconds, it will
-	send a short keepalive packet.  The default is 5 seconds; set
-	to 0 to disable keepalives entirely.
-
-receive.unpackLimit::
-	If the number of objects received in a push is below this
-	limit then the objects will be unpacked into loose object
-	files. However if the number of received objects equals or
-	exceeds this limit then the received pack will be stored as
-	a pack, after adding any missing delta bases.  Storing the
-	pack from a push can make the push operation complete faster,
-	especially on slow filesystems.  If not set, the value of
-	`transfer.unpackLimit` is used instead.
-
-receive.maxInputSize::
-	If the size of the incoming pack stream is larger than this
-	limit, then git-receive-pack will error out, instead of
-	accepting the pack file. If not set or set to 0, then the size
-	is unlimited.
-
-receive.denyDeletes::
-	If set to true, git-receive-pack will deny a ref update that deletes
-	the ref. Use this to prevent such a ref deletion via a push.
-
-receive.denyDeleteCurrent::
-	If set to true, git-receive-pack will deny a ref update that
-	deletes the currently checked out branch of a non-bare repository.
-
-receive.denyCurrentBranch::
-	If set to true or "refuse", git-receive-pack will deny a ref update
-	to the currently checked out branch of a non-bare repository.
-	Such a push is potentially dangerous because it brings the HEAD
-	out of sync with the index and working tree. If set to "warn",
-	print a warning of such a push to stderr, but allow the push to
-	proceed. If set to false or "ignore", allow such pushes with no
-	message. Defaults to "refuse".
-+
-Another option is "updateInstead" which will update the working
-tree if pushing into the current branch.  This option is
-intended for synchronizing working directories when one side is not easily
-accessible via interactive ssh (e.g. a live web site, hence the requirement
-that the working directory be clean). This mode also comes in handy when
-developing inside a VM to test and fix code on different Operating Systems.
-+
-By default, "updateInstead" will refuse the push if the working tree or
-the index have any difference from the HEAD, but the `push-to-checkout`
-hook can be used to customize this.  See linkgit:githooks[5].
-
-receive.denyNonFastForwards::
-	If set to true, git-receive-pack will deny a ref update which is
-	not a fast-forward. Use this to prevent such an update via a push,
-	even if that push is forced. This configuration variable is
-	set when initializing a shared repository.
-
-receive.hideRefs::
-	This variable is the same as `transfer.hideRefs`, but applies
-	only to `receive-pack` (and so affects pushes, but not fetches).
-	An attempt to update or delete a hidden ref by `git push` is
-	rejected.
-
-receive.updateServerInfo::
-	If set to true, git-receive-pack will run git-update-server-info
-	after receiving data from git-push and updating refs.
-
-receive.shallowUpdate::
-	If set to true, .git/shallow can be updated when new refs
-	require new shallow roots. Otherwise those refs are rejected.
+include::receive-config.txt[]
 
 remote.pushDefault::
 	The remote to push to by default.  Overrides
diff --git a/Documentation/receive-config.txt b/Documentation/receive-config.txt
new file mode 100644
index 0000000000..65f78aac37
--- /dev/null
+++ b/Documentation/receive-config.txt
@@ -0,0 +1,123 @@
+receive.advertiseAtomic::
+	By default, git-receive-pack will advertise the atomic push
+	capability to its clients. If you don't want to advertise this
+	capability, set this variable to false.
+
+receive.advertisePushOptions::
+	When set to true, git-receive-pack will advertise the push options
+	capability to its clients. False by default.
+
+receive.autogc::
+	By default, git-receive-pack will run "git-gc --auto" after
+	receiving data from git-push and updating refs.  You can stop
+	it by setting this variable to false.
+
+receive.certNonceSeed::
+	By setting this variable to a string, `git receive-pack`
+	will accept a `git push --signed` and verifies it by using
+	a "nonce" protected by HMAC using this string as a secret
+	key.
+
+receive.certNonceSlop::
+	When a `git push --signed` sent a push certificate with a
+	"nonce" that was issued by a receive-pack serving the same
+	repository within this many seconds, export the "nonce"
+	found in the certificate to `GIT_PUSH_CERT_NONCE` to the
+	hooks (instead of what the receive-pack asked the sending
+	side to include).  This may allow writing checks in
+	`pre-receive` and `post-receive` a bit easier.  Instead of
+	checking `GIT_PUSH_CERT_NONCE_SLOP` environment variable
+	that records by how many seconds the nonce is stale to
+	decide if they want to accept the certificate, they only
+	can check `GIT_PUSH_CERT_NONCE_STATUS` is `OK`.
+
+receive.fsckObjects::
+	If it is set to true, git-receive-pack will check all received
+	objects. See `transfer.fsckObjects` for what's checked.
+	Defaults to false. If not set, the value of
+	`transfer.fsckObjects` is used instead.
+
+receive.fsck.<msg-id>::
+	Acts like `fsck.<msg-id>`, but is used by
+	linkgit:git-receive-pack[1] instead of
+	linkgit:git-fsck[1]. See the `fsck.<msg-id>` documentation for
+	details.
+
+receive.fsck.skipList::
+	Acts like `fsck.skipList`, but is used by
+	linkgit:git-receive-pack[1] instead of
+	linkgit:git-fsck[1]. See the `fsck.skipList` documentation for
+	details.
+
+receive.keepAlive::
+	After receiving the pack from the client, `receive-pack` may
+	produce no output (if `--quiet` was specified) while processing
+	the pack, causing some networks to drop the TCP connection.
+	With this option set, if `receive-pack` does not transmit
+	any data in this phase for `receive.keepAlive` seconds, it will
+	send a short keepalive packet.  The default is 5 seconds; set
+	to 0 to disable keepalives entirely.
+
+receive.unpackLimit::
+	If the number of objects received in a push is below this
+	limit then the objects will be unpacked into loose object
+	files. However if the number of received objects equals or
+	exceeds this limit then the received pack will be stored as
+	a pack, after adding any missing delta bases.  Storing the
+	pack from a push can make the push operation complete faster,
+	especially on slow filesystems.  If not set, the value of
+	`transfer.unpackLimit` is used instead.
+
+receive.maxInputSize::
+	If the size of the incoming pack stream is larger than this
+	limit, then git-receive-pack will error out, instead of
+	accepting the pack file. If not set or set to 0, then the size
+	is unlimited.
+
+receive.denyDeletes::
+	If set to true, git-receive-pack will deny a ref update that deletes
+	the ref. Use this to prevent such a ref deletion via a push.
+
+receive.denyDeleteCurrent::
+	If set to true, git-receive-pack will deny a ref update that
+	deletes the currently checked out branch of a non-bare repository.
+
+receive.denyCurrentBranch::
+	If set to true or "refuse", git-receive-pack will deny a ref update
+	to the currently checked out branch of a non-bare repository.
+	Such a push is potentially dangerous because it brings the HEAD
+	out of sync with the index and working tree. If set to "warn",
+	print a warning of such a push to stderr, but allow the push to
+	proceed. If set to false or "ignore", allow such pushes with no
+	message. Defaults to "refuse".
++
+Another option is "updateInstead" which will update the working
+tree if pushing into the current branch.  This option is
+intended for synchronizing working directories when one side is not easily
+accessible via interactive ssh (e.g. a live web site, hence the requirement
+that the working directory be clean). This mode also comes in handy when
+developing inside a VM to test and fix code on different Operating Systems.
++
+By default, "updateInstead" will refuse the push if the working tree or
+the index have any difference from the HEAD, but the `push-to-checkout`
+hook can be used to customize this.  See linkgit:githooks[5].
+
+receive.denyNonFastForwards::
+	If set to true, git-receive-pack will deny a ref update which is
+	not a fast-forward. Use this to prevent such an update via a push,
+	even if that push is forced. This configuration variable is
+	set when initializing a shared repository.
+
+receive.hideRefs::
+	This variable is the same as `transfer.hideRefs`, but applies
+	only to `receive-pack` (and so affects pushes, but not fetches).
+	An attempt to update or delete a hidden ref by `git push` is
+	rejected.
+
+receive.updateServerInfo::
+	If set to true, git-receive-pack will run git-update-server-info
+	after receiving data from git-push and updating refs.
+
+receive.shallowUpdate::
+	If set to true, .git/shallow can be updated when new refs
+	require new shallow roots. Otherwise those refs are rejected.
-- 
2.19.0.rc0.335.ga73d156e9c

