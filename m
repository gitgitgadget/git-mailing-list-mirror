Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089884;
	b=A44JKkjsALDbq17MvnBItogwvdpzP2VTfU8K0PnVwacs8PszpigJYcCPZ0M+d+eIqkRA
	 XSsIjVP64kC7LNHhcqNWhfqvGE7REhF9e+mm3QgcC0/Q0zU9q8Jk2ViB+xBJMFlYXSw2M
	 UZK5cSKWOxztu+n/HVxtRBTKtyEAH+vBcB8rCMlEwJ/9gbxWE2SY3ktC0Ac4buGla9wmI
	 +9cpAVFW5ixyD0KoBk5Ti4hXKrK1kIAjwR3jrao9F4t/qL7rXFw1Aa+hTpq1ezgP6mrJ2
	 VV7vEEvG4RIljdF2LHAb0mdARzk2xa0CgRcfJVPQpVJrX4gjeMVCdel28R1/S67KVpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=WeOf4DRqdt7xaaG+/C7UclMb4uK1l1Tp9C1jIGAET0U=;
	b=JL4+juOU1cRqnGNlQ9yOz5P6Q+vxJTazQBmhu4cbAxAxIDrgaTLsnKqvBRMJQ24QNim7
	 6RY/VlqxYP9ACP5g8K6hzRdGL1DhXexEEZb8bgFy493xNvkDAlJ8mag3iCUa3PiHC+RqT
	 WOfoDyEDlRMopHpvoX/ULYMVsK8cEoRCdTNWDOMo1C9LzCUXVL6t6SlsMrRt1qyrVkuIb
	 8SO+q9d29xWGZseZsRGLZren551NnqSvzmWCSDTsZ1VeQYbgTgX7Vd38vBHUUovHW8m1S
	 yDG/aSxxj3K9kGTPTQCkkTfYZ7OfXZsck72tGk7uxKJAyny4Cc1dojPJ/NysrpTBqng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e3+6hGW6;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F2C606A322
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00F2C606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e3+6hGW6
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so6193911eec.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 01:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089883; x=1793694683; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WeOf4DRqdt7xaaG+/C7UclMb4uK1l1Tp9C1jIGAET0U=;
        b=e3+6hGW6GF6KnyAaxqFN0Navd8ASl/310thVd4aSSq+oRJ1bS95qgJGDk4x3txwfBL
         yT/Z298LHZsgSLh2ijNG+Q9WlHjSelefGw7GDvuNS3/uuGBzPz1FZtHEaIQsbNNFUQku
         AFqRpebU/ZnS1JpvNlXH+Fa48hGWCmX2M75FK3oX2m6+v/iFSei6OYrxV6jETzxNRYYJ
         l8iolZNgaBwMZPp4Gn8V5mrpo5AUcYKZMi5TswLwMMBkxGlqESMwClQJ0Cp8RvbgfTr6
         UQ3dT8VaeoW+HwjMYSJqFKt7v37TnzZWE0oNhkzLvMR7EmAymGjJjUuD2cBlMMMfuKzu
         foKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089883; x=1793694683;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WeOf4DRqdt7xaaG+/C7UclMb4uK1l1Tp9C1jIGAET0U=;
        b=hMyd2JIa6NtNQ6IZYDIyfICfxJs49ZeDJnIvT6yA+Tl/eavpdcQFRslnhJWTHQKaBO
         7HpjeHDNh6JvaNKI/8qUX8pGWyjSax8HzW3CaR7k4NFN63keiqx6NIViEyoEgO4TfZEC
         W0i+uvy81uyKDRZ1tESeOqFcxK2yEadLg+p69Ody9uOKt3m/u+kcMheWQtMCFYEfG/zr
         5VStXprNzmL5JUV5XuIL5YwoWyQZwFG+++oOVzRa10zytA2cjlV92wuSB6+/mVeFCEdg
         1kaE8/tYnPg9SL5V0vfdgrXAo5/Ct656Y7x6f9XehIiD471W2BPDx6vGt/Gjx5M0Wk7I
         kirw==
X-Gm-Message-State: AFq9FYL1el/N99hVUWkBX8KdOgQlhPMBYAxVisbfkHOCxBNHcD2WFfB3
	xP2DNuk5aE6vro9QWroZ07CgdjE7ivQFCrAG/wbs8VazmY4u8jXDt89we4LrqT+6
