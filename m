Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C584CE04
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712878351; cv=none; b=HgvimcnnlF0YuWhjzAauvPs5C4ulTb61R9E91HsnviCErHU67VfbyIiUnkovljcS8Gd6KcmUFrTY3VNghfZqeNi5MNRZqKltqXi0XOaU6Uzh/g2wfYytHs/CTw5WWYlwajSngo+ns8GVigTug3xwPEdieYBTaTdOK8DITEJgjh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712878351; c=relaxed/simple;
	bh=Kz99GogLEhZHQLY/eZCIt8qbiH76jvagkjpGYXJisR0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LBbAp6AJFzjg7YbHtnkBc9oOvqHqUeA9iJwlmeNLhZPr0g5lcW4I1KAdRQc+E6a5krZ63RGE4kAq4e9UgKUd1uZA947ZVYrpFTIr/YeOcL+Jcit6dtYW0oNLGpPW+aRmjFI19Gxt8KELajs+DD0od0g+54IDRer2y0VdlIRTcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXWLJ+GX; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXWLJ+GX"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d094bc2244so3315181fa.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712878348; x=1713483148; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cujYfvsf9Q2v8mchqaD3KzHFDOWtn09nJSffrZKYfk=;
        b=IXWLJ+GXyT8NIRHOEo5fxMldVfL75D2FaQXeDRyGrPG0eH/BrxiQ3d01O7HvEHeMJL
         cBNIA84pknszCDzInZ99igwvBvGHX+SZosChw6Q6K3XH8Ntq7fo2MwFbIarQBTKhH1Lv
         +nAWagiRDf1cI6t+KN33O0+rUjpEXglWNaRJAOTcE1wG3E4yYqM/bxMNJU3dHIFXBOmh
         cMVfhHAE3HTFZyiPWVeDC9VJRnOVMysCTTJZOSih3kDhELquXhPEbyqgaXRuIAitomhs
         XEotLbCklA94V5Vi7JlArIXFsn4aNrz1JoK5kNsuXnzAwK2lAc5C3zbqpEThHW2hJ8yF
         dB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712878348; x=1713483148;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cujYfvsf9Q2v8mchqaD3KzHFDOWtn09nJSffrZKYfk=;
        b=CP6Moqxjhs8nmdwOORH0E/X/q51fOk57FxPiQo0/J2I+9k4tBfmy5infSM55+6fAnI
         2ksg/0Eqm+W089Kp5HJyYnaL79108vzTtWfQKJr1PMXKmI9mW/fYcGvPX5ynkiv6fdCy
         ZRR8Kj7VYKemOPe9yFbRTR2eMNapmHp2MvjG8hoa7t9GHctdYE3JmWjkyr3SBsxN2J6W
         yNs1mnl6iPI1IpM3bv9xc80Nngwno/zAARpueUeYHlZcLSqpfADVDmE0Xr5h45gpxGQw
         oUZayjjggXztPf2PxOYBigFDa/mxs1A29QJPyrDiEzIQ/nt4Q7YrJxOE8q+HH2bRalRx
         1dJg==
X-Gm-Message-State: AOJu0YzEu6gADcG/A9xcw/KG0qaDMy/rVVbtfcaGbRK75B1NIvKOBPU9
	rO24P9ZW84/3NU2EFgO7TcLayjN6Ng5dZaYPkOQSIgW9OKPXB0XBC3aY8w==
X-Google-Smtp-Source: AGHT+IEToDCMMmTPEZpWwiZdE9H2HhhRDh5xbfdcJ+U6gtJY+wgEUzQrSG2BlIsRe4qTVVTjahKPaQ==
X-Received: by 2002:a05:651c:484:b0:2d8:4af7:1235 with SMTP id s4-20020a05651c048400b002d84af71235mr445217ljc.44.1712878347702;
        Thu, 11 Apr 2024 16:32:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b004163ee3922csm6947200wms.38.2024.04.11.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 16:32:26 -0700 (PDT)
Message-Id: <e889e64bd45f43c1a18fb121ebbef1f2b82fe2de.1712878339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
References: <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com>
	<pull.1704.v4.git.1712878339.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 11 Apr 2024 23:32:17 +0000
Subject: [PATCH v4 6/8] SubmittingPatches: dedupe discussion of security
 patches
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
Cc: Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Jonathan Tan <jonathantanmy@google.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matthieu Moy <git@matthieu-moy.fr>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Kipras Melnikovas <kipras@kipras.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 8805579a36e..ecc1622c8bf 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -399,12 +399,11 @@ letter.
 
 ==== Choosing your reviewers
 
-:security-ml-ref: footnoteref:[security-ml]
+:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
 
-As mentioned at the beginning of the section, patches that may be
-security relevant should not be submitted to the public mailing list
-mentioned below, but should instead be sent privately to the Git
-Security mailing list{security-ml-ref}.
+NOTE: Patches that may be
+security relevant should be submitted privately to the Git Security
+mailing list{security-ml}, instead of the public mailing list.
 
 :contrib-scripts: footnoteref:[contrib-scripts,Scripts under `contrib/` are not +
 part of the core `git` binary and must be called separately. Consult your +
@@ -434,12 +433,6 @@ Do not forget to add trailers such as `Acked-by:`, `Reviewed-by:` and
 `Tested-by:` lines as necessary to credit people who helped your
 patch, and "cc:" them when sending such a final version for inclusion.
 
-:security-ml: footnoteref:[security-ml,The Git Security mailing list: git-security@googlegroups.com]
-
-Before sending any patches, please note that patches that may be
-security relevant should be submitted privately to the Git Security
-mailing list{security-ml}, instead of the public mailing list.
-
 Learn to use `format-patch` and `send-email` if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
 your existing e-mail client (often optimized for "multipart/*" MIME
-- 
gitgitgadget

