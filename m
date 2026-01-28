Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF162D7398
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595644; cv=none; b=q1Po05kA9Hqj4pr45DAMUchVaoZ7k18RaGsXJM6x1iMlgNhe/Z0l+Qvxq5oiUhLE1LHYedahBCwxzqdhtH4fAfB7eB7sbE57gTMhEAXwTIoiCSkgx3LYbbsU4FizbzmW6yxRWsc57tEhD3Nx+4JVZrIlQcP4H31CeOv9lFBh0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595644; c=relaxed/simple;
	bh=YPx83LdIcDfoHGOCpk5bCmg4JWC/ns8NajM9MoCBEew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=dRz8kv6mfoLcrC2inrkoL1dWegAJ2Hg/HBv4LeTyLl1eRA1zqUGwiCxV0Essfbp/R0hkkAdxm7hmUNrlQQVfh6NPhBpHkav3QObDtGhTQrskykABXiYEu3Bvjq+s6puauYBP1MdCTZTT3dherg8p5Mpgp1U6GDlwicZu/BewwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5qNUY9T; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5qNUY9T"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b704f08e73so432788eec.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 02:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769595642; x=1770200442; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOnfR373jMXqBHsXUCxC0C+5dQU6rO1UaRKWMaKPTdU=;
        b=h5qNUY9Tx2B3zqn64vtPavaKOKtYli025vpNxv8e6Gug9co9ghBNhOLOsfk7XX4sO7
         VBL/H4jp4wyfKmZdQpCMzVEP/p9YHBtTYmt5ikmF5PE6tnwHnJNlTUStpI5wUeu3in8A
         Y4HFVTjz+yPhtvDkXfecvrlM02Ej8rJ1wc6IRcWfv59MiJrloeta3OogSvF4gHgKH5xF
         tENQqL5+USI3Jb4DtBTH2kel+BIMRAk5WuwFlGfX9YiXEsqQJ9Z3Qp4+lKKVX5KdKA91
         BsyL4jPR3gN5yT3aZT0VBn400J86MRlbEdj6FcIuYS2DvfBKqH2PgliWQDIH9H4/K6cJ
         yVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769595642; x=1770200442;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jOnfR373jMXqBHsXUCxC0C+5dQU6rO1UaRKWMaKPTdU=;
        b=ng7+o7XRd1bLtPMf/xSFCXHyjocLLV3e0U7MpIXrhc+2sT6jEVxaNC2or5ja+eUgmk
         BW5aGy6kfUbSf1sxStmrX1wYodJ1ja9FD7eAdUuqLjupvL0EWMfhRflLiiWnjiyDMO0F
         /c3AyPUkYR+IIAQUob1IsyeO5U3gtoNkD/k0QQ7QjIPWPOBSP3NYPrNNoFTpKzME3ThP
         4yF5u6fQttD9WzqnPDluowV2AFUav30AK1KldWQxfNXXDdeYKBxKxtIpmipgr3tRG/ID
         uTXCi0TpiZShUPd3IAUZwr061BMaRm7eGEBRPJieSaNJBZNRgw9jPGfgOWuvMvgD9Cc4
         gMTA==
X-Gm-Message-State: AOJu0Yyohq6v4tPRHGGVTk6MciC1jQzx4/m3B9SOoVdnWC96J0JQsdWU
	Ia2iwA0ZQ+nv8VY+smNNh+YdP3p+UuReyufsIZLo0TSsM9dbtR4BkE2itxt/VQ==
X-Gm-Gg: AZuq6aIRRQ5iYGMs2SFEu2ryM3UAOY5+/9cmgNxAEt2elbRSWO3wnfWISbV/pmjpWHe
	BWvaKqhr7Qba5tF4qi6xl0cuJ3mWRgxf3Ns0gVHpKv1653Duin1pCmIj29Eh9UKVFSXuk3asiua
	0/3hDTQXwjPS0/6/6C22NntPlHtGGe9XN0uSqo6CWXOHiCvJpldvuU6dvdGdLNZCtAIu+vVVgqk
	9sCHaU2TXiQWnF5yCGwVbo87ZChSoaOw5jIWSZT0Lbnm0yu09zZxE4zA4WLXCHZZqXsGevwqge5
	fUv1oiwMjgDfLlY/Jm/rBuIP6xK3PhMUMvHMoG54zKbedpu11Mtshn2api6P4x4FDE5U0UZvOKL
	KhcGbftuZnvRapy6ATbK1/Cfc3IEpm8J/nqZilPdb2uxrtPkX01+H/k/8eZAKkzD6+nRWYGlyuz
	iVltZcoqAvLvGR9Q==
