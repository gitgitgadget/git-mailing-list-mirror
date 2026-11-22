Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795356235;
	b=ceN0TyAXPsVxIt+yh3P0CwUHca4xyZ8d4ppzXs7MEJjp1Vq/QDmSafqznL9qwEE/0et6
	 OT7Ff7yHoiGCl92w/zJin/8g8iwJNY7RGvMxGBrDpRqYzzf75EGkPuR7pF1h9nlZMlZ1G
	 984khReKYB8R729Ztl2l2gOBYZCq0MF+5Sgzajsdd8qSzWOVot7MAdllEfBgW6OjicZj6
	 H1WZef1kdbfD6P3j32tLCOJEhTcm/B9b3WN/fQU9NMmdTufw15WvqgH8dSl+Jb6vFRcXS
	 ZJGpcgBQ5fTF3HaLgEkJa0PPOa2pinc6KlOi5IlE+aujBpcltBlTApuQkODGiSYH3yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795356235;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=OMHkSaUaeeGcuErtpjYba7L3ja/NIqQmQMOPfWfuX9s=;
	b=uggg1+iVT+vzLT1NbN3fpkHYormAZ5j8Lf7IYe95n2hkzJN4a/lFnrtdqSsGWLwzU4DR
	 5nVc8f0N1lZgAQtKnEq4qFonULi7XOm0SLFMIBHPF57uA2v8g27CuaCMqJJXlb/IBxS8G
	 V7X7XrDCluJqtxOXNctsjojkoXQXhRWTLjmmlqGlFIQ/tYTRd2HvhNsYEfwwnt87ECAdH
	 3ruesMebG6mYM1KXH+ravUSGZXEqF2dMuCVBKJP/aNDRi1uFOH320agLNsz0psGWfUt5t
	 /chI++BWTsRAm22eGdBrjYJW607os3ACmoBIM4GgGUb93I1mnObMa8GAQ3Ct5yIIGsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cU2vDhr3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=25PfMZPt;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91987606A335
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91987606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=cU2vDhr3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=25PfMZPt
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BE4061400247
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 09:03:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 22 Nov 2026 09:03:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1795356233; x=
	1795442633; bh=OMHkSaUaeeGcuErtpjYba7L3ja/NIqQmQMOPfWfuX9s=; b=c
	U2vDhr3/cSHm7uj0OS78/R/Ft/Q7j3KeS315S1+cWAy7Yignc/yWrDJeB7vtmXuD
	zFyWws9Y77D2ECO9FQDLzw/qT714Hbj9e3WgtqOeYbt1+5xnutcwoOuVXajlRFOz
	4mo+jD6CvcqtJxMuhaO01VlvUjtnriRQiGsfaiLR+/1Ok040PPsD2SFYC9huVy+5
	ls/EWrzUiEpinWIOJbHdm67kQXRpqhMuAiKcju/Cv/Jsk9oefT9Xh9D/p58qz2gm
	HGhhY8dhkuevRzDbuLTkF4Wbw8pVLWKuaN98zX/SNZA/eS3XlUFIQser/EEPdq2L
	sn8I/Lqxar1Qnpu965GQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795356233; x=1795442633; bh=OMHkSaUaeeGcuErtpjYba7L3ja/N
	IqQmQMOPfWfuX9s=; b=25PfMZPtiXvc1WgPRGBBiyVLSIRSsOeS55SIR+YyuRLR
	P6KcrcfOIZE0ketH6KfrCfxFWt6yX8ImFNHyV0PPvl2BvJP3wV0TXg+0XYBeElw0
	/uCWiR/6zGd2vnZO+AW5Xk8YjiLqY1XzXRNPHQgZek9pMzwIkcy/jk5ajk2PrnhX
	FVZjA6NQnWEaWIz9xD8xPFGbUljcB9iqhPJKp8toqx0Rs8xN+bhnrKOIo2UJJaEi
	z/lkPICsJDOafHT8GAF/EQq0MWOlckSR6jppy+eIpuSf0m8++pvI80zny5AjE6bO
	g6lwmWwAMC/FNsQicvLySskJZNezp7XGOxuf2lVkkg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795356233; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:O13t8vSYG2K6NIcxsYR2bv+W/R5D6b30j/Nz0lBm4YDq107
	65uzePnXsJFFMklV33oKzTLUnLGPQPDozCseRXSyIsm3fQiGfKYXqPi5KBglFII9
	azcJEy6Pb8om792/N7oOmmJZtk9IV70Z81dlU0hcUTdxn+rMhTIH77m+oebH2cui
	qLT0UwN0asuYiDOBAR3oKkG4LJsRaZlVNq10UTDnW9uS80XfsO7eqf0TqbO21k1d
	TV6CBYNfOQ+iklBJLoshSXgmKMG6CmLN/qhkPWUaedZacl9N4FsOTYnYUWNWtyrv
	4FXfXSdMneKXJ8hC4XkIL6DZIiLHi1l9/oPw7bw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RWxu6uj2mUZKkSLYto5XqZPF/ENHFpTOcTD14CH3LLM=:FJKCFzq9F7DdOQSRdY4B51sPwP15LAQaKJqKnD7Y6Mo=;
