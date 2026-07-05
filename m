Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE7E36CE10
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239894; cv=none; b=R50mY/RvVqsVbdcKDKv/P9sVTSH8jqsNCIb0GV/lFjwLNxp1RU3NzVRqvYLARP5bYHyuJ4Paw8/UlXzgfLPQP3eG7x9FwjwyKr/98aCNnz1dlU2bLrrPEE5Rb3TwdBe1dUfKfeG54uwvydAXY3J+EE+N4w+JUvLeFqrTHR2FgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239894; c=relaxed/simple;
	bh=DdLrBEAnjUn0qzAG3UTaDRp8jRJaZ5CpNIericlIy7U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cgCrRhstiaXnSFDDGbGgI4pc3ZuZns5xn3mlgG5BmgnnYejFC0JUcS5DxuDwnFKyx+Ey1WOvjgKci5NQs2XESpDqkgVYKd9/L/9AfQvZMlYcdciU7wevdGRd/7Oh7pdkinX59h0vaJii4+dutuKb/B3LmBBtGqZm1s1QGT9ftg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfLf7cAE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfLf7cAE"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8f0e5e36912so11757206d6.2
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239892; x=1783844692; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FcPImijrp/FJoVvHN1JYuK9O7gj2NKEMm9XH/ybNafU=;
        b=KfLf7cAESnRih2yW3rYggR3n0lFT4aI6boWpTye136CNJObQwfCv/s4RGEKIKJ+gIc
         IM0C4973pFc9o01AhpH50454YP4IYnhyJ4lSvWZGNLHWtkroVUwxSMvPxatc0kiMrs8Y
         h2JoD/VNJkRbpLynuZKg6w/MhWr9qN7zSPzDy7kvr+riN0iSZKXS17T9ddf8N5Nsh0i2
         VH4eQVU2Xg6vsfsaf4QAa1WgRVCm78yQqAY/73DOXmT/Qc7iXih2JyzlBEkxjiXExqRS
         oMIgzotaM++4I/XQpAciX/PJfjZCMwtvIA+knnvbO7O4bgSm3hX2z7yTz3PS9vQiXilh
         6n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239892; x=1783844692;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FcPImijrp/FJoVvHN1JYuK9O7gj2NKEMm9XH/ybNafU=;
        b=gZ27IfIKXOuI5TGbHgSDWJDy3IOaheTMXMwQBaWt8q4h2K7jynJFlKXqdItDa/QgdY
         NOcO9NnvvXxeZMIDDhivkipRyHXIe6sZP5pom3+4Ia7GH3xCXJBRCTeSIUMIURADgXHL
         HIkrVIQjUvUGfmtCBH7LyE/si2z8nmo+ssyqRLzPobjNspQJnlG8Ur6CnDbBX6DUgpUM
         HOnXfnP1LB9yPeOQOYf16zyDeNKed67zbfSMWTsb/kVjEYQPkybUKkOanCW6EM8Iap8Q
         mGnRaYpuE0mXwnuNkL369/NSNn30GYFuycedTCK9vaLakJxyW7KMDda7+qbtlQwXTfMZ
         PmfA==
X-Gm-Message-State: AOJu0Yzaeijtw9xoK0W+euF0ATI9vNej2AqSnmmSKLX98sXsleu9kR/S
	KuF7/0jReAXlLt3oaVeyKMLs2IYrcjhXmIClhjTB2zJ2OnxGBxkVP0PWy7R4kQ==
X-Gm-Gg: AfdE7cm9DnjCh8Bs+Nr24Vc0wAkGBdS1vDZKSUAEYSor+cGPak+dWK+5ZjUGH9jVph1
	yWDDIxQI4YL+hqQekl+IQ1I6m/A7aYDUlkyeDYtI3kMIxFOeDzEMYGpsAnufrHtT+xY7WuNoptx
	+mZAZ5hG1wKXhJfAiXJ0YWP8Y0h4X0+8gLJSfIT0ei7BgNKmWd/HQEqTghu2dTYyH1LN/vguvhI
	eWa9U162f/vwlKY/WjbnHQBpxyF5t5cPZws8CYAs5NafNg8btNgcrBBTvKpFCjrHxtQ7q7uU8fR
	61wPfepsU4EHIl1Ns9a46OeokvM7Eq6ryInXvPqvDewt3DJ0pEe3rbcbJ0pN0LSOTF3BWSSW7GU
	RLTJ0IYMGNIhZR5O6EJQhBtp3wxxVExPYhtqBx+7SrKpDCrHjIiqFiDj2w3TxcQu8l4FP+jdmWJ
	7A+PfS7iGLGVrUo4NcN9h9XzBmv6fG
X-Received: by 2002:a05:620a:4398:b0:915:9d08:94e1 with SMTP id af79cd13be357-92e9a43b335mr825303785a.46.1783239891793;
        Sun, 05 Jul 2026 01:24:51 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90c92634sm626327585a.27.2026.07.05.01.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:50 -0700 (PDT)
Message-Id: <13ecebcdee633689b861418a005cf4f64c190fb3.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:27 +0000
Subject: [PATCH v2 10/12] reftable/table: release filter on error path
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`reftable_table_refs_for_unindexed()` allocates a filtering_ref_iterator
and then calls `reftable_buf_add()` to populate its oid buffer. On
success ownership is transferred to the output iterator, but if
`reftable_buf_add()` fails, the goto-out cleanup only frees the table
iterator and walks away from both the filter allocation and the oid
buffer that `reftable_buf_add()` may have grown.

Release filter->oid and free filter alongside the existing table
iterator cleanup.

Reported by Coverity as CID 1671512 ("Resource leak").

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/table.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/reftable/table.c b/reftable/table.c
index 56362df0ed..d604ddebf4 100644
--- a/reftable/table.c
+++ b/reftable/table.c
@@ -709,6 +709,10 @@ out:
 		if (ti)
 			table_iter_close(ti);
 		reftable_free(ti);
+		if (filter) {
+			reftable_buf_release(&filter->oid);
+			reftable_free(filter);
+		}
 	}
 	return err;
 }
-- 
gitgitgadget

