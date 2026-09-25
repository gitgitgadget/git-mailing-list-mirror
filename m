Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9DB3563FB
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790369827; cv=none; b=bjLJYB1UxtlQf0+O5whVlVNr3Dmvnt+jZ8iOQGUIlKSSHkyIbS0n8aOwLaOTDiudyJ8nGHZ3IPJ/reiHVwe4uuh4NI9JipLAEncb2mUUzNaW5goYC7PFomtiCJvQuAyI+I9xZKwBnUe3HRqdwqCrszoFf3QkkkZe/NDx199+1S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790369827; c=relaxed/simple;
	bh=FSxNf7mNowPCRqTSqkYkNNeK9OUdNTGOXfAyvZyxyQI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CDviGKwdGY4ub/3lpLlbuuDwUXK+5cM7liWCj7b3+2ol6HvGPdigdBD5sYHZ7KMI9XZ7+jJ922X+zkaXOxNZe+4ErVgdfbzhcb/D3/GiYOZWIJL1HfVaYbzjPYmn9+QHv7/9UGBNuW1SEjkTWduVbBjU2F5XVH7ZM7q/vg+NW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoDBuTVL; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoDBuTVL"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so1721821eec.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790369825; x=1790974625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2e0Eza53Pz2ISyTGawC6/OAQ9o2MyjBRls6GcH4OUMI=;
        b=VoDBuTVLzzVawfuK+sagQuZPnELRBZ/1WJWDcPdykUSoIYZxS8Xb15Q+jsyJJhSzhX
         y22H7Y8qqz95XA7ZD7QMACt6FzveMUE9TjbVOeFQt8stnudiHuQ7FVXQVwZWNQDhkxYI
         WppPIg68liohI0lqnAquqPM5vSJS10At2VQd5ys4OQmNMRHu2gqx1yudIrxecpt0Bx3L
         UM+GyvWplEcmiM/lCILtAA3n1FIFvx40sHi5x+hL5mLngnk4FdwHHLs2INUX323klG0D
         CEgM1RI33ANItSRS2tuoCBtGsc1IVPk/I7Ab1rYOTDgye7rN1cgH1OKyg79ki4EmcqCG
         Edzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790369825; x=1790974625;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2e0Eza53Pz2ISyTGawC6/OAQ9o2MyjBRls6GcH4OUMI=;
        b=jraxxw5Kuikl4En1EMDvYh8d2tk5pvYT3QdSvNLQmqltsYDzdOrfJ2cpb+fEk7q7o+
         hX+nwXVGgBZRe2ge4VlPoiSc+X18sziBkWAJ9vNK1/Pj9yyjNcE25fQvBtaX5btnfSEg
         eHQoRz6qbA3P67uh22kd4nrMBfQ41/lQnDsTOBAPqAQooEzT/iTs8cIVlcrjoAi5ks7r
         VeCicSeCYoP4DVTGPu2YutBG0txoR6UO0Xhwq3t4XM8c/T1XF1DPQ6utXCQSjlO5LvZg
         vHISyuYKsgiYmjZaWKT3pz888CP3ifPsfTMSMHi8slsErhBvrL7mRHjHCUWJo0bLI9TU
         79mw==
X-Gm-Message-State: AFuF++lb7iqjyOkxAGRJOUiX5sGiZUicRgiOpR+qzsjqIeq5XoFkooRL
	Jvgj7QlsYaEjnf8dVDczqQFrXEDtBqbxoAxdV7kKjeDyTi7bazEi3+Ih8OF+pA==
X-Gm-Gg: AYBFou1HSsn+3BfuFndulSeqypJV8sVULqV4cFnPntyiOMfB1fg3ByxXsJJ0CMIx1CQ
	MBfyaWFVfVvckwt8h82z2cNXdVSHZm9RjkN3TQX4LX6yP7juUPl2km53tEI006T1UBtPjGM1eH9
	e0xkcaqC4MqmZ6mOUDDRUBAor52HmWbvKglQA7MOFUEpat8FaH7aQsPURCgXPmRtDzsD5oUgcvM
	vauwsgFuRDkK4v4eWTHikLn11xoZzd3Vo2LzL+sHeTQYhOTFWHMKL2po266e40pC6NqXBgoMdvU
	ZMHZ+n1T27MwdCWOM2tYQJNa5pDMZHgCMsbEbGIDbU7G5Uh+XCx5kTtg/wQHkmhgUgqNnCHUfVF
	AqEyvT7ULs7g/hgpSyvnepjb9lGIrM3A8rlrwEbxbEJvmTu/UtHAPq0BgzanbyX6bAMHD9UBoRh
	xrjLwq9dxEX5TVtrD04jYIOYaMQy9Pz5Nn4xrJKw/+jAz8Za5y74ClKK5CdEHq8Fc8090fOiu6k
	UuCqJN206a6aSeGOl1e+d1GybeWIoSdjW/x2A==
