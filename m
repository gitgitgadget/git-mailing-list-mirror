Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51CB41C72
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 00:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147357; cv=none; b=ufwWPsIeLlHvr9fEFJaBkjl9+inkiG4xxRR5y059mvWHeWMuKBT3hrMuSQh+6mfqhHWjl8QMTUz9ZpUgVz67xbaaopBDogMET08rjoondQxoUm58ktF9/+pMdbfITp0jGNP+kfK/G1T/TPbhcs3xOk5ZzdY+XQ9d6J0+9vymCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147357; c=relaxed/simple;
	bh=Ex+rLTpY7CXjJ5yWusH9htAYp0wqCOqzVhSGUQWpvJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XtSbCocBsgCUv0fA0gJ11CpaeMrthk5A/k/jJ6E9MvtfC4Tq90El0V2MDakAXM5bo+M2e8wciUTkLxI2vjNsbXEHjQfXoogeKZESG7Jg7SDRBAeA0AOYVuKj6eDm558c28f5S+KEM7adX5IWwz0YZmJkHAbPizup7w7lxKTJDzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2GinC1b; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2GinC1b"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso594105e9.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786147354; x=1786752154; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v57lCHwquE5GVjnhPQrgTNxMHKbOfRMWPcfKwp23G98=;
        b=M2GinC1b1RbT2n2r+P048nI/lUUWsUAjQKG95P/oiyo0mVVoRILj3/dIYKMoxC3Nf7
         5Ez81MyzytKBjU14CED11bbAYbnH9m5dSEluAl9kZnrbjiWDQz8LnlYRm/53lpETsWO2
         MqaI9eo9zqfjTUueNPHi6Hu0NQCOX/a3ttduVaGDF8JPqD34Idy8Ro2kPMO8wK1kltce
         D7Z0H/AD3k40dNLgfKTZ7F3sHg7mx8O/D/jNCGVLcJsenrnx7OEhTuX4EhDFyoM77Bn6
         5h5LOhtQnSf9sE+W31YCpf2XZUUQ9WBZ61kitYSLnmxZZI+IOHXNJZ3m4HyWiANxCHc/
         zXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786147354; x=1786752154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v57lCHwquE5GVjnhPQrgTNxMHKbOfRMWPcfKwp23G98=;
        b=S5kkPPzr1rROydAssxI5Kmv1AINmf6Oq4GzR/+8Rvr1ZBouI/Q+peHqD2OY6b8DwCB
         HURezmUeZcpx6TIAl4myx6ODvQFsDSW175yCq2B3V0FUI5uk9biGoLOGwwEn64EJXYek
         8riI+RrGEctDmRC7l1rYrIYvhIjN+PErI1RK1XRAOuocX1b2qBGTXuOKBZ74Xu3FVtkQ
         pTuiVQMoOZuI2DHu4wqxaguwL/BGE30oPaNCfa/+7dRZQVeghWD9328Jry96O1FbyKz+
         LqA5+DDxfkQ6tK36sUXne4pBjgfhtj8nvfz2YtGNDOvU1doW+2xJl/uXjEI3d4vfiU5g
         Arjw==
X-Gm-Message-State: AOJu0YwQdBm6pD3+TLv3Z6iYZSBANNxfU2JFys1Ktm3dEov41bn4hrF7
	Yq/txS4Qjr17qnBapZHCE/JvHuLya9lzELDYkiG1G0f0JC/65Fl8AGjH
X-Gm-Gg: AR+sD10ucZuB8+HKTcpHz3FW6Gemt89Y9RTkZv4eJ4T//sPlqQywq+KyAkLaEmLM9jl
	UfWaN8UBEAUZEYAVfywO3I+FGjB4RP2iU6KdWc+A8+g8KvbVwidppOHGkNAstgP43dGflJWurUV
	8dXuK5bHe0N4t208skgBE1iLKo3PD366jcN/ie9aHzRqzwiEb1v4UU106E9MSXODxc17745QK+1
	GUIEH7spw44FO+qnLj+n8tkRtO/K9Ozyo8L/VAEj5L6XKclBOucfIBVxQnkOm3zBYPYQOxs9G6p
	KSAHo1v/RUzwMdNXNxqvpvFVypxy4lgGROd7ek3I61NbijAjrACdY4DOd2+XJBJHNYui27NqHCX
	5Ol1RKYvRNsMY6aBgZl5jv9ObmQNDLK86JuBcQHKzTlWUjuVLmKsi0RkajWP+ko3R8Mj5fyPZYJ
	SF1Y94WY5tPXcll1FoE2r/cDVH2uFv+t/Vv9C911gfel7HMRQ3IxepMyYBp/ddQ1eYS7cG9W7Qn
	YThnxFAIQB6hrxGp+ydnEAG8bNOK5/3MBUT5wqpeAYxu8R/P58mb+u2OgHzCwEry+rcOlkdgkNf
	zBvokvqZBgJ0CQfX/vVhb7eNMb47b3KTMaLjV0JYn3WCz6Sju6J9iEX15/UGCNx2OhNFdr+Ou0Y
	nEwzprjgxcXG4eEw9eP2N7Zw+y23qnGXunHklt4KvJZB/ILqBuHo64mUystM6LtH7EvmS
