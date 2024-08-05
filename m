Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9015EFAA
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722877814; cv=none; b=mBxPnxBeI+Wz9K6nICnVQ48v1F6dQhNwLGXbjrqKCf8C61lZMscYWdB3hZkXccJww7If5RPHjinCZNCzGI6+1GBewkuo4D8UYUPQb6Vt3PvJDXp4LviNrEfju0QcALPuVVu63v+zQ5RXQoaNY/25+f/0dWd85CWJ4ph8jdilKiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722877814; c=relaxed/simple;
	bh=cpHQERrBy/e+QlEOrk1xWanbWtQ6/SnI7s2Iub2Ue+Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IrBOKX5DSYs6enO9XMZHKrnEtqjU6BlWkaY06Ib3rqLL5b7eB3wCk5viF/Rvh3Ni9iqskjmuob4jpwwhm3cMpvwnP01Cr0kHuBZl2fbsxRj75zIaStFEFyvcCYNe3jG/SlDzbvjYL2bEZroQ6a41g4VpK4q3da8OUEh49ottBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iAB1GWGC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAB1GWGC"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3685b9c8998so5205724f8f.0
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722877811; x=1723482611; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HQe48C7retWVgU11VG8KpaLIFiEtdB+eb7jfq+1CxM=;
        b=iAB1GWGCzpmO+z+IIPtaMS2H4+vVOeqcMuHX6UZgcZCNrxoJu7KrMtWrT9XxhMuit1
         VadfRxgWKCdwKLs2XM76INxiSOwG1uFggjvr4/nb9dcpBUcynsF3bgmXnXhF0/o1Gi7c
         8PTAGdnT47eAsu+e7UjAOyz+0uLo6sf9chjGNEshk+IqtJ+nfcKHCXAOkli9nHqeU0/J
         Acmn0wVtkko/4MX/BZU9va+d3BCGyPzkO9Y+Qy18oHwnooTuZGOrSjq5EmDG+aGpOr2t
         qol1UQMpMrc4tJ+a9Hdcm/rugYTdGjUiWEFm8uQyOE5DxekHQKAJYWGKkjiRRk4IXisO
         d6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722877811; x=1723482611;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/HQe48C7retWVgU11VG8KpaLIFiEtdB+eb7jfq+1CxM=;
        b=Y+zB1A1hy8pzMtYoaB4e6y1AxC1h7Vnpt2Eg4TKAMq9PEixi6dZ7scsCW4m7W/DaT/
         w2S4/sAcPzDYsrzvv+VwaihnxVfruz5d1YwuaTvQ/3sw7ripFn449C5VCm+dLrhWH69R
         wQKBVVuWylodo26CBF+b6oO5nVzI2ZJx4ZEYMUqcqCeAu2wxROUXpxFgplz3+fdB5Mqv
         NRfV5vbPCaB8HfDUK+KDb1oV5wtmFoW4uCjQGMUcrXlBHqgWNa+fLmGKMFNGOb7+hsFE
         exz05j99DfpUCwS6LDihtJnUlZru7IiV7E7E+u6H+ygzp+JDjFsiveE6U2i0gnTkidtj
         7WPg==
X-Gm-Message-State: AOJu0YwYt5DDdpeHGYPn+zaIrhXkm+6LXBwdG7cvBquXfxO9+/p2cmyA
	EA2GqLvmN3ixpmVpZqfo2rQH2svNYpowA2ngF+gWnam1leO5o5r83DBC1A==
X-Google-Smtp-Source: AGHT+IEVu76mYzZXK5/WoYVuAGbEZDz4HAvS+EmbGVS6EivjVAqYoyJrAdBbuOi8AZ0Pi6N6TvG5VA==
X-Received: by 2002:a05:6000:8:b0:368:747c:5a04 with SMTP id ffacd0b85a97d-36bbc10f6c5mr6599813f8f.25.1722877810716;
        Mon, 05 Aug 2024 10:10:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd0269ffsm10522412f8f.58.2024.08.05.10.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:10:10 -0700 (PDT)
Message-Id: <96984c4a15e3b587cf8d590f5311a1abe1f63e28.1722877808.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1756.v3.git.git.1722877808.gitgitgadget@gmail.com>
References: <pull.1756.v2.git.git.1722632287.gitgitgadget@gmail.com>
	<pull.1756.v3.git.git.1722877808.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 Aug 2024 17:10:08 +0000
Subject: [PATCH v3 2/2] t6421: fix test to work when repo dir contains d0
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kyle Lippincott <spectral@google.com>,
    Kyle Lippincott <spectral@google.com>

From: Kyle Lippincott <spectral@google.com>

The `grep` statement in this test looks for `d0.*<string>`, attempting
to filter to only show lines that had tabular output where the 2nd
column had `d0` and the final column had a substring of
[`git -c `]`fetch.negotiationAlgorithm`. These lines also have
`child_start` in the 4th column, but this isn't part of the condition.

A subsequent line will have `d1` in the 2nd column, `start` in the 4th
column, and `/path/to/git/git -c fetch.negotiationAlgorihm` in the final
column. If `/path/to/git/git` contains the substring `d0`, then this
line is included by `grep` as well as the desired line, leading to an
effective doubling of the number of lines, and test failures.

Tighten the grep expression to require `d0` to be surrounded by spaces,
and to have the `child_start` label.

Signed-off-by: Kyle Lippincott <spectral@google.com>
---
 t/t6421-merge-partial-clone.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t6421-merge-partial-clone.sh b/t/t6421-merge-partial-clone.sh
index 711b709e755..b99f29ef9ba 100755
--- a/t/t6421-merge-partial-clone.sh
+++ b/t/t6421-merge-partial-clone.sh
@@ -230,8 +230,9 @@ test_expect_merge_algorithm failure success 'Objects downloaded for single relev
 		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
 		test_cmp expect actual &&
 
-		# Check the number of fetch commands exec-ed
-		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		# Check the number of fetch commands exec-ed by filtering trace to
+		# child_start events by the top-level program (2nd field == d0)
+		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
 		test_line_count = 2 fetches &&
 
 		git rev-list --objects --all --missing=print |
@@ -318,8 +319,9 @@ test_expect_merge_algorithm failure success 'Objects downloaded when a directory
 		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
 		test_cmp expect actual &&
 
-		# Check the number of fetch commands exec-ed
-		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		# Check the number of fetch commands exec-ed by filtering trace to
+		# child_start events by the top-level program (2nd field == d0)
+		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
 		test_line_count = 1 fetches &&
 
 		git rev-list --objects --all --missing=print |
@@ -422,8 +424,9 @@ test_expect_merge_algorithm failure success 'Objects downloaded with lots of ren
 		grep fetch_count trace.output | cut -d "|" -f 9 | tr -d " ." >actual &&
 		test_cmp expect actual &&
 
-		# Check the number of fetch commands exec-ed
-		grep d0.*fetch.negotiationAlgorithm trace.output >fetches &&
+		# Check the number of fetch commands exec-ed by filtering trace to
+		# child_start events by the top-level program (2nd field == d0)
+		grep " d0 .* child_start .*fetch.negotiationAlgorithm" trace.output >fetches &&
 		test_line_count = 4 fetches &&
 
 		git rev-list --objects --all --missing=print |
-- 
gitgitgadget
