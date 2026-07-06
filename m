Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A5A171CD
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 05:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783314130; cv=none; b=aYylgzkQczXyg1Gr1wULfV7s/htUJ3XhuiC2+1tvV0HZZxjgQbnDkXjCEqcCXA0KgKxvirl3dMy5ngHt68lSnxJvdLco6r3G3qf1alcWLJ/jrEi6ZyfBeMl86a+M/NCKgplMZg9grWTg7RN2WdNYJtG9DUyBzPKWsAxhj6c3ZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783314130; c=relaxed/simple;
	bh=cXHzFO7+qBiNqSwUz2TAOi8M53fD1AnlMLnx4ZQUTgg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mfToBqF+qdhYZuhRV4Tk+OWk7hNlbzbbcwjv59dGF5djhg6bT2cVYcuxMvP8yXUqKUFx4s6Ts+yS1yNf6+JJ4LqAbDBxI9NYYDLyT3ByGWr2VGZvF9RPxHegi2QAOdW3WPm501TUO6UVzwSE3lL4Nqwx9B2fnnEBYDt4vET1FEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMgZYF8H; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMgZYF8H"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c21495722so13315831cf.3
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 22:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783314128; x=1783918928; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILkaG14RkoqFOxawttGG22ALaxpi2/ynXVrtqLVSKak=;
        b=DMgZYF8HnKSSLw8LXIe6ry70yMWsX1lMEdXfbxH5R2NDCu0iNoE18HuGrL/W9eHo2W
         4ZFtYbSOJfcFEueuAK8qCiPeK0mJdRiO6OQMB2R9cAbvuuVrciBnlcAgAyrgLcjzAnnp
         cdsY0JuSnxeudxeEHOmcsjiCl+ERCPCX89YUsZMimu0xFSuL78+phvhhhZNFrRhxfau1
         /JBe6S0TwEyZOSX/v5S3Bo+564+MK37QCew4Dkau74TTZkUI2YVWTSgF8WLbVkrCutTU
         5rUWRZOtsncJCy0pP65Lh1+/fQLr0oATnTeo0tD5mxyB2YaoXHdydLdcKgvHrTRp1Tl4
         wMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783314128; x=1783918928;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ILkaG14RkoqFOxawttGG22ALaxpi2/ynXVrtqLVSKak=;
        b=rdGV2a5Qdt4J0ZqXaz2IeylU1kMpMTaBkk1i8bDr+4oMQzCiJDxXhIqPXtjf23zfW2
         gYDD9dGsxd5S1BNto1Gdyt1ebgw3YIN4Z5Q8CFkzQjwea6dVUc3c4fgcROaPhV2roZru
         PsdCk80HmleRTL9jTpwIAQHNSI/6/HQBw+xcMBc2U+zb/AlS1Cxw/Fnpx4Bq6Er4WSLu
         //AZGx0jkNgdJinz3v7B/hjBm20u/QDo36QP+BCrUnOpexz+KqYFldbbhxuvI8esujT4
         b3tYdzvNAvY2Cofx0o5gn1REvR7CV8xKhUdCx7E1UNmt68tB65n+0Bv2Q6QirW6sdxip
         JikA==
X-Gm-Message-State: AOJu0YxlTL3SVJsiAQRVYcduk+uomEjJdIemh713r6kOVoYP+J4aw5zk
	7dARjmHZf3pHXGNF9lm+stz+w4sPeE4rbKd/4hv+wIObpmtSYqPIuuEyIfHzwgaM
X-Gm-Gg: AfdE7ckIGV9pkCal+7T9q9/HmfzyOojO8V1rvHRffpmSnTyQ11LayoBoHcRTj7EBnxE
	z+5mH6/Jsw6cwmL6h2eYnzYv+/4fCNKnZEgHdRb7UQbZ9mU6JyZ1w6cMYoOUJp6riT6UjVCLAcQ
	bP50MEK9OFsP5e1GUiUcVh0vbiznqa+BsSAvcQRtyQqRAZwTIVbPwZQoi3eQt5Xb7B7rp+rTRE8
	rSAjYNKe9fZ92FLkFjFlqiYVBuA2nlXqXMQ6OJb/qufG1RrJFmKDeYm74tRRnrBP6lEqyl3FWBn
	iMHglzHFwyOu/3t2JaXc7+EiqubZMRKlv/PEWUXRKIbjBkgBIlBB8gUFHbJZb+ioILidJwyAfRl
	/SXP576HcAhPlXgMly0cdaZ6WC//EC3cBxHb+DJ5BckJhUp6uD6T93qOu39htlNZjOiuEz59nM7
	21t6WFYANsyvjWZXMceKD0f1wx
X-Received: by 2002:a05:622a:58d:b0:51a:8c9c:7f51 with SMTP id d75a77b69052e-51c4c352237mr128961441cf.68.1783314128322;
        Sun, 05 Jul 2026 22:02:08 -0700 (PDT)
Received: from [127.0.0.1] ([68.154.38.16])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b266c0sm81226821cf.8.2026.07.05.22.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 22:02:07 -0700 (PDT)
Message-Id: <5689d2074ad81d39502838029831f559365ca776.1783314119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2135.v4.git.1783314119.gitgitgadget@gmail.com>
References: <pull.2135.v3.git.1783054466.gitgitgadget@gmail.com>
	<pull.2135.v4.git.1783314119.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 06 Jul 2026 05:01:56 +0000
Subject: [PATCH v4 4/6] t: fix Lexer line count for $() inside double-quoted
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

