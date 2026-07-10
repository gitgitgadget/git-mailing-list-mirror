Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B28438019
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701457; cv=none; b=iAzZj34POWcoOFk41vunMRkoNGkvCH5PMm/ONghRlHAi2cYiF/do0GybfNhehMRd3OBcRly2rrj0uNV0rTT0FDYAmVeVTMhdK0g0M0E4QdmsnKxCXJ9PS58ky3YtKDBKLgPFPFmaKK+0jHOmt7+Q3s/mEDDUoSQQQDlhE0oWRos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701457; c=relaxed/simple;
	bh=vMUHgGr2pTME2XTSEGDSDrpgc6g5k9PzEwT/eWh8gxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cprGGkW7hIjidB6VSirN2cdJDc6cgdyRVwDuhBZwvF6fySbTH/UUm90X/pF+9yFfYt5rMXNXwwI8BiAB++1+YERgTjsBCiFZDZXGjLeXTW1VHYMiqj8S8jjJBqDebB4/Yh8uJ591t0B2VpGMx+Ph2KLoObheB4p0r82h2TVaDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3RrOyOA; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3RrOyOA"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9ecb1e13bso574994a34.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783701455; x=1784306255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kqg9sL0H/xd73ZPc5wnr7FL+RaqqdWCJkO1eBYZa84A=;
        b=m3RrOyOAtlKz/w0I3+hxezXQSdh7nCfuP3r/Rs96Tl6b9a8b8/RD6YK07K/mG2OGxZ
         Vby2PXR+j7bvUaRSKEtfK6vmvHWEsdbLoELjVn1R5UGvtPbdaukxktlPt181up3E0Oug
         Z4cuGL9TsfeIW2CImAxbaAohNEKQRghZoJK5ZUQ0DcKScw9UXjwHwlTiW/C+7eD3IH/T
         QfuO6zI786pkQcRHi+7oXPJMPJg0tXgy1a7nbSCxw0Av09uy/bVFQHH+Yx+hIETJl/Tz
         OBw03ohGRzI6miUpshGZQuf7tJ65l4hV+x1as3benvRZysUZ2WG8YC3kTPNNrdKv6wO6
         e03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783701455; x=1784306255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kqg9sL0H/xd73ZPc5wnr7FL+RaqqdWCJkO1eBYZa84A=;
        b=Aw8RBcZpmA75BNn9m6MxpD/B36D+/pXdKp6B2zcpBX+hqvjG7Y/Ss/nmhY8X1727sd
         LvImNB3yLLHSLfVbSQMHVyY3gtxcBMwbaYOI8QqfmcOlQp+gaoWbfLV3hlw38YcN/7r1
         QxuHSUHoeaCuc5OUeDAzftzjQFibCFuyleLxpCzfnDFDx9X2WOh+af5zTs5VS3PJd4E9
         sRRwVCQutr/hfZdv+PRwA3dBYPFE2hZPZHT2UTMa6jwjPquhwLtFlFS+XfVnInLZMGok
         HoGIcnnlZbMErgy2BRX+2ofy3qvj/VdAgS3NDKJ4Nv1ySYTvP6exO3jtYEu6ZIx+IpjQ
         D0iA==
X-Gm-Message-State: AOJu0YwUnnIc3aDs0VthCP42FuNUnLndansbtqf3L/ua/M5A/UzpbESa
	mUX2ATI5tpwD3S9ucBtPGOPw0SJ3viottxFW2lKvs6+aTyEXGdGN+AZQwpwsGQ==
X-Gm-Gg: AfdE7ckhe2dbk56QI7hGcebD2ZGLyXoQJdm4diupsxehdapne5s38JldStcclGG2V0V
	0AQHmNgN21XgdIKFgZ1arcbuJk4Oe+hX0Gx+wjYzyx4njhWZLGkAnwXLnkHOhRqJJpAtg67S2Uj
	ohJLRTM10Rmgp+EtrQO5T8zJ1qJovqeq84A/Fmcwc/KeWiIWLZ1jz5Oae1+3eNfn3eY0/azf7Dn
	Wx01K3F4AYdX5cSanHj7M5ziizxYAYKIWEyPVQcdGONulsU9r38ynYtxHy/nKaS3mS6BKCqUOSB
	RqcL7FCGZdOYQvLv6FOmrAi0qd4uNSLPVH/1sOOd3TZCLp3INmPy1pQxWHsfRlxMgXp0STUD0zr
	q7QeA8ApxrJyiq8h5oQo0YbExdt1wIl51UYuteTzE30PdN/ohqXEU42uXbNDoCK9eoRHjJ4wTxe
	4CwPyPWj6Xw4lquz4ar/M9
X-Received: by 2002:a05:6830:608b:b0:7d9:f50f:96ad with SMTP id 46e09a7af769-7ebcffd698amr7949550a34.24.1783701455010;
        Fri, 10 Jul 2026 09:37:35 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcaf742e1sm6882147a34.8.2026.07.10.09.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 09:37:34 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 10/11] builtin/receive-pack: drop redundant tmpdir env
Date: Fri, 10 Jul 2026 11:37:21 -0500
Message-ID: <20260710163722.2962278-11-jltobler@gmail.com>
X-Mailer: git-send-email 2.55.0.122.gf85a7e6620
In-Reply-To: <20260710163722.2962278-1-jltobler@gmail.com>
References: <20260708235925.3992097-1-jltobler@gmail.com>
 <20260710163722.2962278-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When performing the connectivity checks for a shallow ref in
`update_shallow_ref()`, the child process environment variables are
populated via `tmp_objdir_env()`. This is unnecessary though as
`update_shallow_ref()` is only reached after `tmp_objdir_migrate()` has
been performed which means there is no longer a temporary directory that
needs to be shared with child processes.

Drop the call to `tmp_objdir_env()` accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 19eb6a1b61..50bc05c70c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1363,7 +1363,6 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 		    !delayed_reachability_test(si, i))
 			oid_array_append(&extra, &si->shallow->oid[i]);
 
-	opt.env = tmp_objdir_env(tmp_objdir);
 	setup_alternate_shallow(&shallow_lock, &opt.shallow_file, &extra);
 	if (check_connected(command_singleton_iterator, cmd, &opt)) {
 		rollback_shallow_file(the_repository, &shallow_lock);
-- 
2.55.0.122.gf85a7e6620

