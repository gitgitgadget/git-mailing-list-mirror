Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772D332FA19
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536578; cv=none; b=VE4MSpmLizXwabNURM14QsXC2a0vbGhFc52pLUXPMf2ZmBKAD7xleoOhthYnOg/FXbabaVH43RA1XouweVyyrs8JNz6hERVLeXknN0Jqyzvqr4BG7wEg1RX/oLHZ3LqXvFWl2uJa4jfU9gAvsPyPaubDnJKegoFmSaExOgP/K/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536578; c=relaxed/simple;
	bh=7f4yBpKxeROg6eim/BUNuSnK3yI20/bSC+a4DvZEUPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBQhlU9xuQHLCA4p8eOOpQtBdHEdM2wwcRuGiiVAem7rVKPK6LmemwYd61bElkas3IemPMfqsaObO/+Bmv8rX/DlGpnwvoxJ6ptrmuxERRPwb5UghCvt1PtqyNmN91n/xeExLGOi4QCTT0kDKiV+16JiARxRXTktr8ACq+3ye44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHEyXlYR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHEyXlYR"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-430f38c7d4eso343296f8f.3
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 16:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536574; x=1767141374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3yB/lKfdMaiLfmFijeJpgqfStvYKmq0CXqiwN4urYUo=;
        b=cHEyXlYRCodh09dorlHMEaU9e+1xRAhDQbDAekssCOZMDOmga5PiOvGdSmZ2e/C385
         PzVGw2oIWmLfgO/v/6piGfwPQWuJJYh1WoAfJkCucYGZjqQfCeleuPczCuc+f75x6qg8
         ZzG5M6PoL/JSTjULfqj41LgTGPzSRX+SsF/G0jJrXFvTCvVodGCzg8uXFwyf6JU/0ZUX
         AdTFdkAf/fnWxFNc8oEJfkXi8DBoHC/pAmQecOZ/R+Vf4vcmOwlOEz1YiBWxvgpSyrru
         ExWejcnw49ux24lW3Apx+NO9k8Us5rHK1Co1v//8VmVkDwHl9NwC/yU0ELnk3i8Hbf57
         qOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536574; x=1767141374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yB/lKfdMaiLfmFijeJpgqfStvYKmq0CXqiwN4urYUo=;
        b=VyJJyj1qqMVlkE0F5/uYPaNNXX6btqSIH1ROkSgzj4Dg279XhstOUsZaevApBHlPx/
         28wd8wJIfDaCeSJiebm3U6tqRoUEoFic7R+co9JGTHySdUIb8p28B+JvNhF10sFWVUZ1
         XUST9zSzWS1tp2+ewWfykUK57JZmHjrRmUPlRmz7FbQkd2VFYyqe7E6LEzeJ/nzKyw+0
         R8YD0Ld0Nl2e1yIVayvVe7qWsJprof/5mqF0P00+5qjTUOD3Oky4gKcjD+fN9Uj+ffx0
         rKIOPnVY1qyI/Dm5VdCYwtpc+HdU6NLbF92RU7aipTjaNqI01j+i3/H1O3Wcy8j4vx3s
         0DGA==
X-Gm-Message-State: AOJu0YyrJgryyAXQHqhzH9BskljnqvgH5Yl/MbP3MPHMkXHJGa+hwkHy
	U58lj486T8Z+ykCtLgBRF0Ylx+LA/B19JkR8uS4a5E/Z1dXERn77CoxgGzL7aF39
X-Gm-Gg: AY/fxX6c0X93HzGwK6cD6b3otRaxlFGOSza+bzMIlFmfgWb9jYSy80Vdg0yq6YNho0r
	XCSE2iOKeb4rm8KgIo/GrUW6nrl1+pT7bizR+2fsxBLnfb526UThEvpM2I/WB6HG8GRlKKHM0tX
	ZhFRad28fGwVTSHI8iZ5GQy59wjDzHL3YTgWZ2mXgB8y3jN5j/GMx7dgypQyIXfpoDJ+ZmVFuPm
	ZOtCmrVqEMkrlKuTeM21tU1rC06X6JEju3+hvofkZ9jBxb48iyF0BQzfYjttGWgcwwZwK12BXjU
	hsuexrITe3TqM1Iglr0yiUjAh3sIUKPOEbjx0efJX/BfaUYmaaK+CthuiWnzDJZB7BDimGgoFvD
	8nyZ7JFQl1TpSCbqrfeAJShESXv9MNYfJqJnxxE+u5ppy5pUebaWNfFh06ZLoYFmTvmRd+s1NoA
	OHNL+hMdYtrNqDgUUIVmsLWFJ0/zafrMxyy5Jcpvh1HclZAJ6u3UDBi+nYtV/gNHfqOVd5Ig==
X-Google-Smtp-Source: AGHT+IGyhE+fPYzCrhP8fgw3G3Ozqtp/itxcZJz1KUeL2ja9xYiu533+uG+HPKTh3+T0EB0DENdYvw==
X-Received: by 2002:a05:600c:4ed2:b0:477:9c9e:ec7e with SMTP id 5b1f17b1804b1-47d19597517mr96577855e9.6.1766536574500;
        Tue, 23 Dec 2025 16:36:14 -0800 (PST)
Received: from pc-128.home ([2a01:cb15:523:b100:b9d2:873b:863:c3d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193522cdsm255240075e9.4.2025.12.23.16.36.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 16:36:14 -0800 (PST)
From: Matthew Dodd <mats.dodd12@gmail.com>
To: git@vger.kernel.org
Cc: Brandon Williams <bmwill@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mats-Dodd <mats.dodd12@gmail.com>
Subject: [PATCH 0/2] Fix shallow clone with ref-in-want enabled
Date: Wed, 24 Dec 2025 01:35:02 +0100
Message-ID: <20251224003504.52660-1-mats.dodd12@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mats-Dodd <mats.dodd12@gmail.com>

The ref-in-want feature (uploadpack.allowRefInWant) has been broken with
shallow clones since it was introduced in 516e2b76bdc (upload-pack:
implement ref-in-want, 2018-06-27). When enabled, shallow clones fail
with:

    fatal: expected 'packfile', received 'shallow-info'

The server sends protocol v2 sections in the wrong order, violating the
specification in Documentation/gitprotocol-v2.adoc and client expectations
in fetch-pack.c.

This series:
1. Fixes the section ordering in upload-pack.c (swap two lines)
2. Adds a regression test for shallow clone + ref-in-want

Mats-Dodd (2):
  upload-pack: send shallow-info before wanted-refs in protocol v2
  t5703: add test for shallow fetch with ref-in-want

 t/t5703-upload-pack-ref-in-want.sh | 9 +++++++++
 upload-pack.c                      | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)


base-commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
-- 
2.47.0

