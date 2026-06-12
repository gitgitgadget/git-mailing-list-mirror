Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFDA349CC5
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781262622; cv=none; b=dwsZxxkQ/c4rsbE84M5TSPh/NQadhBYSN0CVSVfzBtzH02vzslWiRhLPMv0EhixiJpeMB401UMyefkgwHn41urzTsDjXXAGBS1cm9ABk9mZCsByh6LqwA7Tf1mE9bnPn4upETGO3f/cVE4/U7e+cSwADxPZ8spwswRR3+xU9XC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781262622; c=relaxed/simple;
	bh=4BdOb0PwlzskShNEfqc9/L+kWr6GuH9rs7ferB7XUxY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dLAHipOD3uc6ES01ItBmtKHspwbt/AtOS03WNwRPBXFC3tchHVCg2PbiVHkg75tVfpNpyxHmLMNzMTxUVFXbpNuoytqlsgQmw2TJ29hZpxYySJHBxtUazsD5aW6GLQfjjejsPfUX/dEsmALtkpSdkwSmVLw7h3SA0RO4c3CnQNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4PV4jOi; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4PV4jOi"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5176ca6bab1so9927421cf.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781262620; x=1781867420; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e1QJegMgKEq4UmO8+TPtfgClYTHVbLNc2/hwl+2wFuY=;
        b=g4PV4jOiTFkT3r8dvRdhlJyhdV09CSS5knB7leoQlAJRsjD7lFRhfqaYDQ7gaCsgHE
         b4zc0+FI+208oKoVeHQn4y77chIhNRbrp4mSEJfiMqGwxQDjoUbIzaqbM+JPuNQbkTRu
         qy03znxvWY/AyG6JleGro7347IdEIzFVoDFRpAPEkPqRdLwhCxe1HWyY3aKU2x+hbDKy
         MDlX+mZ5ialsAshOp2ElfolKVHq+LBnLnv7TxtQQo2x2m4+kxjU9/RdPl8qgVsGWWWO2
         f6RKdxeIKjSer+qR1vp1odk6KTjIoFudUEKEPFlF3ps7hGll/BgF4Hx051oNlP53DULx
         /srw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781262620; x=1781867420;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1QJegMgKEq4UmO8+TPtfgClYTHVbLNc2/hwl+2wFuY=;
        b=loVdo6bGWeyCOeE4uLaT2hjG/28shF3fUNqYV5wx8MHDqrlZ2EDYPw8qyCGViMExQc
         /MCml6H5cEl9p6xsV0DYnMe5OtIoPpa1nbN4/Gy40+0yQx/Zg8ZsBUMRsOEN8j/cXH7K
         Br3ysexfGkVja0zsVB19PJgm/irtHW7AmaFNdfM4lR3EHYxsJ1EUsZ9GucgRHJvffRCG
         /c0TuuVrXDPgZAm+b8XZj1oEIKlp7wAeGVo/1S8kOjsgrOAzYrkcfbe4UC4+eMYcbHQZ
         nnHGW2LbtBLFlqGf2aS+gQi6kF4m30YMdSU3shJlHjKbfYcGo+Y2yhUWsIA5ZhuiMUsy
         ANCw==
X-Gm-Message-State: AOJu0YyeEoJVh3jmmDhSxphJnl8yHnzjqMr2CziH3mYJCxm2BMTuDLiT
	8vYyl2N+OB0hMYeJ1mH2cg0IRLUOa12zyiwI0wlJHz9Ku73VqoKG2pjJfbBB8g==
X-Gm-Gg: Acq92OFu3jHdemtf44z4Ixe4G2ScdAR4Ktzp73e6kd6XdZN07GNIoK7YxmDCT4Kb3fx
	TeNnAfWC8dhL9dj1UmyrAYUmyzsKo/0ZEhbfhZChpNSdw0axngKLoPW9d9sMRslHqnNZB2/RVFc
	dy6aV85WzEEOkNPFGUmhGWb9ZP46WBJFjqmSwuYUP1PIvsOM7kO9sHPTrd2f+QC2dsqJrEye7cD
	3x9r6cS/K4LPJx/tTzcSWiGtf13dBsDffNeNYTOn6jcUPa3hvAdmfRbD2QYkhLQwsak8NMXjcc0
	Gq4y6k/FhXyaPSULZEQUbzkp9m8A6mEa5aIanNR8mhj0HHidaJ0PFU+SlMzee109b3BZpMsywtd
	vAIVqh7zqvx3yChb3lsMPL/pi0lFOJpfEVWgHBEUjsOPX1xdH+gctH6bhTCCHU0Cf/t5mbikYLt
	QpLeRIsdkRDeBYb8ab6mfehdgfFA==
X-Received: by 2002:ac8:7e92:0:b0:516:6818:6d74 with SMTP id d75a77b69052e-517fbeb078cmr31169311cf.34.1781262620139;
        Fri, 12 Jun 2026 04:10:20 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.45.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb620338sm18255661cf.6.2026.06.12.04.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:10:19 -0700 (PDT)
Message-Id: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Jun 2026 11:10:17 +0000
Subject: [PATCH 0/2] branch/push: suggest intended form when remote/branch slip given
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

When the repository or upstream argument is a slip like "origin/main" or
"origin main", suggest the intended "git push origin main" or "git branch
--set-upstream-to=origin/main" form instead of failing with an unrelated
error.

Harald Nordgren (2):
  branch: suggest <remote>/<branch> on upstream slip
  push: suggest <remote> <branch> for a slash slip

 Documentation/config/advice.adoc |  5 +++++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/branch.c                 | 17 ++++++++++++++
 builtin/push.c                   | 26 +++++++++++++++++++++-
 t/t3200-branch.sh                | 38 ++++++++++++++++++++++++++++++++
 t/t5529-push-errors.sh           | 31 ++++++++++++++++++++++++++
 7 files changed, 118 insertions(+), 1 deletion(-)


base-commit: 3e65291872de10c3f0bf05ea8c24187e7a71ebf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2331%2FHaraldNordgren%2Fsuggest-remote-branch-slips-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2331/HaraldNordgren/suggest-remote-branch-slips-v1
Pull-Request: https://github.com/git/git/pull/2331
-- 
gitgitgadget
