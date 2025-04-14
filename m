Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483562AF0A
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744665369; cv=none; b=ZOIakv7mi68icSi41uo5kTQSj/qf9KU0liA1y8YqPrlpmx+SZNiHrm2Z4bxrLDLfWIIY2/15IpnsBHyOEw0Nf+Oqu9DP3u16vF4NNWJeR4Tp5Z+9kZ1dEieEn1NjPPKOMkCNKm9Bf/nqEOb0NVCceogAt6E4S2ha0lJGDeMBDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744665369; c=relaxed/simple;
	bh=7kVcuWgIrWUvJa1xqjcaHfpmGd73vsFMXJTLt3emX0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MaRJHxGwhRMxkInBuPbx11EZHgPvNDWG0Fb9qLgTffkBtYa2XV1RS2z2HxDWFKN+tok2J+7rmwlWDZqOVAbPzpPGtRxBY/pI+WBbqyBfG/0GaUROhtWjaI7ucM/3PQHaeTlXXxEXIU62XQ0FoXL8eYyGys0I3zRRh+Z8/iGjMC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBOluhda; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBOluhda"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so8330530a12.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744665365; x=1745270165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A/QnRHzqMoxjHFd3mI0dWBFcPsSwBJpyZP6TtPN4hYc=;
        b=EBOluhdasOoFTRGAbUdG7iIWKdCFs3vI/v2C0H5TXvDnD5/sfi4boMP8p47O8xZTjS
         jU04+zke64uI7BD6zZySr1GmLSLqaty1HzGmWl1W0gyDsyd4IQscoWQroYkwzkMjge4o
         7+ChbHyFS3FdZhSC2oL1AyUqe9NV6nkvZnl+0XyVQ+98dutkOKe5tWvriN0vfxgD8O9j
         5+NwoSst0S10S2udVCL/opiBsjSBkWo565RkkvydCzPjFFZVuIezoJjOuGICYLuiTpTY
         qAojUTDg3kylTCgs6P874wqjwiK2Ck7xGt6kgUKksR4SYscrVYtK0ItfAZJ7M2mZ9+CA
         hQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744665365; x=1745270165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/QnRHzqMoxjHFd3mI0dWBFcPsSwBJpyZP6TtPN4hYc=;
        b=h+Rg559iYw5Ww8/jk/PGU1bcKSNLJ3JXoIVkQ59ReiTXL1PQBdFWyLCaHSOLPGaGUF
         S2JNi5BY8MsMCyGe/W/pEJDTwXDyQjQWNQmbBiDEF0SvNDoDTKNH+ValdKmE1q73nhUx
         os4VNVfVBl5BfiKjIwRLRruS1wsoTMO31iD6Hada95zjGpAwRNQDW6lruWfCoa2JYR6P
         AucvrQQ0UqUQyt5N0Xy/18ty3lOTsbkcE+Jd393MYkPkiW8Kl8ZJb1tjeHLEeUKrkLg1
         7jRCdusoZ4P4Qv8cbNjmUBOanqYxTIGXZKyGYm7n34W+maf1EFxD5XnLJbJxYK0urwdr
         HiCA==
X-Gm-Message-State: AOJu0YxZGrqErSK0L3OArPslN4AJBRLyRCrR9/QYKWDwm6i45fGL8MZB
	Dz747vzRfeG65hb4PL6fIp0avKuTE5hJwQeROrFCcZAMFn5oa41swNYa/ga5
X-Gm-Gg: ASbGncvBFzKyN6wXHRzR1ftpctCxvCvaWeP9Vdy7jIlfnJVagiW3Rl+/Wjg1AXPa8A4
	ff0IBSRTK7eCAPDfUEWSgc6V6urof5Sv90tEdlFK14yJxFHCNx1dov61jdnESsYWl8WjS+nYpxF
	oZ8ZtvJn44UEpb0LeQKW46IwDIFzeHaHfRYWCP/fKdv/yKre6OXH7vL21KiYViqME7HJCY2rkm5
	O7JSgjSZN3DQ7csnmElrMymtszKMPw9jAhRwEdsErBZJmOvqi0Ay3MQNMM4SzzUyqsy8+OIH+tt
	9OLlI5D/wnyVGKf98qT8hDwO9nE2jg8CIesq9J41MXEI1p0=
