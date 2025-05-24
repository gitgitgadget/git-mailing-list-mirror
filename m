Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295911804A
	for <git@vger.kernel.org>; Sat, 24 May 2025 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748071869; cv=none; b=I5BdeUNufqc1glVq2n59P8ocuNSf2I0x5DMBnG24gHyFineDAKsX6+kp9GWzSxRmPVdV2cBbJji4dpTqZlOhaN2bqzbIE68wAsiR+E7AJ3Mi/ygoIeuvmrmKnRtA9117yfC5Cp0DyFhApb6WttaBfZxFvTqt3mJxFs4AinIs0Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748071869; c=relaxed/simple;
	bh=RJkah9mCA4aqNQas0hRZXrEjvqQqUOdZrpMo0CAxN1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdeScaVtTYWjdDTQErdPKpF/O3JcsxFtAeEQXL72cWuIyqOkqX8PnTO4GSTGsmyITf2hAHy40Ruz9SL8ZMRqETU+wx6Lhkm2eZVjKhkDg5zIpP0D0dKKyGNgWchM94S7bP8efFiTl61ljebRpCZn9JdCsE6vTDUlsh/9Erf2yEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pu2ynxds; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pu2ynxds"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-af6a315b491so470357a12.1
        for <git@vger.kernel.org>; Sat, 24 May 2025 00:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748071867; x=1748676667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CUVMFwrZQb8Z9BUDGox7Gg47gBniAPr90iRDg0fNss=;
        b=Pu2ynxdstWM+pX7rAG+1cpl8ZPyA0H3M/F0kX37JF8ox8AotRqFNhyYNdVKpujYmfE
         tvnU0QMPfXU8ZvNIQE8qCvg4skh9buApYdPQS2r6t4j6UQC+A+KB6hf2kDQFmRjCB4L3
         1f2sCq+18mc+Hhw97jIaa6EFcilzleXlB1vrTPAW1ad8F80yXfvobR5/2/RGRIgpRCnN
         AWDyKBgJ4kLGdNBryx3j1Blva8p1taA0bIFqMPIY2arz+xjMgVAr3MkV3tHAs2Z3KdGJ
         Xwqj3Tipp1WwBUE2rlt4r353+xNrnZWe2gioeIhmhZlGEDP5ls092ifr6k5qtallG3Kj
         PPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748071867; x=1748676667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/CUVMFwrZQb8Z9BUDGox7Gg47gBniAPr90iRDg0fNss=;
        b=CC7IDOzRmWPkH4Kk3xBv93bD3ikJeqIB3pmVtz5VVACodh/ozmbUabXx9RP23dWlnl
         ZG71VZuwpO/jrPZ5DN+sBnvu4QCjaNcVov1KCIJGvfQSO1I+LO7//eNOmKoG4xLbqfGk
         vWifQXQGSkOMR9qGiHAfYBDSNhfKO0+l+kaGa5k1oaS+hBofVS39pHTp0usWYSkS8BHp
         MSAvZsHiZ7VT+LPe6396MKJyLqnp+OZpzVad9K/knN/CcAfKUyDMph1ehI/k1HBL9AOH
         bsr/Yr6Z7cX+KvGYNmVTo7Swts+TgXOQ+drF6TxdMguo3gK1jl6SnVCNRjpys3IV6l/F
         UHIg==
X-Gm-Message-State: AOJu0YwgA9tIDXSDxrvqeJKPkoF25+NRsUFtF4dWr8bQkiGlepFVYrsX
	xfiBfzbFND5XZKamIqaUiHVXNsh5Q7XlrRyebK+aBFimYtKdYnbaLgCV
X-Gm-Gg: ASbGncsxd368Jqe4gozi/DcQ+CW+lNdv9KE+4TCr/n/ThwxxqCqyDxAE2Wsy7P5G5De
	Pzlyq10K9Ja2rDc1xIJq/u6cdaTmqIlAsm5d8/5HHjv0NVP12uM0HilgSzfVA62znAFeNF1XsGu
	654opaNx459xyTcsI8RbJIJ1y0udmgY9oi/mi7G6YIB3dteYQwyIqmiRPDFYEeyhwk2KTrF+OdD
	LGeVdohMVxgEYGUbltTWVgzdZXNPeKdwRHMnFkm1Hrp+8ZU/oo9wEDrBvhLKxr7YVuPtR8mn5Q4
	hwAaMQkuEfQ5oc9PByHTl8PbhKOJ2NWEXaGplkdZ6qM7Sphf8jbdowJf0UvuiNVQw7o=
X-Google-Smtp-Source: AGHT+IE6GQuZhhQlK//hvAovWYYTRHCmKXc2UR8w8AQMlJlNO5IoP/hzMXVljHvruOCstosrkunJNg==
X-Received: by 2002:a17:902:e807:b0:22e:50fa:50d6 with SMTP id d9443c01a7336-23414fb1934mr31611655ad.37.1748071867332;
        Sat, 24 May 2025 00:31:07 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23414e86538sm8737935ad.184.2025.05.24.00.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 May 2025 00:31:06 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	mlell08@gmail.com
Subject: [PATCH v7 0/2] Avoid submodule overwritten and skip redundant active entries
Date: Sat, 24 May 2025 13:00:53 +0530
Message-ID: <20250524073055.58092-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <CA+rGoLdbZvD_aMfB=J_cJay-4Ptgf+=R3es9vmdrsHkGhCtPmw@mail.gmail.com>
References: <CA+rGoLdbZvD_aMfB=J_cJay-4Ptgf+=R3es9vmdrsHkGhCtPmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of patch covers mainly two areas

1. The bug report where after submodule was moved and the path remained same
   when a new submodule was added then it directly was overwriting the 
   moved submodule as the present submodule since the path matched.

2. The configure_added_submodule was writing submodule.<name>.active
   entry, even when the new path is already matched by submodule.active
   patterns.

Below is a helper function and 2 new tests with fixes of the above problem.

V7 has added Tab spaces in the test rather than 4 spaces in V6

Junio C Hamano (1):
  The seventeenth batch

K Jayatheerth (1):
  submodule: prevent overwriting .gitmodules entry on path reuse

 Documentation/RelNotes/2.50.0.adoc | 19 +++++++++++++++++++
 builtin/submodule--helper.c        | 28 ++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh         | 23 +++++++++++++++++++++++
 3 files changed, 70 insertions(+)

-- 
2.49.GIT

