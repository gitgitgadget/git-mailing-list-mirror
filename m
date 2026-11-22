Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356239;
	b=mR3MCiBwRN/1HlEIgGP7EH041RUnQ5mGVfYT4mI37xB8LZntifs7+BfY13bKQB0Dm3Ea
	 oa+yZg/splkhPYsQc6ZAy4sx8BPeDfAhUDxtKz/3xxYWNkHE++s/XcNPSxi4xCgbnTyPa
	 8OuyP6Rb5kPN2BndZXXEFjhMOb4GqAaZXgZjpIUgPHOmtzO63j2VnWgQDKC8tewwtsvgE
	 SBd42miqSn1qseDIjXywJLIzrsqwF7bgOvAm0v5tBLDEJKk2KvT/CisVCTWl6pCGTs6H7
	 qZCtrCM1nM3y8aHg/zbGGQxddM2Q6O76N6EVSEyGrmrakAldEmXUJJ93KnEHhHuf+Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356239;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=TFzNOUMt4aIdvVOzUrTILbbP5HTJ0ru7g4Tfeib4fuM=;
	b=NcE+zEvNAbbkjPTZy/EM51hBe8MjcGYFi1HRzyKAtvU0IXNV3yrC+Whk3GliNIQk1mYK
	 QCkPVg5Bsx4kBt6Qh7Uz5UNxUFNEzPFT7EWLNrHzbCkB90KrE27APpbLBCC63YZSM42NM
	 hzed6UvgpjEP8dEGPYYaojNbaNqFm6Ze5pf5DdzHjeUMp/KlGBohBBO9cBAm2w9s5CI0B
	 T2mrZwS8+jM42Zm/t9LCYIx1/9moe7bFu4o5RUBvIxRlj6DVxP9tDmm5nk7K0ieqtJOkT
	 9YdPsc6NvujmG3od9LpDIxRp0Dd0ApZEicOQb8UF8uvADPDTpUppGKMzI/4GznfF3lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="j2Uc/9t8";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4qTLHJD7;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F46606A330
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:03:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84F46606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=j2Uc/9t8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=4qTLHJD7
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9D9F1400247
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 09:03:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sun, 22 Nov 2026 09:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795356237; x=
	1795442637; bh=TFzNOUMt4aIdvVOzUrTILbbP5HTJ0ru7g4Tfeib4fuM=; b=j
	2Uc/9t8d/4rleoXLV2ABQSDV9XCLyYF9XR3hSUyPovIS8496q7/3jyyjfpafY0a2
	uTTqDlO1E6Ic8hubGcSFEpGhiLRpNpmcL1uq4auOD4v/fnA5TSVtdkJyaMxAgP03
	U4SKZ5KDvKGqgh/PNb0Y37vi74H03U8aA8XLvNK3NcC/832LkALF9P3Qir/LUwre
	9VAMTMqFkjqtbfxKE45HiVlUGU/kfEV3jRlaRLhWapR/tgEioYPfOxzbyz7dhfqT
	MID4NCVBTomkHRdbEfAManLe/HlRI1gW/uS111NN/lQKlY0oF8coyxFlSq2zY38W
	5vYm9u0edVWKWBE6FfTOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795356237; x=1795442637; bh=TFzNOUMt4aIdvVOzUrTILbbP5HTJ
	0ru7g4Tfeib4fuM=; b=4qTLHJD7Cg9a9S5QFsoIU3UfPHXgKCOelKW4FyctSx5n
	7ThqqApiwPKP/nbccP4PqBvPsIQtFKyN1LSHInyNKXhRRVBHCKfH/zDDIMbbBDZe
	Zoj5C3/oNfv261bWo4zSHl2va1pDoAqDtDGFoKSrvxJjd+I0og6Tr00cMKEgbUEX
	IqR4pa2EQ8W2k7vZ0AybfPe9omNzvx/joblrE+olfjxs50nJ+FvxiM+ycvlYGMdS
	2ToFIE712w1gidON/wzf5uLMreOaoIKW7ovOBp3XWdgKleI4lI2I3apVRirvp5Qi
	JzFz9Y18Pbyhr9NBQF6kh95IJ4AdxPKLapYki5Ol1A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795356237; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cy5Fg118NRB36uzMeOdYTPvSncdtPW9cykFL075SlXnGrwX
	tR+QGrg1Intsxhlw+RR24upySNE9qXOGiF91ssrMtIRBSwmcGdJr+CokZ/Jjzmq1
	rYOhFOtjj8wSywuFZJDnospzI67ETYbeng4LialHeAPDxbrW5g+DYNKFb1q3ZC+d
	gzmxFjI702Kvj49pJXfu9+x2OVx9A9p0FpEmWcMNz6JatHwD2e8ZA/n/TzEeXM4f
	GLAjqn8goLGHIWT7+ALxh5hw84YfzHyRCZNL2mPxbeZZbFryb+Pezl7J6XUQthF4
	OqVOVafeV6N0ZOeNZ4ExWDe0AWN6m5yEo3/EDEA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:i/au7znF/sZ2zVi70u1ncP74ite+RT4LNi6yJ+wdFQo=:NKF89sgouZufuSIJNV7azdnBy3yPWMWNp7PgwSaYBWQ=;
