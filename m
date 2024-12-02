Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1115D1FDE24
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733139622; cv=none; b=t2dDnHLcs3fTEeI59R3uVqKako0beTX/CC68Ssfb9sMwWMsDCaHCIHt2HB56VUB3/nTYUeQNF6uYTHwTOKZz2n+vlksDvz+DO5Ilf2MssL3Yte1K8bXc+zdOCrKFk/1tOhbb9kevFfwmh8JYpIMpfCC3HBJZvlWZE5QdKo0XYec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733139622; c=relaxed/simple;
	bh=K37z3ulRQ+v6sE8H9mwH3Yqtgamlb9ke45clGcRnPBM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=m2yoc2M0uYBmgPF1NytLS9/bORKZ0TFydANmCCxReChJM/P/FeehCH75z0tuaGBoCIM2X+loo/IGLwpvptqjm5ZxI0z0imyXQqc/KAPbLjAk+W39KvsSmgnYpzUWW7gNIYraFDXxdtPEpM3QMXvFLIr7TRIl4wdkuzFA0qe2W/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrB+jNbR; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrB+jNbR"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4af3c833017so1200081137.3
        for <git@vger.kernel.org>; Mon, 02 Dec 2024 03:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733139619; x=1733744419; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K37z3ulRQ+v6sE8H9mwH3Yqtgamlb9ke45clGcRnPBM=;
        b=XrB+jNbRrFdkW59YNMcCuD9FBLK6K+uriUFSSLjO8TizfLPsQuvu6E8oB1J3/2/7OJ
         Hf5TDme5wcUkzLF/XQ5bA2XFbGnZg22rlGVU7O87dw6WF22TNhmufp3Ifx+zu5inqMTt
         fI5A9MOeFD3P1jjkaNmV0bmwAaUqBYbAn7QJ/vRBna5wY90tTtRtD6kybMn2kqt+dWsL
         cBp1cVhRGJDi8SBmSBAxwC6uxG+iKF8W82heZZYoGfGlns0VN+TUP/8AayypEIuN8sYa
         qAAwI0S9peXRKV/wZGzrplnE7cA+sn76LPNDyQUxI0gK6QuKFCiDQ7Y9PriYOy8yBcYV
         ORWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733139619; x=1733744419;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K37z3ulRQ+v6sE8H9mwH3Yqtgamlb9ke45clGcRnPBM=;
        b=XrE+1zkD5SC6hSv9irN4Zqf4k5ISFFFNJohfTpA8CYGSaoyrabInvTNYNf8n5FXP1X
         3UdBT7/tCAQEMj6CblXEWCTTUzY7IbSgHIvNwTbkeUwiJuo6VpHXcQEJ0oxJxeJ5i02R
         9c31OBxocpN4v/+jDbgRgX0rjV+eKuSoCBSEj9Ynfw0SzuiuJARCVuMfb1Qxo8yzkL+Q
         dseLNo+Ms60LtZPHs0TKtCRiLSFyEr5IM0RYSCBsTudbacbfBEzWugHr98R8zLW8tsGG
         gbCRVjEcU7g66CpUHouyHSqLapnjGNHhQJ4RN0yfGv5VKwPn9GL2zSEr0z7EzXTphyd7
         V2MA==
X-Gm-Message-State: AOJu0Yy9qwp12rU2BRjEMvYMmOsENxeH3GLmyN/R+A3kcr9S9rRZDH6f
	cF4+25aCptxB0qJxocEtSrb1NGHp977/0ImjImx4AEdGZkdQZouJrgXdxEdcaTsqdxjkr4Bw3y5
	bOx2iuMuhLw0dE8YBBIgz3YwpJEpWWQ==
X-Gm-Gg: ASbGncvC7c9As1SYvvXr5GaNMmo3iG79dPkDu8yFMPejIIjSaMJF0iOQoQPKx5uUbDC
	GLlydh/ZCGRNpLpudlb22S9Ga3qaxQf0=
X-Google-Smtp-Source: AGHT+IGcgqkAJZpTp48e9CuXB+o77kQsTPnpZYagFT/ZtQ54upcM4JiH2kwax/xxpvWGDY6MVvNch9Mzbi2WHRK6qfk=
X-Received: by 2002:a05:6102:5e7:b0:4af:4902:153e with SMTP id
 ada2fe7eead31-4af4902166amr17494791137.9.1733139618747; Mon, 02 Dec 2024
 03:40:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: tao lv <thebookofunknowable@gmail.com>
Date: Mon, 2 Dec 2024 19:40:07 +0800
Message-ID: <CAFePT4zytyuLB0TgyJ+mbrNvz=Xt1x+gJv4e-2j07YK7Cg1bzw@mail.gmail.com>
Subject: How to revert to a specific commit?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I want to revert the code to a specific commit. This commit is not a
direct part of the branch history; there are merge operations, branch
forks, and other changes in between. Therefore, directly using `revert
HEAD...commit` fails due to merge need -m.

I don't want to revert each individual commit; I just want to restore
the code to this specific commit while retaining all the current
history commits.

How can I achieve this? Is there a better way than using the revert function?
