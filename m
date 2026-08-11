Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DD429010
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440544; cv=none; b=LhnAW3g8pm2qYwrcQh/MkROXMS+VitPqU5113iF8YllUOrn5CGvnl6TBvGDslaSjZp+EWq6araeEgMW5cu45lyJC4I2+Xw/NSUFzZGkA29P8ivTugB+hnR+m7cLcOyZf8KMrlGYdNh7l4nVnjInxv3EP4ZXL0J2TNJ0buD59ncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440544; c=relaxed/simple;
	bh=/YA5uurhehTI36Eje2dE1XwMu8hvZm9qyO8is5AuuVU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kRN+sJPekk/grq41tD6680hgyAQLRi8Icwm5goIgZdilWceke/GUhKXrZVCgELMow9itjmSvX7I9KshtsAkwmE8dTxImpjo7V9m/jmP95MS1aPWwESb7VmCX8dktKV04lXi3HeFlsyWFeaCJyYHwuIqUtt32jyKpuPdIkM1l5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0t9FpQn; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0t9FpQn"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38e041ea211so3283770a91.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440541; x=1787045341; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B7tAvrt1Hc+QocSX0uwwceLmdipQHkCYbrZDTmKBCUE=;
        b=N0t9FpQnA3LSvB0ikEvnI6vYvFXJHi2Rk+AJtiCnaro4nhip3aL8w81EFxk6Jp6A5d
         97SK/Z52VOBd2lHwSiCbWENRMC4r28O5HXGw9BZXzAEtT0YBv068yoQuXS/1wtTg5Qfz
         voOvEjOyxx4D88ELgGzZMz3inEjeHHrRNuUAyvq1QVoEECUwFFEYx8HNmLKQ5IUSspGH
         NGBH2x9qwanM7+z9KKerZlc2wMk2DHnyvotwwNi84r1Nu/7ofKnMUl0I3H7IrW6mNXHg
         Z1g3bHJ8LtSnizmaLLA5iW8wOpdFU3Tc29mmDj3nFGmq2RMueVT1gk9OMYHXng46VWsv
         Qw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440541; x=1787045341;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B7tAvrt1Hc+QocSX0uwwceLmdipQHkCYbrZDTmKBCUE=;
        b=sd8rvYoTdHq6MZ1yku/mYDKr53w8mwZdetwVz+fLtm0+LADDbSgbkKUW8tO13dDmFx
         N4/P6afwe5eTw5ab0SqXFFKB4FClTlgBt3xtO88RpgmFPEZff9N7ovJye8G1ZiEKCbM2
         xuaVF4rRAqsg2RvJIO1Ys+L2BKHiud/wPGP/h0MWi+sh0NAQYVXhbdAg1gJRRqunFrZQ
         rSBpK+AVySwTkFTos1Zi2ZDkGICUX0/t172QAdztk5TpcsI4oMO7YUTfR7vciSyv4SGk
         KWWQvRFybTEFn8AQSky9gE2N+++GGsAl78le2CAxkrJDpUJM86mh9AxgEse9OJS6HV+u
         F1mw==
X-Gm-Message-State: AOJu0YzxE9/xmqby6UTxLjuHoZDGu0PmiBa/uZkYA7NPqqC6JgsM+KMg
	Pbata6nhx26bsXMPPqv7rHk7OwFI6Oz2WPn81q9McyxYB75xxWfNNzHIV5ec6jWg
X-Gm-Gg: AR+sD12L/F+6aeXjlB1T2XScACPob3d24kz0aBFNM4gORBZMuLzJ3itAfQsVPjMMsPP
	sVDr6pjvGyhvn4ryil+xXeFJKJuGNJp0lF2vbCcJsCdz2L3RFTG6I9A2AMbcQK+2gwVvo3DiRc4
	wIyoxsTHxB75yM3hGT9oaVNTUk1Q8Y48fiKUbReobjdmox93FLW5UEWykBVdzHTc34ZhFOIan19
	EXUfkQlyjMVXlihB6lm9G69e6w62A1zwl9O6BJxp5ZYd32+EdpFth7dZGdi3lp6tHZaO02ZuZHF
	Gc6WxPX3SUcm+vCx7ma/r7S1liX7Uc12zMY16gVn23ZEKSBok9UrHXVM0dL4vd3ApCrYjo95WgU
	01UP6F18nOqvA2T9zej3xDZYyykbeAkZHnTjgByuGJ4nSgr7E3aMBxObabUjrY3ARn89yj/Mq5z
	BrmOqSfifi6PeFLiQaCdyMUKjBIYW2CajoNQOiGXqRMbCNF5Of+LYHTwieK/e+bLs=