X-ME-Sender: <xms:SfYCa2JjAdneid15BxHVZP-Zx4ZTOzQ_EpO0yF-ybkvJgsT_A5PIUw>
    <xme:SfYCa0L8zBeKy6wjsS8UWPP67b786AOPf2ejkiaV3YdNrF7TU6tCebJ3UOlEQQ9EH
    _pnrmYSZPiNnaCtuPVlzsXs2T3YLjvKnbWqduC7bSwVyRoOtqTY3to>
X-ME-Received: <xmr:SfYCa0WqC0rVaEMVcR_-buEAcF3RDn-Ac4eV6MNR9b--xJn2w8EM4kccRgp3c_pJB_StpqWJowUQFP79-jl8wgzYvRyTHLSlS4KGEfY>
X-ME-Proxy-Cause: dmFkZTEFVDnRsW9jNPep9nj//Jc4qhWCmMhODPItEbEObIurVSxDUOQ2tkN9tE/227iOZh
    Je+974/ibFTrsQ5+mvL6yriRLkJuSrW8VM4xGN4Rdn6zXcqHg/dvlbAIFeUgQcJ/Pak5/0
    gmm7MH7oDV7k/xqFQsDiP8hmamlJ0TU04XwqpdEDyGlgQtU9FznqK2FrkN9q7GuTWBQEAS
    5Sxn2DaYEeYtLM2Cxi7LLEpHmNMYujNPSEMQV00zx9k7LhsD2K38nxN5aPuYYEkZ918gef
    AunEZlKSDn8PmlLvRz9DTF6YmuzVGMq5Xv5jfjgIeX+sMjrpza5kj9MAuqsGdb86/nC5SC
    L2C5kgpyyyDqrU5nE1We6JTo9wLeRkuu2wKMMePvA/tDJ9carLebOf09pDCSKJItYh9XCY
    1y3Qy0gonbS/zinXVx5Zdxw5dLD64au2HiY3wrZIeMXj7YkzeGMYaTmXqJvUm/dWXlXl91
    4+TlvJQrP4dQGgG/bCqpTZZ2ExjCpZJPwuiFsMWjOJmpr6n6eiLngTbGRL8FSHaeL1N7Gg
    xMQFpqnWaT5xr/maOHltKyttmD48++aHg80TXM/QH74gSlB1aJT6Qzs6HSgH27DNHmvBsa
    Ig+lgoopdxnn0YUTW6XPgzJjrOuQueBgBuuZDZl1X+Wplo4CzdMXP8AigcnQ
X-ME-Proxy: <xmx:SfYCa2jGZ_delHAR-R56JeFEt8I4BfKozaixkak6KdAGj_6qJQyHkA>
    <xmx:SfYCa_9nF5W4R4fYv3z7s--Ub7ryOApA8gzWSIXY_BRhkHXAS4rLxQ>
    <xmx:SfYCawBNEiEetMDoutkULJg5Z0qCo-OwkB8i490f4MOUE7JFt11qmA>
    <xmx:SfYCa8J7jV0rtJLASFS2lUS9WRwtWahDwf0XApfXElu0wKlHVn39Xg>
    <xmx:SfYCa5jKhXE8IDOuNciBTXQ_H_V46fbBFFrNXjwf6rVO1n_fcVCENGG5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 09:03:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/6] t7301: demonstrate "clean -i" ask mode deleting past EOF
