Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3F1DE4EB
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 11:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730894171; cv=none; b=PfVUkr1ScgPzEV1erHehexSEbyh3BDi4eQV1K9oTHa2R7eeCwYAdq2rAggm5+yNILZj+cksixCTzM6HV+ZlraLo4034qRALQ2o84CXlFeWn3+jXzRLQRgF0qf73NmrzeMxYnqdKrP62G9pUyief0P2ogZ5U2WLNk+AvE+IB2LyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730894171; c=relaxed/simple;
	bh=OplWMD96HLIX8YTPBHiNMDAYLUSRHVRQI+AVRffViLg=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=j69K3PnaAbKQUvkMWlusz06ElFin0siHyN9QcZoJ2j8BrgJ452ohvqxbnKl1ziOrmSLoBlQC6ezVIaC1tEXSZ990EZ0gYK+vURaoL6rNGil+8rr5IBiqgTCBKyFj4rQKIb+sN/MTd/22HitZYsNztKp60OdPKFAjxrk0go4V+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiDwK45m; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiDwK45m"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a998a5ca499so875144166b.0
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 03:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730894167; x=1731498967; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:content-language:from:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OplWMD96HLIX8YTPBHiNMDAYLUSRHVRQI+AVRffViLg=;
        b=RiDwK45mIr+3ABbw9UiQ1ur/jQwYGHI/v2SkKZKjeL6QjnUQfSEjuH4nE3NBeJ7Lg6
         J7b4FbzQv3I6X41ZCN/xiN9k1nSrtU7HrN6y6edD0prtIUYO/8Ozj/g1V+5nLHGFHmdG
         RkYstzHx09pBPFzA2ohPTaUHFrxsJjRihT9HxH+8PZfibRYgjH+VPBqPBHwAx+P8tsXp
         U6/xfY3cBF2lTBYMi/jfBAHotdrv8cdlUvFwgzqz0628JthH6+GYyWV44x16hKuhTTSI
         iWnl8NnbZmOir/R9HXdemYZahxMhTI6GjYE5OH1h93c3cRSa0eCr2yxgjjmQuFrKtpyv
         Bw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730894167; x=1731498967;
        h=content-transfer-encoding:subject:content-language:from:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OplWMD96HLIX8YTPBHiNMDAYLUSRHVRQI+AVRffViLg=;
        b=mj/Z3WHB8LlrWFFLefHeDGthWpyV16pmDPyScJJacj/XAEaHVL9ijBo0hifjohAtDu
         nCq8yXEgqUoRAHwjeC0Mo041GMZ39XjArJG11269E5gp4zJIWmZ7J7lOnYkPgxRN8wcO
         iAmyULF5L8/BQtGCnXYsZ8O8wMAlJoYIa6aJGDFym74vv5/Z42N2YcH1cYcC2TGEe7WC
         S0uCKH0gUb/69VeXVufptws9cSCUobDa98jCj3NWxrXz1KshhygmofLqextcZ+I3ahZv
         hOi/DigiWyg+R3IpsmN9Ej4DrVSGoNqEcK1mYRld4sLAwJYbTm8v78rByPyDZUZN96R/
         SYiQ==
X-Gm-Message-State: AOJu0YyVZut+s9morVGofF35mahbku2BAqYuYNcR+QXYgUOPulPjEv/q
	Z9jptL+nBU6NxDAYXStmwlAbVR5tad2jog1usUIb+ym6BC8LFsQPkacA9BmvV+OfTw==
X-Google-Smtp-Source: AGHT+IGVZdKMAJe/ZZwPXCnImPIksDYAqyvSs3Asdq36CcCPtDTkGECZX09d8kHLfcW1qJQiCwALyw==
X-Received: by 2002:a17:906:c115:b0:a99:7bc0:bca7 with SMTP id a640c23a62f3a-a9e654953bfmr1706812266b.10.1730894166900;
        Wed, 06 Nov 2024 03:56:06 -0800 (PST)
Received: from [192.168.149.55] (static.190.186.69.159.clients.your-server.de. [159.69.186.190])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9eb17f96f2sm267131066b.162.2024.11.06.03.56.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 03:56:06 -0800 (PST)
Message-ID: <f1a8afe2-df78-40d9-9866-d49dc4057806@gmail.com>
Date: Wed, 6 Nov 2024 14:56:06 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
From: ilya Basin <basinilya@gmail.com>
Content-Language: en-US
Subject: [Feature request] autoresolve modify/delete conflict via
 .gitattributes merge= attribute
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi. This is also described in this SO question:
https://stackoverflow.com/questions/58767528/how-to-specify-a-git-merge-ours-strategy-with-gitattributes-for-deleted-files

Our proprietary IDE generates theme-cache/web/theme.compiled.css and the contents are different on different machines.
This file was supposed to be in .gitignore, but it slipped into the repo.
I was trying to remove the file, but other developers silently re-introduce it into the repo. Here's what happens:
- The proprietary IDE re-generates the file and makes a local commit.
- The IDE does "pull --rebase" which results in a "deleted by us" conflict
- The IDE immediately re-generates the file, clearing the conflicted state
- Even though it's in .gitignore, the file remains under version control because of the cherry-pick by rebase

I was hoping that adding a certain merge= attribute for this file would help, but apparently it only considered when two files are merged, not when one is deleted.

