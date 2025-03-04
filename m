Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1779E27933B
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130704; cv=none; b=GToBO9r2GJOYrROcVUE3CaqSrN7DQtcDL+qBdadqrf+1oEf6yYqOJJdJEZmLiP0Kij3kYASEn5J2i2lQO1UGeN7dX0cVEdQ/pSwQIFZksusQopRrHfale7u96CVs/YvQIWpp/UDmElF7/OW8bv9WG5bLfDmV7FA3u6pfa0Q5lDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130704; c=relaxed/simple;
	bh=F/DjT1Z+FKxmKNz0MBQeTxbn7T5et3pNltQxgDo9HqY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LxrTDs2KalirKtg+o/DHbJVkABAOZx0/CNvbZPa6fCmVRVrS8MBtCBkGPE5ija0i560gcP3/HbMJs8g4OK4+/O1Ziq1J5ZhGJH9hbjuvGJZIX20Defqhu6h3vcrU8DARvsbcFtU8YAWztypxbyC3lvBexP1a0cc28hROmLOQJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRzYOUX1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRzYOUX1"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2febaaf175fso7880969a91.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 15:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741130702; x=1741735502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F/DjT1Z+FKxmKNz0MBQeTxbn7T5et3pNltQxgDo9HqY=;
        b=TRzYOUX1pv3DoQpWcTQjTnfooSXcbkNra5j+uBcKfbQWNvckIIgVoEisWsQrb74Wuc
         poSYke+9/K4HP6buFX7z+Ohvn3NadvbNfipnrvLi/XNhte8ZcA9FU3zm3Zv3vSnb2wcR
         SfBMQvXYbIk9NkyYuPoca2wXFkavWAzZkhaeFmyw8Wpd5Ux1W24MbOvjWrwDbEMoSyTb
         IOOLIH4a7y11Bu60R0XvPSs0czRajdLCRP9fov4UtYottXj1veLW5Vf95QR4X5Sz9hkN
         PjIdsdKWYrkckE/SWsaFJ+SKk17EX1ntgwF+0xAj4WN0s9oVFoaHB1JHkOTxqHmK9o8l
         ieUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741130702; x=1741735502;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/DjT1Z+FKxmKNz0MBQeTxbn7T5et3pNltQxgDo9HqY=;
        b=cuDGTThAHiZdmHIV1QA3xh1yarJIXGnVhJ1y2AXwt5tN5Nb0yjyCVDwCKX2rDelzzZ
         wlvt++5XoKM/R+HtGTZeGGr+RVyfBxnFLmAHtUExMWDSQ0EuuG2ENoM5pxWU5/EDzw2r
         +NxEAdazPsCwVygI/tJhLBH/2lhNucLK8UIcSRxhmwuTreldyeKX/qTvpoiroZogllsI
         6JV+XClSf+OVIk7KyptLmYUayRO4eHZDs9DjzqjEGIABLvFNtGVxn4MAGP5nskWfTKmx
         hDUEz+0aeII69d3qSvwd6+adSXpxn4o6Usxo17vrWSS/tS043cHW507OI5ADI7d/8Es2
         X9Fw==
X-Gm-Message-State: AOJu0YwTFw+sgqTcraft1Ui1PSWs80HA80sq9OQ31X2/VE2sKzATfvq/
	zlxBJPMkG3F1o3iptcDtMIFl+/UfwNFIxNBOUgjfU8Qgy/HOxuP/G5vGoLv26qSvMMZyXgAUSuJ
	JlHHmX6561yu6sKeQM/V/dPGJ2QtmGRseR+c=
X-Gm-Gg: ASbGnctarhOM5J73RMDnghZ8vRMyPVadsBGbR4Kb3hKOGuXAoc7h3bleDNsjhHpyoyY
	IwbE8qj/4XJc4ntB0dGEABrmYVd0NRertG+H67ECoHAAclQCS3i3pktUt8mKx17u48kuxSdkfbt
	TlVq5yM5VRcYDWIG2ReoIbNEshHL/u
X-Google-Smtp-Source: AGHT+IF0zsc6V9xJlqk59hvSqvKV0RwdVtKkm4KpqecTIy17H8b2f0gEp0FMRaC86a4thRXLuEtqCl30rXM2Gjm/03A=
X-Received: by 2002:a17:90b:1a88:b0:2fe:ac91:4667 with SMTP id
 98e67ed59e1d1-2ff49853d52mr1817847a91.29.1741130701858; Tue, 04 Mar 2025
 15:25:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Tue, 4 Mar 2025 15:24:50 -0800
X-Gm-Features: AQ5f1Jpw--Yl4f_wpi5r46TnAkNBymDRqdCGmihHinGm-6m6jLxQGMsNUBdZtW0
Message-ID: <CACCo2jkKraSnGUeRqJSuis9EfiubxEbm1dT2WZk7gfk9xjQ1rg@mail.gmail.com>
Subject: Failing to apply patch generated with BSD (MacOS) diff -- multiple No
 newline at end of file
To: git@vger.kernel.org
Cc: vrose@confluent.io
Content-Type: text/plain; charset="UTF-8"

I was diagnosing an issue in a separate Git implementation
(https://github.com/bluekeyes/go-gitdiff/issues/57) and noticed a
related bug with Git.

BSD's diff seems to produce diffs where each hunk in the diff file may
include '\ No newline at end of file'
(This is different than what the GNU diff generates)

Applying the diff via git (git apply) removed multiple new lines from
each corresponding hunk.

** What did you do before the bug happened? (Steps to reproduce your issue) **

I produced a diff with Apple BSD `diff` and it produced a diff with multiple
hunks each with `\ No newline at end of file` in it

For instance
```
@@ -161,12 +161,7 @@
 this is line 161
 this is line 162
 this is line 163
-this is line 164
-this is line 165
-this is line 166
-this is line 167
-this is line 168
-this is line 169
+the number on the remaining lines is 5 ahead of their actual position
in the file
 this is line 170
 this is line 171
 this is line 172
\ No newline at end of file
@@ -197,4 +192,4 @@
 this is line 197
 this is line 198
 this is line 199
-this is line 200
+this is line 200
\ No newline at end of file
```

** What did you expect to happen? (Expected behavior) **

When I `git apply` it seems to have removed the new line from each
preceeding line in the hunk rather than at the end of the file.

This does not match what happens when I run `patch` program. It
correctly seems to skip the multiple occurrences of "No newline..."
and only strip the newline at the end of the file.

** What happened instead? (Actual behavior) **

Multiple new lines were stripped.

[System Info]
git version:
git version 2.44.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /nix/store/4hnzq5yiv16j2k4rka60x3hnck9rrlxg-bash-5.2p32/bin/bash
feature: fsmonitor--daemon
uname: Darwin 23.6.0 Darwin Kernel Version 23.6.0: Thu Dec 19 20:47:53
PST 2024; root:xnu-10063.141.1.703.2~1/RELEASE_ARM64_T6030 arm64
compiler info: clang: 16.0.6
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