Date: Sun, 22 Nov 2026 06:03:44 -0800
Message-ID: <20261122140347.41990-4-gitster@pobox.com>
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

After builtin/clean.c:ask_each_cmd() asks a "remove this?" question, it
reads the interactive answer from the user to decide what to do.  This
is done in a loop to remove potentially many items.

But this assumes that strbuf_getline() clears the buffer when returning
EOF.  A "y" answer on an incomplete line causes the command to delete
every remaining untracked item instead of stopping on EOF.

Here is a step-by-step walkthrough of this code path.

In ask_each_cmd(), a loop iterates over each candidate in 'del_list'.
While '!eof', it prompts and calls git_read_line_interactively() (which
calls strbuf_getline()) to read into 'confirm'.  On EOF, it prints a
newline, sets 'eof = 1', and then falls through to check 'if
(!confirm.len || strncasecmp(confirm.buf, "yes", confirm.len))' to drop
items that should not be removed, assuming EOF left 'confirm' empty.

Imagine that the user types 'a' to choose 'ask each' mode, and gives 'y'
with no trailing LF:

 * For the first item, strbuf_getline() reads "y" into 'confirm', sets
   feof(stdin) while scanning for LF, and returns 0.  Because "y"
   matches a prefix of "yes", that first item stays in 'del_list' to be
   removed.

 * For the second item, '!eof' is still true, so strbuf_getline() is
   called on 'confirm'.  strbuf_getwholeline() sees feof(stdin) and
   returns EOF without resetting 'confirm'.  ask_each_cmd() sets 'eof =
   1' and falls through with 'confirm' still containing "y", keeping the
   second item in 'del_list' for removal.

 * For every remaining item in 'del_list', 'if (!eof)' is skipped while
   'confirm' remains "y", so every remaining untracked file is removed
   contrary to the "Ctrl-D should stop removing files" intent.

Add a test_expect_failure test to t7301-clean-interactive.sh
illustrating this issue.

Once strbuf_getwholeline() is changed to reset the buffer before
returning on feof(), the EOF read on the second item empties 'confirm',
making '!confirm.len' true for the second and all subsequent items so
only a.out is removed.  Because there are other code paths that will be
"fixed" by such a change to strbuf_getwholeline(), we will not fix it in
this commit (yet), and stop at documenting the issue in the form of
test_expect_failure.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7301-clean-interactive.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t7301-clean-interactive.sh b/t/t7301-clean-interactive.sh
index de59ba3724..73e923d212 100755
--- a/t/t7301-clean-interactive.sh
+++ b/t/t7301-clean-interactive.sh
@@ -381,6 +381,26 @@ test_expect_success 'git clean -id (ask)' '
 
 '
 
+test_expect_failure 'git clean -id (ask - EOF without trailing LF)' '
+	mkdir -p build docs &&
+	touch a.out src/part3.c src/part3.h src/part4.c src/part4.h \
+		docs/manual.txt obj.o build/lib.so &&
+	printf "a\ny" |
+	git clean -id &&
+	test_path_is_file Makefile &&
+	test_path_is_file README &&
+	test_path_is_file src/part1.c &&
+	test_path_is_file src/part2.c &&
+	test_path_is_missing a.out &&
+	test_path_is_file docs/manual.txt &&
+	test_path_is_file src/part3.c &&
+	test_path_is_file src/part3.h &&
+	test_path_is_file src/part4.c &&
+	test_path_is_file src/part4.h &&
+	test_path_is_file obj.o &&
+	test_path_is_file build/lib.so
+'
+
 test_expect_success 'git clean -id (ask - Ctrl+D)' '
 
 	mkdir -p build docs &&
-- 
2.56.1-766-g80003c9184

