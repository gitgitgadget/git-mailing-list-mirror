Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.216.95.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793406352;
	b=OYnIp33WmRliBq+dexJQYQX+rdx1VQdsZQfv3P6unwjtTkifBZn00VdcLCKcDYoq2mIz
	 2C/5w2jSHUsqX8tejxAkq8wFYIdAqPW2GO54OaQwM36ciECVIRifE0iP+g2YSuCysr6LU
	 IbKwJw9E8Xp33MLcB81Al7zgKCnPEE3QgOiQnwXjAdzzC8YZDb0TTWSvmwmaokHA7UH3H
	 cKSFmklELuA+AcUYx/jBzfSEUEFOFajBzJb2HhYdPTlHryZZj+FUfQk/oL7ez/fAhS3V5
	 zjZ/tmvjB3gjxnufMD2vq352xPuUP+cWw1qmf2USDRV5TLMGxZ2PLGHmgJFJcZofTNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793406352;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:Date:
	 From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=C1fAkcp/58rNYpd9ywX1KTf3+JcWanj+nVafcorSjUY=;
	b=yye3CWqOrz6MGWttCNX2YHCWzYmYRuRbDgn8staLruDjQrT7BPqx6kjPp/r3cT+cO1JV
	 i9t2lFb/PuJxFslFPgekMwuKhOvZShNjfV2Y+1on4/Pa/DG4VjSg/eKPsQBuQU1s7MR/7
	 7hUIjcj1byZGR5SN8dSSWLUTOeA+yKW9OVbJ0reWcPBNM9K5DHtqDkk12Dv6lNaEbbuRh
	 2vQI9j7JGC8zMSzWLpohmU0QN4Uz8JezXaByiugRLqiC2DfqccijrMZ/ui/LprATE+VXw
	 frGH8nwLPnisP+eLja1RNAajAgZJMRcY7uQXWgYThY40zMO5C+7CRa6WA70m22+WY1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=peff.net;
	spf=pass smtp.mailfrom=peff.net;
	dkim=pass header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=Y7A29r4K;
	arc=none smtp.remote-ip=217.216.95.84
Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF59606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 00:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEF59606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=peff.net header.i=@peff.net header.a=rsa-sha256 header.s=20240930 header.b=Y7A29r4K
Received: (qmail 49913 invoked by uid 106); 31 Oct 2026 00:25:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=HuOJJKPRJtD0AzSqgBc49sYig+7SHznfE+AaSZz6Fo0=; b=Y7A29r4KZuQjxZfvoyYzEx+ll5PtWmV22s5XCuNKSLg0WWSTmKEhXpM12IBO9Ptg+fGlsqG8C1W6SFTMad3UQmJL8MNAJFbuGls+dqDqRpx3lOf7QO3C9NpGp/6S08FdEtso+qNcSu9LURxaPUX0VyMNuK4p1khw1ugHgpEMr6qMBqBF5nReoX4n3bAp69YA+Vvy3hRDD+QTugdABZauoTEU+CJlc4+kIiA1UpEQ8Eovm9MbEDHtU2X4gaSU90kgceiz+OsCZ1j0bDtm5NoxpzTbOG15afs3vbUu937ChVZWKdmm+rtYiM3zmzsbLe83FcWM/kcGhXsQDxyZxt5TNw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 31 Oct 2026 00:25:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 327175 invoked by uid 111); 31 Oct 2026 00:25:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Oct 2026 20:25:50 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 30 Oct 2026 20:25:50 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] t5702: be more resilient to env quoting
Message-ID: <20261031002550.GA626623@coredump.intra.peff.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

A few tests in t5702 check whether we specify the v2 protocol via the
GIT_PROTOCOL environment variable. They do this by redirecting the
output of "env" into a file and grepping it. But our exact pattern
depends on how env quotes its output. GNU coreutils 9.10 will output
this:

  GIT_PROTOCOL=version=2

but version 9.12 will output this:

  GIT_PROTOCOL='version=2'

It doesn't quote every variable, but the presence of "=" now triggers
it. We could loosen our regex to accommodate both versions, but there's
a simpler fix. We only care about the value of one variable, so we can
just print it using the shell invoked for the server-side command.

Note that this new formula is slightly less strict: it allows
GIT_PROTOCOL as an empty string in addition to it being missing. But
that's OK; they both mean the same thing to the child Git process.

Likewise, it's actually more strict when we do expect the v2 protocol:
it checks the contents of the whole GIT_PROTOCOL rather than a partial
grep. In practice it's the same for now (we only ever set protocol=2),
but I think in the long run being strict is better (if we do add
something else, the test will break and we can consider how to handle it
then).

Signed-off-by: Jeff King <peff@peff.net>
---
The new coreutils hit Debian unstable, so I ran into this doing my usual
daily "make test". I wondered what idiot did the overly-complicated
"env" invocation in the first place, but naturally it turns out it was
me.

 t/t5702-protocol-v2.sh | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7e69ba7f84..a66adfbc3b 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -929,28 +929,35 @@ test_expect_success 'file:// --negotiate-only with protocol v0' '
 test_expect_success 'push with custom path does not request v2' '
 	rm -f env.trace &&
 	git -C client push \
-		--receive-pack="env >../env.trace; git-receive-pack" \
+		--receive-pack="
+			echo GIT_PROTOCOL=\$GIT_PROTOCOL >../env.trace
+			git-receive-pack" \
 		origin HEAD:refs/heads/custom-push-test &&
-	test_path_is_file env.trace &&
-	test_grep ! ^GIT_PROTOCOL env.trace
+	echo GIT_PROTOCOL= >expect &&
+	test_cmp expect env.trace
 '
 
 test_expect_success 'fetch with custom path does request v2' '
 	rm -f env.trace &&
 	git -C client fetch \
-		--upload-pack="env >../env.trace; git-upload-pack" \
+		--upload-pack="
+			echo GIT_PROTOCOL=\$GIT_PROTOCOL >../env.trace
+			git-upload-pack" \
 		origin HEAD &&
-	test_grep ^GIT_PROTOCOL=version=2 env.trace
+	echo GIT_PROTOCOL=version=2 >expect &&
+	test_cmp expect env.trace
 '
 
 test_expect_success 'archive with custom path does not request v2' '
 	rm -f env.trace &&
 	git -C client archive \
-		--exec="env >../env.trace; git-upload-archive" \
+		--exec="
+			echo GIT_PROTOCOL=\$GIT_PROTOCOL >../env.trace
+			git-upload-archive" \
 		--remote=origin \
 		HEAD >/dev/null &&
-	test_path_is_file env.trace &&
-	test_grep ! ^GIT_PROTOCOL env.trace
+	echo "GIT_PROTOCOL=" >expect &&
+	test_cmp expect env.trace
 '
 
 test_expect_success 'reject client packfile-uris if not advertised' '
-- 
2.56.0.613.g16c2199927
