Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACCE149C6F
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640284; cv=none; b=WNWQJ6ZMvF3sqaHwr9FJVnw0jO9OruRd23YxEcUO8N8YfszkOD9tGkxSGoSU77bVHyx9sAWcNoXO9CKvKk2mX68KcO5P2zbPZsGgBksBYOvG9wZiR6dHwbMp6OKunuTzCdv9opHuvlk5TbNT6rVIvRoN5bAcZEYGXojYAroIlfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640284; c=relaxed/simple;
	bh=W8EgyTzQCR74+k/q70hPmziHaXbhYiifnpKq2zJZ2WI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yzi79WBcuRpCKLPR1YT9iKyLK9A9Ia2NgIKbBF2Oq22m0TTu6/i6Vm0/pc6TBHBNLpoxp1AONWIlYEUo/Kzc4DU885e0QlZEJsprylU393+ZgYp6MoImgzkrYsxQyGK7mDwGQcV2wW69dOAnm/x8L/YGWKqFaCnYprUzCTnOgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkzSk4OK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkzSk4OK"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-639e1e8c8c8so2083240a12.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 11:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760640280; x=1761245080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9iskZGJIveoLnfQFCboap0T5biqRDW9+HKDFPzylwe4=;
        b=OkzSk4OK+/bM2QA9q+59LzOiecVYYCdFguna2XYykQU71sk4eMp1fKbqT+PvFCG+/d
         KwjlR2Gvc9KHE1I6IR2Oz1/hkYMFEke7Kz6NUe1Fko7aynLGGuJsJHb5Ee8IQ0NH6KEl
         TNFIxMCAwSycZjiyxN7Hd6SAUv479tw1Zkw1l5JJgute2DPyddFvdn4zTA3B86PlTHax
         KazgzYDLOkDw+qDagY9EhKFs8it+0iwuGZFLTNn2nTtDmtGnaG9iYeYKj4AjU59T9ckk
         R5nWhYMpE3O92BuiwgwhLAtX0GyRtBL/eErhlllcrbYkaIU5YWYzG1a/YcLnmWFryxlz
         77Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640280; x=1761245080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iskZGJIveoLnfQFCboap0T5biqRDW9+HKDFPzylwe4=;
        b=pxIhhfMAfrsPHVj7RvrVYJ1vnY/9c/oqPxrxqe+V3VhGQmoQgQ0e0McCExSuf+wFSt
         Ba7oyvxqUBHNiaGzHjvgF6uaV9N42lSqKxEeysHoknllVdE+bRWpDh/UA4jyISJP8me8
         Da3DJhkbUD3pbuZHy7Yna6uZumRj2/N/GOwItN0l8gHoyRyKZFjMGUMBKzcdiqnE1cGC
         3ZBMZhH4AVOow6Z89CKg/bSSVuf+BLu0V/AgZdxk3XU6pWw+i8W5/TXApIueSlvYpPie
         jJZ6wp2iTJ20yQFdPTszwjzWoLh8h6+cIS1BXix8gFjkJ/yE6z5KtAHA2Z+YfAyY4Vok
         TXWg==
X-Gm-Message-State: AOJu0YzXiBK1GcpFiqzMUIZ9neezgJPdnwCA0BTQAFJcJ+gK8q09r9yY
	YzDqSDvZrmezQdccD8w8NGo4DI5klFmloGWF3M4E+fHEqXdyyHRiCymrrLFau0Y3/NUR2w==
