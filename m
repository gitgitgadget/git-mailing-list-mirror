Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3252857FA
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506280; cv=pass; b=NGpojjZysJMd8HDZ1LR2hAaq+aZ9YGV7uow7e9kOCd2CC/8VVJOzz6X5FseDPC4UsLgfxMYfrdLGL5GjQHY5JbwbrW3jw4Wk5YTlvLCL2T5UN1TVzH6uaqkvKatpIUeGXBiojE2j5CpGYF3Zb41hTqoi0LVaYauzkO7nS12FMoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506280; c=relaxed/simple;
	bh=qhwG4SbOvGugvlRKPHGAa0CqxmkAhwAKsKhvX6gF1Qs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=g/HBx1maVBqWRXUKEJgZPb3JDlRk31M1Sqm+jFaJXy5VmBOX4MUgjlpzBRhIiKsWQPj+wFojnmUQ4nD27WyqUuUGE00/G7bxJqOVTE3byAQC5olgxKmy/mM7v2mniPY++W1t7jTcNHXWe9htQ78lHCFRKoLa0cyaI7W2/GlK4jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSaJ3ZNl; arc=pass smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSaJ3ZNl"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-560227999d2so1849906e0c.1
        for <git@vger.kernel.org>; Tue, 27 Jan 2026 01:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769506278; cv=none;
        d=google.com; s=arc-20240605;
        b=T/woN49qzeQctECfWlAagGU4kYTXFrpwAnOV+addfRbBBtZqk9YhnJCFITM4NvL2K1
         ge5K5jjonpwhQxk/JogUPfBZc+3akYXG6xFtFllTtrm5bxRyXlywPA57DK8pZ0aMvolR
         LbTRH9qsFun0ol+5kM+tairlXYI55OUa39OwIHGsf2LucAzaLYbT2JrWcuWqnoZVT6mp
         vZpjTyKXTTaQl/7X8gJhjjDUOmk29M8mDFXS6H6ir/tkAQOKH2dKZMz5C1O+FOpwXpoX
         hnGjXijVmdnd1RDaQkjjfxkq/xRncqg6yKZn4c/GC4D4FmtNxb92kqwGsEIrMqxF3m9x
         TEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=W/Cymd/9+Vo7gZV63CmcXLZbWoG2QgFQKmydPvRE8hU=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=g6VND5Q+eh8wju8Q506KWtYKFLFceQtOcmTfxAN/HBvPDahdmrwbHQAJ3Lp0XtH129
         kqMD5oUQ+cv/Sp5YQsLMRNyVBYPo0c2lC67s7YP1aZh60WjJj1ksehx1eTSfV0QyL/ZY
         tq4PkZUGNGiy2B5WHV54JRgRLA1tIg6p6lMk2yCFU5lnV5ym4MPtxLevWC9xSgUH+fwM
         ixyadxN3/XBFYV068J2Vtls2HNpD37rQQ+7DgntWzcAXjfLpdk/Enu43PucJKxzQ1NkW
         o0s+INGpUXXlO2gwBKW/rIfuWX/rCDJGUjezt27fu/WNK998EQOyrJlWNAUbuNkT36SU
         hetw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769506278; x=1770111078; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W/Cymd/9+Vo7gZV63CmcXLZbWoG2QgFQKmydPvRE8hU=;
        b=MSaJ3ZNl2EkQw+bXxdyUkyooclGlBwCsRua1jHTMgbGmd0ZTXZhNMjMIr6A1QQksvk
         /bqi4XXMeyZJNFXpNdnG82rPADKn6zR+Z3/A9MAmGaYqfmZfILesxPaYkG0Vt7DM+XFy
         KTVgu7ZCoWqf5YI9vm/e1GPjYm2zgJhqwgW4baKt7TxwTnaDUal3S/NLXzqoUC94TAVf
         nPyGMDoXFWUIs4imDJhjzEh02zyCwdh+Aa7zDOMcDW8eTwAzApdc3fnoQZzsmXeEnKu9
         qTUOOtjaaPG7xFMHSLfWsLG4XQ/moEdVIO8IVMUivYtawNnt7y8oH1yjBPpBC/C4uowO
         AutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769506278; x=1770111078;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/Cymd/9+Vo7gZV63CmcXLZbWoG2QgFQKmydPvRE8hU=;
        b=M9pXHRlCyzLxQWWb4xhRg7ouQYUMIlHXXpdeM0v4Mcd6cP3lbEUWNs+hsyEqlhpFVL
         EBdu7jINFQ3K9iIp6wQ9zf3KDsBwXp1SrOu9cCdNO8CNhcxEC95mweoAfC1t7IT9omh3
         EzdCyiAgNic5mQIJjcrnO0D2FTQRTmMGwCoN7DOfP50LORprtUQyJ4J4bzPleCqiHl2K
         pB/h783QofxtcXoUEmnbaVr4L4txZCpUEw6jXg5HxdI/Ko2EU7MNhdsocKIw8noHkzcj
         RItoUPSZkDBHPwvpjOeCYcbHEtVTSXTeir/RNKLeZnHQ2qW2zm2YhUNaZq07qEOkN6Pz
         mKUQ==
