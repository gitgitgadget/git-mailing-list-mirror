Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A4A161320
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743695082; cv=none; b=d4Hu9H+WgbWZAtyhXXp2J/pR1Our5nxppjru5lBGLhKKqmNns8493MvXrmj0WnkKqsb5cjXi2FG46QIidypvXdg4UNHgjoKEmK6Q0/0xJO3MTw1GKn53dM4UMXjzAD/XRcppLvvfd4ck9C+eA85wClmzXEPjDW6kK662jrzkkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743695082; c=relaxed/simple;
	bh=lMsDN04jOy2f1V/h+atMMFv2fZFO2cBQJPzzgZuWDFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ex7xodGHsuise17TzGknjTjTwe1HdL6jfmhXRRIW8yZjet+MCF5mn44pzizbLDvuATt0n+MVEfHUITMeNLGn1rsu4AOWnVYYsG5LswTVq+wyR0NBuDOD+t9ikZiYi2EFy2+QbLQbuqD2D/easvIQvyJks4rI/9DRbYdFAw8YMPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOtcNO9a; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOtcNO9a"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-af59c920d32so791232a12.0
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743695079; x=1744299879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/V8TNqItUsnx5hgEEL1Mmm7MbaxXfTze0UckZCq604I=;
        b=kOtcNO9a/fall1IpIP8ap72aCiot27gKI0qrjVdmUc0wO/Bftbg5XyjSrCbMaM7VIu
         yG0aQMsVdPLGWUeVT2gcEcl8qXxC8vxcrpwvJU+mY0xfXyu58DJ6K3rxRXD7iBFez0aB
         v4Enbck50bOBWbYP2HNoATb2eXSWZK5g9hc5exy6y8NzYwoBzr/283vvhizroLDYmA1B
         EtO5N+KG5Phr8c62CYjb09RWFFCMWg62qwGScvaya85mwDVRSSFNUvxr3Qg9G2Vj1ZC0
         Wi2aMhHjrr6XlA/ZEyo/RsU/69GNXPTvcfjTVHIq5vzoQxsgToTnV847XUuF9vKDbju0
         jYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743695079; x=1744299879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/V8TNqItUsnx5hgEEL1Mmm7MbaxXfTze0UckZCq604I=;
        b=V6N0EoLhFtuUPjgnaRnTlQGh39+opkDX98c8brEdlpT+0GeWFG5DEKhMkDPrUifWMf
         faN/ah74SbT9Qp9/FP5O+SHZFZQUCXkT/5fk7UhTH8//tE4ebZsUazegO2kt3WA6vJdG
         SnnhC+S5yH4PKHMCZGF9MnFVosWRTol0b5G/YwC3RqhMuAtr4nkQaHQt4fZZXSNwFUeM
         66N6+7CqdJGbQcOgKdhtxDRyX2xZj7ePh5dXm4oe5WbuYieUkd+EQ+VN/kKQzX/uuyA2
         0b5cRmxUdx7gokjQzlwgsaPw5tjTma3FZUgq9ovkhvY4WVj5BI4EEaRKLXT/AnvbEJBv
         6NhA==
X-Gm-Message-State: AOJu0YxoT5fpbiLQoHROqnszrwADYbRurZSijG21t59n5/8Rs8sdgDQL
	cCSoRj5hjsXnjbmptnQmIc+f8u5b4VBiucOzWGOQvmDyLETKBijVKUdLtjhm
X-Gm-Gg: ASbGncuLKa8yS5DcVcnOgdqyeYIivZbC2tRVJ5axH3nfVaork5GRB8OLh+RpnxrKOQw
	bc1Ysw2cruFl296AfeCa16TJJfAutExIqrxK5VdKBEuCYCOGi8RLmBWtbCO808dDIRGZ6Vwl7pQ
	MsVL4x+FbE/7vnz9U99K8fCYuz/DXKL8PIH8c6DMl6qdbkKzwtAANl6+uyQkyyRvJwPtBQC+mCf
	TYUHmLrfBBl64wmfTUjcIr0mq73QFM8vu360pn0tFEQI0yq1c6YruheP4f/3xoi02xrOt+HxU2i
	q1rZ6nxDPxwvxxqE4uBbd57DVRYE4lXf4FV+kWKSMQwiqZgnSUUgbw==
