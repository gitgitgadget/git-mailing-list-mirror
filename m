Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988C1990B7
	for <git@vger.kernel.org>; Sun, 25 May 2025 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748204840; cv=none; b=OHIXxj5pl8Lp8LBIO6UtcSmJMkCttDcI8ZUcz8/zegB6ymur3JglASkkMHL3SmAWf9gaDwjMlzLdYsBrAVhDIz7mKNxY5I58J9WYU+f+PmLOwFXvPgPzauLLXOupKAix1pk+N1dOVwHphTaS7IJf27d3/M7eDhXSaubUk66uaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748204840; c=relaxed/simple;
	bh=pHtoRzycBVOBasIDOMPe65Ckk4dTOu63rrfWB+85LVI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=XDoH0kuMrumdzunWMO/Uo98ZH2UyG8QIWHBLsUuYCOb3IWIR/4+5O/KMoY5mguBtTuKMba+iLtNvh8jqmO5/ddmjvo5ma2WdwEIQfmLtjD62F53DxIVLkF7c+yfHDdLi6x1S21nP9oE/i/XxwKvRhG12y7VooH0FqAX+wTUgOhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH0w5/2+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH0w5/2+"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a3798794d3so1684866f8f.1
        for <git@vger.kernel.org>; Sun, 25 May 2025 13:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748204837; x=1748809637; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRoWlTIpRr3ppPRHsQDTXR34ZVN2UoBBMKuKXuwjLXM=;
        b=iH0w5/2+sQE5DU1JntulGC2I3QqW+9N6NSQZAcoi7tuutElJI3b5+1X+Ma9nvqxlXA
         WsndUHdPgqCMEjxAPRhWnHYyZV6tEWPAA+3i9zMEjcmL+4kBvDrWaLQNspf3ogHm3Xmw
         RWzMK42PMpn1GOoK4iEgTKhMll8kncA4B4TX2eeGyKn0cLddMcjW+GRbdVivGH1tTP+l
         tlFRtYDiQeM7Ju0JqMzrIF9EZ/zLFWa2mCRQll7wFCFEo/41K3d5ojaSwl3d4Q+Q+ihn
         K4S3Z4VRWsKe1mrd9MAUnpy7hYij6QCc2YMMKs0HkR9TT1sjsFV5T/89g5OnMJm9+mJX
         aGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748204837; x=1748809637;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRoWlTIpRr3ppPRHsQDTXR34ZVN2UoBBMKuKXuwjLXM=;
        b=myZRCehUBoZaPoRJjVK+p85Cof4gvu//QZW5fRtvHDsU1wQdRZviTvOTSa+HUewV+p
         p0cNAd3HWuHJoKyeq3wo3k9QPYMe0ApQYphceO7F31tH8HWcbOUNcTNHow6clWBGB1XW
         w1azDoruquuaTA8T0MfgLevxmOfdENyxf3SVjzBS12fuAiigBRiwfg6C97PXyTeQYDaW
         mUn6NcPrxbBspHbl/6noDnt+tcglXJ7mRoglc8A2MZTFOuwcGWPvt3oJaZRw1kg7/NOM
         wpIbrZ2FgYVdU+n3R1EaBSaI6v35XFTDAFIUJC/IE80245GTKR6pdzHykS1nS/8U0pjk
         qbEg==
X-Gm-Message-State: AOJu0YwVVCLZ7KFGRIQhM0IKnJzn9K3s287waDGl3Yq8e77rU4PvXTCR
	aom6gtQuAkxDbQI9vGTm5WPsH5eTltRw2JpqDycbAx4977hpoWICAd9jNX4LXg==
X-Gm-Gg: ASbGncvqsiufCUzE8KSiCZ1wMtT44Y9JWvqa6mHjRiL4P59hEnQm9WWN0UYBV/Sn1jD
	vB+X/WOIXCreF9G/SRv/g4d8KJN7oghYyYxLRjaB/uLe9Kuhm5yGTveNS3JppfrRwBwZXDOHZua
	lYxeTbo8XS8v2/Pg16f94eI4xuWzndlXB/BTfkQ00oXui9+hzYcxHRFBi1rPEPmLll5sce1v89a
	522CZgD99JqZJs03YH1hzYt4yfQdoSAbMIX6iw++VuQ0vmSJt/hPpLqGC7ETVWgAlFtcQOpToGn
	E8DBiNeApQ85gqpr7/Ihc4BSF8ceCTHzdvLvvRTfdtttoESVjNLA
X-Google-Smtp-Source: AGHT+IFAYyo2jFEKxW1oYD+14WTKUDo1SizZs4KddeDA1i1cHYMCyVCMsvbKa5gNQ94G8twx2CGrkQ==
X-Received: by 2002:a5d:64cd:0:b0:3a1:fcd6:1e6b with SMTP id ffacd0b85a97d-3a4cb4c622emr6211117f8f.57.1748204836560;
        Sun, 25 May 2025 13:27:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d1d2f788sm3603730f8f.65.2025.05.25.13.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 13:27:16 -0700 (PDT)
Message-Id: <2e3200c0f6f35c3de777c8ccf72a54b8da62dada.1748204829.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
References: <pull.1927.git.1748204829.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 May 2025 20:27:07 +0000
Subject: [PATCH 7/9] doc: convert git-mergetool manpage to new synopsis style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-mergetool.adoc | 62 ++++++++++++++++----------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-mergetool.adoc b/Documentation/git-mergetool.adoc
index 046c3258f050..77d0b5055057 100644
--- a/Documentation/git-mergetool.adoc
+++ b/Documentation/git-mergetool.adoc
@@ -7,95 +7,95 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 
 SYNOPSIS
 --------
