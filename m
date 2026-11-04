Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822005;
	b=W7AJ/5wkViRaZbiulRkTPfsaEwKkb3LS2ycYK5TfhmhKa5+T9z7EuqGrpch4D4vfVWY9
	 mcYJ8kLO3PkIG7tmMGbf6ZQpo6i27cd8WPtsPLl0vVHKDJOf9W6e3ufHWNewshA+t1T/J
	 m9xbAIvZARMo9xokbadeoBTlkCux/oeJTej+yubHXUYjaknG3XMw/7xxrEk+Dt5dTaFWJ
	 COITo4y4klejpuqC3SZ6FpXujzJgsFZ4+CgDNDk6wcv5Ytw6AgtTkBRi5fZEOeSPJSaQU
	 IJq9XSmKXZ0RHruvJVTmq3a/w+9VVsLE5saGQWTnWAv+KGidYrOmcWaCAGPuCDfqueg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=vzI6SSPNrg07UjbBnbz0/XdKR8Q0RN9FyZQVq42f8AM=;
	b=0rdyhBs/qUyfsxCwNY/9DBJMbiOHEK5nfzpIXwo3lri6wxk9j9oroaA/5yK6JOTQxFhf
	 upqjhzUi6USOYCskcy3GwUXKG0WOSIiFh0lmveWq0H4jVUwmgnLzypPdMsx8NUr2a1/hF
	 XXQyxLmg286sBHiKPvKMtRYLck597IY3bYTmxSPbyQ6KtEq9qY6LexywqZTGoDF8MKBL+
	 fkMuQjtcMjgzGmsneQWWAGGqXzYPp5XK1hzGMMyeRapQdvRuur0AD+mz+IR2kgDtfcSVH
	 9jjpWPqTYhA4nXAlNhU+zIFn8aA4ZIyFCDxdPjAfdpeiGayqdpb9mbriWPb3ewwN4Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JB5dEMDw;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323760DD364
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 19:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9323760DD364
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JB5dEMDw
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-36d6765756fso1004035eec.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822005; x=1794426805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vzI6SSPNrg07UjbBnbz0/XdKR8Q0RN9FyZQVq42f8AM=;
        b=JB5dEMDwUpGd4Bwe7p1umqQxyCjF0HAJgDr6sXlFpnY8rTC+i4eVKh1LnMkHino5hg
         1nN+ljqC4TiOIkelN6xh5/R5buBA1NcTmn9MRS8lEyNefleNvGzjj5/cdJRBUUNf2a8U
         KMq7rg3/07HIbnoN4kkG6ySKl4n9u2PoVfYtLe8vYF95b+ehejWbRIb02XsHl0kIW4WM
         34LF2TtIF18g3HjqwqxFI3J23+7jAVKzO7S+FrsXSaP0xoNbwhIe2T5IW+m8dZ0ng6ZI
         yxSnrWwMTmth4M3iqq3ZEwQ6gAkhyNBW1uis9MnHNsEPjRq5UtMhIrk+WPjhKLi/dn9g
         zLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822005; x=1794426805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vzI6SSPNrg07UjbBnbz0/XdKR8Q0RN9FyZQVq42f8AM=;
        b=o/lBtUnaRA39rAxSduwv+1aFLVqtqCmqA5Aba4m5Khsmb42FiFlujX8SrUrSXF1tEw
         emNoBshGG6FZc3+UTPsZebUTZ2M8kEv4AIcy5UhLWFZ2cu4p3kVsYnOAbO5QCIhmsZD3
         5fFxsQlnN4FDwfwA8Zo3ZIUeTjqVH8EIn3vUuTHe9eTDnrAnKv6gqN3esWnnB+tKCCDZ
         9wzgU/LUn40NxnaBg3MaE7I6CMwdJMVAaiZKuC7Qf74WvYyFlyqIbnZoLSN+q4y9mGfE
         x38owocOM0Q5jgOtvklLx7H+5QO6WCyntIQat3Er4gU5DBEltYs+NrDg+QLufIeGaOTO
         1DpQ==
X-Gm-Message-State: APuU4Z/ojOAO9u2MBj3wUGfePyMOHxlkMhn7Klv5S+N+zCgXEsiqnaMG
	z8fw/Owmhk/YM+wJ/SUwNyCh6ZM0bKU1boSodEnwGj/rT0EhQ5TL+m+V
