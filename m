Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577034;
	b=SgqVQsnRi/onXjGnxBfcU8SQQ8Qhd/zQE/qFFZknMjxrbLDdJuAEDgfW/pchY7tT4Yz6
	 yXDBjErEw9glu/EO5BQMQBmH1KPIKY6vEXBy2V13XSWqQx1Gf2odQ/9kIWGsMRMPkBhdy
	 zCese14Bd9rR6350cEgjiNswXQVZ2XB2BeFd5KM7Z+QiCth1IlQG7stlzKCqKI5eKvYkB
	 +tarKiqpxQE1XuAU8jD7iZgqvA4BTMyT7tsLKP7DEj61Gr4pI7ZwcYIQMAucm4EmUf5Fn
	 t9dGztD7LST64nxW/Yx5nMDhBp4SMCnXffruwjV9IIktW8dy9ti7QcT5TiOFuLE2Riw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=h30mfFIEmhrbOczIszgugPwljcq9J1JiKD1KHrVxbOo=;
	b=3g5TIW6hDUTC/j7CROad8Os/Np6PZ0RO8qFzKMecBDTWN9dRceE6Izhc8Jw3HGQV8dQ1
	 G0bm0KEDc1+ugkgpHbaumsXzavRXIocrmHxtlPupqkqcIuHcMimOS2/rz1Mq5E4R+Swjd
	 /PrgVMaPnRsALAeibn+9CKBh99r96Gu/sqzeJKTvp0W2Ql94E9cWLUei09AghkMCaBcIb
	 rSypfM5qe4clOtwt97Wrm5T3tB1ZfwRFJwNyvLQ5gs4gujuxPfA1JPWXSZ+k5d4AOgHV2
	 p66HEL7oe1tTrCgmXMTWZ/owkOA/d7VE0aZqTCMedcCZgI67rAaA2Gmv2+so/0bcFqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0RtTyt7K;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AB606A327
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 03:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C2AB606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0RtTyt7K
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4adae187d94so3603538fac.3
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 19:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577033; x=1796181833; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h30mfFIEmhrbOczIszgugPwljcq9J1JiKD1KHrVxbOo=;
        b=0RtTyt7Ktv9wHvpEmvd3X94/z3C141KC3BuD2Nd6qkrR5RHJkxYpAaKEOPalbkLyNb
         Agq4SPH4ZnsY7W2wynUUD+HXRVIOfhH9SsDeJsPgcOBRAeDzhiSr9pXlSvmLjYWzOekv
         wTIX1juD500kZD074hJeVfCuBgwCg7JR0uLpy9rzBoOm8nMz7b+lB9RU126OTkRBQdr+
         bWYlfP6+rqj2IpISmq+vG3vog1G5UDMmilbVT9tK3SsSifXr48pUsRjJCJgyjP9mPxwL
         XRdPMo3Z7psbB2poz1d5BnloSMxhihoH8dp4fJPYVdhPT2BOWi2AI2Jq4rbBW+2DLWXg
         R0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577033; x=1796181833;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h30mfFIEmhrbOczIszgugPwljcq9J1JiKD1KHrVxbOo=;
        b=MYD4oxxtJlaYrzvYS0/8iRwLCSl2QuZnZAgGMdTK+UPbp7yFA9HtYat/dg9HsWnXoE
         YJe3KRS/YR0CgV1mAPdzorMpls10CahTh//nXANWeQBCYtLKFudRhfhzGkFUat4ul8O4
         cEthUnt4Qqfjeh4l1YuojSzjXGOkCJtkX6MFzFmAzVkbkevlRq4wVvOXjoPukv0AjTcc
         UCG0rgUkY9crxj82m+bNFjGxF8qNP8IGxUD5u2T/bwjI7F4LZW85D23CpkPX/Afp10mc
         yJWW/6Td1TglvFHElEP+oitWlwEuEQLmdmLn2SwIgG1b5+sE6xpjucdDt1xyekjhj9fo
         Ymbg==
X-Gm-Message-State: APuU4Z+o2GYCWvO+Ghem8lNcN/1h0UzyFx2zW3bbd7hduB1P6PnchZml
	Kpa6t73VHOOaBxD60glNYNCOlBMfTwl+8TiY7uH0P00TTYdB75lEVCzg5rjLgj82
