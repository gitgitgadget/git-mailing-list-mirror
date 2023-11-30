Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJ7vKxI4"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7501A5
	for <git@vger.kernel.org>; Wed, 29 Nov 2023 16:24:54 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b4f6006d5so2860405e9.1
        for <git@vger.kernel.org>; Wed, 29 Nov 2023 16:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701303893; x=1701908693; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+CmRCCHA9zdDbEts/0JPouoKBTMsX0oz6YclPFFbnHg=;
        b=PJ7vKxI40XdzcP4ttst8tlN3aLy5DqKBlA3RgC+M+cscsk4TVvA89Wsz3lfKZ9dy7l
         pb/siwE4w2Ekb6SgYAF9kRNS07TrdfAS1vCx74JFhBxPDWps0GEMrs1RVUBb1U+I3aMG
         vgo7OVQwmSgipmtvrzTuM0gdgWtqwZ/M8fXZPalG30e16mWq5UoOqECwSKoEMoxd6ank
         AbZqc0iUZH0cHsVr1ofnmg5mcygUFZs6vHNlNVHp9Oir20960SstKKRikYjSDxEh32TZ
         D9jFLXFlpZa3UocOaFWz1MVy8RVO7nMslqa2UC0sP4g13bZcCg2S2PeN6OrBFZx8u/XB
         w3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701303893; x=1701908693;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+CmRCCHA9zdDbEts/0JPouoKBTMsX0oz6YclPFFbnHg=;
        b=uTHWn/8vgL7qhlL7k1KcEeH+kcMhHNeI10a804Yk6GDXCJWk+/g8pB9eW4ktFT3Bow
         eh5ggRJqPcop6fIr7gcxSdWWtuDBiL00pemz2xrToaonxrRXvNUNZuG5zsFKOWCSK4xJ
         14ZNdvKmuv04/JgauwIVMtgJsDXdtl2T0DradvDnl/q8ncEWj1DWVLlE++YKY0TBrJB4
         Pb5o8z6RMlwc0tkZDHw+s4JWlZ91UIbGzBqLAWewK5O18pfiOt7/7E6NKdjp9EiTWoqJ
         eXoXQzrDwxAiEfoiVIg8vw5+Lpm0KcE+cDg9w7ptLeQVWUEAibss1slslv6lTZq5QXEy
         cejQ==
X-Gm-Message-State: AOJu0Yz2raY9xWsZz/XF5U6HRiBQUQvXls7gTgC4/E8216/X2FrKgZ6a
	vmJAWuvJ/lx6k3gxWeXhQF16TuTAlVA=
X-Google-Smtp-Source: AGHT+IE1EqGtKaI0iPEupBKJK7DwlC5AsALk50r+Y3+r+PIhmtsow+zGDd3zcxVgQuWxHHmOvUJR0w==
X-Received: by 2002:a05:600c:46cc:b0:402:e68f:8896 with SMTP id q12-20020a05600c46cc00b00402e68f8896mr11325217wmo.0.1701303892532;
        Wed, 29 Nov 2023 16:24:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az27-20020a05600c601b00b003fc0505be19sm68930wmb.37.2023.11.29.16.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:24:52 -0800 (PST)
Message-ID: <pull.1613.git.git.1701303891791.gitgitgadget@gmail.com>
From: "Clarence =?UTF-8?Q?=22Sparr=22?= Risher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 30 Nov 2023 00:24:51 +0000
Subject: [PATCH] Mention default oldbranch in git-branch doc
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
Cc: Clarence =?UTF-8?Q?=22Sparr=22?= Risher <sparr0@gmail.com>,
    "Clarence \"Sparr\" Risher" <sparr0@gmail.com>

From: "Clarence \"Sparr\" Risher" <sparr0@gmail.com>

`git branch -m` has an optional first argument, the branch to rename.
If omitted, it defaults to the current branch. This behavior is not
currently described in the documentation. While it can be determined
relatively easily through experimentation, and less so through viewing
the source code (builtin/branch.c:897), it is not obvious what such a
command will do when encountered in a less interactive context.

This patch adds one sentence to the git-branch documentation, with
wording based on another optional argument described earlier in the
same doc.

The same behavior applies to -M, -c, and -C, which are all covered by
this same section of the documentation.

Signed-off-by: Clarence Risher <clarence@kira-learning.com>
Signed-off-by: Clarence "Sparr" Risher <sparr0@gmail.com>
---
    Mention default oldbranch in git-branch doc

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1613%2Fsparr%2Fdoc_branch_rename_one_param-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1613/sparr/doc_branch_rename_one_param-v1
Pull-Request: https://github.com/git/git/pull/1613

 Documentation/git-branch.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 4395aa93543..affed1b17a4 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -73,6 +73,7 @@ overridden by using the `--track` and `--no-track` options, and
 changed later using `git branch --set-upstream-to`.
 
 With a `-m` or `-M` option, <oldbranch> will be renamed to <newbranch>.
+If the <oldbranch> argument is missing it defaults to the current branch.
 If <oldbranch> had a corresponding reflog, it is renamed to match
 <newbranch>, and a reflog entry is created to remember the branch
 renaming. If <newbranch> exists, -M must be used to force the rename

base-commit: 564d0252ca632e0264ed670534a51d18a689ef5d
-- 
gitgitgadget
