Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F24C25C6EC
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755955383; cv=none; b=EBYh8VwJ+xcLQFVnwbzm8nJ6irqGg/zFtdY48OBQqVr3AS2iWVJfxmGr8bigYnbcpiTzCXR5TW5bIaX/Dz1mmNaomiEsS6AtIy4dH907rBNFS5/k9B66GPn8NN308DV0TTn9ER0BgJKgH855j+bLQsSGkRWYGwB082rSEiqz5zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755955383; c=relaxed/simple;
	bh=45UakDwetimDEXbZMYxGNMKAm1P/wQmSq2jCPBhF/0M=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=nzHUP21nBL/RcpYRR67OkOpdzceiKDzyu1eEZknA0s91Tk7u04JFoYNp0j/e6W0rjhBaH1dXwC6wE/f4x4V6oR9B444uLwGz+vDpuj0Wb/dETWq7tRePIwSEiuHHZ86M7qe92Hb6ZlAQQ8c2SYgZlFZ2rV1oEcrbHaOQ7WfisKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlema0nK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlema0nK"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c79f0a5b8bso333055f8f.1
        for <git@vger.kernel.org>; Sat, 23 Aug 2025 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755955379; x=1756560179; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AlzMZehbrw2ApTcwVbm1nd2cSNDGRYJIOUpw5ol1TEQ=;
        b=dlema0nKRtEgkjL5mVDaCFhBSUUCosezOyIiCAn+aRoHfbYS++HfOdWxQ8ayZaATSk
         ED0+wxC3zcCtDi7r1BMiyoN0LxROS6HoFBOP0Lcg5SvDbbdROGsX4KGz5IY4KBxzczBW
         oW6i0mkZtkDyX4A0BkYMg9Zpr7gOhTTJq40PmmQZ07YkKYii31RIIH+CEPFMe+uq2Z29
         dQHUbNPWsXbSCEkgCB+vWwzIr+kAjBWjjp4dZU/BmgBkQW3+/DoRPI0MzKWcrWY0msFJ
         r3PrzJQ+w92j9dG7RXl2kLyCBWtX3A+nyPlBLZ+NW0NgCNJN4tILCx9brk8gMmKAZ2B1
         AybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755955379; x=1756560179;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlzMZehbrw2ApTcwVbm1nd2cSNDGRYJIOUpw5ol1TEQ=;
        b=hHl0SxknsF2ZGfs/ddxZiU2zIBQLM/VNhlqnWAIq5YUoXoXAcd7VXbIF49ka3Bj0y8
         ZKZvFgoAFXsJksiabbNuIlPYwi0H1cGCDVHoqzJ9VEZoHBrRBSFeO0v1cMuzoyCzAjEg
         uc+DexvpPPtmfIvpobLDPrC2sxAygZW1t1X64rElStoNrNN2d8ZQwC0aO5MKz0svnIqT
         zHcm3cdfcWPrmRqZuZ5ASnZ4jkPqF/s7EcwsnZzHrfP3URGoLx6DKQ3qcsR68UCYuzY1
         I/A5ot7jySoAQvnob4H5LdoPCxlKmr07LyENTY/frKxsIHnH5YYo0oOraglk3k+oqS8p
         604A==
X-Gm-Message-State: AOJu0Yxz/3Xa6VE3IWzRVDKCI/186na/ksidFIp6vyXIa+g4YWErWFtT
	HieGE+Bl1oUSzKwG5tuBu8ieIHEgU2DfEN7JbwaKdJEUy6gvPuBQXR4RFvIn/w==
X-Gm-Gg: ASbGnctUc1YIVkrA1COay3KKCyEvxioTtoJIv2+/7bkDWCTEM7WyINmlYhGbUeZFJKh
	OM83liNRAr0YT4azmAK6nnr5wIqFCrACk19tEchzdfaw/F7Sju8kUsTQM7hbX6MlPY5r0AGitRN
	PGQcqwynlZuY3eJpGzcxBEDleMS6idFm3mh62uji2flHXhbFEWdTQa6Ps/AVZ74LWgEAySWoPI0
	8/lq91EK97ullhQ77FCYcSJuttyMtR6c2BDTMDLhcaD2jXrcBjWfSibu0tSgRQ3QEiqNlh76RzF
	jRHuT3eGe3UKYu0zffYKhzzgLnZKMseecwq+E1RuLxmkASF0prc2MN91Z9VwH7Q3C3kHYnsML3P
	bHock9YYH9lXpYFXE2yieljNJbgs=
X-Google-Smtp-Source: AGHT+IFyWxsAOou+ZxXuAkdEoNtZ7wluFaBpsUYGN1YwjpHmfVWGP2D7XdXAbkfLFMSBTfs5YT2IZw==
X-Received: by 2002:a05:6000:18ae:b0:3c7:e6d0:b191 with SMTP id ffacd0b85a97d-3c7e6d0b761mr762364f8f.3.1755955379123;
        Sat, 23 Aug 2025 06:22:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba390sm3793312f8f.12.2025.08.23.06.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 06:22:58 -0700 (PDT)
Message-Id: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
From: "Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 23 Aug 2025 13:22:55 +0000
Subject: [PATCH 0/2] progress: replace setitimer() with alarm()
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Nicolas Pitre <nico@fluxnic.net>,
    Johannes Sixt <j6t@kdbg.org>,
    Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>

The first patch does the minimum changes required to swap the underlying
function, but introduce a race condition that is addressed in the second
patch.

A third patch that does further changes to the Windows compatibility layer
was punted.

Carlo Marcelo Arenas Belón (2): progress: replace setitimer() with alarm()
progress: add a shutting down state to the SIGALRM handler

Makefile | 12 ------------ compat/mingw-posix.h | 9 +-------- compat/mingw.c
| 46 ++++++++++++++++---------------------------- compat/posix.h | 17
---------------- configure.ac | 13 ------------- meson.build | 16
--------------- progress.c | 29 +++++++++++++++------------- 7 files
changed, 34 insertions(+), 108 deletions(-)

Carlo Marcelo Arenas Belón (2):
  progress: replace setitimer() with alarm()
  progress: add a shutting down state to the SIGALRM handler

 Makefile             | 12 ------------
 compat/mingw-posix.h |  9 +--------
 compat/mingw.c       | 46 ++++++++++++++++----------------------------
 compat/posix.h       | 17 ----------------
 configure.ac         | 13 -------------
 meson.build          | 16 ---------------
 progress.c           | 29 +++++++++++++++-------------
 7 files changed, 34 insertions(+), 108 deletions(-)


base-commit: 1fa68948c3d76328236cac73d2adf33c905bd8e3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1960%2Fcarenas%2Fnoitimer-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1960/carenas/noitimer-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1960
-- 
gitgitgadget