X-Gm-Gg: AZFdTZflkqa8U6UUlyytQc7+zW44JxpGd4YeoI1QjUjj59HfvYXO+J9ceZxzYHsBNQ3
	o3SYe/Hr8/f1jHa3wMl5x7GYWJMEHUPmFeW2X7z2TdOOPXlao96rMADfhvXKTap8LP+sUy+UUBo
	O55OpBZav0U3oId7LyPsTFGyk+cMItnJ/jEtsio9qP/349x5BmkaNSaqkDwU2nRsQ0veDH0n2U2
	nqeSAiFaMEAIQIj2MozuakB3FEeLvdJyUZk/6VST6BSusQhIOvMRn8wekWQ6lMw3v3Upn0AZ5KK
	G647Ci2Nbzq5MPAyjjLEmvqYTXqRr2/+HVUUbWvZXLrTbO0MfKIx1adzJ0bCopesHHggJNp4a+O
	vfNQuhThBiu1yvc9G0YG/WCD/4LrO1Yrkx+cZA3fUvR/jrjikLNSXyE5pG+Kmojs0SAYjVipcIM
	x/6Xak5LI6er6Kek1zxoeJ9HQ4xZ3Y8NFLJ71RO9wHiON0P2VcIx6nNSkxvyXkf/BOratkcSSBZ
	SjYfkBP66qgAb3FuhqwSJJ8guaP2Uklw+My2L5NerOglhQDvN/cmY1ACoQzVCBiqtyHgiOLJyNK
	0grGxSD34AvA7iUh3+uxg0IOgl/YF6bLpQ==
X-Received: by 2002:a05:6808:30a3:b0:576:b73b:f26a with SMTP id 5614622812f47-57a0a51921bmr18639368b6e.17.1795577032943;
        Tue, 24 Nov 2026 19:23:52 -0800 (PST)
Received: from [127.0.0.1] ([172.169.255.70])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a34763004sm12487407b6e.8.2026.11.24.19.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:23:51 -0800 (PST)
Message-Id: <14e015ba240a661d8cf8b6bdbc4d7093bbc42ad3.1795577024.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.v2.git.1795577024.gitgitgadget@gmail.com>
References: <pull.2317.git.1795242633923.gitgitgadget@gmail.com>
	<pull.2317.v2.git.1795577024.gitgitgadget@gmail.com>
From: "Wonseok Oh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 03:23:44 +0000
Subject: [PATCH v2 2/2] sequencer: save the null OID in abort-safety on an
 unborn branch
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
    Junio C Hamano <gitster@pobox.com>,
    Wonseok Oh <wonseok_oh@korea.ac.kr>,
    Wonseok Oh <marinelay7@gmail.com>

From: Wonseok Oh <marinelay7@gmail.com>

On an unborn branch, .git/sequencer/head holds the null OID, but
update_abort_safety_file() writes an empty .git/sequencer/abort-safety.
Write the null OID there as well so both state files represent an
unborn branch the same way, as older versions of Git expect.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Wonseok Oh <marinelay7@gmail.com>
---
 sequencer.c                     |  7 +++----
 t/t3510-cherry-pick-sequence.sh | 11 +++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 20bfe00ba3..e0bfc6305a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -644,10 +644,9 @@ static void update_abort_safety_file(void)
 	if (!file_exists(git_path_seq_dir()))
 		return;
 
-	if (!repo_get_oid(the_repository, "HEAD", &head))
-		write_file(git_path_abort_safety_file(), "%s", oid_to_hex(&head));
-	else
-		write_file(git_path_abort_safety_file(), "%s", "");
+	if (repo_get_oid(the_repository, "HEAD", &head))
+		oidclr(&head, the_repository->hash_algo);
+	write_file(git_path_abort_safety_file(), "%s", oid_to_hex(&head));
 }
 
 static int fast_forward_to(struct repository *r,
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index d52fda1c54..fb1ce079f8 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -284,6 +284,17 @@ test_expect_success 'cannot abort a cherry-pick sequence started on an unborn br
 	test_cmp expect actual
 '
 
+test_expect_success 'unborn branch is saved as the null OID in the sequencer state' '
+	pristine_detach initial &&
+	git checkout --orphan new_disconnected_state &&
+	git reset --hard &&
+	test_must_fail git cherry-pick base..anotherpick 2>err &&
+	test_grep "could not apply .* unrelatedpick" err &&
+	echo $ZERO_OID >expect &&
+	test_cmp expect .git/sequencer/head &&
+	test_cmp expect .git/sequencer/abort-safety
+'
+
 test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
 	test_when_finished "rm unrelated" &&
 	pristine_detach initial &&
-- 
gitgitgadget
