Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB1B248F79
	for <git@vger.kernel.org>; Mon, 12 May 2025 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066632; cv=none; b=I2mBuJwUWz+4VxKqxD4PZIWw0ty9+zqJgdmnI9+WvDtASSJbuDCXbtslCHYfhE5BawlfYMR7OUbuvdezg98NSvxMh+rsjnHi5+ZNZOfKsOixwrreF6NWkysoQjg8bGAixChFB2Ei0UTloPLOnmgJeNIiTFT1BWzpU5HOP//PAQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066632; c=relaxed/simple;
	bh=eaEsXzoOjr2KEPQToB1+ELX3ARJQIBMB6lCiUhCl/6g=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Qr9Orv2GOcDEFvlCVIZUEN3oqnV8RX9TZ+NEzsFk83Z1h6RWLXQ3IhtmHga4KNUFZCFiYrLNtgQskalo2n2HVq0Gi6mzpdb5PJRd2hzHcgklfrT8xwOPCl3oAQgn2cF1X99Pkn1bs2tu7pwWGnf8ka0Y99Jny+pBJWkwYg6wiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGCJGa4L; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGCJGa4L"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so26725895e9.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 09:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747066629; x=1747671429; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T4i79nVCaQzSnzt9VVqxtfgVud/se8GQ8mOsjmmB8MU=;
        b=iGCJGa4LiF7u72l76H5VGp0CTu6JSGPuSk/hOHu6OOrRHRgMoExfDzHtUfHRcxkYeP
         IaYzc9v+kgCDKS+khPBihOcaYnq2fY1b6DSdIDmzZKBkSQblg6p29SyFFPgDl/nvn3Zq
         JPLz32q1xFhX+pdkCx2ap2d26m7A7UuYgitUXXFKR2WpjGKtEgPjsH/1iBJXS//7a7pI
         ORBWIzjqGvxCekdQc7iOmgKtFCliL0bZ/KsKDUfCIkAsPLNAgaWkQkUFcqC2wVXS8USp
         DMl/mBebi1Ymvh72QAGNATA+3za0TwxMvljdmiF9hyOyOsyGuO34IM1Ri5tf21+gVtkD
         DUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747066629; x=1747671429;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4i79nVCaQzSnzt9VVqxtfgVud/se8GQ8mOsjmmB8MU=;
        b=ewILFs9wJOZnJTrpiMOH7+y+ZAzLrg7iZ8csD8kmxrYB5s2uY3NZqFq68aIxpKciHX
         2mj2ULqBNRt67Hdg5cXahlYq7FzipNlO/7eMvX7ocpJjzLvYksH7RT4412ziA6oPmTBz
         hlBkD/SuGkWqMujPVLSyCGnaJ7ReDgF/KIkXx7L8JXokW4j863b7nA9AAef4afx/YgfN
         kZxIMShwUruU9WCIy49IJU1dP16omi4AM9RrtyMUFS3/CF1poJ5X0DstZvlTx9RhuMWY
         VQFsXAeWESiQLPXQjl7MEicK0OsR9nn75G65zC/QRRXjcXy9ZRSjJays/Wr37nRMdNKc
         96LQ==
X-Gm-Message-State: AOJu0Yy+2X47y5QJ60YzZF/9QSFQ9EEanEJejtoysL3C+SMZ5ZZhBRRE
	2gEJbCNkS+zPL2djaXba2QvqVY5lGQRbeuSjwcNEO68i1RCSwBLkkda7CQ==
X-Gm-Gg: ASbGncuGjNlaeoWnezqOPlxWMz3XI/aYIWGKfFqMogjhAR/4B4uRww1KkcWQcwA9MC1
	WJ7Ry3IuSB+15egciiEDKGqBWXgVnNM4q5/pQMuhd/5cwtUfngwXrJaKUGs6JCPbXrFygx+X8xO
	RFTuR5NRcUj3xiMRu0OFdBxCS/3FAco5qoiVRX9KCclhRIsJqh3t5QNbXYZRYPWw0uNpnQtFvUs
	6ZEmNFnacmJcoZ/t4tup2U1Sml27Wy4rs9PNanZ8dvbtxMzrBX0iT1mRCqlCI3WV+uYZBB2RGEQ
	vmdoRcVS9zrhpGGG22bZFt+n8gCYJ2wwGJ+3YimMtsaE6siwHL6f
