Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918131;
	b=KVkwwJAc8mwZwiEhw9DUVxFn0lPY5nJA/u/GfnM7yOa+D7JUJdVnZsrHNUvq1v6Z36LM
	 +I/17K4jWQdc5JRLlSwPlKaAlw9tMYxm21sajwXnACUEz4RyeOtqBKVd9I14FHsKdN8f+
	 alV0nsB3h6SXPOvl83AWe1GLNJp/+MZc7qztzpj7hp6/HCpf9H3mygRT8sQnNf2rFCuxZ
	 nwK0KZsDab/kci4PO2Uc8fvy/T348rWGrM4P7Kel5CxiguNKoG0xLXzMv1uRDt7IBjgY0
	 0cHzVjqmp9V5mBhbHHxjfnw+x35vKVRo3+VN+3xDxMVHzwguj8WsTiwSva7/nJ+txbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=rC9BbVpEcPxmUYJ/AzgYmPVa6ALH99Gq+D/3SDB+5dI=;
	b=xvjVUBDy2C8ID5mR53YCRmz8KK1m+2O94UwypuRixMKcvZ7NknP3HgSbX9fmup9p2Hz4
	 z5YswoXS4QsnclIzDYWoDYnWTh8ijdRZegbj4Wdfje69C3Ks9Kj9hGBdGPHli3dvRbCSn
	 tPnik5z/7v4LWE0oA8BdLycd01UXKTjrzeH9lCnw/NTJaFi95p07QnQEACru69daG3T/N
	 J3DdNGGd0fhqXhbwwBPJKDmOaRWUWRcmwaFNAZtMCUtcePe+mvtlCXYZMreeoIRR/bHmN
	 e5RBfeZ2UzE1ETe/z+zuqd4MeIMVn8d1cjQecfaJ+OjEfl32gK6bq3vTU5M1UUm2xwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NW50Hx/R";
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF5606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 22:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86BF5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NW50Hx/R
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b561b60b78so1704198a12.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 14:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793918130; x=1794522930; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rC9BbVpEcPxmUYJ/AzgYmPVa6ALH99Gq+D/3SDB+5dI=;
        b=NW50Hx/R0dGdQPgDCk9sD54HPaqlNLim3spk3bgSg8lPZI1MHMBkVNSwbq2Ot8JHZl
         0hX/xwAKJ8YHxOgoepj6TWJYEn9btBipofFuk1/B7ccFm0MJYn9uQzNqYqoS+axGyhBr
         1n5sNoV4JwBNUFeTbsVNtQhdX5SVvq3Qo97I8ZlzLzMpHQTv6PROZ1IGkkBIcpi+aq9M
         BbkbiFUql1I5l3+Yp5c/DpmImZULiR0RpAV/dmvntTVgXPfMXbiychHSej8/AuRWqZFP
         qKD3khjUp9b6XDcoiqhpifxZhJ5M4KOaf7AKBPwAhk3Nis/1gHcQqrm4pal+dJb4m27E
         PyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793918130; x=1794522930;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rC9BbVpEcPxmUYJ/AzgYmPVa6ALH99Gq+D/3SDB+5dI=;
        b=t8IoORCL4xvq8r6dkKqK/3i4GjyHRPng2df8MAIYH2n3OYOtTZbHqNcoLhOd45J9B8
         leFWiy2jldqeNhUeF37gRnWTD68TTYpownLjsZkJ4WLW4RcnnzxjbADtxVB8l0ca9frS
         xxD8Auo/kp8SJw9NWxNPR40SotW+XPI8pFfk9V1waxPSQ0iYA3zGq0cK3/vC6mTV2/nL
         GblWSPBiwSLaOKz96vclWmlUoF6Shs7CSLoconrcIACeOayGCEl4RutNh9RDfcY1z4qC
         nLa/Rj4GvGJfozdwNZB7ySg/jRbzhW70lOOZbYkP5PHrugXqjsMQ+jqAHrzDoF+moJOD
         6D1A==
X-Gm-Message-State: APuU4Z/S6QMYjv0jUrWJkqaOQxyAJDzXyYNb5C9i9qrBOFptIrq9BNvF
	o2Wik4BXxlRDkrc31PjmUMYFQqHzJ5atVS4Lq1RV7g6i9ucBjxEJExJP9J0LjcxI
