Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652188;
	b=VQkn/gNdrN8PkbGLVRAmBSlurt6lr5SlnaJya88O8Z6c5j0NG2DmxOtLKDGsnRYWqBoQ
	 f9eh487QPzaSXg9RN7VAiKIrn37eV+X4gmcLe7ArVkXFdzSWfdxG+fbiRPwRIxar9ALR3
	 uPxv27u0CP/R8enaEY66ltTcoDVvqbHYlo+tqJqFtLTDKlbHwvUJC0ojMPxIEQ1WE2KZ8
	 57z0sKZA0ppKbwS96GRYVy9HPuQqDZfUq5EHbovwNztHZU1y/JyhK3aH9o1bt/n7bERV4
	 jEZheRrzUMDtWmvsFAVes2Wm+II8p6LvfgyiQxR3O5cGxofaTSLEkk51+wubhsueGvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=9YZv5cUT9lvMoubXOM7Zr8uycoW+pNq2EAjs+lXU51o=;
	b=yzhpOenlT6Rdrqq4cSJmBk09pxw3PkoRq1CpGPCYPo5o/+lqQbYVTjB+SwKWxguQFFuo
	 plwc3OODsmuoUSGqFBDPa+eKYCwbf/uDY+up4EntLfWuc/sGJA0CIoO5BZMIErNZ08hLS
	 inKOPZlGn+j4+d9BQsOjeA4Jf34LnROHpVVVkm8gZxwvKer9sx1vUgHMCR+1LwwWK49if
	 OrsNPaaXFLNBxAfgve31BO+bgFc4Tjtl6bjwMjgzY/JEsLUIKhHLlzFMdKFV76Omn2nyy
	 /Vk7B5x1zNPO4oSJTIztVc0ryssUNIkjpGvyCOEeXlyk5skIRY4mRFnVooTBQomTWBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=grSe63JE;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A0606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 06:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 365A0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=grSe63JE
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917a6dccc60so7991986d6.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652187; x=1793256987; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9YZv5cUT9lvMoubXOM7Zr8uycoW+pNq2EAjs+lXU51o=;
        b=grSe63JEaM7Aw25opeDuOgSb1Fo6l1wANCEg0WnZ3cc5tam+XUO0tlf5eb6NV0j6Su
         OEheVzTPnu1erlmsfpLATqLldepgZY0e/59J7P95pEbvccoamW/Aa2vtMTh6Pxmegjgf
         rqE1WRcdfZGbOrl2YqzV136e0iVziV8LvF6LNfaS4XispSTiEzD+fX08OQNzIUvlho6k
         5GRUuaqQdYuW9xQZ9GB9u31XColVsDIrsnkXVK0967KoKIWSZEbSo1KuwP677RWmxQLn
         HuuMj96ZxgN3dfPBP5+k+X2NWKNdiMdlZNDpfLx45KTr5vRrDa8O9jR/R2mH1zmVjoig
         EFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652187; x=1793256987;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9YZv5cUT9lvMoubXOM7Zr8uycoW+pNq2EAjs+lXU51o=;
        b=1gljgpvQ/W7pz3FiSoDdm1kHoBpg/xplZeQ4/pqqVzMLxxnLbYIPac92vs3IWBcsRv
         L7Ms2Biy3CSY6SpGPTjObFFMJzQzjzimjIfCiSYzXtIOzE3dnd3NyaiCDgDPOKB3L/GA
         pnkdYsooc4XxMWPIc1Iwj9s0nVTvHocN6miqYh+IGBCFaKQ+vDGOuxoixTrPS+MKl5I2
         ahappIOZZobcgowmE79wyDpmiDL12W9RttNbt2h8QfScJCePIAWPcmJEoouySMgu1yIx
         uweOhtzIokWPvwQ49V94bWRrBgGPsNvdsYDeijn+bjB4k9OAkAk4aaxJvfMak0llRYoF
         bFyA==
X-Gm-Message-State: AFq9FYLDSY3+QzwT6v2PufAesN9zFYKSsOdK2KuxKkYDo7ZVN5hbPi26
	msglGoA7dgyQHsOze4gwfjXarpM+dUZcYNJpXRkzG3bDPBm/Ab2OXWWC1n9p2Q==
