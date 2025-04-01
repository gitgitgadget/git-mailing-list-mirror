Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1408B203707
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 13:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514060; cv=none; b=AAW6suf2Dx8BvzpfzeHUus3wqWm2LI57Bg7yQ82a7TVHNobLrw00Lhatt8P/6I2xLtM2TKnDiE5k7T/F7oPKOtxbvGcHbD7Mxpujz0tY46MCYKp1hBT7cPpcdLhwi9iKrfW6LhMI98UaEgKBkQcZmSbEv306JjebQDSD3X6J74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514060; c=relaxed/simple;
	bh=Dxbl7RF8sXtB9wsNWxUaAHIh1iHst8eH65uMckTIIIg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VExV4lKnDPjUi4jBVDnVVI7tDfdclh/NkM4LoC2UtNPlISHI1IbdLQYjfhIqmxyEs07tHPgNG1QXAtSXgMR6yeqYOseWDvWnj0ULSKy3hvWkMp09ZvvTd1k5g9/9n+QcGJSKXQ0gforZMCKlIPpZU1T8tXs94vTexMpFn8+gpZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LMoV/awT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LMoV/awT"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4769e30af66so314881cf.1
        for <git@vger.kernel.org>; Tue, 01 Apr 2025 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743514058; x=1744118858; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMiiMwKgUKv67dNEaGqW/FOnQAM6+4bydLFjsTaUxp8=;
        b=LMoV/awTGJ6hBmD4vzuFWAk8dIPFsLmvbg4bO4cpYwrrbXT0NHUz9eU3Jq0DJ0jhox
         NOQ9wIp3Xq+lGZsvlCrJSOjaXSAaDRTPGCwDBQ9x+gITE5Bs/UGQvdoCfLDrpSMxIWCd
         GgUurPXme9K8LNq1X8yVw+uJC2co03Ect1X7WPRdqbiX1A2lgYoWOFnpcIAL26AHxhtO
         8aanFzFs6o6aoWFX/SlClkcMrIIiXrUWRP2CRWK3Ad5ihOb9S8VUSBsdTqnw8iN3RXnv
         PxUldHC3bAPVVTEd5Og9aTuWe493iA9Dn+0+vvEuyGfcNbDW38EOFaBsG8MjY8rAxGEZ
         lMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514058; x=1744118858;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMiiMwKgUKv67dNEaGqW/FOnQAM6+4bydLFjsTaUxp8=;
        b=EXMQ9q6Ik9LUoc6ZEWsyw1vz1fNXpFVkhy4VX/aw5DkwqddKOOEGkaNsBKcCHJRt3R
         KxH8Jv5ej+GLV56fmrAUsi8oBoSTtiCtlUnAE1b6z4NB74KEAwhkUoadSmQCEr1oL/BI
         X0rEpqT+xMSwMQiZQtKqqjwwu4DyG3oq6opcDohf8h3n8piM43/WwOoyXwwyxw9R1IGI
         oVQyQ/6gS8fudjuXtBA+bw1QhBZuqNsFfRzMGaTEWIsPpBQopSKsO9PxzU/13iCEH4kd
         q29t2mljPksPldqDJj+MZzpOLGVfA+irBVUDymJhz4nNi/c5vC4mpb00OgdW3uD7BKt0
         E/2A==
X-Gm-Message-State: AOJu0Yy2omFj1nZetbiEEc4JyW09Zxg4ePsHt5PmavEVr4BtgE+Vmlq5
	wv70RRTXO4Yg5DTT7osRmguMy3XfcSBDI2tVMI0VTApRFeYrUPrJqgZOhn/2gZUY8p8cCPpl22E
	OIwQx5oJVVGCzwF50P0aFA7EPTTQw/ft/J0FDMccsuhhcLG3uNKFEjPk=
X-Gm-Gg: ASbGncuGMNnMmC8apRr4zMiU4Lld5u6pTz/tu2KqaI4ZVaJBhq0Um6q4k4FfmAZ0jHv
	qYRohIvO4J00inTluyNZERtcpBAF63FgJO4Fm1FBeKmBLFrMCzbfdmh7QvDemHDSTB2J4kswSFC
	p8whMiAji+TyO6IQtgJsdyd6UpAaTFSh84f34byAvrYWK3Q9QZ55Yu3AKJ
X-Google-Smtp-Source: AGHT+IGEwk5DGV15gZBwtokynujq8vGd9blGPPkmChI04FEGAQhMY4RWCrGSx2x3f7NRxzgQtX4KfNRUNKmjFXx4BZI=
X-Received: by 2002:a05:622a:1a03:b0:477:1f57:38a8 with SMTP id
 d75a77b69052e-478f6386e57mr4656931cf.8.1743514057470; Tue, 01 Apr 2025
 06:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brendan Jackman <jackmanb@google.com>
Date: Tue, 1 Apr 2025 15:27:26 +0200
X-Gm-Features: AQ5f1JrVTlSj7Fp99wJnQjRAGYIzt1SwblnzCdDBEnbCNZTjHWt6b6h2BZHU_is
Message-ID: <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com>
Subject: git-interpret-trailers and period characters in the key
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi folks,

Just debugging one of my scripts and I found that
git-interpret-trailers behaves surprisingly on trailer keys containing
'.' characters:

=E2=9D=AF=E2=9D=AF  cat commit.txt
my commit title

My-Footer: foo

=E2=9D=AF=E2=9D=AF  git interpret-trailers --parse commit.txt
My-Footer: foo

=E2=9D=AF=E2=9D=AF  cat commit2.txt
my commit title

My-Footer: foo
My-6.11-Version: bar

=E2=9D=AF=E2=9D=AF  git interpret-trailers --parse commit.txt

Basically, as soon as any trailer key contains a period (which in my
case, it does because the trailer keys refer to versions of of
software, i.e. "this commit was backported from the following Linux
kernel commit which appeared in version 6.1"), it stops parsing the
trailer block.

My guess is that this is just that it doesn't allow periods in the
trailer key, and once there's one line in the block that isn't a
trailer, it no longer meets the requirements described in the man
page.

I can't find anything in the man page about why the period character
should break this. Am I missing anything there?

Cheers,
Brendan

=E2=9D=AF=E2=9D=AF  git --version
git version 2.49.0.472.ge94155a9ec-goog

(IIUC that -goog in the version string is just noting that we have
monitoring logic added to our internal Git built to spot people
leaking IP, there's no actual feature customisation)