X-Gm-Gg: AYBFou3I1q2M2gGYZX6vohmhtdKPP4zbYcyf+30pM3FBmH1TfS+nSPhCezfO741Y9RD
	T8qfc/xwYD4E+prpP+XL81NEj4ST8Y6zqI2hIcXEDOJMxkIYGC9g7yuLa9Mupl/w+brhyAl/ftN
	/Z17TZiyKng1G90V4XRLkdCDgkZ1GhByspoGwRfNtjgrSXX7NHcixu0IxykDUULWj2Fa7ebgvW2
	O+g8grm+pLCjZa3aNryy3M6f9RWlcmC+6Kh+J+fN2HFSfazE3akqQw3iHQo3B2xEGNMMu/pbx0k
	Suj4ja3lGdkZHMuWQLRyYQAM3dTmFjHkzHNIa3x03OBtLQUuWP3ofgJU07xx44SNuIyns2roe2x
	D83J7H7dBcYaQDjKEtTXG3CiY+E5UtcYheXLkHR3NL0kyGcGkL8/kPh3nRrE4vQxi0vBGhvPNxW
	zL+eP1RLopzlZDXKoaRDH12EGsRxQA2OB7pLOc/Lw6GY7tPGZUhbT2L21MlAca5Igk6mMBmCqzS
	xg1/DmGSO9bcS5q86pK2MkLKygP9d4jx5BnWJK8jd/hXhPlyaTYX6GZomo920l6Fqb0obEzhHkT
	TlEZvROgG6dsdEqKqQy0lg12bsF0Xemd8xJ7QfnaJVGJDNjtqgHVRA11fUciHyiyA/eIO2+lDmT
	/uWN2NKr8ngoqDWHzDtvmuGWjXSpvfjA5zYQ=
X-Received: by 2002:a17:907:d40a:b0:c3e:d0ca:d30a with SMTP id a640c23a62f3a-c4d35447db5mr69028166b.4.1793918129633;
        Thu, 05 Nov 2026 14:35:29 -0800 (PST)
Received: from HP ([105.163.158.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3569e638sm23826666b.48.2026.11.05.14.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:35:28 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	herroyalpriestess@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v5 1/3] parse-options: answer --git-completion-helper before command runs
Date: Fri,  6 Nov 2026 01:34:56 +0300
Message-ID: <20261105223458.1534785-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261105003914.708836-1-tangajoris@gmail.com>
References: <20261105003914.708836-1-tangajoris@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fast-import parses its options only after reading the "feature"
lines from its input, and it creates a temporary pack file before
that. So "git fast-import --git-completion-helper" waits for input,
and each run leaves a tmp_pack_* file behind.

bash completion runs the helper with the terminal as input. The next
commit removes the NO_PARSEOPT flag from fast-import, which would make
"git fast-import --<TAB>" freeze without this patch.

show_usage_with_options_if_asked() already answers -h and --help-all
before a command does any work. Teach it to answer the completion
helper too. Then fast-import, and the other commands that call it,
reply without reading input.

Reported-by: René Scharfe <l.s.r@web.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Helped-by: Cynthia Uche <herroyalpriestess@gmail.com>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
Changes since v4:
 - Reworded the comment above show_usage_with_options_if_asked()
   in parse-options.h, as Junio suggested.
 - 2/3 and 3/3 are unchanged.
 
 parse-options.c        |  6 ++++++
 parse-options.h        |  6 ++++++
 t/t9300-fast-import.sh | 16 ++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 283a0f1dc2..f2a23b79a4 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1536,6 +1536,12 @@ void show_usage_with_options_if_asked(int ac, const char **av,
 			usage_with_options_internal(NULL, usagestr, opts,
 						    USAGE_FULL, USAGE_TO_STDOUT);
 			exit(0);
+		} else if (!strcmp(av[1], "--git-completion-helper")) {
+			show_gitcomp(opts, 0);
+			exit(0);
+		} else if (!strcmp(av[1], "--git-completion-helper-all")) {
+			show_gitcomp(opts, 1);
+			exit(0);
 		}
 	}
 }
diff --git a/parse-options.h b/parse-options.h
index f68b51ceca..775a028f10 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -427,6 +427,12 @@ int parse_options(int argc, const char **argv, const char *prefix,
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
 
+/*
+ * Programs that call parse_options() early do not need this function.
+ * If your program has to answer help requests (-h and --help-all) or
+ * the completion helper before parse_options() runs, call this
+ * function to answer them.
+ */
 void show_usage_with_options_if_asked(int ac, const char **av,
 				      const char * const *usage,
 				      const struct option *options);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 73c6e3d448..1305614381 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2914,6 +2914,22 @@ test_expect_success 'R: blob appears only once' '
 	test 1 = $n
 '
 
+test_expect_success 'R: --git-completion-helper does not read from stdin' '
+	find .git/objects/pack -name "tmp_pack_*" >before &&
+	echo garbage | git fast-import --git-completion-helper >out &&
+	test_grep -e "--date-format=" out &&
+	find .git/objects/pack -name "tmp_pack_*" >after &&
+	test_cmp before after
+'
+
+test_expect_success 'R: --git-completion-helper-all does not read from stdin' '
+	find .git/objects/pack -name "tmp_pack_*" >before &&
+	echo garbage | git fast-import --git-completion-helper-all >all &&
+	test_grep -e "--allow-unsafe-features" all &&
+	find .git/objects/pack -name "tmp_pack_*" >after &&
+	test_cmp before after
+'
+
 ###
 ### series S (mark and path parsing)
 ###
-- 
2.43.0

