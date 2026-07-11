Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91983C3BFF
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783785923; cv=none; b=q+l/T412urKv/Hu468XQoKRDc9QtiaOR7lcdixHSZ/UF96T10dlqMhWb0P2y9OBdKw0aIA50tAQSGJp+21qbifMgQcuuJS+yGY60v1m9A94p0HQLhPxZtqdwm8aVlznhETx9bpNi41vt9vCRBmsSGtGCqbCn7rXAU9HJB+ma4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783785923; c=relaxed/simple;
	bh=3MYSWRYW5jzuZK7T9wo3iUecN+8rdbABSFe0LyUi040=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvjXpEJTOyiSirtiJIwubQtusxUMTwIkvUQ8wBvvfcMZiAfdORnM5jxOglKXNUF43/UtGE0xFn5PwwYe7RToupoy26BOnccwYSbtbr0rjoxuDOCCgsfuZs2A4aOefGkGFgJFY1SfMur+kqngXFuL01Dc214/GUIPtoDQAy3IenU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Yk5tzjNU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Yk5tzjNU"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7dbcb505578so20055717b3.3
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 09:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1783785920; x=1784390720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EQ++60R7fRQPtVo6dAcqQVCl80km1jIE+HcDpCIU1Bw=;
        b=Yk5tzjNUORauUsFo96lJ9bLTiZZmTz6QZV7vqNAeL5+KLtcVJ9Dq9EEv9QQokPya5N
         bQh6JNbbK1N48pwkwZXvoLlDrnz/TuJnlAnIRbs3Vs/RFbB7Y2CTCSXTYzz3lPe8B69l
         yBkYOZi131IWw+rvp605SIcVkkYGim/nGk2dMfP2OZ33kXLKfbzU93NShhxoghN0nbyb
         NV/He8/JU5As4HLHQSY6wteOyXI6tfYP4ZBDW4SS3ZWHI01+/L6lWHLnFpvgZ6c1/Fwz
         6cCG7uthL+QoVyTr/avFNbQRdNmsLcmq5tSOqF7oXzNADSPHpFu+m4LR4r3xBMUCy/Bm
         aWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783785920; x=1784390720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EQ++60R7fRQPtVo6dAcqQVCl80km1jIE+HcDpCIU1Bw=;
        b=VZs5XSUjnt0g1BmPZ0jp4Kt0ZnGANNXDXf7RIJdSgNhe5GH0M+fscrkVBB8ZnIA666
         yvvgYeExUQcv1ynWUPtcE6yipK4KnV9Tv87NAwwYf+vp+n7EKH6HePPOCkyUl1YbIEhB
         3XlT7Ih9SxIdQMKYNVjKvSWMLZ2sK+xtMnt2993fmsHhRJQDykQ7CiWgDz6FLsM1+zh3
         +NYRrtqOwd6De6Zxb4ZlYP4AxyaK2N81/15CFkDHWPayL0VoA1fzmOHjxDe+nLhr5E9C
         Vxov3475u1xCsAgMKrqXBxLjMLF1fX4YLGO/b5zhX9gMfdL02SrP7z+U/13Ewkz5mQmX
         Sc4A==
X-Gm-Message-State: AOJu0Yx4fC0Cd0DJlUVeFhmWPm/Nw81Vn65+AeeFwHurL1Mi3hUWvsWo
	jAIt5Sw25ynYXW5jFqamjFVT+IGR95x+/51LnNN4ATewyyDZdbEu63smuNvCCOnSqV1L6AY4JPO
	00SQN
