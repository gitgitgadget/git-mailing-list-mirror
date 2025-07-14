Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86706248883
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 13:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499648; cv=none; b=p8d3iLwRAnWlKMg6S82kJJ4ilr2FU9AQ9R5sNVu20l+SRCUwujGoHynXMbVhYkySHcxcbXhVDeDWT3IaFERricjgzXDuXltVIu3pFI0DlboDAEBQQ+IvoAbkEroAjIZWhtJ1nYVZDyyv/uzudk1f0E9JGGX+ABJYSftEJ69nVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499648; c=relaxed/simple;
	bh=HT/gbOhO4RHjXmwX54AH0i0T08qf9xKqSST8nZJykbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KAYmKb3wmNBEOh1TqhFkJ3pIyjd9Fyto63Yd+Dyum7vlP/W7eHyvn2ODK28hqgGijQ6DVw8pSbaUOEvAunJcBj7WGj7oXQEIF5Bn0EitX50lFxjlY9tf4M5x2ReChtyY6jL7eTGNTi1ZXeErJ3xs0iGonikfE1yAvr2PHTli14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmG0PfBt; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmG0PfBt"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a582e09144so2597190f8f.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 06:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752499645; x=1753104445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zwjstrbwC3AtW2NcEQ9o5fA3JfvKLAReJnNgS5RjOqg=;
        b=CmG0PfBtdqBbrnAwd7qvoE52NZ5FXpec8t+sU4huaoL4sLSUpodklogA4j+35DvR1+
         xRadRFsJyxOnKHE3CRm410TJ9Fvpi52ZXy9zLptnkCp5n8pj1WDZ6JAe3b68ph+rD0RQ
         7nEysAX7U416kaTgPn0ROuXtz2raP1jT+FEsG1iQEm30Uj88h/jGMTSeuEZhtNJ68kWD
         OaArqWqOZ6z8+bTE4E3WVKuSq1F/5cYImpD1W48Wv6uviglTCQfRTzffVOeaOrKVeIHL
         1TiaUYXJDZaGUBCNSV6GNUCAHJly4ddnz85TR61RQAiz6Nxu9pQYTRFJ2N0qLvD4cFhV
         Fd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752499645; x=1753104445;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwjstrbwC3AtW2NcEQ9o5fA3JfvKLAReJnNgS5RjOqg=;
        b=VFAwSNRHdfwMhrnXsATiIBCpHe2BivEZdodLhYI1yyPOkdkB8NJNXVkjQ7rKrBEVEU
         9xcoz8Jm+t6Voza/JsdMRcTs1usN8xmgM/GPHXtG4HcV+doBnykC0j5XwoYJn6vC3/Qy
         5jTCqfJ4p9enBIRQYhAjF8U3WnlXg2/ufUB0tCP2C3tCnuRuPQQPwvaG8yQnCMOfjHUL
         UDcYglYQuFjwzo0gPB1fLw0PDrqygE+5Aaacu/DHf1TEyRXnoJ40KWBbZngOCmUOusdF
         fhPCRoMgEshI3AOjHpM4jPQD+6n6R8OTawaTl7cr2F1667vK9VQuah63KHsBNySLKagS
         pwgw==
X-Gm-Message-State: AOJu0YxAj97+00UIr5JzoWBfC4O8+FHQcOq6vbyCl+d98t2rZlq5jeW1
	r1vnht72+tmUIvmcVsx7WHJOWrCaK1A3siqGNRtAUQclMvkFrAOhTbT5T02jbQ==
X-Gm-Gg: ASbGncvaGJazDzY9EoM8Q2JYSoyQmD5maaYnqEnUhr69e29LOO3d7QFyo0O6iNpDEA1
	Mm6EUsbDkJ/lKK2+48Gim83aFK7WR1NflsMUo2IaBFtXcr0kkjQRWHHQET/d7vrp3R3/Vb13Cvv
	Zx34jtOIemgU4xV5YQu127cf3lRt/pl6CyeOFkSfaCjt1oLlU9ZxJX5WYVstzZMhpfKabdGptIr
	Fzx3RTp0Wr4elzNHOhKQ/0A38x6SCDrRovzmMdxCs5OS6JSxtINgrJeFLntvVpaoPV5Ml+u1AzL
	StvH6R+2dupQydyFD75D9KehuOopf4owBY5D462zpg0bjCuFvBGOarcvMiPHdSyfan5w0Oc728f
	vfmoasekN98YlC9kDvAPPn9uAY81n7yjfcnB+t4McoLqo
X-Google-Smtp-Source: AGHT+IHP6MOAYTLAkx8P/2pvu7J6VuV79Iqj24rLegqU/7PsedyzA5kIP43EwBKPcZfb+Maflm+wng==
X-Received: by 2002:a5d:588e:0:b0:3a4:eec5:441c with SMTP id ffacd0b85a97d-3b5f2e26bbfmr9951742f8f.47.1752499644371;
        Mon, 14 Jul 2025 06:27:24 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d867sm12616750f8f.61.2025.07.14.06.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:27:23 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/3] C99: declare bool experiment a success
Date: Mon, 14 Jul 2025 14:26:59 +0100
Message-ID: <cover.1752499610.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

We've had a test balloon for C99's bool type since 8277dbe987
(git-compat-util: convert skip_{prefix,suffix}{,_mem} to bool,
2023-12-16). As it has been over 18 months since this was added and
there have been no complaints let's declare it a success and convert
the return type our other string predicates to match.

Base-Commit: a30f80fde927d70950b3b4d1820813480968fb0d
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fuse-c99-bool%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/a30f80fde...7eaf80420
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/use-c99-bool/v1


Phillip Wood (3):
  CodingGuildlines: allow the use of bool
  git-compat-util: convert string predicates to return bool
  strbuf: convert predicates to return bool

 Documentation/CodingGuidelines |  3 +++
 git-compat-util.h              | 12 ++++++------
 strbuf.c                       | 28 ++++++++++++++--------------
 strbuf.h                       | 12 ++++++------
 4 files changed, 29 insertions(+), 26 deletions(-)

-- 
2.49.0.897.gfad3eb7d210

