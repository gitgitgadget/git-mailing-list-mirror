Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE928339719
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621405; cv=none; b=jCnHK9FwnmfjLIZWpJT9nfwvFptw38SHyUzNgaYx6qnPvTOh3Y8KqySM5cxqk1MxkmunWTvjvgLnfatjrlwI+ywjLAYajHJrL0Umg1kx2S6RHGgy6/GxdSq2jY+G3x3jL2DayDTAf6uwDIJ40yoC3RLy8z3Zx+SypDZvkordEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621405; c=relaxed/simple;
	bh=hsRDD0kDtVFLor+ZsgPzabzYIDE2jsDOLm/rGIoI2SU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QMKoviFr5k4u7Lk9k1yMQ3vtct8uOYKH446lNpSzetAKvtshWsAgDcf3HShvUHHJjHtdb36owIcb/7Vu5CuV92Sr223xJsl9zIGr4k9zduON3ZIWasXlEB+tmm1+BjQ95o1/It/guPi9hN8DlsR8oBf+Cs8i2eEibGsbm8ltqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goL+0zTK; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goL+0zTK"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51761d27612so55661141cf.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 07:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781621403; x=1782226203; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCBWhPr67l0pTXFnTG+XjOKPJgRBbQgk6RbnLQarnd0=;
        b=goL+0zTK5TgmNYHAwroe2m399mJsTalfXn+zjr45rBGzUPKHp+tscVD1unmKD1TM7e
         r+KtRtL+MKwK/0nXxy2aSXx3y3BjHHqyyASJu++reoWSSZobU7F7yB5J1neNSBt7rcC/
         CX9u1iDvuROLNz1u62h+zrVHLw2SPPcyKQZUoXcrXUFY+A5R57m1cTA8Ue+M8d60Dx9a
         /QS/mUrhG5PELwY6/9eKLtbqW8K7JPdjow+4RhEITXGpDuYA5LoBwOabmZMUwM0mbpGp
         msKZNzPPdwwkjIs5gu0aqqujJMX6RSbqmsLkQLPNidFUi75nGHsnSYEjRO0EfTOEVK2A
         3yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621403; x=1782226203;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PCBWhPr67l0pTXFnTG+XjOKPJgRBbQgk6RbnLQarnd0=;
        b=SxO4cFanFalSY9q9rFWhI2AnGHGjQqyymiaAKpNkueImPFSwJo3vlIqPvGKuEQTAxs
         eFPqW4P7kzLdyy9+4wFKldjBkHQvhsckUlwTMa/BQm8LE0LGnWij7IweZ0y3+3wDDJGR
         /P90aNLZlyy2/4ThijOImFofbPT9sQuz0/WFVDA38hFAL4+HIMmb0iMYzDNS3/Ik21gv
         n33NuoZFIzKsTZMF7ct8s44oz1tVprTDNvd07X0XBNVa14I52iMVkKmNb/BBqMoJPVvg
         CJf47yB3FdYbW3Np9zlMC08wTxZ3rsju8mMJSD6c4R4zGhBnyYHgrRdtw3EDStxFiga9
         6mvA==
X-Gm-Message-State: AOJu0YzGRQqMY9JCZ43jOzHMCj3r1mmZ9QO2zlnWfzWZFp2ZFHPZDWh9
	B/Kp2y66Ef8oyRf1So07PruWfD6iZhE5vaYIV41wy2rDFTCvCmrDuxXC6y/HVQ==
X-Gm-Gg: Acq92OE0Kd9ME7/X+r0t3DGgk3iAMAblltAnOgOnU0gHMTBZI4cItsNPuUNpxoPynMP
	07SC63qFEVcaSpoL3O+xFn37yBMFY6rEnYYG6lS6bBJJY1yNMMBPuU/4sTwk0oxzsT2ZOxgJD0b
	uiAPQwPq01opAAWXHYG2bCrH4YEZHTxxqscq37pTKfdsKaY7CkuDiz5nmVnep7tFplb27amsYky
	NDRyX/ZnQMnj1XWeWImj/NJk43LGVHByH1EjfaGD50DO+hCMFhSecS0yZd8uSmHyAHdSJLS1tpX
	0VINRA1vt0MEPiDNRnq3sqCVPkaTAQLqiOXOuDMvlGcCeoL5MGYfzIc6wddrMCcT0EhAv9AkwRY
	kv/oEVlkat0+HsiaOOFl8juYO8drs8QFsXznnuygXd6HC2zrG15H0d3JvAmXbDR1Q2luOlSXhB2
	gKLAhyDOI6LqbF92x7R7SFBcNRvg==
X-Received: by 2002:ac8:5909:0:b0:516:d95f:bf33 with SMTP id d75a77b69052e-51991a91b71mr54674811cf.50.1781621402110;
        Tue, 16 Jun 2026 07:50:02 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.77.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f4557d43sm34310946d6.31.2026.06.16.07.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:50:01 -0700 (PDT)
Message-Id: <9c01bac407034c6361dc54af7f11f64e8af7db0e.1781621398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
References: <pull.2138.git.1780593313.gitgitgadget@gmail.com>
	<pull.2138.v2.git.1781621398.gitgitgadget@gmail.com>
From: "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Jun 2026 14:49:52 +0000
Subject: [PATCH v2 1/6] hash-object: demonstrate a >4GB/LLP64 problem
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
Cc: Philip Oakley <philipoakley@iee.email>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Philip Oakley <philipoakley@iee.email>

From: Philip Oakley <philipoakley@iee.email>

On LLP64 systems, such as Windows, the size of `long`, `int`, etc. is
only 32 bits (for backward compatibility). Git's use of `unsigned long`
for file memory sizes in many places, rather than size_t, limits the
handling of large files on LLP64 systems (commonly given as `>4GB`).

Provide a minimum test for handling a >4GB file. The `hash-object`
command, with the  `--literally` and without `-w` option avoids
writing the object, either loose or packed. This avoids the code paths
hitting the `bigFileThreshold` config test code, the zlib code, and the
pack code.

Subsequent patches will walk the test's call chain, converting types to
`size_t` (which is larger in LLP64 data models) where appropriate.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1007-hash-object.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index de076293b6..7867fd1dbf 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -49,6 +49,9 @@ test_expect_success 'setup' '
 
 	example sha1:ddd3f836d3e3fbb7ae289aa9ae83536f76956399
 	example sha256:b44fe1fe65589848253737db859bd490453510719d7424daab03daf0767b85ae
+
+	large5GB sha1:0be2be10a4c8764f32c4bf372a98edc731a4b204
+	large5GB sha256:dc18ca621300c8d3cfa505a275641ebab00de189859e022a975056882d313e64
 	EOF
 '
 
@@ -258,4 +261,12 @@ test_expect_success '--stdin outside of repository (uses default hash)' '
 	test_cmp expect actual
 '
 
+test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+		'files over 4GB hash literally' '
+	test-tool genzeros $((5*1024*1024*1024)) >big &&
+	test_oid large5GB >expect &&
+	git hash-object --stdin --literally <big >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