X-Gm-Gg: AYBFou0njANu7UIt6Vd5+AXIIMz16uxPbwkZvE6CsbpBJSGLCY3BiiZlZK1uk+nkio/
	OUmapWYNp1rrTjjAeNs5DnnGPigomEpmWO/JaHR3nLxYevSDOKrgffGnR8zBmO/RGcwjJIFZ/Zf
	1a9AzMSoc/vh2cvCaDEVauCUHpoIWt5rFpBaJCAO+2JTWLA5y2zzaXYgVi06AlDEtaZwnpUWYrN
	csZGGrCFIcfVbyVku+PalZd+FUn3MqR7PYp8gOt4tbh0r7eUzXlOFG/z2RZM9P7+WmAu2QTcxZC
	NAgRHjHcsbx1sDf5XJTq1tdCL+FLuHg881Xu2wgUUmOVOcf7Ro+uEsgdAJXPrVUFF4cokSbO/1B
	z1RSuZ+67DwXB7zW0NKYh5Jyc02DNP1yRIF/aVqhXWwT6wt53uaX1I0MiqjJrr+VtBXQVDjtOQ/
	e3N1JW8B8/HnnV9oAinQ1qlO56/9f8YiegdbrfQnc1EFVcDDLdJBKVzUufqiEbJMdSkrlMkwB2E
	lROe4ZkoUmdps7VYmIfGqSgZCt+C20UqJuOHVT+K4cq3Ia32w2VwvAjkKzH
X-Received: by 2002:a05:6214:8401:b0:91c:913:462c with SMTP id 6a1803df08f44-91c2300ff9amr17603946d6.0.1792652187042;
        Wed, 21 Oct 2026 23:56:27 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.173.122])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10be6a69sm44496376d6.27.2026.10.21.23.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 23:56:26 -0700 (PDT)
Message-Id: <pull.2456.v3.git.git.1792652185.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Oct 2026 06:56:21 +0000
Subject: [PATCH v3 0/4] Fix imap-send with reordered message headers
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

 imap-send.c           | 57 ++++++++++++++++++++++---------------------
 t/t9001-send-email.sh | 35 ++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 28 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2456%2FHaraldNordgren%2Ffix%2Fimap-send-header-order-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2456/HaraldNordgren/fix/imap-send-header-order-v3
Pull-Request: https://github.com/git/git/pull/2456

