Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD219AD90
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736337839; cv=none; b=belBMNk16xHaoi7QlDVzAiZeqzAPdLUaRxJOUOCkw2MSLuLrlMGsMsKRvmTbKyuKTdLCHJOJbFzq5zyoEMzRx5aKxXaIglS5vl+WeOTQA52pc0Qai9FwNVoH+4sFbSWx3JDgfy604irIUkSiZYTLtuBFIopKTBcvaNKKx2eIgwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736337839; c=relaxed/simple;
	bh=P6ietmbyeX+QtYTzbtpCrK55NA6XxGCRtQBaQnzr0Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAhV9MwagQP8gmvxwNz4+UZUldMQr56mAMoXlcQCk7F4JjgS3HXS82lYv+Npb7S+sbfMhXTZ0Hvehx+MInjj3oept2H2vmU7FsVRjHRUTofeZoinUVw2pu7Pp4MrYcJeNxtzyw3pLbr+rlnKcw373dXNWprcnaw5fbB/miSgE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN+roxp2; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN+roxp2"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso601859a12.1
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 04:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736337836; x=1736942636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+M7QrCuYje8GW98nwmM2KiAabNS3qWttujgOFtsdiw=;
        b=lN+roxp2Ngzct47vI4TnPGhjSZ43CYt+YnOmhe6uoJs7LGUi27SIXTfPkN9bHVTJfQ
         u6gSsuHMFZRd2E9JQMZNFC3XWJMNzqXyaiqUlHOBzmpfq3dpelubd7XeebdJnT68XYcB
         INRvJBR/TUWoRGbYuyXDYES5wU5ppJpDjAfmgkvp6/lmiXSBx3ef4fmHkIBjuiyEgkxY
         33LWNKCs9MFgMZzCGVC2qqQNFe6dXxbON6zXhqbagD54gHAHFzkJ8/HAhXL9a7e8nXeJ
         FZlNzysp0RRIi4NBgs7MDBiQdJ1f7YPtDHcm1B4ecORzx4O1YHDaBhtEGweEPwtDnUbv
         BV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736337836; x=1736942636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+M7QrCuYje8GW98nwmM2KiAabNS3qWttujgOFtsdiw=;
        b=EEoTLgIzzbVGQaBpcNCUnUE3ql/oEkkl3j+PC2LbTPU+L0DyY37RZPkf6jfAbVPTEY
         subs1yuTLSCKg2VZleSIWKKvUre1WtpZSDQiuvvuM/RgTF2vx21Zi1IwMuRUxuJrrzqo
         Z5jCj0RtyI5fu20EwKBUmM0vNEbblpqWzKGjKT88GXimx5YhUwEJB2R3R2ojrF5kZLcP
         SJlGni07SW2/5SOLQ9gOT+JSN1EjIPFAPHt/uvqJJfTCkVLODni6sK6B/jVKIqTtV5SA
         l6CfeSdd/EpTJnsXwuQZD/hPMcrEyYMzf/a2RWiNMhEP69IHbQ5kO4jKEURa1JVBVCf1
         Pi2Q==
X-Gm-Message-State: AOJu0YxlpL+VbGhBSQRBdwEA1OwNseHGczWiWIkwxBCRX6eYOBthXU9e
	0W3XY5p6nmLDbKB6/t1HmD5Kpfbi3NDQF5r23+gg/Vwlu5nV73/B1/o6Ji0MjfHHdw==
X-Gm-Gg: ASbGncsCtL56nUW8cBYTHQFE4faZneG9WV3uNPno2QH8BC/4ubeb+KqCjDzmqRPiIO7
	nSDA/xFKSDFLMnuu/LsN+QmljJzpT0evU2cb7ECPWpdv4N1wiKwoLckTLvKCmBtKFOrp5LrFytE
	OsuAzJwXZzSvsAXZoDLry0X4IAhc1eUAnu422NK5ZTvlDK50O2FN7zmaQ6SCIqX0NviX2YMNkK/
	a7+baXTaJp2Rsf1VzeNOQiuXNrWQQ3Tr8jQIdh51xBr1AjC6jhOOtQpQTLZtABT4/EO
X-Google-Smtp-Source: AGHT+IHF346gtlxbUxNwN7BTeHqCoBrLT4N/6bTLGXYcqi+tVWsYF9tL021nTkcWyESSnHkBpQV+Dw==
X-Received: by 2002:a05:6402:5109:b0:5d3:f6cb:73e4 with SMTP id 4fb4d7f45d1cf-5d972e708f2mr1963861a12.34.1736337835550;
        Wed, 08 Jan 2025 04:03:55 -0800 (PST)
Received: from localhost.localdomain ([102.89.22.24])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5d80676f192sm25932961a12.35.2025.01.08.04.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 04:03:54 -0800 (PST)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH v2 0/1] t/unit-tests: convert hash to use clar test framework
Date: Wed,  8 Jan 2025 13:03:38 +0100
Message-ID: <20250108120339.225596-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
In-Reply-To: <20250107091932.126673-1-kuforiji98@gmail.com>
References: <20250107091932.126673-1-kuforiji98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This small patch series transitions the existing unit test file t-hash.c
to the Clar testing framework. This change is part of our ongoing effort
to standardize our testing approach and enhance maintainability.

changes in v2:
- Some small fixes were made to the macros and test functions
- Link to v1: https://public-inbox.org/git/20250107091932.126673-1-kuforiji98@gmail.com/T/#t

Thanks
Seyi

Seyi Kuforiji (1):
  t/unit-tests: convert hash to use clar test framework

 Makefile                            |  2 +-
 t/meson.build                       |  2 +-
 t/unit-tests/{t-hash.c => u-hash.c} | 75 +++++++++++++++++++----------
 3 files changed, 52 insertions(+), 27 deletions(-)
 rename t/unit-tests/{t-hash.c => u-hash.c} (79%)

Range-diff against v1:
-:  ---------- > 1:  6fde57893d t/unit-tests: convert hash to use clar test framework
-- 
2.34.1

