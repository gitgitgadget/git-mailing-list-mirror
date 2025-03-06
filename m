Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F71F63E1
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256787; cv=none; b=rtPSgRHKzM9l23xoxRJnetwAVXov9A3ZQxlmGoBSXoJ2qESHynyfsIi9xN+rdce0UwFhN+zsQqLscz8dOLtLgyRD1nttw209xNOo7XD4DtmdFefdjc1BMPOIqqPzEqtaSrHLVJwUgL3PTtbgdkX8twXUuqTiuWuzhoEIUsHHJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256787; c=relaxed/simple;
	bh=GwADelxk4yHsyojxB7C8PKTjwHaY08iMf638eGvAp0Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uIQoWRsyWxyVmF6HpUUQ/WfnqNi5xUujVBYBp05mUwasU5MDZ9Dm6rksTwxrck9j8enJVQ+c17cte7kBt569iFgeYQIGqYegGX3RST725qzTL9pUwSB56f2JUxSVE5HIEZkzvVetQcCQ6ApeWx6kxUcXrOXoLwkUjGtQnA8TCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUb42/Gh; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUb42/Gh"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso73908166b.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 02:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741256784; x=1741861584; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGaJujnVkNJgk8cC3UaqeOejOCa90fkdzPUMX4gKgqc=;
        b=OUb42/Gh52fishcTLAmTUFdEpnwU5WSo6Y3tQq/Yls0HBTknxYnDALVUYR5Vva558D
         PrS5gFxksFwmNh3HCuvmAmhWvozcaiIyvIstxEVAAbjO9UlSJPZI2TMkh6mzDfbPp8Y+
         7TsYO65Jtg8+TLFfNU1h19pJkNMo559WErcMovsFwGdc8CNu+1kQbfjO4Q6v8VBTHDl+
         0BodSvEjKpPBIjFZIqmqlS2WPCNzov4i7kRU15C0NNDgtjrDffrHK0rclby5GF4nbrlg
         VFTj87hNJAvDQDt6voxaEzYtpNnKmzINoBiYn+AZ62tPCOkRMTEgJPh/n+OTO8q6tCwj
         wiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741256784; x=1741861584;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGaJujnVkNJgk8cC3UaqeOejOCa90fkdzPUMX4gKgqc=;
        b=PI7Qf0ZDqd7ot3oSsEp3WHQKqPQ50YzMgUZflbEYq8qZPMZ9d9OVGWI1l4RHHy8bBi
         nLi0e1WL8Kb23v+UudDkLUPfTrWifaQENyZ5U+5BUoj3eHtDH1tCq1uHmKLlhRD2iIF6
         J/ZS7z+SolMeYk5daalyzKIL+U9+k7ZsfOOfsmSfNuWMw0m3zymGApxtSRbnNfPZLZim
         1kHgIUajMk4+S3gsY4/JOadUbxEYUegHLGCEo3WkdfABbUHiEYmZ81vjn4WYDT+ADBPn
         U9tWGC65FpMpp5JbCwFJEU9wQOfhskR2fOTOQU4xqDNeGyDOmxpNeyzIBXFF72LQ2MN6
         WvZQ==
X-Gm-Message-State: AOJu0YxBiGdXbgyrCenC4/+NAMbUpZQ7ke5ZIN2WtCPdJ/l2Cixl1wen
	kyNbuutC27wUS3alH09eOJ02/2rT5Jj5INwbRb95scgK28jZD1AjECMbfA==
X-Gm-Gg: ASbGncuJ4d6vEJw70nHDDrjlWGwwgurO4YBj5bwmFbtbQOPwDZFQi/q7LpeSPbN7Oy1
	eDP+bR0wl2syDTYyOX53QsnoNdaF7tVepmMRw22gE/dnCyqQsyFkhc9e+jIr80ysnMtCZVOBVXx
	fR4vZuzELLnsUS9YU1jeihnPT6Ko4AxpeY29hUDfcb5bti2Y5r9EzKTfQZ111YP2NmpW5c1Pw2T
	ZQ2I3goz1Z3PfCGEly5Z+LmVzwWFoNz/mwX4BrwZLjCAXlnAcNkE9F8JptAVxQHrJt6mwRYpBD0
	KEW2jCsHV4uONCQJ5Vs2C5z1scRlgPipNp7NbeuFxRzbGA==
X-Google-Smtp-Source: AGHT+IHSZowailUCkMRsOIBhNvf/o+iLY5Tn59Ad7IfIQFqcAna8vzcpKCtTu2csWi2WfGjMZ+5WvQ==
X-Received: by 2002:a17:907:96a5:b0:abf:7a26:c46e with SMTP id a640c23a62f3a-ac20da536d2mr709101266b.30.1741256783764;
        Thu, 06 Mar 2025 02:26:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac23988e590sm70090566b.150.2025.03.06.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:26:23 -0800 (PST)
Message-Id: <4e9ab3e011f0d3c619f58ec88c8bbe8f5cd56ac1.1741256780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1867.v2.git.1741256780.gitgitgadget@gmail.com>
References: <pull.1867.git.1740671049.gitgitgadget@gmail.com>
	<pull.1867.v2.git.1741256780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 10:26:19 +0000
Subject: [PATCH v2 2/3] meson: fix sorting
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

In 904339edbd80 (Introduce support for the Meson build system,
2024-12-06) the `meson.build` file was introduced, adding also a
Windows-specific list of source files. This list was obviously meant to
be sorted alphabetically, but there is one mistake. Let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index e86085b0a47..efe2871c9db 100644
--- a/meson.build
+++ b/meson.build
@@ -1109,11 +1109,11 @@ elif host_machine.system() == 'windows'
   libgit_sources += [
     'compat/mingw.c',
     'compat/winansi.c',
+    'compat/win32/dirent.c',
     'compat/win32/flush.c',
     'compat/win32/path-utils.c',
     'compat/win32/pthread.c',
     'compat/win32/syslog.c',
-    'compat/win32/dirent.c',
     'compat/win32mmap.c',
     'compat/nedmalloc/nedmalloc.c',
   ]
-- 
gitgitgadget

