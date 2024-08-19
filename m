Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F87F142900
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066950; cv=none; b=omARjuraJbHOPZlT7I7O/q93WT95QhLS/FqS7lIGns2Fx4Vht4hkENLfzgK1XsZ3jeFK6kdoix0b++L8rTGatuBvsnI4ax+q48CkRcJ/fG3aMFq9SwpJQEMmxEPE+zFPGUcVNqZuqahyp9MVznKBLJFuswgoymXc4hy936dIV8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066950; c=relaxed/simple;
	bh=TuuS5YhKf81OKD9+NSrVRRDEQ8gis0ibjcIA3kdWoSg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Do/ebEGxrkw9QG2XdDJOYybgkdPZrQOj23SPxikCVNfLoY/y+al06kL5PzR19ynMQq2bsxPOvBgf91YbgrWyBjgMKMKEafRH0nMBCTne3s9vvWpB+Fa6wr8njc3vWMH3+wDcAKIrIo6l+tQ3FhVpPZhHxGby/v+1kS3ZbpRQi7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLM31Sze; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLM31Sze"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a728f74c23dso549956066b.1
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 04:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724066946; x=1724671746; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmKYWxatjLLicy33ba34ub+8gL36lohiwuJZqaecq2Q=;
        b=cLM31Szeh0AKePuWfEm5gs5rXq8BMdBC2vxoVvsVcqfjxuMYT1B2YhrULURvv2cMCm
         uaDMxJQwA0gE3e9NFys/RNfIPUkrGp9lbFBFjK6VAnfy7Tcs3pjOFGeHmFiMKqOUEGgP
         ceAJaoPG542u4+/qAevls9W7Tx0oI4UfteVxhfMWa10xwNk3pJpmxkvvVuqBIBxPNKdW
         /oc2Xe8r9n+IfaKICRn09nQIjZ7cTyF0YCUlLLjVySgA4chBPV8/Wety230VoPaY5aXW
         g1TTx4wyh6jfmBzs/dfCV0r+1KzXpyZxTa9PIO6urHHPOxUQwxx30WYMrYP/6LQrkZDo
         NU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724066946; x=1724671746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmKYWxatjLLicy33ba34ub+8gL36lohiwuJZqaecq2Q=;
        b=aXieYebR3a/7+D3LwxpMZ4e66ARbIbqMe831F+aneo9leWcGgopefyQyMvkTo98RsD
         NcjQ1Nt7137altVni3MkxM7Mivj94ItZgeiDBnA1ISAs4+5nzl+SaET7Q7qhub9kMlB8
         uH/CjawFEdWty4jWF2lAm52u5P+F1v5+PXt2QLaub9LzBMIXWzRbNSkt89YM0bqAQ4Os
         wIbz2tvxzsZmFuZglQ+TqwZFfygkhZGeQE+mbLDSMQckfz53NAe93I0TZPHxWwBX6M7O
         av6/xqW+W9I3sv9TK0kfA6VbOMJ/+/o7ZlaBGL/l3NBD9ZZxMrrNnYyxEOpBu0quXQKN
         YZ7A==
X-Gm-Message-State: AOJu0YxwWkbne46+5eOlJTuZJRmcmn86qw7u1rRfeksGLd2sh4TFRUK2
	bS+hJeQuSHtv0jC93zeYwGT2rn0TSPVCOhbVYRosQVB06umpoELAY8oKrQ==
X-Google-Smtp-Source: AGHT+IHwg+LVAw6dK/uK+lbEWHehA5oHbDkxj7fb0El4pjsieIgAWqPqO0kWNgR/Y972+IX5LC/mYw==
X-Received: by 2002:a17:907:f193:b0:a80:f893:51bb with SMTP id a640c23a62f3a-a8392a4c515mr715592166b.68.1724066946031;
        Mon, 19 Aug 2024 04:29:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cefe0sm621403766b.47.2024.08.19.04.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 04:29:05 -0700 (PDT)
Message-Id: <pull.1773.git.1724066944786.gitgitgadget@gmail.com>
From: "ToBoMi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 19 Aug 2024 11:29:04 +0000
Subject: [PATCH] git gui: add directly calling merge tool from gitconfig
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
Cc: ToBoMi <tobias.boesch@miele.com>,
    deboeto <tobias.boesch@miele.com>

From: deboeto <tobias.boesch@miele.com>

* git Gui can open a merge tool when conflicts are
    detected. The merge tools that are allowed to
    call have to be hard coded into git Gui
    althgough there are configuration options for
    merge tools git in the git config. Git calls
    the configured merge tools directly from the
    config while git Gui doesn't.
* git Gui can now call the tool configured in the
    gitconfig directly.
* Can be enabled through setting
    gui.mergeToolFromConfig
* Disabled by default, since option is most likely
    never set
* bc3 and vscode tested

Signed-off-by: deboeto <tobias.boesch@miele.com>
---
    git gui: add directly calling merge tool from gitconfig

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1773%2FToBoMi%2Fadd_merge_tool_from_config_file-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1773/ToBoMi/add_merge_tool_from_config_file-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1773

 Documentation/config/gui.txt |  4 ++++
 git-gui/lib/mergetool.tcl    | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/gui.txt b/Documentation/config/gui.txt
index 171be774d24..e63d0b46e7c 100644
--- a/Documentation/config/gui.txt
+++ b/Documentation/config/gui.txt
@@ -55,3 +55,7 @@ gui.blamehistoryctx::
 	linkgit:gitk[1] for the selected commit, when the `Show History
 	Context` menu item is invoked from 'git gui blame'. If this
 	variable is set to zero, the whole history is shown.
+
+gui.mergeToolFromConfig::
+	If true, allow to call the merge tool configured in gitconfig
+	in git gui directly.
\ No newline at end of file
diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index e688b016ef6..fbd0889612a 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -272,8 +272,15 @@ proc merge_resolve_tool2 {} {
 		}
 	}
 	default {
-		error_popup [mc "Unsupported merge tool '%s'" $tool]
-		return
+		if {[is_config_true gui.mergetoolfromconfig]} {
+			set path [get_config mergetool.$tool.path]
+			set cmdline_config [get_config mergetool.$tool.cmd]
+			set cmdline_substituted [subst -nobackslashes -nocommands $cmdline_config]
+			set cmdline [lreplace $cmdline_substituted 0 0 $path]
+		} else {
+			error_popup [mc "Unsupported merge tool '%s'" $tool]
+			return
+		}
 	}
 	}
 

base-commit: b9849e4f7631d80f146d159bf7b60263b3205632
-- 
gitgitgadget
