Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089883;
	b=oFbPCE2f3BpgDQCrAssLDX8pif5A3fqfw4Y7AjKzW/Rh9dMUYohZ7JrCYo6S6ikGN5+E
	 ea5ycfAp7yd/5bb7zGMXXnBCq2E2n/zWIUTTPs51dQdTJ2uliLGJM6Ueojy1IYpp7+Ya7
	 ASRjyxZQT4QMeLKykxo/oIp+QtmmnQmN2BoD14dtHiaaFEHmKQp8b5Hyf40R2TzBtnrjG
	 ZqZtqEYOdURsV7ven9IT0/ZgtEsP0BXXOKqzu+GWjh5byRrhz7DGkMOwRQQpFyqOs54HC
	 NyU6QwhACtn9pCXVy5o2U977NSD43XwlMklJEz6m0vESwwiOYYqGhI/awmkyYHQviLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=6i2bM5HaFXfEgiBJkebj2MDcvZVZtXSsdVM2GiaqliM=;
	b=Arh/QSmChcByFvS0f2K5decmp2bQX/7knK1wFPUh3PFM53xopwt3kIkeEah/mUPPBF8z
	 1px2zMg5KxZ024poNOhRqlL+swSREA7Ri2v7afVQXiCgY6ey1c09q8WE+QL1JR/I9IdyG
	 BF1Ywg9NyCw4vQ9t0jtllrFsIohidH7LYAKY35iLtHxaz3mbPNtmgOnma2KtXjc6Xh0wY
	 Ia7WHkChM1Ub1VFCPFkoPekZgo9imGaWz0jqN/EeaYK/PSqDSX6Rb40mzcuWQ89T8RVkr
	 KtuRxiR8VWfL7CF98blgfYFrOuoNZ3rFhL21pEsT+IFZbCGGQfylm4vsWLn1rgtr05Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MOaha76M;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB013606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB013606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MOaha76M
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-33fb4680717so7166183eec.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089882; x=1793694682; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6i2bM5HaFXfEgiBJkebj2MDcvZVZtXSsdVM2GiaqliM=;
        b=MOaha76ML7HNCWuEKub+9sHOsoQGMj9AEx1kmQAfrXUaV2J+kKuW9++EOehx/XwzpD
         xvS0dt4DeYj9bbGJ4k5ksAkbnJ/uRa2DOREHmh/vqCgJC5JAzdiIBKTZG7zlvq4YQ0yK
         OuXf0UUTvdMQD9NGSHlRK16GOCAJIUb0rrfPXn11yeoxspHo6Odjr96CJ3osBnjPRf2h
         SFBpn+n5LgFkGquIba/Rc1/yT+aJeS0RNvMg1Sg0qTicWOZH8+YcHJKe/s+isv9FEawW
         AefaPxjM2WCOO6zczN4AF1PSswFXCVpXJmOZJYrOfIR7mkp3YAzQ2qJ3lx9cgy3Cd3o6
         3Olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089882; x=1793694682;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6i2bM5HaFXfEgiBJkebj2MDcvZVZtXSsdVM2GiaqliM=;
        b=WlwlMagVmLNOKdRZ+R0hryW59dG1H8nJq8DKs+ikur6XxRIEoyUKvB6Lm88o1U/wd3
         dyZnMNdCG+kM/voikGj8/5jQUcNmhMq5w+BWWKwvyNY5aDGG1XXfsPZwl/gkUUWefNCY
         6KBURe871m5CdoRW9X2Ysz0RJeJ9O4lwTj6tnm9OYgzZNRmLtOzvK5lEqptpU5npiBLE
         5iFJ07EYYjhe2nd3A6yH9bhJ2pQepVklRufP56w7C5v+AmxS91L6zZeEtfgpdCaWWPaV
         24iKNMS+fH3brhiOzPEaLHy/LsM6cnVoxklGiZeaKLzfuHPYw25x03qZHUEdkdRn1XrZ
         hqtA==
