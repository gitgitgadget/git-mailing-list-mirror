Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D51F5E6
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760494792; cv=none; b=fD0yeF//U14W/aIfxGbnFsZ++2FJTnNQWDMd5NchKA+JB5rAeqXCff1Xnq+tQIt1zJbf1S51R64pSPmhzvl83dj8p2Lc7LF7NKthlIismJzvgxfY1Bzp4WAiciAzXhrYKyzIOEsJQD8eyX0A5GgZdyYGtr5EFnxE9ecdC2QG1/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760494792; c=relaxed/simple;
	bh=b9W/wc38iqFFuYELdKzwcIoJZW97k7D/z4DVAViN1Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StxRivsUAKqqEYvLtIOmV/zZ49x9yToJeNk1FAmPk+HyKV/sZ6Gm64XEZgon63wLfedH0Jg5EdKttWnEO0+/oWRuyVFGxMGml6E+wW1THZzePFv1XAHxtmrdWDMtX0/OeOQVbx6T9PypqtZFZG9s/+xpGbQ/cy6+Aqs11W1/muA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuqSidkg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuqSidkg"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so62340775e9.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 19:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760494789; x=1761099589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDlgH7ckBz0UiUE6rT3TuEmWtiXWaJJKNeNf9B7+Nn4=;
        b=AuqSidkgBHreigNA9DguCCXgmIWhEahU4PUe/OxQp/6cRNad3bqQFwsw4k5emUrmgl
         u3v/7LN3ySExRLtsLRhU0eCOJ1Y9SnFmvDQgCiW5MfuaLwNTPliGdVSwSqSy2KWyjo4e
         Q7PS2h9wHr0fPHKf61RRivVx2IrsMaVNIhGOHdg3AoPazL86lqHdnaCJ2B0/Wtg7Thaw
         y+eyKPsLziniBgk94vsXto5HtBBnQK+UtwZ41nv86ZnNghrQkRyw6JmVkT1MhKXDxViB
         DgUTu7Ajx3hciJOT0esQvzL36TzKnOIoAyeBdJTP10LoZyOrUB10f7bm9lYdpKHVZylB
         uWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760494789; x=1761099589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDlgH7ckBz0UiUE6rT3TuEmWtiXWaJJKNeNf9B7+Nn4=;
        b=Y7ERha3FQ1wx+NPh+8qDEX6uDrse13i+AJd2Pw8bXHej79ZOpSEf8oLlxC6TrXFj15
         l9fti9i82sYFfu0ejm89L0lOxFFG69HdvQov6L9HfFQvUYNSLwXKggvF5aOvlGQ3gmOQ
         Q/1wcxRv1ZZHAg5O4jzySCSvgjszpro3bFr9P+7Mt7vISmRvFsab8CLpn4ARzK9sTVeA
         ehES8K82yk/imK5zxePR+OvKwB0YXC1MXMwALi4+GSoXK92VDa3/sGRhLY7KNFqAB96D
         q83j3aL1UEH9FxZrVEReSzn3OMhjPvib+/uCNX++08Vhqm3elyEiNSWeJ799wFIbHb93
         IHQQ==
X-Gm-Message-State: AOJu0YwG+4zHlW/OXGCE/PhpGJHYTC/EVFP6DOBagRZl2mT45clyvtz+
	bVRpuTIRDA9ISxNvc01MqPhHK5n6zYDPSOiNSVUxoln+NK7nj4L39K8/
X-Gm-Gg: ASbGncv9PYWbUArIwd4Rszv6qvzkQosX05UvA2SO4i3i2SFTZFKql/9I+1p/FkLJskn
	iblvcixfhjJfxyjxEdBygIb2b7CwsAZKeo/17fOsqw0Pdjh+eoNCOZD1OT4GX/snIcr+rirroQy
	cKHkkCGcphWj1nYJjIWzuBdHIgMc9AHEiD8lCtu9+8E/aBxH6eLU2MEEUtUiRywLAe4vuwTf89t
	LitjTD+VIO80juDzcJKTvKIQ9u+tXes9E56l3UytVgkI+XgDEOYsO9ScRziDnodM5OHcETl44nJ
	/pMS10N4PufVRw0j4RVxAuK+QfDjQUOBPGEuRVyCtoYQm08sHOD0Ng9RwwdhpzWcW2xHxqtgwxV
	z3dhdlxoZ6YoauVtVU/jyb0ta8YMyWSL02V7qdA==
X-Google-Smtp-Source: AGHT+IHy8LcvfgxnCRetiHGvEPD2YZ5ni9+YXlA/RUm9+ooc/k8mNh10eUiamIMQR/cmxBvruCxuDg==
X-Received: by 2002:a05:600c:1384:b0:46e:3cd9:e56f with SMTP id 5b1f17b1804b1-46fa9a89286mr198257545e9.6.1760494788692;
        Tue, 14 Oct 2025 19:19:48 -0700 (PDT)
Received: from ubuntu ([105.112.225.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-470ffc994e2sm3175505e9.5.2025.10.14.19.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 19:19:48 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [PATCH 0/2] [Outreachy] gpg-interface.c: use string_list_split instead of strbuf_split_max
Date: Wed, 15 Oct 2025 02:19:41 +0000
Message-ID: <cover.1760490943.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The array of strbufs that calls to strbuf_split_max provides are merely
used to store the list of tokens gotten from the split and no edit are
done on these resulting splits making the strbuf_split_max unideal
for this usecase.

This patchset replaces these instances with the modern string_list_split

Olamide Caleb Bello (2):
  gpg-interface: replace strbuf_split with string_list_split
  gpg-interface: use string_list_split instead of strbuf_split

 gpg-interface.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

-- 
2.51.0.463.g79cf913ea9

