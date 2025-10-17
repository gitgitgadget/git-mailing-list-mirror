Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B12550D5
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731563; cv=none; b=D0tvu+DV+fa0QoohbN3jnAosM49crwIAojcvnY5i7EtpB7PZHB7TwJ3BTcOoPStSYa4vswi6HtFD4lHJqFTj/9aH+u/78WM/0ehUvJ4sqIWxfO/xw/QMnm2ZDqR/o6ffbbl1QndAf/Q/HAZM7q3hbgadAreHGE+C9i+oHvj/Hqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731563; c=relaxed/simple;
	bh=RviuygLE20touQDcsPHH6W9lL8n5hwxSn5TJLh9FabM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DEtbB6SYIet0gnR7EOomCoeDvv0JtGQaOPeGaZ18cTN1MvdOUSNXQo/xrlirxT3dfYobMuMvcNhka4Xh3SdDJcVzvP37CqK4QBpdIY1SjPTaDzQQ3mgD6LAN4l5HtJ2EEG8I9NM3sPPsLaoUdNyxUAoKx2hKpSiifJ9uN1T3d6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQbpeIcW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQbpeIcW"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2271024b3a.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 13:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731561; x=1761336361; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6B3o1GcV4NOswYtqv3NoADkIqp/vNxZ9DP8NEa56sZU=;
        b=MQbpeIcWHa5bdWl20/adYCds2wdJZRnAWIL6lSo7M9q7ThxpGVYuLYpsy0cYj1Ijib
         vS0oosh5yuvKeP4wazhu/p3sNI3CxpROUDaWp20vkSxM1quGsZ50xMLXuEyx5aL6m7XZ
         rHAOvkqXx0s/sASiMTwtyhP6kPhcPeXDHgGl6c80lSM+wjTOxr2AjIsBGPmFIRoQdtvW
         oY5/DDlxGYm2oBiW3QZYNmEedKP97CKpX9aqO0Iysxl9ScdzyOFRa79oT6xjB63uJzDK
         q8LT1yX3YIOHrWLZ1/s5wAH26+zf7YvdyKBpJ3VHeerPRtV8lB+H8KT1jTA/RiE3lQ57
         WnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731561; x=1761336361;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6B3o1GcV4NOswYtqv3NoADkIqp/vNxZ9DP8NEa56sZU=;
        b=ldmKvFzyYpUujcALOo2E4CiUtFOxp1U7tsIPdGsX1gt+rqR/HdOwwLQahxPOYgKXRP
         FZBqttTzkyhG2UPQ9S9L/I3RqiXVg+1VHXLgNSS6iOAfT6nb4vNydka5lLrYs+f2wwZk
         hWjfON5W0rFb+EMCGxKqitXwNBFSxnzWBaLJNuVMunCNvz/cCqMgVo96HU+oPVhoMw3g
         oo1oYO6pjnhhDt/AfVFUzFD4xEW+RYPYQT//pGtk6BoJI6RJxUljpGqQ01G0Sj/ymLfk
         of6ctHxCrRZ5KziXg8i5At7DSgG2kRQrqISWUbSWhZXrzqKgn0YfdE+PlcwSrWCCI/iq
         RWwg==
X-Gm-Message-State: AOJu0YwygTWjSMxxh4lpHSoM7I4I1qSdC1YFXlNCu8QZJkvncjSQ//NJ
	/AerOM+n6Bgh1ybmLuLFwMA7/7Bdsc5nx9bQUOe2T89oTzKKcg7KmbfCa4gxZw==
X-Gm-Gg: ASbGncvLZ+f1m/0R6lk15KdgYvFPl+e9VoCjRp050zS8t1unhT8js67j/KtdAxHjVg2
	vEzUgLJBejjRA8XBOKPNv2HNax77AlCgNmbiBnJSeOCbVY6XRJ6mInYE3DIxM//GlMhNBh7eAia
	7WtTQSgrRcnbudoRLfK31npVDk3XSMHS6BaCbzjuI6sLYUMPR5yy3ZcfP7HeClIYYPG1CaKr0cj
	FiVj1Wlmsa4j+FKGuWoX2SBCNojlmRZQIP9oZIpHDOvbms95AoVOS+Il4zJgJXhhnVSmtRpkbF2
	tYNzBQsp6UeVAiXrDU2WXmXqT/Ui+fnsQNsbniP9z7KGr6Wf9p6QaqPbXf2iQubChdJZyCv3X+I
	6MTmAfWdbN2+ayGwNfGZdovjFhqzCaBTGx3xVZOIxlagOpC/QaKCRw9ZV8/glm4Qvna64+RtAyN
	SVQhsew3zWwphlGHPMXIdEceA=