-[verse]
-'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
+[synopsis]
+git mergetool [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
 
 DESCRIPTION
 -----------
 
 Use `git mergetool` to run one of several merge utilities to resolve
-merge conflicts.  It is typically run after 'git merge'.
+merge conflicts.  It is typically run after `git merge`.
 
 If one or more <file> parameters are given, the merge tool program will
 be run to resolve differences in each file (skipping those without
 conflicts).  Specifying a directory will include all unresolved files in
-that path.  If no <file> names are specified, 'git mergetool' will run
+that path.  If no _<file>_ names are specified, `git mergetool` will run
 the merge tool program on every file with merge conflicts.
 
 OPTIONS
 -------
--t <tool>::
---tool=<tool>::
-	Use the merge resolution program specified by <tool>.
-	Valid values include emerge, gvimdiff, kdiff3,
-	meld, vimdiff, and tortoisemerge. Run `git mergetool --tool-help`
-	for the list of valid <tool> settings.
+`-t <tool>`::
+`--tool=<tool>`::
+	Use the merge resolution program specified by _<tool>_.
+	Valid values include `emerge`, `gvimdiff`, `kdiff3`,
+	`meld`, `vimdiff`, and `tortoisemerge`. Run `git mergetool --tool-help`
+	for the list of valid _<tool>_ settings.
 +
-If a merge resolution program is not specified, 'git mergetool'
+If a merge resolution program is not specified, `git mergetool`
 will use the configuration variable `merge.tool`.  If the
-configuration variable `merge.tool` is not set, 'git mergetool'
+configuration variable `merge.tool` is not set, `git mergetool`
 will pick a suitable default.
 +
 You can explicitly provide a full path to the tool by setting the
 configuration variable `mergetool.<tool>.path`. For example, you
 can configure the absolute path to kdiff3 by setting
-`mergetool.kdiff3.path`. Otherwise, 'git mergetool' assumes the
-tool is available in PATH.
+`mergetool.kdiff3.path`. Otherwise, `git mergetool` assumes the
+tool is available in `$PATH`.
 +
 Instead of running one of the known merge tool programs,
-'git mergetool' can be customized to run an alternative program
+`git mergetool` can be customized to run an alternative program
 by specifying the command line to invoke in a configuration
 variable `mergetool.<tool>.cmd`.
 +
-When 'git mergetool' is invoked with this tool (either through the
+When `git mergetool` is invoked with this tool (either through the
 `-t` or `--tool` option or the `merge.tool` configuration
-variable), the configured command line will be invoked with `$BASE`
+variable), the configured command line will be invoked with `BASE`
 set to the name of a temporary file containing the common base for
-the merge, if available; `$LOCAL` set to the name of a temporary
+the merge, if available; `LOCAL` set to the name of a temporary
 file containing the contents of the file on the current branch;
-`$REMOTE` set to the name of a temporary file containing the
-contents of the file to be merged, and `$MERGED` set to the name
+`REMOTE` set to the name of a temporary file containing the
+contents of the file to be merged, and `MERGED` set to the name
 of the file to which the merge tool should write the result of the
 merge resolution.
 +
 If the custom merge tool correctly indicates the success of a
 merge resolution with its exit code, then the configuration
 variable `mergetool.<tool>.trustExitCode` can be set to `true`.
-Otherwise, 'git mergetool' will prompt the user to indicate the
+Otherwise, `git mergetool` will prompt the user to indicate the
 success of the resolution after the custom tool has exited.
 
---tool-help::
+`--tool-help`::
 	Print a list of merge tools that may be used with `--tool`.
 
--y::
---no-prompt::
+`-y`::
+`--no-prompt`::
 	Don't prompt before each invocation of the merge resolution
 	program.
 	This is the default if the merge resolution program is
 	explicitly specified with the `--tool` option or with the
 	`merge.tool` configuration variable.
 
---prompt::
+`--prompt`::
 	Prompt before each invocation of the merge resolution program
 	to give the user a chance to skip the path.
 
--g::
---gui::
-	When 'git-mergetool' is invoked with the `-g` or `--gui` option,
+`-g`::
+`--gui`::
+	When `git-mergetool` is invoked with the `-g` or `--gui` option,
 	the default merge tool will be read from the configured
 	`merge.guitool` variable instead of `merge.tool`. If
 	`merge.guitool` is not set, we will fallback to the tool
 	configured under `merge.tool`. This may be autoselected using
 	the configuration variable `mergetool.guiDefault`.
 
---no-gui::
+`--no-gui`::
 	This overrides a previous `-g` or `--gui` setting or
 	`mergetool.guiDefault` configuration and reads the default merge
 	tool from the configured `merge.tool` variable.
 
--O<orderfile>::
+`-O<orderfile>`::
 	Process files in the order specified in the
-	<orderfile>, which has one shell glob pattern per line.
+	_<orderfile>_, which has one shell glob pattern per line.
 	This overrides the `diff.orderFile` configuration variable
 	(see linkgit:git-config[1]).  To cancel `diff.orderFile`,
 	use `-O/dev/null`.
-- 
gitgitgadget

