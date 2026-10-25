Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792956034;
	b=0aNrzo046upXHfvYKTfJ4y8IJBcZ0Y+BZU7jwIGJake7zgp11fb78A3JJZRgDBnvzsGq
	 OZhDKS6SrlsAOg4NT26VHa3wOzW7CBbK2z+lmPduJYjF/0k5MHot9lFSICmfez9Agn7BY
	 49L42XNnXNc5dxeJaEyRxaXn2kMzGVvdBQza8vd8JH/6AD6JY4lbW1ayfppCxgl7UJCud
	 ukUphTDEPiqLmscBUQJsXbFDzq8Gsqvjm/APmy6PXG7QEB0IiSz1z3bHATqh78u98aHlt
	 jr2jfI1ILwzAwIwLiiRW6ukzS+yTFWfie4eE5Khsytp/4ACSNF1SF7KjPj3IhB0d62Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792956034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=b80acukHVdMLzZTTka6IesVtT9UFyhKUNuNF0s+dA+o=;
	b=YwIg68Gf3EgjHlUNEJH+k028dVNO5Oqmrby/i8TcUBy2cEOuk54SX8XC1pvzZ3+XHXfK
	 hQf1pw6Vm8B7z3ynE2M5q+V2lE8gad5j4vMlb4SC4noAuI8wpOyBQpMvjEkUwRNO4NaEg
	 y8VbJsStK8nR50sXTbKZY2JtlUp6UfRu8JrALHQimj/MCF9PbEoPSGHDjurmjAHVePAeI
	 tNujtC4OWdLlzEyS5kTXl8LZuxsRkzGQh5b20NntrCO/LxlzRXaRxEcKmpt1OV27P4IW4
	 B6IaZHeA6rr5So4I4QseMJyyMYvk/gwkpZcz6Tczf77B0ASgMynUsrh14S/0XJo9dBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ATgxuxA1;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC356606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 19:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC356606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ATgxuxA1
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35f036b17easo6193782eec.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792956033; x=1793560833; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b80acukHVdMLzZTTka6IesVtT9UFyhKUNuNF0s+dA+o=;
        b=ATgxuxA19vz+fdTSXH2hhO6saRH8o+nlwhObwBszxhbeRF+k+xc8Nnosi8x454D7AH
         4gL8U0IuJbvTBXaIxjbWpGM7bMEQO+3dh8l8mGy548l4MjFKQOd6D0SihABiV2sXCOT4
         AkFNqr77EufXenn3ZDu87LTM5+eyApWtvEd7VTP9k1a2QjR015C5oKKLFBNVumEo4IEi
         U4WRa9I3tYt+ywq+NVjAL2/yhYFAPjvuqsRi+rVejydIywl0wygCDFoTwKFuEY4cC0t0
         nRII7uUmLC2B9kQCgqB8Fpho/TVix/zPsVQugDkPvqgK4uPypucjPZhlpwKJ0i6c7vjD
         qF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792956033; x=1793560833;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b80acukHVdMLzZTTka6IesVtT9UFyhKUNuNF0s+dA+o=;
        b=plCt3bb8sHccwdYBF7gKz3QwoldA1iOBiVkR5IMD1xjyeEc+3cUVfl5Eq8lyzuWXLG
         bNWDWHCAMmTtyMPWpap9xuePVS5Jp6crVKP+Gt06aQLbwgLGleau4xTNz3Scx+hHUXcr
         qaXr2zW5U8FILHMgST2CVSoBcuuIqVJtHNu1sUgjgII/evKSJgpfw/+QsQRpIU68rq+t
         ODr8CuyL3tSH5iMsqg26/vkHCR9WI/mdd6xcM097quTQWREGiLfe8UHOmZc5V4EVYi2B
         empnX2JQ8oUH12PHECbxEmvkhROkKGK7ukhgdy3sfaz+g2o1klzjcD6TiwrHuK46XPp2
         f04A==
X-Gm-Message-State: AFq9FYJWWN6mUaAmZnw1uSMNb24Quik/DNaqdRGV8eIrjRG8D2w5CKwH
	PeG6dhjxqWd9e0A0dTxqUixAzcfjSJaytif3KX13kKxvT6NJLJVxkB/Cp2grN+yN
X-Gm-Gg: AYBFou37O132UublXmX0dfHepwNnQuINllrQUm+WttjQJcXgC9gbFJ7KngGrSN6HNDv
	PR1iPUskU30/Vc+9C43O3jYzFVVuoeOnvuKHfnf/H7b2HoC4rJH9K1dI2KR7F+HZSK+oXQV+i2p
	1CSIHbxy9iFlZx4SIXfnF5VuBl5mesQ7ekcBwKPfoAuxtmPyMeqSO+NDsD28ogKNzMugmiKrWW8
	JWjnIRq7Q6Xlfw50xK4oooKmWMUXcrgUtg4HNLh+JwbuXpOAjpHsIjp6rG88+20qYMeV3c5qX49
	6GgZY6W8PVIuYWgeWOowTXNPUOv2u1waEq5SeKwKjheTogaXL0QXNLNSRRpzaCUg+OsBPq1cktI
	BEJxEHcUBG7XzW87CKNtCk2JHB7xDF2mt8Y5xIgQIf7iFfD2e9z5+oPrD/IKttYwbXGTEWzC25n
	Qi891+G1bJJQ8hS7FkkLH7n83joPiD8EjyxKis77ise9hNO1heRAvE4DajJ/G7Ef3pYBkEs3BaV
	O3YZ1GYD5k44JtZ9GXC/XDgC+UMQgCMXxhQr+bWRbHxevJqOqUZTbn/9iE=
