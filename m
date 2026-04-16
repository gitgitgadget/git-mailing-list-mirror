Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706537107F
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776382604; cv=none; b=gUFF80ka9cIv1SzZEa3l1iN9nsCTZlMV2E3GTYxTqn3XEjOvg+JaHmH2HnIpmmvz5Fr3plGpWBuH9UeInjUX37egoSLAPcGrn5F/LRcFWV4MEyRk003ge/5fKZsus2kdthv9gG7NLDk2gpcTzPHdpItEC2Th6X5TYqSKe83PBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776382604; c=relaxed/simple;
	bh=EXiJV23psHzG0lRSk7aR9ynx1MX5xmZ9uJ8AzmSaIVA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=pvEJCX79m8GxUCOyL7m00oz1/bfhksdaloiHn6pC/AOWpBqRxz0qvvZd/ssg97kH5BD94ilxNK+qDpRn0p5V6hT/3cqDH8xuWcSftqmbfoJJ0XHooxVd/z+Nu+HAok65EhxhuMBrwe1OkujHoMAQnHFstUhg1EwgAYu//KC0e1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgW02cHo; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgW02cHo"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d9916deb14so167292eec.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776382600; x=1776987400; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiUpbC8rtmbOfU/i1xNZeRIOKkgwgdTE9jq2xyvhZXQ=;
        b=EgW02cHoRWraWLBO0UnsHRIR7ACsMCzLQT0jnJ+7t8reSv5iLgMnsIbtmyUFOhZy5n
         ALOgO9qLUCxc5N9Rn8iXU1Yjht+XDJPFtBXC6lHfU8I6+MaGd+nlZpYW1Nts8IjHmnHu
         khgW8zkpU/OxJP/IorugxTruKDIUWfIliU/0vOs2DlpwxHTXh1/SCLemUs1hq1xTSFaU
         8/CpYYWPB9OQgSp8ScErPrVuC+VeXcmzUeh/PXSKb9tkYOB3fYGILj4g23udVK9gHHVx
         STwEk5hw6uxmoUQWEy7U2uSIDnunUEC+CBlq0LkixQ3sUK7nvN13mkkPA396l+9lcq7V
         nsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776382600; x=1776987400;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TiUpbC8rtmbOfU/i1xNZeRIOKkgwgdTE9jq2xyvhZXQ=;
        b=rRScu+NWej3XjF9Q5Pv6jB/b3vm53yuZHBRFSolD7LoUGq953XA6a8VXfZRhucZpj6
         r2d7dcUOTPZ87na6cDRHOF+OfCJ06KSPR9S2bIrK8+UEpM7CAYVBOhaEhS2aLEuRMAM8
         pch6bX+Fkm0G7qgFg/OTz/fbKhpgEdnTPohrDbXIHmBSecsdASRKjZkcCLvDFPLm2xZ3
         t2TZ1UKq1nuVRBkyq6oqDJyCqn06+qWMseocbFLFbPJp++4FCUqG9ay5JtFG2hUj3wCq
         zpyZMLIplmkS+msypoEZJuiacdabfTC6ybaMg45RFT1k5+Gi8Iq1pVv3LQddEwXhOTW9
         i5XA==
X-Gm-Message-State: AOJu0YzJQseX7nnbboN2s2IZoKX2tHeMfNuYwjFmBTCDjL6bz6EU43cm
	UBQ0+9sLeor+t2Kt+Fk+MLPR8PehTQjY3rHJiDJte5jndtGRNjKpVdujVzCV2Q==
X-Gm-Gg: AeBDieslgLfvfnniakPEgPOKm0L6mhVrUPDA9H2hK7rRjdIVQlUxY1yDM5rFeUdm4Ao
	4cibfFfpwj+gb4FPUR6J304HXMEPpIvP9MvHDoFADPgaBNNAcL/Jy98CV5zeenXAXTjwnWVGQyi
	IM6CMMcx0aDt4oyhLKSp+qhL6jHq3YHt5R0yShY6M6+c1531Ot2PXypaZ970Xlw+1Ivrzsov0+d
	gJLAN0vjqyXIju4ymTx1ui+Tyg/TkBhjdiLqmK3FN0ckCJxlm7qBvc+66qJZg3yyXmuZBiHum3D
	8Jf/vQ0+uogWSMJ9OkERg3e/8b8U4Q0s3UOy54nsdtRGRF00M8W5MI3SQPgUyDkFmFQYj5ryvgD
	zIyigEbhDP3pdLkDlQdrxk9aGIK7ezFewPfXE0VAWMa5ji3KZdJJZH7q4Fo+n7aA2sielR7rGNO
	Q7OjMnWugrhO+rUnsnLD1fl4aLTFa7JT9/88A=
X-Received: by 2002:a05:7300:2203:b0:2dd:6937:79d1 with SMTP id 5a478bee46e88-2e47972451dmr225265eec.15.1776382600009;
        Thu, 16 Apr 2026 16:36:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.51.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e4c3f4f762sm197531eec.5.2026.04.16.16.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 16:36:39 -0700 (PDT)
Message-Id: <93e1556bd86a55501f6894f22d2c1b47fe464dba.1776382591.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
References: <pull.2092.git.1776382591.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 23:36:30 +0000
Subject: [PATCH 5/6] doc: fix singular/plural mismatch in git-rerere
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

conflict -> conflicts

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-rerere.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
index 99f967b7a4..4e6ab9a27c 100644
--- a/Documentation/git-rerere.adoc
+++ b/Documentation/git-rerere.adoc
@@ -44,7 +44,7 @@ will automatically invoke this command.
 'forget' <pathspec>::
 
 Reset the conflict resolutions which rerere has recorded for the current
-conflict in paths that match <pathspec>.
+conflicts in paths that match <pathspec>.
 
 'diff'::
 
-- 
gitgitgadget

