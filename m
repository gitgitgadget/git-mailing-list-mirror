Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9493D6CD9
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954681; cv=none; b=lnDFXqyi56IXWcLGwGy+8LD4g7XoxkknLrdcO8fR8aTHyqsLERB7sCiW516lZ9tu3RUMa3sw5aGyXx6w0hP4vs/ErM0RBRqT+bZF6yqG621OJmRGwcxq1s9E8DatqWqihfv4KpqBUCglDHNqKjAKJwI6511vfqBS8ptv7l3RsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954681; c=relaxed/simple;
	bh=jb1+5zh525lJx2yTH4w9R1S975YJtAmBtoDENblHSJY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JiuO7C+iDjCwucbbcYfPP6PD6xL8NihWTzCJKj15+gzyw0vxO9YPVp+eGI3Nty1l8qizgw/ItpPkZtrz18ngeFyBM5/alSktks2KKJYB9sj0YmVbcIJvuy9/7IVQFUqdYR+yqZokFpKl/M2yAOvcoGHOYlWqSdz7zC+g7xxSpZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajXcaPrw; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajXcaPrw"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e347638adso1475288a91.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954678; x=1786559478; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fRccCIDR+jTMBT4usvw0ZbAZlpjVniL2pBi2VJhyIow=;
        b=ajXcaPrwhgBVOcHeMvcGaUYPCrcI1TGJCEMOmkFOCd47ZdIMy4m94lHgO+eFe0hdbQ
         Ss6Q2eTsG6CEba9iQhGc6q22FIyG6eUpLzvUdRODBoBL415+KB+c78OW+w+w48qSdCpm
         6oBymmGmgQlaJHiEwTRGKJ5x7AeYQgSaLI7Xoxwr1z/dVbL7Jm4/NB9wQHf7EngpU8nT
         EOGWIWpNxF7fpTB4mPNKeBft0ToE/2252Zux/Of7dqD6x0V1wOF1rtmNcMRdF0T1r+4T
         j6aUR5+WAONT3A4I0IHnAlw6JjGWyW5ZwSoFNX5SpFfTSKxMeQuaN3EQyZgVPkqWyVEq
         dYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954678; x=1786559478;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fRccCIDR+jTMBT4usvw0ZbAZlpjVniL2pBi2VJhyIow=;
        b=iXMrgIed4LAseNHyzjWk3xFI2cCRg3/RDJkfYuAfCzQ5GyTNJTTvBKVEU0eK9Zdf4M
         BjBEbIIfd8JkykjFuoIEdSoOLgso7EzW8PagPDQcXRaMglCNOrpglr3Y03ZI4Dz4zuVC
         iqItuw/PG4ndZpcce35ZjJxfLR+vO1w2Ock4/altYpDWKxq/Y+tK5K0hRbvMZgUsIoXT
         eWRtXc5JYSCgyiPlcKtqbUoZHAEGauqHtJwQPVz+/FBZmcqweiCZDR4/51w/ldpfBHD2
         RYN59g3lHtI43l/HELgaBMa5hdiW5w4qS2r3sUaloBur+xlv2NrT6WpHuVIaaoNjqDl1
         ER8w==
X-Gm-Message-State: AOJu0YyGoB7bt8/AZg5XRGNx/rvbUqU7m4t64ZeiACk9KoydEeP41FfN
	LXmUMMgZ2YbqEm5V8B8FarND85e8wdI5a7qyYjaKQaN8t/2TWeNqVBCJikIEgA==
X-Gm-Gg: AR+sD10PP8zH/eQ5U3uMUux+8kKoRE3E07fC2gNub+HZlJQNoQ3xAR4yGuso+56EFxI
	VIHD25fws0JzZhBo5N0BeB0Pc27e/4WISzkjme1g1T7YMJSXBNMxq1F27JHLXZROW98yzqy5xqv
	4qIGEtraAybn4jTioCzBt8YjQNBdguINgT81/EJv98cRx8/99842pP8O/lnnRLBG00krdRLVYs6
	9F4wN4lVY/q3iu2w1dUSdJXGcjwsDZIs2fiG9UzC8xRw35yC/p4jObBsJIT2GWrNsdE1smKWkan
	mQBrtK0ieplXg9hLFCTQ0zN726TLc539Ua0Q7+wOA3uEi0xiIR4tbzorMw6VRPtWcOjw9ZfExuG
	mOWEBg4RvTRVrpn8bfg5L7yM8mSFU64o8/iUYxaUAa6jpBUOPsFwWPGLHmvFdAuMN5qz2+fJqog
	m/IFV+xVcCP2kOMON+Xi4tpZY+zlMI+xWdEMwnq5eer8s5lDxD0YpDsFJ5gc1LLR7zsQ==
X-Received: by 2002:a17:90b:6cf:b0:380:7688:fbe9 with SMTP id 98e67ed59e1d1-3903c559075mr9659314a91.8.1785954678055;
        Wed, 05 Aug 2026 11:31:18 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903f62ccccsm1706849a91.3.2026.08.05.11.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:16 -0700 (PDT)
Message-Id: <2b0e4f32fda6672f5d093e203e2e9774cf464aef.1785954661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:30:57 +0000
Subject: [PATCH v2 08/11] transport-helper: warn when export-marks file cannot
 be finalized
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When push_refs_with_export() finalizes a successful push, it writes
the fast-export marks file to a .tmp sibling and rename()s it into
place. The return value of rename() is currently ignored. If the
rename fails (permission denied, full disk, or an antivirus product
locking the destination on Windows), the .tmp file is left behind
and the existing export_marks file remains stale; the next
fast-export operation that resumes from it then silently operates on
inconsistent bookkeeping.

The push itself succeeded by that point, so promoting this to a
fatal error would be inappropriate. Emit warning_errno() naming both
paths so the user can recover manually, and keep returning 0.

Flagged by Coverity as CID 1427723 ("Unchecked return value").

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 transport-helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 31883b244e..ed0543f1ad 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1184,7 +1184,9 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (data->export_marks) {
 		strbuf_addf(&buf, "%s.tmp", data->export_marks);
-		rename(buf.buf, data->export_marks);
+		if (rename(buf.buf, data->export_marks))
+			warning_errno(_("could not rename '%s' to '%s'"),
+				      buf.buf, data->export_marks);
 		strbuf_release(&buf);
 	}
 
-- 
gitgitgadget

