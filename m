Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933BB210F6E
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830602; cv=none; b=rsIAzJDNcxv4vI+6N5d0lP+5RbECnbdqb2kUbn7NNxa9frAE0SViMFRgkxKo53zuQX936+4gI+axWWxpXASm8yM62GC1rTj/4WHGOamzuaWsOYwgFNlorfzOLFdq5z/3DTmq2Bd6gFtIBoMAx1Jp0zfxTdfaOHdTBqT4FR0+vbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830602; c=relaxed/simple;
	bh=6UZ6NPaB93dwITRwaQEC9l1HrfmGkEvslrvsJQs4cSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M7xvOYJraOjc28ePUkFTns+UMbRHipe87e3Kj0Zu3GcxlkXEoFjhio27B4z8U+6gbS3F/hLtnhca+y3n3mmF74RycmsSnZF8gBM+63UY+wIv8wCo3kpz9Ak+7uwn81FOVnTDTUItkQFfAIlIACrvMZij53BtXL1sxdL7DBxpu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNho3vD5; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNho3vD5"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725abf74334so4440817b3a.3
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 03:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733830599; x=1734435399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4NGtyNaxxvQ0Fi51uChUd3uXGsfuST/Ggr61mmi7oA=;
        b=DNho3vD5OF4dyXz9iwTAl4gNesuiqknRgukH821xenL9IRmf7VB1/ogn82yYgIW5Ug
         W/eHJbMwbg3fK7bdHnddI1SdO8ZuUYgWY2f8UCI9ual0t4wVo3UEODg93rXHFOxb6dwo
         6BX7i3lrblrUg2iGCw0KppF4FLE72LVWtFy+jhWWYUCCM0z0phEfI8ky4PJefUE5sl29
         ArynUAk3nGlJP4ddq/Nf6E0LV70Pa7QZ6khdOJYIVmal9aHIc1F7boWMRmBtjZmwT5aX
         fkpnUjGRJrISxnFWvcvhPqzgJ0oYArbu+G6Pja6dgwzSE1YoOoOzAcqwtq3BPrXDyvre
         waew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830599; x=1734435399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4NGtyNaxxvQ0Fi51uChUd3uXGsfuST/Ggr61mmi7oA=;
        b=rPPafmyUkV7yeg05jTPp1sOwTITU966dBfelcSr5fT+rjQTd4spcmz5HVXX1YxiT14
         DH9T3++CKfxEeyFUPZH92t30eoLo4FRdinYkdY31G0LsmVIr8S8iNY9ozVP1N0Scaz/i
         epTORSeFRO/1Igyp8SVghGTyRKXPCbSQwwF5uG9gIBkN9XnMHz4Z5IkUWc4lzywPKU9V
         gSZ5K5DtdsOdLSbRzKXuf5x5Y1JM+bH1NEEy5nJAagSssiuOuOeJyYwWvMCKvoKCJuQE
         /qnLoLDUwpsNwMe/k7gqpj26ZOJK71FF64dDehb0w2Rt9dgo7ZpjpLG2pooA74aDTLfE
         6Feg==
X-Gm-Message-State: AOJu0YxGVZk4EFKR+HVmO3MLveRoqkEMlqWI6101LaVd+UTrpk23SaDU
	zBKXGELgY2vvFyvwv8Usr6Dzrtv2FYYTZPQkTKOuHm6opdQriIohxH1prA==
X-Gm-Gg: ASbGncvrumhVKt+VdJZcT0h/PE8ZDDU7FqQWoqS3i94ZaKkAU3eczd0DmJCmn2ObwOC
	boXiFyoNXiiWLAm9wa+o70xJlAtTvuM9UDZiemhlHIg6VWXbYLyogcCKJtkMoSklqIpIKhhZkwR
	ts1SOMG5+7mQ7CiDSRP7GS6EkTxixgzAu6nrFZyxihCXfQmeCF/mM9oFjyahG/3LAGEKI5z/iLC
	yShe4BsIkV5XkwMzaZsg/aOH43IPVSQtdMGhHMaqpu/C6MDNxBrqU5Yop+Z9TvF3oT2N3kWZeut
	TQ0LQEhwe3Mb08+x+rWjDPjfvP8XpnSMxQXuHqZ9zaE17A==
