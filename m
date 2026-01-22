Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65238367F26
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102139; cv=none; b=IuvrmnCinjV8K9xckkce2hVHEIeqBbWQqF1ldk5PLqBxIdBH3vC+sh/Kn1h97UkQ5TrlxUXmRPuWO4EtrSTWV3HaXz8Zi3ZnKG5zGNrMlcVbZczWk0iDtluVXGf9CjZisffhWEy29UwlpvflErl3OycUt8+cWmvg3vMWmHkfu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102139; c=relaxed/simple;
	bh=c2VVnBJUyvGedCoTqwRLl4PZ/N4OFVeDqetvVcgIEjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=muNY4+YBC8xp7SNVemAOnFocA4sD931MrGE/jEin3054SL5AOVyz5g2Qg8d0SArol8Vads7zzeTOACZ1MQL3XbxdJZH57Z+L4/sCEBJcZcizwRHmYwDxSyBLuKzIS0ZEAzl6o8iAjrclvvsK45ONJJE38Xe6E3tFzGmg96GdveE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCiIhXUN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCiIhXUN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a76f90872cso7161925ad.3
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 09:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769102131; x=1769706931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zS/GxMdiJGDCeHk055yjjzpfuWy6c8ec4m8IN4L4FwE=;
        b=RCiIhXUNLgw6APUXmLoc4p5VUsZveUzlCnv6UtTwAO63yIvvFXRt74mQ1jB0cHL0K0
         AEMPXvuDVK0v9x5Ge2bkIygxvJYdcyGCkczvx1BDl+iCef2Og2nM5fEK1GHhJUX2Ynza
         IaCn0SLW2hk/xSKwQ6Ks4ireiyfoQTgRtOFqAdNQrfMLL0u7B0pVS9lq7Mmeb/SVhhye
         lqC5BY5eJCfRAEp7pjH2+rr85Czwh55+mvc4xOb9JE9g+YFQTqnLKXHTpUzPD66CG8Wu
         3VTi+fVUWft6KNqNRmSCExivH5LCr3HVwnq40wHdX0t3seDrUFUeJQn1x0P2f0rvZJ94
         I7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102131; x=1769706931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS/GxMdiJGDCeHk055yjjzpfuWy6c8ec4m8IN4L4FwE=;
        b=fE9VZXV2WSWk90iiWIfp+u9dB4lacKOy6LaVd4ohfzm12oqo/1MC9V1IoPZ0rr7fGb
         NPkh9iDQBihqto9Ub4VvNaYk7CX0+w26VbpMqEjyJuiRrzU9/MK4UIoXu1Bd83QlUV6P
         K+MprcE0EpdKn1dMqo1kcgha0LbJ+pq6RIr3R51OvBr0OnAMnpe8aghbCU4QZl721YWA
         nohSL0IjwiHy52tMdXT6fxy5mPnK9XutHUoJ4EUrrteullC+vbbOovpNAib+IdMyEVSE
         ZCK4mn0Nv9DdAyUjTZXMTGovC02T/MHHUT2e2Y722OO2GtkzDSFcxvfEtQ3lfMuJusVn
         SIyA==
X-Gm-Message-State: AOJu0YwLpJQMV/U69M+/i5Aw1YYvje6DfPGZ/vt2T9gxfozF9KX4Eoga
	iEw528Mg/6FD8j4fSfZnTzBgeBtuumRCpN4hdj9ddnxjSzewBTh6UMqrCMeTYxil
X-Gm-Gg: AZuq6aIWE4KY6ZS4V0YBMyaSVeoeFSkISLG0VwpaTsIOwwUZdQ7e8Or9mTZVtZ4VoWv
	QLAYFWfF/VX6qWh9x5EOX0TP43/3CnvubjiCRxAj5Y1BwVxzYYOZFQ8/zmhF9vR/I6S05e0ndD4
	Te3s4w9HFUfM0yw5lmnn0TaAupGhnxeN5qTz5RdtwsCa086qYxorDf1b7AejeqKHkChX2XQGZK3
	w9DeTo8mc2WDqofOfxnIMxMbzTZgeE09vJKXce9CaAq6iXj4PhUtKi9wUnQVv3kCHwY2ZdNQFkp
	MrJbPWESTESlALOmW/GY0WF+wwASegg5zClF0S3cDqch/0A6pdO7Xl3UwGlh9WjJwgJMPxyxmWn
	l6kM/Zkv7kZEgJIEH+sNxD+JOmCnV+cYYfugf2LnStUSeN5k7yvVjuOa5mWmBG1NaSBWeH8NOK8
	Q30+hYJ4w/YzRBpbHH2eD5ssjblzEpMlLWmVAJve1Kou1jNy5HuFJbin3abSf2p94JdSev
X-Received: by 2002:a17:903:2443:b0:2a7:f369:4de8 with SMTP id d9443c01a7336-2a7fe73eb13mr983295ad.42.1769102131065;
        Thu, 22 Jan 2026 09:15:31 -0800 (PST)
Received: from localhost.localdomain ([115.98.234.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a773d4e5basm81557205ad.94.2026.01.22.09.15.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Jan 2026 09:15:30 -0800 (PST)
From: Amisha Chhajed <amishhhaaaa@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	amisha <amishhhaaaa@gmail.com>
Subject: [RFC PATCH 0/2] Adding string_list_sort_u to replace combined calls of string_list_sort and string_list_remove_duplicates calls.
Date: Thu, 22 Jan 2026 22:45:21 +0530
Message-ID: <20260122171523.94234-1-amishhhaaaa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following up with Junio's suggestion in 
https://lore.kernel.org/git/xmqqqzrp74q3.fsf@gitster.g/, calls to 
string_list_remove_duplicates are almost always preceeded by string_list_sort
which can be coupled into a single method.

There are places, for example the call of string_list_remove_duplicates
in pack-objects.c where removal of that line causes no test failures,
however removal of string_list_sort_u version did because removing sort
is a more catchable behaviour by the current tests, this might improve
the case where we were unsure why removing string_list_remove_duplicates
caused no test failures.

I was unable to write unit tests for this new method in this RFC PATCH
since I was quite unsure why no unit tests were present for string_list_sort
and string_list_insert.

Amisha Chhajed (2):
  Adding string_list_sort_u which sorts a list then deduplicates it.
  Replacing calls of string_list_sort and string_list_remove_duplicates
    with the combined variant string_list_u.

 builtin/clone.c           | 3 +--
 builtin/fast-export.c     | 3 +--
 builtin/pack-objects.c    | 6 ++----
 builtin/sparse-checkout.c | 6 ++----
 help.c                    | 3 +--
 notes.c                   | 3 +--
 string-list.c             | 6 ++++++
 string-list.h             | 6 ++++++
 8 files changed, 20 insertions(+), 16 deletions(-)

-- 
2.51.0

