Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBFF1411E4
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446088; cv=none; b=bR9dcDy9lRcfdM3Y8dU97g0BfKDcab/sf3hYF5e7BblvloZ36NXemHxLSyhI3k0CYNw9Avlot1+vUl4lTQPrzZd2OfFB+pyXqFlODcxiqaewBoUzJQz3cXBqrwbjPWkkFm+npwyau6ecSLT26umOsHGACW6rJQz16v5EeMRChX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446088; c=relaxed/simple;
	bh=Xe7cIJq57pP3LKvVgbPtOPZFSEpuFjov6MKZpzDkPQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g2j4cDY+3IoUCAfW45tG1PEsTNYfAPut8+NER8fscIMfw+x3ceU8Jz6fSb0smTiMqRBR+bFX43IWmF/p22AkDaz5MFgUMD+fl/WaHwCCjtDx2hlvvQQ5IHlJSBuGv0GmxcZpiQdkX/bIUTXozrRyGoCiLeYbJAOsvzLPDeeoy9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFES6Dt5; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFES6Dt5"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343f62d8124so634046f8f.2
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713446082; x=1714050882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=arnx0Z0MJdM3I4tSQKHfG5hYl3Ed7UPVDy3gm2crrm8=;
        b=FFES6Dt55LbioQ79aTVV+sjyef8KwfKUYW04lV7DrdSlIGUz3vyiAp4+ribsBe3EDR
         ySLh5+OG9kiQr1vAIf+t7cuALW5hNbLI0qZsBMEGDgA6Je5ROBbsdZFNP6zEGma/Ci6m
         3ZOIoU+7tCoO6byEZicnrKIS5te3IQmifcJy7ApVFOOeCXNShYfUdHoZzHk7gLTY/gLO
         KyE753TpUqWUwyszOxdF/uy9SzEa0YBLob3i8Cub3QW1VE4sRuSby4SI65XbTWI9wXwF
         VHKLOvJjEjg1W5BiGCyQcsvjpVJEHn0FbR0QREjD63KIxzOJzP/8ruIM8FvsAfDmxVjH
         bTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713446082; x=1714050882;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arnx0Z0MJdM3I4tSQKHfG5hYl3Ed7UPVDy3gm2crrm8=;
        b=d9eGFQbgC2VPllc2BCe81veUd3qgArJn9avnssDr+JuKwlweBwf0oENDayizRIjqUB
         EhoVW1H8qAykBDW10b3BYKO+lNFzHjUc6+ZdP+C7zyVAwCoZLNz5k685Y4/fiREKaZO+
         pytYJ1htrihDhTB5g8/Tm7vWoh72JR0lpGa0Xd2ph2jjXdsNjOTS6f6+yJOmHIv/C/tx
         +yax3kkaYz4KgN8MzTRZhomSGOtaeX/JyU4829EmomtLobauJNnjihq+RUxqMr/ITvTb
         zeiy9RsjgTcWL6vD/izACW68Kcc2ZxZBqnXPBOlJwn6Q2beGpHlZDXlsN5kSgsxIfuSS
         Tl+A==
X-Gm-Message-State: AOJu0Yzj/5v9fQLEbLCFLQUCVxy8HI6rvaKXnshThyrHZAtl12ULAZcd
	//9fKCXzTUlRY+Z1mU3fcm9SQPxvWZTdfCxyJa/Z+L+pp5Tnl36UhYbD6Q==
X-Google-Smtp-Source: AGHT+IFhyAyggTqHBgg5BVnWS6DeJXmRXgj4OXK9u26PE1EZhG6pf+J8lAi1ExB1IOlhPFBNIVJtUw==
X-Received: by 2002:adf:db46:0:b0:346:9903:d10f with SMTP id f6-20020adfdb46000000b003469903d10fmr1665722wrj.12.1713446082421;
        Thu, 18 Apr 2024 06:14:42 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c458e00b00417e5b71188sm2682748wmo.34.2024.04.18.06.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:14:42 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: David Bimmler <david.bimmler@isovalent.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/5] rebase -m: fix --signoff with conflicts
Date: Thu, 18 Apr 2024 14:14:04 +0100
Message-ID: <cover.1713445918.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.44.0.661.ge68cfcc6c2f
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When rebasing with "--signoff" the commit created by "rebase --continue"
after resolving conflicts or editing a commit fails to add the
"Signed-off-by:" trailer. This happens because the message from the
original commit is reused instead of the one that would have been used
if the sequencer had not stopped for the user interaction. This series
fixes that by introducing an strbuf to hold the message which we then
write to rebase_path_message() when stopping for user interaction.

The patches are structured as follows:

Patches 1–3 add private "struct replay_ctx" to "struct replay_opts"
and move the private members from the latter into the former. These
changes are largely mechanical.

Patch 4 adds strbuf to "struct replay_ctx" to hold the commit
message. This change is also largely mechanical.

Patch 5 fixes the bug by using the changes in patch 4 to write the
correct message to disc when stopping for user interaction.

This series is based on a merge of 'maint' and 'pw/t3428-cleanup'. In
principle it would be passible to avoid the refactoring in patches 1–3
and add a new member to "struct replay_opts" instead. However the
changes in those patches are largely mechanical so should be low-risk
and they pave the way for more improvements and bug fixes in the
future.


base-commit: 7bd541c104a2e383dd250f5f8e514785c4cabbc0
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Frebase-fix-signoff%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/7bd541c10...4c8f88437
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/rebase-fix-signoff/v1

Phillip Wood (5):
  sequencer: always free "struct replay_opts"
  sequencer: start removing private fields from public API
  sequencer: move current fixups to private context
  sequencer: store commit message in private context
  rebase -m: fix --signoff with conflicts

 sequencer.c               | 250 ++++++++++++++++++++++++--------------
 sequencer.h               |  11 +-
 t/t3428-rebase-signoff.sh |  96 ++++++++++++---
 t/t3434-rebase-i18n.sh    |   2 +-
 4 files changed, 243 insertions(+), 116 deletions(-)


base-commit: 7bd541c104a2e383dd250f5f8e514785c4cabbc0
-- 
2.44.0.661.ge68cfcc6c2f

