Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745672F39B9
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781497529; cv=none; b=LmeW1QLUM0LrlkSqFQE5oUdag6v1Q7xDkuhyuNvZk6eRFXZI4FJ+mJ3QJR/Wt9O9/fDDjGKtO8qcUTLZ6odCIXNQuk9esE2p7L8ZrxxSZdk+F/kFwuPTbfrRTsJxaYaTj8T3NlGyK+ZxOTJSYl2mhKzLOu3Ub+Lxp21HGhjj8KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781497529; c=relaxed/simple;
	bh=gwJYjpYyXo2Fk+R0urtcZvUpzroFM1QuDOnqzpGPBDo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=UvZ3y7x35rRnpGGwK7Vw78JdzzDtGEHecCY36qBzorvqO36nR8oWKxlhTSg4Hc37CsrlnzQujgRTGwXWU1XNpcrdycjnxBhzuBXVvc5ifQHETWddU109f0ISk/xbC3UyMKETjGHHQfjMZ806ELncULJPrkwC1OgN6v+9Zf1s+Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8HX91Ap; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8HX91Ap"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304fb780deaso2949760eec.1
        for <git@vger.kernel.org>; Sun, 14 Jun 2026 21:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781497527; x=1782102327; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CcaDW/WfsQ/3g4OnK5hK2/9KtAij47pRdhevGlZkGu4=;
        b=r8HX91ApFSdbLHGA2ahD6eF9eozRf9EjunFKWHPfU2W/PjKe/2mmR60xLZBoj0ah4d
         PaiiCKQwA1aWaELMGOYWRsAnlH+zcDs5hXjctqPkwdspEwEiLZrjKozWH5xyveB78JeX
         LEN/vZmp5HuIWa6K6iToYMJTpgZFTuX4GIHqCwamsmqtvWIjnBW8sSodaqF0L72Mian4
         iUvACjhGPx76keejvzB6NUDieCM7Bxr2xXp8BW94N3kElAABgltJzDZSxaxnS+FLHlhv
         GEnEYs/HTDNdkeq9Dgl2kcsnkLt31VRazcsqKOS+uuhXP+oAjOXpt2GM85n36pXeOGX0
         GMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781497527; x=1782102327;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcaDW/WfsQ/3g4OnK5hK2/9KtAij47pRdhevGlZkGu4=;
        b=d858GAJBYscq7/bGjjbwzrrmiJ4jkgZgmh6beLGGpMJaBdUxK88vPS5kSTjQKImNgR
         Wkk70zLm2hZ0a+e+ClYHcOyGGXxO4j36Rkt6XxkKUKX7IGCfKhdrHwyaevqLiedSTWVJ
         7tpy7f7VFQxRF+6nwixR8Jixf+YwtqDSHGN/Ii9CUrDfu/hpT0h29fBaX0oww2aHPFr6
         GW4XC07lba7qn9oqXHiHWk/jEXgRoLahFh3MBR422NN9ie2MnoZknfY/pWpPTA5HSlLC
         df/QAs0aRojQI9Yho8zjcsGolV8wkroA/c+IQ9FP7WNDYpEhdvF2vWDUQE3iuRoHEW7D
         Tp5w==
X-Gm-Message-State: AOJu0YxOspgBaXQ01JuS/Xir2/1/dMYMRez6rrg6NVRPlxsSHMIlv7gU
	CG54hQUcMNscDul3zeQg4hResPpDbMknZ2WBPQnn2DM2Nsuye5Z3twomWO2eXg==
X-Gm-Gg: Acq92OGZr00Lws16W7HUpuNrCqaujqWmWIHubWk3KqZEeiQ64NDVbLPgzDr8Uh3YAsC
	arWgO9KHbB/FCGKIxO+ta+j/QksA4SbuoUCuHfG0lZ5osUBufG/YZNooTr46eqpPuvNvqd9WZd4
	31Nv/V1inqWiXzXIis3Pl/JgyhvtfymwV0vqN+J1khDJqzyFPZbE+bWAugw+qVCjG2rw6NeOGkD
	5ZtPR+qA8KT4lCoAUDgUBovr2rSXnrhvypMHJAUIvPH1DljTkrhJ4893E6bScz7e0lhwXEefYOf
	/Vq4LNtgPjFYlBtS3hgM1Kowfxj8AfY1yW2C7j8pxXE87LZcu02WAK0lhvGIYiS+vo7lInG8Dyl
	Fmj2nsiku/TC5LXz4MrBWV1Z7jx/RKiZHrzBrKu1p004/7P95d2vYaY25Qx5eXFt8JTA+YKu24H
	LPJszBubEogbagpxwmOc2Z/UwxXQ==
X-Received: by 2002:a05:7300:cd93:b0:304:db3a:3919 with SMTP id 5a478bee46e88-3081ff4b664mr6334278eec.6.1781497527263;
        Sun, 14 Jun 2026 21:25:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.166.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e489621sm13441377eec.6.2026.06.14.21.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 21:25:26 -0700 (PDT)
Message-Id: <pull.2151.git.1781497525828.gitgitgadget@gmail.com>
From: "Koutian Wu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 04:25:25 +0000
Subject: [PATCH] gitattributes: fix eol attribute for Perl scripts
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
Cc: Koutian Wu <ktwu01@gmail.com>,
    ktwu01 <ktwu01@gmail.com>

From: ktwu01 <ktwu01@gmail.com>

The *.pl pattern currently sets eof=lf, which is not a built-in
attribute used for line-ending normalization.

Use eol=lf instead, matching the neighboring *.perl and *.pm rules, so
Perl scripts are checked out with LF line endings.

Signed-off-by: ktwu01 <ktwu01@gmail.com>
---
    gitattributes: fix eol attribute for Perl scripts

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2151%2Fktwu01%2Fkw%2Ffix-pl-eol-attribute-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2151/ktwu01/kw/fix-pl-eol-attribute-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2151

 .gitattributes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitattributes b/.gitattributes
index 556322be01..26490ad60a 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -2,7 +2,7 @@
 *.[ch] whitespace=indent,trail,space,incomplete diff=cpp
 *.sh whitespace=indent,trail,space,incomplete text eol=lf
 *.perl text eol=lf diff=perl
-*.pl text eof=lf diff=perl
+*.pl text eol=lf diff=perl
 *.pm text eol=lf diff=perl
 *.py text eol=lf diff=python
 *.bat text eol=crlf

base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
-- 
gitgitgadget
