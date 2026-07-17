Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3274625A642
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300747; cv=none; b=MdDi9fV7WYlQVXhQtL8cpoTDi+BYhe2vyxfaV2GV6yEPWqhIhb8ZPxH/COlMkTUHoX7b2WA0kUJLR+NgQILPUi3uBx9Hxfe0Nam+QDSP6jKAABD1mfHCfBzUsh6LQVR48DGvmFSdB6RPF8WzCWEvHxfhGYdwK4f7jYwWm1CLWwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300747; c=relaxed/simple;
	bh=cv5HJASiONpTpIcycrY2pdOotFxWIuHn0b95+qtpCg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kh6bZVWLfHsV/7jcwyFKvbPOx+FDSrQlAz+3TFsXjjvTJMLy51yh0srgmBUHSxTwtMvn2aCR1GKq9Q4miWq3c0/y8Vj+yBlisweAs5NijctMyuDGwsbWGO8r9nsXL+HtMtt5ADtb6wMjcgwO7eOxBPPfUHZf3PUkU0ywYV3BYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrAen7Kc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrAen7Kc"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso17299545e9.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784300740; x=1784905540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YyxJKZiLu8AWu4foef14yuiqLa5SqL7NQDlxxBlKXKk=;
        b=QrAen7KcpDWV4XaJNULsNEIhSQM6Xm6PAy7HZ7SqEDloSq27+4Z6iWRWSuiIyhhrGa
         f2vD/pk47+IaZ2NHCUzfGin8WHsdZaEOyQnZ2JM5gg3uT3pGkAkuB0d7pVs3E6C7QfRG
         WRkyW5O7WSZ4o7XpI5vazoPd7jqvgM2f1RUn6upeQjFZOCVpaCUjTIhnaFEaMetvc07a
         Hon1SwDszNWkJprp6Wdu2iUq0HV53+IPp/g48NiIB5F0uqwYbWWf4LOKnvFs62/3HQXF
         MKAmlGdL/Gpb8tGU9E9cyjYZpr/vuTh/kWfk9rMlLVH6aAEdrieZOX6BwDw+/rWaoBeC
         +qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784300740; x=1784905540;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyxJKZiLu8AWu4foef14yuiqLa5SqL7NQDlxxBlKXKk=;
        b=A9xCQ/NCHGSNUQtAi5WlIjVADQjbuUXP2Ajvyenm59RlFgzUP3/TObcf5jLu35Ww51
         UZ4l6Fzcdw4LqyshVtSgMguDteq43dftiOoAk7fiAT6e57WN696S4UMX1AWDDjseTST2
         wMaTAiSVgVr/tleKk9+06QzINBsI/Affkg72uPiV5idD/9jEtyuPx2SXnhMmSoyFCl18
         AcTPHNY0TMC7SE3O0Cdt8d+c6ET9o5AcHVuS6eoYS6XUAIo9BjDOir6C3kLkB/BahW03
         ft2YHV8COpeLp9SwrIdm3hoETxxSbh6Pt14N/k2fhK2yhF0K5+utX3Wnv13kvpIlOKcI
         dh4g==
X-Gm-Message-State: AOJu0YzgK4fNbWKHXr94vIgs1ucVi6X5Zmff9y+QBBAQEX1Hbe0Bym1C
	hmbpOMs0hdzQtdrIr9C4ca8Qe/HpTngd/WDZHw3EekmH7jDlery1wKzSTGLmmjJa
