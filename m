Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356236;
	b=fVaABv1i7cWDbhyQyk5+9vfrl/BbQs29q+1JwOh0HL+yqgrm7NH7gR0E+B3F0hGHNUmS
	 n6F/HPHAgRFmSGvNEC1AqZko8fwFpCKrh01p0k/dVqc7WpVw1HMvLhl2UKoiRUiidJS6D
	 zNAIa3MfpN78P9QubqBN1TtmuH9J5QFB7KpR7fVjrdGoQi8g7LCSkMMbwAHiLF7tgQZZN
	 0cbNYDJlGSdQa7wwdl2M9yNQdWEwu97iv42Bz9WQnNI5NjUU1Nwn7t1GaD7lqXbT31/ts
	 aVorVf5j+r6mH4j/7M/2s2iCXE9SglO39v+9bWLbDpNY8j1OQKPFtGcRKgOdBgbJC6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356236;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=CHyExZdx2hsvvLvPcZuXZgtjF5lAPwiF3MKZXg5BoL4=;
	b=nHLIS9clj1lzfPtaksVR92RWn6S4d+G9EnV+Q23COx53Gy85SZ835fjqXUujOZP5jp0l
	 c3SRtlwnzJPlgU1b4lXbJPyXvcNL+o8OtXUIBhn71lubCYN74aKdRHxcBg9EwdhmGXB8m
	 XDQGC27tSwi1oAFBf4bSVswaxEMnr8lzpjE5UguD+eI/o8PMNyFSHmqETHv/kigRyaOOM
	 cIB82W0ncvqmbUfIdYrQft1GY9y14jKx5SdczILU25vuQ6go6wZ6fu9bIpuZ/ozwGyQhQ
	 x5i4pw4OjQZbvKV4SALEiLX54XLOS6/XJWIGi7TINoVL20QfEA5q0adfPZqYyikK7gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="d7gE5sQ/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XFNBHqwS;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78CD606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E78CD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=d7gE5sQ/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=XFNBHqwS
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3158BEC09BD
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 09:03:55 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 22 Nov 2026 09:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795356235; x=
	1795442635; bh=CHyExZdx2hsvvLvPcZuXZgtjF5lAPwiF3MKZXg5BoL4=; b=d
	7gE5sQ/WSPdG6xfbyxqJ5hCUkh/1hI/wMB+4w8HXEu+I07z3c4Olk66osdBhlcek
	0DS8On+oZuV4TZPZwAtf0uqS35Pn7/bBtvoIsRq2ZgWi4rMPD91QPG993nmnwtI2
	wNOj7OZtKWL6s8v1SziQF+tRwPIpWjE1vxi5LKQNVU4gUR1raVLCqx6CoYxcDvDH
	TQkzJbXsx1G/Ya6DCc5k8QUUckmWZZjd4EkJKpnpt/YDuHAXq7kHJ/HB3A//1YGN
	I3V7KKwj64B1YYUOs2+3f1WUeG3CcesAt+w7I4kAyDGNaVwaPV23cBjm5zjdo+zV
	b+bX3ntA5razB+8Rq8O3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795356235; x=1795442635; bh=CHyExZdx2hsvvLvPcZuXZgtjF5lA
	PwiF3MKZXg5BoL4=; b=XFNBHqwSfcghPg1EukhHBCkSbrBleN0GQKoWD9kwczWC
	cR7t6x02yLsjHW3oM/oxDaur40oPe8bPzL9YUXlODWVwlmjVVqFcQcnSRd/9J6U9
	ezyuIh9qykO/co8vCejRR+gP0jRk5eBzXyjBtxZ3+mRn3xKggKT7epyFpAFgtW0i
	lM5TV4RIvWHtb388jRAWU2fDTWhx02uGc0o+iMyS9ex8dIrypCjn5i9W9HKHyFAv
	1LZTKlmhGp7cjVADh2lWuc2L46oOyVZ2pk2YvzEYjA4OGVod6PmJbVeIlmeLoQW9
	atq7HjQTLZeSBhw2Wbu9BEGG7gzgUFNEX/ZLsXS/WA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795356235; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ipTrYzbi3p5ADfLyMZOK3Mx5jr3qVlFq3jMjbCsOZ19R8YI
	0e1lVyhaV6l1wgElX/F06NmeSz2cNBAOFwiA4gyIsrUPbTXLhrpPmad5L0hS7iKM
	MniLoTdR3gjkB6EAxpACwk9Xi5dYU35rVgNe8vpe+YDGdDeJMcwhmSxuJNWm7CAP
	PYA8zdC5UmRHq8xXu/of02fTS29ZHIHEq8VNJxWRLmzRp58v6rSJOYMBbZkCgYvn
	MYgW51wNVian+8BayNdoJipgPIoKI41uW6/zpR8btYFARFCE5re02UxFFCnpK2vr
	M4v/5I6rkJsO+jaTO1rVc45Z7URb0UttAhuIkrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:jcD958+ZKVR3jhIzy3qCP37mFjBBGeTBWG7CLISYb1A=:wvgxxQQfMeiUsi91kxX9ZzJk6foGKVvk53pZQj8mUzQ=;
