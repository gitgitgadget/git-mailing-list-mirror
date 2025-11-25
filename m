Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06DE32E73D
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 17:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090076; cv=none; b=VzeCfEwpH7xosXZwsfqB06tZjgf8XQ23HFINXVNxUJUpaEt9ZldEHK/LujSv5CBdtaAA4oJR37AxlQ1G4vPYzMPxrvbroaeOJcKVIzC6haJNPivh9kqQkvrI9WXSzgX/WwYPWQUQe9UDKZiNyw4FxPtvP8rdxKYHyDPT+YyQFUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090076; c=relaxed/simple;
	bh=9hLPvY9oZ/TahsZjPMn9fEblQkYp4S3Tb5sm2MBmNT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1z1sPNM3IG22slDBewB8hTw4ctlHDv60OzTyDtUa69CHs23LdrTua/4At8cEus4A0gstded4OfHZv+K4oRZTNPEdYmgiDLTylmoo1KfwY9iueRuBa2KtDn7t6RVqGLcPxZnZG7VXJES4fSbF0RPlAeB7GIWHHdobkia901q128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQ/LTtfq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQ/LTtfq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so6596924b3a.0
        for <git@vger.kernel.org>; Tue, 25 Nov 2025 09:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764090071; x=1764694871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5b8aZHWrlmZQsjgdfH72Z05o3IyEEYclUaQoP77a7s=;
        b=OQ/LTtfq/ffHZmVVl1H3emxULG/tKg362SrFFvkxVcKJWZ9yFalaieKdasEZURA5ve
         VxhkvvLzVLrU7LVhFfAY+YRGsR1ywv240VSPEXJ7G530YoDQZCDCO1Ofduq1j+306pa4
         1KAnEna/9lvSISRdIF5t/aTHqrttdau/zv7UK5LVuW7msh9JddGrr6ce9O/4IPXnFtOp
         9qFcaY/wfN7oS4EcgUJyW1F/m9zsPyGdArXaIkvqMQPOXPGa33g64JIQPRUc16/Qb6i3
         BE7ud10ZGPBSfQ7m82qLxLsyxJ7H6zDBx+p8ASanT11IycaWH0M9Q5GJJ7okzcXpE9H4
         g9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764090071; x=1764694871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5b8aZHWrlmZQsjgdfH72Z05o3IyEEYclUaQoP77a7s=;
        b=lfbUdXzsmktRJ2/QvzowOxyucY79fFCK9vNQ98QWBFfulnIAlDWtuKrpAEgo2oKz80
         Fzr2/bToZAhsvE7I8geguN63qnvADexwnMzDwH46mh713bAfWcr4CQzwjklTOkYi90XO
         6+b6zeY8rxdXHy5r14J6Tdfpr916G64OcTDMSvr8gpZxKuJX5iAPwx4JukSqTr0m/3dG
         zAvvmEAnsmVkdLmfZNScsQk2mQGmVmZf4hCz6gkIrwGk2NM3/OKt90GkigLXSHqmssUB
         /OOgmxWik39elbO0Ypt3zbsFj6OgxAXn1g4aVKRIBEI+ZjzeUGSFg0kp66J/86QTshM9
         aMZw==
X-Gm-Message-State: AOJu0YyObrrRiW0h1IhBceKjJcU3UcXeMl5g3+2Vb7NAxhzJJS/vb2TL
	8yd553a71utu7Tz8yzIVQIdoFKBGKUqMOpK7f3NN2VZwpeizRhzJRXMhpMD9H7wr
X-Gm-Gg: ASbGncuKqxn4Z2PggeDsYmTfQz/mdde88LF4/FQznBzJpcVKByHNKDNvU5hOuJu3kbV
	HsFe5Hf77eUSs8N7U32YQUEIJFzblBCak0QCOfJ39qqytjNsq3Ar9ejlLG/AGEKXc3Wzlb1/0vN
	LQqa1YPrgOxJ+oelnWm6xy35cv5ZxcWMBdHdTYN40coOskHHWmhQqIAXnkYbDVOJFVQ7Uyor1mF
	vDSFZjH8lo8BI2M4eAPiMuRHDfNCf73riF3rtiPmQ4X3DD4rFBGYFhGIxmz7XUOFZ6KOBZ+xMH4
	ukFjCq95zyE1R0doIpuG3kQLYJH3O6j6iQaqDPReLae0q8ulcHNJqmx68iierCuLS0iQOfTrXtC
	v5zblBQvjfQglSrCQHhohH6ZLmvJkj9iffUKYr1pr1oUEpymxZ/+mUwgSdduB9YoZNr799IZsaM
	EhNangtuCJbH9LYQxiOKJFYheZ76aiyLVgffXZIKI7f/+rueZ0WtjAb3AHxke51g==
X-Google-Smtp-Source: AGHT+IHp8wuu0CuQ3+4nmJRkMajn+lcc66VODZhzRmVH2e/v4OcLofr9/+2qWh4wQWBbQBjyroJVLw==
X-Received: by 2002:a05:6a20:a124:b0:355:c208:b248 with SMTP id adf61e73a8af0-36150f4305emr16380249637.60.1764090069496;
        Tue, 25 Nov 2025 09:01:09 -0800 (PST)
Received: from localhost.localdomain ([2409:40e3:30a4:b776:b45d:b475:12df:68c0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75def6346sm17014834a12.4.2025.11.25.09.01.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Nov 2025 09:01:08 -0800 (PST)
From: Siddharth Asthana <siddharthasthana31@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	ps@pks.im,
	newren@gmail.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk,
	karthik.188@gmail.com,
	code@khaugsbakk.name,
	rybak.a.v@gmail.com,
	jltobler@gmail.com,
	toon@iotcl.com,
	johncai86@gmail.com,
	johannes.schindelin@gmx.de,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH 0/1] replay: add --revert option to reverse commit changes
Date: Tue, 25 Nov 2025 22:30:55 +0530
Message-ID: <20251125170056.34489-1-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `git replay` command currently supports cherry-picking commits for
server-side history rewriting, but lacks the ability to revert them.
This patch adds a `--revert` option to enable reversing commits directly
on bare repositories.

At GitLab, we use replay in Gitaly for efficient server-side operations.
Adding revert functionality enables us to reverse problematic commits
without client-side roundtrips, reducing network overhead.

The implementation leverages the insight that cherry-pick and revert are
essentially the same merge operation with swapped arguments. By swapping
the base and pickme trees when calling `merge_incore_nonrecursive()`, we
effectively reverse the diff direction. The existing conflict handling,
ref updates, and atomic transaction support work unchanged.

The revert message generation logic is extracted into a new shared
`sequencer_format_revert_header()` function in `sequencer.c`, allowing
code reuse between `sequencer.c` and `builtin/replay.c`. The commit
messages follow `git revert` conventions, including "Revert"/"Reapply"
prefixes and the original commit SHA.

This patch includes comprehensive tests covering various scenarios:
bare repositories, --advance mode, conflicts, reapply behavior, and
multiple commits.

Siddharth Asthana (1):
  replay: add --revert option to reverse commit changes

 Documentation/git-replay.adoc |  35 +++++++-
 builtin/replay.c              |  86 ++++++++++++++----
 sequencer.c                   |  23 +++++
 sequencer.h                   |   8 ++
 t/t3650-replay-basics.sh      | 160 ++++++++++++++++++++++++++++++++++
 5 files changed, 295 insertions(+), 17 deletions(-)

-- 
2.51.0

