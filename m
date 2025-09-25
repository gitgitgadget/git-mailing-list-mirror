Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E84302758
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758813045; cv=none; b=NYS40cnLPf7XbqMZth3jROI1W2Kt4h8xnXQ/V2TtP25PkHH8HaXLN0rV5z+m1pykELJeS9AqG8tyhlXspvCZgmqbUN3DIoJbcsnJL4EtcnhcYIzWR+D1btHwG7znwfomW/CkbXy5JR7YeEew/mt69YeI+iwXl3eiLgAijO9azAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758813045; c=relaxed/simple;
	bh=qtSQ8E3FxYfTAumEG7YvUd5oq9LkHCa+D6xXZiDHlO0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LL7/VQgBaT8+EIDruoNH9l8rC/FeLufdK3uiqT2XBSFZb2FY3IEe8W9nfvGAiwtg3DRIC1yS/O5IEHuzZahCU1ugniv33tBU+KHFFxjAq/eDSYSqywWPoSJjW+T+V+dNT1uRegTntzDKVinzXVu9TJqdaeh8NFKEBRcX0/FxVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3KJgb1e; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3KJgb1e"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-90a0b3ddebeso16763039f.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758813042; x=1759417842; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwvbXw7yeyduK5FQwcplE2FeWWV8zQHgiDfDuuucg3I=;
        b=D3KJgb1eGXIfVWUfeBzyVzfCUTAo8CMNl3HIu6GUv8Jbb32yAMwkXHnXOQH93xeZTR
         5agcRLiB4oGKHr45WVI3XeT3CTNSAZMwxIZbBe+JvM6YauqmF2N3ye4m+BsImTN3QmmX
         jGo32kppdaH0VVSRN3pX1zQebG6Vev+KXh3SRSY4Oz3yfrRXV1drsmNOIcbWhlCAuTji
         1CNqfh1QP2xXDhV4EP6h5+V92VseDKn6SdFmQtTkAsBeghsgMn/nZbkM2cfhyQGD2x1x
         WZitLcisFYvJfEogEwCe6jWw+7Xz6Roj6gKcfT5SU+cBTEn4I442z5CZVTmAzoj3TI4e
         0RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758813042; x=1759417842;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwvbXw7yeyduK5FQwcplE2FeWWV8zQHgiDfDuuucg3I=;
        b=l6f9yEXjCdKTkiy9koJqX+fwo5+MAqxtPUUFe62S8hVax9jm0WOx3GogPD3HxaohxN
         /eqnzeJ3SGX+Ya64vVanLzTpaDdntTDYsnMSBD51+GBHMLuCCPMDk9N0Cu1m5+CzgD+h
         VL69lkeWwfKQ8yBphQkTOnyFQj6wslifH4Fg8YWv7ipoIeIuqRVtYl+gQCeT2x8Uayt6
         K7ifNGCaW5Yh2VgjTn/I2fenV2yyxk3M5tzBFfdciK62/z7P3gfc4xCl0A6jMTO373x2
         eMcj3sQ2y5JJv1Ew/YBZdKYAl8hEujvmGzt3t3ekcOd7lQebovszHd1FYWQiwLc0/XZZ
         QG2A==
X-Gm-Message-State: AOJu0YyjF1iG5KaI2d94ZFynp4nesci9yWuc0OuSN+OgIxcbWVl+K1br
	L7XEidzljizFbRgD8lLYMeQjI124T9Pj/76Eth4LnIRsShSCatemuXPqNTHag/BR
X-Gm-Gg: ASbGncvJ+L4DqjhuQOOZbTQMWSUBTO5bDUwt6Cgp/RP1Y5pCAqy+tNafWPVMUfgPsui
	5ZP4Q59EH5237IXjfb6DxXvYqV4FcpNLfs8VDqGidPH3VtjH3WyRoKijBV2xmRLOgdI8PuJx4Xi
	cNjjZPKGsJsU0EF8mrrL/IhDCzQlvIuR0F0HTIiH46eJ+cyREzgcGK5V6/Uu99VqGGw8TD1y4x4
	3EvKF9LIW3rAI1sUMlBLjvk5AhBNJnxYSsmXrA07uwA4aHlczL4qr9H9PbNOAnBp8jK5f3/UMkZ
	VJw0qho78Xc8HW0TJ3lH4d2QOCKxln4lz/gbaL6vq3Fcg5B+D/8+/V3pRbeaPNHucWHZDYSUDYj
	wMsz2/AYy/BOAXixbwApYZMhevQ==
X-Google-Smtp-Source: AGHT+IFGUVdvwDGbmb6j963QNuXk+i9CShb0Mg1w9AyEFken/wJswCTQeS46lfskQbCjv4lKOgJpEA==
X-Received: by 2002:a05:6e02:12cf:b0:424:9926:a97b with SMTP id e9e14a558f8ab-42595654326mr56534955ab.25.1758813041747;
        Thu, 25 Sep 2025 08:10:41 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.124.180])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-425bfc9ac86sm10826965ab.29.2025.09.25.08.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:10:40 -0700 (PDT)
Message-Id: <4935dde39933744ecd957d84d3b71287fc274074.1758813038.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1863.v3.git.1758813038.gitgitgadget@gmail.com>
References: <pull.1863.v2.git.1757950144.gitgitgadget@gmail.com>
	<pull.1863.v3.git.1758813038.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Sep 2025 15:10:37 +0000
Subject: [PATCH v3 1/2] add -p: mark split hunks as undecided
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When a hunk is split, each of the new hunks inherits whether it is
selected or not from the original hunk. If a selected hunk is split
all of the new hunks are marked as "selected" and the user is only
prompted with the first of the split hunks. The user is not asked
whether or not they wish to select the rest of the new hunks. This
means that if they wish to deselect any of the new hunks apart from
the first one they have to navigate back to the hunk they want to
deselect before they can deselect it. This is unfortunate as the user
is presumably splitting the original hunk because they only want to
select some sub-set of it.

Instead mark all the new hunks as "undecided" so that the user is
prompted whether they wish to select each one in turn. In the case
where the user only wants to change the selection of the first of
the split hunks they will now have to do more work re-selecting the
remaining split hunks. However, changing the selection of any of the
other newly created hunks is now much simpler as the user no-longer has
to navigate back to them in order to change their selected state.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 add-patch.c                |  3 ++-
 t/t3701-add-interactive.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 302e6ba7d9..61f42de9ea 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -956,6 +956,7 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
 			* sizeof(*hunk));
 	hunk = file_diff->hunk + hunk_index;
 	hunk->splittable_into = 1;
+	hunk->use = UNDECIDED_HUNK;
 	memset(hunk + 1, 0, (splittable_into - 1) * sizeof(*hunk));
 
 	header = &hunk->header;
@@ -1057,7 +1058,7 @@ next_hunk_line:
 
 		hunk++;
 		hunk->splittable_into = 1;
-		hunk->use = hunk[-1].use;
+		hunk->use = UNDECIDED_HUNK;
 		header = &hunk->header;
 
 		header->old_count = header->new_count = context_line_count;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 04d2a19835..a6829fd085 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1301,4 +1301,14 @@ do
 	'
 done
 
+test_expect_success 'splitting previous hunk marks split hunks as undecided' '
+	test_write_lines a " " b c d e f g h i j k >file &&
+	git add file &&
+	test_write_lines x " " b y d e f g h i j x >file &&
+	test_write_lines n K s n y q | git add -p file &&
+	git cat-file blob :file >actual &&
+	test_write_lines a " " b y d e f g h i j k >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