Range-diff vs v2:

 1:  b170b1f6d3 ! 1:  0f446c3c12 imap-send: avoid leaking the tunnel command
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    imap-send: avoid leaking the tunnel command
     +    imap-send: wait for the tunnel command to finish
      
     -    When imap.tunnel is set, imap_open_store() starts the tunnel but never
     -    releases the child_process used for it, which leaks its argument list.
     -    No test sets imap.tunnel, so the leak checker has not caught this.
     +    When imap.tunnel is set, git imap-send starts the tunnel command but
     +    never waits for it to exit, and leaks the argument list it was started
     +    with. The isync code that imap-send was derived from forked the tunnel
     +    without ever reaping it, and c94d2dd080 (imap-send: use run-command
     +    API for tunneling, 2009-10-19) carried that over.
      
     -    Only the pipes to the tunnel are needed once it is running, so release
     -    the rest right after starting it.
     +    Wait for the tunnel when closing the connection. By then imap-send has
     +    closed its end of the pipes, so the tunnel sees the end of its input
     +    and exits. No test sets imap.tunnel, so the leak checker has not
     +    caught this.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## imap-send.c ##
     +@@ imap-send.c: struct imap {
     + 	/* command queue */
     + 	int nexttag, num_in_progress, literal_pending;
     + 	struct imap_cmd *in_progress, **in_progress_append;
     ++	struct child_process tunnel;
     + 	struct imap_buffer buf; /* this is BIG, so put it last */
     + };
     + 
     +@@ imap-send.c: static void imap_close_server(struct imap_store *ictx)
     + 		imap_exec(ictx, NULL, "LOGOUT");
     + 		socket_shutdown(&imap->buf.sock);
     + 	}
     ++	if (ictx->cfg->tunnel)
     ++		finish_command(&imap->tunnel);
     + 	free(imap);
     + }
     + 
      @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
     + 	/* open connection to IMAP server */
     + 
     + 	if (srvc->tunnel) {
     +-		struct child_process tunnel = CHILD_PROCESS_INIT;
     ++		struct child_process *tunnel = &imap->tunnel;
     + 
     + 		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
     + 
     +-		strvec_push(&tunnel.args, srvc->tunnel);
     +-		tunnel.use_shell = 1;
     +-		tunnel.in = -1;
     +-		tunnel.out = -1;
     +-		if (start_command(&tunnel))
     ++		child_process_init(tunnel);
     ++		strvec_push(&tunnel->args, srvc->tunnel);
     ++		tunnel->use_shell = 1;
     ++		tunnel->in = -1;
     ++		tunnel->out = -1;
     ++		if (start_command(tunnel))
     + 			die("cannot start proxy %s", srvc->tunnel);
       
     - 		imap->buf.sock.fd[0] = tunnel.out;
     - 		imap->buf.sock.fd[1] = tunnel.in;
     -+		child_process_clear(&tunnel);
     +-		imap->buf.sock.fd[0] = tunnel.out;
     +-		imap->buf.sock.fd[1] = tunnel.in;
     ++		imap->buf.sock.fd[0] = tunnel->out;
     ++		imap->buf.sock.fd[1] = tunnel->in;
       
       		imap_info("OK\n");
       	} else {
 2:  c42827a122 ! 2:  38214d9abf imap-send: accept messages with Subject before Date
     @@ Commit message
          and git send-email writes Subject before Date.
      
          Accept the three headers in any order within the header block of each
     -    message, and match their names case insensitively as RFC 5322
     -    specifies. The copy that git send-email --imap-sent-folder pipes to
     -    imap-send then passes the same check, so the special case added for it
     -    in 04133f5bc4 (send-email: add ability to send a copy of sent emails to
     -    an IMAP folder, 2025-08-12) is no longer needed.
     +    message.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ imap-send.c: static void wrap_in_html(struct strbuf *msg)
      +	bool from = false, date = false, subject = false;
      +
      +	while ((line = strchr(line, '\n')) && *++line != '\n') {
     -+		if (istarts_with(line, "From: "))
     ++		if (starts_with(line, "From: "))
      +			from = true;
     -+		else if (istarts_with(line, "Date: "))
     ++		else if (starts_with(line, "Date: "))
      +			date = true;
     -+		else if (istarts_with(line, "Subject: "))
     ++		else if (starts_with(line, "Subject: "))
      +			subject = true;
      +	}
      +	return from && date && subject;
     @@ imap-send.c: static void wrap_in_html(struct strbuf *msg)
       static int count_messages(struct strbuf *all_msgs)
       {
       	int count = 0;
     - 	char *p = all_msgs->buf;
     - 
     - 	while (1) {
     --		if (starts_with(p, "From ")) {
     --			if (starts_with(p, "From git-send-email")) {
     --				p = strstr(p+5, "\nFrom: ");
     --				if (!p) break;
     --				p += 7;
     --				p = strstr(p, "\nTo: ");
     --				if (!p) break;
     --				p += 5;
     --				count++;
     +@@ imap-send.c: static int count_messages(struct strbuf *all_msgs)
     + 				if (!p) break;
     + 				p += 5;
     + 				count++;
      -			} else {
      -				p = strstr(p+5, "\nFrom: ");
      -				if (!p) break;
     @@ imap-send.c: static void wrap_in_html(struct strbuf *msg)
      -				p = strstr(p+7, "\nSubject: ");
      -				if (!p) break;
      -				p += 10;
     --				count++;
     --			}
     --		}
     -+		if (starts_with(p, "From ") && has_required_headers(p))
     -+			count++;
     - 		p = strstr(p+5, "\nFrom ");
     - 		if (!p)
     - 			break;
     ++			} else if (has_required_headers(p)) {
     + 				count++;
     + 			}
     + 		}
      
       ## t/t9001-send-email.sh ##
      @@ t/t9001-send-email.sh: test_expect_success $PREREQ '--compose handles to headers' '
     @@ t/t9001-send-email.sh: test_expect_success $PREREQ '--compose handles to headers
      +	test_grep "^Sending 1 message to INBOX folder" err &&
      +	test_grep "(1/1) done" err
      +'
     -+
     -+test_expect_success $PREREQ '--imap-sent-folder stores a copy of the sent patch' '
     -+	test_config imap.tunnel ./fake-imap-server &&
     -+	clean_fake_sendmail &&
     -+	git send-email \
     -+		--from="Example <from@example.com>" \
     -+		--to=nobody@example.com \
     -+		--smtp-server="$(pwd)/fake.sendmail" \
     -+		--imap-sent-folder=Sent \
     -+		HEAD^ 2>err &&
     -+	test_grep "^Sending 1 message to Sent folder" err &&
     -+	test_grep "(1/1) done" err
     -+'
      +
       test_done
 -:  ---------- > 3:  213c4950e0 imap-send: check git send-email copies like other messages
 -:  ---------- > 4:  01add80af2 imap-send: match header names case insensitively

-- 
gitgitgadget
