Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1539DBD4
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 03:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789700625; cv=none; b=N72vsiW/wj9o6nA/5aHozQVhZVxZcX/PeoyXiupjTjurSWd+2vtbsHNZEuuTCv32VndVtr6K0O+0prTfVomno0Llf7fzH2fdOlyEiChWX88f1oNYPtynvjc1x37dVgaDbcLoWY1d73Jv7PyjUerRcusellDQRNRGvzEFm244HEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789700625; c=relaxed/simple;
	bh=7FQAv0xilKM7BMUM0aO7Fp0DEYdLipfXCdSd2TSOJxc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=XoE2LzQNKplzgWdRAFmtYaE8Kx2oYuOS3f7SD4U58ZwCARaJ/XNNq56+Sz7n72yZXNxkH2zVQFsDz5kP24zepGVkt21ePBE3jth0k96IWMefyWcNmapA09Z+YRNt/ZKozYNC5HGa/Vml1flTI8v28mA32R5AqTFaiDeyPJq0Ocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjGWbhQd; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjGWbhQd"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb0so23585485a.3
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 20:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789700618; x=1790305418; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=s0kLvt0TiJhwJWZ30oqJfPT3F0Eu8GP8xiOBtyQM3TU=;
        b=YjGWbhQdcZdiEqIP17tF0T8XbLqlon2TQ/XfU5TjNk4vJxHgSwlECfOiy8t2u46fYN
         ZXwveqJAOGqGhlCgLf6CqSNOFKGsagq2CiK0Hhw3ZKP7jp1nrWRhGpZBx/SQ/PKtDVKP
         PPsBtci9c3SzNdASYGhY4E+6Ayr6QKh8Fpe5e0vyBDdZuAiGi9UVrwq9csKlPnCj+ABj
         DER5/5CMXvYSaV0LuhF9UJj21aX5qPFWkKbVNzuSpO7c1xL8cStn+edOFOxtVksaEJnU
         ilSLeoKMBeHkTJ0hLWujywgRL4cR3au5EdFreOkDZcx0l4AYpoW4OmU2Ve8Y+UkQILY/
         6ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789700618; x=1790305418;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s0kLvt0TiJhwJWZ30oqJfPT3F0Eu8GP8xiOBtyQM3TU=;
        b=GeLI0aSWY/pU3Icj49A2H7VMxOIP2Iur0xuEb+gpSlproOeLAsSak7dVhHxC2DG9F0
         RyD/62zh11osD7fK55Iyb1PIL2MrT4u0xZHP0fhNyasfwSNs+g5NrPzM8wZpoPysAppT
         QmwlL1k90DzhNeQl8oSoOpcUBTnOk20EJHuDpLPNjGtPunfVk/l9XW+mIJF76q9y4osw
         yFPhA+GNQEfbciRTjnSXqVcjWxPRjMuZdQP0k5SKtMBfiiPnPAFlu1Y23yhW+CVZ2KPe
         bVmODacNee2xzKaB+AyIKEBivx/KxmmzIKSWIwnirF5F7SeJp1gUqO7EYA/sAozFOYmQ
         65Cg==
X-Gm-Message-State: AFuF++n9PCwKyxwTsg8AJlapdssNVN3mQDwJFl4/+odlIM+ZDQ919b8V
	SX0m+MFvF5mdg4zj6z26nQ2bm3yjrIZfRLachDpAmdM7YGbs0mbtNmewbhDrAA==
X-Gm-Gg: AYBFou0FDQu16SqU5nw7GlLVsUQ2K0zeSonuWC6cQRvhNSJng2z/JxFZOCz8BzNU4ea
	YLHbQj/fRsKrWZPGDDEHTWVLEW3ytOnIR6AiHP75Ehx/fVX0l/3LJ0aH+NlZe7Cz21CyFkU3set
	1lmCOOkIyBtN4dRGo+pFAEV2P1WzPiMONqbL2xFAjHUw0AvEKNGN6fDS16a7hx8FVeB4D+3/ZSO
	IJiZdpGWulhDy1z1GxGqlnSIptzVqfxQKLE78yYWyL6oDVyfQcur6FQh1w4JPRnGPQX2bZFcqq8
	f0jwzKamNXhVJERwwUECLyHh0rgqlohcjZCjmL+YYlXpC17qfa8bZ8YK1GXnyvHuJXhl9wEVa5+
	lpF/mLpLLa4krgkSv5LS3IfIZbWNmUHjRoZWVJGkUNQEBmkWTaIEHqDCVv+qK8UCssuvAjoVnym
	y1jmFRR2lQa7M0JHafJomyY5251RQ84giNbiCc8mlzfyewCSInTiD4Q5DGNXHs1M7Wr6bahnTSt
	JRkz7hb/2rm
