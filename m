Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080903AE193
	for <git@vger.kernel.org>; Thu, 14 May 2026 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762502; cv=none; b=cOZE/XzbEz2WvnYhuzorOsqWNbwSCEhVzIcIQ+QsI86i350aBY9F5xw1MGHpHibiZcp8Lc6ajDkiPA4BnTtZUrCZk3vAbk5LFcI3Gak0FTwHirA8h0VePukKZtMhnj86y497BOMKZ2UzuAxB1L+CbVXUBj0hIFjN6ztUNVGJKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762502; c=relaxed/simple;
	bh=4hWhAS4AfA98ZWoWlHmoe/Vgz3puTTxhoiJaEfS98so=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HUurw0FAqDNJXMDe8U+2A7EBrOunraRJyE6nyHiTrmnOUIXEgLYLnD25y9TPW3wjfp8kS0gOZXHQUGu0qtykmZaD0wGrf/hinaSIDQ0RN+a0+8dKjf1oLpyv6TJJ67tR5G2FdIuT7Y1ZSvDipMIogliI2f/86z8gQFvaPycMzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n4bFSkL5; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n4bFSkL5"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1334825de43so3503663c88.0
        for <git@vger.kernel.org>; Thu, 14 May 2026 05:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778762499; x=1779367299; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UM/vnQtbBy0n1GvF0m7fg3T7V8DR5AeR0ptKKwKKmbU=;
        b=n4bFSkL53+ZInSCMAp3RRPodx/rdgLGYLLmRzitmPZKBdvYtqtp5UfvRGtOItF39k+
         sqlXMs+IC8xz+ihE6j4tGls3Twzrxru1709th3ORN4quzZxJkQN9sxsrI2j0772P6mXl
         qcZpOR44XHUFO7nni9USRYINw/I1RW7rNxSXyAiH7frN0msazGKsi97z4mjzEs46xjUm
         MNe7CJdXawb0hZ5+5lDHE8ClIe0dYfeViKP88WhViFVsJCFeuDoninLShRUHOxPIPaKH
         8wPx515SD6I/K4a0k0BCRl1aidqej+yqPf1j3dARtPz9QUUTRX2kGmhvkFPXIY3lSTJH
         eXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778762499; x=1779367299;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UM/vnQtbBy0n1GvF0m7fg3T7V8DR5AeR0ptKKwKKmbU=;
        b=BsYYgPYd/bwCYTBnXY271EaE2l3nAPxUvr0rug2lvlz7R9BXYhBcCBKdPzWQM0auT/
         IWazCrhB8DnKcl1ZkEWvdLo7eXobXJJUvv6HkWjVKMiVT6EUF2VJS1YUrriQX6GM19yX
         5y9ZlujEM2aQwE0GyTSWcZJ8vHagE15mWNpasrMp6buaQetcJaYH9qQ9u6kxOZ1VQWCf
         L1ExJj6BJvVPrVeaUJ6z9YSC85b0tbDZ80ChLVN8/WPcqdiyWp2CluE5K2h4fdEnxH+o
         zfpDeaai5TKDfDu83fBJ3DWyT5+ifuW81rg81ClWAnYIXoCdTgMcOwyQcaa97zI5WSJ/
         aupQ==
X-Gm-Message-State: AOJu0YzLN9qJve/59GCCGljpqKkmkQoaeLamfrnW//7od7wwpAdIOjNv
	7KGfqFPZeeWnCyhcbkVLkRY8lr2Xn5vePpR/2qOnhN1/5mlOTlxJmF2ut/sFXxxQ
X-Gm-Gg: Acq92OH3P2nByC+/0xvg1mrtNT0PiU0k+jVKJc4G2xUvmO3BQcxAknDu6pJy55lZfIi
	kSAf2jMvwAASndBXN4Og2Em/RVFGV2Tva74ZO4BgRHc2caid3EK6TsDFwRtn+N4jrDHTMxuQQVE
	/E5PnwT7KU60cqb6Wa4foHeZxuN1+gvetV8wipJwb/e678udYFiNl5Aldd6uPZKzMcIsWGsjc7R
	6pK3OwZ6VV9JSvVWGj4MVAgdSDq40OhQq0yU3/G/ayRBMoL8xKGhPDJQHO8qlJQvcOtyyN2C3/T
	831r9jPBc6VHf3mz5k+wJJYMO4AXOGqL7AKouRRHOkwF1S9FOCp1y3Gum1lvtWdGbak5f94Bvgd
	5Vo04/yd3n3M2mMuuTJbrTSFoNWn1t9oAXl0rB2XIxqan2Y5T+tnbr545hN2ExewZ3j7B/FCheP
	pBC5SckJFB45udIh7D5FdWA66O0w==
X-Received: by 2002:a05:7022:6b8c:b0:12d:b8e5:5d6 with SMTP id a92af1059eb24-1343699ea4amr4244529c88.24.1778762499242;
        Thu, 14 May 2026 05:41:39 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.45.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc2351d9sm4270150c88.9.2026.05.14.05.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:41:38 -0700 (PDT)
Message-Id: <7409a479d67eefed4b8958be83c55f8636233b4f.1778762495.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
References: <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
	<pull.2085.v4.git.1778762495.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 May 2026 12:41:28 +0000
Subject: [PATCH v4 1/8] t5516: fix test order flakiness
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
Cc: gitster@pobox.com,
    ps@pks.im,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The 'fetch follows tags by default' test sorts using 'sort -k 4', but
for-each-ref output only has 3 columns. This relies on sort treating records
with fewer fields as having an empty fourth field, which may produce
unstable results depending on locale. This appears to be an accident added
in 3f763ddf28 (fetch: set remote/HEAD if it does not exist, 2024-11-22).

Use 'sort -k 3' to match the actual number of columns in the output.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 29e2f17608..ac8447f21e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1349,7 +1349,7 @@ test_expect_success 'fetch follows tags by default' '
 		git for-each-ref >tmp1 &&
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/main|p" tmp1 |
 		sed -n "p; s|refs/heads/main$|refs/remotes/origin/HEAD|p"  |
-		sort -k 4 >../expect
+		sort -k 3 >../expect
 	) &&
 	test_when_finished "rm -rf dst" &&
 	git init dst &&
-- 
gitgitgadget

