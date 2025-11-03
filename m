Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E367D34D3A7
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 18:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192914; cv=none; b=oj+sX4TuisVPpvEazu9tzIBcxfPaEWgtPtPC3EzbXYP6Ffowlv+voxq8uw8xzZtNXB5RzP49NLzIdaLOOyS+04UHzMF0mrFUb/u9DTFRGY9JfdxZV0SFwU6jmF4+Z456Hd1Nb0aRxL8o4Phx35JuwNCn/ztv0fLhCwnCIOIJE0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192914; c=relaxed/simple;
	bh=YbqNRgYougkcdkQ36Kz+kd5Y8s0xevZwEipMggG8+40=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ArWds+jlXcDBfoE/dvAzURbcW68qWhj7QB5HW1ADAiTE1eVBnvqzAIYBw339DwqQPWR01OtgkaRRiFQQ1Ue+8Lm03DS4vgZURZvl7JJYd2KInaUgeaatXnvz2Jo7kQj5r5GjkVPDxq6BxhCmhzy+DmFrwoJm0AtjtjKNtnLQNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V55w/iPi; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V55w/iPi"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-557c5109d90so3323822e0c.0
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 10:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762192910; x=1762797710; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=H/jenzFQDxo9VXm680PHTsWBZ6aKR+X5cXe6b8Au2xc=;
        b=V55w/iPipirzgSI6uikR5H6QdndUQBGPBsDgB++gOZ/GvWtLZ1z81gL+1BMbWuCAx7
         BWYPHDRcDvuiIIsl3dKMLiIaNZB6mp5F4Iuwop1wnytQ99lTU/jTh4aNfzBSEcSXoGCr
         3SN0/hw7nlIfCZ2vp7HKmT4t8hk8y5qMB81J796K09dEnFD1jklvIoEckKymkgFf4BxX
         WoXaA++7J9lYQO+pWEHj8SKO2B5W7wlwpMP6Kl9LLfCW1BxcqRJQm+JLYfXUkkNPRMRW
         TRD9uqxTIc1yTd0Hkntj0yJilLcIsU9PmnLelvNaWzkug9QBpwAIbp07Z3q80LK2mixN
         hn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762192910; x=1762797710;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/jenzFQDxo9VXm680PHTsWBZ6aKR+X5cXe6b8Au2xc=;
        b=n6SQ6lBzFMoHApqe+4z04hLR66CvyjjAO6gbiUkMetfYdk05FE7yHtLC7WqsHV550I
         b5UtmT7U+KkSBwrafXUEFWcQhAAUI9+0FN3Ee1sodH5wJexUZKet16MRyp3aj3iyZq2c
         y/q0fdy8Tc8WdRkKSEA7EmekngAQBXzcsxBPBzn3x/HIDtcOXubIyK5GBarQOLdWQENo
         kdoqLBbmdpRBifwmVobxV5iEl6knD8DeTH9CKU1h+q4QIVzutw3RZMTP5aJVPbhPWiQu
         QWAMp3xQhP5EIxe5XSWGO/Ay7OrVtx3QwXAhcEnryQhjC4MKKjYkFpyfIJimR6BE3zQ+
         thYQ==
X-Gm-Message-State: AOJu0YxuwnvlrS3V1ziGx5hfJn7GCykojLLKw6zWkX7afUxVqO3J2GPt
	gq/Pp2udaLarpdp8dJ6wUO0bM41tJcJ9kJWY77iEuA+ubYFiE576FY4VKZLeeHeS
X-Gm-Gg: ASbGncsTpvO6s6Q+6DJK52sl1ynRd2co118MtmMCBNgrnrdPG97b6YpVfue6Nq2URc7
	7rx9B1ypboRwNQ76aoFZYaP4is3CjHoMzDDyo2r6PMOwo1HFTasq9S3HPUhO9NP9woFi0eEHl2z
	/jdJjc2CDQPDdlpKpWGVPPUOMAwJLcXoUbRnRmXV7LBg4aSzAVW8/8tYr5qLKCMbkJeogxZrwSi
	2/hxLQJQFRlz76d7hX+cfYmk6F/EH+rF8oOwXTo9NQUCBx83m4m6g/ZBEixU7DXqtoPEIgq7bYR
	/poBti8rY7by1mZ8Mzv1oxIigbknTKEAKC976n45s0vQ5prcgxoL6j953M+HW3Zdn8uBKUWcoPA
	Bp1P00r2SPnJnntnamWBgxS4SYSIzSNdAxIVQBH11DzWQ1f9zu1wdkTq7EIXawn8dYxY+rjrWlI
	5J3Pps/Ho1xRSzGg==
X-Google-Smtp-Source: AGHT+IHJuLBuYwrC7PXA8Ld35CvPqy7t/SO8K9JgfWXCUofPxHrhD0816WcseKh+QqLEDYXw91gxXQ==
X-Received: by 2002:a05:6102:508e:b0:5db:eeb6:812e with SMTP id ada2fe7eead31-5dbeeb69432mr784704137.18.1762192910334;
        Mon, 03 Nov 2025 10:01:50 -0800 (PST)
Received: from [127.0.0.1] ([145.132.100.68])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88060db7b30sm6715396d6.11.2025.11.03.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:01:49 -0800 (PST)
Message-Id: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 03 Nov 2025 18:01:45 +0000
Subject: [PATCH 0/3] Fix another crazy rename assertion
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
Cc: Elijah Newren <newren@gmail.com>

This fixes another special corner case that was being triggered at GitHub;
the error being triggered is the same as what I submitted a fix for a few
months ago, but the way it was triggered and the fix needed are different in
this case. See the final commit message for details. The first two patches
are just tiny cleanups I noticed while investigating the problem.

I will also note that I first came up with an alternative fix -- checking in
use_cached_pairs() whether new_name was contained in the opt->priv->paths
strmap, and if not, skipping to the next cached rename instead of adding it
to pairs. That would also work, but it would mean that if a yet-subsequent
commit after that did modify the old/file path, I think we'd have to
re-detect the rename, which would hurt the effectiveness of the cached
renames optimization. Simply avoiding using it in process_renames() allows
it to avoid being forgotten (and since old/file is NOT modified, the
upstream rename remains valid). Besides, this fix is nicely symmetrical to
the check on !oldinfo, so it seems more aesthetic to me as well as helping
us preserve performance.

Elijah Newren (3):
  t6429: update comment to mention correct tool
  merge-ort: remove debugging crud
  merge-ort: fix failing merges in special corner case

 merge-ort.c                              | 31 +++++++-
 t/t6429-merge-sequence-rename-caching.sh | 93 ++++++++++++++++++++++--
 2 files changed, 114 insertions(+), 10 deletions(-)


base-commit: 4253630c6f07a4bdcc9aa62a50e26a4d466219d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1992%2Fnewren%2Ffix-another-crazy-rename-assertion-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1992/newren/fix-another-crazy-rename-assertion-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1992
-- 
gitgitgadget
