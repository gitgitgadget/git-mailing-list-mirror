Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2442A9D
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755515606; cv=none; b=bSatojBrBZ2vw+0r4CIKxedMQ0k1iNpieJGu3+KMMY2qdBlyTU4ZqGOtJkECxnaUrISNjkI5sWDbNQ1COt/mvy77nKvXf7lG417ZydacQyw2sB/CHgnMKT5miw+PbMbvT7MpNiouKUGDj0LToS54tt/wp/nIlFCdLHl+dmDiPE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755515606; c=relaxed/simple;
	bh=QcMmWNgcpnQzsKkKitzFoipHSBwpbGCGhOxizxAyFqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dlBLlqBmhipL/i2zyTuGtpqRfFBuUoQL56lUOUovCoScgWKWE7pftTVVGpl2SptURTANDIhIU0y3JEjqoVuVFzPDOmbtA2B9yIUmXJi79B7PqviJ/JLzp5iPq2dwfr3/3lTXdARo6yPEnirJVCGZORH4YNmH4wCp+PSdkuXg+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx5Ewdj3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx5Ewdj3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b097037so20593755e9.2
        for <git@vger.kernel.org>; Mon, 18 Aug 2025 04:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755515602; x=1756120402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzyrjzeDnKmzeCk2bx9CGQGmzZ08ap/I5pdBRH8bSKI=;
        b=Gx5Ewdj3bDqbYLGtycIP6YNJ2b1S7MbMIxAPJsZLotlIUg5YrpWgDHP7JCMyEKetDy
         hyklajkyj+7/jQnHP49qsSkr22zid0zWSyU+dsLZe3GPLC0vBL3fsH3E7/xVeCnh9C0x
         utu9W2U4hD9xHV/RDq5jAjsjdi5x4C21e8gSw7Agtsr6sehu1kX4gB9RP1Gf7giYGzon
         XSHVv14gOIfY/kVPDPOJANiM4KP1cdngOcOtaaXYBTCJVdNLTOKyjWR3MAChWXORif9m
         Myj3WxJtc91AbtdBqRq3DUCjyxv7MPSbnKrIR2Rws296WZzr8BEbB9UrBbNLGbCWMm4K
         AD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755515602; x=1756120402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzyrjzeDnKmzeCk2bx9CGQGmzZ08ap/I5pdBRH8bSKI=;
        b=SsC/KQp4nDPTrwofdI4t9yj5PeUm3sdlxzwVKVpneHZQuX4JKNWFRh21LSvFviJB2V
         LD7/lBALJIpvs9dFdMcEVReWL3kNzepExrGvsQ6V4jFFT0vF0mZCJUvaOfKnSvPV27YE
         bmpxZ+raiFTY/C4Z0aGMhRtrCnQ0DOzYb7W55ep4Wjt4yQJdGcQK5k9bB2yi//2FWC69
         rCcEICqafyPphYokBXh7F8rTinAZyc+gfwU6I4/xBTdef266aZ+ac5ZKbcaTlYvF+/sm
         T1sxFloazhscyMezpKXLqBfM5eq2vM0J7Ek1KPbO4AweJWxzoQBOCKrlDkNXdFISWT38
         u/rQ==
X-Gm-Message-State: AOJu0YzAAi+Zq6+uO/aJgK/EcNPw8cRGZ7+omAtDHGdVhbxHLw2sHvsC
	0sdgtGFXVhL6Umrah6lCr1DJJT5QIMMSqV1MAPv5UU7zLorsffgPrQlKcYe1DQ==
X-Gm-Gg: ASbGnctRWLBScJksRhHGcFF4bLUOAisRCEq1Zwb4hxvOdZjS16XK+U95TBXDFUP0qRs
	Ib+jP1rLsO1fy9AFhkPaK3cKmuKJiMqFGlju4UBgiqpB4Pn/bmzzFL6vXmUfa0FIek7jlhz5mCo
	SU9Hus6eAhQuGQUEr4R9KNtWMoucJ3qHEfyEiuE+1lLoxcjhQN2APr11f30WPd+UXgIvwdSNCMj
	RjtzPVcLkJak7kdqOFmyOWQjPZuwlyeM8LpZ9o7v2OzAJpv0XbB06SaRKnqgcvGirRK/en01Mls
	/qYMAmc/tzkTk8Nkrj/VuaE1IzRZpIhqCbN9J+8PbcgyW66fwQi7wHvktvoLOTbbbkK3LBJfyu6
	6Z2HJAvB22xgGDrU6H5mC+BDUXpcYtyygjkxBFWgqbjKfgdDBVewVWCi70dO4HMXbjp5FoYr9Zi
	aYU+X89Sf7rQKi
