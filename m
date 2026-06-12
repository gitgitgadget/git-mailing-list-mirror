Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF201E515
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781300960; cv=none; b=WU50K2T9Gob5K52yCTX0HbzQsYkly3EBvnAHE0A/bQZSm2w7pYvs9UM4Zm4d8+kZz/sSWBVYcN3tKU9pLhnumlZ+hx0p/nuj7L5xLjcD+vq4PSXcXP/G14RseCmVQ5JU5M0FqPCpVLXdxVPwiVi2l8l3p4lIEgFo8BvpNFBli48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781300960; c=relaxed/simple;
	bh=eaIHWW/8IGw9QmDXU1EVrEBZj7ZHbWk8QcV+gsY5P5g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=iLk29viWxcqoVLdvOrpE8+CsThhe5ewQ/26aS3PkaEfAZ7YISBVNAPNONLHQ/sykh9pPcnMYvBwaTmLvS6t+EKXBb2fBez0QB8LS6swJOCz9+kwHmoE9T4392fGYTt4QVYpsoxnHVFEWbXash0AFopCsdeE6v02La6yDEvGrtkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMSMUoPU; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMSMUoPU"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176bbb9384so15179341cf.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 14:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781300959; x=1781905759; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zg5Ik1VP+XN4MoJcvMxUbZ+xLvpDDJ7S+oI1Mr4GjOQ=;
        b=FMSMUoPU4tsofebm4Znrv7hcKr3M2iT2wp1fPVEERbtBqzlUkpr3Pt4MTraU/+BuQ+
         5HBh53GfKOryTuE01+ZKTvgiiHFUC/XhY5G3nxor94sTVIXZYu3vPmiRvJ3D5VXconeT
         UIMQRmYZNdPJ8WQr1jbqUOeQ1sycxMP9EdAagt+Cryo2Ai7H9kPwtVm10o0GF8qhpkEc
         CAcPVCTsXbBcNc0R4ECKEYFadfcepvpPjvIo3VNqUSnzcv77TDbldWIAAMNSDV9VffPI
         +Idi3dwqTcAp8fzPO8jFPt5fJpRZkqscDB9aN/k8oSEjeMooujx87aI5/ql0QwcE2Bvr
         BPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781300959; x=1781905759;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zg5Ik1VP+XN4MoJcvMxUbZ+xLvpDDJ7S+oI1Mr4GjOQ=;
        b=kf9pJeV+rGlhFVu1qBHXvQgVyteChVQMsPbfzGhateo8FEACn3kNkuzSlHTICBxczE
         TqPQpiiL8zSTOc9j6v7dj4w7BZRk1XFM3HV4HV65M8k52JoBJQz4LsZQQXDgyNeVLl+s
         IXDOLfaQFK1mnjOUSrI5voDtg2oEkLNHaBarm7eHh8EIgU0X7J1C++fJ1I9IyvWGnpaW
         6oqh9afCe5xreuh6VC1FEhasIJj6yJgto5pzA114ftBq1xDxNPWIqdsgGYccoEWBTHL/
         yHZpEgykAT6LvGIokcuQn9ZpdOcUfSqg1d2H3vYmfe8qRLcCbBds92ZpCZAOVqvVdCV1
         4dKA==
X-Gm-Message-State: AOJu0YzWPfRL8k71dD6Kc11/j+uIWm3ZBTP3i9kJIa2Mv0jjOqPK/DWS
	Jof+Z37MKWhhK9bIp+Oap/TReUDpvQFl9hP+4xmK658SOo+VTt8yuHNS
X-Gm-Gg: Acq92OGBoUDCyWU8UiTIm6SqEQ3e3l5Cy3D7Zbi4R8KLYkLQR5Ob4UlepmudsmoEFEJ
	XngVW/FnMfrCdVhUBU0Iwb1GPhMipaRUSZ/RozZQTBGmAJLpGnTxfQUzsgTZfAPb6ax9I1ZLlOr
	BfRDXeIiCFTMbcBKEN0E4jGki8JLujP7ExuDTFvDWmGpEubLqelpKhS5AB7gsqypUYqTp3a2LMU
	eAIH3YYs7y0IEpQiKdRmywO4brkb1O/mNYEYuuaGbUUdx53r9lpv5sBGNAhKQaLYeZaCgWrQ9Ag
	j5A6JYjWTs0hV7YoG5BsTWsBeDMqSdw6TLdrMpq6ePFwnxSB6Qud9+JFDrTObxGoWpMUL9w219D
	joJjiv5zDZf+YXi4ft8iea3urKRo+Wr7+23q4HR7ldCz17IJ53g9Ny58qc6VLuMxKDVpEy2h7yv
	PRcACmFWzhmQoaLc8ftDmlwYl7MAT0zKRpJdglQLMhUYvP6Pw7SaRyhfAmS+KqGBwFFob42baIX
	Pw8cPWA76akNmKfIhl6vegTNRI7pmGRsNHKEUdrZF/LFNlDP5XrCAD0LFJI3CPdbewRshYC4g1F
	HuOjdrJDJd1XSFIN6Wkt6BctY436dFBJnPljNvuae/+s1K3i1bdr3RQwtK44SU93
