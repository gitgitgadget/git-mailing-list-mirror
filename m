Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791515;
	b=x7UXMVY7Y/xmnBUIkFp4BT9lHAJ6ZeW2zdy2soFURObqZaN8n435g4bpfeRSO5q3I1vt
	 TaOtbwA0PtsPhBiCOGbLLNuiWqamUIiM9QlPCKWjJy35iu2OBdVVl4AopVg3aDl6Jkhgy
	 lhiYsFhk63aBbhSvQMeRKntKxcQAeN8XgWfi9kDJR53ZM2GfqxmHc9dxNOqsIYBF8S1Iu
	 3VaFzvrjQ9zJ9tTaMfriGL6BC+CqNxLRur1zsutBeBFh7uaOG4ydVCaYYXrmhbSsyTPHZ
	 q8WkAf34mCdZomeqwm+eP0oi7B9JazXu/A0b2CeyvtBbhNvfmJ2+Vw7D/QX7DnIwTaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AE88dYnt5eHLT+z74Ak7X+d3AJRN6Z5VTlxP597SgyA=;
	b=N1R0oxI3fJ7XzwEs6OZbjczqlXSrH14o3QXwbzTlKwpEN6+uxRAr4D84yOITnuZGdm13
	 s/TP/FiHP0LOYpm61UNb0D/Bg03nwBZJwdF/THvxe1h9aXK4zDm9MhtViI/vFjjEVBpe8
	 /h+mqSQv31/r+R4/02psSDUxBvBKwS75JOzib5v7aMUzXvYOHWeEseLT1UKcfU8FkvXCj
	 an54Cjlaf7Fsg2sfJYMtP2mSEiGb2ardDq3CVj5lBBKeaKU8C2jJU3Z7MuDnVNOG6kq2R
	 g1LF+dzEAs8HXvFa53mX9hOWHdyLpLxXIvlTJXSGJhrW26i2IcYyp9LuFbzEHuA6+RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iElIvnLO;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0A6606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC0A6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iElIvnLO
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso883350f8f.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792791513; x=1793396313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AE88dYnt5eHLT+z74Ak7X+d3AJRN6Z5VTlxP597SgyA=;
        b=iElIvnLOslQgG7Ol1N8iHEV+B6RXNvvfVZ/aB20BvH5wOmf1PIVFs5vkGNgd7BDF0X
         mzjgVzNFNjo6Yu7rnxQzj4qrGKZIp2lGDiPx7+GhIRccqSUmJybSzqhCQ5ks/pSbrCOw
         jUgZJJ7K5q3+9a/M7hCgYFir+cLJMmoYkFZ4MFF2T1GTCHBoQpikLSMcfTXCZzD98gLd
         TTZ5QG9rAmUdElbZWI+jSnNz2VHGwNJAJGHy89Rq26rNNrfiytfLvYBy64M/unRH8PTP
         PozsbFn+1s6OLyFvgKq0rZPtW9iWlHFrFK8C3cLs4ENcPNg5dWHLHUuBZnLHmDaOZpum
         zIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792791513; x=1793396313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AE88dYnt5eHLT+z74Ak7X+d3AJRN6Z5VTlxP597SgyA=;
        b=VGfCE7SF8NEoP2LKKy0gG8SAZUq+Y2H/0zC2gyCKvqjHd91zPz8Yo1oBJ8KZ4O+Pbl
         XjZepMBiwx6cIJTEVVFqBs9bV8aQ/W23RXhMkkL8zLnHXHPBPMlnY94il5YAMCZ4nl4S
         72nI4PSobGzcKiKbeCu3uipm5NN2+gefPEk7cYS+Sh8CPExspKgSXZ/7bddwFLKcwd+k
         ZsqsgrQltO4EnVcEf7rUa33rH6Mc3R1yQ4dwvtzRhzuRzvlM4FSs+uYA+wgbOPXFj5Xb
         fNHHN+vrLHJK+6S+PMExf+L2Zh0E8DeAmFWWaB9gAVoLew9czxAHyacQCsNylKVB6Xsp
         +sDg==
X-Forwarded-Encrypted: i=1; AKwUvBxPB5U5VDQtLuGPpzWaq4oadDF5BBDoUYLRBxMvk161A869IQf/kTyAqjZfLexeuxc7E7I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpAiY1veKSsgbGn93IOBEqsvloc+5/QEI1R/mbvrWDlT7KBEvv
	iaIPmAtXpsuVRTi1O8spXj3tWlMnAUJPBNnaOVdBZm1eLFXvntQSkQpe
X-Gm-Gg: AYBFou2IOqyofrgVqvd35uyE3/OiFQgndfJi7H5shsqOjqA6VTX1CPBi8fILIUuEGCr
	ygOuwNI8EPVodkIPgrb5siBjzaM1nnuXFq02n3RJAR9/yV0Pl6dEx9DI7qf1/SD0YyC0zGUC7Va
	IKiGk68uxc514ubc4Fj69f5YnsEgzHy0KuVxuPzxcw7pDnceqtSZXpqvPJRAZgIPFgHGkPNbNhf
	rsb42d7vSxoCtwC4ih+qoS3BtlGyRLu7ZIO6px87H49C04j4J2YmiYL5sQzH7OECzZGKXEgFfcY
	cBZN3XZbp/YM6qhWP0qToC2au1THERDEx1HZEQyQz2b7cE2sWM4BAdtzSfjH/h1QzhpA3BFRAxp
	neTdneGtk0GT+95e3awC5wYr284/u9KjljpaooGVL4FN/S1PDjvzgwgDcVXRILo3GjG1opJtC3W
	CCxXqNN1V2XumF6nH3NOzJ9isF9yIkebTgPM7Ur+/PLGqbNemIop+ArBHB/YeYQRzvW1c+5jCX7
	6Hr0Q14GGq+tK+J0Ppc4M+FygSZ2NoI5ftxN8rtceU5RityFKMLPHuYuj0tuD+Ba+CrZrSbtNNg
	gpjb
X-Received: by 2002:a05:6000:2288:b0:48e:20ed:27b1 with SMTP id ffacd0b85a97d-48e3eac4af1mr378200f8f.0.1792791513071;
        Fri, 23 Oct 2026 14:38:33 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc4d76sm476609f8f.12.2026.10.23.14.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 14:38:32 -0700 (PDT)
From: kerylefondji7@gmail.com
To: gitster@pobox.com
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	git@vger.kernel.org,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v6 1/1] archive-zip: refactor 'path too long' error message to use Q_()
Date: Fri, 23 Oct 2026 22:38:13 +0100
Message-ID: <20261023213813.3318-2-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261023213813.3318-1-kerylefondji7@gmail.com>
References: <xmqq1p9hhbue.fsf@gitster.g>
 <20261023213813.3318-1-kerylefondji7@gmail.com>
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

From: Keryle Fondji <kerylefondji7@gmail.com>

---
 archive-zip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 6f73ca6d58..160efd878f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -328,8 +328,10 @@ static int write_zip_entry(struct archiver_args *args,
 	}
 
 	if (pathlen > 0xffff) {
-		return error(_("path too long (%d chars, SHA1: %s): %s"),
-				(int)pathlen, oid_to_hex(oid), path);
+		return error(Q_("path too long (%d char, SHA1: %s): %s",
+				"path too long (%d chars, SHA1: %s): %s",
+				pathlen),
+			     (int)pathlen, oid_to_hex(oid), path);
 	}
 
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-- 
2.53.0