X-Gm-Gg: AYBFou2j9X+dEshaXVXFKg+t1jUsfzKjdFd+TRZkMxN85NVBYzz+RRkzmlqQsEDbq18
	l1gbsF+OC39KobEJ8aPZ8pRPOSqNlZScJ9gjkEqPV4NPPW2Nb5TQk9TC4T90oO/osFQNUDc7gCQ
	Si5HaSwUSyk/tOiiA5VqAoD4gG6FmmIkX0JKy99kaAk1r5AnAlP2ahTyCs3o/9097aOmyNw/jTp
	IYkNFdPGkX5lxVgakL6fUsrt2BhZy3rBjpCu/l0ZFhR04ctAOTfMJuae4pcapdivwX3XsZ2V4nd
	GVtB/q6/1LZJWYYUTVhpGqdGJuCEJED6ob1zjXmE+vrN9PcTlVDCvpuz2sZEB24Aaj8T3QacvWL
	mUqAuYHZGVyrGRFaYxXKBX+qNmssup6t1h6g0EId5hDW9pL/4nJaHM/r7lCg8+qgHTNUXfg1K1I
	Hr7PUxK82t00iHxX/hY1uWmRneHczy9gSoQcL+JuWPNq/cKTJ4adXuUrpbdseKTsj1L74dLKjlr
	jjqSJDE2ZNc8xTKRK2auTpBIi6oHnB5TFvu4gzQ/wjfNre5VQy+BcMojA==
X-Received: by 2002:a05:693c:87cf:10b0:36a:15c3:2aaa with SMTP id 5a478bee46e88-36a15c32bf8mr1363405eec.29.1793089882650;
        Tue, 27 Oct 2026 01:31:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71easm30955087eec.5.2026.10.27.01.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:31:22 -0700 (PDT)
Message-Id: <8941ae12bb9acf8f3b780314dd5d4d740c1ace19.1793089879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 08:31:16 +0000
Subject: [PATCH v4 1/4] imap-send: wait for the tunnel command to finish
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When imap.tunnel is set, git imap-send starts the tunnel command but
never waits for it to exit, and leaks the argument list it was started
with. The isync code that imap-send was derived from forked the tunnel
without ever reaping it, and c94d2dd080 (imap-send: use run-command
API for tunneling, 2009-10-19) carried that over.

Wait for the tunnel when closing the connection. By then imap-send has
closed its end of the pipes, so the tunnel sees the end of its input
and exits. No test sets imap.tunnel, so the leak checker has not
caught this.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 imap-send.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index bf1d2cf74d..7e74c37a72 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -118,6 +118,7 @@ struct imap {
 	/* command queue */
 	int nexttag, num_in_progress, literal_pending;
 	struct imap_cmd *in_progress, **in_progress_append;
+	struct child_process *tunnel;
 	struct imap_buffer buf; /* this is BIG, so put it last */
 };
 
@@ -858,6 +859,10 @@ static void imap_close_server(struct imap_store *ictx)
 		imap_exec(ictx, NULL, "LOGOUT");
 		socket_shutdown(&imap->buf.sock);
 	}
+	if (imap->tunnel) {
+		finish_command(imap->tunnel);
+		free(imap->tunnel);
+	}
 	free(imap);
 }
 
@@ -1163,19 +1168,19 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 	/* open connection to IMAP server */
 
 	if (srvc->tunnel) {
-		struct child_process tunnel = CHILD_PROCESS_INIT;
-
 		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
 
-		strvec_push(&tunnel.args, srvc->tunnel);
-		tunnel.use_shell = 1;
-		tunnel.in = -1;
-		tunnel.out = -1;
-		if (start_command(&tunnel))
+		imap->tunnel = xmalloc(sizeof(*imap->tunnel));
+		child_process_init(imap->tunnel);
+		strvec_push(&imap->tunnel->args, srvc->tunnel);
+		imap->tunnel->use_shell = 1;
+		imap->tunnel->in = -1;
+		imap->tunnel->out = -1;
+		if (start_command(imap->tunnel))
 			die("cannot start proxy %s", srvc->tunnel);
 
-		imap->buf.sock.fd[0] = tunnel.out;
-		imap->buf.sock.fd[1] = tunnel.in;
+		imap->buf.sock.fd[0] = imap->tunnel->out;
+		imap->buf.sock.fd[1] = imap->tunnel->in;
 
 		imap_info("OK\n");
 	} else {
-- 
gitgitgadget

