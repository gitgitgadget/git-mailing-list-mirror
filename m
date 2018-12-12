Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29015211B3
	for <e@80x24.org>; Wed, 12 Dec 2018 00:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeLLA2M (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 19:28:12 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:40545 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLA2K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 19:28:10 -0500
Received: by mail-yb1-f201.google.com with SMTP id i15-v6so10716047ybp.7
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 16:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AYod6JPQO4bReuwQzGcTE4hHgdq++Ph1Uub7o1mqHqk=;
        b=U8w6OFLJx3WRIqy+pOtVwaiVlEU5Tl5pG5C1k4IKpmoy4va5MwQROLOqFJlh3jyDkP
         vYHaDrp865iy/olujDdPOeRuIxDgFMYMjamxjFFZfL5smnPO0aYddSrHWW8dxkZbHOV5
         VFrsd4VcTlX0RitRep8F36VRTk/djew57fMGAPEAHoufsRrIP3nBmdWGK5sBoP0VtTDT
         D17IEzxUDpqDOiE645XTusaygv6n3rbrjrPEckKBB8a+YttLd6YxFcqfvIC7fJUIoE21
         uZ8eWy/Vnyf7/O76fyDj+b8etLHf8GTcfZiCYCxr1fdzMH6DMx8uFiNEkmAVru0HY9Lx
         9TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AYod6JPQO4bReuwQzGcTE4hHgdq++Ph1Uub7o1mqHqk=;
        b=d/hIDhx3OAKqJpFF+ku6imJ86X267GDu7NiK/FVrOwjUU0mTLHD/F/DHeMSNBLdzuw
         A9hjh6x5S4Bqvsgj2WjIi52/QiKJMxHspZTrQ3rUHDsIWTT41N0HzRdv6y5ZLjtcfmUN
         aFEQwHVINlGYkdL+bSxY7z2fRktqUSzJg0ychPwV3+/KERHriMLQkHxKDdtbN56UgFqe
         toRS87fkFKGSjRbg1GRC9cCGCSMzAjUVnNnAafD0ALJmJy0zPQ4jDPpkwblQqxjtRtGF
         /M8B+C8h/VWkVf6m4S5CESDM4fkWEfacINz9rgtOFKsY/8AvRzz2HIcylw0Sfg7RVhTM
         gyEA==
X-Gm-Message-State: AA+aEWY0W56TOE8ipDXrKNLzxCl5lEOzRkHf5UTd+8hdYkDdGpKwHXc+
        hk37wZitSAEMkLH6J4Bnp/MMmzCLm3V+8NHly/dwvWxw73zQH1Z/TrEp3FF83UMnHRC/thB9UYU
        vronLfK3FkLSFD8XLzG07BbVeGi3p6CAVku3+ex/7sKmvCBGZZkQMHrXo7GuTVi+hS6QC4Z2v/Q
        4S
X-Google-Smtp-Source: AFSGD/U7CwJgWWlJlVDyj9qRwF7BRwZKYwkTO9iozVid+638jAKiAKCn9b8ME2C2Jjg9B9/uSaptKvZT8ta3vfDHBtNu
X-Received: by 2002:a25:b945:: with SMTP id s5-v6mr10530495ybm.63.1544574489222;
 Tue, 11 Dec 2018 16:28:09 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:27:57 -0800
In-Reply-To: <cover.1544573604.git.jonathantanmy@google.com>
Message-Id: <a09a0ac1218930eab01ed6ae92a20d84ab12a03e.1544573604.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181211212135.21126-2-avarab@gmail.com> <cover.1544573604.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH 2/3] builtin/fetch-pack: support protocol version 2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, if support for running Git's entire test suite with protocol
v2 were added, some tests would fail because the fetch-pack CLI command
dies if it encounters protocol v2. To avoid this, teach fetch-pack
support for protocol v2.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch-pack.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 63e69a5801..f6a513495e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -55,6 +55,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 	struct packet_reader reader;
+	enum protocol_version version;
 
 	fetch_if_missing = 0;
 
@@ -219,9 +220,11 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF);
 
-	switch (discover_version(&reader)) {
+	version = discover_version(&reader);
+	switch (version) {
 	case protocol_v2:
-		die("support for protocol v2 not implemented yet");
+		get_remote_refs(fd[1], &reader, &ref, 0, NULL, NULL);
+		break;
 	case protocol_v1:
 	case protocol_v0:
 		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
@@ -231,7 +234,7 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	}
 
 	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
-			 &shallow, pack_lockfile_ptr, protocol_v0);
+			 &shallow, pack_lockfile_ptr, version);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
-- 
2.19.0.271.gfe8321ec05.dirty

