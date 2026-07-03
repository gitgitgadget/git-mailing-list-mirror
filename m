Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65593264F1
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054485; cv=none; b=AoVF9MhKVSirjDp/X2nG4DfgDZh1By1IcK5ZqGOxMS0HGa5kxeG8+BDLglT7M1rh6x46iD4lLjitzeawh3MVHHy/eNKbLsnwaiYHxfcYO+GwBnRR+k/VAG0jgpfevxlmAUDQ+bR6CZE0Bq3uKqjphTEhQPIwjcgMyaTZRVVciLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054485; c=relaxed/simple;
	bh=cXHzFO7+qBiNqSwUz2TAOi8M53fD1AnlMLnx4ZQUTgg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Iueh4JZrbpehyXlKzEt3VNuCVmrfdm838ddRfoA/HpauLjUMfmDecuSWoRVN2vbQ3CfQqk+SnQJd0qENLsdi1mTn6IdK5m+hzY6SH+isac0wMWb8e2bTxgByaCP+YrIhd33i9SGaDSyevuUreFpgo63G0amSxZbgwjhz4BItxzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiEu9wao; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiEu9wao"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c05dcdf49so2052961cf.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 21:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783054475; x=1783659275; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILkaG14RkoqFOxawttGG22ALaxpi2/ynXVrtqLVSKak=;
        b=kiEu9waoW3y1qEW80exJnB89c65IcUKjwxXbXSRrdfMwXuuL4CMzSteLgrKIF769Rf
         kQFLkB3zHZAdBevRd9eKf15VPy4wOV5hjlLPo2ppyxSE0cLQLWxyIlQ/JdMtwM6J7d16
         hIYWObG2Jb3L7z1r1PeQxVXl77Ttxkfz8n7TUY0nqhxk+nqnvNGv80jPWmCDJAJuDckz
         OHEX1GwdhLHbjaR8YL+V+x1Ha4Y1u6te36a3ArqailFSlQbPmNP9pfl+2vMZbOhGZNYa
         wK0yOexuPGGXAsUqGrr8ccWJ3sP4AC/EbR1g3RFif1HoxOMJX7LrICF2d7AdiXC2yNYd
         BAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783054475; x=1783659275;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ILkaG14RkoqFOxawttGG22ALaxpi2/ynXVrtqLVSKak=;
        b=CKTNsHF5tegMYzjvGfY/K7ATt0G2DkEpMK5GITV7SO9xT2uDsKF5s6GwM8OQIfpgUN
         K5Gkz/Jh3cYDPiU0tcvNzBbhX9nz//k+tufl585UtV33C9UNX0s28oG2MjnYIVrbkSn6
         /UgJWwHkjQIOatX42jJwKYjFlHj0gBssMSgtQWgu/AMpmtU6w7ojCWJnknpGVYDPcT00
         hnE9rykFbvXmm2VFDLCZf8YPKUH1R/TlfoKDCsJmeWyNt1XMSpK13b8nlVwfMkUm0mDk
         Jlc5zUX9gnBJ7a8QGMBTelos1erZ6PW872j0JBThKwkyIdxMeL+9iUAtK+PXi348ZB1U
         1Fhw==
X-Gm-Message-State: AOJu0YwuhhIuH8v6NRefIanqn8WxZZKT0HoIBR35Il1Qb56n556F+UG7
	4GVo0nSW2FhmohxynC1fBhVbOOSrzWhbfA5IJVC+CfgeF41icppe7Ref9xhvuw==
X-Gm-Gg: AfdE7clyYBc/PAN4QOGuwy3DCmdB5wNO295mgkfccLwSQ6PEKU9u/WhcmpMG95x0wbb
	bT4ewF5IWE58kc83lujMMY8Xy6ue8Ik18w+I3kz9IzAo35QvEYTsb1X8ZAW5b0eM7ISRyiwLdsh
	oLIT6TByVTrJRGy6LhfuVHHgZTlGLt7H7hSAM8xTfPAiOyovLvzi/IdH+8hMXPcFipSwCZuD4A9
	Q5A9fE6fvr/6VIV/iipAs0Sgu5TAdeIJvUlI+3UVHw2dywPmeh9xea7d7z+PPptcxH92SqnCwb+
	af37GgYg2Pr6lVzgoFik1ucK0/Rj0UdWlZ8IgownCoW+5IekeBi4PmFuP7pylPuRZHZ6JavYYwD
	ZFjMnL1Gkrwrk1OQlzHkOdeB5sAxVq+08EQm/Z6RVhQJg5bkMyW75eaiywjF65Jj2kanXBQzZoO
	i7s3haht3AHVyLb0vw5+ZDumwk1w==
X-Received: by 2002:a05:622a:1829:b0:517:8d24:64d8 with SMTP id d75a77b69052e-51c26a3e326mr116967591cf.13.1783054475346;
        Thu, 02 Jul 2026 21:54:35 -0700 (PDT)
Received: from [127.0.0.1] ([48.217.251.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2cde7sm7460651cf.18.2026.07.02.21.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 21:54:34 -0700 (PDT)
Message-Id: <416c95fee5994b03364b853845e2efe87f4efb54.1783054466.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
References: <pull.2135.v2.git.1781323575.gitgitgadget@gmail.com>
	<pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 03 Jul 2026 04:54:23 +0000
Subject: [PATCH v3 4/6] t: fix Lexer line count for $() inside double-quoted
 strings
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

scan_dqstring's post-loop newline counter re-counts newlines that
were already counted during recursive parsing of $() bodies.  This
happens because scan_dollar returns text containing newlines (from
multi-line command substitutions), and the catch-all counter at the
end of scan_dqstring counts all of them again.

Fix this by counting newlines inline as non-special characters are
consumed, and removing the post-loop catch-all.  Each newline is
now counted exactly once: literal newlines at the inline match,
line splices at the backslash handler, and $() newlines by
scan_token during the recursive parse.

This is a latent bug: any consumer that relies on token line
numbers rather than byte offsets would get incorrect results for
tokens following a multi-line $() inside a double-quoted string.
chainlint is not affected because it annotates the original body
text using byte offsets, not token line numbers.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 t/lib-shell-parser.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/lib-shell-parser.pl b/t/lib-shell-parser.pl
index 5c435c5d05..17fbf461b1 100644
--- a/t/lib-shell-parser.pl
+++ b/t/lib-shell-parser.pl
@@ -93,8 +93,12 @@ sub scan_dqstring {
 	my $b = $self->{buff};
 	my $s = '"';
 	while (1) {
-		# slurp up non-special characters
-		$s .= $1 if $$b =~ /\G([^"\$\\]+)/gc;
+		# Slurp non-special characters; count newlines here because
+		# newlines inside $() are already counted by the recursive parse.
+		if ($$b =~ /\G([^"\$\\]+)/gc) {
+			$s .= $1;
+			$self->{lineno} += $1 =~ tr/\n//;
+		}
 		# handle special characters
 		last unless $$b =~ /\G(.)/sgc;
 		my $c = $1;
@@ -111,7 +115,6 @@ sub scan_dqstring {
 		}
 		die("internal error scanning dq-string '$c'\n");
 	}
-	$self->{lineno} += () = $s =~ /\n/sg;
 	return $s;
 }
 
-- 
gitgitgadget

