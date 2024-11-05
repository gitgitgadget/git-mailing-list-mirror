Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1211E2007
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730833515; cv=none; b=sBJ1I+s2CGk0NusGVuCsZVoPp3EpeD2JniYeyS2SL+GBrnpDGPHbZLJ0qpjKAQQ66M7h7JLRU/aXyp5DNozBRzrAOauQda3FTHMIl+dQYOpX7djvl0Q1N2M9VrmDcBL4dCiJsfL1MB+Cw+Vd4HDpdzTzo6e7NN8vOforWm/sPxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730833515; c=relaxed/simple;
	bh=qy/YkWlKtdd9KwYg7BHV+FMKt41kCOSWW7Pw9cn3znU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AimVIilBfhrwSDo13XOzv2trWv/WqAvM0fN5y0VpPAeWVbqTrDSGdbyg0OcE6yj++1z40Gwv8YXLQz9V7Ar4KGcCuMQIeDbhrX1cbL3L7lagZ2OTHyd7iZ+NyDkT0R0bO2PFIyXGuhn+p/aVSwRaGfk+eCJo8wxm1PjqPrMqFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=rIKwnR3w; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="rIKwnR3w"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e29218d34f8so91512276.1
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 11:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730833512; x=1731438312; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+PsZBAC3zIPlhosMi4HsMbYB1YsAiQTc4xvKHPSRnc=;
        b=rIKwnR3wY3Ae46DKxCK9Ly+3t6LSgaJMZKFWx00gAVSW7/6YANHjUnyFos0EaGKmir
         Ob5035hjiYo3NV+PukIjnhQbBs5+kZqBl2PagC+tWmmIyJ3VsvF5sDeMCCnAaHB3BIHi
         6DQWZxmEMfoFHNoH4QYbyk2FDwcv4hdfTp0j/MVns8QT2O8zFBLhqG7DAfQcy8hhx3d8
         Wnfcv+GN4swIIKPAAE5dDpSLuIr+qMbncJLayjq5K8mUHS3bv6f/MLqfgpA+qlh/f7a+
         9gt+Pc7r5JgpUyheVMUhEWi0P4PsVlu5bq78YmxZ9Xb6jSfOq2Q9r7VGa0y9+Rw+Q45n
         VlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730833512; x=1731438312;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+PsZBAC3zIPlhosMi4HsMbYB1YsAiQTc4xvKHPSRnc=;
        b=S+fDbTpnhf+/g771fWPxqsuETHeZa55ype4dQ4VSCQk6M9rqZqktg2urGBVOIeeiIe
         bP3fuZBoSdMbqGAFf94I6bkzhW/DeMhtyltYj07mWL/G/+VjZVepbdiAqF+lE4GEAI+L
         XBGGltVaNUsZUHqaAmiCAEKGJ941BFLhn/z1R/UqEu23iBWCCOvmIwaJVdEbosu22JDE
         QfH2vFxXbWLGV+ZxTLR7UwR1Sc3lA5wY8cYBmMveJoL0rjmCiCuB0BCl4K7Si6BIL0YK
         UdicDRDsvv/Vcnm+UMY7aBfGa8Z9S91DPuFzecy6Iv2txzRtJCsPgKxwHfJT4ErBYuRi
         bXuA==
X-Gm-Message-State: AOJu0Yw4GZt7xVCDGDxbXJuiY9aNAlgj3TVrrhTt6wtVrje+9bApL3CN
	MwyaywxJl1NGA5SSOBId+snkJBWVNbFbHTKZraeVywqLgY+IGdRAwJ39SyWVh6w9Z144F06YBQn
	HS+U=
X-Google-Smtp-Source: AGHT+IENch7lWoeonTzs9EvuIS4UEL50XG1NcxAI4lOLhCoKEABXRH3m2QGU7hdpV/qx1C84RhUn4w==
X-Received: by 2002:a05:6902:2b90:b0:e30:c850:b77e with SMTP id 3f1490d57ef6-e30e8ba581cmr16717140276.3.1730833512524;
        Tue, 05 Nov 2024 11:05:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8a7ca4dsm2676458276.20.2024.11.05.11.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 11:05:11 -0800 (PST)
Date: Tue, 5 Nov 2024 14:05:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/2] t/helper/test-tool: implement 'sha1-unsafe' helper
Message-ID: <cover.1730833506.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This series implements a new 'sha1-unsafe' test helper, similar to
't/helper/test-tool sha1'.

I have found such a helper to be really handy when debugging the new
SHA1_UNSAFE build knobs, e.g., to easily compare the performance of the
safe versus unsafe routines, different unsafe variants, etc.

The first patch prepares us by setting up the existing cmd_hash_impl()
function to be able to conditionally use the unsafe variant. The final
patch introduces a new 'sha1-unsafe' test helper which calls the new
variant.

Thanks in advance for your review!

Taylor Blau (2):
  t/helper/test-sha1: prepare for an unsafe mode
  t/helper/test-tool: implement sha1-unsafe helper

 t/helper/test-hash.c   | 17 +++++++++++++----
 t/helper/test-sha1.c   |  7 ++++++-
 t/helper/test-sha1.sh  | 38 ++++++++++++++++++++++----------------
 t/helper/test-sha256.c |  2 +-
 t/helper/test-tool.c   |  1 +
 t/helper/test-tool.h   |  3 ++-
 6 files changed, 45 insertions(+), 23 deletions(-)

Range-diff against v1:
1:  3b31db4d2df = 1:  0e2fcee6894 t/helper/test-sha1: prepare for an unsafe mode
2:  d343f5dc9e5 = 2:  d8c1fc78b57 t/helper/test-tool: implement sha1-unsafe helper

base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
-- 
2.47.0.231.gd8c1fc78b57
