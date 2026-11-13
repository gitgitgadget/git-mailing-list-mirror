Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794607914;
	b=zZDhNcQRFUQCf1DFY6/qh+FdhVT42SZX9tOATxPW5w8/mwp3NjtfM6BQRCH470IY02NR
	 lzDhkqb9gXnPbCsZXRAQV0oUOmoiLSbyavKtI4BDxr0e1Zr6Wfd2QTGU//2DpFTst/Tf5
	 hMh392zmOVwVxYTdxwe7rw2ON2XUBvQcFW+lXGEveFqnfVPvQgQy5eIEAU2iYoJQNIXRK
	 7fsfNnD+7bqpW+hgDszEZQuSJZQCBxra8bG3++MyT6z8ecZW70FepzkDH2TakZ8l0eoE9
	 SSV4w38t1s3zgnyVh9vLTxgqzwrGpoqZo0YG8h3ImcvBKCZbS/ZThckszsUmsad/+9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794607914;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=QI4PfEEuomKrYd7toNWidgHaD3LKxtzKYIUbf7STcAU=;
	b=EYvBTj7fRRrV+na+y7ATNQH8ET183ao7cgDioIVRX+H2xkXh4P4tcjcjRPw5newTcNZr
	 8r276xaXdL13MDUTYi+onAjL56vC258IvqgOJRuylIyKhUm1rU0jYdKndxotNecEGw7UZ
	 iYxX9OkOkoa5EOfNOqzrUq9Q50c5A1bonfVriUNefD2oYOzTTojLFHf5sSqB1SedIQBqP
	 4pNKiTL1ACE/A0Gs4Mf1Kruk82pyt1k2uSuuoLO/o9EYc7JnkPjYKLGJP/1ImQdJyx5pO
	 bTnCrwCdzKiFN1p9prRCQlPnvVazICrMywr6YyqscO1HBcz47Zmwm6oQBMwwQF/6gNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJqX7Uou;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ED0606A330
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 22:11:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81ED0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJqX7Uou
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3712b6d9843so1383842eec.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2026 14:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794607914; x=1795212714; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QI4PfEEuomKrYd7toNWidgHaD3LKxtzKYIUbf7STcAU=;
        b=WJqX7UouFMqnykMIA/CkBNUkWlfYTCYexDZMbR4nOPtxxEqE/wPuUz6pCAb4HIeyr1
         ogMx2b+0DiIjSI4du+Trjfj+szPOtnM9lAOglySl++rgkgZ2vln7NvQ0ZLSXSYp682vZ
         AtnndKwsd/j8iGasL11/rytphbpc/BDVX9Ppbo39DBFUJz4p6DfiBQQffxsootUGhulo
         S9MAFHpcbkSAwYZkVKbmyWAppuFt+F//6UMS6Izuq0Lum3q4AcxCBIaVjtfrYzqMAk8t
         gOCFW7VjfAVEx3mIWdCS4MAK7omU4J7DE5dEnQGBMBdEK8SUuRQNAw9vKTRvMBRHtJu5
         oIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794607914; x=1795212714;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QI4PfEEuomKrYd7toNWidgHaD3LKxtzKYIUbf7STcAU=;
        b=NkIABO9LG98aAm1SrnwI0u9MA1qkZsYG4KgyVpw+7BA0S+Xez22xa80+nv7ydKzf/N
         OwB+PEjUTAamZkI5Bol+B23QGQVFcYBTjvgKbpI4bG+CGgZzeHoZMdnXw/TKj1d5/LAN
         SzQXUZTcwGm1rO/Xv2JqeMjqojtOC76OzaWlwOtCKMKcfjGhrJe+ZU1BJnDMw47/6e3K
         WYT9bw5pijbxxvDZ0+n/kqCPGO1anaHBBHcwoKwEgRFwJYh+GTK4j16G+ePhswMl6LKk
         wKp6N83i3AzayV13s5GDOfth+JJgd3YQsavG8sB+oUAwC7GYiiJPCEmNoQz/kBIZ/ggX
         kCEQ==
