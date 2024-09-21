Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0940C5684
	for <git@vger.kernel.org>; Sat, 21 Sep 2024 02:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726886763; cv=none; b=ovTBtzv0gDe4BEO81HLTO+5IF5C70YKCDwmiQKuxoCGTrMS5keOw+4bGkUCDH2Dc+C2cswQn+e1acaR+6VF941RasuDCsIO6QwPOtT4Bt/rAlkIHx4/eVfUzf7Tyqj4POGUQQH+wTMpKnRY9F5YEBAerAB4d9EGCABy3a0qnlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726886763; c=relaxed/simple;
	bh=5XjOw6T9OUkYpVBZvHxsTb7m0k1YYTV0bQpUKVbfkec=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Er1cmhQQdeFus1L7zpo3zZFYlGSdIaU6jVrx8R/svoIaXbtq8SmMgGyDA/Kx3UJc+vW9EBzCQvKQK7hy9aZY8mRnNXFwO5JDJqXnKfVsiQuoqhpwU4CGkqSOMgw2nped+z5CHDV9IUP90J7Ud9evndKwbw+C1uBr+GfiIES7XWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sf.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9bi6vtL; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=users.sf.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9bi6vtL"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a95efbaf49so278043585a.3
        for <git@vger.kernel.org>; Fri, 20 Sep 2024 19:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726886760; x=1727491560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XjOw6T9OUkYpVBZvHxsTb7m0k1YYTV0bQpUKVbfkec=;
        b=T9bi6vtLfPJ8++XC6DcM/Se16Igbi4FJwe/AJiuGFdlfAy4vP/rXowACYMt1BqOE0l
         04QaiHCY0jdJqT4eL7FMqW8nLQmy2V6CbkmR9EA+GXL1LFJeKOWcccdxH/1I4QyhiiCL
         ifPBi3hW/BTXUY+dV391A08WDHVQG1hNTq1FGyeaOTKxoNvPWI1lXx8Zbj8vhM75TChZ
         j9YPlSJYNSmGhR4yblL3tFz1PGvkAvHCkAPtnGuO15+2PVB+rCYGoG27QwHGHCj04uaL
         wGePlzW9PreyJdW1L93u+djt0PLTI1hzU4kynvDHhe03sfWvWJsNltjeKFeMvAkQhr58
         mUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726886760; x=1727491560;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5XjOw6T9OUkYpVBZvHxsTb7m0k1YYTV0bQpUKVbfkec=;
        b=G6rnP+QWBEe0WMdv5oX6BQUR5CdBLipospMtnGM8RA+iXoCXvW9/oqegdZrBfvwcql
         3iRf5Rr3PNwQ+G+W0BJvJvgoxTlt/VJt74l887Zd7lIYmIlpLOj+6F9XFpiYCBcxdE65
         LT9m88bvjT1n59248w76+wjHmetdpO8+ClQKrNeTehntbB9AX9a2MCkZpMhQxFzaYxqF
         mZT8wryZOTP7ZVxyGotbNNg4xz4DSCP3RnKcehC09jOky8SnUXFj5iv7+xOCrldYrOXY
         QUHPw/zD/+f5prZWFsGStTPn+frInivEZEo7jC/B8OGz9cA+UqX66PxxKpB4SRLlNZaF
         nbXg==
X-Gm-Message-State: AOJu0Yxd4lL7Nsc0vUG0owyXwrAs318kxL5uSk9teARDwtcavNmyoz68
	Fq4ye51v26QZ0ChFAKvg2VMnQKPK99OuGL9h5QdujUPcUiNDooEC75482A==
X-Google-Smtp-Source: AGHT+IGKqNOAY0+Qus/cs/zmtO9nIaFkg+voUM9Z7RHwjgnxchVITE/+nOvHXvEnEVn1uYzHmTpBtw==
X-Received: by 2002:a05:620a:4514:b0:7a9:b618:16aa with SMTP id af79cd13be357-7acb80a23e7mr816713685a.10.1726886760347;
        Fri, 20 Sep 2024 19:46:00 -0700 (PDT)
Received: from opti.lan (pool-71-183-241-13.nycmny.fios.verizon.net. [71.183.241.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45b17888921sm24700181cf.41.2024.09.20.19.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 19:45:59 -0700 (PDT)
Sender: j j <gonch.dmitry@gmail.com>
From: dgoncharov@users.sf.net
To: git@vger.kernel.org
Cc: newren@gmail.com
Subject: [PATCH] merge-ort: fix a crash in process_renames
Date: Fri, 20 Sep 2024 22:45:32 -0400
Message-Id: <20240921024533.15249-1-dgoncharov@users.sf.net>
X-Mailer: git-send-email 2.34.1
Reply-To: dgoncharov@users.sf.net
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Good morning.

Resending
https://lore.kernel.org/git/20240706211407.512652-1-dgoncharov@users.sf.net/.

