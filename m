Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4E27FB2D
	for <git@vger.kernel.org>; Fri, 16 May 2025 18:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421742; cv=none; b=s9Mi1QHBWUsHtuGfFqTZji1yeItPJ3iWCXLGgqdgReICfcGoTESFljkpZIiAPkpw618R5ivdUEbHfglFn3amJmGUQKXEVuw0Ehav5rq9fgtXnQZ2gtowf5F+uj1pY9iDvgC5+IK8P5/DbHFGHfVuvIlZJLCotlSH911jH9U6zk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421742; c=relaxed/simple;
	bh=f1hSBblepr3xZTVhTzZETBs5w0naOrcBEMZjemUm4v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aS9lCuGBr/nB/bbsJtYZp7nfg+7TKCFZJoXRLEBIOE7wLBwFnpT9O7dVQ3DPcPmN94qA4BbAV6sVo1h5PsxHjVrFL9L75CxGF2PgTB5BU58jo1X2H5+HG3OgNb/6g1dvedSSai1f3uh0FISF5vEQPEQaOp8t854cAPX0rFusaAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCND+gqm; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCND+gqm"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3081f72c271so2253435a91.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747421740; x=1748026540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8helakiDSg1Sv8E94p62ZxeGT9Mgil2Y7E7gLldr0SQ=;
        b=CCND+gqmoDZr4HjPPZjH4ZkoTchRhGQNps0usFby9S/4WzD87zlVTLgQtkzTyWQI1f
         ZmhwqbGzxJEsI9Yw+p2z55dm2DMrmHfheWJ/XMb4oQbdevuhA+0g79g0ZHoD/qv3GX/4
         NGsZyaGDbEkdlHuPi8OkSfk5GGEirDo4T6TVHWvm0dBXYyDQWZ7AG1iW530nilmmj+lP
         WNm86RHgVV8eVbW99dkQajYiIJqdXnUJVGXgcAJhfgdL7AjGLtS/QjgEWnmceyuDf0Kd
         6JDCxJxQr+bCfzxxyf9Lhp6kYpoc/rpgdNRXkyYrc8jFlg6YBtyUEnVS3S0MHus1WS79
         T+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747421740; x=1748026540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8helakiDSg1Sv8E94p62ZxeGT9Mgil2Y7E7gLldr0SQ=;
        b=pa1X+svi8s8TM5mS4Mp/j5mL9crgD79STcA+JJLEb6o8JJYT6XDIcDfHTZe5gbGtK0
         SSm9p8Ha3z65S+oyQxfGjWMnMmo7dECR8TAdo0y4c5G5s36nwU3xrOxVgz6maGT9xrti
         yGh7Vkhf+MhPibvzkvfGEW5BdOeb2y++LchkxY0pvk6NL3Krvh/yIXJgBv4jYr/0Gs91
         9bi2j/cPMPhnibFXbqdtmspgpkF7QXQIBu40p5Bkbwc0YEiS3kY2IylKr4omMDbNn4Cw
         dzsCwlcXX0nq0MWh4DYd7LXXYdT1/CL3uUpkT+/D4byGx4SIb++SDdIU+hNUrNLKypmd
         7/dw==
X-Gm-Message-State: AOJu0YyrbPXy8riYtjhN8CEEGfQ1dzLUdtMya9dD52pHCu4HD0yvKx1n
	FxkRjZd1gNsp6gJY79qNJsDExqaP2aW1TFIVFHOteh4nfM2u9aSxoZN5
X-Gm-Gg: ASbGncsSFNJpHI9bcSa41liFvwuTnwCylQJtfLbIm9oIIHj6bIKvV5XuZv2aYolY3AD
	ahi8BtyWwnO2ldBpTTrfaksyxrbaCQwyp6tR3avnRtlh0YWaeLmdOIGTcQvGvCElThCMfmoldId
	zSSmyJAm5LGOBs3J/u0Qqro5k6mqCxZ3ZhMaZqBoxOcaf6C7+NxnZiYGjEhNvpa4yyjhC+W7sMz
	NVZMN/rlJoovBWATxSyHLzoI27Q4wr7iqm3Ya5MAHezHi9r6P927A+3gfqKfH6lYxZ9SztWDTZF
	cV6yj8JUmZborqxRsl7+lqib3y8jIRStG34UkgJxoxceFVYjko3Pt333PsD3ke3q9qw=
