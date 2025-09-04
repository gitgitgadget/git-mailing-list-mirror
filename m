Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEC2E8B69
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756989991; cv=none; b=PM+nxYJ53v5diC3AWnA7as8xGyynMlTVjttxPzkQaRRrakcX3l8fD3qoOodoR1bTcuWLBPFr0fGkr5FQPcCBwDAqrSsFiKv0nncnJFn89b1XnFTjXnU2gOWlcvJLi8GntQRZU+y9xEPRCRDcrUkRvibZ8nwmKYuZ+wBs6vqpTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756989991; c=relaxed/simple;
	bh=EkbexpfjiEPpLiqCHAuJh49eRpuHFrGxiFxjCw0ZNMg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BnX/hgY+YGYWBG85Xb9nc/mH0fvSLYR1DrJ9PlHIj5otqzDRFsUIn+znsuD845Cg3TUnU2javIebzF4CyqtI/T3WhssvwNuzChcyhiBNUG4bLoTT8ff2c6/WFHL1tYGVahLZp4H1x5ZrHtwMMk7azptqxxDP53HHTrlBSJPvqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNkprNd8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNkprNd8"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f7039aa1eso1055332e87.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 05:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756989986; x=1757594786; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EkbexpfjiEPpLiqCHAuJh49eRpuHFrGxiFxjCw0ZNMg=;
        b=KNkprNd8+191p6TlBU1aUvhDLhf575xwvuEbjMkt9eCva10T81nXzh7Jlhtntkymic
         Wm5wQSK1FcAHeBKV7p6B8m+/PjRLX0aOHYFX+jWXlXXX2eyiN/qOyqbRXX/tf40/uXBv
         S4C6Rv2Bi5oGdKH3QYex4NeyI8k5cWQsH2h8T662ISsZFVLoaKMu3qm7xRiBhiXPLLse
         Nulm9xAMIuEcmzmEyocoB3Jns0p7is+6cb2FcNxrnDQPhw1/zvPSTXkBqD0A4uGFz6ND
         o2/er/SNvGetqVQYyqQ198H8wV6vZAP+CIr++HpVBO6oOGXS00xNMB6uHXtIwDfYGiqj
         XyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756989986; x=1757594786;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EkbexpfjiEPpLiqCHAuJh49eRpuHFrGxiFxjCw0ZNMg=;
        b=PUeSIUfsgQC2VVZ3kS5FnbwjtPE+QUn8CwqWDb0KgD+FXwiI8ZhKFzz8OUWVE7Tryq
         bk192bXOs9B07NYkO/5j/g7u1/mddZUE3j9lfGBZ/Bgi0H8GQqNlfZN5d4/oiDR1YKfO
         FFEhMgBuaNr6QOpzCqzbvvuozOyytoQDY0koBRMQdBBylz3e3MJBisnYbA5dFTndc+KJ
         zJAf593zeOkfxt8GcwR6gXDTqPlMg1IHk2E10ZQWdcnCVK/1ZAvET+udtoevEGTpTFHw
         fAGA6xuIa1y/hh3mRrplxyvjGfg9Opgp7T3jthQ25+R7ezyzgkomW4gVSBRjqq540mN6
         9JJA==
X-Gm-Message-State: AOJu0YzwvNBSSqPyFle2UyJlDeh89TUvq/hhkIy2P2cc2gT70uV55mVJ
	Fce828qwB0ehql0PEpO8q53J0QdihrnnAdXmlifkRny/Vlbd/LG8BY54MW9mPNrM2QrWcJj87mf
	soiE2mUGYR65ZaHTzz8tin1e208l7y+tJzipLZZg=
X-Gm-Gg: ASbGncuyP/Rs39TouLIGUwVIA3vKyiosGSotzqt7shLbNMz244Ppy7PVb5yiSjmy0ds
	1HBc9VOxkPvHvrka69jAyBSwcTP6bYuE7r2yzIZWsIdBuB7mCjlxHT2qPsBZkD+bN2h0+TDbRxj
	4WUCvCgFaMioi+3qvWpcReFrdopbjZkODAaccJnQxSDqE+OR+s4ENVkuK+OZ2U6Oo0D2ZAC2oR5
	UdN
X-Google-Smtp-Source: AGHT+IFeLTSd3DyfxzqRhl9CmlSbGMHk3CXZ29swRXGyJSo5zPdj+IF7YXC+YhTNayrsxNw2533LS0MJCwgXWJ2Zl1c=
X-Received: by 2002:a19:6b18:0:b0:560:827f:9ff6 with SMTP id
 2adb3069b0e04-560827fa7cfmr2565303e87.57.1756989985991; Thu, 04 Sep 2025
 05:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Devste Devste <devstemail@gmail.com>
Date: Thu, 4 Sep 2025 14:46:13 +0200
X-Gm-Features: Ac12FXwdLncNN9J8bsL4d4RWemRSoiiLNAq_uC2qUOQCVC2nKjwpFTfcwe_m97w
Message-ID: <CANM0SV0+t7x_VTtZNCO8rKo1vvxhJjwEdmjLDN70njxCo7DofQ@mail.gmail.com>
Subject: Config options -c in rebase --continue not passed to
 prepare-commit-msg hook
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For some reason neither environment variables nor -c is passed to the
prepare-commit-msg hook when rebasing.
Other parameters (e.g. -C /path/to/repo) are passed correctly/it's
running the command in the correct repo

Reproduction:
1) Create a prepare-commit-msg hook with content
echo "prepare-commit-msg hook"
echo "$FOO"
git config --get hooks.foobar
exit 1

2) rebase a branch with conflicts. After resolving a conflict run:
FOO=bar git -c hooks.foobar=hello rebase --continue

The hook is executed but neither $FOO nor the config are set (both
echo an empty line)
Output:
prepare-commit-msg hook



Expected output:
prepare-commit-msg hook
bar
hello

Git 2.51.0
