Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3591DF267
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124135; cv=none; b=kJUIFZSvaBrDoXgoCnHKl4+63u54PwYu2j1zT3bMlJZ52RDOaTmhTp3PkLxTiiagTnhliRx8W5RlR2tUHfLQU2CHzYqcwpRiOWvgruyLfqlwTuHdC86j67oVbWxrRKDga3uj7ga16vz7XWjaiAGKnX8doD6nxdzchCm5mAj1bQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124135; c=relaxed/simple;
	bh=h1S1UZXO5qPfkzkEMdmseX3Um78vGBQHgZYRwKtT7VQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GtT/oqPTDossJ3VYX9b0fwP5vgyBjlycCoRosRFwYlVBQxnRpOSIuvxCEWARBOFGk0iXwFmQ5Wls63GtHHJEVFBIA655txOKJkxaH5sNjNmrXjUd0rAhpfYhhrSn3ospy/FbwukmJ3VvQDL+6wAjmf/ADwcfLH1Knowhwf5yL5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc59zgUu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc59zgUu"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so9243652a12.0
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744124132; x=1744728932; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K8B6WuqX2u+Oltp2rgoUWAOyVZzdIFfFC7JGENcIrtE=;
        b=Gc59zgUuvIeFEeGhq5OyxIWc2FBKVx0RzrQT2NKRYtYQ6rEOcLTNOZRKwlY56EZjSx
         k/ZxQNLG0my6bKB2Gclz/c9azgWfK7Rz/UGw4Zvb4dwqIMhxYQHVyFhQE2WIe+MRNmUX
         kQIg7XS/5vvaoo4VmZTC5Jsb/Gb/xplQoHNVtsprhXaeo5SroNy0nndu5g6gGO33GEO/
         IYKbpyQBttgfzIFC91Erxb+CAS017qlstTPF/Xj7DkM/5f+t77NReCNXuqwKjVp3stjU
         zqi22p/gk0Pi14fkQPM3tuHfX3GYQZepCXUBPiGofkrpOpH7f8W2Il4yxPs/4nqVeRqI
         TWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744124132; x=1744728932;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8B6WuqX2u+Oltp2rgoUWAOyVZzdIFfFC7JGENcIrtE=;
        b=OVYEM6qXh4EfRw7/D2QxXOJo/e8c+PcnaREsI2MVxd/AwKiAyVuu3wD/XvRWMQ+Lch
         q84N6hC/UrsbFDYstTRZOlrH4dct37zr8R0/O8b94RzKmlDJGR2tbAwNNS1UaY1xrmo7
         9TYz5lQA3dzJIXqaXONT751pv0Jymr3Gqhf+UvtIygtkv2BPcKD6WLLeLvKatkgTkmPG
         DNE2gQYRMJsSGwXs1XI9m9tUkkGuIcrcUQCHdEuhhyjT9m+d1OVqpG/E7HpzMsM88C7X
         0/jUcD8nEvA3Y6kfKvew9arG3h4cmpS8YBsV5kNnnHjpe+YzamKX8KFLLD61GVEkEbOu
         7vGw==
X-Gm-Message-State: AOJu0YzaN8bPO4bGl6zYeyItqf2gmdvPtNH96cmdFpzcPqqNRjMb6zxg
	PWWvo3vevfYpBEApHtZL6x63OL1InKRK9/PW/rsvmZK9Uo0xTlhpYr4QK6Il
X-Gm-Gg: ASbGncsIHlq+hLW256ukPeHO2Cit2/ZQjF3lIitKP0axF+veWNxk/f03aTft1zTwaNl
	39kJ/WtvhRzsXkHVO11e2UWBTEq6CPHc++G1VSNBTNrK8BZIJGQL4vdzBDLV+7p/JJl5eXJgoEy
	5YfOqSHr74T5QcnUyVw4jJcy/AHg2M5VFazgZAhV0070wlE0yTKPkSJM048YPuPNYFr9+u68iHv
	nq++XhDJ55s5JqIsCt2sKtUmzPUy84hZ3uJA+v8gKli4oCuIxCbqWJRj440EASNNNJGr5/pqbe4
	ruABr7xt/nBSPfdO+8M3rPBVBtpIBtx9B0dqMvNgBiQw