X-Google-Smtp-Source: AGHT+IFQtdp+NeT4B/jP+VO41ToWdpB30XFHcpyGyQT6sK9eZHxyfse8AJb/dwkDE8ujjM8W3T52tw==
X-Received: by 2002:a05:6a00:178e:b0:728:e196:b5b5 with SMTP id d2e1a72fcca58-728e196b7c2mr3321764b3a.20.1733830599589;
        Tue, 10 Dec 2024 03:36:39 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd54aa2399sm2554532a12.39.2024.12.10.03.36.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:36:39 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 6/8] send-pack: new return code "ERROR_SEND_PACK_BAD_REF_STATUS"
Date: Tue, 10 Dec 2024 19:36:26 +0800
Message-Id: <77f5e128fc1b66a9c8b0df3ce274a98921800685.1733830410.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com> <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The "push_refs" function in the transport_vtable is the handler for
git-push operation. All the "push_refs" functions for different
transports (protocols) should have the same behavior, but the behavior
of "git_transport_push()" function for builtin_smart_vtable in
"transport.c" (which calls "send_pack()" in "send-pack.c") differs from
the handler of the HTTP protocol.

The "push_refs()" function for the HTTP protocol which calls the
"push_refs_with_push()" function in "transport-helper.c" will return 0
even when a bad REF_STATUS (such as REF_STATUS_REJECT_NONFASTFORWARD)
was found. But "send_pack()" for Git smart protocol will return -1 for
a bad REF_STATUS.

We cannot ignore bad REF_STATUS directly in the "send_pack()" function,
because the function is also used in "builtin/send-pack.c". So we add a
new non-zero error code "SEND_PACK_ERROR_REF_STATUS" for "send_pack()".
We can choose to ignore the specific error code in the
"git_transport_push()" function to have the same behavior as
"push_refs()" for HTTP protocol.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 send-pack.c | 9 ++-------
 send-pack.h | 3 +++
 transport.c | 7 +++++++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 6677c44e8a..f1556dd53c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -630,7 +630,7 @@ int send_pack(struct send_pack_args *args,
 				reject_atomic_push(remote_refs, args->send_mirror);
 				error("atomic push failed for ref %s. status: %d",
 				      ref->name, ref->status);
-				ret = args->porcelain ? 0 : -1;
+				ret = ERROR_SEND_PACK_BAD_REF_STATUS;
 				goto out;
 			}
 			/* else fallthrough */
@@ -761,11 +761,6 @@ int send_pack(struct send_pack_args *args,
 	if (ret < 0)
 		goto out;
 
-	if (args->porcelain) {
-		ret = 0;
-		goto out;
-	}
-
 	for (ref = remote_refs; ref; ref = ref->next) {
 		switch (ref->status) {
 		case REF_STATUS_NONE:
@@ -773,7 +768,7 @@ int send_pack(struct send_pack_args *args,
 		case REF_STATUS_OK:
 			break;
 		default:
-			ret = -1;
+			ret = ERROR_SEND_PACK_BAD_REF_STATUS;
 			goto out;
 		}
 	}
diff --git a/send-pack.h b/send-pack.h
index 7edb80596c..ee88f9fe9f 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -12,6 +12,9 @@ struct ref;
 #define SEND_PACK_PUSH_CERT_IF_ASKED 1
 #define SEND_PACK_PUSH_CERT_ALWAYS 2
 
+/* Custom exit code from send_pack. */
+#define ERROR_SEND_PACK_BAD_REF_STATUS 1
+
 struct send_pack_args {
 	const char *url;
 	unsigned verbose:1,
diff --git a/transport.c b/transport.c
index 47fda6a773..454d7f21a9 100644
--- a/transport.c
+++ b/transport.c
@@ -914,6 +914,13 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	case protocol_v0:
 		ret = send_pack(&args, data->fd, data->conn, remote_refs,
 				&data->extra_have);
+		/*
+		 * Ignore the specific error code to maintain consistent behavior
+		 * with the "push_refs()" function across different transports,
+		 * such as "push_refs_with_push()" for HTTP protocol.
+		 */
+		if (ret == ERROR_SEND_PACK_BAD_REF_STATUS)
+			ret = 0;
 		break;
 	case protocol_unknown_version:
 		BUG("unknown protocol version");
-- 
2.47.0.rc1.21.g81e7bd6151

