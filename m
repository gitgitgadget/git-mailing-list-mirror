Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB37C157E99
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729899061; cv=none; b=BGtpp5GK0WtcMYbJEjSZKL+OFOCGgnbSQwVBYqKkJR824eBQH30jrcbCCvxQZ+TWVCOWLGRHi4jIaDUD4I9JxHbbysrsP2LoBPoaLJbhxrgJiZECq2nEeZacfMHjlI3RlixHvz2e08C+QwhJPfAa9zUemdklLo+2f7KWwqmjBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729899061; c=relaxed/simple;
	bh=iAO15gIvH1XC5QEcsKUdv3iBYcIHiTx9AurUXBX5U+0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oW13JkkI9prLQnNW2NQdujNetpy67LbZboomLhL16VExQO/zvfDIv0JJoNgKa2pAQmD4uGU03cePYoki4N5Ia2RDUdxUJWIBsl/OreStSmnh8XrC33ojhoMraHkYIWsrTsgZAbzZcxHeRuKYC5m/X2OkOGcGGLICXt5qL7V/+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJeYQ5S9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJeYQ5S9"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cbcd71012so25805985ad.3
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729899059; x=1730503859; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tanLOF0Tg5icNVhQAF1MtZpffUQJDjHK51aCOxJ/rMs=;
        b=VJeYQ5S9rlbS6NsjZc0Z3Z01DBDPu9eKaH9RNBoaMskm3QO/vlwY4Ux7hGVlfOkzv3
         kjKvQjPzpqzSMJC8MdMklEz4y44DjqiP5SeehfmBKZJuSWhp2HA8QgwU+OtPHYpCodwa
         SXt4nNNU/wBmvcIH85JskdSpsNbAeMfJ46vFY38MD3QnczQS0yaLrRxIkPKa/GHvQBno
         FN2U15J2j/aOLeZFimDk+ACCRWB+EFiS2yPnVpVlVu3RIjmOsRpEdMT4h9lj10OQ3cLO
         zA/Ft/CTiCWjirJ08Rl5slpyOEt+wUdntEVrXj5niQ4cdq9eqJXh08FaoL6yKSFWXtk0
         bIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729899059; x=1730503859;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tanLOF0Tg5icNVhQAF1MtZpffUQJDjHK51aCOxJ/rMs=;
        b=jqJ0n/5d/7jvg+8zgd4Qd6k9Y+4izaCV+rXluPhDDNM69BDUO9z2+aBG4bq1VgRb7M
         U817g2c5+hubrnawSWTxpJPKdQfiS0ycVvRWNA4+IfFJP8aXq94pRRSx/EYb1rkCjFUy
         CXBihItYg3MgAWDk1mm3rR8TOGR4eE9jYL3v1XvjrYa7mb7xpxXhLL/nt15IhOvsJ5vT
         +n9MEGdvEvuIz9QLtOb/FOxTNsQgTSw2sink0lXqRqCXYlAVZu+bX6gCqphUauQc7KoJ
         0BcYei72GdAnbLRUDr0IVRCw+c3JUg2W2mexlXxZPyFSo+H20a1J6+LXlv9SWiOvm5ST
         rllA==
X-Gm-Message-State: AOJu0YwIEkArQxfJvQSZHdPMuypNT7hkzQ2iO8mNZvr4bLw6jlG6bknj
	yZBW+x5RQWjukSPGdHL13Y4dqP43D2LspLgG/TI8nC/t34JfGXjc2F89F8NchupRrPs7qh5/fMj
	DCga+s9QJKCxL0OPCm0n+su1AS0fAtpioklI=
X-Google-Smtp-Source: AGHT+IEH1Z47yUvNpZEY6J1P/ZnaAFM0XVhkLE9DIobz4DoFPypPqTG4eT/JIaGHWXp2n/MK02om4zCgGjTKCCpcpPo=
X-Received: by 2002:a17:90a:644f:b0:2e2:d33b:cc with SMTP id
 98e67ed59e1d1-2e8f107a3f2mr1088940a91.21.1729899058811; Fri, 25 Oct 2024
 16:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Sattler <sattler.christian@gmail.com>
Date: Sat, 26 Oct 2024 01:30:47 +0200
Message-ID: <CALCpNBqfGRh3U6HpJDfUQyLOckz-hRJw2_2GRZfSFqXAyRY12g@mail.gmail.com>
Subject: [BUG] spurious failure when adding tracked file in ignored directory
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Adding a tracked file in an ignored directory causes a spurious warning and
exit code 1 failure (despite actually adding the file). Example on 2.47.0:

git init
mkdir dir
touch dir/file
git add dir/file
echo dir >.gitignore
git add dir/file

The last command fails with exit code 1 and prints:

> The following paths are ignored by one of your .gitignore files:
> dir
> hint: Use -f if you really want to add them.
> hint: Disable this message with "git config advice.addIgnoredFile false"

Suppose we change dir/file before the last command.  Then after the last
command, the change is in the index, despite what the warning indicates.

- Christian
