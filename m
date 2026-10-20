Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512119;
	b=W7D93pxb65bfFOSpolsQ162B5yN1b2yEwFRTwTffcZJXSfla7yrK9Hd96RXH0+oK10wP
	 bWEjDAdE2XCs8sLcrNGbJC0+SPiBcZpT6gBIecO5UUkqdxJr1jTkQfoVwzZWtWSrJ2z9s
	 i+Q6CFzEYPjWTrEdBxR5b1FTnDe1TB3ePAJkRl5YlmDfJyXvfgwIuo8sCZ8viBXyRuQmz
	 7FBhsftNzXx5Q4gihS3rSdSrik9Vuapr9xjyulOT5bV7/kbn4IbpT3z2H2PFevnU4wmGi
	 f7GQ9dvD0LNmz0M8G4gCJKDaYHt4pzjhdc6ekoE40fS0EZzHrcjV80DyvFycBhK85FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ikQHvq1zF8yjSyFKFPIITe7Oou89/SjMvkJjL0Bdr90=;
	b=PnHvsBth73JBATxpSOk1WC9mh/IiqK33IThsFbExDaKgeEmhJy2+rR8YbR0GM+oNjoMw
	 DnTUhpCIeBJ8XV4P8VZrz8v6y3vBoLLBY1IZLdZ/fCzXhggOp4yrqbL1NWtzdrGZ8mW/r
	 0Z2PLjrmtDy2gl9GQcLQwc4eJSMTc0gpv1y9fi0iYo2+viJK2nWM1FT7VNbbvphA3B8Sw
	 E6HXgUyiVzRI1+/18+xisbyq3d+y2veQHO1X1Hlj1x1SUvY0nwbH9cMJuLXvI375Heq3+
	 K5M5sRC6kzirkIMzi3qSeNFQAOSnEcr0j4Uw5T0NaMayBdQxOuY29Qf3vSGlE9CsAfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pVYwFTWv;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0D5606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E0D5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pVYwFTWv
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso2132911f8f.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512118; x=1793116918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikQHvq1zF8yjSyFKFPIITe7Oou89/SjMvkJjL0Bdr90=;
        b=pVYwFTWv1zknHVFEfNPx89N1X83K+ZyRmkkwA3Q3yVSsilrJ4kGQw5zpvTD0pe6KgW
         gAvd+IkC9Q5MQs2cvZYQAuVviS0fH2b4asvwNTvhLq1h7C8qeOfYvxqLk9LbvHhSNewU
         /SJq0LzwlPGrM8hcSOJhJqopGciraOEftrQEqKzfmGl1LoCvVhDkkGWHRhMoyGR51fAk
         84rVVVpaON6Lc2ZNdj2wREl6mgmOewQ7dzPsgscaXZiO6a1DdMOtEX6Xse6rsX3dB6yM
         ZXn9O5oiBEK/sV3trcZrQIRyH2u7hdoFr+XSKaj7XgVZTyBIfFtR2/CZsvaoau/qvRUR
         A1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512118; x=1793116918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ikQHvq1zF8yjSyFKFPIITe7Oou89/SjMvkJjL0Bdr90=;
        b=OCn8m3ks7qQcZhIRJ8bBl3/yVGPYYbv2rJnZF3nJVU8biKLGFRRpa0Bgw6OwUR7aII
         G9GADW4VPQilV9tBdRrYPxAp3OfKMcF4DZbk1ogb51vRsgqs6jMJU+tPqTGD7gsGq0FJ
         Y7M7aemetAzXvNMhBSXdA6T60tlWS+R4WGV5N6eRcGk9PqM07QcMbw4NGZaxwQztY52j
         DB81eUiYfhCccpBgjgdWcRDv0SBEVCvOupq337kByTcMQIFygNPImix8zkNLEQwKiTan
         Jlwj4RMXa3+1+ytS0xpEEfSCsdEBv/EM2VWjw+7GOl2155lUxJixflsMuxrrLIjO5ZnV
         qm4Q==
