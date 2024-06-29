Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E315660
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719672167; cv=none; b=OkSXSBUmskV6KWrk3WrGHd2PfsCuMRGUhYzjO/d43jF59OrbMbMlKfxlRL4EWTC5LA8FiXZ1Zvrr+C2SxcWek7kRdVcMo4zBmsx1JVn3QmvWIeIO6fY1urR54mSv3D+oLRREa8uNsiUjKM6rR/QDq46pQREwDnoweg5FSaP7BrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719672167; c=relaxed/simple;
	bh=BJ4aYSidzujpUmkmqKrAoBPJp20b6e4Jjw5dc3mJp5I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iPxQniRD9ymbz2G/1LDxPWlz+xpRKVxB3OJmQuOr0vwvLStQ+A+Q522lVSSz6W/YwDuYOxmgfjSU1DolnUy5HB6wWd8fWHDQrPidS/nSrshNj7RIOlt+uDzGZGSN2kxqs4UwATmgv3saXrb5R8UZee2X5So5LNyR2ktsYLHA9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NutjdncC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NutjdncC"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so1901711a12.3
        for <git@vger.kernel.org>; Sat, 29 Jun 2024 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719672164; x=1720276964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJ4aYSidzujpUmkmqKrAoBPJp20b6e4Jjw5dc3mJp5I=;
        b=NutjdncCCHx1UY5zD/GjLApdvPBU+ZdSgGynxL0rl+ZqDKLEKp/POTrVcSswLwIZtk
         dthQ/0vqG+UdSCTK9fUu8Xar9ObarH0DdznDmt+g3iNJh27hgyuhaCeNchPFf3A7z1fD
         +c9eQyX4THEy8I4xKUK8QvOVYrgu7OvGrxt/oVmzBI605zsZJGqqjulH+oOQTt/Y976o
         xQSqo89/K1NhbYJ5465aubF57c+wvkt1m5Onak5df27O9JpGlJ7dHOc6JZwKzeC0/Gzu
         EOnUAUHFRiGVnDmPD1HhnMoA7Q9y83R211OxCcXABwuCFaWrWmJm7TEfn+7+xJOrwKbQ
         0C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719672164; x=1720276964;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJ4aYSidzujpUmkmqKrAoBPJp20b6e4Jjw5dc3mJp5I=;
        b=j/r/1dFpPHeY9nl+OtrTvkQQfGletSyAIF7DRElNTdFhRpF9RQ+qjRvlV30ohYVvy3
         LJ3a4Ft2rctpwYwrf30dNV+PXkQR5Wu8Nen7M6LVSZIcG/i7Rs+2ppbPce8/2DPjYn98
         0bG8sN/tE9X3l0F2wXj5+wEhjFbZ7SRQgeZ7zHW2CK6m7Sl0O0MmJUuxOHTgr6DWu1eN
         4yl+7Q6zvlA8CdMjl8D8b7YWbJ3s9ymKynHJhm529e+/LerLw3gQDRNF9ZdR+0hO8ZWY
         rNwGGT1TF94vDY6wkLecVLH2UigfSnk9tX05Kv54utfZZlwnwrYrNyVzbxxrKR4y/4yS
         atUw==
X-Gm-Message-State: AOJu0YzVBv309zQfgsLq5hROSXJ5QqgOOoxcDWwYSXfj1vHfpUZzhnfj
	1rHu9UmQOlbkApDYWdw9grKdxl5IgBQg4Iqxfr3uGmAcRwzHHyQkwH86CjXaWjoX/lW3hSlYbdo
	HwfG3IpifcnX/IH5kCPRxtYvSGfww/Jw9YVFfgQ==
X-Google-Smtp-Source: AGHT+IGJy5XYfSydaAHxbZ202VH8mFCMqCjgUJe2H1bfnO5UsF0qVrA1DptY2+hTcfbwdGqw7rNA60wh2CQC3ah5Zco=
X-Received: by 2002:a05:6402:26c6:b0:57c:cba1:444e with SMTP id
 4fb4d7f45d1cf-5879f2b808dmr914660a12.13.1719672164116; Sat, 29 Jun 2024
 07:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ZheNing Hu <adlternative@gmail.com>
Date: Sat, 29 Jun 2024 22:42:32 +0800
Message-ID: <CAOLTT8Sb4+_L7TrP8zZvvSqFu0MqbDanOhi6jfxfRLQKRimYzw@mail.gmail.com>
Subject: [QUESTION]: How to get uploading git objects via a git command in a pre-receive-hook
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I want to check the uploaded Git LFS objects in the pre-receive hook
of the Git server. Assuming that the Git repository during the upload
process is A.git, my current approach is to create an empty repository
B.git and then use
GIT_ALTERNATE_OBJECT_DIRECTORIES="A.git/objects/tmp_objdir-incoming-**"
followed by executing git -C B.git cat-file --batch-check
--batch-all-objects to obtain the objects being uploaded, then filter
out the LFS objects. This process is very time-consuming, taking
roughly more than 10 seconds. I wonder if there's a simpler method?


Thanks.
--
ZheNing Hu
