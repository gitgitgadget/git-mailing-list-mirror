Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57337FF43
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789081523; cv=none; b=sBc2LdFHa+u5Jd1TDM65xOq9y41vklUOe54M3uNhIpSHQrBvi2hBbTkBD5oQ0rsHP3zPgIbtOKvgk0mT8jcBLZWpOwRVjtVBHLEV0AqvjEWsXbROt7l1oS8ZaaCjesGk/HRI/wzmbKYozAcdWortk/fyHoVu0zLrlfdQrBlwZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789081523; c=relaxed/simple;
	bh=grS9ctcE08PaKKdQdC8CVf9dHtbIKOFM9SidRCPYCuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgJ1iVt0AGR7DCxKHx1Wya6Lgj2p9NOMa4mvFbU4zZ62ieopxTX3L4cKhWZDw/geSqmDZF/4+rN4yDFScWNK4bDVBSUNaOVPfyp2keDIfq+SVR0XN3KuY2xS7u/NCCfkYXX5fF6fi0PWRc+b4cdsAG13Rr8UNIgtu2PRhFSdTaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=M3LHdmoI; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="M3LHdmoI"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7fcb425fb6bso199426a34.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1789081520; x=1789686320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6EgiBFnK/FmN0w668alGSOACbcFDnVi6+yaWD5q7lJg=;
        b=M3LHdmoIyyeic/9jLOyYZi5x+vyuCMa6z6nmrMrAMPA0E1LhP5Bed3RmqCN+kjKijx
         HUM2+Hx9cO+jdUiLRifHPWFNhTLFpG0B8AkYlICmn/zv6pRtXcSxahSLAZMMg6k4/oF8
         C4+jLxbg6V+PSs8VnXNlWyvCbpvz1ZTCCB5vwLysdajskJVzdnvNaSS69qtbrkinmItQ
         4fwkIenIGdKJ2donUkhid5ox6+dLy5x1ULEKbqtuWMMmJXjRw9GaSRc0GyTnUnHdCmUl
         7+57N6rW9DyKTl2Tr0t0DsLrj6tyQdacX++wcVYUy2SmI0GpR5UnO974otkMVImA4rXm
         bHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789081520; x=1789686320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6EgiBFnK/FmN0w668alGSOACbcFDnVi6+yaWD5q7lJg=;
        b=rSeyb46au+pIOuMp83JFpFPJOqSQ6vMkPRhOqDuHrpVXvFqYoFHU3c/kyEs7W472zD
         u77VRAOq/2lgC70hOYIXWPp502/Sa2Zae3ZHsC+OegXL1M2MrUSYLVNfrmYkEdbbcd6W
         lkMh1dxg9w20/11QolMD4Tjma5u47Ci3qFMoezu1J+46qPEZxHg6nfmYYBDj+ZbgVhIt
         No4ghj1tbbW0r1eolEx1JWMZKf52eWztPuHAiqxjjoOMadyfkYtk+2ZWrxL3h/jengjX
         yAlm5TnbvmmpfcRtKl3LVIUw5zRjNLp6MV7TFFJpvmj97uAD73UfrdCWSs0WlcbGu8E4
         GaFw==
X-Gm-Message-State: AFuF++lb/8oDKjGwvP6u1aNlG4gvuXy0o1LgQeKbRaXfIgubwsY+lxXx
	3ZlWkFEggHdhI7NItfcrcnlGhTgLVIv+2Ofp1zahgsQt04pXC5t7wY20CxOkf3JO0uMLq+hiQ65
	xTkH7lvo=
X-Gm-Gg: AYBFou3NsYX1XdMII2xqbhcYE/WaiNRcae/NwXkkhRBmWCR0A/er6k00PD9aVmcXAbL
	944YQR8D5VhD9X4Nril00h+kFlnaW//s9lP00blk/lHpKKC92ad7IA6bUk3OslMFiAuaNpuKVwQ
	nqDC6K1KRVigQPiPBnEXq65dD9QPO8WUyXbppiRv074bubE8xHD1SvQ9Ss8fRlvr7osKD9oDFrF
	NIuzFnBVK615taboeB70PURxd+0jeDxqyDTzA5qYp5CppZaL/Qz5QkUKDSW/7gVLMThRl7fIi9c
	1AM1IVo2Sh/A6WAVzdwV9wcMgcvk20amt0v2TEsgAMXx3BE8A0ALfG7FosdyfhK9w937UQFPqC2
	jxoPU9y+hUMW0EzoCVhzdjQ9n30OBjUzI+GGCt8HmE5BqiyflAvgFq6EmNXMWXYRACTWNNmM2K4
	wjXDUcGm6l/s+CZM5birMGfOT3704ALAEw4MmY/S5ncZg+f9umnA/p5OAv1s2+VyPwIdysrvp7v
	zfokfC6Rg==
