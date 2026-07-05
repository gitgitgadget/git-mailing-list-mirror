Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB536EA84
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239890; cv=none; b=iQ0jwI1wy4GhB8Bmn6TB4shRxplA41l4IKG2Kwyabc2wTKTDnXFOJ6b27RBU/bSZ6BfV3FBBNkqb8HbmXRvL361jLyj6nRNMOHCRO8RMqmuoSxlerE0FsVzau4UeuWeF34hH8kCK6JOJ7Subt1aEyZVUo9eNaU3q5Mmg5EmlwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239890; c=relaxed/simple;
	bh=cYVz8SAx3dAKViqMYxsANed4fTd5lIvT00C45fyj6Pc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=FsT+LPWs+L+WZikcrnUWA5E4sJnotG62/I8BHzXO9rQhjVlvN3lUzyap/MRigfSykMaik5YdK3eKw5m/FaR+erP39vg2NlYqav04Sqk9qmGHcNkTB1uNj4P5rFr9NafZ7Wb6M0eBmwC6T3jJjqVNoN18T2r78cWDp3ESjXoQ2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJ0wXOnG; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ0wXOnG"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e5cb052edso145779785a.2
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239888; x=1783844688; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+31RVqFfLVXxUW7YYIaqSHEKTPV07+qpCi/C9V4GjUs=;
        b=MJ0wXOnG7IOHJu3fSah271M7woturNEnKquCPvC6xP3RXnyw3FaeVYcYiobDpjxB4f
         1DseMiN15XDE9MnZbm7jgbJtmL02Dr836GxTZQa1YDTQuHH1iyauffWoLKiy97dljuMD
         rZjDe/xP1PBGZK+SafA1M/G6kSoXTLeWNwoISU9el9am5aXfSzNNAkeOuve5pHcwuz+v
         WsALyvpMZASwV7bc1paUwG8nnvijxGjqN/QKLCxtsF4FBBnLXpDzYpQV0NAfYdzBzZ8y
         +nLWnnDD5qAFz1xo832Ko9dqLzgmWdWA8GfUf6gpmoChWeSI0N1J103Ev6KryOyhuthF
         /NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239888; x=1783844688;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+31RVqFfLVXxUW7YYIaqSHEKTPV07+qpCi/C9V4GjUs=;
        b=a1T4S3XKm4WQ33HTLnJahD8Uakuo2gY7hFy2Jw2dPWBfHrrUdvXZ+vFWrJrUDk6KfJ
         9zEZWEP+HR5hniJoOm3+EFOYRHlQ++g1OykOPPbXc9xdOfeYYLn1+z/HTQ/Zyxiq2NBr
         qbmsTgVKuvvNI9tanECDugN91HMOQxu99eFv1DlVtvKRlCZiBo6pN7fCe9IntRivJY8p
         RrgQ1IEs17nSmaPKe+TtWrZgXWN2y/5Cvb7yVnzyVyILc0eD2CMoFRnXm493MWi4RvuH
         wpgI98BPYKvwKZ67B99NzM9EEJa0LIx8K53JdGmPI1S5suEh0O8q69PAJt99h9rFjsbN
         n2bg==
X-Gm-Message-State: AOJu0YxHJmKwf8obiHBUbXtsl7NHpajwIyE/NKleNE+Zs5Wiqt9/WcaG
	1bmWvWEasCICPPwzKHPc/7PYWlIywVblVtrVahyY4/rlPSTtViB/ROztHKBI7A==
X-Gm-Gg: AfdE7ck7NBhG4msMTxYBlpLf0q5aCR3SYYCfbv2R8ZLDW3zaoY8pMLAjSPvr9qiVGL3
	4I6l8saXKpZZu3nfafmQJew/MW7Va6AtFRNti5XP0IL6bKNVBajxcB7CL41TpjKVhDGS/GDTSbq
	vW63Dw3eQMKliB5r9R8A5Qu90rJq48yjlX+B783m+1TI+OWDRA6NnBOYF6ajb7jRgnle/O8iOsF
	h1cJRKpVL86i9+lRxX41+SaHwevZ5gIIrXi8I7ZRrsuDXEFwQD+/FCWeO6YJlpmDNdi7SmfpfML
	VEHEoZ9BE/V60hFi+/cJAO8qdRDEtH+mJi56Pceotx98PWmf2uXou42kobd52rE+2w099vOhyRv
	qCEqli+J1zL1jvbFsYTlO83Z2RxxcW2Hb7Og+1WMRytflskjS7tAAJHw2gwiL6yQ/HEUyYwTtpG
	FLBZSxJp/FX39nG9cnGQ==
X-Received: by 2002:a05:620a:4728:b0:92e:4e88:f453 with SMTP id af79cd13be357-92e9a477c49mr882959885a.52.1783239888332;
        Sun, 05 Jul 2026 01:24:48 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90b81342sm621849485a.7.2026.07.05.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:46 -0700 (PDT)
Message-Id: <0048c0ca2752853dfba7ae1bf89dd70c8e501d54.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:25 +0000
Subject: [PATCH v2 08/12] worktree: fix resource leaks when branch creation
 fails
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the "add" subcommand, when `run_command()` fails while creating a new
branch (line 948), the function returns -1 immediately without freeing
the allocations made earlier: path (from prefix_filename at line 858),
opt_track, branch_to_free, and new_branch_to_free.

Redirect the error return through the existing cleanup block at the end
of the function so all four allocations are properly freed.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/worktree.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index d21c43fde3..4bc7b4f6e7 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -945,14 +945,17 @@ static int add(int ac, const char **av, const char *prefix,
 		strvec_push(&cp.args, branch);
 		if (opt_track)
 			strvec_push(&cp.args, opt_track);
-		if (run_command(&cp))
-			return -1;
+		if (run_command(&cp)) {
+			ret = -1;
+			goto cleanup;
+		}
 		branch = new_branch;
 	} else if (opt_track) {
 		die(_("--[no-]track can only be used if a new branch is created"));
 	}
 
 	ret = add_worktree(path, branch, &opts);
+cleanup:
 	free(path);
 	free(opt_track);
 	free(branch_to_free);
-- 
gitgitgadget

