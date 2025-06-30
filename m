Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224543AA8
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751315547; cv=none; b=qKxJmxcTXyhVHa0BNRYcCR48ZEDxRjFHTvQPb7yo2v+uB9rcAo9+IV+yFCezcZV24Wy0YQepayjoAw9/jJOcoy5ZAEc8tWsvmAN3YFw2Ea1zgJk1XgUKUbUC8PJa/UVA4vXu25OLRuVk3Vb50N2fMUP0IYz3kg8NHsrE2dqklBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751315547; c=relaxed/simple;
	bh=SlSIJGSeonMJ8mvbvH39MXKJcIKyZSEPbbOSwisVncw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uSfxd8CH1p7KNX89fI4tybqMkXpuMBifOCb7IQKOcjBzTZTqkIJj3gpTFg5FbwCc3jbPeNgqghYvLc4gpFkOm/H/AgRKo3gxdYM6beIPU7v2XwlF8E9ih16+Wp+w5zVGpaNX8cFa3kvxfmQ19PDNImrlRU8sutg//ueck0eaXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSRLGp+G; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSRLGp+G"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234f17910d8so46543085ad.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 13:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751315544; x=1751920344; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6L+r6P0ATwYqb+oe9QANYz/9QSgo7u/pC29yBiiNdSo=;
        b=KSRLGp+GzCAMC9nNLJzivhJjPifk131/KA8rvRdR2qX0uu84kJCPWEvcnseIG6SKbU
         MsElHZ8QitBunduxVZW5CBxArOj+NGDlHL4KbIL5UDvGbOqc2Wc7yCKTBCIX2pnLbb7M
         fZkNbaujKIBN2u6J7ByGMppito99nNgyv/61eojwTYkqH7WtGnRuwJQrRJGROvSRWG9K
         qex9MstXIZoTJl0KKdqyLhQ9Q7ghl1xa/xHabmQnGipmvw91T/Y7KOxlU71oNelXozaX
         mdHpi6JV9Hg5GEqzbm4JozOBPmi4CjSJrSqRcALbDJZBkOKewv05jEXz2VJDTfHO+YYc
         No2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751315544; x=1751920344;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6L+r6P0ATwYqb+oe9QANYz/9QSgo7u/pC29yBiiNdSo=;
        b=SmaQaxqC+siP863KC0XrkSJWJxcbT9ACBza9am1PqokNAUPOMPzpOujNRyGBbw8GPS
         9O39EkdUbyMykMrVTidY18RYUZvE+xTl4QQBsuIj8FPFvgsVF1btKF5Nj8L8LAWxjBfk
         bMvobK1wiTloRpOgruByXJzYvINABQXq2/LfrOiV8SrwUaFk05miTOYbx9+EO/RJQ2oq
         flTyDuhGI45ZkWDt2qNNYpM8Mi9193OVDbgmTb5HpCmEezeMvhJUpBnW71HhWm7GJAXw
         kISntDEhu2TqTCyZNxsGH/8wVKz/sqCb+HBmc9fyR6cpNHGII85M6M2nTvttdrSDyntn
         9gzg==
X-Gm-Message-State: AOJu0YzJW+3FRHNL58dD5ZboZVo/TOU6fnSMgAlUnuKXIoJ2X2ngO5SS
	wlB6gacdepsdr63co/MoxfFc04m6jUIl3Qp6Yg8hvkIsR3Dj95iSWm3ucb5+tA==
X-Gm-Gg: ASbGnct3M71A0V4o9002S1njyq+ZU5ASWSpHZ+yXYCFueAxxwT22VfpNJrwlQpdNOYP
	8U+rLCTLBZ55e347sum546ACtT4SRH0CwC9L/8bxZCwUcay1jJwP6STeKeMavPv7r/RGjmvCvxZ
	L0FLhe4HMRsTB49sI6h38b6reW6pE5EbE22DZPlZjVuqcIrA+6/K83z01LT4DRPC/8mrAg0BhIJ
	fpvCN0pEas9hOkStDR72M2+lcA6yD9DrZPHsz+DpFbaaWX2RGwWK0RghsVQujUKPgtZZ3zWXVTd
	cojQ2YK73cDgKgnEPtGjixuZZjcUKPS1u1NeViE+00OHlvSEqnYfgBeEbap5obf68EunrWxjwJV
	v4N7wp0+kwNO81h3Kyos8k/KCblg=
X-Google-Smtp-Source: AGHT+IHIeR/opYcZc/Dv/eKknfn9poucInMp9k1m9h17rhYhnwR3jgdMS4PRmu4LioX1FajuJrUf+g==
X-Received: by 2002:a17:903:1aed:b0:236:6fbb:a5f3 with SMTP id d9443c01a7336-23ac4893e96mr257047005ad.40.1751315544131;
        Mon, 30 Jun 2025 13:32:24 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb2e1a8asm91959185ad.47.2025.06.30.13.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 13:32:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Git PLC <git@sfconservancy.org>
Subject: [RFC/PATCH] SubmittingPatches: forbid use of genAI to generate changes
Date: Mon, 30 Jun 2025 13:32:22 -0700
Message-ID: <xmqqcyalm0mh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Following the example set by QEMU folks, let's explicitly forbid use
of genAI tools until the copyright and license situations become
more clear.  Here is what QEMU folks say in their commit to adopt
such a rule:

    The DCO requires contributors to assert they have the right to
    contribute under the designated project license. Given the lack
    of consensus on the licensing of AI code generator output, it is
    not considered credible to assert compliance with the DCO clause
    (b) or (c) where a patch includes such generated code.

and it applies equally well to ours.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index 958e3cc3d5..63fd10ce39 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -439,6 +439,23 @@ highlighted above.
 Only capitalize the very first letter of the trailer, i.e. favor
 "Signed-off-by" over "Signed-Off-By" and "Acked-by:" over "Acked-By".
 
+
+[[ai]]
+=== Use of AI content generators
+
+This project requires that contributors certify that their
+contributions are made under Developer's Certificate of Origin 1.1,
+which in turn means that contributors must understand the full
+provenance of what they are contributing.  With AI content generators,
+the copyright or license status of their output is ill-defined, without
+any generally accepted legal foundation.
+
+Hence, the project asks that contributors refrain from using AI content
+generators on changes that are submitted to the project.
+Contributions in which use of AI is either known or suspected may not
+be accepted.
+
+
 [[git-tools]]
 === Generate your patch using Git tools out of your commits.
 
