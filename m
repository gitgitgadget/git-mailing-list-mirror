Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2131282F
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516962; cv=none; b=r3QOAyILz7fm002mMmORZxr5sJhlzhbZy9L9p00QqZvk0wFJsre7SyuisihwuNbv/5r2lPB5socC6RgrQvK/2iMwtMtpgoEK8T3RawNO7Soz2KLIoRLemJZx7vzeK0X14v6LM0UFTfvtRXeDzYIOhlCdUyCDKL0f1TwerxcK2sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516962; c=relaxed/simple;
	bh=GhkipAkeDys7vxAUtGP1v/e59h5wg0uUwEdqzr8x6Xk=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=AMkRCp5UQpBILY2ur7tmf174t0oMAI6fMeuubzvR1t61HklmwwpV7u/bD18rYLaynfAUHW3WDEJgMYv1TnDp+uAwVloCZ5TMOU4AA6kxgCN0jJOXY8jfvHTeBpsnjYoQKXj3LJc9x1ILp5zlh3anO9MypeWdSC0YDeNo1jI8ReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sli7ON6/; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sli7ON6/"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-448de0cc236so432564fac.2
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786516960; x=1787121760; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y5dgEhRAtMCvXyYUqMC9i0Bbk67DkSZZcrCsa70d+tY=;
        b=Sli7ON6/BYpHAB9/NjTKWNSDpdssFZftRdz78FQaN/3nZP5UGyhMCHjusur2Z4TTkb
         FUR6dEEOiR6l54MzMcfVPA9n3fjSC+d0dX+Ybo4gByVpS2N/ODTTMpPguJds6x0qpDCb
         xno1i7/76+oRDWLQCKbfYHiIwBToHVZ/7np1x0A4QXLUb4GHmnz9j+Nh77RXkRiM44UM
         OP2Vow1WkGREh0gnsMhxQi/V4CoM8QiFO9g9uDX4mUYswwjPl6yPuGsO/IsE2dZUfBOe
         DkqoyhqxCXIEqwu4ZsRi1KsdY79R6OhkDtde1uWRufetBY9MIcpgTNyndQ5l2s5foUU4
         NoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786516960; x=1787121760;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y5dgEhRAtMCvXyYUqMC9i0Bbk67DkSZZcrCsa70d+tY=;
        b=fAUS2EyVcAnlo3cZY46mdLtM0UMZMJHLLBANnSaBPOIKPIQGNygC9QziUqiXCw0+eM
         W2G/60lFv5RC8gl6B7yYchPQsuStMwhitpozrwVDcIg3gHZIgLZY2CJgd6kzo7zJiY81
         3p/KxMxGId1H7oFjCc+41fx9aB++8CNE6IyjlUq8pnkZIBurngaZ20/4r0S2hraJHmI3
         QhNyUjKPv5ul5q9/WiDua4Uu0CX1P+3u/z8cDuCBeY8odd43xCp28Cm0G0TbusHWYPMz
         ACxqPJuovjUZpqPZCe0uyhUR0/pUw3D6ZRUw6L2EWym2n6spCeWamQNPuZ8SxoYUAJSb
         lASw==
X-Gm-Message-State: AOJu0YyI6e7248elYSPMoXXsVO2vmEYZCYPHD/JAeReuUZ8npk0O9A+k
	r0camkUOadfTFxfZQ82KQVbZakT7Yp5E1YFPpxAR04gp4bTycJtjasFW/Fs3AA==
X-Gm-Gg: AR+sD11hmHmOOSW92ztja62/4uGIY9PxgWGMnbnJ2SK+NV/633IQsR8ycOMsG7jp3ks
	OowyvW5MdXJf/9hGFwD+v9ONaC+NFTL32he+s6zKXUHcrv1Ih4kHqeaI2UtNNOPBZPZaga8skRk
	McGeFGmiUjBoEvTSHm4S59GRfIh29Gaa/wx58fIxlevo151ECeVqgnCRzymdexl9ffrOLXJBW3u
	K3F8cNxsArQDtudGfOVtiz1S5KlsdTULC3IehdFKpo18e1BrZEC79zUMFwitubeeNk1mrojMSk9
	NUanrYHxVkpL24t/nzSOZT7ETu/IhGB0z2Doe4hMnrBNTlE1AIiVgWIOAVspBfEkqmLjp3JU7Mi
	r9z9xBCgkhDGP/g5In7+hIpDrHkr/0UYo7YywIeSS7VRB21fhnkg5VpC7OEd0917NbiAUbWubKz
	r1G+QkgOEZN1F4RPWdylzrMZbYGs6Vzo9njQQ/9Z+shAlYzqKUOMJ3UVR+ctZJfa3M
X-Received: by 2002:a4a:e84a:0:b0:6a1:8125:ffd with SMTP id 006d021491bc7-6b0b27ace09mr2210461eaf.30.1786516960402;
        Tue, 11 Aug 2026 23:42:40 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.165.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3b3475bf1sm1947460a34.26.2026.08.11.23.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:42:39 -0700 (PDT)
Message-Id: <pull.1922.git.1786516959130.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 06:42:38 +0000
Subject: [PATCH] sequencer: remove unnecessary variable setting
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

revs.pretty_given is only ever read in builtin/log.c, and nothing from
builtin/log.c is ever called from sequencer.c.  So setting this variable
cannot do anything.

This was introduced in commit 62db524779 ("rebase -i: generate the
script via rebase--helper", 2017-07-14), which used `git rev-list` even
though its commit message describes the logic as having been based on
`git log`.  Because of this, I am guessing this line was copied or
ported from part of builtin/log.c without recognizing that this line was
not doing anything and could be removed.

It's certainly not doing anything now, though, so remove it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    sequencer: remove unnecessary variable setting
    
    Random thing I noticed a few years ago, I believe while investigating
    our tangled web of revision fields and parsing. Either way, it's still
    valid and I'm finally sending it upstream.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1922%2Fnewren%2Fsequencer-remove-unnecessary-setting-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1922/newren/sequencer-remove-unnecessary-setting-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1922

 sequencer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 83c3849205..a0abcc69ce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6277,7 +6277,6 @@ int sequencer_make_script(struct repository *r, struct strbuf *out,
 	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
 	revs.topo_order = 1;
 
-	revs.pretty_given = 1;
 	repo_config_get_string(the_repository, "rebase.instructionFormat", &format);
 	if (!format || !*format) {
 		free(format);

base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
-- 
gitgitgadget
