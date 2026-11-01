Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521360;
	b=x0a4qG4GKbsHW2d3XQ99RiPty7ZHlJ+i0nR5vkRQhtz+iuF8nuQ7TTA/fj7L+XPrkdpo
	 FbPXQhScMDsEndrYMeMYmahGULHszJNUgH2Cubxic9JNL4QskaXzMgNsyfgDT08irx0Lc
	 tZLymwvh1fgVB2oA729GWGXZC0PRThKKATW3P8WtH9YL5Y+dR+DEDnNBJAK1KCPsQmFDq
	 LevP/TEwgYdTprWsd+HgnIYEhks0W1WaxcxYGFnyZfCtRn9CoBjcrkDQN26BNFTEzYYFl
	 YJM1eFjfstIKkEz6LDW8bm6V0gb5odiM83D8ggBjz4g9yR/Uz66FWl/m+HpSx8BeDyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Q0359+pxSsVt6jBqqQfIwFuVIpEiAtLgtSOeANBda1c=;
	b=fgH07PCpAKzLzxK587pJnlj+AxM6XF5ug8Kt/Ff7GNOPZDWgqsBp1kkPz9Y3EQDA1lXH
	 6pU75fLBWGA3sdajhftV7LUiEvoEiTVSyF3wNoJ6dKvaRrfajBniq80c397U1aK+w+IYG
	 N+sKV69xVXYqvq6rvIuzeiRXjmJ9CR4qDTAnjrVT28M6IrlZ4aVDkFtiXdC3gHhUPcXaj
	 RuHWFaNiKxBV3vFTUv4oy7RHKeRY/mXUQrvSoToDet/R64xGPg7Zha/LzwafTyQSLyl2K
	 asgPwt+A1l6ao2g6XKPBX2JjzsdYXuKGAwniEU+TvPwhw2pfm38HgoqWdcgLjH+XaZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWcga0Aq;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC0606A325
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93AC0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qWcga0Aq
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c43fbcb4393so305000166b.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521359; x=1794126159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q0359+pxSsVt6jBqqQfIwFuVIpEiAtLgtSOeANBda1c=;
        b=qWcga0Aq0yU89JP0uIw8qICo0kYeNB6acViIIU29snuHIN3bYyYBoTQB7k6ReR/HTm
         LDJ48gOfYUi06dZvsCg5bxpuaMT2oPev5Ccf3ArOX2kPyA3HwgGsd4CrLndwPtkXqXWW
         y3PubCQYOKQeoSx3a2TTaL1PfgQPs0c0g+TtpqxdIjm4dTkch+iQxWN2D1FkD6uvFQ0Z
         dhS39SgtJUP395AYDBNDpgAOffIWg64KZ+ZsLMvtPWHZfLq4hiIXxBSowUSArHuiCmlT
         9ozPS9SqZHZHkDP6jpBn69hzCX1b2+fzWL88g8/n4nNsmdn+lacjuddKsyPKDQisgHzr
         70yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521359; x=1794126159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q0359+pxSsVt6jBqqQfIwFuVIpEiAtLgtSOeANBda1c=;
        b=kIGUEAQM2ayjtMaJy6H1Kyn9DnpTGeA5hKyA3UojZ6bzG3xGUHDzSpLrXo4cFDbD7Z
         71llHkPSNtOamdJFZ0x61kyyX35RDDVQ9IPC7abGFLMk4WKLY5u9i6gmud0lTQPtbcEf
         JWzwD9DXf6oAMVecBuodSXZ8ARXnp0gWr3MWVry9vjSkNzZGFNRQHuo75iNXy/IFTt/W
         gUoRzXcNVFKZywP/b+FTiV9ZH+oiiTgFCXjtBAnpYnQFybLSsAjzcosm20uSdWe1rsL/
         GPf/50KB4Ir3EfcDRUTztrhtII7y5uzn0Z7LaNuXbnjvzXek0P0UPv8lVGpTB/vext1n
         Wukg==
X-Gm-Message-State: AFq9FYIQcgBUQEYGiKx7U58hIpAOmB+hemKYSn7ykxNzKOIeGa5QHE3+
	ijWk5PjFOYaZvvos5Z0nWlbsi2hqRteFl3R2G/QeDL6+wE3GjSG7Cxqd