X-Google-Smtp-Source: AGHT+IGyDjD6RV5e8HHCNsjeL0rJ0AgG6+5ek37CaiYoBUkZtB7mMHR6YYEC6D+WCu9IwE2Iq2QoQA==
X-Received: by 2002:a05:600c:3b0e:b0:442:e9eb:1b48 with SMTP id 5b1f17b1804b1-45a26794ba3mr62223905e9.24.1755515602192;
        Mon, 18 Aug 2025 04:13:22 -0700 (PDT)
Received: from localhost (2A0011100205B3242CE2DE6CDE8A6370.mobile.pool.telekom.hu. [2a00:1110:205:b324:2ce2:de6c:de8a:6370])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm178238935e9.6.2025.08.18.04.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 04:13:21 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Evgeni Chasnovski <evgeni.chasnovski@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/2] line-log: small fixes
Date: Mon, 18 Aug 2025 13:13:08 +0200
Message-ID: <20250818111310.1283932-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2.346.g6515629ae9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, May 02, 2024 at 09:29:04PM +0300, Evgeni Chasnovski wrote:
> Calling `git log` with several `-L` flags can result in an error.
> 
> Steps to reproduce (on Linux):
> - Set up repo with a history:
>     - `mkdir log-line-assert`
>     - `cd log-line-assert`
>     - `git init`
>     - `echo "Line 1\nLine 2" > file`
>     - `git add .`
>     - `git commit -m 'Commit 1'`
>     - `echo "Line 3\nLine 4\nLine 5" >> file`
>     - `git add .`
>     - `git commit -m 'Commit 2'`
> - Execute the following command: `git log -L2,2:file -L4,4:file`
> 
> # What did you expect to happen? (Expected behavior)
> 
> Show log with evolution of lines 2 and 4.
> 
> # What happened instead? (Actual behavior)
> 
> An error with the following text:
> 
> ```
> git: line-log.c:73: range_set_append: Assertion `rs->nr == 0 ||
> rs->ranges[rs->nr-1].end <= a' failed.
> zsh: IOT instruction (core dumped)  git log -L2,2:file -L4,4:file
> ```

Thanks for reporting this issue!

As it turns out, merely specifying more than one line range is
insufficient to trigger this assertion error, we need a rather specific
interaction between the line numbers of two line ranges and a diff range.

The first patch fixes this issue, along with a couple of similar bugs to
make that command really work, because once the assertion error was fixed
we ended up in an endless loop, and once that was fixed the output was
wrong...

The second patch fixes another line-log output issue that I just happened
to stumble upon while testing the fixes in the first patch.


SZEDER Gábor (2):
  line-log: fix assertion error
  line-log: show all line ranges touched by the same diff range

 line-log.c                               | 15 +++-
 t/t4211-line-log.sh                      |  2 +
 t/t4211/sha1/expect.multiple             |  6 ++
 t/t4211/sha1/expect.no-assertion-error   | 90 ++++++++++++++++++++++++
 t/t4211/sha1/expect.two-ranges           |  6 ++
 t/t4211/sha256/expect.multiple           |  6 ++
 t/t4211/sha256/expect.no-assertion-error | 90 ++++++++++++++++++++++++
 t/t4211/sha256/expect.two-ranges         |  6 ++
 8 files changed, 218 insertions(+), 3 deletions(-)
 create mode 100644 t/t4211/sha1/expect.no-assertion-error
 create mode 100644 t/t4211/sha256/expect.no-assertion-error

-- 
2.51.0.rc2.346.g6515629ae9

