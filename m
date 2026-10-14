Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8C348465
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958175; cv=none; b=fUsPDWOAE5k2Z7VR1wA+q0S/h4P0fFLt/ANgKIK3aBxzCp+1KuqrW1Zvy0+8AMYmcdeoSFKhOh3oAG3UgeGI1E4H7uPxO41QWiFEQqFVA137IsdBi2X+vjG2mHwSeBA0e4ZFvfAhUnTrjuTdm+/NPz/jO1ZhwWmgtl+waJG9hZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958175; c=relaxed/simple;
	bh=9+NOAMXmY2WAdiTvPBzvBaZWX+KbPYeOeUpzz9+mIcA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=OJHDhVzrn9uxkgFpPlbTGet6kp5Dq6tCNzIHgit4ChsTeKm7slKVkeA6EjpdFYLr5niRmCinF5lbUDdxQs/HhH164Vvz/sWUoWQ0J8XpZDvZx9KNOIaj0OyvWflKepuFCltpIpAefEr2NRUht1XFduFv0P9MlaBgJNI7KKP0ZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2f9OzpI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2f9OzpI"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53397554beaso142451cf.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 23:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791958172; x=1792562972; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j7E8OZ6V2kFSqL6LbxnYviZftFPa79U63csUFSmQK84=;
        b=m2f9OzpIZI7QoeIlFf8cZygh6hZdbP4zzLw97nFIEKIARWAUYlRuyRkqwBPjV/POmw
         4jYIS4kRjMqn8VJs6exq8tMixiio3iV1DAEC0QZllG/aAC3Ei7KFacEIKBM0rpVcEzZt
         f38//lEG5YZzBTnuDyP5sXkpLRP2iDwVm9WVLM7JYqx/BgcUa6x0DBd7N4TtZ+n3KgWN
         RmKPG+5utY6FBeJrraIZxouynRmBQ0YXhxLeqXGOPhOa1YU4J4hQDBppa49J6n8VR1iP
         YrU2I9D+GCjS3WcIMq9JA72BAoykzqDSqoFb1PBrFTVOJtMkS6p9LwI0ZH1d8inWn/nl
         qAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791958172; x=1792562972;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j7E8OZ6V2kFSqL6LbxnYviZftFPa79U63csUFSmQK84=;
        b=VM8yOYLFpmQdPZoK/174d1bvMtg3tt8Ck1YpC6WUm7jVw0QAQ5/imGFEoGyCavZU8s
         DEcrBc6vGwVZGQJ+GiPrBdNebFcNQ4HqDY9ZrcuIfu6LHwQLOHs8lb6MeKQuqJKGwEL7
         waPYM/ws/ADTXTtLFD+Iil0GmOqRkTe0EibPbs6tTASjUc/mnUR+5rtvwHbUdIwH9uYP
         WDNGJvWkqp+cWIWrxn9b4jZ3D5Ergg0tUiPZwk9xxdfYqe4vFLcO/E0zeYc8VWp1VsNb
         Ip0cBYgpJ2cn/8pTfHHK4Y62ax5f1C7Z1PDWwNVynHuV/VBlbg9jWwcsh8MNJiaQi9h7
         BFgQ==
X-Gm-Message-State: AFq9FYJLik+dPpC09gMKCeXMxsictvxn66KagGagA4BY9MouOlYnLbvY
	XZPARIVb1S2kfmQVJPURjJN2scHxZ2mUynEGh87zw0w1drRoz3QcUeUkiTi8+g==
X-Gm-Gg: AYBFou3aO9qkpzWQBNCRP7fO45TcbGh1q3K4DQ7BZ2ZHgDPa1mgRXe6XLbq9pRgfhHu
	HlxEVChF6eKPsYnw3FfnKCaDKw4jGmnUt6/aZloV3v2Y7cbfVSZTsJiqoacG7k8eDA/hutuKgSY
	yKGeCeCLDQUzWu5I5HmkQi5rP1Ui2HF09LdfuJInJV8LgkQvrlqxUa9hq5CLrpyWOjWan5x+y3Q
	rZZ5ZYGOLxPD20IPD8H4PDpfMtYX5uw/ffsH0vHJbL2Y5Ju9VZp0LBmgic9wLma8m3gk5VGd1Yl
	0TpXrLs7jm37VNLxoCLJfbh8gIHpxU+TJ+rbGXHgrPNT5mC+nvBsVMlFoCgk5U1LUxhqZKjWPEL
	3mqIyHdJR6O6/q2x/aAFXJ2u1NZgWu3pA7t35+VStTfLB8yqXv4HUQu/33myNiaqrrIfp/cNXjT
	zg7bTDzWo7ZDkXslKL8IiFnrpOkIRN/vNdhpN9Zab8F5VKYkSvpKzzOWalRPDsV3LDJNvA8pkp
X-Received: by 2002:a05:620a:1a03:b0:93c:ba44:673d with SMTP id af79cd13be357-93ebd1b7173mr2631866285a.23.1791958172220;
        Tue, 13 Oct 2026 23:09:32 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.149.85])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef500643bsm419457085a.13.2026.10.13.23.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 23:09:31 -0700 (PDT)
Message-Id: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 06:09:26 +0000
Subject: [PATCH 0/5] Address overflows pointed out by Coverity
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series is part of my effort to bring Git for Windows' Coverity
reports down to zero; Previous patch series have been merged in 347fe8a91b5
(Merge branch 'js/coverity-fixes', 2026-07-16), 0b75ef5168c (Merge branch
'js/coverity-fixes-null-safety', 2026-07-19), fcc8c931b53 (Merge branch
'js/coverity-unchecked-returns-fix', 2026-08-24) and 8bc9c7fcfd8 (Merge
branch 'js/coverity-fixes', 2026-10-03).

Johannes Schindelin (5):
  archive-tar: guard get_path_prefix against zero-length input
  http: use `size_t` for byte position in fwrite_sha1_file
  wrapper: reject insanely large byte counts when reading/writing
  git-compat-util: add `signed_mult_overflows` and `mult_overflows`
    macros
  date: avoid overflow in approxidate relative-time multiplication

 archive-tar.c     |  2 ++
 date.c            | 26 +++++++++++++++++++++--
 git-compat-util.h | 54 +++++++++++++++++++++++++++++++++++++++++++++++
 http.c            |  2 +-
 wrapper.c         | 10 +++++++++
 5 files changed, 91 insertions(+), 3 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2253%2Fdscho%2Fcoverity-fixes-overflow-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2253/dscho/coverity-fixes-overflow-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2253
-- 
gitgitgadget
