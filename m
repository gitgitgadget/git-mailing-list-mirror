Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79466377A95
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411425; cv=none; b=RcTpdxJPfaiWwlvAwMjGhsRnLlwHdBeuhyHRkmEsL6Cw9l97XhNCC5+0FV2BPMqG7s50AsYr27ibnOEA1vB3NPKyyXawKfdslu6JMS2FCxnAzHAJ9Gwh7kt1G/ZGtheaQoNgl9Six8kh0V7ppdebbvfm/u8T7yv65JpH7tHwN2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411425; c=relaxed/simple;
	bh=cv5HJASiONpTpIcycrY2pdOotFxWIuHn0b95+qtpCg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWdX2kHMpiRbVoP1hMP6BSglkTL2ez4D6/Fi1xMTe9LmYGXaN3gXXjRAq7jLMIyQjMjYjVn26wkYwAfKYGlxT65dB31duL+Wj5BQAneXv5rEY+Pq61YtRPWZQMhuzMAx2H5V8FpNez1GJ/i3mtYAd4ilNGBP6QqoeX/sgvAs4FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9EOvPFs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9EOvPFs"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493b966dd74so36534395e9.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411422; x=1785016222; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YyxJKZiLu8AWu4foef14yuiqLa5SqL7NQDlxxBlKXKk=;
        b=a9EOvPFsdo8MFBrmysuSPNqxqAkNIBsvySaN+3xkL12rqpbiPJr6mP+CLMnsv5TJzD
         w8IS2EzOnPh4iplSCSLcSxe7yUi1C5y/V686xz1btgXrgahOi1c3Qisf2X6kTARRs518
         +0P1panhh7JzdaY2ZuYcim+Ust2NUuCshTK+z/XEF2Gd50G/yyYxf7cjhC3nqJ3sj8FU
         5Lb31XYF9hrAXSl1OXJeHrlitZ4aci+VGzuEjTxd56fuj30hESmIOAfWy2zZ+VkVfYxw
         pKspEnfZKq5011i1pGCbM7b3U5H7RFCCglyl0TkA4aOKzANs+u0rN33v1MnEGGTyBlqX
         Eh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411422; x=1785016222;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyxJKZiLu8AWu4foef14yuiqLa5SqL7NQDlxxBlKXKk=;
        b=k+G/umhilk2ByAqZPsiaw7kZYhytTVFMaXrfW2z6nuy+qrqcBz02ANzSxyzHV6rN8R
         bUWj8zziCsQN5LoSyjuVMIjApcpZaDDzQYGPgVwuttFJCtl2yHipl/Ox/jN9SnSp3QD2
         2xo6Wv8wMKE5ATy4KN38TdGTkB1Khb2oRHK0HAMeg1Kz7MGdy+Q41I3Q8isYo/PXXRjF
         wpi3d8ArwR1nFe09kLSLtC6xcI2+ztug0Mb1GgRuw5MLXEYohz3IlTNYfH3mub1iOPGk
         RC4cDI6pSlUitXFcTMHDBOwQVIoCjSIp9Xlv5oqyr6dBn/OP7UicoBdZYtpjkV8sXnV7
         XvAw==
X-Gm-Message-State: AOJu0YzPXIBzRFuYhtc2fReqdPKU9FblnGbMPmgz3cMoVftpIPplFcML
	ehmzVJncEJFbZYn6K9ZesCUx3Jd0abH7pGmOKRxboEC8WdQw84A1dR8vqxU0FvP/
X-Gm-Gg: AfdE7cmLEqE/D2j9J1GVych4aVGYC7HMBesAHI86wfqMYOJ8IHwMamHlEmcmkblw8qn
	bGfYw5rI4X/CXieF4iTVdhvLfyy2UjljvTU999J+UGTJQDwxM7lqacoQzUcKw+IWbdjWOaI081H
	J5XFcr/A8N5e1lazOh6S8dDkyczeCB0ftTor3EtYUBhypptmMZP3RJrXFkuWz10EmNSNFGSfg7i
	zWXbp7WE9vg26DuKUzs3CqLZUBxDncjAv7utk3qU0ms9cbsnlwnsPPmSbga+J0fXGzJqzmTsFgv
	AlHT4BAByTKXfQOrX/WVB+H9krOHfYbzuoHAxK1E3kyM34MHSCRSpxpxcD8QIDGOX7nRwljHEsu
	Yv+v3+CpJh2OwOZWd8I5s7kLdYj2NBwKG6YtS1Y4r9s0X2SkyhM2DHjF/iB/ksapPURhtJmSr1s
	o3qfwsvaQH0j9jpBmf5UvLzBd+zAxNGRlxZzCsyi05gwfoxutzyH9Y1VvtEQsUg2I+KfljRNPHQ
	AIo+fhMPHWKR2NxWsuLiGo8ef/bENYXyCgyYbwzFAss43iu9gMVp4dwQSyAhPVt8wyM3UmsbTHz
	BCgHAdq01RoXkH4JaI/cBuoXBcCMpMM0
X-Received: by 2002:a05:600c:1d1e:b0:493:b6ee:fcb7 with SMTP id 5b1f17b1804b1-4954a3f39ffmr81416655e9.14.1784411421534;
        Sat, 18 Jul 2026 14:50:21 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm146225145e9.13.2026.07.18.14.50.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:50:21 -0700 (PDT)
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
	toon@iotcl.com,
	szeder.dev@gmail.com
Subject: [PATCH GSoC v20 09/13] protocol-caps: check object existence regardless of the attributes requested
Date: Sat, 18 Jul 2026 23:49:58 +0200
Message-ID: <20260718-ps-eric-work-rebase-v20-9-0c13962ac532@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
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