X-Google-Smtp-Source: AGHT+IHeWx95J3yCpw+RUEf9cdvOlkzNY7YUub4Z9dSJ+Ta7/BB8J/87Mahjcp9s1wdVoauZPhdapw==
X-Received: by 2002:a05:6402:4313:b0:5db:f26d:fff1 with SMTP id 4fb4d7f45d1cf-5f36ff0476dmr10866614a12.21.1744665365411;
        Mon, 14 Apr 2025 14:16:05 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:f62e:e088:2c58:70de])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36ee54fb5sm5527518a12.13.2025.04.14.14.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 14:16:04 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 14 Apr 2025 23:15:59 +0200
Subject: [PATCH v3 1/4] coccinelle: meson: rename variables to be more
 specific
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-505-wire-up-sparse-via-meson-v3-1-edc6e7f26745@gmail.com>
References: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
In-Reply-To: <20250414-505-wire-up-sparse-via-meson-v3-0-edc6e7f26745@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, toon@iotcl.com, 
 gitster@pobox.com, phillip.wood123@gmail.com, ps@pks.im
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1987; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=7kVcuWgIrWUvJa1xqjcaHfpmGd73vsFMXJTLt3emX0o=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGf9exKN8TxYyqVuirE9RpoqKNqrQdC89cafk
 DPDZxgwStjan4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJn/XsSAAoJED7VnySO
 Rox/nz8MAJV2dNF8iro0WsPX0ciRGJH8Zh6J8DpVslgAzDyJfEnKWgEhYwP6TL9GyALeXyWyHXX
 e8fR7AXo+uV+RT0jhQS6/gcs40gtfylDvswUT2Dz7u8hojZ0qCqLhjrqtUtZq3HL79+86lj9REf
 eRAv+K2NiHcVGvuAbZdMxuQ5b62QVW19y/eEJISQp6dckM0x+WwJ/QSuIb+CAlryan0yJkWyAVL
 Rw6yW9tSxcbaKlrcPxMsfkFM4pU4mbFogQHPP55eoCXE/MU0227X0n8qs6HgUh1nUNM6/GRGvvi
 7+ekHbWB+sOZeSXYZym+efDUQ4ItY/EXDZ/gprPrADZMGh15mg4vZQ87uQKtSJ6ECoJtdiJVtKX
 Bs+sYnIcIqXocTRtESDp01GxksHgPlK5OfvWp4MIrmDl2k52uDmEPD1jpbCU/l5cwpTLRv6tXZH
 8ZUeUtVI6sqJqajLPFw/5Lk87KFBChWYGhjqcYiVNdGY1ceCJpLUrBtOHu4u0d435Z7hXUUinJ5
 2s=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In Meson, included subdirs export their variables to top level Meson
builds. In 'contrib/coccinelle/meson.build', we define two such
variables `sources` and `headers`. While these variables are specific to
the checks in the 'contrib/coccinelle/' directory, they also pollute the
top level 'meson.build'.

Rename them to be more specific, this ensures that they aren't
mistakenly used in the upper levels and avoid variable name collisions.

While here, change the empty list denotation to be consistent with other
places.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 contrib/coccinelle/meson.build | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/coccinelle/meson.build b/contrib/coccinelle/meson.build
index ea054c924f..03ce52d752 100644
--- a/contrib/coccinelle/meson.build
+++ b/contrib/coccinelle/meson.build
@@ -55,18 +55,18 @@ concatenated_rules = custom_target(
   capture: true,
 )
 
-sources = [ ]
+coccinelle_sources = []
 foreach source : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.c', third_party_sources, check: true).stdout().split()
-  sources += source
+  coccinelle_sources += source
 endforeach
 
-headers = [ ]
+coccinelle_headers = []
 foreach header : run_command(git, '-C', meson.project_source_root(), 'ls-files', '--deduplicate', '*.h', third_party_sources, check: true).stdout().split()
-  headers += meson.project_source_root() / header
+  coccinelle_headers += meson.project_source_root() / header
 endforeach
 
 patches = [ ]
-foreach source : sources
+foreach source : coccinelle_sources
   patches += custom_target(
     command: [
       spatch,
@@ -78,7 +78,7 @@ foreach source : sources
     input: meson.project_source_root() / source,
     output: source.underscorify() + '.patch',
     capture: true,
-    depend_files: headers,
+    depend_files: coccinelle_headers,
   )
 endforeach
 

-- 
2.48.1