X-Received: by 2002:a05:600c:4f4d:b0:493:cc25:9c0e with SMTP id 5b1f17b1804b1-4994e7cb0e8mr344691025e9.14.1786147353809;
        Fri, 07 Aug 2026 17:02:33 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa (183.red-79-149-223.dynamicip.rima-tde.net. [79.149.223.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm72424525e9.2.2026.08.07.17.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:02:33 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Sat, 08 Aug 2026 02:02:22 +0200
Subject: [PATCH GSoC v6 07/10] protocol-caps: add type support to
 object-info
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260808-objecttype-support-v6-7-e5cdaf27a49c@gmail.com>
References: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
In-Reply-To: <20260808-objecttype-support-v6-0-e5cdaf27a49c@gmail.com>
To: git@vger.kernel.org
Cc: chandrapratap3519@gmail.com, karthik.188@gmail.com, gitster@pobox.com, 
 peff@peff.net, Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

Teach the server-side object-info handler to accept type as a requested
field. When the client includes type in its object-info request, the
server returns the requested object type.

While touching send_info(), wrap an over-long line and fix the bit field
style of requested_info.size.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Chandra Pratap <chandrapratap3519@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 protocol-caps.c      | 21 ++++++++++++++++++---
 t/t5701-git-serve.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/protocol-caps.c b/protocol-caps.c
index 02261be14d..27e0f85b10 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -11,7 +11,8 @@
 #include "strbuf.h"
 
 struct requested_info {
-	unsigned size : 1;
+	unsigned size:1;
+	unsigned type:1;
 };
 
 /*
@@ -73,15 +74,20 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 	if (info->size)
 		packet_writer_write(writer, "size");
 
+	if (info->type)
+		packet_writer_write(writer, "type");
+
 	for_each_string_list_item (item, oid_str_list) {
 		const char *oid_str = item->string;
+		enum object_type object_type;
 		struct object_id oid;
 		size_t object_size;
 
 		if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
 			packet_writer_error(
 				writer,
-				"object-info: protocol error, expected to get oid, not '%s'",
+				"object-info: protocol error, expected to get "
+				"oid, not '%s'",
 				oid_str);
 			continue;
 		}
@@ -93,7 +99,8 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 		 * If an object is not recognized by the server append SP to
 		 * the response.
 		 */
-		if (get_object_info(r->objects, &oid, &object_size) <= OBJ_NONE) {
+		object_type = get_object_info(r->objects, &oid, &object_size);
+		if (object_type <= OBJ_NONE) {
 			strbuf_addstr(&send_buffer, " ");
 			goto write;
 		}
@@ -103,6 +110,9 @@ static void send_info(struct repository *r, struct packet_writer *writer,
 				    (uintmax_t)object_size);
 		}
 
+		if (info->type)
+			strbuf_addf(&send_buffer, " %s", type_name(object_type));
+
 write:
 		packet_writer_write(writer, "%s", send_buffer.buf);
 		strbuf_reset(&send_buffer);
@@ -124,6 +134,11 @@ int cap_object_info(struct repository *r, struct packet_reader *request)
 			continue;
 		}
 
+		if (!strcmp("type", request->line)) {
+			info.type = 1;
+			continue;
+		}
+
 		if (parse_oid(request->line, &oid_str_list))
 			continue;
 
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 51d5dd1ae6..f57e36a88d 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -369,6 +369,36 @@ test_expect_success 'basics of object-info' '
 	test_cmp expect actual
 '
 
+test_expect_success 'object-info supports type' '
+	test_config transfer.advertiseObjectInfo true &&
+
+	two_oid=$(git rev-parse two:two.t) &&
+	two_size=$(test_file_size two.t) &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	size
+	type
+	oid $two_oid
+	oid $two_oid
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	size
+	type
+	$two_oid $two_size blob
+	$two_oid $two_size blob
+	0000
+	EOF
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'bare OID request' '
 	test_config transfer.advertiseObjectInfo true &&
 

-- 
2.54.0

