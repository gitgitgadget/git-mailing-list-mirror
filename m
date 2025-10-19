Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2AA2E7657
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 12:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875773; cv=none; b=h/Es2X9w+nTNIGBHR6BxlBcnCM0l1fd4sJZMs3ELPOQM971TxddLx8gvPJq0iYt8dij/QfQ2wtZo1CBV33vQ59zMOAeSJ83/G0uvTf2Wwb93dqb8azoTfw/8DPsL9HnsEjwWU/2DtHglIPIorCWZa9p+6McnHUd3Nl5q0U3294U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875773; c=relaxed/simple;
	bh=FC38gAgE/uAh9yVxyuJluiUX0Sgetx6G1Q2iQcoEsTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBY4NcYpuGFEBoKfE1ZnQMfOaeV0TxWjwfCXGURwpF0zrsaP1RfXPjKqTDcyK9Duj3EHMWAGqr80zeBYlDdCj0xEvke87JtNYyC+4Bw/myb8J2HuntF4xDA4UvwMtoMVxiMIbfj201RkQUo407Q6ErtRp6QWVX+sIcs6tsCY9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhs3xgZM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhs3xgZM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-471066cfc2aso31094895e9.0
        for <git@vger.kernel.org>; Sun, 19 Oct 2025 05:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760875770; x=1761480570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klI7eJQgau8HPDg8hjgXXP8wm38MCMXWS6HJXMBRNzo=;
        b=fhs3xgZMBKvPsj15tAF6f/xvpuufvFY4634wR5Fo/h7iQVowNSqNlv1hwYYvWHPuvG
         Rj0KfgtX2p5s5SZV6N27kfGuy+DOrLoUgwQJuxvSH6XQVR4HOWg5U8CASws/qNVSdbQX
         XLahFwskEf/lzCTRphj8hPc804kmrTiTe+40KCnOE/MtgEt49Z7y2kelZT+VAeT2QPMY
         7fyLMpad2ikjYLKrV29FLIMQSBrGBFdoxMpsLHUj2rgi+YpjV9QSAHzxIMZdZiK+6SOZ
         m3mZpaZy8oRoHX0qGBmKparBYWaOKsybhTOTWQs0rhDqXlib+QxvsiSM21fjC966FosV
         nQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760875770; x=1761480570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klI7eJQgau8HPDg8hjgXXP8wm38MCMXWS6HJXMBRNzo=;
        b=dtSs1c4apNQlvnHowTXLvF7IwxUvsKkE6nINFZwGOK2HRLgAPZbtAykZydyc0AoiMV
         GV0hCY+CCOjEFRTQdIZg2JgWwObFBn4HVuoF8wzsMfX0e57FcwqEDOihQXQilGeZLX+Z
         kWzuhIoKBo2pSJ2TTuBz/uXf9KXDVdydv0/dc5dJ1obXWF4WBRqybUtaKOlqJ41EKqRy
         zOXnkKeJJ+ffn34/RUWcweybSkwcqgs0kayKc3kI5NblCJey7I2FDsNFv9lk+cCoaZ6c
         X026BhBmTETmXc2i3GJ28WOyZaugEQCvmHrzwCRy4JfuWSIJBuidWfjRb4I1RaCjd3TJ
         1+eA==
X-Gm-Message-State: AOJu0YzypGsTUbCQTIjN54Uge0sbGWvaLy6GfnWuEzUhKG/uZ+xe2CBY
	FN3TxlKI+mfMIlyi1uOjqGCdXc/YDdhM6Au7wkVntoMr3eaxhJOTea7i
