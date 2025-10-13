Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41127055D
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760358525; cv=none; b=hVrxdVmC54umZxZjny1K6h+5ZMbchRzUNgSzVW7SLBzkngXBgS5/iQpqDlkUUglZEx859XqieI7A+4RvNOKBNPWl7anIvMOF3Wh5eKkRR+3JbhMb0jlIupZHkgRT2ztN36W//JyQq7Sd5p1lOmCuUN4/zaG1UGYiH8tVGEwCrsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760358525; c=relaxed/simple;
	bh=AFivuKhbFaDiS4Om8Zd2u6Ufsa2cegcNFuSl89Rfl3I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WidC0XhtFTV6PioxB6n1wweDelhS+mg+Vqv71jFZRlqHtm3Ebr3LonbSL5O8UQLzLzRQGeL/FlGLG7Mqpvtrbch8JmIDnD7R+dbtRZ0CVJATmLdXwQxKCUW6lPXScfQGllSWDhqLUiUNHoxe5oHbNeZZo6MzPZn90KWfTmYtINA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmV9TBtY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmV9TBtY"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3da3b34950so707174166b.3
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 05:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760358522; x=1760963322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kb1lrfTxfjifXpMz0rzdX1xYKJB0W10eSnZyPjotjxg=;
        b=PmV9TBtYIfaedq3TtTGVn3av3Oy3Z3cVD5bIEYi3hiThm28uBx+A24A6nFTsSKCSQj
         1jZ3aHyOiUdKnH/1NvAw/+HmMJFQpGaUZqGDpC2PZZ8wgVHb/RdWkmEnOftuO/VEyidk
         yACjf6SqUgCRoDf6wMEWiKrXCWfFxyeubu28BnfBdJSGB1z6ONNzIr+maG0hKy4SKqJ6
         AvQRFsGlyBrZmXexwsft+rEBN2UwKZNpE+IZh5LBJPQKtC27uT/W8cfQlPbXapwZQ2Y2
         mCuDHu0PaMdaUW1hCLey4xmS1HA1u85alE9L0QeAZ/lJvccoVRQZcxW+WOBuWsVMV/a2
         shJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760358522; x=1760963322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb1lrfTxfjifXpMz0rzdX1xYKJB0W10eSnZyPjotjxg=;
        b=vgyCtEVqbN8LczLnfzociOnhB4bLOJ8YgmQFNBqVfygH8Y1x+p6/MYsefKKNYQcQUg
         /LNmdrIz20lTVnnAFzCgiXDk8K8wbWbz6jfCVEqZ957NTfMhkfVHeHGakNqEDYJ97hEW
         /daBiczR26s/2DjfoCm1vafA4M8dwAnlWoUbirilzisLIkU+5Q2/vst/hN4fb/JdeR8y
         60fcOK1SdDjtFSPhsNnTtuXslj8X7GjYaBnCMu4qB8QXFWY9IUbGMTBH4oOIe/F+CxBx
         T8ubJrpIrhmmWJsNEJfQEk0dQNn2J31/XBZHcByYqxJ1NY0Y/J58VAEwGSY3n4qoEpkJ
         DWQg==
X-Gm-Message-State: AOJu0Yw9JzT+SQNraNTeW0EBmnYLpRAAuhjuIIl5vaO04haxOSzg217b
	ZfJwLV4v3aLl1m7U0vHCM8w5zFbH5tcJC9+2zlgZY4egRIk48lUcuiwTHNSWg/wo5lL90vzj
X-Gm-Gg: ASbGncukd6OXimSeVFgCMiT0HiCKj9mKsIltomb2swM8Errd1JxPn6XM2lQ4oMpPDQ3
	8XA01BwlSzhw9nqzB3sAzosxF9vhbH5P6uJPqtl9rq46B/mVga8nlg8NIDbgk0KWBaL+dV3OXuw
	T8hiTo0Nd/IvK8bPW/7DeMx7U/yBn6u+D0R/8HHU0W00rawxWWS5w+3bclVuCjAX4m8RJ4gSLGI
	zELDwnZmFbKeumGzkh9hVR6GSZYhbVZHnIDKnrX2aQ6lo9vNBEIIlHlPsbOj7DyP6H+MKhG3Nhp
	iQu24jfZ/q/effjhpYBkMwMBZgRbPjaadNDtDgeSCo+F12NJ70ewd+6fW1EBapG9mcvu6VFdfh5
	Ss4Zpc6AYHLj41nrNwhYa0SEuZrKPyTdNxle1WYWm8xf0XAuLYDPQZOC/t3EhCjxIoHVvyx+/bt
	gZaZ1XE+NEEQY76VpihyS6X4n7W9kKTTM9l5yffS5QKpgZ5I5fSim1Z2hR/hsvoD0DDYwVzmdZa
	WSf6gGc0RrVJu+rpRt8aaBYR4Tn
X-Google-Smtp-Source: AGHT+IFg0J4it54SUcTAAMqjj38uwgc9rVxikOt+iobPKvUqmWWHYAxx7iBsC6JwkQT21zPiZcwqiQ==
X-Received: by 2002:a17:906:c150:b0:b3e:6091:2c7d with SMTP id a640c23a62f3a-b50aa89b304mr2372809466b.27.1760358522186;
        Mon, 13 Oct 2025 05:28:42 -0700 (PDT)
Received: from localhost.localdomain ([149.34.244.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d900ccf1sm902588766b.63.2025.10.13.05.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 05:28:41 -0700 (PDT)
From: Solly <solobarine@gmail.com>
To: git@vger.kernel.org
Cc: Solly <solobarine@gmail.com>
Subject: [PATCH 0/1] *** Update test file path checks ***
Date: Mon, 13 Oct 2025 13:28:23 +0100
Message-Id: <20251013122824.15216-1-solobarine@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*** Update old-style shell path checks to use the modern test
helpers 'test_path_is_file' and 'test_path_is_dir' for improved
readability. ***

Solly (1):
  t: update path checks using test_path helpers

 t/t2401-worktree-prune.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)


base-commit: 60f3f52f17cceefa5299709b189ce6fe2d181e7b
-- 
2.34.1

