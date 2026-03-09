Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94981396D2B
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 12:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773058446; cv=none; b=OrXLClNMu9fueYSEAq0rCHoPWGaFsejX+fhEODtLl561PR//PiofJV0Mu/ggEQp7rv0Cd0xUHIiKsy77t919uDf30+oX2abJ17LijBbfNoxG8jzfXdrFsScojcyYgNk4AytA5dQq6BI/ws6rCuhhX7Ad/JWEaBqwMba0KP34i8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773058446; c=relaxed/simple;
	bh=h3BjL+Er0mJlne6kqQU3mExXm9TWlEVkRLdCqYoJ+RI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JweeU/4uyfMjqTUpSRB+6fJO8DCTThFOPZI11MJBPJ/FpSCrpIZB1VMdVk5HBP1Qmh7Rhc0T+M3KjBnET8dCzDHawdVHZi/rSneCkkp3fqlLmu4R3oSGR1RgpzyDAmpAUrIx83LX9TSG5aPK4wkRxWcvu0HZ2D2pOcnyji6OW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAusGvwS; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAusGvwS"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a9296b3926so88521865ad.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 05:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773058445; x=1773663245; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yI8UalMZZe52C+Vm+ACl7hjGW9Eg/NCBOBL1CurzgPM=;
        b=cAusGvwSIaqZpHjOHsQqiwOYtPqOXPbBsrI1b3/n0Dm8xYM2//lONEHNUNFbTc51OY
         TElmV2ZHjC5Spra074DqzgI6VvmAPkz/AlPCBnSHkRYLy8qehEPC0HlP1OOym24B67z1
         UK7xOV33YGAxJYy03A7jwQsf5GZtSnLDMQtjzDTeiCpG96aFCpOoqDo5Y5++auMk5AXU
         JpH9iJpl0HsH/zIpVCCkVVZaizFNFpO6cHanBlkfpKIbZDBbVaez6zfu/oEuax1HF8cw
         a3UNZyuZmhUMfKtz+/Fy4sh0agziNEkC9pRHkIbbKjeUyxHCJkwJMm5QjPPFzNAm+k/e
         Ld5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773058445; x=1773663245;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yI8UalMZZe52C+Vm+ACl7hjGW9Eg/NCBOBL1CurzgPM=;
        b=HI5EVaB5yCkCR0OlAONeXT3SR8cyUlrEnwZRH49UsFeuZ/HNYrrmvuhke7ayDqqvIJ
         qEir/Nopnii0WM79e+XNyum+tkacZa44hw906TlRoiNZea8cRfePVyln4ZDSNhGQSKmE
         rGCwxLrwMISg/P5xsWEIQmHhvWOrU2+D2pRRk25vdHaiDYQz6sc5786W+gjUXibOZ4RP
         qb7s2yQXGKpL9yBxuDSFMu18w+9blSkO94UGiWcDgo9TkUKDmUJJQlwd//ztSC+3v1pU
         8MadOaA5+oxMw1P6f18YHVEUfceLmVHELiwJER7vYtaJiCuGj5ft51H/R0NF9k41Dy8L
         RMjQ==
X-Gm-Message-State: AOJu0Yy4moj3BPKMsQu0ISKP6ZC0EsfuPpFRfGE2MJcEUOvPK6X6QlVf
	pgisN7sh60+1yYTUcTl6L7YgDfeUtsZyKH+YS3wZXl5ta7h9tJyEBWknbxbS7EIN+Nw=
X-Gm-Gg: ATEYQzzpZKWytljtOQ9LV1IzFVMVkauGQGo2987R7dYxbSiMzl5YbRWjWSdPpTXc400
	n9Rs+odmjtIfCVf62PN0i+pwi2W/ClNZoDnmUPXZatQDKhzJFQ495UcRShyM8CxcwKdVZd2wqtP
	73YkyDqFWtx8kI4aar970LomKsw7/Lg82LDhAYePoayPsux/uXC3dw/riNaLfU+WB09VXfH6jhU
	FfrHIHigp94F6IX059Fv0CfJCgyUV2/1HKD1qayG7sJXKy/ipwXA0MNLuaEUZ1woRIiEcw90Jsr
	3U5RPW+lWfYBIfLZQtE/l2uZEX9HtmRdWSPtpYxSRzBal8C3P1jyIOPUuK0UhCnxOo137RZ3OJK
	ajM4TzxbwEcesICmvMxCsQR348frfwwBhe/+gRg0gcA+4TV5YtKDhnZbCpLt0+25E+8O0eWKmKg
	KisIuO7KYqDbuJ4OlE5fDVRFcsdlsbqcopfxP9f8dzb1wIA5ep1NonfY5gdZvM3eFFwiibw3YVD
	NObMQknxJeqQZROYl9LwpHwCzDJTujzzSbkXLQV0/rtMcIXFmV3FFQ=
X-Received: by 2002:a17:903:b88:b0:2ae:5435:1941 with SMTP id d9443c01a7336-2ae82539651mr106340825ad.51.1773058444651;
        Mon, 09 Mar 2026 05:14:04 -0700 (PDT)
Received: from ThinkPad-E14-Gen-6 ([220.158.168.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9b9c6sm129546535ad.29.2026.03.09.05.14.03
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 05:14:04 -0700 (PDT)
Date: Mon, 9 Mar 2026 17:43:59 +0530
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: git@vger.kernel.org
Subject: [QUESTION] Improving disk space recovery for partial clones (GSoC
 2026)
Message-ID: <aa65h6Z_TrpJbmkj@ThinkPad-E14-Gen-6>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm interested in working on the "Improve disk space recovery for partial clones" project.
I am studying the codebase, particularly promisor-remote.c, builtin/backfill.c,
and the partial clone documentation.

I have a question to clarify the scope and direction of the project.
The project description mentions that git-backfill vs git-gc vs 
git-repack vs git-maintenance is still undecided.
Has there been any recent discussion or consensus on this?
I want to make sure my proposal aligns with the community's direction.

sincerely,

Yuvraj
