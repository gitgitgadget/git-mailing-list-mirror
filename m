Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D64C385D84
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001740; cv=none; b=uPITEBLoNiPk4LdaEUvaVAdXto4lzFNN8+3vNJFxnZxX00W90vrhTtsCw+9QAwR5mmCUkAaSRXa7H2mjorH17SaC40Et0zZLa56h+L78sVIjEvmeJNxstAR5gJoNqiER9ISHPNQJWdCLc7zuoNZbZvWq4NKO1XY1z9+cGaN/Voc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001740; c=relaxed/simple;
	bh=smtPbgIn8+7fsPu1EHX2UOGXEK0rziOFzd3ub4E7Bdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBdiLdd0ULJZkAw4ppaIgUAmE/a3wTZhsuwYP8XjPkmXVxeCM3+fSbZ0uiQ6B/VRu4ZJLofRXft+vMIyrkj+LT0QUAFZpoPKJymNC3UQYyskz9fTqfrY7OpA12uC4LteeJ156wc92n/RrXaQUEVBdWYoKFW/MesiZky232MBSko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKvvgvMb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKvvgvMb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so17749075e9.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 03:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781001737; x=1781606537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYuKCq3sHlGk7fadNwRXAXJVJti7XbER4U7eN7yEIJw=;
        b=hKvvgvMb8MLgqG+dozr7RxOigjTEqkZaL0XrL5onro/wSI0v16LEO1VHnp5wiXDFsP
         QyICfYkGcmq8AtdWNhdRK3CzFTxbQg2cnhqPmF3H/OdgieuEzGdmStxv3v1X6lav4uF6
         g4UpftqZ3RzDyLWm46TzQbOZqgrKNgCkvhv1ub6cacL29bNeRbQNyXzIoaduF4fmWM6W
         n0y+lMIDLB7I4RAH1GSZErsrtRT/CrF9GF3kaA/KFvleNiEs3B1KdN00Z47j8MKEv9n4
         Kmi54m4ew+AsWz4z7SfTtZwdGNSQkoKM6u66GbHZbzNwSRutRA8+5unbtwYnrLPHRmqq
         dfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781001737; x=1781606537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYuKCq3sHlGk7fadNwRXAXJVJti7XbER4U7eN7yEIJw=;
        b=Q43Ucdfn/l/hz19NV6jQp7ghaj24hQr2fnthiwSgTEzd5cocHI/szN0CzPaoi6rEAF
         3RDdrH3zTl6MAf9NaDRDhHPmnanVIy6gAmDTOFzJw24yJM+xsiLG0pQRFIUaklKtfY9Q
         MInT7vp+TrNi8356CyNoa8pTge1Me+s2zKyfcpWd+iQzWitCmVROjK9K1WTYfmn26z7A
         ttA5TW0OkfH2doIWaDqs2m7uJ1s99QieJOiJkTU7mMbNK7bztBdQTVFPU+V8mA3RqM75
         QyC8l0KgpHssE+QRkG4rRg/C0KZFpAxXeAF11Um3YQPjAzCE7AurovXBafO0vHu7s8gZ
         iRLw==
X-Gm-Message-State: AOJu0YzAaAoKeypsiaOjK7ZDEjY85rVRa2BpMoeZLn6H1WF05PpHN/sO
	fJNkI8Sdgb87Sqznt1QAA5Qa34ZCFNb32NGOC4xetsqFOc3quh3ZURpHHGUFXlHe
