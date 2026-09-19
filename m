Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B55349CF8
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853222; cv=none; b=mxU5ycurG8uV7S/ZCtFjt9efWD0HR5+6yY1hzi8+XFR34j3QyLSB5j7QMDQlL8Amafed8EvxvZJyprMa9gh99jr7l3MLi/6fOs0PBENMYJy93pupodErjkM/GQe+5NytglRnkPFejB1aeJ9p/AmwWmZ25g7l6DYslHHMOyqWSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853222; c=relaxed/simple;
	bh=eUovcdejft7mUJ/0JrATBapLDuJn8rQbw/ePZkQ0noM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b2FV/zTvwS/QUylv3Mqxk+eRv3FsVW/2fIrLASgJeG4mBYMQRU9AVVeHVHcX5J3wZLjDYwCuvAmmCJCvoxpSXwMBANJ9wBcu8Kde2ot7Rkp+Hx5oRVaHoO9tUMcOVXLC0mOtraChYVYvJVlkbeKyt95g5PIfYAp4AKQbbKV6e+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YML2O3i3; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YML2O3i3"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-670f572e814so1110609d50.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 14:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853220; x=1790458020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V3bWIuXO2U+ZrMRv+SikfCvv9XOr8yrgLARWBboFoss=;
        b=YML2O3i3BeBYCt5bPUEj9cD7Ux+sv9lom7bZBg7+Hbh3ZdXmuc4VV8j9N2ifzVDtSJ
         mQ345HSvQz4J8988q9jY+WtJOQBM1lYtFkFR8lJr2NhYiy0F7S69kepLX8ka/XZezMyx
         nluF0IRxHdn8XmPf9b3KhbPWFD8mrEFHdLn3rdZASzztL2bXKFFsuqQwDXuwHK4lnz+v
         7yxo9ZxkjfSx+MHh/LnMZkrCykcpNNpLOEmFd8ptoYqO6TSfACMgP/tSl40cZFBRjbgo
         Ezy12UsKsVmCnDJTgZaGfCEmHgyINXSHBEYNFsRDBUcmlec14EE9lJh7U7TokqoLdfsl
         CKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853220; x=1790458020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3bWIuXO2U+ZrMRv+SikfCvv9XOr8yrgLARWBboFoss=;
        b=Sz5Vl+eVA9oBKrkdOY1PzOBU7GtrTo0E7Tna7OefSxMVHdl1ps4/CyvIOxQb+IIMkH
         eu+fbyV7qQfP/dgKCLIcAMRpSnG5xBRRXGpyNhmse5q1bc5KDKZFx9zVC75uISXXyFch
         8xC2H5MCMRK3Qm4ev0/o80hjjWb8Av1SNttRak1fkZu2MCjl+mul0mgSx6d8XBhwXN+k
         jTiaYW0K2NkQhG933fSQzOkHq8ysD/TKcfLcN5uWoGQ0RDBGVd21VjdsjdjBnH72wtO2
         z+16XnN+0ZFFdLqVmr7IplrkdSq4IButC6i1BexcKPB2/q6skfKsazGAVhM9VqqUJMOp
         OW8w==
X-Gm-Message-State: AFuF++n0siCXo2RguAKEVkCmqSfQm0fj2bIuKBlgyblSyLymD2oPTiK5
	Fwmh9domgSKMrOpNmptYdEqNPmNbdHtn7EWeFC+89fuf1QMUAmHlP0AkXFifzw==
X-Gm-Gg: AYBFou3KPNk1GYRJdvNul04xiGe/E/AdiDgsdIR498cTuQQp7tMWD9lgzARjrEdJJJi
	G5kzWwb7cPQDMvJ06Ka6RfBdNJOSRvnn9l2ob1XrMKKVHaO3iMU04WUzjmz0pALYeS+I14H5EdS
	CZEGFR0aFnOO8t8kayTIEqpBBd9SGrFP50zeximUuFlctQAJIFEkquqppFsOxd/DOfhHWKjLCUD
	t2mMgKd8uwDuTpnRpe6zr6c7DaE/+XiW/bDQa7xV3IP9FvNYMMvUuFLKRxlgX6QXaRAv7YsbB3a
	II2dn+E5mBcp0yUBD088wPX3OcYDjByPBrsX60O6bswbIQ1QDjEhH7MuFgn7VKhiTW1va6wwycO
	9a7ZqN33PSh7jc3cnkp0j1oQ9dQK3mq+lvhI8TsxV2sQeKOQr/p4uGNgxD8QGCYLtOyDbrVSndD
	jylvriaFPU+TbrJPEoD/ghoe/e6gJtqvYx0f7V/pcBrQDOx24lCEmEahpd6Oh171DR9yrtm/8Nt
	mFAgh6vOwYIZiiqheeyYCjlet1L6ugyOP4L9Z2dKwFbzRte0lk6SS+pJ9Iu5ZbWjNyb5M5yJZDf
	niWVdNV06H4kcNRvoA3Gfw==
X-Received: by 2002:a05:690e:4192:b0:66e:7af3:ac73 with SMTP id 956f58d0204a3-671702fc5bemr2463833d50.1.1789853219717;
        Sat, 19 Sep 2026 14:26:59 -0700 (PDT)
Received: from merguez.lyrebird-fence.ts.net ([2605:a601:9092:700::6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-89a4751bae9sm11756497b3.28.2026.09.19.14.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:26:58 -0700 (PDT)
From: "D. Ben Knoble" <ben.knoble@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Eli Barzilay <eli@barzilay.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/2] Hi all,
Date: Sat, 19 Sep 2026 17:26:34 -0400
Message-ID: <cover.1789853192.git.ben.knoble@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small patch series fixes a bug reported by Eli Barzilay in the
interaction between autostashing, staged index entries, and
stash.index=true.

The first patch is an incidental cleanup, while the second holds the
interesting bits. Preferences on keeping or removing a few assert()
calls in merge-ort.c are welcome.

[1/2] builtin/stash: remove unused header
[2/2] builtin/stash: merge index in-core

 builtin/stash.c  | 77 +++++++++---------------------------------------
 merge-ort.c      |  3 --
 t/t7600-merge.sh |  9 ++++++
 3 files changed, 23 insertions(+), 66 deletions(-)


base-commit: 339ab2a8f14c0c304ae2f28df1a859f3d2cf610c
-- 
2.56.0.rc1.315.gc6ed9934b7.dirty