X-Gm-Gg: AYBFou3e4phCaXUcgsjhrBhuk6jTJ5rJoARZGNYg2l2zHCLowVppij+BVGPtU9jmGQV
	eNvQayl0pxbA5s2ToCKt5suJce6leZYZudO1NatBz4PNWhTyIvor3n5aMHZfPZx0958qJEKpSHg
	5YChCakGdignZsd9xXZn4q9zj7TVPI5ELFOBiw9XWjWJaZzo41WNJxhqJzE+x6F94KLFla+B6+3
	HDpc65yl8CAy3bigWLJVYJVU2NnvUdJVhz46dtkxaVgUmRIWOwLIYyTYEL3Ioh9qSeb0TueCzH6
	bGGgIacRkHnPIpBU8Hoo1Mm9DrUO2nQMIgqrh0RgvzdX5wsB6TZT6jk5cD/TEbnw4h45vtaVV6g
	msjA0qByqMwnIzbVm4IolMyz3jKDdg2MiOo/PcIBHCqQD9uV5Sbvgohx/k+sDru6L+TE5MQ1+qa
	UUr1fH7fE0EI2UyrYYu3WGayP3MEUra5G6rwGiAJxVgKgcmedzeU9DJ63pTzmFUeoomcliermYn
	3wJesOLvbNEYyOOQ2X37CxX23kaCe/+TQlA7RuvmMnThVmND9fefuW2zEy1c01/UXXh/BtpmWcm
	8rMmn3b6jhVC+LPIUizA9C2+Q44HehQHsJQ=
X-Received: by 2002:a05:7301:6405:b0:366:83dd:4704 with SMTP id 5a478bee46e88-36a423dc7f8mr25970555eec.17.1793822004459;
        Wed, 04 Nov 2026 11:53:24 -0800 (PST)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3788bffsm9598670eec.1.2026.11.04.11.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:53:23 -0800 (PST)
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Wed, 04 Nov 2026 11:53:15 -0800
Subject: [PATCH v2 2/3] credential-cache--daemon: allow a concurrently
 created socket dir
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-fz-credential-cache-race-v2-2-ddccd0831eba@gmail.com>
References: <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
In-Reply-To: <20261104-fz-credential-cache-race-v2-0-ddccd0831eba@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Patrick Steinhardt <ps@pks.im>, M Hickford <mirth.hickford@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Jeff Hostetler <jeffhostetler@github.com>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>
X-Mailer: b4 0.15.2

When no daemon is running, two "git credential-cache store" run at the
same time each try to start one. If the socket directory does not exist
yet, both daemons try to create it. The one that comes second dies:

    fatal: unable to mkdir '<home>/.cache/git/credential': File exists

That client then fails with "cache daemon did not start".

Fix this by ignoring EEXIST from mkdir(), and checking the directory's
permissions the same way as for one that already existed. We create
the directory with mode 0700 instead of fixing it up with chmod()
afterwards to avoid a race where another user enters it before the
chmod(). A directory created by another daemon was made the same way,
so trusting it once its permissions check out is as safe as trusting
one that existed before we started.

Signed-off-by: Farid Zakaria <farid.m.zakaria@gmail.com>
---
 builtin/credential-cache--daemon.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 5cc39cd172..9e6ed9c922 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -273,8 +273,18 @@ static void init_socket_directory(const char *path)
 		 */
 		if (safe_create_leading_directories_no_share_const(dir) < 0)
 			die_errno("unable to create directories for '%s'", dir);
-		if (mkdir(dir, 0700) < 0)
-			die_errno("unable to mkdir '%s'", dir);
+		if (mkdir(dir, 0700) < 0) {
+			if (errno != EEXIST)
+				die_errno("unable to mkdir '%s'", dir);
+			/*
+			 * Another daemon created it first; check it like one
+			 * that already existed.
+			 */
+			if (stat(dir, &st))
+				die_errno("unable to stat '%s'", dir);
+			if (st.st_mode & 077)
+				die(_(permissions_advice), dir);
+		}
 	}
 
 	if (chdir(dir))

-- 
2.55.0

