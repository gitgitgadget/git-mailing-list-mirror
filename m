Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A125813B580
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878333; cv=none; b=P/ilPsImsPCVUdGv4gbPpRVOenz0TVc96sI1XVg3FXPgbMS2r7v8+M7x5iz4a+eIpiAIut64nsfNQH6FKX4z07cG4gt5iEgF2VZicjectbmW+xc95o4jbA91UxY3oQAaYpqN4rN5XjznVClUQ+Iyy2raO6ZtZzVN2/PdmmDtDK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878333; c=relaxed/simple;
	bh=fQaACFgFIxG/vOBFIv1xPM7jvvVSGUqWNMyg4xBUvBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0BRfPpYcOFROlAVAJVL/pmsMUPyCQCiahssIHPZIUdm1r2kfBuockN/qKpfMCHmEATID2Hg5vSjIlFg0KiwhSMDqb72X5JgMMXQVnyZru8gmyKYR4ksoVsreDhyZrIqr8vVWthJ7cPUArKe30257iKeEPORxULINDTVqivI0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnjpkZv6; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnjpkZv6"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-367e50f71bbso1934572f8f.2
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720878330; x=1721483130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1ObvvIMf0jTtjQcMpTJUCl7VMwv/7rhGqluTGyL/Sk=;
        b=NnjpkZv67ICdYkcdLdJBrJFgidKK0nPMoN8ceEyjOgPo8tOqBovezhhX2zmODs4o0w
         dRByJfXT5msBp/1txNY6no2cwOWE8XkDs/I6FwMO7P4VWXs1nCkhcxFyVLJ25kh/bOhq
         hV3Icw3LBVUCaoPj6L/1YbvB69bKGGZIi0WTSBdyhRhd15autZuDg92JZZLkFLPMIZuu
         a9EfKcX8eK/CSjzebM+/ztN7Pcwy/wml3ykEPsjUxjkYjfSu7bYjQYZKZuSQF9E+J4B8
         sj0iuV3OH1ufgmuHDhpa1K8kIrXppMcJzT/Lub83fjm9BIdFa3BKfyBdSxhFRZSPDDeK
         SJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720878330; x=1721483130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1ObvvIMf0jTtjQcMpTJUCl7VMwv/7rhGqluTGyL/Sk=;
        b=gntxZtsQ4/lpEevybqxHwzLiBvgh0ZE6gWfAv0qTn8dz2LwiEVXiVmFY6/ZNtJvsmb
         YfB5VxAJpZua812urdeh/GQZ6b1ZOeJWNUuD7jNep6iZcXvFmYAUENT86py3mJ+B0oS6
         zewjqHG4yyypEuGWoCxr+yx0eoncu+jCS7gm6qLwtqDob9KX3k70aGxtwuTK/hzURzx0
         6Y1MRbczfema7IkTi5xdpe6pu+wdJcNwWKlCKMYCgHxZwiLuipVUkG6FR/EQ2N07YI43
         S6U6Utl3zw1f8DTzM9RWxWOA1nbPFc9sfoIz4XiBtnsPlG2Kqo+pRZQdX6aLPxRxXQ4i
         g6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWe7bF72egV9OOpUYVHrodU12lVswuBzfVd+EeSbdIABCFkrLn1vrRDE/kz4eqJOq8q5VC7u/DcyvDsEHV/1vyHaOps
X-Gm-Message-State: AOJu0YyqAdPTgwTMd8Aelbts6V1b+g1Th2uWpxh8xzri5EIpye51uWgE
	2nXhru66vH8V0MeLux4rxlxcSs81HUdviN0LDfvokokIqR3F/NWo
X-Google-Smtp-Source: AGHT+IEUV0tLC4q+48FPmYdEkWTbkMNYPvbw/4Pk52VCp9oY5ghaMEf/xhPQBf1ZnsOL3qziUEp2/g==
X-Received: by 2002:a5d:480c:0:b0:364:6c08:b9b2 with SMTP id ffacd0b85a97d-367cead1d1amr8320462f8f.45.1720878329839;
        Sat, 13 Jul 2024 06:45:29 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:cb20:918b:a998:e5da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3bd8sm1440325f8f.13.2024.07.13.06.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 06:45:29 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: chriscool@tuxfamily.org,
	git@vger.kernel.org,
	jltobler@gmail.com,
	phillip.wood123@gmail.com
Subject: [PATCH v3 8/8] ci/style-check: add `RemoveBracesLLVM` to '.clang-format'
Date: Sat, 13 Jul 2024 15:45:18 +0200
Message-ID: <20240713134518.773053-9-karthik.188@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240713134518.773053-1-karthik.188@gmail.com>
References: <20240711083043.1732288-1-karthik.188@gmail.com>
 <20240713134518.773053-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For 'clang-format' setting  'RemoveBracesLLVM' to 'true', adds a check
to ensure we avoid curly braces for single-statement bodies in
conditional blocks.

However, the option does come with two warnings [1]:

    This option will be renamed and expanded to support other styles.

and

    Setting this option to true could lead to incorrect code formatting
    due to clang-format’s lack of complete semantic information. As
    such, extra care should be taken to review code changes made by
    this option.

The latter seems to be of concern. While we want to experiment with the
rule, adding it to the in-tree '.clang-format' could affect end-users.
Let's only add it to the CI jobs for now. With time, we can evaluate
its efficacy and decide if we want to add it to '.clang-format' or
retract it entirely.

[1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 ci/run-style-check.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ci/run-style-check.sh b/ci/run-style-check.sh
index 76dd37d22b..1dce50a0ac 100755
--- a/ci/run-style-check.sh
+++ b/ci/run-style-check.sh
@@ -5,4 +5,17 @@
 
 baseCommit=$1
 
+# Remove optional braces of control statements (if, else, for, and while)
+# according to the LLVM coding style. This avoids braces on simple
+# single-statement bodies of statements but keeps braces if one side of
+# if/else if/.../else cascade has multi-statement body.
+#
+# As this rule comes with a warning [1], we want to experiment with it
+# before adding it in-tree. since the CI job for the style check is allowed
+# to fail, appending the rule here allows us to validate its efficacy.
+# While also ensuring that end-users are not affected directly.
+#
+# [1]: https://clang.llvm.org/docs/ClangFormatStyleOptions.html#removebracesllvm
+echo "RemoveBracesLLVM: true" >> .clang-format
+
 git clang-format --style file --diff --extensions c,h "$baseCommit"
-- 
2.45.2

