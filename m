Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784E5217712
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 11:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741346261; cv=none; b=E8wFU8SOlU/Rkg5n1HUBqO8a/Q5NuxrB/KXwhVZEWktIy/tm0H1YDjnrbG30GNIWQQgCd79QJi036PpE7YJuVlEacjjBopclcoCC35tY/86R5Ij+pEtTFN5YxX5M3W0YytzpowNkcgWdb+OfEm7e/w7sZKqu+O6oQwUbsd14ek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741346261; c=relaxed/simple;
	bh=RWTbTcrz1YAsjbkbskRzzTP2qZOaaChawAAhksR1yuw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z0lkfrOS2ifM55DuZNPMZ6H79rDP6IXdJCbByWFinCqqpK0zwJxIRBH3FANintUIp/wQ3kuG+FfyxJqbZ3fXasCpZ8IP6/yUL6BLf/G39AlDSWQO8ZEmT+0ZYp74+Xk45Cmq6QBNKjQ4zy0CWxYngXFkO6sNvXGCcB2+dk5e2FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFCWUThh; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFCWUThh"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-abf4b376f2fso314555766b.3
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 03:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741346257; x=1741951057; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SU2fAlxpxQ9hnsU7epeb/8WJDiG49FZyhjV4BGJIUMw=;
        b=EFCWUThh+OsuT9qEhxut6aC9JVMD3PRh1jQL7XMsLjW2bUcyeRhuDqih2oXOvSsvyo
         tpIjz5444ydup1U3GtEzRo5R5XT6hct1XNab6oiS8cmMlj1NgCMPx2HkL819CoI02j+s
         ntM2Abu+MlWetNln8WqXfrqfldpHAy96faWmJoWmBRKwFXQeHigjCngbnQMhOCYn6j5Y
         ueAl9fexrNybkOM6EFbcob/GNUjrz9x6u5WkPg9y5pVL5vPu097RVeVLYk6ylxj2xPJk
         vvuw4FH0v4yPFVU5rDtkejEXW6EvLhIhWy4DTxheFwLF9CzlkLcyf9L9KAwbFdzYgBzT
         t+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741346257; x=1741951057;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SU2fAlxpxQ9hnsU7epeb/8WJDiG49FZyhjV4BGJIUMw=;
        b=Mkwx3G+HIVo9msTFGljdQKfMAcXDTwxdlFCFIXwy3clA0vre93Z/3XuX8G2/Q8qTGL
         l3LkZHeqdNpBFgYSeaSV34ASeLrW4DFK99yeBEq8tB7Xnr9GgWRm55vfYV8CWm0Gakk7
         iiGgUTlNjgUzj/QK33Ts99acXr4ulpJeyGuVSKOtVlbrYt5mWtyul9wIc3QxSW/yU9GC
         pX6WO+Xjag45b49lZp00j1vJphI6zYoOsPRXiK2zDz5o/RVsh2dRy+LYk2V8KJApzOGZ
         7hMQHjIfcM3MBwj8HatoTcNVAir8e3nleAV7TI+oOtZ4yox+K9jQtjbI0A5d+inFqSbC
         84Qw==
X-Gm-Message-State: AOJu0YyE/I4O6SwgbMASSDZ6JjzDoCHRjkbj2ptQ/0Z/7SwqyIskx0so
	PUS27awXJU3n/E4Uv1nVFvxenSPibtUPO/wQ5r5xZ6MG2SZEVTuTFTtqRwmb
X-Gm-Gg: ASbGncsFvNfL9SNNXXRqkwo+GaLU4X7IXile4d09RoM10uieeZ2iKXKdWWmDxwMhQn3
	pjwghteJqCoSK9AXVUKq+O7HevFa6uTtkjrxmnnMI+Fo5Sp8qPJ8bgBUBYElmmqNLNXLP1oipZA
	CtBWvxvrbxCTDmeDCR2ELCyYsdeW/HOGiRJuY8TV6G8TgR6xlqVgnP++pzYKbNPTQtEWzRKD4C2
	2fY3/+o39w5rjANnGyeBK9i6PTC7Woa504EfrKEPTKsFiuvujc7WU3oGilOR/mpyjhZLjv2X4B6
	+LQkwUtz9MSMZTNc61cQ7HV03tq7VJWOhYixAFASn91O