X-ME-Sender: <xms:TfYCa7zdaYcZDwwtxgkVT-LLvWjVCswkh2LC426oq6-sj0a0r5q_Fw>
    <xme:TfYCa5TwLQ-mbujopDBbSJPM2GqFjsHexQBxsIVbafynKoqt-AA6Gsff7hsPy-HUR
    0f8U82KZIqq27SZmGKnDQTfNBffXFrAeDu3vfmNinOS7ojw4EAfono>
X-ME-Received: <xmr:TfYCay9dbRGzxrtqOIR1xDJlCwpjRjCRKtkviI_GSFXy72oq-satpwty1656iNoLyyoQu4CO1s_ZH7do4-BUncKlkTalmzKWowH0y5g>
X-ME-Proxy-Cause: dmFkZTGOSNmmm3MHuNPlZaEvjSZxZz78SD3culRZi+I0BS1ZWuZdFUYX5AaoQmptmxzzpA
    2rDq1klBA93LX7FWhCCFb/XFVmLAH8LcT4jMU4yjPNxlOP6kum1CJzjdf3drAWoDiDDBLL
    JLrq8Dyoo32pxIF5xQ38UbDzl1Muf/EQoEF7YGcE4oUBaGBzbktjNuWa/CL60jmcRtu3iZ
    8OFtLPBLXUiVV236idymllSSQ76cvuQisLopTwbgE0Dwn+ayPH7k3D+Giql71mRWKnzZWw
    pHf9QhJ0YGvDVRliCm4NHT9k0b+V4PF67GCI/khvB4rk1vOorjunSkfgZK16ElMNAdzjMP
    G9Zf/3eGqOQmqXmTUL7Ry24zG5rjBczT29+1efynOwFRiCVyIBwUfaQKhCdQeN9XsFcSaX
    HcSpRcTevfBUmq+QMROc8cuAbitHJ9ELZEom+DAq/9dP6pRJOz6iI+tHPNrAwVNJzAJv6d
    urARA8ui8vlr5X9v3V4+VtcRt4QWStqmAU7ryiTO2MnTjLTTHV3MaUX1vSeL76/xJko61U
    2gIKtPm72Hi1zP7/AErJliyhvYvM/2On+gGFEWOGI68bvI8Nag56GSHWtBvDi7MrfO+58o
    Bwa6/nxT6KHqnCBchApOzLst7Qa9WpCgTe3xRdcJe0EpfAt3428PjarmMWkQ
X-ME-Proxy: <xmx:TfYCawowd34-hd_1un_D8rgXH57CBlam5MKt6nOaB2zEiXri67Zfzg>
    <xmx:TfYCa_nt5szDfDju_Oyk__p0oElEMPbatjwpvHHQIhB-ePRQSGduUA>
    <xmx:TfYCa3L0RKVPERZdl6pG2H9Pi77h0wpFfF8_BF9oX1ucNgQ7813HpQ>
    <xmx:TfYCa0wzp2KiDyeswKcaxBY9otC3thaSOZAKr4PVcs1CY6T3aFx83w>
    <xmx:TfYCa_J5DMdADerqL4quNY4jOcMc189CwiIdIUfvMzjKsrcdcAh76sS1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 09:03:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 6/6] t7301, t9300: test EOF loops fixed by clearing strbuf upon EOF
Date: Sun, 22 Nov 2026 06:03:47 -0800
Message-ID: <20261122140347.41990-7-gitster@pobox.com>
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