X-Received: by 2002:a17:90b:3d89:b0:392:c80b:8eff with SMTP id 98e67ed59e1d1-392ec59c589mr2186958a91.11.1786440541078;
        Tue, 11 Aug 2026 02:29:01 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392ee1e37b1sm1243922a91.1.2026.08.11.02.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:29:00 -0700 (PDT)
Message-Id: <53cb1a96904b60cbe23de1a41b2d27291ed739a5.1786440533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 09:28:47 +0000
Subject: [PATCH v8 05/10] commit-reach: add trace2 instrumentation to
 paint_down_to_common()
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add a step counter and trace2_data_intmax() call so that the number
of commits visited during the paint walk is observable via
GIT_TRACE2_EVENT. This provides a way to measure the impact of
future optimizations without relying on wall-clock benchmarks alone.

Some step counts already vary across commit-graph modes (e.g.
in_merge_bases_many:self) because the pre-existing min_generation
optimization short-circuits the walk when generation data is
available.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 commit-reach.c        |  5 +++++
 t/t6600-test-reach.sh | 44 ++++++++++++++++++++++++++++++-------------
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 8541264136..d59e76a2e2 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -11,6 +11,7 @@
 #include "tag.h"
 #include "commit-reach.h"
 #include "ewah/ewok.h"
+#include "trace2.h"
 
 /* Remember to update object flag allocation in object.h */
 #define PARENT1		(1u<<16)
@@ -113,6 +114,7 @@ static int paint_down_to_common(struct repository *r,
 	};
 	int i;
 	int gen_ordered = 1;
+	int steps = 0;
 	timestamp_t last_gen = GENERATION_NUMBER_INFINITY;
 	struct commit_list **tail = result;
 
@@ -138,6 +140,7 @@ static int paint_down_to_common(struct repository *r,
 		struct commit_list *parents;
 		int flags;
 		timestamp_t generation = commit_graph_generation(commit);
+		steps++;
 
 		if (min_generation && generation > last_gen)
 			BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
@@ -194,6 +197,8 @@ static int paint_down_to_common(struct repository *r,
 	}
 
 	clear_nonstale_queue(&queue);
+	trace2_data_intmax("paint_down_to_common", r,
+			   "steps", steps);
 	commit_list_sort_by_date(result);
 	return 0;
 }
diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index a113adfc8a..c0ac90680e 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -153,24 +153,34 @@ test_expect_success 'setup' '
 '
 
 run_all_modes () {
-	test_when_finished rm -rf .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-full .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-half .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual &&
-	cp commit-graph-no-gdat .git/objects/info/commit-graph &&
-	"$@" <input >actual &&
-	test_cmp expect actual
+	graph=.git/objects/info/commit-graph &&
+	test_when_finished rm -rf "$graph" "${graph}s" &&
+	rm -f trace-mode-*.txt &&
+
+	for mode in none full half no-gdat
+	do
+		rm -rf "$graph" "${graph}s" &&
+		cp "commit-graph-${mode}" "$graph" 2>/dev/null ||
+		true &&
+		GIT_TRACE2_EVENT="$(pwd)/trace-mode-${mode}.txt" \
+			"$@" <input >actual &&
+		test_cmp expect actual || return 1
+	done
 }
 
 test_all_modes () {
 	run_all_modes test-tool reach "$@"
 }
 
+test_paint_down_steps () {
+	for mode in none full half no-gdat
+	do
+		test_trace2_data_singular paint_down_to_common steps "$1" \
+			"mode=$mode" <"trace-mode-${mode}.txt" || return 1
+		shift
+	done
+}
+
 test_expect_success 'ref_newer:miss' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
@@ -244,7 +254,8 @@ test_expect_success 'in_merge_bases_many:self' '
 	X:commit-6-8
 	EOF
 	echo "in_merge_bases_many(A,X):1" >expect &&
-	test_all_modes in_merge_bases_many
+	test_all_modes in_merge_bases_many &&
+	test_paint_down_steps 45 2 25 3
 '
 
 test_expect_success 'is_descendant_of:hit' '
@@ -329,6 +340,13 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 	test_all_modes get_merge_bases_many
 '
 
+test_expect_success 'merge-base --all commit-walk steps' '
+	>input &&
+	git rev-parse commit-9-1 >expect &&
+	run_all_modes git merge-base --all commit-9-9 commit-9-1 &&
+	test_paint_down_steps 81 80 81 81
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

