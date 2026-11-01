Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521303;
	b=5eB7pToFGSbnaHdz1F/VUlxnOGjqTr1c27GmA4y9ZjnKt7BHOqCfpFTR+sQp5aJG1agC
	 2RoYgz+35Vz6D/+1gkLZ1skE4l0H88gD7NbCVaT+JrJEAvzdBQCEk2k896Zs9UBG/1G+W
	 OO6Zlyr3TGVrxbs4W5z3GhzUDjn+3m7yB8PibiZw2eygCWt4wDMnf0PI4AD3+WLZ2kWmX
	 13o2lT9K7/3m7KVFpJ2eZhn5Wtvpcmj9AOY5ZoNq16m5vwqXlGuHUFdZlqLZHM4z6H0FH
	 l2DdbTu1N+ZpyzEkj9eWuP4GVhuZzWdhuKtKQzGNiFs4NwfH1wJNoi+ouf8FQv1Bxxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=WeOf4DRqdt7xaaG+/C7UclMb4uK1l1Tp9C1jIGAET0U=;
	b=aJngskGWVMQEytlmrnwDgET6ioVtVUkhGwbB4Ynck4ejfIlh5XUZY9ORcLBpoogKdZQ7
	 13aB3V2WEHE8PzD7DzeTvMGvdMog01S17Nl1vyruf7IaVKPngqnpRqWW54jU2J5JfNODY
	 fIP01xlnrzQ3szlNqC2mukGCRCGlUdfjncpA3WE91Y66sdtZMGCLBp6QvxCkt3ilOblDm
	 2qQhQDzUWiu21Cf6Ns3vRKeG5nPjhcJs4xb31cyL1/VEutLHUOWiQUvywdT/+3eTicX+X
	 FXjZJKZ7Ln8UMKKz4a/W+K22jP7JstHmznaiq3gqt4g6/IVHFJ32xtvHEjAyaOEYp8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pNsw0QKv;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F729606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F729606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pNsw0QKv
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91c75be77c4so21293406d6.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521301; x=1794126101; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WeOf4DRqdt7xaaG+/C7UclMb4uK1l1Tp9C1jIGAET0U=;
        b=pNsw0QKvRNXDvzbEhgt8hpMVTQ0Ld4Gayzezwc7aaeRq74Rm1uM8ZI0o97lUuNdagx
         askGSghOyjSFF4f4ZwMCWd44oAqcwpFa0gij2f8CPdRVvwxCkQPEMrhyeSWzKOrO52Dg
         3T513A4gHaL8tgNYLBvtgO5Qk0Ex35AratxpK2oJc3Ted6WBYd1cayiDoDRvo/VpbL3y
         uDGf2ba5aQCRsglNtRQVkZT+7nM5jpS2LXboNHPcn/UHIz1pvamyLTvYSY7AkfJCN421
         wUCTUriqpMS9v+vJ3TH2+1IpaG3GoGg9ERG6c9Wmuje9yVRSRT5inq12GJk4CSPZ2B6V
         5Brw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521301; x=1794126101;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WeOf4DRqdt7xaaG+/C7UclMb4uK1l1Tp9C1jIGAET0U=;
        b=rZbcBtSfAMEeeWZP9QP0su63LN+Yw9Jsm2YvFCOYpNAog1nJc8nI75yjJAiTt05y1b
         16S2SHiLcAsuSXKrirG6inNNrwp6U1nfT3CKYo72gqzVXqJMyKQQV9FCUcTmFHDiQ4D5
         f/riwzt99Q+Q2RoTJW4Gy6fW0K0MA9quoFklHoBa1mdF1IrXR0m3pdsp9Hn2bamlqaYS
         pM+4luRevDjivI9Bfr3JXjNybnCK9hyUc3cUc23iakbZpD4hQQfaAzGAc3WPPE75ZGN8
         GutfdfzzeMf8yGRUoH5Oi/aZQONBCa0zbFADghgcUfMsowDc/0Si4TG74kuBBhvlz/bW
         6hyQ==
X-Gm-Message-State: AFq9FYJuPedpY7QCge7iyhhod44jV+iMPFjWV7JhweRJKmjywGEMAs74
	FoVxjJ4kHSnkXRSs6R6wSFosN/OsFmJ/s+qO0tM8bTHBXCcRRVnKiCtPT/yM1uSdsuo=
X-Gm-Gg: AYBFou3/9V7avqER2sjfuelPB+1TcM+XsiPtOa7pT1rq0PMsbcypTtvYmy2JN8381Q+
	BRgoEijxP5cSMc+xJKv0R6lOOSed6AZs9ZZo5RLpAwwZiasCoeCzxAYWt329OWfUOd35Y6lHzHt
	1JvlhLD6UzbvMqVG0iRs08rsaHZHp1+ZtmZ/Qlb4vP6EzGNkoTMflbmlhH0+73VeLBW5pLTftAL
	lMw8g5s4cIN/EhsHlZxOKGa/5PtXx6pFL8caSTBEcR5x5gi5HXk8yrBY7HttZbhILHLXsWTs8gs
	fLRQIuXF2zyAlPcNVgJwCHXjP9rVUb+2kJq6vPr3PCuC8V6v4rFCZwTdHhLK3iVvkz8xaVzyxQs
	tAlgnlF7pU4xr7H/7VkaoYwcN1Ub8VCyricdL8nhW0yiidNAysZBpxadx0UYfWMqK53iUPr8YPg
	VuwcJnKIE0+mZ5P0/BivGbxKqqOg1q+FHyOOgocv/7Go1va+daItpEgSC0CiB8j1Gyqgyv4cWUF
	tgNwAAVNw925uCI8NNsSPGPkETysK1alFEfDrPAFUynNg7cMj1cH3p/KGsMfOZqTusfrPowegSW
	Jexvf32ua5OFS+I+OOZSZUIEXmNB+Fw=
X-Received: by 2002:a05:620a:31a8:b0:93e:6c02:d181 with SMTP id af79cd13be357-9442161975cmr1198521185a.14.1793521301449;
        Sun, 01 Nov 2026 01:21:41 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.79.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425ac5322sm557501885a.39.2026.11.01.01.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:21:40 -0700 (PDT)
Message-Id: <cb27ac3a27eb9b6d3b951d34422b6bb6a43b8626.1793521297.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
	<pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 08:21:34 +0000
Subject: [PATCH v5 1/4] imap-send: wait for the tunnel command to finish
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