X-Gm-Gg: AYBFou3UIh0u4T9PdXNxn7m85Eu90qaRvcNA7qFOdZCteyrN1yLYoHRTlAT76G3PMZv
	4BFfjG1alIr7LpRS4Kd9f3t6fQU5Zn6Giy006fvOtKtUROGWjlJH/Ef3iR0iWKvtKPZLnfv4QE8
	bneLoQhsX+GvVNDi1pnTTvz5jTvRT6ED5o6PtWNXW4OrIfqlcsTPDAK4GozXPBMMjGGVmzFHo4V
	UgUTsW3FX93WHXc6DatBahjBIFbsIMTssxdrLiHUxvSB+UHRRLJqDQoQe69oj8dqpN927iyEFVN
	KGSVyiJ62nymEHdWDJLJYXpxjLoWV4iWnBzlrZup8Z5wg2cihajDhUo3fAwbiEm0Sj79bIpOyyk
	leCGKkkPG+SUJnmjQDcF9KbPFRbitKXZKLR2WdDWA3FNEJiwycjFq+ajwBPeItCmBsaSGTvOIvI
	24bJ8J3V7WAn4B2Q9+/Ad9WMaMmUdyoXyo13V7w93A7AMktNqBg6g3Nym4dcXb1nL8svN9her+d
	A6x72xKHZ5r44+u1YcSlEq4q4mpadxYrCK+sM4nuZe5/qQC8MaL7kY9DeIBIwbsqNhIylf2eNRU
	ZOHhJqtvBo/TA1fkc/RsGioYpl2Vsg==
X-Received: by 2002:a17:907:3e83:b0:c40:560a:462 with SMTP id a640c23a62f3a-c4ca7a848bamr577668166b.32.1793521358777;
        Sun, 01 Nov 2026 01:22:38 -0700 (PDT)
Received: from omris-tuxedo ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabed8f04sm256709966b.75.2026.11.01.01.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:22:38 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: omri.sarig13@gmail.com,
	gitster@pobox.com,
	taahol@utu.fi
Cc: git@vger.kernel.org,
	julia@jvns.ca,
	me@linux.beauty,
	phillip.wood@dunelm.org.uk
Subject: [PATCH v6] doc: git-rebase: update incompatible options
Date: Sun,  1 Nov 2026 09:22:30 +0100
Message-ID: <20261101082230.141688-1-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261025110759.204336-1-omri.sarig13@gmail.com>
References: <20261025110759.204336-1-omri.sarig13@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few options in the rebase manual page link to the "INCOMPATIBLE
OPTIONS" section, but they are no longer incompatible with any other
option:
- Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
  incompatible opts, 2023-01-25) removed "--allow-empty-message" from
  the INCOMPATIBLE OPTIONS section, but did not remove the link to that
  section from the option description.
- Commit a74b35081c (rebase: drop support for `--preserve-merges`,
  2021-09-07) removed the `--preserve-merges` option which was the
  only one at odds with `--ignore-date`, `--reset-author-date` and
  `--signoff`.

Additionally, since 414d924beb (rebase: teach rebase --keep-base,
2019-08-27) the `--onto` option is incompatible with `--keep-base`, but
doesn't link to the INCOMPATIBLE OPTIONS section.

Update the description of these options, to have correct references to
the INCOMPATIBLE OPTIONS section.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---

Thank you for the review!

Changes in V2:
- Update commit message per the review comments from Phillip (Thanks for the
  review!).
- Add `--onto` to INCOMPATIBLE OPTIONS.

Changes in V3:
- Downcase "Update" in commit title

Changes in V4:
- Update the commit message per review comments.
- Rebase the patch to be compatible with the maint branch.

Changes in V5:
- Update commit message, making it clear that the `--onto` option was only
  missing the INCOMPATIBLE OPTIONS link.

Changes in V6:
- Update the commit message per the review comments, making it clearer.

 Documentation/git-rebase.adoc | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..f1f675d311 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -217,6 +217,8 @@ OPTIONS
 As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
++
+See also INCOMPATIBLE OPTIONS below.
 
 See TRANSPLANTING A TOPIC BRANCH WITH --ONTO above for examples.
 
@@ -332,8 +334,6 @@ See also INCOMPATIBLE OPTIONS below.
 	and this option would override that behavior, allowing commits
 	with empty messages to be rebased.  Now commits with an empty
 	message do not cause rebasing to halt.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 -m::
 --merge::
@@ -487,15 +487,11 @@ applying (in terms of the author date).
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 --signoff::
 	Add a `Signed-off-by` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 --trailer=<trailer>::
 	Append the given trailer to every rebased commit message, processed
