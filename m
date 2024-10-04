Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014801E378B
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058713; cv=none; b=nihJvpp28qyNKGmK8rFpqAkYO7eNDI9sUgRJiN3a1FP6qEh6b910EKNL2cXAoxe8cd6EaFuPmsmozaETyxWR2mvCIu/vvhhujaTUCWY9EiA4BHDqAd/71VWlT8vbuWmwdbb3JLpOqM8CGlWTPtkiG00SpLf+/+gvBXf2S6B/Jd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058713; c=relaxed/simple;
	bh=QqGDCYQeY40mMJTzZFSSQo0AXn+81c6garIwE9+umZo=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=qBZgsrv/rDTVsyFx73m3QD0wHTJdD7N77LN5ntNm7Rb/wJWqdjoTSboalKekjRIbbRsnvsWqAC/iC1mFevcFRboy9Ig1z/vekPWT3ZCL6V0dXNL13u3jnrfE43vjmKHQn5rYw1ORUlFKLZw/sRi8edGm7Pt6c5a9VLctomkITfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGN3PEAH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGN3PEAH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so23465925e9.1
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728058709; x=1728663509; darn=vger.kernel.org;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqGDCYQeY40mMJTzZFSSQo0AXn+81c6garIwE9+umZo=;
        b=IGN3PEAH6V8Xt8HVCHIDLvi0OUL+VHeE+LSjn44d5rG969aiTEycp/JFtfB/v/Pxs5
         QBeqsJu9ZpWnpEoYJgaDCztDsXsBphZ9Nz1GUy98SlG3w1OGHoE3nNgkPE0OxCABWQ/7
         AhHB4McdFj5O4/6eagqSoIXQz7je6Blv12jlQw/tRK8IjG3LrQjOKRcli2bfwCqDKvyQ
         xRxi0djQvup2FmT0nZy/Tq1cV8D4oZdy4IEDl8BiE6wxsn6ZUpSARo1ENrkx+P+36luI
         pbZYRv48QVLUsUuSUzl4R582a2bn3FvM6UGhemUVSkxWhayNJ0Y1j5M8VgGAL+B8e0/z
         cFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728058709; x=1728663509;
        h=to:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QqGDCYQeY40mMJTzZFSSQo0AXn+81c6garIwE9+umZo=;
        b=fxQ9+tY/3A2O677lUX7ISZO1InTCh5DwS6aQFL15od58BhxYreZUFJRV9Zpst7kMsH
         A5j/KFw0dJWrIzg7x5SB9hwoEZlevM9uXTUYmZ7Ig9gYuxxkZ9dNyIY8eCvt9SMPKZTO
         T0Ocbod5gXkhDLlpRWXhlM2S3Ke5L07PL8jbSgxuv+pXRf6CvH/PKBXpFPB8csHUhahu
         4kTPbw+ST6vFssm9l3SzvDx5mJQSTSynC+LWXIOCwTPEu+HDuB8RGihFCoDFF5UoXqmw
         pADDKa1PD+YXPCeTAMFIsgWdZE9h87k+EKjeUVH2RyZYYU7ZGIOcUmYtQznQ5drR+4xT
         BWHA==
X-Gm-Message-State: AOJu0YzkUZlewcS2D1U5XefmTLtOXZ3fO+NbydA5F93zBnmDqurRIG3K
	G0q6wEI/sQY8Dsoz6sSE6QI+NF4ZO/23nqmd1I1Ei0xWObsB3QbLxoU1mJy/wdc=
X-Google-Smtp-Source: AGHT+IGiljCFr0SW/x466O9tJojbonSRFkWo6x0/MSRYjUOU96kaleeG64wbd7GvM1yusx8aefnilg==
X-Received: by 2002:adf:cd06:0:b0:37c:cfee:10b6 with SMTP id ffacd0b85a97d-37d0e74c53emr2423940f8f.20.1728058708835;
        Fri, 04 Oct 2024 09:18:28 -0700 (PDT)
Received: from smtpclient.apple ([129.205.124.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1695e8b6sm1880f8f.71.2024.10.04.09.18.27
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 09:18:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From: Fashina Segun <fashina.segun25@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Fri, 4 Oct 2024 17:18:16 +0100
Subject: Outreachy
Message-Id: <BF74FF00-C553-44E8-AFF8-F83D28422A7C@gmail.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (20A380)

Hello team,

I'm Fashina Segun Kazeem. I'm thrilled to be working on migrating our unit t=
ests to the Clar testing framework. Currently, I'm dedicating time to thorou=
ghly understand the requirements and familiarize myself with the necessary r=
esources.


Best regards,
Fashina Segun Kazeem.=20=
