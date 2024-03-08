Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B21381C1
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907276; cv=none; b=ig140xd/OdnckPiHFc28ElmVfzgrpo7008Rtouz8TNzu+xJX6bxDVDkrJE1Ukoj7aLJ8CZZVP9f40YT3zGfc9b78Oo8u1tI4ygk11R4T8D7P0GXnj20Hwl++RL2emBf/MfAFUa6XzqJfWFQIKj3FgEk3W/GJ+QcjQIpabEhQQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907276; c=relaxed/simple;
	bh=TtjyXG1rPTIPiNXM08AfflrzLBkjwjCufq3WkDxKjT0=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Ba6oKoRg04hZk4qrhYOQCm5pM8Pt14arcLzxsEEKkeZax48yPUVJTmX39GwOJc4WYgyDzhn98U/7HD3amFz/ELz4Sxyztt9Jeo5zYEi0JjfQw1UrF8zvRPajU67BBh8ELAileZZ6StG7ILpAEmXAkLI/qUJkAkoGT4SJ61Ye/zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEzVbRty; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEzVbRty"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e6d364b7aso1138099f8f.3
        for <git@vger.kernel.org>; Fri, 08 Mar 2024 06:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709907272; x=1710512072; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2m658rC83JOdoYOJ0lf8/3Xq4KbQQ+bt89KAeckhJSc=;
        b=OEzVbRty7g5jTbNRzcxihUGtunO5Y6GidVZ3bZ8HeMA+0nb00e3Ok2lXOK1Hz5di38
         OJnKuJbD31zX1bUX/viQh8tOo6iradPq+55mUqOkX0r2Z6g5YsZAfHyCm8dtDzj2pxFa
         bR4Zl38sow68OLWUjqY1sO0CplvlEXlwncvXJtQaXuJAPMT1WYuzpUdTpWV5fX20cpt/
         o6WVkaZU0CHYQPE1PFd2rvLpi59CJRPogP2nq3PDYk9Uymi5iQ0/9ofaJAET2KK1NUZB
         Le0ylMXZTtB6xEUwfRXfDDgBFPmEATWa5sMr/yuIf5XDkxPlNit06EYMWTdpWk34s/7j
         6Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907272; x=1710512072;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2m658rC83JOdoYOJ0lf8/3Xq4KbQQ+bt89KAeckhJSc=;
        b=RCoXvef0iOCv884+Uy3Tj8dfj+N0H/RsZPXrNM+va1aRemaYdTG8g6AOKIwUcx2vDH
         sX0hO38jFeUoJdzqbtQVLd/DRAK9PO9jTXg9HFq+7386si7cjYzL27JIe0B8enVWfGI3
         7qE78co+FHJWZqvOsv7UdMvALML3TzPs8oVasGFoM1DwVE5HnfLcPDRLp96XTb8XTTBY
         e1zvelBXep72f8e71SsYXAzXskDpLgRqNWel5r4FN56MDLqzKNk75JgheHHE5d5QlEkb
         EuiZI2HAJNBHWNHuB6SCckzltfFb7Rm2gO4AR7R00ASNn5DF/LlfaDzwRCslBF8kjgHq
         gX9w==
X-Gm-Message-State: AOJu0YwLa9s5brsJlrjbuNbtliO5sCRvMz+ZJuElqgjygP45igG79R5z
	6cCQKOIO5Cim2+qcxUn0ISXEa2NlZsbk+jjAjtxCqvvRe4rHjvBIzLIA5/WL
X-Google-Smtp-Source: AGHT+IEQep/uWINE0xAJk9EmzBlY//EBgzc5iUFVB/ldRRioPOj2iVoB7kBZ8uu7BoLuG6ARJKfrMg==
X-Received: by 2002:adf:ce87:0:b0:33e:76a0:2fe3 with SMTP id r7-20020adfce87000000b0033e76a02fe3mr1626512wrn.61.1709907271955;
        Fri, 08 Mar 2024 06:14:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4411000000b0033e745b8bcfsm2362186wrq.88.2024.03.08.06.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 06:14:31 -0800 (PST)
Message-ID: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Mar 2024 14:14:26 +0000
Subject: [PATCH 0/4] checkout: cleanup --conflict=
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>

Phillip Wood (4):
  xdiff-interface: refactor parsing of merge.conflictstyle
  merge-ll: introduce LL_MERGE_OPTIONS_INIT
  merge options: add a conflict style member
  checkout: cleanup --conflict=<style> parsing

 builtin/checkout.c | 40 +++++++++++++++++++++-------------------
 merge-ll.c         |  6 ++++--
 merge-ll.h         |  5 +++++
 merge-ort.c        |  3 ++-
 merge-recursive.c  |  5 ++++-
 merge-recursive.h  |  1 +
 t/t7201-co.sh      |  6 ++++++
 xdiff-interface.c  | 29 ++++++++++++++++++-----------
 xdiff-interface.h  |  1 +
 9 files changed, 62 insertions(+), 34 deletions(-)


base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1684%2Fphillipwood%2Frefactor-conflict-style-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1684/phillipwood/refactor-conflict-style-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1684
-- 
gitgitgadget