X-Gm-Message-State: AFq9FYLZfihVxv4S0fskRMYO0co19Rm9XGY+2Wglqa4qq9rnjoSqc1L1
	lMuFT5sfeNMQKiSIEwzvInczJXmaARVSwaBTvrB1CL1zoV4dTItZOuGZwbMC95Ep
X-Gm-Gg: AYBFou1VTBfdM+EqQIP84RdFaf/qwk4bvEExhkGDl2gBtT2ggV/3WlvPhmRdMIXZpAC
	BDAwSsOEMn65arjycuRo6zgpSMvdsVKTLyoi6/LdFgcVeZ3nnsI+LlRUC3QI5n+bH8d7+touOyY
	Z5e1XhKytD7pZcOzCKEGTaPTtJfm/JVKNdsKjE0crKu+BrQysoneL33CAvjoXth7upTHyZv23bk
	+BAzz3Ex8eaffyMwPLGmLUNF7kEjFWGCHMSUckuiUv4D1R+KuH4VdQoMiu0TLOL+apkbGGIwOaG
	dfQP38AOQEnKXxKDZ0G18lsA3K/QUA4Rb8vj3/0KCZojgb0L0q0Xp7+UkvMOHNGzZT7licFFnOU
	AuLGSu3RBEalwi3BN7BWoO6kS6qMrtORtlJmnS3sbX24e1HhUPjsw+5TMx4tGg8oK2+tStcfPhf
	MaL3ifHcf1dc7Wq1BPhj1IU6pYmTgmBGY7hqdzbi6NBjnrs3TuWdT01f+PE7vzSHf5WJZokYFHm
	VMh890OQTYTdry7xGUFJfCI1FNavrsuasEm6rgSRw9OslWAve8Giv+XXd0=
X-Received: by 2002:a05:693c:4009:b0:36a:1819:4d0c with SMTP id 5a478bee46e88-36a181952aamr927735eec.41.1793089881310;
        Tue, 27 Oct 2026 01:31:21 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.77.163])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ef6a71a4sm31803009eec.8.2026.10.27.01.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:31:20 -0700 (PDT)
Message-Id: <pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 08:31:15 +0000
Subject: [PATCH v4 0/4] Fix imap-send with reordered message headers
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
    Harald Nordgren <haraldnordgren@gmail.com>

git imap-send rejected patches sent with git send-email, such as ones
fetched from lore with b4, because it expected Date before Subject.

Changes in v4:

 * Store the tunnel as an allocated pointer, so it is only finished when it
   was started, and drop the local tunnel variable
 * Add a test for lowercase from:, date: and subject: headers
 * Explain in the commit message why dropping the From git-send-email
   special case is fine for mboxes written by other scripts

Changes in v3:

 * Split concerns into different commits, commit message explains what they
   do.
 * Handle tunnel leak in the proper place.

Changes in v2:

 * Case insensitive header match according to RFC 822/2822/5322.

Harald Nordgren (4):
  imap-send: wait for the tunnel command to finish
  imap-send: accept messages with Subject before Date
  imap-send: check git send-email copies like other messages
  imap-send: match header names case insensitively

 imap-send.c           | 60 ++++++++++++++++++++++---------------------
 t/t9001-send-email.sh | 50 ++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 29 deletions(-)


base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2456%2FHaraldNordgren%2Ffix%2Fimap-send-header-order-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2456/HaraldNordgren/fix/imap-send-header-order-v4
Pull-Request: https://github.com/git/git/pull/2456

