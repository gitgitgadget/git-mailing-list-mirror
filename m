Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918146;
	b=NvX4jXJZbIETaazV2uEq8/Td48henp0bba5Yirnh7K3+KK7S9gxlqd3BKHSq1WtT/0Ag
	 N5hq1VcRKUKqbTHHqXMXzrhXDmoTCrwwUsCiLRijjZxea7xNaD20I768BVVcYC7HTORBM
	 gU+fqedFl4lTCtyyyhMJaKu9kvas1SzOYD92Gi3CCCBbuK7WEkUzHKY7mm5pHYMi6Xmyz
	 2jNPSPxtYx0BowgrAjXyd2K4GEWgZPtwvMl0pt/l3t8juxMRUuEgU3tyr0dCTkkEcwAJ3
	 YPnYcYceS8AUCTAV2Or5XV8BvL6HRS7f+zdU+FPXm7fg34gHuRFqUKxa56i2P0G1qPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zocq7yfGbTzYHcG/8OtApMhRy8jzy2uGTHW6gAXZAEs=;
	b=otDMgA0L4h/sdBs/xPSemko8pkTCVqQXlj6NkZMDlJBTfajb0wipEkETEPELu673wfTr
	 lt2MBe6A11r6NPLW7vkE5vUV7copv0iVV3728WoaT4AiUjmchXC09RPXbNUKoTInTA1H6
	 VradOwVG0xzcel8IzfFgs7jva/mJEONGfeRuHrrmUycsjc+t4AlIEq69kqaIWEP9a0veQ
	 CKenuX/yhJUjBppZSnudBe0OSwpBxO9GoMjAEYzziOn6F8B9BdjdLviofDbabLraInmME
	 eZ8Lye6Js/MTtGPmnr0WTGkWF+Qu6qJTSnQENgGp4PXtg1QxZURwDasSeITzbq/v6pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qkyrvw4a;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC0606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 22:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36BC0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qkyrvw4a
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4395d31228so3305566b.1
        for <git@vger.kernel.org>; Thu, 05 Nov 2026 14:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793918144; x=1794522944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zocq7yfGbTzYHcG/8OtApMhRy8jzy2uGTHW6gAXZAEs=;
        b=Qkyrvw4aZp7ncgSwpoaUt420bDFZq3lugRHf7CI58gPd4xmmtOwpuo/d1fxh+3JbjJ
         x6ycW9+ypunvSox13gxqeQM/TSaQ2doSynW58U0hV3JQUa+aVcpngQVPir3qJ5vTAF8D
         7hr7d6+++yuS/DMRIcjgAntaB5/vQb/mdnFBm2eXABuP9eUJZ2e9N0h7IX9wWxh3Rr6y
         brwK6+FNBhiSRW+odSKP3cwbYG2yy76q42RiZRGeUZEVsSe01gwdd7PDwp9ksqnXMMih
         bEtKiqTERHqKvNtJ40ZCAAHfb6b95w+MPHUmtDIVkh/AD1qOlQLBl1mWdLVoIAXJaCgR
         y1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793918144; x=1794522944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zocq7yfGbTzYHcG/8OtApMhRy8jzy2uGTHW6gAXZAEs=;
        b=tg7gLV56k+/RmfCaBnGLqSUs8bY7mDFwZSwnFu72VTMU0mFieWcaFISUSwqJVE4wab
         01tJNV/T6IdTxRDx7kjmCOGVS5sGJPRom/hBlEtod24yw3GqNu5ISb2dednnjmIg+NSi
         LS11AlYVI3nTn+oNHdzGey67VbMEaEVMUY+LKP0YZcsxSPRAa0prAhR4GqXwkBrhVYZs
         Cp1jzWTOCkCLhduRXSAkV9haO00s33hrcBnxAVDW+3kj0lkbxBd5/DGIJ6lEgNxiP5+d
         eP9+cGybjXLrgWA3hJLyQPAtfGovNmFTUjqdhVzphydcxOxt3AL81XxEESdj5/gDaoIh
         uFXg==
X-Gm-Message-State: APuU4Z/lH8KyYXYqEXjZQGVb2yAVnCiRXrbo4fBOXnearjvWIFHUnl77
	2vUxA3+waVwSm+nZzqq6jTl6ESEyQlyXpoEOVOjGE/CiM6mtkKFBGYPDf01OWlW7