X-Google-Smtp-Source: AGHT+IEDuZzYwaUyhpgp9NMK3H982sOvYL49JlP5zQ5vBT0JttttKZW9IDL2dvWG1Jr6QUXgO3v5KA==
X-Received: by 2002:a05:6402:1d53:b0:5ec:9685:e686 with SMTP id 4fb4d7f45d1cf-5f0b5c2bba9mr11263129a12.0.1744124131647;
        Tue, 08 Apr 2025 07:55:31 -0700 (PDT)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087ed1c68sm7905678a12.17.2025.04.08.07.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:55:31 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/3] meson: add corresponding target for Makefile's
 hdr-check
Date: Tue, 08 Apr 2025 16:55:26 +0200
Message-Id: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN449WcC/x3MQQoCMQwF0KsMWRvIpBTEq4iLar+ahZ2S4CgMc
 3eLy7d5GwXcEHSaNnKsFra0gfkw0e1Z2gNsdZhUNEtKwlkyf8zB787Riwd4tcIvxNJYkbTWNKs
 crzSK7rjb99+fL/v+A7XzZvhuAAAA
X-Change-ID: 20250330-505-wire-up-sparse-via-meson-2e32dd31208b
To: git@vger.kernel.org
Cc: jltobler@gmail.com, toon@iotcl.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=h1S1UZXO5qPfkzkEMdmseX3Um78vGBQHgZYRwKtT7VQ=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf1OOJKFCxOs+UPajPg7rWJK26kzNnz+pV8A
 zeo5r8WeCTtY4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn9TjiAAoJED7VnySO
 Rox/61QMAIZ7fdBAw6EigRgA5IOPheVT3DDnjWaepatqYL/X+qhbjzlgPwEzSnki6ncT+y6lvUp
 HDn4Uq7A/P80KSapX2XH8WW6bHQyhedaha+gg61alElg6pEv9nScVR4jBU+vgOs8/vz3RYWkKyW
 v+nbxrgwwBGa/TJxPdak6i5FOzQE0dsT8y41fzengl/EmfbcdWtPyoIscR2CDQQibA3CcNMe8P5
 6cK8//9u5pwBUi8gWPD5W60CSTbn5LARa+kzBVvYGElQ57wd10izlqEmTl5AOFaFzQliemQ7r5U
 Eut5z3oxBS9RGvv8t0RVNgnCTLOgugj1/y3apkDbPU9NR2+N/epNK7HtpjVe3i+NlwZk7qWW7KR
 x0gktb8oPV2jHFAX1eMATI0ynst+CKqTNe7qweFyFINFLx850ZO73Zlji++W/xoQkGfoNd/0IS9
 IsU2jU220mNG0jgtpdaBaQ+jHsDZVFQlNWJE6FG8uJtkZvGrtGAtkfOKBM9LAIvaVbwxLSCGuT5
 o4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

To bridge the remaining gaps between Makefile and meson, this patch series adds
a new check 'headers-check' which is similar to the Makefile's 'hdr-check'.

The first two commits are small cleanups, where we re-organize existing
variables to make it easier to add the target. The third commit adds the target.

This is based on master 9d22ac5122 (The third batch, 2025-04-07) with
'es/meson-build-skip-coccinelle' merged in.

---
 contrib/coccinelle/meson.build |  29 +++------
 meson.build                    | 129 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 22 deletions(-)

Karthik Nayak (3):
      coccinelle: meson: rename variables to be more specific
      meson: move headers definition from 'contrib/coccinelle'
      meson: add support for 'headers-check'
---



---

base-commit: 3a956c5f69873611ae5f8dcb9acd117f66b95ddc
change-id: 20250330-505-wire-up-sparse-via-meson-2e32dd31208b

Thanks
- Karthik