X-Received: by 2002:a05:620a:2b4d:b0:93b:d79a:c466 with SMTP id af79cd13be357-93bdca577c1mr113794485a.62.1789700618400;
        Thu, 17 Sep 2026 20:03:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.97.198.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0f0a202sm26784285a.41.2026.09.17.20.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:03:37 -0700 (PDT)
Message-Id: <8cf72312c5e0c2a11166a7024c521c53d9b7a1ec.1789700615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.v2.git.1789700615.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
	<pull.2219.v2.git.1789700615.gitgitgadget@gmail.com>
From: "Qin ShiCheng via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 18 Sep 2026 03:03:31 +0000
Subject: [PATCH v2 1/5] pack-objects: keep --keep-pack open when following
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
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>,
    Qin ShiCheng <qeesung@live.com>

From: Qin ShiCheng <qeesung@live.com>

"--stdin-packs=follow" distinguishes excluded packs that are closed
under reachability ("^") from those that are not ("!"). The traversal
stops at objects in the former, and goes on through the latter to
rescue whatever they depend on that would otherwise be left out.

A pack named with "--keep-pack" gets the same in-core flag as a "^"
pack, so the traversal stops at it too. Nothing warrants that: the
caller said not to repack it, not that it is self-contained. When it
holds a commit but not that commit's tree, the tree is never rescued,
and writing a bitmap over the result fails for lack of closure.

In follow mode, mark such a pack as kept-open instead, the way repack
already lists the packs it cannot vouch for as "!" on stdin. Its
objects stay out of the result, and the traversal can go through it.

This matters more once repack names its ".keep" packs this way instead
of passing "--honor-pack-keep": on-disk kept packs never were a
boundary, and they should not become one.

Signed-off-by: Qin ShiCheng <qeesung@live.com>
---
 builtin/pack-objects.c        | 20 +++++++++++++----
 t/t5331-pack-objects-stdin.sh | 41 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 708b719f40..6f579173b0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4999,7 +4999,8 @@ static void get_object_list(struct rev_info *revs, struct strvec *argv)
 	oid_array_clear(&recent_objects);
 }
 
-static void add_extra_kept_packs(const struct string_list *names)
+static void add_extra_kept_packs(const struct string_list *names,
+				 enum stdin_packs_mode stdin_packs)
 {
 	struct packed_git *p;
 
@@ -5018,8 +5019,19 @@ static void add_extra_kept_packs(const struct string_list *names)
 				break;
 
 		if (i < names->nr) {
-			p->pack_keep_in_core = 1;
-			ignore_packed_keep_in_core = 1;
+			/*
+			 * When following, treat the pack like a "!" pack, not
+			 * a "^" one: nobody said it is closed under
+			 * reachability, so the traversal must be able to go
+			 * through it.
+			 */
+			if (stdin_packs == STDIN_PACKS_MODE_FOLLOW) {
+				p->pack_keep_in_core_open = 1;
+				ignore_packed_keep_in_core_open = 1;
+			} else {
+				p->pack_keep_in_core = 1;
+				ignore_packed_keep_in_core = 1;
+			}
 			continue;
 		}
 	}
@@ -5443,7 +5455,7 @@ int cmd_pack_objects(int argc,
 	if (progress && all_progress_implied)
 		progress = 2;
 
-	add_extra_kept_packs(&keep_pack_list);
+	add_extra_kept_packs(&keep_pack_list, stdin_packs);
 	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
 
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index c74b5861af..4e1fde1b08 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -483,6 +483,47 @@ test_expect_success '--stdin-packs=follow with open-excluded packs' '
 	)
 '
 
+test_expect_success '--stdin-packs=follow walks through a --keep-pack pack' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		git config set maintenance.auto false &&
+
+		test_commit A &&
+		test_commit B &&
+		test_commit C &&
+
+		A="$(echo A | git pack-objects --revs $packdir/pack)" &&
+		B="$(echo A..B | git pack-objects --revs $packdir/pack)" &&
+		C="$(echo B..C | git pack-objects --revs $packdir/pack)" &&
+		B_ONLY="$(git rev-parse B | git pack-objects $packdir/pack)" &&
+		git prune-packed &&
+
+		# Pack C is included and pack A is excluded and closed. The
+		# commit B is in the kept pack B_ONLY, but its tree and blob
+		# are only in pack B, which pack-objects is not told about.
+		# The kept pack keeps B out of the result, and the walk has
+		# to go through it to rescue the tree and the blob.
+		P=$(git pack-objects --stdin-packs=follow \
+			--keep-pack=pack-$B_ONLY.pack $packdir/pack <<-EOF
+		pack-$C.pack
+		^pack-$A.pack
+		EOF
+		) &&
+
+		{
+			objects_in_packs $C &&
+			git rev-parse "B^{tree}" B:B.t
+		} >expect.raw &&
+		sort expect.raw >expect &&
+
+		objects_in_packs $P >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success '--stdin-packs with !-delimited pack without follow' '
 	test_when_finished "rm -fr repo" &&
 
-- 
gitgitgadget

