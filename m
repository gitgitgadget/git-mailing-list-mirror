Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377844BD798
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790844819; cv=none; b=u1FSKPBH2xPjpcd7Ez3F8QaXkTdOUpGRvcbeUSjE0wtpBSANTb8PWkwswajXSKJa4JK5hngo+O4Iom1W2rZGdehrYSV2yfdUUAdmPZU3/Ey82cCMSExDKY2WPm/GfMAOq8ZBGjILxdzt1fldp8bbtpWlNUcIFfNwqEFHLD48OKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790844819; c=relaxed/simple;
	bh=RvdhpVjA/mHtNYltcbqa70qzsiJwp6HQM0tNAt3o7xM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nYzyCVIM+DlPgZ+irlrqiGQa7l56+nDL2w3neZ/FT5aAT8LdgkMnM4/qfSi8217X3fZVRavT6new8WlsW92qTR181tYS5iOm7YtzyR28o/SwXquc2T6cHF0Jf49J0leURc6BPeIKnsIOsdlQMHdMBXhrRxvmX9vdFlL5u8rAQeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiBtTgcr; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiBtTgcr"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e721b5503so58706075e9.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 01:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790844815; x=1791449615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nlnvN99UtZqk3+dvXqEpiAGsAmxcGWoSUmy6lhg6jHo=;
        b=LiBtTgcreIFhMHcJFJVHi9LfkKIuPKrFILj1refIdH83T+dfiSNoM2r+C+Zgiq75f0
         e0ndsDgZQZwdKmhHJcIkiu0pfp7WzO4/wYmHY4gdV1P112xwOwmDkIVU/pyc5JhoLo1c
         p1la9zx4Ju8C/hCknJoT3DiIHclRBMckwxrHEiOcuCmPJXUnp8AmtAgezQigt0J96Yuy
         yAU5AqYs+8x53DJWUMUQHPfLFR9ByC1LwXP040T+f/CT3jELPYTMDEsPpSdObihFivZd
         yzvYwf/d4p0/qTVp5uizb3cZXu+hgn1TGykF7vJ6DhmQTP1t/I/pUsC11UDeU+6JqOVC
         j94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790844815; x=1791449615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nlnvN99UtZqk3+dvXqEpiAGsAmxcGWoSUmy6lhg6jHo=;
        b=AdV+gjFfSiCvccIsdMM9rxJNDy50E2KerY3nTN2f1uspG8t49Z+CeMUIlhZvHvsHN2
         9WLnG7ZdA8e45L/2fObyLwgaCgBG/x3LBDK4k1UCsqpujYGke87/0FsQuXk22Rj+WDIQ
         oaQ1l8OVVDCSnCS6NmutYMGetSh5aE0UffHHWcWwMbHsKX7jh18F3+Pq+D7X9Yx8OV6N
         VgaYO+bawyuGlN2CZa4hjHavDos34CnyVmRxRpsXE1/OWPqZm8BVJVXJzqFQtiCPBrvs
         U7e+VfqOpxlB2nj8qtR/RPlvYGI5adV0f2xQxGCW/0PT9JDV5RWVB0k7aT4Q4ZDkmHcr
         p0Mw==
X-Gm-Message-State: AFuF++lMQWhkVciV7dYb+vF4z0Fs5LsMfBFlszKm0ODcJ+khE5s1UyWs
	vpcBTsAmx8V+xuqdZyAP7CJS1EN3eVBZgXeNv+YFX2EQKnjOQDBtUz4FpeNeJA==
X-Gm-Gg: AYBFou1F9oz3UuHI1LfkkTFBFMtR/W7hd4Eq1o2WRoIvcJysR2Ov6/bz+lV5on+10sX
	Cx3HsRPoyaC1/p1OmWwtVsq8psSoudl+ROOTIcigrglZQEc80HxF/BlG+rR4Sj1YOJSGDXq/y2o
	rsu8jflCJUBm1oCu/JKjlcg3C+bjKAUwoLo79fRxiXwpoDO7paG6jyDdDqHF7VOIc2jeXmjfDMi
	XbzkBXePXguiSp7QF2xB/r1lzG/wI8AMiShgqXzkOebx/EwAdCax//oyEkFmIBPykVwwlNA4H9D
	w7zdPW69GHxpdl/BGxELUxduB/h2YMIBVqLIa0DzTx/z+DDVy3r0uGmBbYfMFhSZ1hk4PSfJ9sG
	SZAYL8G3Fg1ek8YS16heijEKF0RV33jfCN2p3D6bO4i1AU1w7yrASSeZtDJ/S4612L+2pn9H12M
	NmEaQHddbYNuDF/eNKOevJYsFkBtBp3aKvw3d3MI5ZljmTug4NPp7/TDfi/5PRWgUDf00l6aYKF
	7ndz6mRxOfzFU6D96742+ijQ6S7bdB6gezDHA==
X-Received: by 2002:a05:600c:5020:b0:4a0:1efa:c746 with SMTP id 5b1f17b1804b1-4a01efad733mr29773125e9.21.1790844815292;
        Thu, 01 Oct 2026 01:53:35 -0700 (PDT)
Received: from SSI-H-ARSHAD-LP.ssilhr.com.pk ([182.188.107.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f98604csm40751875e9.4.2026.10.01.01.53.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 01:53:34 -0700 (PDT)
From: Hanan Arshad <hananarshad619@gmail.com>
To: git@vger.kernel.org
Subject: [RFC] git stash: add porcelain for sharing stashes through remotes
Date: Thu,  1 Oct 2026 13:53:09 +0500
Message-ID: <20261001085330.73586-1-hananarshad619@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I'd like to propose adding a small porcelain workflow for sharing
stashes through a Git remote.

git stash export and git stash import already provide a transportable
representation of stashes. I tested the following workflow using
existing commands:

Alice:
  git stash export --print stash@{0}
  git push origin <export-tip>:refs/stashes/alice/wip

Bob:
  git fetch origin refs/stashes/alice/wip:refs/shared-stashes/origin/alice/wip
  git stash import refs/shared-stashes/origin/alice/wip

The imported stash is a normal local stash and retains the original
stash object ID. Removing the remote ref afterward does not affect
Bob's imported stash.

I'd like to add porcelain around this existing mechanism for four operations:

1. publish a selected stash to a remote
2. list available shared stashes
3. get a shared stash as a normal local stash
4. remove a shared stash from the remote

This would not introduce a new stash object format, server-side
service, or synchronization model. It would essentially compose the
existing export/import mechanism with normal push/fetch operations.
Before working on an implementation, I'd appreciate feedback on a few
design points:
1. What remote ref namespace would be appropriate?
2. Should shared stashes use an explicit user-provided name or an object-derived identifier?
3. Should listing only inspect remote refs, or fetch the export commits so stash messages can also be displayed?
4. What command naming would fit best with the existing git stash interface?

If the general direction seems reasonable, I can follow up with a more
concrete interface and implementation.

Thanks,
Hanan Arshad