X-Received: by 2002:a05:7300:f497:b0:369:f3b8:2c48 with SMTP id 5a478bee46e88-369f3b8473bmr4599060eec.34.1792956032713;
        Sun, 25 Oct 2026 12:20:32 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.21])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d578casm21015137eec.6.2026.10.25.12.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 12:20:32 -0700 (PDT)
Message-Id: <pull.2276.v5.git.1792956031588.gitgitgadget@gmail.com>
In-Reply-To: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 Oct 2026 19:20:31 +0000
Subject: [PATCH v5] diff-delta: use safe integer arithmetic
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

In create_delta_index(), buffer sizes for allocating the delta index
are calculated using arithmetic operations on entries and hsize:

  memsize = sizeof(*hash) * hsize + sizeof(*entry) * entries

To prevent potential size_t wrap-around when computing allocation sizes
on 32-bit systems, replace manual arithmetic with overflow-checked
helpers (st_mult, st_add, st_add3).

For the unpacked index allocation:
- sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit systems,
  which may be padded to 16 bytes depending on compiler alignment rules.
- sizeof(struct index_entry *) is 4 bytes.
- entries is capped by (0xffffffu / RABIN_WINDOW) where RABIN_WINDOW is 16,
  limiting entries to 1,048,575.
- hsize is the smallest power of 2 greater than or equal to entries,
  capped at 1,048,576.

While entries is bounded in current code, using st_mult() and st_add()
guarantees that any unexpected growth in struct sizes or bounds changes
will safely die() on size_t overflow instead of wrapping around.

For the packed index allocation:
- Passing (hsize + 1) as an argument to st_add3() is safe from overflow
  because hsize is capped at 1,048,576 early in the function.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    [Outreachy PATCH] diff-delta: use safe integer arithmetic

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2276%2Fpoojarysrujith%2Fc-refactor-target-name-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2276/poojarysrujith/c-refactor-target-name-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2276

Range-diff vs v4:

 1:  0d5a729cde ! 1:  23fcfd3227 diff-delta: use safe integer arithmetic
     @@ Metadata
       ## Commit message ##
          diff-delta: use safe integer arithmetic
      
     -    Replace manual multiplication and addition in create_delta_index()
     -    with safe integer helpers (st_mult, st_add, st_add3) to prevent potential
     -    overflows when computing memory allocation sizes.
     -
     -    For the unpacked index, we allocate hsize instances of hash pointers and
     -    entries instances of struct index_entry:
     -      - hsize is capped at 2^26.
     -      - entries is capped at 2^28.
     -    On 32-bit platforms with 4-byte padding for struct unpacked_index_entry,
     -    the calculation size (sizeof(*hash) * hsize + sizeof(*entry) * entries) can
     -    exceed 2^32, making safe integer arithmetic necessary.
     -
     -    Similarly, for the packed index, we compute allocation size across
     -    struct index, packed_hash, and entries. Using safe helpers prevents
     -    wrap-around across both allocations.
     -
     -    Note that passing (hsize + 1) as an argument to st_add3() is safe from
     -    overflow because hsize is capped at 2^26 early in the function.
     +    In create_delta_index(), buffer sizes for allocating the delta index
     +    are calculated using arithmetic operations on entries and hsize:
     +
     +      memsize = sizeof(*hash) * hsize + sizeof(*entry) * entries
     +
     +    To prevent potential size_t wrap-around when computing allocation sizes
     +    on 32-bit systems, replace manual arithmetic with overflow-checked
     +    helpers (st_mult, st_add, st_add3).
     +
     +    For the unpacked index allocation:
     +    - sizeof(struct unpacked_index_entry) is 12 bytes on 32-bit systems,
     +      which may be padded to 16 bytes depending on compiler alignment rules.
     +    - sizeof(struct index_entry *) is 4 bytes.
     +    - entries is capped by (0xffffffu / RABIN_WINDOW) where RABIN_WINDOW is 16,
     +      limiting entries to 1,048,575.
     +    - hsize is the smallest power of 2 greater than or equal to entries,
     +      capped at 1,048,576.
     +
     +    While entries is bounded in current code, using st_mult() and st_add()
     +    guarantees that any unexpected growth in struct sizes or bounds changes
     +    will safely die() on size_t overflow instead of wrapping around.
     +
     +    For the packed index allocation:
     +    - Passing (hsize + 1) as an argument to st_add3() is safe from overflow
     +      because hsize is capped at 1,048,576 early in the function.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      


 diff-delta.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 7cbedeb507..efebce3aca 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -162,8 +162,8 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	hmask = hsize - 1;
 
 	/* allocate lookup index */
-	memsize = sizeof(*hash) * hsize +
-		  sizeof(*entry) * entries;
+	memsize = st_add(st_mult(sizeof(*hash), hsize),
+			 st_mult(sizeof(*entry), entries));
 	mem = malloc(memsize);
 	if (!mem)
 		return NULL;
@@ -258,9 +258,9 @@ struct delta_index * create_delta_index(const void *buf, size_t bufsize)
 	 * Now create the packed index in array form
 	 * rather than linked lists.
 	 */
-	memsize = sizeof(*index)
-		+ sizeof(*packed_hash) * (hsize+1)
-		+ sizeof(*packed_entry) * entries;
+	memsize = st_add3(sizeof(*index),
+			  st_mult(sizeof(*packed_hash), hsize + 1),
+			  st_mult(sizeof(*packed_entry), entries));
 	mem = malloc(memsize);
 	if (!mem) {
 		free(hash);

base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
-- 
gitgitgadget