X-Gm-Gg: ASbGnctGR+KclDZpovf+d9BK15qLV93A+9/hpOtdHvrFzG4mcSsvSZCxsQsaqHifriw
	ac3CA7T/0YZ6TU8eIRERQ64d9Aft9V5GpoBgsWBTqm8fmgaEeE4kseCSXC6xOk+l8uaKZjNpVPX
	qPC1JRRsFpcJfmkc8ZSeWdndoS1yL9LXFyzhkEHb6jx1C6prTqaxNUgq412TSWbiqT6/KRge9qu
	rik390jJZggO8HNB0ziz2XSiplLS5jx9bcs/TIopVYp6So2xUmUxUzMIG6G8Qc4YeEx+EKsmHRT
	aCtn8dLA8amkQr/ZlgKt6osvxDKZlBXH2HCRDv1styuWTqItLamtyyHmrJf61kl/jboYYh59aCQ
	CGJIdHT5dv1Qnz9AngAjS7dv8ecf+Dv2+vwvfNbVQqboVCMl30xXMh4au8GhzHGZxBEbR
X-Google-Smtp-Source: AGHT+IHSfxD+P13lqA2WidZHFZd32xSPZxmLsJT5qZPyew3lBIh6ti20BUIZnLoRzriLni4zjo/Trw==
X-Received: by 2002:a05:600c:8505:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-4711786c71cmr70603085e9.3.1760875769424;
        Sun, 19 Oct 2025 05:09:29 -0700 (PDT)
Received: from ubuntu ([105.112.227.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c91sm177096815e9.11.2025.10.19.05.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:09:28 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>,
	Junio Hamano <gister@pobox.com>
Subject: [Outreachy PATCH v3 2/2] gpg-interface: use string_list_split*() instead of strbuf_split*()
Date: Sun, 19 Oct 2025 12:07:43 +0000
Message-ID: <9a6eb6ff8b92a94de990303cc78026029a669cf8.1760869186.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1760869186.git.belkid98@gmail.com>
References: <cover.1760869186.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In get_default_ssh_signing_key(), the default ssh signing key is
retrieved in `key_stdout`, which is then split using
strbuf_split_max() into two tokens

The string in `key_stdout` is then split using strbuf_split_max() into
two tokens at a new line and the first token is returned as a `char *`
and not a strbuf.
This makes the function lack the use of strbuf API as no edits are
performed on the split tokens.

Replace strbuf_split_max() with string_list_split_in_place() for
simplicity

Note that strbuf_split_max() uses `2` to indicate the number of tokens
to extract from the string, while string_list_split_in_place() uses `1`
to specify the number of times the split will be done on the string,
so 1 gives 2 tokens as it is in the original instance.

string_list_split_in_place() returns the number of substrings added to the
list keys.items, so we check that at least one substring is added to the
list since we just want to return the first substring.

Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
Reported-by: Junio Hamano <gister@pobox.com>
Helped-by: Christian Couder <christian.couder@gmail.com>
---
 gpg-interface.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index cb182f4c11..3b9d85a5ef 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -862,7 +862,7 @@ static char *get_default_ssh_signing_key(void)
 	struct child_process ssh_default_key = CHILD_PROCESS_INIT;
 	int ret = -1;
 	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
-	struct strbuf **keys;
+	struct string_list keys = STRING_LIST_INIT_NODUP;
 	char *key_command = NULL;
 	const char **argv;
 	int n;
@@ -884,19 +884,19 @@ static char *get_default_ssh_signing_key(void)
 			   &key_stderr, 0);
 
 	if (!ret) {
-		keys = strbuf_split_max(&key_stdout, '\n', 2);
-		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
+		if (string_list_split_in_place(&keys, key_stdout.buf, "\n", 1) > 0 &&
+			is_literal_ssh_key(keys.items[0].string, &literal_key)) {
 			/*
 			 * We only use `is_literal_ssh_key` here to check validity
 			 * The prefix will be stripped when the key is used.
 			 */
-			default_key = strbuf_detach(keys[0], NULL);
+			default_key = xstrdup(keys.items[0].string);
 		} else {
 			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
 				key_stderr.buf, key_stdout.buf);
 		}
 
-		strbuf_list_free(keys);
+		string_list_clear(&keys, 0);
 	} else {
 		warning(_("gpg.ssh.defaultKeyCommand failed: %s %s"),
 			key_stderr.buf, key_stdout.buf);
-- 
2.51.0.463.g79cf913ea9