X-Received: by 2002:a05:7300:16a8:b0:341:4466:1cd2 with SMTP id 5a478bee46e88-34271d8bc23mr1127530eec.20.1790369824550;
        Fri, 25 Sep 2026 13:57:04 -0700 (PDT)
Received: from royce-MS-7D09.lan (76-14-104-130.rk.wavecable.com. [76.14.104.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145632298sm8082744eec.22.2026.09.25.13.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:57:04 -0700 (PDT)
From: Royce Remer <royceremer@gmail.com>
To: git@vger.kernel.org
Cc: Royce Remer <royceremer@gmail.com>
Subject: [PATCH 0/1] pack-write, pack-bitmap-write: register tmp pack files for cleanup
Date: Fri, 25 Sep 2026 13:56:32 -0700
Message-ID: <20260925205633.530651-1-royceremer@gmail.com>
X-Mailer: git-send-email 2.55.0.1.ga30d533ec0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch registers the temporary pack files created by git-gc(1) and
git-maintenance(1) with the tempfile subsystem so they are removed when
the process exits gracefully.

Background
----------

The motivation came from diagnosing disk space in Kubernetes pods
running Gitea as git mirrors.  If a pod was killed mid-gc, the
pack-writing code left orphaned temp files in objects/pack/.
On restart, git gc would start fresh and write new temp files
alongside the existing ones.  Over many restarts these,
accumulated until the underlying volume was exhausted:

  Two repositories examined on a single pod:
    objects/pack/tmp_pack_* -- 27 GiB, 21 GiB, 11 GiB, ... (17 files, ~60 GiB total)
    objects/pack/.tmp-*-pack-*.{pack,rev} -- ~118 GiB across 6 killed repacks

  A second pod had a different repository where two killed repacks left:
    objects/pack/.tmp-*-pack-*.{pack,rev} -- ~39 GiB across 2 killed repacks

  Deleting those files and running git-prune-packed(1) to remove loose
  objects already represented in pack files recovered ~224 GiB on that
  second pod alone.

Obviously, this is dependent on repository sizes and number of
failures and such, but I thought I'd share my extreme example.

Reviewing the gc and maintenance code, I don't see any attempts to
resume or reuse temp files left by a previous invocation; each run
calls odb_mkstemp() unconditionally to create a fresh file.  Any
surviving temp file should be safe to remove.

The tmp_idx, tmp_pack and tmp_bitmap sites predate the tempfile
subsystem (1a9d15db25, 2015-08-10) and so had no mechanism to
register when introduced.  The tmp_rev and tmp_mtimes sites
were added afterward but did not use it either.

Note that git-repack(1) already handles this correctly: it calls
register_tempfile() for the .tmp-<pid>-pack-<sha>.* files it creates
via collect_pack_filenames(), so those are cleaned up on graceful exit.
The lower-level paths invoked by git-gc(1) and git-maintenance(1)
(pack-write.c and pack-bitmap-write.c) go through odb_mkstemp() which
wraps mkstemp(2) directly without registering with the tempfile
subsystem, and so do not benefit from this cleanup.

I have some unit tests covering this, but they required instrumenting
the code to add a wait driven by an environment variable so I could
catch/kill a repack on a tiny mock repo. I decided not to commit
those as I think the fix is self-evident and we're just delegating
to the same tempfile cleanup logic and relying on that coverage.

Royce Remer (1):
  pack-write, pack-bitmap-write: register tmp pack files for cleanup

 pack-bitmap-write.c | 3 +++
 pack-write.c        | 5 +++++
 2 files changed, 8 insertions(+)

-- 
2.55.0.1.ga30d533ec0