X-Gm-Message-State: AFq9FYLVrOjsF9RNXPv7ufZZ4ehlg9HUJwelAiP8FRXns7pJ7pxtqb3R
	rM2pyhLSc9evZyoyHQ2WcNtbnQr8KKrcVWRO2+Zjxge6K+s0S6WAw1OgXrkp4EB1
X-Gm-Gg: AYBFou0Tb2qb+swEwFDZ4BvmNTc2ROI6PsqbnE7LwMgXgR+BxQH9zlUCxYZ2cP1vM9h
	xP8otzBNe/4NhZl5kbahZwDZFDzj9f3GqDYgm3ZOjKDao7adTrp2UsPburNIGfoyPKEpth6nUWM
	KFQelbUGf3GoNscQRJO3sD3k/3F/AwSVIhE8EiFlWaWQH79rgno+pn6gFBlHRUcki1PcVbbzRbI
	RnAKwi2Vksq5UVB8xijFOFYSVRuZ+qSaz/WispUHhpd556YMCw/WirfXmiU4V+GX2mPmosfNkup
	/B2tO4i7/yal9BNzrN+kmvIVxpU679Sf+BnW+B7AcgZUGVZlNAhXlQs3HDxkFFwL/WEK5Yw8NCV
	eZn5d6wwc1uENQ7ATnIKAnZbDiRPOquEwNuvdrNObJODfivgl5Refak2GAPDS0263TuWcrv7GSF
	WuUHrf41BfTdXHaK+ErgsDbR3WSXjrz54bTGbSZl6vALz5LfZ5XMeNrvpUZDxAEADmXwLgUgfNo
	NMcUc7yoaPb6RRFIoeYleLsAavGIsVqMOnGfd96srQo
X-Received: by 2002:a05:6000:46dc:b0:48d:ed30:f863 with SMTP id ffacd0b85a97d-48e07fa266bmr17771149f8f.30.1792512117636;
        Tue, 20 Oct 2026 09:01:57 -0700 (PDT)
Received: from Stealth.zuku.co.ke ([197.237.143.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d830e91sm7157410f8f.54.2026.10.20.09.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:01:57 -0700 (PDT)
From: Dorine Tipo <dorine.a.tipo@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	kaartic.sivaraam@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	usmanakinyemi202@gmail.com,
	Dorine Tipo <dorine.a.tipo@gmail.com>
Subject: [Outreachy PATCH v2 1/2] t0410: use rev-parse to get the subtree OID
Date: Tue, 20 Oct 2026 19:01:26 +0300
Message-Id: <20261020160127.29096-2-dorine.a.tipo@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020160127.29096-1-dorine.a.tipo@gmail.com>
References: <20261014134504.1152225-1-dorine.a.tipo@gmail.com>
 <20261020160127.29096-1-dorine.a.tipo@gmail.com>
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

The 'rev-list stops traversal at missing and promised tree' test gets
the OID of a_dir by piping 'git ls-tree' through grep, head and cut.

The pipeline goes against t/README which says not to pipe the output
of a git command, since only the last command's exit code is kept.
It also silently assumes that the first tree in the ls-tree output is
the one we want, without checking which path it is stored at.
And 'cut -b13-52' also assumes a 40-character SHA-1 name, so under
SHA-256 TREE2 holds an abbreviated OID.

Use 'git rev-parse HEAD:a_dir' instead. It names the directory we are
interested in explicitly and returns the full OID in a single command,
the same way TREE is computed with 'git rev-parse foo^{tree}' just
above.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>
---
 t/t0410-partial-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 788e9a1631..a24b663f73 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -405,7 +405,7 @@ test_expect_success 'rev-list stops traversal at missing and promised tree' '
 	TREE=$(git -C repo rev-parse foo^{tree}) &&
 
 	# a tree referenced by HEAD^{tree} (tree referenced from tree)
-	TREE2=$(git -C repo ls-tree HEAD^{tree} | grep " tree " | head -1 | cut -b13-52) &&
+	TREE2=$(git -C repo rev-parse HEAD:a_dir) &&
 
 	promise_and_delete "$TREE" &&
 	promise_and_delete "$TREE2" &&
-- 
2.34.1

