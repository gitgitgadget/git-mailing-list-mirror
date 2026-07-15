Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6AB306752
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784149333; cv=none; b=k5YEYRuAFPDyyAxjODBvmclET1ppF8yfGXS2rRjtLYzZtjsq2+9GdyUpREI5ZV2FIyginIzMODCAvH+gbUR9lTbiGxcDTvlqMeSsQEsgHI0LH1/E0hF2UoBFYv26cj84qGtl1F9z0E1mUc6dqM624kujRc8hoKbtfuk//tOMGFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784149333; c=relaxed/simple;
	bh=b63FwAXWj671Jz5W7et9R08DCR2Q6v32Cdt4VG5jdc4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mH0zbASG+Ms9pha11lAVrRaPV920zXXv5MpPWSgNHMPlvGK2ea6cjLBFSKOo8UWTEtLl/tp4zrtquTDiMgXn6T8qC8hooGgPVtDcG6WlhO9GxlxIqifrKG8Yl0CH1U58NLBxgGO/WgPlPa/aoHCH1ImOrn6yYnk25lydIyJVpaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BX/jku4c; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX/jku4c"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c1372f84dso24264891cf.2
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784149330; x=1784754130; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QGhPD4wlK16cfPJHf0ZO8q+VJwE3VbJ4mUgT7ZSXaqY=;
        b=BX/jku4cCjky22yMG+OC0Lbn+VE+tfQoB3g1sbselUvPSK2fpsmgZawYgTbPq8hOTI
         Wd7njQiPu65iK1GCKjlJhKv1zFLSsaxh7Crw+h9TRkI+JnTScAWdw+ZUg6ugiIWWJ4Tz
         rPTkmHVYYcfSRgnG/c8IxhPEIuBRNNhWBQ1EhixjVvSQVGCyGrLQf+WpXwOkZ435b+av
         JQe2OuiFqDhVv/Ktf25FujiLi+339xOQ8AxD4iNZvMR/eNVHtyZXkwXXMgcZBo0/3AlB
         8YTDVlLDJhitESD/8Klf5g8cp28+yOUpZMtEJ9iPe9yMWnjNuo79C9ayFwMe6DS+26rP
         7ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784149330; x=1784754130;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QGhPD4wlK16cfPJHf0ZO8q+VJwE3VbJ4mUgT7ZSXaqY=;
        b=P8wt+KvknSvsuUKSNyK7+5j5O5861jmQToxU5nLZ03wUQoMLScci5vRJOcK7OWO3mk
         7t38VuMSPjS1jzUSFcgvuVltC4TvvvhwZEkglJLqjVT93NJpHgI9XQRpjJzhc+Rcyq6T
         ri6sEPSwTx4oUzGSsgfLVOG3oUOxHg5HZBo4YsRmzPEKuZQ728E0lWIC+Na3OR69Cgc6
         HVCI2OO7OqJqks55VCj+c4RGXvSnGeUlKTJN+4zdXcoKkIWftH/IzVQ+m0t8MKMXMg9X
         QhYRJGv8IwNe1xADbM/w1Vteg2Xl2expdJEIcGX7I+l9sX9YwnIGbd0sclr9tlLqLnni
         kT4g==
X-Gm-Message-State: AOJu0Yz/MgU6qnkMjyMqi2LL/xQX0lHv7FyormZd0LkDODrsH3p4EpIZ
	0BKE4tEyK8Ot/VZjVU9ZykHqY9J/zQF0bP7KVsBy9V+mAG/dUhedan3rK8dzLQ==
X-Gm-Gg: AfdE7cnlRx1NNhjOq0N/8CEBnngqya5osjaySYAv1c+3mGmserOwnj1JEortFu3/SnC
	DTXcBKR6cPeYHH0x+s+ozErTp16UtNvuQk97iz0yiV1USKulgHrdfUEnc772vQriOF+vfIx3N8L
	qVn2e2QnbPfU8OdzrQ8kbBk/T5Nr34YrcK9GYOAq51havdp31WkDuGNccNgNgmnBhBVgDuFdH/P
	lgaUDsHKzD+I7KGDsSvj06GQzfg3fth+ndPUMzhbGBHcDIv+fui7gtz3ZRizR5S39oFrTJWd5CS
	fy0SPNQYBGJaGTN3AWqtXboFkfHFsMQDMB4d1EuX0ZRnwdrD/OH+4+dhZ4d3/KsF6VHINlkQ3+X
	TQdqYYanbKXsIUxWiqCBu2yrYP+LTgh5lOWJIpNuCuDPtLKybLp/XkjPjydEPqdwYUJ0SNHq0fp
	Gglu6dkw==
X-Received: by 2002:a05:622a:5805:b0:51c:f3e:781d with SMTP id d75a77b69052e-51cbf38d8f0mr199749331cf.66.1784149330288;
        Wed, 15 Jul 2026 14:02:10 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.193.33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caaf621e6sm140187021cf.24.2026.07.15.14.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 14:02:09 -0700 (PDT)
Message-Id: <926cf01af697aa37a5860ca957ef2d344da72c46.1784149323.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
References: <pull.2120.v4.git.1781463564.gitgitgadget@gmail.com>
	<pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 21:01:56 +0000
Subject: [PATCH v5 3/9] userdiff: add diff.<driver>.process config
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Add the process field to struct userdiff_driver and teach the
config parser to populate it from diff.<driver>.process.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 userdiff.c | 7 +++++++
 userdiff.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/userdiff.c b/userdiff.c
index b5412e6bc3..7547874aa2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -509,6 +509,13 @@ int userdiff_config(const char *k, const char *v)
 		drv->algorithm = drv->algorithm_owned;
 		return ret;
 	}
+	if (!strcmp(type, "process")) {
+		int ret;
+		FREE_AND_NULL(drv->process_owned);
+		ret = git_config_string(&drv->process_owned, k, v);
+		drv->process = drv->process_owned;
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index 827361b0bc..51c26e0d41 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -31,6 +31,8 @@ struct userdiff_driver {
 	char *textconv_owned;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
+	const char *process;
+	char *process_owned;
 };
 enum userdiff_driver_type {
 	USERDIFF_DRIVER_TYPE_BUILTIN = 1<<0,
-- 
gitgitgadget

