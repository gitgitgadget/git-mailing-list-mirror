Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6132B11D
	for <git@vger.kernel.org>; Thu, 28 May 2026 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996109; cv=none; b=G7EbGuziPTD14GNRpBRlhHzf3R5/Z7PxpThG5jhWj+dvVwWuIX99eXalgGXn3LLlbkO928b2Vcooln9IMl3hG71eAYK3PSNX3OFhBLbFSS4IudRAX2jJuY4ZyDahSndAsG4e/zLDeJcjYMqA/TY2vbhvL+RxAPW5eOmdGHLzS5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996109; c=relaxed/simple;
	bh=pwsprhFsEIDlakVXSaHrSxLvPw1zy1qsqlfu3kn2+I4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ERrd9sJWIdUdzIJQrNcht40U5T81uOZahy9UWMVo8gpe/rfzCgn0nT62ejBgp5cqAZEuIUK2PhtIVQOh3wyWiD5mB8iwiTDroM6fYmDFErUhCw9fjVhSV4KAaU/y9BZuegpPbEUMbGQy0TarpEElucer0/gGFHboZyFoN2FkQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pahj7VSZ; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pahj7VSZ"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-132830d8281so111350c88.1
        for <git@vger.kernel.org>; Thu, 28 May 2026 12:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779996108; x=1780600908; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Adi7TlI5CP7Ret78xXrWgTuOUlTsc1Z3boN/GhiygME=;
        b=Pahj7VSZfB8OoYjQYmusu/TYmA1939IMG/gf2dj6LazMCPD4Ci45Q8qPAih6T7Fvdx
         jXXcpNAbT9xCtJzwV538MPazLNcJvGbf60xxBNKa8QWMyadWYscALLQ1cadXiuzTI1uW
         +qTQBV0EMGfj5tduqnY9QQa6fU/fmKokevd/KmOfbrbE3x/QoMTM9309oy0E/1rqb6AH
         9zD1EGAA2w/35K4PhBjCs0du2cdV8ecTO53txxJnMdBmnHB+Moy5xobpfghoV5UGaxAu
         RzV/7L/4qcxZ7Je/D3+cLHN6vLXX+xOQnBX9B8i+QhMdvvm45R8Ut9tgisWBKabJo/dC
         pZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779996108; x=1780600908;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Adi7TlI5CP7Ret78xXrWgTuOUlTsc1Z3boN/GhiygME=;
        b=CdzNT6PKUlmtm9HZXehZ1TrJRlshDNCQApa9ChCdU1gkznKQ72r1UYv3Azj7yJ2T+8
         3+XWLTuMMxz0wQkYNT0uufuvoAU2oIJNs6lsvyiaaLxNzElYdFQgQxLBdGE10kwWZtsz
         CNp8uGJoIl9HTBU0gS/tUUUpQvTE5pao6FCfPPOH2oTtu6sczH16iSF8S8xK9dPGekDU
         YedvY0/zTA/AM61miTcMYRD+/LfBV5z5B6walWPq/PEjxWI1bo77eHOBjc1NrjhZnsLf
         tblfFC0buwOfa4/C69OQSgzpHG4pvvULRv0iGvZSG2nyjWjxvmFulxfzHnzruSmB5AhP
         OMNA==
X-Gm-Message-State: AOJu0YxLbYwd4I21s1dRmI2sh9iatZUl6kNVGyfPx15UKTQOtWEEvxxx
	/XaSY/diH3VBmlBMklcfMRmok9KJukowD/M2W5pPRi6tgna6WBVeT+++i877tQ==
