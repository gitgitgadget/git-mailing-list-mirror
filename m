Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DB879DA
	for <git@vger.kernel.org>; Fri, 23 May 2025 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003570; cv=none; b=eKNNTmYsCEWYVNRTJg+JfsfQeCIv3JNZ5Fs8kgfWvgIUPTMUR/cLpVYbQvG9O1Z6D0anCzUJoGfTWUci0BYZWk4S1kstSo5r/EmbeNgLmoNgB5aaV55pWM0qIYBN13uwRoszMNMMNSNczY6IRxqlriaZQ5vl1adEux58/QaFVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003570; c=relaxed/simple;
	bh=zKoEvsgzS/7Iz+hCuiCQUMTfdiwvYIWk2VUmvr+lR1U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VwqU0Rqz23/ntOdUBApPN7XSKZexnh7p0y9Bxoqsye5QNwR48pbOGOtHdmIS2IgT6cQR81hGcoU6Dv5SLstVd5b8jeBzQajm8YSQWYPYFxD8gVldkB9BDM9D5t+4QtRm1mtzylJWuE/cde9pCJAWVET/dzSWr4DMineoW7MWRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ux.se; spf=fail smtp.mailfrom=ux.se; dkim=pass (2048-bit key) header.d=ux-se.20230601.gappssmtp.com header.i=@ux-se.20230601.gappssmtp.com header.b=oxOZ6M12; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ux.se
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=ux.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ux-se.20230601.gappssmtp.com header.i=@ux-se.20230601.gappssmtp.com header.b="oxOZ6M12"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so75569955e9.0
        for <git@vger.kernel.org>; Fri, 23 May 2025 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ux-se.20230601.gappssmtp.com; s=20230601; t=1748003564; x=1748608364; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B2uNBSu5pbDeLWdnC4wYGvfoFaXKqQC3aMEwHL4pA6E=;
        b=oxOZ6M125zHkvdAwh8oDq2DtpERjIDAhz38lmj79VWRqjiFwdTKBlGh3teMjwMQXKM
         yfho9/oicAPxJKwrREHBc/rkRx+A7K5YnjQ/x1tWcSwqWEs90VnstPcjvTC38vh7z6DC
         3zpOCMw8RibgKne7l4GAOZp/mITd5AKLywS18UyUgv8EtConMvwq/g7O5JuUo/p+7vHD
         QiA09QsL/FlTuXvSkEwmQarbdQMgqfMfcIVyfVCp5DZssZrxpftudoLRlnsykr/TlVCP
         uqhcxovVyXkJySmhfR3dVrIaQh5Bd/yLEwBGzdl/N9BF0nS/qMXhj7oRFfT2JS5rC2Ij
         4ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748003564; x=1748608364;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2uNBSu5pbDeLWdnC4wYGvfoFaXKqQC3aMEwHL4pA6E=;
        b=LTb3X1TMrTXX/oM+HTQEWL/6SjaKerZDwTaRhRMF6g732R09cYc6Tblh7m1DPjVc5f
         Trrj+4iffX1yeOlUb0SiQGXGLq5xF/xHzyecdgy6hRpZ8ayr9BUjiKldviKvMEqA/rfl
         Q8bfKkqyCygvL7rpu+JcvCLb44EVA/ZWbMSecqOry9sLrz+Jpv75akPwDB9sFGC1iHnH
         z6dZuJH2JK+jWHSpA4XR2NNjkXncuXKfnBRSCeJ6uI6ACbxPymvAHljZFrXUzbfLGLu0
         6OBkJWUCABevLETUU0hnYTRVaUclDRaLamrtIfiZdPQKtDnk/pRPfHUzMhqnqwpXnen2
         WUPQ==
X-Gm-Message-State: AOJu0Yyrw0UYZyB4LDuV7/l9ojeBtzBnLNB8LNnZ99lMMwVlyz31luO1
	5rQyc7URUn/G1P2SKX3LUHRlbPO0FWN6JL/WL7nhIHYFlAZPq25/htQoi9UpOjnZmCxpfB51/ou
	9DDbva+89y+QXPoa7/iGB9pFpBoWgwZX10fF2ljvK4AtFW4fkdOYsdSAHnA==
X-Gm-Gg: ASbGncuWSfyNuG1p+vjK+GmLiTzAqGLxf0c8u/9wyCw9VNl0DQo3ni1B2/z0MijWxKz
	lS2QqPLWYGJ0UXZaCuEaF1M+XDMmANhjYnG72rsoJRjPhBq8rg/5zS/B885wcfUuIVI9GJ1PKmK
	mVmkSOCsIjK4px5CaqgWDTQJQVa2ENEUIy+g==
X-Google-Smtp-Source: AGHT+IHISLwekh2Ag1B3yoBcW/8+Qb7Diqjj8rpEPQEneTBuluRQzNWXJsY6WV3RHJxQ8RQhwleGvE9G8Yxkx+O3+Xg=
X-Received: by 2002:a05:600c:3e8d:b0:44a:4fe3:3a28 with SMTP id
 5b1f17b1804b1-44a4fe33c4dmr64193605e9.1.1748003564127; Fri, 23 May 2025
 05:32:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Max Rhodin <max@ux.se>
Date: Fri, 23 May 2025 14:32:28 +0200
X-Gm-Features: AX0GCFsGTGTAleyzhRwQxJvoVpz1fIN9fw23_Jqe53w0qW6x6pPzkXIOoDn55Gw
Message-ID: <CAOc+UT0n9pRGur0d4cORU0SMQY-PNs5ekLd=LX9xc940Og+nrQ@mail.gmail.com>
Subject: =?UTF-8?B?W1JGQ10gZ2l0LWdob3N0OiBwcmVzZXJ2ZSDigJx3aHnigJ0gb24gZGVsZXRlZCBsaW5lcw==?=
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I hate losing the why behind a deleted line.

When you drop code in a review, being able to attach a brief comment
to that line would save a lot of head-scratching.

Git-ghost =E2=80=93 see the remnants of days past in a file.

git-ghost hooks into commit to stash deleted lines in a `.ghost` file
and enables maintainers to prompt for a short reason. Later you can run:

    git ghost view <file>

to see what vanished and why. Blame also becomes easier.

No core changes=E2=80=94pure userland. Repos can opt in or out. Also helps =
AI
agents make sense of code history.

Could be made in thousands of ways, but unless the deleted rows are saved
as actual file-bound information, understanding it later and building tools
for it is much harder. `git note` could be used, but doesn't really solve
the issue.

Comments?

Max Rhodin
max@ux.se