X-Google-Smtp-Source: AGHT+IG5kcykaMhkBDhV8ZTP0KST3o88AiShaJ5ZnWKJit1FuK8xrFoZ/w+MBX1ANmig1dyIMBKMRQ==
X-Received: by 2002:a17:902:c950:b0:226:30f6:1639 with SMTP id d9443c01a7336-2292fa0f3b2mr271135345ad.51.1743695079303;
        Thu, 03 Apr 2025 08:44:39 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad831sm16240175ad.11.2025.04.03.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 08:44:38 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org
Subject: Discussion on git-refs list Implementation and Possible Approaches
Date: Thu,  3 Apr 2025 23:44:04 +0800
Message-ID: <20250403154404.3459805-1-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250329150248.2274482-1-05ZYT30@gmail.com>
References: <20250329150248.2274482-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After an initial review of the code and documentation for `git-show-ref`=0D
and `git-for-each-ref`, I believe the functionality of the `git-refs list`=
=0D
subcommand can be categorized into two major types:=0D
=0D
1. **Filtering options**=0D
   - In `git-for-each-ref`:=0D
     - `--count`=0D
     - `--sort=3D<key>`=0D
     - `--points-at=3D<object>`=0D
     - `--merged[=3D<object>]`=0D
     - `--no-merged[=3D<object>]`=0D
     - `--contains[=3D<object>]`=0D
     - `--no-contains[=3D<object>]`=0D
     - `--omit-empty`=0D
     - `--exclude=3D<pattern>`=0D
     - `--include-root-refs`=0D
   - In `git-show-ref`:=0D
     - `--head`=0D
     - `--branches`=0D
     - `--tags`=0D
     - `--exclude-existing[=3D<pattern>]`=0D
=0D
2. **Formatting options**=0D
   - In `git-for-each-ref`:=0D
     - `--format=3D<format>`=0D
     - `--color[=3D<when>]`=0D
     - `--tcl`=0D
     - `--shell`=0D
     - `--perl`=0D
   - In `git-show-ref`:=0D
     - `--dereference`=0D
     - `--hash`=0D
=0D
Additionally, for filtering functionality, the `--ignore-case` option=0D
from `git-for-each-ref` should be supported across the board.=0D
=0D
**Note**: The `--verify`, `--quiet` and `--exist` options in=0D
`git-show-ref` are intended to be implemented as separate=0D
`git-refs` subcommands and are not within the scope of this=0D
discussion.=0D
=0D
## Implementation Considerations=0D
=0D
At this point, I haven't come up with a perfect implementation=0D
plan, as each approach has some issues:=0D
=0D
### Approach 1:=0D
`git-refs list` would support both filtering and formatting options,=0D
meaning it could provide:=0D
- Filtered output=0D
- Formatted output=0D
- Combined filter + format output=0D
=0D
However, I see two potential problems with this approach:=0D
1. Would it make the `list` subcommand too complex?=0D
2. The performance could be worse than `git-for-each-ref`.=0D
=0D
### Approach 2:=0D
Split the functionality into two separate subcommands:=0D
- `git-refs filter`: Handles filtering and filter + format output=0D
- `git-refs show`: Supports formatting options=0D
=0D
For implementation, my initial thought is that `git-refs filter` could=0D
reuse the formatting options from `git-refs show`. Perhaps this could=0D
work similarly to how `git-add --patch` and `git-restore --patch`=0D
share logic, though I haven=E2=80=99t thoroughly reviewed that part of the=
=0D
code yet. Would this be a reasonable approach?=0D
=0D
## Overall Plan=0D
=0D
If Approach 2 is preferable, I could start with `git-refs show` since it=0D
only deals with basic ref listing and formatting. I would then make=0D
the formatting code more reusable to support `git-refs filter`, which=0D
would focus solely on filtering.=0D
=0D
If Approach 1 is chosen, the implementation plan would remain the=0D
same, but everything would be handled within a single `git-refs list`=0D
command.=0D
=0D
I would appreciate any feedback or alternative suggestions on the=0D
best way to structure this functionality.=0D
=0D
Thanks!=0D
