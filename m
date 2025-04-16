Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EEB2080FF
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818140; cv=none; b=D5XrvZ5yz0xisYinndqo46klQIZpPPf16/cMkETPrizQBtLClhMytPDXIym3/cb62dSaCi9cRA4ZecWkqnnkBNO4nydKtAHl9Civ0+MT31nQD9uDIObmJ7GOotVwUkE3ekOXSjbAk0TFBRXT7QQX3TFb7E36lMlzn41oeGPKJxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818140; c=relaxed/simple;
	bh=bM7Yb3jrg44NktJQsxFut7ncAWwkZShasE88GpWV900=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fsqnGLaT+29W0PltummVa1O8vnDg3Jn1uS0f9bOqqgzBRp36cjUJ0mhmpUGnm5vLwVWDF1HtLcE7Fnrig5Xw0zTXuOUUVB9Ux5sIHQ3EZN6aKRO9JtG/O8TwwHeCpk5fRw8FA9VzX/RPe6TDA1U63/SEsd3cisidJ2+qdP/1qIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKVblws8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKVblws8"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2f391864so4204150f8f.3
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744818137; x=1745422937; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ETDol7ZTecKVzOib+zYe62HXO/MrPWpir2telI8JtQ=;
        b=bKVblws8imMg3+T9lLGlR10CRqq6BihfdE0KAvmtR76z8hvfNGU3ObcNZy/T15Qp/Z
         d+QcsXjvK1C1ASLyI08KnVvDiuSuskvRLL4wDBdIH3dNM+MvMSJGaKT03eF46urHJpw+
         x8SaqwhB77dQVzHBJ/QmfYpigOEm/wby8A5BqW+xqOiPfcMZ4gy8bsKAHYz9F6+fyolS
         +zyhSVmJOatToeblD1luaj6o/Py8vL3uyyX0/p90DdJ1+DAGVTbl1GS2ON4CxEpNNIBT
         3X9UGkfJVEFGlSI9DC9sQIaXTWV+bfI9iju1P9anG+ZCYpLzg1LUnBy1FZ/za0SNviVe
         sT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744818137; x=1745422937;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ETDol7ZTecKVzOib+zYe62HXO/MrPWpir2telI8JtQ=;
        b=m9nxwtSN0VrcnlUFe2gq5UpFS0GJdIKdYm3uFTWUFKJmpKLnL2ISgQ5movmUNPv0LC
         hhe/rtRSM92EIpOupTA8bvbIXIHzjnastgrdJX1alxlCVo0PmNrQG5YW5YDw+ZWfyk0K
         24YyB2xM7X4hT3TDp1YsFz6cpsiuSwX5qZvrL2epgA5n0KVCSm1YeSmhR2bKTsutrrPI
         Wg9AI8l9UYSTbS0LKztvAyq5b2FiX3rJPbbTK0WmuSFcbLzo8NUj9QL508gVcUvNpAOQ
         cM155huoMsQbW5d0M47giy+tXL3WAiZxA0bQaqW6uA1tP5JgTicAZIIKj/TvWxlLT2hn
         Dlng==
X-Gm-Message-State: AOJu0YxmK90FXWJa91HAOxp5rqMecu2GhiPl02WADctM+8HnTXWbnGfo
	QuhVvqipuYSiiRLKsWQdFYAyjUnWaR/dwKxqZ4aBCLpuwR/TrheWPeZ2ow==
X-Gm-Gg: ASbGnctWJ+spMcTi2sLQquhpevPpKptmhSQGcw2A4Lxocm+UuNQFON/u8oCgm/U/lEG
	vnxxYlRb7xVaflcNaPWbnZLFSpipqXfAourFsUD6TWsn+3/r0GXuepIrVGxJwpRaN9XiLWDObht
	MflFGE9UigttLqDsF2PEBff0XBJam8HA5bgHbE+E5XRUu+3f8RK05D5JvGS6JWwXTcfHz/labBr
	XD4t/qXRPllXfTSfw8A16wBdPg9gdIGN00gQz7cm7KzSBVD+DIgE8acyk3BqCOgIsM+aqq0vHEG
	BiDxExRIDuLRTwjKbhEAm3VfydJI1l7LU/lCfUcp6w==
X-Google-Smtp-Source: AGHT+IFxZqkQlIF9Qy3z7yyly2yx0KX9I2KxBBOWEmEZGo34iPELGMiE3sxVDRaSc2mU/o6PCasoDg==
X-Received: by 2002:a05:6000:2510:b0:39e:cbd2:9ad2 with SMTP id ffacd0b85a97d-39ee5b13b95mr1926517f8f.4.1744818136797;
        Wed, 16 Apr 2025 08:42:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4f2cfesm24553795e9.19.2025.04.16.08.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 08:42:16 -0700 (PDT)
Message-Id: <pull.1899.v2.git.1744818135435.gitgitgadget@gmail.com>
In-Reply-To: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 16 Apr 2025 15:42:15 +0000
Subject: [PATCH v2] docs: document core.hooksPath=/dev/null
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
Cc: gitster@pobox.com,
    james@jamesliu.io,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

If a user wishes to disable hooks, then they can do so using the
established pattern of setting 'core.hooksPath' to /dev/null. This is
already tested in t1350-config-hooks-path.sh, but has not previously
been visible in the documentation.

Update the documentation to include this as an option.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    docs: document core.hooksPath=/dev/null
    
    Based on the discussion of the proposed --no-hooks option in v1, that
    code change is dropped in favor of this documentation of
    core.hooksPath=/dev/null.
    
    Thanks,
    
     * Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1899%2Fderrickstolee%2Fno-hooks-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1899/derrickstolee/no-hooks-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1899

Range-diff vs v1:

 1:  91e82850e7d < -:  ----------- git: add --no-hooks global option
 -:  ----------- > 1:  a9cd4bd5100 docs: document core.hooksPath=/dev/null


 Documentation/config/core.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 8f6d8e77541..9fde1ab63a7 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -512,6 +512,11 @@ centrally configure your Git hooks instead of configuring them on a
 per-repository basis, or as a more flexible and centralized
 alternative to having an `init.templateDir` where you've changed
 default hooks.
++
+You can also disable all hooks entirely by setting `core.hooksPath`
+to `/dev/null`. This is usually only advisable for expert users and
+on a per-command basis using configuration parameters of the form
+`git -c core.hooksPath=/dev/null ...`.
 
 core.editor::
 	Commands such as `commit` and `tag` that let you edit

base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
-- 
gitgitgadget