X-Gm-Message-State: APuU4Z+5RQOiej4De/ZB0LP9n830LSvwqjsWuG4PwtqpIVqGuW0Q9Ce/
	xjaVnwrNHkHMp70Bd4GOq+JovQfxf4ObdkKwVjyY3BswXaw6Su2EGXCav6ZHrQ==
X-Gm-Gg: AYBFou2p/bYLr/8BLyC5h4EsJtCZEsBMdX7UWgJj/o8QIXC+ZK2DNEvNT1EtTnGVjKt
	CJ6Gwy4c1ibH6zjnv41fcMs5NyIrX3zhsZ056rPghSWfraes4yVrDKRn3WAanWykB50hFsmJxhO
	0JM08YhtsDDBcPa8uyR8TK/9LkKx4mqV7YLsu/I1Lga+NOmQcdtYeTx90XEAVHgT2FloD7bUlHt
	bE+P+nLFz3H1LKkwDxEwvtnKeFy/hszLKU22t/odUAOBDsbWdWDj/Lm+ResanT8LiSFoFJT8BCL
	Gu436pED/YBQ1Daqh85L4kBInPvCHLzzDh911A22Pdrh+5n6ntcSNSudtfBO/m/M/Bgr/qVBny8
	Lk4w6jAbC7/2L0G7UKRYmY4BZqA2i9811c+9fNjU3G9LaRyApY/eLqb+w+8w/pgsmTZ4OhqUH7o
	DMbXmFzP0Mp/nleROA3uroZ9+jAI+4TeKAA0e7KiOo/zOzzB94wjKJIegQJVdcOp0WGTmymZ13+
	72TLRibPXBELzkQRc+KLq9ceWU1AQAZPG4bC/N8tmzND3igTZPGVQJtkjqykIc2NLihCEslL4hV
	hsGqvMS7X2epZn44JG3DCkL84MF9oXx7Zlg=
X-Received: by 2002:a05:693c:895c:10b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-37963a4f1femr3373176eec.5.1794607913451;
        Fri, 13 Nov 2026 14:11:53 -0800 (PST)
Received: from [127.0.0.1] ([172.184.174.120])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm10117263eec.3.2026.11.13.14.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 14:11:52 -0800 (PST)
Message-Id: <pull.2314.git.1794607911.gitgitgadget@gmail.com>
From: "Adithya Chakilam via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Nov 2026 22:11:49 +0000
Subject: [PATCH 0/2] repack: write filtered-out objects as loose objects
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Martin Fick <mfick@nvidia.com>,
    Christian Couder <christian.couder@gmail.com>,
    Adithya Chakilam <achakilam@nvidia.com>

Some key-value object stores manage and retrieve Git objects individually.
The existing --filter-to option writes filtered-out objects into packs, so
using it with such stores requires unpacking the resulting packs before
importing the objects.

This series adds --filter-to-loose=dir to git repack, allowing filtered-out
objects to be written directly as loose objects into another object
directory.

With --filter-to-loose, repack streams the filtered pack into
unpack-objects, avoiding that extra step and the intermediate pack file. For
example:

git repack -a --filter=blob=1m --filter-to-loose=/path/to/objects

The destination is treated as a Git object directory.

The first patch adds the option for objects already stored in packs. The
second extends it to include loose objects excluded by the filter, so the
destination also receives those objects. Objects already present in the
destination are not rewritten. With -d, the source copies of those loose
objects are removed after all objects have been written successfully.

Adithya Chakilam (2):
  repack: add --filter-to-loose to write filtered-out objects as loose
    objects
  repack: also copy loose objects excluded by --filter-to-loose

 Documentation/git-repack.adoc |  14 ++-
 builtin/repack.c              |  32 +++++-
 repack-filtered.c             | 152 ++++++++++++++++++++++++++-
 repack.h                      |  14 +++
 t/t7700-repack.sh             | 189 ++++++++++++++++++++++++++++++++++
 5 files changed, 394 insertions(+), 7 deletions(-)


base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2314%2Fachakilam-nv%2Ffilter-to-loose-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2314/achakilam-nv/filter-to-loose-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2314
-- 
gitgitgadget