X-Received: by 2002:a05:7300:640e:b0:2af:f2c2:3bdb with SMTP id 5a478bee46e88-2b78e6beec3mr3201507eec.2.1769595641409;
        Wed, 28 Jan 2026 02:20:41 -0800 (PST)
Received: from [127.0.0.1] ([52.190.140.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16d01c4sm2008679eec.2.2026.01.28.02.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:20:40 -0800 (PST)
Message-Id: <pull.2179.v3.git.git.1769595640008.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
References: <pull.2179.v2.git.git.1769545996.gitgitgadget@gmail.com>
From: "Chris Idema via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 28 Jan 2026 10:20:39 +0000
Subject: [PATCH/RFC v3] diff.tcl: made alignment of tabs in git-gui diff
 consistent with gitk
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
Cc: Chris Idema <github_chris_idema@proton.me>,
    Chris Idema <github_chris_idema@proton.me>

From: Chris Idema <github_chris_idema@proton.me>

Tab stop width was not properly rendered in TK regardless of
tab width setting. The + or minus character at start of line made
tabs align incorrectly.

Signed-off-by: Chris Idema <github_chris_idema@proton.me>
---
    diff.tcl: made alignment of tabs in git-gui diff consistent with gitk
    
    cc: Johannes Sixt j6t@kdbg.org

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2179%2FChrisIdema%2Ffix-gitgui-diff-tab-alignment-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2179/ChrisIdema/fix-gitgui-diff-tab-alignment-v3
Pull-Request: https://github.com/git/git/pull/2179

Range-diff vs v2:

 1:  f2a09c15eb < -:  ---------- diff.tcl: fixed alignment of tabs in git-gui diff by using spaces
 2:  e11aa6d811 ! 1:  18d25b90c4 diff.tcl: call "apply_tab_size 1" to fix alignment instead of spaces.
     @@ Metadata
      Author: Chris Idema <github_chris_idema@proton.me>
      
       ## Commit message ##
     -    diff.tcl: call "apply_tab_size 1" to fix alignment instead of spaces.
     +    diff.tcl: made alignment of tabs in git-gui diff consistent with gitk
     +
     +    Tab stop width was not properly rendered in TK regardless of
     +    tab width setting. The + or minus character at start of line made
     +    tabs align incorrectly.
      
          Signed-off-by: Chris Idema <github_chris_idema@proton.me>
      
       ## git-gui/lib/diff.tcl ##
     -@@ git-gui/lib/diff.tcl: proc apply_tab_size {{firsttab {}}} {
     - 	}
     - }
     - 
     --proc expand_tabs {line {startcol -1}} {
     --	# startcol set to -1, because in preview the lines start with a '+', '-', or ' '
     --	global repo_config
     --
     --	set col $startcol
     --	set out ""
     --
     --	foreach char [split $line ""] {
     --		if {$char eq "\t"} {
     --			set spaces [expr {$repo_config(gui.tabsize) - ($col % $repo_config(gui.tabsize))}]
     --			append out [string repeat " " $spaces]
     --			incr col $spaces
     --		} else {
     --			append out $char
     --			incr col
     --		}
     --	}
     --
     --	return $out
     --}
     --
     - proc clear_diff {} {
     - 	global ui_diff current_diff_path current_diff_header
     - 	global ui_index ui_workdir
      @@ git-gui/lib/diff.tcl: proc read_diff {fd conflict_size cont_info} {
       			}
       		}
       		set mark [$ui_diff index "end - 1 line linestart"]
     --		set line [expand_tabs $line]
      +		apply_tab_size 1
     - 		$ui_diff insert end "$line" $tags
     --
     + 		$ui_diff insert end $line $tags
       		if {[string index $line end] eq "\r"} {
       			$ui_diff tag add d_cr {end - 2c}
     - 		}


 git-gui/lib/diff.tcl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 442737ba4f..7da6e5ccae 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -495,6 +495,7 @@ proc read_diff {fd conflict_size cont_info} {
 			}
 		}
 		set mark [$ui_diff index "end - 1 line linestart"]
+		apply_tab_size 1
 		$ui_diff insert end $line $tags
 		if {[string index $line end] eq "\r"} {
 			$ui_diff tag add d_cr {end - 2c}

base-commit: 1faf5b085a171f9ba9a6d7a446e0de16acccb1dc
-- 
gitgitgadget