X-Gm-Message-State: AOJu0YxghEJcC2FVaNBzRz5pZ5r549RnI2oF0JDxvRTwk2qBAOJwjbvY
	u4Fy8gS3wbfLWCnmZs7a6vqUsr/zv0sq9HjEEWJB7cCkfbC1uACzTH9+ayAWfdkiD8lbZYqNDiK
	dS4u/FYJRVSV+caQK/FEv3nXKmFXA+riqNZq4tnk=
X-Gm-Gg: AZuq6aI7C5AQUR9l9vLfzP6VZDe/vlxL7okCJ0meeHAYg22YXqU5LxYIsC/KCxfnw9/
	7VslNuqAPHxZg4xsrjdy613VuBhMxjjUfL30yCpJLfwOD48z6kcl/wabtFyPHz2Nv8EJQifzzuq
	88YZNEuPQMHgL348rqf0Co86gy8dp0rtrIQS2lw3G7eiTivFcSTYW5Hq0W1IoHtenXXlt2jHryW
	ZjAzATTGhIaU54sSINY//6l+bjhaMQDEWT+10+/TQzx4qSzR/dXobH0rdQW/+XNo7IL9afiydVl
	+3PJbZBB
X-Received: by 2002:a05:6122:e242:b0:563:7b3e:d853 with SMTP id
 71dfb90a1353d-5667957cf40mr297311e0c.9.1769506277724; Tue, 27 Jan 2026
 01:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Simon Cheng <cyqsimon@gmail.com>
Date: Tue, 27 Jan 2026 17:31:06 +0800
X-Gm-Features: AZwV_QgkiA3lHO-9Sn73oyJjwEEyGSMHdYykG6tVkWxb5tstfYbPoF1nH7n1LME
Message-ID: <CA+itcS0iyqNyzOP0cueLg7B3yadoEr_VWJ-QoL+YPFUPJiE2RQ@mail.gmail.com>
Subject: Remote tracking option hint for git-switch still shows git-checkout command
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When `git-switch my-branch` is unable to guess a unique remote
tracking branch, the shown hint still displays an example with the
`git-checkout` command.

=E2=9D=AF git switch my-branch
hint: If you meant to check out a remote tracking branch on, e.g. 'origin',
hint: you can do so by fully qualifying the name with the --track option:
hint:
hint:     git checkout --track origin/<name>
hint:
hint: If you'd like to always have checkouts of an ambiguous <name> prefer
hint: one remote, e.g. the 'origin' remote, consider setting
hint: checkout.defaultRemote=3Dorigin in your config.
fatal: 'my-branch' matched multiple (2) remote tracking branches

Of course that works too, but it keeps the user guessing whether the
`--track` option also exists for `git-switch`. Not to mention that
`git-checkout` is now largely superseded by `git-switch` and
`git-restore` and is no longer recommended, as far as I understand it.

So I think it makes sense to either:
1. make the recommended command match the one ran by the user, or
2. always recommend `git-switch` as opposed to `git-checkout`

git version 2.52.0
cpu: x86_64
built from commit: 9a2fb147f2c61d0cab52c883e7e26f5b7948e3ed
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
libcurl: 8.17.0
OpenSSL: OpenSSL 3.6.0 1 Oct 2025
zlib-ng: 2.2.5
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
