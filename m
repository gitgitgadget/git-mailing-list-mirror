Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3672DB640
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621214; cv=none; b=ib/m1rIzHZSnKgGdGY2nXn/2r50CYRyymicmCBTgw5loJqhDoUilFrlUvKt5Ycokd9RN9DM4hvwYg/wP1uMHqKShIt/4FBcylZyVonvMgPsdDT0R+L4bpDUY79LquBM7B9hSPskWTWjFvvHFQBnXtYXP0IS0oepHev5lAlU8R4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621214; c=relaxed/simple;
	bh=TPyKnEmBdLg0YFaT+H9UjPuAEZnnErdeT7j7hK5JSSs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XWp5I/rzHqWVdwuVv3wwZnpQKinNAMH0j7gjcdIFxgCgfl3CnhEqQsaaMWsceft6T9ZKIjJlelf498B7aq0w5nri5w/gj4TrtwEY/gKZD2UXnrv+yXP+L9os9CNa2DdPEHmvqh6mqMtHc5/3mPqofHs8fLszMdrFo5gIxHs/uXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OttcAP5h; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OttcAP5h"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78a6a7654a4so5301017b3.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 22:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763621212; x=1764226012; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TS4fFtQd9ihPZu9cs2u5VhledGXSQFXVKRHtG5/i9oc=;
        b=OttcAP5hHIdmMlhEZ59OGTdm+Y6UNAvXR9r5+ArFeaBqPEWIM5vVQ6YZ4Gy9nDWKL0
         yZNMKZpvOTAtJhYRqPgBt9QpcZhuvOyh0g16p3GRfOhxWgpGDTgI9PZ8kdLOy45JNoTN
         j0XjDIDJn83jtEX2UM0JqfzuNPapH2G7v5qQMUUuFUNh8zeJpbluSp++tP4ToC3lHN6Q
         XFjg3FSW+mhHvkB1s+mypmrxnkgkrmnDtr8m7I47lz39fvwooJPOtPQ8I6sVM/iMbEU0
         CJulGjO9j7heZvRyqOeM3YnrYSoYkRbq8ClL32sh8JafjjO6pfUgoCwZW7omlPnSqX6K
         /2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763621212; x=1764226012;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TS4fFtQd9ihPZu9cs2u5VhledGXSQFXVKRHtG5/i9oc=;
        b=tC2LuJ7CQkoHBCVWuqRB+B3JedjdAwZBMyMZ+tY3CEQGca+phwkZ2H+koXyZlLdCyJ
         hOrh2jTxB1tEIpbfRfLUtWSxUZmc/0XaXdLIgJmtT2E6gXk+UprzD2c45LAK7fjUURSX
         Womrrvns0c5rjjY0ruIjR+LRD5cMWBzAHwltHJSODM05hzgvQsOi+1tKN7D2smbkoSDz
         /GTT6ivXlv+khfF8uAeASdfafsoT/o6IwqiWcOWkC4BEY9GDwfoQzBXdmkw89ubuyrUg
         m41Q5jwtHsZafcXNcdqo7nNVLqwPrd1Mj62EmgbZuj0njDQDdvvcu3oNanI9JKTsjEAM
         aF2w==
X-Gm-Message-State: AOJu0YyqqZEE+h/79u+/FfdckEdYKFBs/6oX0HZcePOVLUw3C1jgz7D1
	Mghc9ydqwR1JD90jgjySNEssjKkoZ0vWGpNEhsbzEtS0TpdxZ1z0sXTXV4Y4E0A/OoaU+9qNpsQ
	DtzA1VTuORGUWF4fY8JlbJaKHnO7C+3GjcD91
X-Gm-Gg: ASbGncuPQCyZYJf6i2kxV1rFvys6QRuYexbDm0qISSNiP0oBDql6/BkiUuoQ8wDWl9T
	2Ug5WqOzH39JWyRNy1GNHqTMKO4iDHVXyPoK56CGPCTqBpWxE350Y/Gm60eFNvBxzDHWmeJyXC/
	OXiccx9ZDLawFplsKfpBzFkOYDaUiLVG4MEliPoy3VLmwb3uwYpj6/Rt/sPbwMG9ZAwF7rg0lJ0
	PbBw6gDrKPl4AdlGMUDqHH1bQNXm2yuW+CZXHHlW5McWY+A0Tp41MTNoaVAa+aAI/iVF3q4KHur
	Ste9NQcD/mbWnJovQAYXP7RPxZsEtmuF+FNcs6GZ8H4=
X-Google-Smtp-Source: AGHT+IHalV4eNrsLW2mAOJMym6c7KbLc7CuXlAWo6mSl7nfW2nWKNihvAIn+POakkVgzWnXlN7B+ejkdqkGCgMTfKN8=
X-Received: by 2002:a05:690c:64c1:b0:787:cba7:55f7 with SMTP id
 00721157ae682-78a7ab3c581mr13624197b3.19.1763621212160; Wed, 19 Nov 2025
 22:46:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han Jiang <jhcarl0814@gmail.com>
Date: Thu, 20 Nov 2025 19:46:42 +1300
X-Gm-Features: AWmQ_bmxtOl5fu3ro5tT5CNe5aCv5MhZFTJa3_HdkjZqdwyDyH7LB5Zo1vTnvxc
Message-ID: <CANrWfmQUuGKWPc6JCzeCaa9t98ag_Lyk0G_Prtd8YmqP-TiRpg@mail.gmail.com>
Subject: `git config get --type=path` results in segmentation fault on value
 starting with `:(optional)`
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
git -c 'section.key-path=/nonexistent' config get --show-origin
--show-scope --all --type=path 'section.key-path'
git -c 'section.key-path=:(optional)/nonexistent' config get
--show-origin --show-scope --all --type=path 'section.key-path'

What did you expect to happen? (Expected behavior)

1st command outputs "command command line:   C:/Program Files/Git/nonexistent";
2nd command outputs nothing, $?=1;

What happened instead? (Actual behavior)

1st command outputs "command command line:   C:/Program Files/Git/nonexistent";
2nd command outputs "Segmentation fault", $?=139;

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.52.0.windows.1
cpu: x86_64
built from commit: 2912d8e9b8253723974b7baf1c890273b1a1c5bd
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon
libcurl: 8.17.0
OpenSSL: OpenSSL 3.5.4 30 Sep 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26200
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Program Files\Git\usr\bin\bash.exe


[Enabled Hooks]
not run from a git repository - no hooks to show
