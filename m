Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23341208CF
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 10:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078621; cv=none; b=r2JdPJLPwvIQAz/lEppr7cjgmD3SZlRMzJE1/gT5ecRselB0MFZhT1rn4dsCuHR5WvU7Rs2it8cy3T21FC5CA5fSOvl4qEtXfWG2ckY2y/JzxCKAjEWy0ji1uW0wEbDCY9C3PjXX+EiQmcF/3fH7jIV6SHbjz+73YmmupRX2EJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078621; c=relaxed/simple;
	bh=bmO4+nnTB+XiMInpNZ5Hs+7r7cv1ErRjE6GBAuWE394=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cjS3WLAs+edzDp9QxuIaggQOqJF4y4hayw7cqtq+DSzafQ9D0SrGZt2yo7HLu/1JV3QkZH8AOPMVrrMa6Owifqu8GgTkJC9/bwrMzRy3SpG1eHlHacYD2vH06BoPoapXdMf2/Y7T1mb5rhivERpmq7DESLoq1fxYgZ0JlA+t1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=sPRDmyPz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="sPRDmyPz"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso1682308a12.2
        for <git@vger.kernel.org>; Fri, 16 Feb 2024 02:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1708078616; x=1708683416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pPsOAgcgZeUFmnm1oHy/dAWqslcAoGeoTt0Wt/wH5dM=;
        b=sPRDmyPzvIa7ULWo2lhzkCPxl1GW9WcvqKAivehuizYhKZLcJLLnZvGrUxhPc8U9rT
         tc+2I4DFAJnQjHEToboJ3VKyf79l+W7BJrClYD0isVBmzC6q7mFmj0/Ke+BLTwHZQXFo
         noysyql1FsvvE9b37UZtj5+ayFjX5SYJkYtE4YnRv5bQafYH6J2u/21gLD/j/kXw3F/y
         a6KNrEg7FstB64c5ZMu4FI3mRWRJA3GmLw3Yn+KQKSYfqhZPdL1gyi4NM8g9/0ZvsXIG
         qtcSQPMjEUZkl9E9s4IQDdZiDaMMtMaubxA1quQAloPeNfn1jTkjgJxaPgCY9GqCoIIO
         wpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708078616; x=1708683416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pPsOAgcgZeUFmnm1oHy/dAWqslcAoGeoTt0Wt/wH5dM=;
        b=oKuSIdy5ojeGeZ4uDhWPJAHMkqNTKWutRXTBEfUyXy9Os6yqzIqMaGNZTC32bV28eX
         1riyh45mFHdqEw67tLTymNgoDBBiUTw9bYr1MV+6G+qvF5ZqPi4C6IQYJXoyK+Ijzfbt
         M6urLGj1X25tsWal8A9bmTMICLoPPZMEGvlVAnEJ5YiRAM52NcPHzdGL8oPYRTRbO/3/
         +rTsMZe2kjYWVvYeQWLHqkur2h4/ibwobM7bOk+vQPl342HT2PBCARmO5RTMH58+LQdB
         hfCHHcDCjCjJj9EVXg0ZJouDS9jDqvVm4ej3fFokvQxTHW029cZqyQ6hp+GvId2tuY08
         NuaA==
X-Gm-Message-State: AOJu0Yz1ewEDYgzjyWUYDl1UqIysDQLZC9HmPjIZx487PUsXFsnRLYrk
	kRVXw80QTp07+yRmniBIU/sxHr9Oqfuc4L+yKK2GbfPBfUFWlBWTD3a691dWzAUDGNz5EYN5bs8
	IJo9IAA==
X-Google-Smtp-Source: AGHT+IFTC30Aace6+J94srBNSBC9ST5wvu2vWKdclLmf7fSZEveOapAjKf1Zz4MmBib5M8bupVWwmA==
X-Received: by 2002:a05:6402:793:b0:564:1c0:bf4b with SMTP id d19-20020a056402079300b0056401c0bf4bmr334342edy.40.1708078616293;
        Fri, 16 Feb 2024 02:16:56 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.192])
        by smtp.gmail.com with ESMTPSA id v20-20020aa7d9d4000000b00561fbfebdb5sm1337682eds.96.2024.02.16.02.16.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Feb 2024 02:16:55 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [Improvements on messages 0/5] Disambuiguate between options and commands
Date: Fri, 16 Feb 2024 11:15:32 +0100
Message-ID: <20240216101647.28837-1-ash@kambanaria.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


These are trivial fixes to messages.
They make sure commands and options are markes as such.
This will help translators and end users.
This will also reduce the special cases Jiang Xin keeps
for git-po-helper which will ease maintenance.

I am basing these on maint but I have also checked that
they ar still relevant by cherry picking on top of latest and next.

Each patch contains a single message fix. Each patch is sent to
 - This list
 - Jiang Xin
 - Junio C Hamano
 - The developer who last edited the line I am changing

These are nice to be merged but this is not urgent.

Alexander Shopov (5):
  rebase: trivial fix of error message
  transport-helper.c: trivial fix of error message
  builtin/remote.c: trivial fix of error message
  builtin/clone.c: trivial fix of message
  revision.c: trivial fix to message

 builtin/clone.c    | 2 +-
 builtin/rebase.c   | 2 +-
 builtin/remote.c   | 2 +-
 revision.c         | 2 +-
 transport-helper.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

--
2.43.2