Range-diff vs v3:

 1:  0f446c3c12 ! 1:  8941ae12bb imap-send: wait for the tunnel command to finish
     @@ imap-send.c: struct imap {
       	/* command queue */
       	int nexttag, num_in_progress, literal_pending;
       	struct imap_cmd *in_progress, **in_progress_append;
     -+	struct child_process tunnel;
     ++	struct child_process *tunnel;
       	struct imap_buffer buf; /* this is BIG, so put it last */
       };
       
     @@ imap-send.c: static void imap_close_server(struct imap_store *ictx)
       		imap_exec(ictx, NULL, "LOGOUT");
       		socket_shutdown(&imap->buf.sock);
       	}
     -+	if (ictx->cfg->tunnel)
     -+		finish_command(&imap->tunnel);
     ++	if (imap->tunnel) {
     ++		finish_command(imap->tunnel);
     ++		free(imap->tunnel);
     ++	}
       	free(imap);
       }
       
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *
       
       	if (srvc->tunnel) {
      -		struct child_process tunnel = CHILD_PROCESS_INIT;
     -+		struct child_process *tunnel = &imap->tunnel;
     - 
     +-
       		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
       
      -		strvec_push(&tunnel.args, srvc->tunnel);
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *
      -		tunnel.in = -1;
      -		tunnel.out = -1;
      -		if (start_command(&tunnel))
     -+		child_process_init(tunnel);
     -+		strvec_push(&tunnel->args, srvc->tunnel);
     -+		tunnel->use_shell = 1;
     -+		tunnel->in = -1;
     -+		tunnel->out = -1;
     -+		if (start_command(tunnel))
     ++		imap->tunnel = xmalloc(sizeof(*imap->tunnel));
     ++		child_process_init(imap->tunnel);
     ++		strvec_push(&imap->tunnel->args, srvc->tunnel);
     ++		imap->tunnel->use_shell = 1;
     ++		imap->tunnel->in = -1;
     ++		imap->tunnel->out = -1;
     ++		if (start_command(imap->tunnel))
       			die("cannot start proxy %s", srvc->tunnel);
       
      -		imap->buf.sock.fd[0] = tunnel.out;
      -		imap->buf.sock.fd[1] = tunnel.in;
     -+		imap->buf.sock.fd[0] = tunnel->out;
     -+		imap->buf.sock.fd[1] = tunnel->in;
     ++		imap->buf.sock.fd[0] = imap->tunnel->out;
     ++		imap->buf.sock.fd[1] = imap->tunnel->in;
       
       		imap_info("OK\n");
       	} else {
 2:  38214d9abf = 2:  ad3158b336 imap-send: accept messages with Subject before Date
 3:  213c4950e0 ! 3:  919e38c31d imap-send: check git send-email copies like other messages
     @@ Commit message
          the check for other messages. A To header is no longer required, the
          same as for any other message.
      
     +    This makes the check stricter when some other script writes an mbox
     +    with a "From git-send-email" line. RFC 5322 requires a Date header but
     +    only recommends Subject, so a valid message from such a script may
     +    lack a Subject and would no longer be counted. imap-send has always
     +    required a Subject under any other "From " line, though, and only
     +    refuses an mbox when none of its messages are counted, so treating
     +    these copies like the rest should not affect anyone in practice.
     +
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## imap-send.c ##
 4:  01add80af2 ! 4:  5b4a08bbda imap-send: match header names case insensitively
     @@ imap-send.c: static bool has_required_headers(const char *line)
       			subject = true;
       	}
       	return from && date && subject;
     +
     + ## t/t9001-send-email.sh ##
     +@@ t/t9001-send-email.sh: test_expect_success $PREREQ '--imap-sent-folder stores a copy of the sent patch'
     + 	test_grep "(1/1) done" err
     + '
     + 
     ++test_expect_success $PREREQ 'imap-send matches header names in any case' '
     ++	test_config imap.tunnel ./fake-imap-server &&
     ++	cat >lowercase.mbox <<-\EOF &&
     ++	From mboxrd@z Thu Jan  1 00:00:00 1970
     ++	from: Example <from@example.com>
     ++	date: Thu, 1 Jan 1970 00:00:00 +0000
     ++	subject: [PATCH] lowercase headers
     ++
     ++	body
     ++	EOF
     ++	git imap-send --folder=INBOX <lowercase.mbox 2>err &&
     ++	test_grep "^Sending 1 message to INBOX folder" err &&
     ++	test_grep "(1/1) done" err
     ++'
     ++
     + test_done

-- 
gitgitgadget