X-ME-Sender: <xms:S_YCawgTdKsd4d_Fw2ZNMk77giVlTqRhsKCZ2RDDBw7Dn5qiIlVlLA>
    <xme:S_YCa_DpeJ16QJ5cesCmlhsenB9ByQ7LCXAIamOpKQJTYlIc9E4h_9i3n3OHs8S1q
    RHxT2iOTYCZb3j80u5kYxnxFySBAoOuGK8UiEDKJ_rMvwMdiU3SuA>
X-ME-Received: <xmr:S_YCa1sxMqw9UYsNhfayGWpeFKwVj46lzpMyNwMVXy66-lcL_HTSwcPFsGnB57gclqslATctkIrDRchDkgH1Vk_ejWtZQmNXrJ0CFpk>
X-ME-Proxy-Cause: dmFkZTEFVDnRsW9jNPep9nj//Jc4qhWCmMhODPItEbEObIurVSxDUOQ2tkN9tE/227iOZh
    Je+974/ibFTrsQ5+mvL6yriRLkJuSrW8VM4xGN4Rdn6zXcqHg/dvlbAIFeUgQcJ/Pak5/0
    gmm7MH7oDV7k/xqFQsDiP8hmamlJ0TU04XwqpdEDyGlgQtU9FznqK2FrkN9q7GuTWBQEAS
    5Sxn2DaYEeYtLM2Cxi7LLEpHmNMYujNPSEMQV00zx9k7LhsD2K38nxN5aPuYYEkZ918gef
    AunEZlKSDn8PmlLvRz9DTF6YmuzVGMq5Xv5jfjgIeX+sMjrpza5kj9MAuqsGdb86/nC5Hp
    W0kYfXNQymFQ/7aCeS/QnVXE93xlXVW4SUZVbWGbkZixs/4Y4kS95kxCftZc6Qlqlp0Tl7
    +3M5BYYQ9SUqTLsMfhqx1HaoSSAKKI21WywFPCfZHtRvTuCRBZ4/OosFMTCqOn85BlYaQY
    +IFANiYFBzMtlsRJ/DYwjm4cy78kbUc0VHIw5Mh/L4/npO53cgUOPlZUGlxxhazJU2lOyq
    qPNlKPCkWLyKQZQRa2kr8zTE6f21cKRy45CUD4egZqpUC6nEt2rukgDa9VgTj9WimKW1Wh
    L2dH9IwdDXCZxwfrnXRJn3MNa9XAdr/5nXWbvzBRjUaTL+jpi+LVp5zVWr0g
X-ME-Proxy: <xmx:S_YCa8YOdfvdWRt8pjoh9KQETw2_UJzyBnblCtpeq7RDmNH278JRcA>
    <xmx:S_YCawWsa3jARq7biH3zAuGtkmkgs7PXEpj1zGry7sjJegRIieTU3Q>
    <xmx:S_YCa46nmIpTP7uDRShqLl2aVngZEqvWN4PDKHM7PvzdzUVH4D2TKw>
    <xmx:S_YCazieBaAeNPakiYNMqdID2AEz1Um9PApF2sMkAUTOSTZWUDgUUQ>
    <xmx:S_YCaz5FtwvADOEzekRHLc1nhgerAx7OmdAjK7fhB184l150vfdAtSuc>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 09:03:54 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/6] t9300: demonstrate fast-import re-parsing heredoc delimiter at EOF
