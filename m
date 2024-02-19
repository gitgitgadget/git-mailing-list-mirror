Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4744C75
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363342; cv=none; b=ar9i9IRGlU5+GIfqx1dZjXtH0LJW0oOthwLTTLC/DFg6DOP2/w7CoDLk1kZhu7tR8oiVr+6YVMuUDxuQcKeZJtIDpynTv7oEldIHYyjjS6nQhjD3qca8gry8ROcR691sN9UVJXzcCZuTDN5aZB8mcnk2Si9RtPVcETLgXo1bf0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363342; c=relaxed/simple;
	bh=Hn1Q61mLfFmRbi+Pt8Ev/hkFd4hWInfsllBtBwM8iG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vd33rUlzrPGl6M6AYwfCtdM3R7+HIS9ySGQGMfHw5MSuPHXG0EoxApkrzFxzeHuas1qcsZabLcxND/JLfLIUlsenyhNP6PxsLxfW0qr5xu7lztvYHXSbpxGRMcNUyxpHoeWPitDMMCvHyB+opyCZbM8qtBbD0uaE2trQRNJZYcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JjK4gVCn; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JjK4gVCn"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d21e2b2245so42480071fa.0
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 09:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708363338; x=1708968138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rXQ/a4Ib0Y1bHiJgbJuXCQ8rT2VRszZDk4oghNsfsdw=;
        b=JjK4gVCnHq6bdWakbxvOBZgaxmgRipf19KS/lEotNGVhRkZKdOyFAm/N+SGQFRMqpt
         X3YTWddLqfULKvc5mVM1rs1JewZDZJ9LEXOW/kJ9LDS0QGSAfsifs8VKWj4PkxlVPEyi
         EL5AgQ8guZEoDUZ9lG3YwvyT83MEvbDRf0CeLhpTGOvTtr8Lw6ocnUwviSlGVwkX4vll
         atHnbwoeDlQt0TS+y1O2VBRgXe9f31Gg8C4pAZEDpTNlX1+IIyDQw/aTcfOYhdIUpctE
         NGycHl92bZTULecriP3YwNPeuLJ9Rr9kNkj9//ozp3+QuYLtzzSKI0d1PJn+QpbpK/on
         Lu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363338; x=1708968138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rXQ/a4Ib0Y1bHiJgbJuXCQ8rT2VRszZDk4oghNsfsdw=;
        b=SQ/mJsD0kbx/RdrG52IMZtFJxYSjyLiKa/HMLR3dCxTGa8T3RjJr3KAoe3uTZJEDfk
         b4DKn4+WAbZaUIO6hHH13kIy+cHZPf7WrF5cSPlhjl5UpCt61/Eio8IbCvdycBIgXIfI
         3KZaBbftksImutiHDnKRIcFKTGvfMMi2SfYHkeaLX6D52ft+YXNYa4GZ32X0ebBb1PP8
         sWAnxxAMu01UwUSwdN5NQiukWIhIkXj2zA8ny/dH6lqDh1nOWdZcQOvc+ogwZIynB9cG
         5lNibqnVBxFzIq82m7W0+kQMXQLXKEefqhB8G3uNq7Yd3ccjmkcxyy4AzwuYoikAaK5v
         YMqg==
X-Gm-Message-State: AOJu0YwROPfMkKwCet5fvMEqNfKjQnqHpA05rTCMy3BnmS7ZWqjDjcf1
	Xiwo2y7L78vbuhV67+d5XOPuAk7Jjk66G0LBl1UL03dQbrHmeNYmNFfD9b505rI=
X-Google-Smtp-Source: AGHT+IG1KTdLiy3Zu5QoZIcQO13bY1yMQrIjrnE/uSb5I8AtjCrNfCMR3UegD84q1hP8GUK1PFmjTw==
X-Received: by 2002:a2e:90ce:0:b0:2d2:bc8:888d with SMTP id o14-20020a2e90ce000000b002d20bc8888dmr8169071ljg.14.1708363338048;
        Mon, 19 Feb 2024 09:22:18 -0800 (PST)
Received: from sacco-Inspiron-5559.. (88-160-103-158.subs.proxad.net. [88.160.103.158])
        by smtp.gmail.com with ESMTPSA id x4-20020a2e9dc4000000b002d0c381a2dcsm1242673ljj.57.2024.02.19.09.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 09:22:17 -0800 (PST)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: git@vger.kernel.org
Cc: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [GSOC][RFC PATCH 0/1] microproject: use test_path_is_* functions in test scripts
Date: Mon, 19 Feb 2024 18:22:13 +0100
Message-Id: <20240219172214.7644-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is submitted as a microproject for the application to the GSOC.
Upon previous dicussion[1], this patch replace the test shell commands
with the helper functions as follows:

- 'test -f'   --> 'test_path_is_file'
- 'test ! -f' --> 'test_path_is_missing'

In the context of this file, 'test ! -f' is meant to check if the file
has been correctly cleaned, thus its usage has been replaced with
'test_path_is_missing' instead of '! test_path_is_file'.

Submitting as RFC to ask whether there is room for further improvements:

Would you like to see something like 

'''
test_path_is_missing file1 &&
test_path_is_file file2 &&
test_path_is_missing file3 &&
test_path_is_file file5
'''

changed into 

'''
test_path_is_file file2 &&
test_path_is_file file5 &&
test_path_is_missing file3 &&
test_path_is_missing file1 
'''

where all the test_path_is_file are grouped before and followed by all
the test_path_is_missing (or the other way around) to enhance
readability of the code?

Thanks,
Vincenzo

[1] https://lore.kernel.org/git/xmqqy1bo5k5h.fsf@gitster.g/

Vincenzo Mezzela (1):
  t: t7301-clean-interactive: Use test_path_is_(missing|file)

 t/t7301-clean-interactive.sh | 490 +++++++++++++++++------------------
 1 file changed, 245 insertions(+), 245 deletions(-)

-- 
2.34.1