X-Gm-Gg: AYBFou169FIW3iNxP+yM59DpWvWzO24APSXbsRc/YDTCY8EwwTjE3zGId+UqYlw83fG
	kulCb1eUUkstVc/6JbeagTA7pL8tnzcSHz3Y6kw8l7tuDStVHBw3psNL1K0xbncE/mYb2/Zjj/W
	pdcEbpGN7sQaChmkioSng3dvAS6eekbc1kwU5O5pPUsyOcDKFGI5n5C6EBlxt31ZpAt/iDxF8g6
	3lg0w3tPwlpncHwqnDV6RP/6IDGE/cgAwkUbAxtM6Rnlw2RBg7VfVhNb97JZIGWlqep6Z1U/sF0
	qb2MxNaQEYfRwk64rHXKdu2+e+/b21qbncOIshxBHxF3r8/jlyH/02a9CbXPkZ6LXqJqhwo8gW6
	6LVBbfDgv9ahsWe5GLtATGDRj8UoiVMfuI1JFaTAMCu8hGa8sHdc1NazEzh2aJROJNLsMh3TBWA
	l8S/erROJDA7+xrH6puruiOnoL3/g4b1SfSBOuQheeALF4FD5WD9Avj9XII5/Qehg/IIMZmqakz
	sVA8TsqVFmbpExm5PxzhcLfk7tvYSQvXxCImZH3Ce6C1F+j96UcpG3zgoAEu3yV444VbZlVSQ+u
	YkEB0smsbQYVrnXaVSQJyOCBo/aD6FB49iVICDIMCf9alv9C48XEEUdGfuX+QsF4DWDQARaRKA6
	HiRNcfUKdBG0FU2jdi4ntZ0i7Il+jo4Jmf+HQ
X-Received: by 2002:a17:906:f044:b0:c2e:2baa:a642 with SMTP id a640c23a62f3a-c4d354cf6b2mr64160366b.30.1793918144427;
        Thu, 05 Nov 2026 14:35:44 -0800 (PST)
Received: from HP ([105.163.158.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3569e638sm23826666b.48.2026.11.05.14.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 14:35:43 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	herroyalpriestess@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH v5 3/3] t0012: catch builtins that keep NO_PARSEOPT after conversion
Date: Fri,  6 Nov 2026 01:34:58 +0300
Message-ID: <20261105223458.1534785-3-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.388.g09a996e1ff
In-Reply-To: <20261105223458.1534785-1-tangajoris@gmail.com>
References: <20261105003914.708836-1-tangajoris@gmail.com>
 <20261105223458.1534785-1-tangajoris@gmail.com>
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

When a builtin is converted to parse-options, the NO_PARSEOPT flag in
git.c has to be removed by hand. No test checks this. The previous
commit removes the flag from four builtins where it was left behind.

Add a test that runs "git <cmd> --git-completion-helper" for every
builtin left out of "git --list-cmds=parseopt". The test fails if the
command prints an option starting with "--". Without the previous
commit, it fails for diff-pairs, fast-import and patch-id.

The test skips diff, diff-files, diff-index, diff-tree and rev-list,
because they print the diff options. It also skips rev-parse, because
it prints the argument back. It does not catch var, because var only
has short options (like -l) and the helper only lists long options.

Suggested-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
 t/t0012-help.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index b0a3fdbbbc..41197c67e2 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -267,4 +267,29 @@ do
 	'
 done <builtins
 
+test_expect_success 'generate list of builtins without parse-options' '
+	git --list-cmds=parseopt >parseopt &&
+	tr " " "\n" <parseopt | sort >sorted-parseopt &&
+	sort builtins >sorted-builtins &&
+	comm -23 sorted-builtins sorted-parseopt >no-parseopt
+'
+
+while read builtin
+do
+	case "$builtin" in
+	# these answer with the diff options
+	diff|diff-files|diff-index|diff-tree|rev-list)
+		continue ;;
+	# rev-parse prints unknown arguments back
+	rev-parse)
+		continue ;;
+	esac
+
+	test_expect_success "$builtin does not answer --git-completion-helper" '
+		test_might_fail git $builtin --git-completion-helper \
+			</dev/null >output 2>/dev/null &&
+		test_grep ! "^--" output
+	'
+done <no-parseopt
+
 test_done
-- 
2.43.0