X-Gm-Gg: AfdE7cm87RejSLEgfx4B4o/w/+xgWhxryTBxUEp9wI+mHX5Zv5GWReNMZnyuAQwOvrx
	4H/f11ID8LdjQpqjo/Lb/Ie7YDTdAHVq9ZvnNoqSELScZT3VJLXtlrINhNEGz6HnnY9R1U5ymQb
	di/sIpyM8kbT7K6oOx8FHF8KQI9kEz36eNrIegBctl3e1rx0mOzuwuVSYK96w+POFqNaSZn5+QP
	oCUpwpf+e9DcnCzPazMoMimfvlW9B5YuFArsVhAxTrxGsQopYnlZXx1QtGW2MRHQa2TuLyAHW4e
	4q968NrKNrd2YkkhbRwLjtDUNhV53/xwvAJ4mDp4nJNdi5iT0MHfY1QGMzvcAkLRxMAB5mSrmh+
	MdUCjReFMAfhNseULLP5THPI66cJRLdCCWW161cbBXpSemwtmsje4F2/AuQmdRWAifuza96rtZc
	2HAZaw+Vlt4J0bcWC2DWzj/r/dLR7luVfoyRG+row8pfkIJZcReCA+yZnFpwyiu3muUMwCjZWD5
	0nvNnJ4OgmP4t/kN6QtTnrWyzubWYDpSUe9aIGMU7mcJyyIxpHHyvLgtBklzVtAcV3GgHAo4Cl8
	WmOojg8VvPqI4Dn5LzGFGbSjnRWjfjMz
X-Received: by 2002:a05:600c:354e:b0:495:4811:7998 with SMTP id 5b1f17b1804b1-4954a3eabb6mr39109205e9.17.1784300739579;
        Fri, 17 Jul 2026 08:05:39 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2692a3sm50226025e9.0.2026.07.17.08.05.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 08:05:39 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com
Subject: [PATCH GSoC v19 09/13] protocol-caps: check object existence regardless of the attributes requested
Date: Fri, 17 Jul 2026 17:05:19 +0200
Message-ID: <20260717-ps-eric-work-rebase-v19-9-d4faee35764b@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
References: <20260715-ps-eric-work-rebase-v18-0-34d7adb051bb@gmail.com>
 <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently, send_info() only checks for existence when the attribute
'size' is also requested. Requesting a bare OID, without attributes only
echoes back the OID.

Extract the existence check to be done regardless of the number of
attributes requested.

While at it, introduce a wrapper called get_object_info() similar to
odb_read_object_info() that returns OBJ_BAD on fail and adds
OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK flags.
OBJECT_INFO_SKIP_FETCH_OBJECT is so a server with a partial clone
doesn't trigger fetching objects when it gets an object-info request
with an OID that is not available locally. A server should only report
what it has locally.

Tighten the condition used to determine whether an object is
recognized. get_object_info() returns OBJ_BAD for unknown objects,
but OBJ_NONE (0) can also mean "not found". Change the check from '< 0'
to '<= OBJ_NONE' to cover both as unrecognized.

With this patch, a bare OID has two possible responses:

1. Recognized OID: the server answers with "<OID>"

2. Unrecognized OID: the server answers with "<OID> SP"

Update the object-info section in 'gitprotocol-v2.adoc':
- Require full obj-oid explicitly.
- Fix parentheses.
- Define obj-size explicitly.
- Make obj-size optional in obj-info and document the behavior
  for unrecognized object IDs.
- Describe the attr header as zero or more pkt-lines, one per attribute,
  matching what the server implements. A request with no attributes gets
  no header.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/gitprotocol-v2.adoc | 21 ++++++++-----
 protocol-caps.c                   | 45 ++++++++++++++++++++++++----
 t/t5701-git-serve.sh              | 63 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+), 14 deletions(-)

diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
index 2beb70595f..7bf62014c3 100644
--- a/Documentation/gitprotocol-v2.adoc
+++ b/Documentation/gitprotocol-v2.adoc
@@ -568,21 +568,26 @@ An `object-info` request takes the following arguments:
 
 	oid <oid>
 	Indicates to the server an object which the client wants to obtain
-	information for.
+	information for. They must be full OIDs.
 
-The response of `object-info` is a list of the requested object ids
-and associated requested information, each separated by a single space.
+The response of `object-info` consists of one pkt-line per requested attribute,
+echoing the attributes the server will report, followed by one pkt-line per
+requested object id with its information, each field separated by a single
+space.
 
 	output = info flush-pkt
 
-	info = PKT-LINE(attrs) LF)
-		*PKT-LINE(obj-info LF)
-
-	attrs = attr | attrs SP attrs
+	info = *PKT-LINE(attr LF)
+	       *PKT-LINE(obj-info LF)
 
 	attr = "size"
 