X-Google-Smtp-Source: AGHT+IG6ZVFJ2y+f2UNYir1xSP2m0sO4YHMDDS8T9PsuO6oRbAPrR3wGSnXIQ+0HTDiw48i/McJ4Rw==
X-Received: by 2002:a17:907:7255:b0:abf:51b7:608a with SMTP id a640c23a62f3a-ac252738131mr298550466b.5.1741346257055;
        Fri, 07 Mar 2025 03:17:37 -0800 (PST)
Received: from [127.0.0.2] ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988bdc7sm261464266b.133.2025.03.07.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:17:35 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 0/2] EDITME: cover title for
 493-add-command-to-purge-reflog-entries
Date: Fri, 07 Mar 2025 12:17:24 +0100
Message-Id: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMTVymcC/x2N0QrCMAxFf2Xk2UBtO4f+ivgQl7gFXDvaKcLYv
 5vt8XAu565QpahUuDUrFPlq1ZwMzqcG+pHSIKhsDN751gV3wXgNSMzY52mixLhknD/FdkVe7zy
 gpGUP4pO9b2NHHCKB1Wbz+jue7o9t+wOK5RveeQAAAA==
X-Change-ID: 20250306-493-add-command-to-purge-reflog-entries-bd22547ad34a
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=RWTbTcrz1YAsjbkbskRzzTP2qZOaaChawAAhksR1yuw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGfK1c9Gz9Wur62OV2T4ErJR+RcvgPtPppklO
 U8yoQx9ejy3KokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnytXPAAoJED7VnySO
 Rox/n3sMAJKF8781ts3AO1b2f96Db6MvHb9yVWJ10lp7ptfRtK/61UTCxjzZsbFzFSFMPpvEkCY
 qrjMwLkagSBQ6CntRCqTiylWbLsD9jisMwZtBfSc7DTlB2BQj/2q3tIBZ+RA0eJ8fT9shmxk1p8
 tvY+1jUFBb9fxS+ATYn7wXrrxiDXE8Ja5tHfvSNhH01dY+hcgaHhxHZthgfkue9mREzp4Di4aRd
 qqdLiSe4Kr3GM0Nn0LEYaHinUBfXdWVMS2VHkxLFhg4EShl3z2awixS5bkT8YoPYVUVuEpI6ZID
 rTXs98ezkzI55I9JjZz5e9M8wgcwoN4rQlHVho8Vp2MOghJjWygltSB8xzJ5FFKOkcGVLSyK1lr
 1TcvXAGV+MY7MpYK6XRoHcCIsV5CwwNMdZE1bJNwgyOIhDpbUn2Rmxp7/6/pf276j7bBg0xgqPH
 yBb/Wv5Pr1BpMl0wjzqABN6IOBwkaHj8ypCjI5nkiz8WF0nlo/q0IeGgzAtyPB7GO2P21893hp4
 6U=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

 Documentation/git-reflog.adoc |  6 ++++
 builtin/reflog.c              | 84 +++++++++++++++++++++++++++++++++++--------
 t/t1410-reflog.sh             | 55 ++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 15 deletions(-)

Karthik Nayak (2):
      reflog: drop usage of global variables
      reflog: implement subcommand to drop reflogs

This patch series adds a new 'drop' subcommand to git-reflog that allows
users to delete the reflog for a specified reference. Additionally, it
adds an '--all' flag to enable dropping all reflogs in a repository.
This is a followup to the discussion we had when I sent in a patch to
add '--no-reflog' option to 'git refs migrate' [1].

While 'git-reflog(1)' currently allows users to expire reflogs and
delete individual entries, it lacks functionality to completely remove
reflogs for specific references. This becomes problematic in
repositories where reflogs are not needed but continue to accumulate
entries despite setting 'core.logAllRefUpdates=false'.

The first patch is a small cleanup which ensures that 'builtin/reflog.c' no
longer uses global variables. The second patch add the required changes.

[1]: https://lore.kernel.org/all/xmqqa5aqu7g9.fsf@gitster.g/



base-commit: e969bc875963a10890d61ba84eab3a460bd9e535
change-id: 20250306-493-add-command-to-purge-reflog-entries-bd22547ad34a

Thanks
- Karthik