X-Gm-Gg: AfdE7clEf8eR/n/iW2t87WMFLetoIm4c3cA4eXUg2pJNIQQDKBlGjTSNh7rngKXJae9
	yPPnSzom08AGkUVt/2uWeyRFx3Cp258oxq/CvnRrrcf/wV8dMYOMTFu6OyD7Q6iTP4zX3ovFvy6
	jKUzFH5/xS8QHtEdF/dCXZBBn89Dn+x4dxMRdKoB3r29CRM5oWIS0t4j8jTO9QUd7CVJLtxxndv
	c0lh6K6+mfCF2peZhoLc0PtpBR3YHuhp7m8sfDFlWjtKzDcLfA8FkySZQ81rfvMqPWD8gz3K/zc
	G4FSDMf2tI3HlPYSa5YcRl/EI5jVsqRP/JcPNqZKwQ5FJ1EI54k2iP9RyBXzVLeBa1MpXXEOMOj
	N4A3ECAWylmDcuvmMRT1W4pzgVrJNkYtBGGQ1DGshXI6iLWiSxQTRbmOjobq35E9IzIMcvDTRuf
	Rcq1BbGl6qJw/RoIgmYkA+UxsXf75bxJG2J2nfsNwmU/prCUT0o2FpUY5WQxzF
X-Received: by 2002:a05:690c:710a:b0:7fd:e030:23db with SMTP id 00721157ae682-81e900915ffmr21872557b3.31.1783785919744;
        Sat, 11 Jul 2026 09:05:19 -0700 (PDT)
Received: from avocado.meuintelbras.local ([187.10.85.73])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e950567eesm12606787b3.13.2026.07.11.09.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 09:05:19 -0700 (PDT)
From: Marcelo Machado Lage <marcelomlage@usp.br>
To: git@vger.kernel.org
Cc: Marcelo Machado Lage <marcelomlage@usp.br>,
	Vinicius Lira de Freitas <vinilira@usp.br>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] t9811: break long && chains into multiple lines
Date: Sat, 11 Jul 2026 13:04:46 -0300
Message-Id: <20260711160447.99708-2-marcelomlage@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711160447.99708-1-marcelomlage@usp.br>
References: <20260702140704.65805-1-marcelomlage@usp.br>
 <20260711160447.99708-1-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rewrite single-line && chains by breaking them into multiple lines.

Co-authored-by: Vinicius Lira de Freitas <vinilira@usp.br>
Signed-off-by: Vinicius Lira de Freitas <vinilira@usp.br>
Signed-off-by: Marcelo Machado Lage <marcelomlage@usp.br>
---
 t/t9811-git-p4-label-import.sh | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import.sh
index 7614dfbd95..072bc88210 100755
--- a/t/t9811-git-p4-label-import.sh
+++ b/t/t9811-git-p4-label-import.sh
@@ -64,7 +64,9 @@ test_expect_success 'basic p4 labels' '
 		git checkout TAG_F1_ONLY &&
 		! test -f f2 &&
 		git checkout TAG_WITH\$_SHELL_CHAR &&
-		test -f f1 && test -f f2 && test -f file_with_\$metachar &&
+		test -f f1 &&
+		test -f f2 &&
+		test -f file_with_\$metachar &&
 
 		git show TAG_LONG_LABEL | grep -q "A Label second line"
 	)
@@ -231,17 +233,25 @@ test_expect_success 'importing labels with missing revisions' '
 		P4CLIENT=missing-revision &&
 		client_view "//depot/missing-revision/... //missing-revision/..." &&
 		cd "$cli" &&
-		>f1 && p4 add f1 && p4 submit -d "start" &&
+		>f1 && 
+		p4 add f1 &&
+		p4 submit -d "start" &&
 
 		p4 tag -l TAG_S0 ... &&
 
-		>f2 && p4 add f2 && p4 submit -d "second" &&
+		>f2 &&
+		p4 add f2 &&
+		p4 submit -d "second" &&
 
 		startrev=$(p4_head_revision //depot/missing-revision/...) &&
 
-		>f3 && p4 add f3 && p4 submit -d "third" &&
+		>f3 &&
+		p4 add f3 &&
+		p4 submit -d "third" &&
 
-		p4 edit f2 && date >f2 && p4 submit -d "change" f2 &&
+		p4 edit f2 &&
+		date >f2 &&
+		p4 submit -d "change" f2 &&
 
 		endrev=$(p4_head_revision //depot/missing-revision/...) &&
 
-- 
2.34.1