-	obj-info = obj-id SP obj-size
+	obj-size = 1*DIGIT
+
+	obj-info = obj-id [SP [obj-size]]
+
+If the server does not recognize the OID, the response will be `<oid> SP`
+regardless of the number of attributes requested.
 
 bundle-uri
 ~~~~~~~~~~
diff --git a/protocol-caps.c b/protocol-caps.c
index 8858ea4489..02261be14d 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -30,6 +30,32 @@ static int parse_oid(const char *line, struct string_list *oid_str_list)
 	return 1;
 }
 
+/*
+ * odb_read_object_info_extended() wrapper. Similar to odb_read_object_info()
+ * but uses the flags:
+ *
+ * - OBJECT_INFO_SKIP_FETCH_OBJECT so a server won't fetch an object when a
+ *   object-info request asks for an OID that it doesn't have.
+ *
+ * - OBJECT_INFO_QUICK to avoid re-scanning packs when the object is not found.
+ */
+static enum object_type get_object_info(struct object_database *odb,
+			   const struct object_id *oid,
+			   size_t *sizep)
+{
+	enum object_type type;
+	struct object_info oi = OBJECT_INFO_INIT;
+
+	oi.typep = &type;
+	oi.sizep = sizep;
+	if (odb_read_object_info_extended(odb, oid, &oi,
+					  OBJECT_INFO_LOOKUP_REPLACE |
+					  OBJECT_INFO_SKIP_FETCH_OBJECT |
+					  OBJECT_INFO_QUICK) < 0)
+		return OBJ_BAD;
+	return type;
+}
+
 /*
  * Validates and send requested info back to the client. Any errors detected
  * are returned as they are detected.
@@ -62,15 +88,22 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 
 		strbuf_addstr(&send_buffer, oid_str);
 
+		/*
+		 * Check the existence of the object first.
+		 * If an object is not recognized by the server append SP to
+		 * the response.
+		 */
+		if (get_object_info(r->objects, &oid, &object_size) <= OBJ_NONE) {
+			strbuf_addstr(&send_buffer, " ");
+			goto write;
+		}
+
 		if (info->size) {
-			if (odb_read_object_info(r->objects, &oid, &object_size) < 0) {
-				strbuf_addstr(&send_buffer, " ");
-			} else {
-				strbuf_addf(&send_buffer, " %"PRIuMAX,
-					    (uintmax_t)object_size);
-			}
+			strbuf_addf(&send_buffer, " %"PRIuMAX,
+				    (uintmax_t)object_size);
 		}
 
+write:
 		packet_writer_write(writer, "%s", send_buffer.buf);
 		strbuf_reset(&send_buffer);
 	}
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index d4c28bae39..cacff4456c 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -7,6 +7,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+unknown_oid=$(printf "test" | git hash-object --stdin)
+
 test_expect_success 'setup to generate files with expected content' '
 	printf "agent=git/%s" "$(git version | cut -d" " -f3)" >agent_capability &&
 
@@ -364,6 +366,67 @@ test_expect_success 'basics of object-info' '
 	test_cmp expect actual
 '
 
+test_expect_success 'bare OID request' '
+	test_config transfer.advertiseObjectInfo true &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	oid $(git rev-parse two:two.t)
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	$(git rev-parse two:two.t)
+	0000
+	EOF
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'object-info with bare unrecognized OID' '
+	test_config transfer.advertiseObjectInfo true &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	oid $unknown_oid
+	0000
+	EOF
+
+	printf "%s \n" "$unknown_oid" >expect &&
+	printf "0000\n" >>expect &&
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'object-info with size for unrecognized OID' '
+	test_config transfer.advertiseObjectInfo true &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	size
+	oid $unknown_oid
+	0000
+	EOF
+
+	printf "size\n" >expect &&
+	printf "%s \n" "$unknown_oid" >>expect &&
+	printf "0000\n" >>expect &&
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'test capability advertisement with uploadpack.advertiseBundleURIs' '
 	test_config uploadpack.advertiseBundleURIs true &&
 

-- 
2.54.0