X-Gm-Gg: Acq92OHxlG/a8yitKEiwqRyCr0VO6jXKozwa8SOvDdDzHjYy9Z2++Rd0ii0qfZeqlUv
	7oh63M8HlQLAjVDuoeeqkU7hekUu+6clBoFdm6VHUIbRiJysuQ1s794/XpDYDnoN/NkFiZSTlxs
	6ooFs4Vy3z3DW5vilr52B8fAqJByWtkhTi7MGhGsdTqnRwjbk97nLZAqVzMXTJXD9M3cmPOm0bL
	yyhEfsnzYSDlqYLqlVSu6yFGHbeTPWHRhtD8E6QiQx8FoHYGQEg+nvY6a+5ciQlgs5A6hUz1zOg
	5cSz+Bnm8DiJW1+kL6c728UUIRoMYOjOpYzAzetIdXwCbPa+L1mBv4By0/bxYVqkQIbQ6VX798H
	uC1IHAnad6Dgwj4genzSrJ28Em+I2Jf5/HV5Yk3tYMvJW2Ib/evDe/N2CrCKCa5TNGog6xeS+Wc
	A7/3RBG8SZ5306EyTu7+PTQqgTes/SV7dabn3+PJY424Gp8xDcD6IPKrhuzhq+2dPv4duEXYVG7
	MhoImrvmbZQV21Yzz7KdWWMEEjelghWwPPzFf+foM7ivvnfzSgtvmTKEvPHj0Hn0+pA3j3gw2NR
	Ud8c9lF1fSHQymBA97qru4mcGyy+MPOwjyUsIUApnXyfzRZFS6nhGt5RoQbBfeBtZdry9EoHRlZ
	IuGOQpYyMz3pxJHpzoq0LPzad5yitZ1EcyldtTY+VJac=
X-Received: by 2002:a05:600d:6446:10b0:490:8fd1:72a with SMTP id 5b1f17b1804b1-490c259a227mr219295945e9.3.1781001737156;
        Tue, 09 Jun 2026 03:42:17 -0700 (PDT)
Received: from localhost.localdomain (static-21-4-87-188.ipcom.comunitel.net. [188.87.4.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e59f5sm499692345e9.14.2026.06.09.03.42.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 03:42:16 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: cat@malon.dev,
	ps@pks.im,
	kaartic.sivaraam@gmail.com,
	pabloosabaterr@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com
Subject: [PATCH RFC v2 0/2] builtin/history: abort reword on same message
Date: Tue,  9 Jun 2026 12:42:06 +0200
Message-ID: <20260609-ps-history-reword-v2-0-a0e6028ca9b4@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
References: <20260607-ps-history-reword-v1-0-ba43a3cbb81b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260607-ps-history-reword-fcb70eaa4aa9
Content-Transfer-Encoding: 8bit

This short series aims to improve the behavior of `git history reword`
to abort when the new commit message is the same as the original,
avoiding unnecessary history rewrites.

`git commit --amend` and `git rebase -i` with reword share this flaw but
changing them faces not just technical challenges but also breaks what
people are used to, so that is not a viable option. Let's take the
opportunity that `git history` is a new command and handle this
correctly from the start.

This is made so any other future subcommand or option that does want
this behavior just has to add the abort flag.

A questions I have is why don't we want this abort behavior on
`git history fixup --reedit-message` it makes more sense on
`git history reword` because if the message is the same then it has
nothing to do while fixup can still have files to update, but
--reedit-message is still a redundant option there.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Changes in v2:
- Changed the reason on why is this needed.
- Changed tests with same message to use GIT_EDITOR=true instead of the
  script.
- Abort on same message only happens when its own flag is set so no
  other subcommand that does not want this behavior and depend on
  commit_tree_ext() is affected.
- Dropped the feedback on successful reword for another series.

---
Pablo Sabater (2):
      builtin/history: refactor function signature
      builtin/history: abort reword on same message

 builtin/history.c         | 21 ++++++++++++++++++---
 t/t3451-history-reword.sh | 16 ++++++++++++++++
 t/t3453-history-fixup.sh  | 22 ++++++++++++++++++++++
 3 files changed, 56 insertions(+), 3 deletions(-)
---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-ps-history-reword-fcb70eaa4aa9

Best regards,
--  
Pablo Sabater <pabloosabaterr@gmail.com>