There are a few code paths that fell into infinite loops because they
assumed that strbuf_getwholeline() and friends clear the buffer when
returning EOF.  Now that strbuf_getwholeline() resets the buffer before
returning on feof(), these bugs are gone.

Add a few tests that illustrate the situations in which we used to fall
into infinite loops.  You can revert the previous step and use these
tests to observe the fixed bugs.

Here are step-by-step walkthroughs for these two code paths.

 * "git clean -i", when asked to filter by pattern ('f') in
   filter_by_patterns_cmd(), enters a 'for (;;)' loop that reads
   patterns into 'confirm' via git_read_line_interactively() (which
   calls strbuf_getline()).  On EOF, it prints a newline and relies on
   'if (!confirm.len) break;' to leave the loop.

   When fed a pattern on an incomplete line (no trailing LF) that leaves
   at least one candidate in 'del_list' (e.g., 'f' followed by '*.out'
   without LF), the first call reads '*.out' into 'confirm', sets
   feof(stdin), and returns 0.  On the next iteration,
   strbuf_getwholeline() sees feof(stdin) and returns EOF without
   resetting 'confirm'.  Because 'confirm' still has a non-zero '.len',
   the loop never breaks and re-applies '*.out' forever.

 * "git fast-import", when fed a commit whose final line is a 'merge
   <committish>' without a trailing LF, reads that line into
   'command_buf' via read_next_command() (which calls
   strbuf_getline_lf()), setting feof(stdin) while returning 0 (leaving
   its static 'stdin_eof' flag 0).

   parse_merge() then loops while skip_prefix() matches "merge " at the
   start of 'command_buf', appends the parent to its list, and calls
   read_next_command() without checking its return value, expecting EOF
   to clear 'command_buf'.  Inside read_next_command(),
   strbuf_getwholeline() sees feof(stdin) and returns EOF without
   resetting 'command_buf', and read_next_command() sets 'stdin_eof' to
   EOF and returns.  Back in parse_merge(), 'command_buf' still starts
   with "merge ", so the loop runs again; on every subsequent iteration,
   read_next_command() returns early on 'if (stdin_eof)' without
   touching 'command_buf', looping forever until OOM.

Now strbuf_getwholeline() resets the buffer before returning on
feof(),

 * In "git clean -i", 'confirm' becomes empty on that second iteration,
   the 'if (!confirm.len) break;' check exits filter_by_patterns_cmd(),
   and the main menu then sees EOF and exits cleanly.

 * In "git fast-import", the first EOF in read_next_command() empties
   'command_buf', causing skip_prefix() in parse_merge() to return 0 and
   exit the loop cleanly.

Hence these infinite loops do not trigger anymore.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7301-clean-interactive.sh | 11 +++++++++++
 t/t9300-fast-import.sh       | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index c7a32fd7f0..0095674948 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -492,6 +492,17 @@ test_expect_success 'git clean -id with prefix and path (ask)' '
 
 '
 
+test_expect_success 'git clean -id (filter - EOF without trailing LF)' '
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+		docs/manual.txt obj.o build/lib.so &&
+	printf "f\n*.out" |
+	git clean -id &&
+	test_path_is_file a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c
+'
+
 test_expect_success TTY 'git clean -i paints the header in HEADER color' '
 	>a.out &&
 	echo q |
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 576fb820b3..1fd3aeaef4 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -4114,4 +4114,37 @@ test_expect_success 'fast-import: heredoc terminator at EOF is not re-parsed as
 	)
 '
 
+test_expect_success 'fast-import: merge line without trailing LF at EOF' '
+	test_when_finished "rm -rf eof-merge" &&
+	git init eof-merge &&
+	(
+		cd eof-merge &&
+		cat >input <<-\EOF &&
+		commit refs/heads/a
+		mark :1
+		committer A U Thor <author@example.com> 1000000000 +0000
+		data 2
+		a
+
+		commit refs/heads/b
+		mark :2
+		committer A U Thor <author@example.com> 1000000001 +0000
+		data 2
+		b
+
+		commit refs/heads/a
+		committer A U Thor <author@example.com> 1000000002 +0000
+		data 6
+		merge
+		from :1
+		EOF
+		printf "merge :2" >>input &&
+		git fast-import --quiet <input &&
+		git rev-parse b >expect &&
+		git rev-parse a^2 >actual &&
+		test_cmp expect actual &&
+		test_must_fail git rev-parse --verify a^3
+	)
+'
+
 test_done
-- 
2.56.1-766-g80003c9184