X-Google-Smtp-Source: AGHT+IEgQRs03BvHuRrk1DMzhVGsItNhPW9n0xUb+GvLnchnlYv7yJsb4qDaBz/EMiJYkGZI3MYIbQ==
X-Received: by 2002:a05:600c:c10d:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-442dc755be9mr75911015e9.5.1747066628500;
        Mon, 12 May 2025 09:17:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442e9d00bacsm13624625e9.12.2025.05.12.09.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 09:17:08 -0700 (PDT)
Message-Id: <pull.1956.v3.git.git.1747066627330.gitgitgadget@gmail.com>
In-Reply-To: <pull.1956.v2.git.git.1746980097510.gitgitgadget@gmail.com>
References: <pull.1956.v2.git.git.1746980097510.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 16:17:07 +0000
Subject: [PATCH v3] mailinfo: fix pointential memory leak if `decode_header`
 failed
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In mailinfo.c:decode_header, if convert_to_utf8 failed, the strbuf stored
in dec will leak. Simply add strbuf_release and free(dec) will solve
this problem.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    decode_header: fix pointential memory leak if decode_header failed
    
    In mailinfo.c line 539, if convert_to_utf8 failed, the strbuf stored in
    dec will leak. Simply add strbuf_release and free(dec) will solve this
    problem.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1956%2Fbrandb97%2Ffix-mailinfo-decode-header-leak-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1956/brandb97/fix-mailinfo-decode-header-leak-v3
Pull-Request: https://github.com/git/git/pull/1956