X-Gm-Gg: ASbGncs6trtLl5cU1JzLKzXpwO4hdWI8afECOjtFxcLr4VJOP671zBhTgqVjHtYL04G
	5gFAa7Gq+FiAGftbVpNBWvGkxjx4ccK+er8uZpN0shT4WfiYK18TvD9XHiTc0/VnPns+z7V1AQT
	FdWyK6deF/sFG1iX808AvyI4m5ehyQtneOb1RNizIbYsGEhVZ80ZnUMDH6c3WheLGUNHvm2KZI3
	bq17sm8ylyml1nKOUr1JRCnZS07X2WPpnEyezRjEUIPocqVMJCfYCzSYCMLqum0Knk2dKfQereP
	aF9w00N47F0jwkWLxT1ZKi7yAuWjN4c0wss9bswRlJSAGLeaZpo8iNPjpAd/vRL0888JlAPp0+0
	j211ZfoySQZovUwbjxXBTcLcqs2MB4QgEXspo4kwmKpkw+rWdVPO0eZgXKp9FAC4UF60hEYZ1SZ
	3++RGPB5GQU1/hRvU+MTqtGvYKGhld9EpCHWpgzGuE5M29b2uWq+hkAUOG
X-Google-Smtp-Source: AGHT+IH52i7VLwIQ9f7d0uA3Gj1RSZyi83SFJ3KmmPRBJ5oMtO4XFZEWR/54SyOXve/EM22NIxekBg==
X-Received: by 2002:a17:907:968b:b0:b45:913d:f523 with SMTP id a640c23a62f3a-b647314a003mr110361066b.18.1760640280368;
        Thu, 16 Oct 2025 11:44:40 -0700 (PDT)
Received: from localhost.localdomain ([105.113.98.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccd1af86bsm579227166b.61.2025.10.16.11.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 11:44:39 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [PATCH] gpg-interface: trim only CR characters that precede LF
Date: Thu, 16 Oct 2025 19:44:20 +0100
Message-ID: <20251016184420.78268-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of remove_cr_after() drops every carriage
return (CR) it finds, even when the CR is not part of a CRLF sequence.
This can damage data that legitimately contains standalone CR bytes,
such as binary payloads or text formatted for older systems.

Update remove_cr_after() to remove a CR only when it is immediately
followed by an LF. This keeps Windows-style CRLF normalization intact
while preserving lone CR characters that are part of the data itself.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 gpg-interface.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 2f4f0e32cb..c961607444 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -965,19 +965,22 @@ int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *sig
 }
 
 /*
- * Strip CR from the line endings, in case we are on Windows.
- * NEEDSWORK: make it trim only CRs before LFs and rename
+ * Trim CR characters only when they appear before LF (\r\n) line endings.
+ * This avoids removing legitimate lone CRs from teh content.
  */
-static void remove_cr_after(struct strbuf *buffer, size_t offset)
+static void trim_cr_before_lf(struct strbuf *buffer, size_t offset)
 {
 	size_t i, j;
 
 	for (i = j = offset; i < buffer->len; i++) {
-		if (buffer->buf[i] != '\r') {
+	     /* skip CR only if it comes right before LF */
+		if (buffer->buf[i] == '\r' && i + 1 < buffer->len && buffer->buf[i+1] == '\n')
+		    continue;
+ 
 			if (i != j)
 				buffer->buf[j] = buffer->buf[i];
 			j++;
-		}
+		
 	}
 	strbuf_setlen(buffer, j);
 }
@@ -1023,8 +1026,10 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 	}
 	strbuf_release(&gpg_status);
 
-	/* Strip CR from the line endings, in case we are on Windows. */
-	remove_cr_after(signature, bottom);
+	/* Trim carriage returns (CR) only when they appear before line feeds (LF),.
+	*  mainly for handling Windows-style line endings
+ 	*/
+	trim_cr_before_lf(signature, bottom);
 
 	return 0;
 }
@@ -1110,8 +1115,10 @@ static int sign_buffer_ssh(struct strbuf *buffer, struct strbuf *signature,
 			ssh_signature_filename.buf);
 		goto out;
 	}
-	/* Strip CR from the line endings, in case we are on Windows. */
-	remove_cr_after(signature, bottom);
+	/* Trim carriage returns (CR) only when they appear before line feeds (LF),
+	*  mainly for handling Windows-style line endings.
+	*/
+	trim_cr_before_lf(signature, bottom);
 
 out:
 	if (key_file)
-- 
2.43.0