X-Received: by 2002:a05:6830:6210:b0:7f7:f55a:4bcc with SMTP id 46e09a7af769-803fef05416mr1830433a34.8.1789081520455;
        Thu, 10 Sep 2026 16:05:20 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-803f6d24976sm892239a34.24.2026.09.10.16.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 16:05:19 -0700 (PDT)
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D . Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tyler Cipriani <tyler@tylercipriani.com>
Subject: [PATCH v3 0/2] push: fix --force-if-includes consulting wrong ref
Date: Thu, 10 Sep 2026 17:05:04 -0600
Message-ID: <20260910230506.1631656-1-tyler@tylercipriani.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904210122.431757-1-tyler@tylercipriani.com>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:

- Correct patch threading of 1/2 and 2/2 to reply to cover letter of
  current patchset vs. cover letter of the initial iteration.

Changes since v1:

- Clarify in log message 1/2 that --force-if-includes will reject a
  detached HEAD today (when the same-named local branch lacks the remote
  tip). And note that this change makes it explicit to always reject
  the detached HEAD case.

--force-if-includes has been checking the reflog of the local branch named
after the destination branch regardless of what's being pushed. This can cause
false rejections or unintended data loss.

False rejection has been reported twice that I could find:

- 2023-07-26 - Stefan Haller reported local branch with a different name
               false rejection[0]
- 2025-05-08 - D. Ben Knoble reported detached HEAD false rejection[1]

The same root cause can result in data loss: when a same-name local branch
contains the remote tip but you --force-if-includes push an unrelated branch,
clobbering the remote repo. PoCs are in t/t5533-push-cas.sh -- new test cases
fail against maint, but pass with patches applied.

Existing tests covered refspecs with different names for --force-with-lease,
but missed --force-if-includes. New patches cover:

- allow forced-update using refspec with different-named local branch
- allow same as above, but with HEAD
- reject force-update using refspec with different-named local branch lacking
  branch tip
- reject same as above using HEAD
- reject detached HEAD

Resolved question: the detached HEAD case; HEAD's reflog was considered
and rejected as too broad for purpose in the original review. cf. [2]

[0]: <https://lore.kernel.org/git/f51c73ed-eb03-83ca-fb31-d3e2645c9a63@haller-berlin.de>
[1]: <https://lore.kernel.org/git/CALnO6CCk0SgwObQRnpd5Pt_DvCKF8dBmyVHivU6Nr_O-GusGLA@mail.gmail.com>
[2]: <https://lore.kernel.org/git/CAHLx=O=tVhtiZpaRP9TpfiBfOMS2xPe3c3=mC3VNEdBrLOioFg@mail.gmail.com>

Tyler Cipriani (2):
  push: check pushed ref for --force-if-includes
  push: fix --force-if-includes detached HEAD advice

 Documentation/config/advice.adoc |  4 ++
 advice.c                         |  1 +
 advice.h                         |  1 +
 builtin/push.c                   | 15 +++++++
 builtin/send-pack.c              |  5 +++
 remote.c                         | 27 +++++++++++-
 remote.h                         | 10 +++--
 send-pack.c                      |  1 +
 t/t5533-push-cas.sh              | 70 +++++++++++++++++++++++++++++++-
 transport-helper.c               |  5 +++
 transport.c                      |  8 ++++
 transport.h                      |  1 +
 12 files changed, 143 insertions(+), 5 deletions(-)

Range-diff against v2:
1:  da27c421ed = 1:  da27c421ed push: check pushed ref for --force-if-includes
2:  e07d16d53e = 2:  e07d16d53e push: fix --force-if-includes detached HEAD advice
-- 
2.47.3