X-Google-Smtp-Source: AGHT+IEGBdP03c6yUjyKLcmY7FcNA89D50S5P/KT5frmFZ/GAP7hvPGmpNfJyMoi6gGqIz64pLqHhg==
X-Received: by 2002:a17:90b:3d85:b0:2f9:d9fe:e72e with SMTP id 98e67ed59e1d1-30e8312dcd2mr6776494a91.16.1747421740321;
        Fri, 16 May 2025 11:55:40 -0700 (PDT)
Received: from fedora.. ([2409:40f0:41:81bb:63e2:a167:6132:4460])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e3343a11csm5591224a91.20.2025.05.16.11.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:55:40 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: nasamuffin@google.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	jayatheerthkulkarni2005@gmail.com
Subject: [PATCH v2 3/3] docs: replace git_config to repo_config
Date: Sat, 17 May 2025 00:25:16 +0530
Message-ID: <20250516185516.52311-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>
References: <aCeAIqwvEVOdrsMg@google.com>
 <20250516185516.52311-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the example in cmd_psuh to use repo_config and
repo_config_get_string_tmp instead of the global git_config functions.

While git_config() accesses global configuration via the_repository,
using repo_config() makes use of the repo parameter passed to built-in commands.
This is the preferred pattern in the Git codebase,
as it respects repository-specific configuration (e.g., .git/config)
and avoids relying on global state.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index f4320d8869..8c2ca5c092 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -314,7 +314,8 @@ on the command line, including the name of our command. (If `prefix` is empty
 for you, try `cd Documentation/ && ../bin-wrappers/git psuh`). That's not so
 helpful. So what other context can we get?
 
-Add a line to `#include "config.h"`. Then, add the following bits to the
+Add a line to `#include "config.h"` and `#include "repository.h"`.
+Then, add the following bits to the function body:
 function body:
 
 ----
@@ -322,18 +323,18 @@ function body:
 
 ...
 
-	git_config(git_default_config, NULL);
-	if (git_config_get_string_tmp("user.name", &cfg_name) > 0)
+	repo_config(repo, git_default_config, NULL);
+	if (repo_config_get_string_tmp(repo, "user.name", &cfg_name))
 		printf(_("No name is found in config\n"));
 	else
 		printf(_("Your name: %s\n"), cfg_name);
 ----
 
-`git_config()` will grab the configuration from config files known to Git and
-apply standard precedence rules. `git_config_get_string_tmp()` will look up
+`repo_config()` will grab the configuration from config files known to Git and
+apply standard precedence rules. `repo_config_get_string_tmp()` will look up
 a specific key ("user.name") and give you the value. There are a number of
 single-key lookup functions like this one; you can see them all (and more info
-about how to use `git_config()`) in `Documentation/technical/api-config.adoc`.
+about how to use `repo_config()`) in `Documentation/technical/api-config.adoc`.
 
 You should see that the name printed matches the one you see when you run:
 
@@ -366,7 +367,7 @@ status_init_config(&s, git_status_config);
 ----
 
 But as we drill down, we can find that `status_init_config()` wraps a call
-to `git_config()`. Let's modify the code we wrote in the previous commit.
+to `repo_config()`. Let's modify the code we wrote in the previous commit.
 
 Be sure to include the header to allow you to use `struct wt_status`:
 
@@ -382,8 +383,8 @@ prepare it, and print its contents:
 
 ...
 
-	wt_status_prepare(the_repository, &status);
-	git_config(git_default_config, &status);
+	wt_status_prepare(repo, &status);
+	repo_config(repo, git_default_config, &status);
 
 ...
 
-- 
2.49.GIT