Date: Sun, 22 Nov 2026 06:03:45 -0800
Message-ID: <20261122140347.41990-5-gitster@pobox.com>
X-Mailer: git-send-email 2.56.1-766-g80003c9184
In-Reply-To: <20261122140347.41990-1-gitster@pobox.com>
References: <20261122140347.41990-1-gitster@pobox.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After reading a commit message via builtin/fast-import.c:parse_data(),
parse_new_commit() reads the next line into 'command_buf' via
read_next_command() without checking its return value, checks for
optional "from" and "merge" lines, and then loops over file-change
commands while 'command_buf' is non-empty.

But this assumes that strbuf_getline_lf() clears the buffer when
returning EOF.  If the input ends right after a heredoc commit message
with no trailing blank line, that is not true.  The stale heredoc
delimiter left in 'command_buf' can then be re-parsed as a file-change
command, corrupting the commit's tree.

Here is a step-by-step walkthrough of this code path.

In parse_new_commit(), after reading the commit message with
parse_data(), the function calls read_next_command() without checking
its return value, runs parse_from() and parse_merge(), and then
dispatches file-change commands in a 'while (command_buf.len > 0)' loop.
It assumes EOF clears 'command_buf' so that the loop is skipped.

When a commit message uses a heredoc delimiter matching a file-change
command (e.g., "data <<deleteall") and the stream ends right after the
terminator line ("deleteall\n", with no trailing blank line):

 * parse_data() reads into 'command_buf' via strbuf_getline_lf() until
   'command_buf' matches "deleteall" and breaks out of its loop, leaving
   "deleteall" in 'command_buf'.

 * At the end of parse_data(), skip_optional_lf() calls fgetc(stdin),
   which hits EOF and sets feof(stdin).  (Note that the input does not
   even need an incomplete line.)

 * Back in parse_new_commit(), read_next_command() calls
   strbuf_getline_lf() on 'command_buf'.  strbuf_getwholeline() sees
   feof(stdin) and returns EOF without resetting 'command_buf'.
   read_next_command() records 'stdin_eof' and returns EOF, which
   parse_new_commit() ignores.

 * parse_from() and parse_merge() do not match "deleteall", so execution
   enters 'while (command_buf.len > 0)'.  Because 'command_buf' still
   holds "deleteall", parse_new_commit() calls file_change_deleteall(),
   discarding every file inherited from the parent commit before the
   loop's trailing read_next_command() check sees EOF and breaks.

Add a test_expect_failure test to t9300-fast-import.sh illustrating this
issue.

Once strbuf_getwholeline() is changed to reset the buffer before
returning on feof(), read_next_command() after parse_data() empties
'command_buf'.  The 'while (command_buf.len > 0)' loop is then skipped,
and the parent's tree is preserved.  Because there are other code paths
that will be "fixed" by such a change to strbuf_getwholeline(), we will
not fix it in this commit (yet), and stop at documenting the issue in
the form of test_expect_failure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9300-fast-import.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 15f511fb6b..22d697ff9a 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -4087,4 +4087,31 @@ test_expect_success 'Y: rewrite submodules via stdin' '
 	)
 '
 
+test_expect_failure 'fast-import: heredoc terminator at EOF is not re-parsed as command' '
+	test_when_finished "rm -rf eof-deleteall" &&
+	git init eof-deleteall &&
+	(
+		cd eof-deleteall &&
+		git fast-import --quiet <<-\EOF &&
+		commit refs/heads/main
+		mark :1
+		committer A U Thor <author@example.com> 1000000000 +0000
+		data 5
+		init
+		M 100644 inline file
+		data 6
+		hello
+
+		commit refs/heads/main
+		committer A U Thor <author@example.com> 1000000001 +0000
+		data <<deleteall
+		second commit
+		deleteall
+		EOF
+		echo file >expect &&
+		git ls-tree -r --name-only main >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.56.1-766-g80003c9184