X-Gm-Gg: Acq92OEaL3zt84BTsn+3CxJNtZk7zIIBJ6hW8HuDqKG4fDMkQwa6LVZB+dtTj/oHQhf
	6YNHWDDLfVlRSpY4d15cH7OmTYOfZgW5OBt2t7M83nxIDFpz5BhNQeerirC6DH6NhO1AKg7B1uu
	G8WvD4eOOI0TOTBUwbJi61MTX9ytlMcr6CPj7BZf1y2sLpnGOS81ACDASlz4ncmxCmHs6doJAJR
	FlmgvQVCMqpBwnPhFMql/EF3pEXBOSUxOMsQcnSKyRzOWImyVFt3LZB7O33lX0fPqqOq1H0SFl3
	HJsThrZs8x0zZDjtpt811fpdH64G1ALjHZ79yyGwxypy1ef7Emz5+Kn4+2UevyU/vN1iOxaPUtE
	Zvx8aRSQlURV8+QSCZU4EQQwk4a+rn+tYl38eAQFMcFW+pW39bl4EsU+j5DEAUaPiuIp82zlEgj
	n0SZqAviJH+rQgybILJ5XUqMcXFpoartygZQyOsfA=
X-Received: by 2002:a05:7022:213:b0:137:9ee5:2087 with SMTP id a92af1059eb24-137a9046080mr133763c88.31.1779996107522;
        Thu, 28 May 2026 12:21:47 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.195.228])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137a9ac8405sm90952c88.12.2026.05.28.12.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 12:21:46 -0700 (PDT)
Message-Id: <pull.2113.v2.git.1779996106005.gitgitgadget@gmail.com>
In-Reply-To: <pull.2113.git.1778686956622.gitgitgadget@gmail.com>
References: <pull.2113.git.1778686956622.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 19:21:45 +0000
Subject: [PATCH v2] doc: clarify that --word-diff operates on line-level hunks
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The --word-diff documentation describes the output modes and
word-regex mechanics but does not explain that word-diff operates
within the hunks produced by the line-level diff rather than
performing an independent word-stream comparison.  This can
surprise users when the line-level alignment causes word-level
changes to appear even though the words in both files are
identical.

Add an implementation note explaining the two-stage relationship
and that the output may change if Git acquires a different
implementation in the future.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
    doc: clarify that --word-diff operates on line-level hunks
    
    CC: Vincent Lefevre vincent@vinc17.net, Johannes Sixt j6t@kdbg.org

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2113%2Fmmontalbo%2Fmm%2Fdoc-word-diff-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2113/mmontalbo/mm/doc-word-diff-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2113

Range-diff vs v1:

 1:  73f7b06c06 ! 1:  bc5ca5a147 doc: clarify that --word-diff operates on line-level hunks
     @@ Commit message
          changes to appear even though the words in both files are
          identical.
      
     -    Add a short note explaining the two-stage relationship.
     +    Add an implementation note explaining the two-stage relationship
     +    and that the output may change if Git acquires a different
     +    implementation in the future.
      
          Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
      
     @@ Documentation/diff-options.adoc: endif::git-diff[]
       Note that despite the name of the first mode, color is used to
       highlight the changed parts in all modes if enabled.
      ++
     -+Word diff works by finding word-level changes within each hunk of
     -+the line-level diff.  The line-level alignment determines which
     -+changed lines are compared to each other, which can affect the
     -+word-level output.
     ++The `--word-diff` option operates by taking the same line-by-line
     ++diff that is produced without the option and computing
     ++word-by-word changes within each hunk.  This may produce a
     ++larger diff than a dedicated word-diff tool would.  If Git
     ++acquires a different implementation in the future, the output
     ++may change.  Note that this is similar to the `--diff-algorithm`
     ++option, which may also change the output.
       
       `--word-diff-regex=<regex>`::
       	Use _<regex>_ to decide what a word is, instead of considering


 Documentation/diff-options.adoc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/diff-options.adoc b/Documentation/diff-options.adoc
index 8a63b5e164..c8242e2462 100644
--- a/Documentation/diff-options.adoc
+++ b/Documentation/diff-options.adoc
@@ -457,6 +457,14 @@ endif::git-diff[]
 +
 Note that despite the name of the first mode, color is used to
 highlight the changed parts in all modes if enabled.
++
+The `--word-diff` option operates by taking the same line-by-line
+diff that is produced without the option and computing
+word-by-word changes within each hunk.  This may produce a
+larger diff than a dedicated word-diff tool would.  If Git
+acquires a different implementation in the future, the output
+may change.  Note that this is similar to the `--diff-algorithm`
+option, which may also change the output.
 
 `--word-diff-regex=<regex>`::
 	Use _<regex>_ to decide what a word is, instead of considering

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