X-Received: by 2002:a05:622a:98c:b0:516:d95f:bf33 with SMTP id d75a77b69052e-517fe62bcd9mr65132651cf.50.1781300958680;
        Fri, 12 Jun 2026 14:49:18 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4808:6353:5c00:980:d7de:1287:a424])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d302114676sm36593136d6.20.2026.06.12.14.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 14:49:18 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v4 0/3] Reuse --contains traversal results
Date: Fri, 12 Jun 2026 17:49:11 -0400
Message-Id: <20260612-ref-filter-memoized-contains-v4-0-5ed39fd001dd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQU7DMBCF4atUXjPIHge77Yp7IBb2eNIOamJkh
 wiocnecsonYlOWTfn3vqioX4aqOu6sqPEuVPLbRPewUncN4YpDUtkKNTjvtoXAPvVwmLjDwkOW
 bE1AepyBjBU/RRRuJQjKqEe+tls8b//L6u+tHfGOaVnMtzlKnXL5u/7NZu39ezQYMBHPwmBIfy
 Lvn0xDk8kh5UOvVjFtsfwdD0MAePWrbdcHTX8xuMGPuYLZhEV3obYoB909bbFmWH7eW4Td0AQA
 A
X-Change-ID: 20260607-ref-filter-memoized-contains-7cb6b3bccad1
In-Reply-To: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
References: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>, 
 Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Kristofer Karlsson <krka@spotify.com>, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1781300956; l=2266;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=eaIHWW/8IGw9QmDXU1EVrEBZj7ZHbWk8QcV+gsY5P5g=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGdSDo4UI9NqIhgO3NahIhUWFj2FMp+Mv5EwYyRKdTFYinhfZUUS4MDiiMnEWUKaHH72lSx/egQ
 NzWORrTrdjQU=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

git tag uses a memoized traversal for --contains, while git branch
and git for-each-ref repeat a reachability walk for each ref. Reuse
the memoized traversal when generation numbers can bound the walk.

The first patch makes the memoized traversal reject cyclic replacement
histories. The last makes the non-memoized path report reachability
errors.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>

---
Changes in v4:
- Die on cyclic ancestry instead of retrying another reachability walk.
- Update the cycle test and credit Kristofer Karlsson.
- Remove unexplained links to review messages.
- Link to v3: https://patch.msgid.link/20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com

Changes in v3:
- Split missing-ancestor error handling into its own patch.
- Use die() for reachability errors, remove redundant cache setup, and
  chain cycle-test cleanup.
- Drop the unrelated empty-target-list behavior change.
- Explain why git tag retains memoization without generation numbers.
- Add p1500 coverage for all three frontends and a shared-history
  case.
- Remove correctness checks from p1500 and drop output hashes.
- Link to v2: https://patch.msgid.link/20260608-ref-filter-memoized-contains-v2-0-e72720344a7c@gmail.com

Changes in v2:
- Split cycle handling into a preparatory patch.
- Exercise cycle handling through the existing git tag path.
- Move perf result verification out of setup.
- Link to v1: https://patch.msgid.link/20260607-ref-filter-memoized-contains-v1-1-a1972dde9c76@gmail.com

---
Tamir Duberstein (3):
      commit-reach: reject cycles in contains walk
      ref-filter: memoize --contains with generations
      commit-reach: die on contains walk errors

 commit-reach.c                 | 23 ++++++++++++++++++-----
 commit-reach.h                 |  3 ++-
 t/perf/p1500-graph-walks.sh    | 28 +++++++++++++++++++++++++++-
 t/t6301-for-each-ref-errors.sh | 22 ++++++++++++++++++++++
 t/t7004-tag.sh                 | 18 ++++++++++++++++++
 5 files changed, 87 insertions(+), 7 deletions(-)
---
base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
change-id: 20260607-ref-filter-memoized-contains-7cb6b3bccad1

Best regards,
--  
Tamir Duberstein <tamird@gmail.com>