X-Google-Smtp-Source: AGHT+IFRDcUAwiNWTF8/r6DiAbOiQgTHfW4Kcl5p17rJqGPVksAjWGXc2hpQM8uBwYz+kNvknW8u+w==
X-Received: by 2002:a05:6a20:549d:b0:32d:a6c0:15bb with SMTP id adf61e73a8af0-334a7a5fed0mr6157332637.31.1760731561030;
        Fri, 17 Oct 2025 13:06:01 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.129.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f256dsm414872b3a.50.2025.10.17.13.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:06:00 -0700 (PDT)
Message-Id: <c7e1c090475f76d94363018681c34f3955abe87e.1760731558.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 20:05:55 +0000
Subject: [PATCH 1/4] doc: git-reset: reorder the forms
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback: three users commented that the `git reset [mode]`
form is the one that they primarily use, and that they were suprised to
see it listed last.
("I've never used git reset in any mode other than --hard").

Move it to be first, since the `git reset [mode]` form is what
"Reset current HEAD to the specified state" at the beginning refers
to, and because the `git reset [mode]` form is the only thing that
`git reset` uniquely does, the others could also be done with
`git restore`.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-reset.adoc | 58 ++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 3b9ba9aee9..9843682e81 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -8,43 +8,17 @@ git-reset - Reset current HEAD to the specified state
 SYNOPSIS
 --------
 [synopsis]
+git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 git reset [-q] [<tree-ish>] [--] <pathspec>...
 git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
 git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
-git reset [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
-In the first three forms, copy entries from _<tree-ish>_ to the index.
-In the last form, set the current branch head (`HEAD`) to _<commit>_,
+In the first form, set the current branch head (`HEAD`) to _<commit>_,
 optionally modifying index and working tree to match.
 The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.
-
-`git reset [-q] [<tree-ish>] [--] <pathspec>...`::
-`git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
-	These forms reset the index entries for all paths that match the
-	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
-	the working tree or the current branch.)
-+
-This means that `git reset <pathspec>` is the opposite of `git add
-<pathspec>`. This command is equivalent to
-`git restore [--source=<tree-ish>] --staged <pathspec>...`.
-+
-After running `git reset <pathspec>` to update the index entry, you can
-use linkgit:git-restore[1] to check the contents out of the index to
-the working tree. Alternatively, using linkgit:git-restore[1]
-and specifying a commit with `--source`, you
-can copy the contents of a path out of a commit to the index and to the
-working tree in one go.
-
-`git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
-	Interactively select hunks in the difference between the index
-	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
-	in reverse to the index.
-+
-This means that `git reset -p` is the opposite of `git add -p`, i.e.
-you can use it to selectively reset hunks. See the "Interactive Mode"
-section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+In the last three forms, copy entries from _<tree-ish>_ to the index.
 
 `git reset [<mode>] [<commit>]`::
 	This form resets the current branch head to _<commit>_ and
@@ -98,6 +72,32 @@ but carries forward unmerged index entries.
 	the submodules' `HEAD` to be detached at that commit.
 --
 
+`git reset [-q] [<tree-ish>] [--] <pathspec>...`::
+`git reset [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]`::
+	These forms reset the index entries for all paths that match the
+	_<pathspec>_ to their state at _<tree-ish>_.  (It does not affect
+	the working tree or the current branch.)
++
+This means that `git reset <pathspec>` is the opposite of `git add
+<pathspec>`. This command is equivalent to
+`git restore [--source=<tree-ish>] --staged <pathspec>...`.
++
+After running `git reset <pathspec>` to update the index entry, you can
+use linkgit:git-restore[1] to check the contents out of the index to
+the working tree. Alternatively, using linkgit:git-restore[1]
+and specifying a commit with `--source`, you
+can copy the contents of a path out of a commit to the index and to the
+working tree in one go.
+
+`git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]`::
+	Interactively select hunks in the difference between the index
+	and _<tree-ish>_ (defaults to `HEAD`).  The chosen hunks are applied
+	in reverse to the index.
++
+This means that `git reset -p` is the opposite of `git add -p`, i.e.
+you can use it to selectively reset hunks. See the "Interactive Mode"
+section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
+
 See "Reset, restore and revert" in linkgit:git[1] for the differences
 between the three commands.
 
-- 
gitgitgadget

