Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D1F1CEADB
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 23:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752537162; cv=none; b=DkfmwoO5KlpvRljDyQMAmbL8XvBzhqUv7Pe06Lsa2tZaOKcoMBM4t+qooDQA3MZk9CIhS5B1IPuVpboRRk2ZDf0NopCBQKEDvXlKlke9A0ze0HSn/1k05HkIZSE6aQf1XZp32eVW+n1RZUBXrlA7TazybkIfMaKi9zEOPu3zDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752537162; c=relaxed/simple;
	bh=s36Dj/gWPrhPl/B5CMcmQeAw/rVjjU652G2tzr6Fx00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IO/jQPUm8s9gEjpyJPWmIRPzC68mEvWec/NEK51K0ahJgh0oi+pEgtTuAZC492zpaFDEuTWU4xiSC9k13a/ZV3Yoeow7cADowLWHM6/BfmB8gwsFTA3nB/58Wx/+qWpCbMTPjwHn1Bw5hQTRBpU+ufgAwq9LHkG+BLLVO/wrbCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHtyvB9J; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHtyvB9J"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52b2290e290so4183880e0c.1
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752537160; x=1753141960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRzJ9Xy2C0BWS/dGEPlciLg/2bqTr/QVKUK+8tszBVY=;
        b=YHtyvB9J7ibdPFejugsd2fR4bUxVZa/lwQaBWOeDnwzq6oURnmy6R171wUU9jphJY9
         n2YJfUax9F3cfqL6Zn3pu2E/nOeRZYgwd928L6Bj+b+swbY2JvkrPlQJ+a95iBJG8ppC
         CcQu3rWmtVMOtg8nc1WMTCUb8BiQIbGfo1ygba8BSYmROYRApjaTd/njeZtOK7wymlty
         Qug3IYOQtSkdoCdBFwI5x9/TRThSme9aPeomJRIQMVC68d9yVWfbamVwTGHg2NVZS/Yb
         WL/7zEzqoXDVIip/7VQcV0jiuewmA4NixHqhpR7n4lZJ5y1oJEBEVjfhdjyAkE2EwJPS
         gnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752537160; x=1753141960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRzJ9Xy2C0BWS/dGEPlciLg/2bqTr/QVKUK+8tszBVY=;
        b=h+FgkUpLtL9upaSZCTrkBp4ZwOlZiVnUzQ34Ffr5ZqwB5LMy/uYTxJtaUGhG1zyeDY
         m9bnbH/3X1ip1CVh1r7jjTIF/spmZf6EKHHSuGQ2qpg1z64e7lJ1lBg368KECDQ9rue1
         hLmiqRbCeL8inrpLTTIw2W2f7Dvw8HnMXyqWW7V1zj5iWMPzP73iN0oMaKab3uRaKFie
         OVLG/QqZtXkKFmQ4jfaNBLt4xMZ2cH/604iyKjAEaksCC12UWxGZACoEgtM2wKV29/Bp
         +b9ms6f3eVnbyBZazVmhYTUO7VlR1n7bNuoZIv0ly41DLLbXq3DgCI44KLY4f/Vf9jF5
         ejUw==
X-Gm-Message-State: AOJu0YwbJQiH4u74no0L+t5B3uUf0Cbsz/FV+XzgA+JHEXBJ0/BSCOfA
	mgrl24VgdaVWYAKOYymknH0vtDSHVX8TSI3Nhki5wwoDd12zLFVV2M6zFYEHq52A
X-Gm-Gg: ASbGncvuMdZwZ+gM390Oyg9DEECrPKIEwQuCsDl305skz4VvrfZxuxbK97hgT/i2GAd
	0KujLwOBuKYGEPD1yfV0Xqdl1CRvbyhIVPQFdWoI4Wjcsntj4xk48HysHlOhrXhohIk4l0ZYGI5
	V79S0VaLtVVRzgDA8jmiW4sS2aFKK3zlmyZEn+lKiCMoOsVusMUmYlfgNB0zZz0Xz1n8vW7VnOX
	Yvm9I2+qhULdrmAg+MqSXCk4sdPdExF4fYgAfNEqNsnqbkSP4T+a8qzp0aVFD8WpWn7nqsr+G/D
	5MtOpSH+mM1KNVRq8RacLINnl00GxSZYYrla1dkwnfYoQzlrmA4Ry4mPudfZlS5IaLJ0nu3c/Lr
	rCjM5VQnRoezePKarff7BPkhJZhPwgWP6j3nq/wLAdzf5wiAiqfcW5aGAuGVAKJw=
X-Google-Smtp-Source: AGHT+IEE+Ojkgbx1rp++pFCrbmHbp8DhEQNIasampcAQCdlBXFhisJHsPk1dW0Dlo1bxAvH+celjGQ==
X-Received: by 2002:a05:6122:82a9:b0:531:2afc:4632 with SMTP id 71dfb90a1353d-535f46ca9ffmr7260848e0c.1.1752537159665;
        Mon, 14 Jul 2025 16:52:39 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:fc3:f915:3491:9732:5741])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-535e73de3c8sm1999201e0c.48.2025.07.14.16.52.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Jul 2025 16:52:39 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v4 0/4] repo: add new command for retrieving repository info
Date: Mon, 14 Jul 2025 20:52:27 -0300
Message-Id: <20250714235231.10137-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi again!

This fourth version is basically a re-write after the discussion with Patrick,
Karthik and Justin about a future plan of making git-repo-info and git-survey
[1] a single command with two subcommands.

The main difference between repo-info and survey is that repo-info retrieves
metadata while survey returns metrics about the repository. This means that
repo-info is really light compared to survey.

This patch, then:

- Renames the command to `repo` instead of `repo-info`. All the functionality
  of `repo-info` will now be under `repo info`. The functionality of `survey`
  will be moved to another subcommand of `git repo`.

- Removes the JSON support. Given that after the previous feedback we already
  have a nice machine-readable format for outputting this data, JSON would not
  be so useful as it seemed to be at first (when the "other format" was just
  returning the values without the keys). This makes the code far more simpler,
  as we don't need to deal with the details of both formats.

- Uses a simpler representation of the fields, based in their keys instead of
  declaring multiple enums and using nested switches. This new solution is
  based in a table mapping the keys and the callbacks for retrieving the data.

- Provide a simple infrastructure for extending with the second command.

Given that this v4 is almost a rewrite, I think it isn't worth to send a
range-diff.

Thanks!

[1] https://gitlab.com/gitlab-org/git/-/merge_requests/369

Lucas Seiki Oshiro (4):
  repo: declare the repo command
  repo: add the field references.format
  repo: add field layout.bare
  repo: add field layout.shallow

 .gitignore                  |   1 +
 Documentation/git-repo.adoc |  63 ++++++++++++++++
 Documentation/meson.build   |   1 +
 Makefile                    |   1 +
 builtin.h                   |   1 +
 builtin/repo.c              | 146 ++++++++++++++++++++++++++++++++++++
 command-list.txt            |   1 +
 git.c                       |   1 +
 meson.build                 |   1 +
 t/meson.build               |   1 +
 t/t1900-repo.sh             |  75 ++++++++++++++++++
 11 files changed, 292 insertions(+)
 create mode 100644 Documentation/git-repo.adoc
 create mode 100644 builtin/repo.c
 create mode 100755 t/t1900-repo.sh

-- 
2.39.5 (Apple Git-154)