Range-diff vs v2:

 1:  90dc9b0d49b ! 1:  7f8ce472750 mailinfo: fix pointential memory leak if `decode_header` failed
     @@ mailinfo.c: static void decode_header(struct mailinfo *mi, struct strbuf *it)
       			goto release_return;
       		case 'b':
      -			dec = decode_b_segment(&piecebuf);
     -+			if ((found_error = decode_b_segment(&dec, &piecebuf))) {
     ++			if ((found_error = decode_b_segment(&dec, &piecebuf)))
      +				goto release_return;
     -+			}
       			break;
       		case 'q':
      -			dec = decode_q_segment(&piecebuf, 1);
     -+			if ((found_error = decode_q_segment(&dec, &piecebuf, 1))) {
     ++			if ((found_error = decode_q_segment(&dec, &piecebuf, 1)))
      +				goto release_return;
     -+			}
       			break;
       		}
      -		if (convert_to_utf8(mi, dec, charset_q.buf))
      +		if (convert_to_utf8(mi, &dec, charset_q.buf)) {
     -+			strbuf_release(&dec);
       			goto release_return;
      +		}
       
     @@ mailinfo.c: static void decode_header(struct mailinfo *mi, struct strbuf *it)
       		in = ep + 2;
       	}
       	strbuf_addstr(&outbuf, in);
     +@@ mailinfo.c: release_return:
     + 	strbuf_release(&outbuf);
     + 	strbuf_release(&charset_q);
     + 	strbuf_release(&piecebuf);
     ++	strbuf_release(&dec);
     + 
     + 	if (found_error)
     + 		mi->input_error = -1;
      @@ mailinfo.c: static int is_inbody_header(const struct mailinfo *mi,
       
       static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
       {
      -	struct strbuf *ret;
     -+	struct strbuf ret;
     -+	int found_error = 0;
     ++	struct strbuf ret = STRBUF_INIT;
       
       	switch (mi->transfer_encoding) {
       	case TE_QP:
      -		ret = decode_q_segment(line, 0);
     -+		found_error = decode_q_segment(&ret, line, 0);
     ++		decode_q_segment(&ret, line, 0);
       		break;
       	case TE_BASE64:
      -		ret = decode_b_segment(line);
     -+		found_error = decode_b_segment(&ret, line);
     ++		decode_b_segment(&ret, line);
       		break;
       	case TE_DONTCARE:
       	default:
     @@ mailinfo.c: static int is_inbody_header(const struct mailinfo *mi,
      -	strbuf_release(ret);
      -	free(ret);
      +	strbuf_addbuf(line, &ret);
     -+	if (!found_error)
     -+		strbuf_release(&ret);
     ++	strbuf_release(&ret);
       }
       
       static inline int patchbreak(const struct strbuf *line)


 mailinfo.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 7b001fa5dbd..9bda2e8170f 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -381,11 +381,11 @@ static int is_format_patch_separator(const char *line, int len)
 	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
 }
 
-static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
+static int decode_q_segment(struct strbuf *out, const struct strbuf *q_seg,
+			    int rfc2047)
 {
 	const char *in = q_seg->buf;
 	int c;
-	struct strbuf *out = xmalloc(sizeof(struct strbuf));
 	strbuf_init(out, q_seg->len);
 
 	while ((c = *in++) != 0) {
@@ -405,15 +405,14 @@ static struct strbuf *decode_q_segment(const struct strbuf *q_seg, int rfc2047)
 			c = 0x20;
 		strbuf_addch(out, c);
 	}
-	return out;
+	return 0;
 }
 
-static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
+static int decode_b_segment(struct strbuf *out, const struct strbuf *b_seg)
 {
 	/* Decode in..ep, possibly in-place to ot */
 	int c, pos = 0, acc = 0;
 	const char *in = b_seg->buf;
-	struct strbuf *out = xmalloc(sizeof(struct strbuf));
 	strbuf_init(out, b_seg->len);
 
 	while ((c = *in++) != 0) {
@@ -447,7 +446,7 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
 			break;
 		}
 	}
-	return out;
+	return 0;
 }
 
 static int convert_to_utf8(struct mailinfo *mi,
@@ -475,7 +474,7 @@ static int convert_to_utf8(struct mailinfo *mi,
 static void decode_header(struct mailinfo *mi, struct strbuf *it)
 {
 	char *in, *ep, *cp;
-	struct strbuf outbuf = STRBUF_INIT, *dec;
+	struct strbuf outbuf = STRBUF_INIT, dec = STRBUF_INIT;
 	struct strbuf charset_q = STRBUF_INIT, piecebuf = STRBUF_INIT;
 	int found_error = 1; /* pessimism */
 
@@ -530,18 +529,20 @@ static void decode_header(struct mailinfo *mi, struct strbuf *it)
 		default:
 			goto release_return;
 		case 'b':
-			dec = decode_b_segment(&piecebuf);
+			if ((found_error = decode_b_segment(&dec, &piecebuf)))
+				goto release_return;
 			break;
 		case 'q':
-			dec = decode_q_segment(&piecebuf, 1);
+			if ((found_error = decode_q_segment(&dec, &piecebuf, 1)))
+				goto release_return;
 			break;
 		}
-		if (convert_to_utf8(mi, dec, charset_q.buf))
+		if (convert_to_utf8(mi, &dec, charset_q.buf)) {
 			goto release_return;
+		}
 
-		strbuf_addbuf(&outbuf, dec);
-		strbuf_release(dec);
-		free(dec);
+		strbuf_addbuf(&outbuf, &dec);
+		strbuf_release(&dec);
 		in = ep + 2;
 	}
 	strbuf_addstr(&outbuf, in);
@@ -552,6 +553,7 @@ release_return:
 	strbuf_release(&outbuf);
 	strbuf_release(&charset_q);
 	strbuf_release(&piecebuf);
+	strbuf_release(&dec);
 
 	if (found_error)
 		mi->input_error = -1;
@@ -634,23 +636,22 @@ static int is_inbody_header(const struct mailinfo *mi,
 
 static void decode_transfer_encoding(struct mailinfo *mi, struct strbuf *line)
 {
-	struct strbuf *ret;
+	struct strbuf ret = STRBUF_INIT;
 
 	switch (mi->transfer_encoding) {
 	case TE_QP:
-		ret = decode_q_segment(line, 0);
+		decode_q_segment(&ret, line, 0);
 		break;
 	case TE_BASE64:
-		ret = decode_b_segment(line);
+		decode_b_segment(&ret, line);
 		break;
 	case TE_DONTCARE:
 	default:
 		return;
 	}
 	strbuf_reset(line);
-	strbuf_addbuf(line, ret);
-	strbuf_release(ret);
-	free(ret);
+	strbuf_addbuf(line, &ret);
+	strbuf_release(&ret);
 }
 
 static inline int patchbreak(const struct strbuf *line)

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
