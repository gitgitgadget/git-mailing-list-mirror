Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E704A29C33C
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758038633; cv=none; b=Mv0R6M2LdRD2hi2kM4Gx7pdggYOzSP+NTUZi1tBYl21k4Iy43Iz6bbfNrLBTYeI8IKRvHia6ndT6sm3ZkONkl/nq87GnYsZSQcXaNbR/w3wBfQryiWQxtwnV+IkknsMzLch1x6QYYZzYc9xnYeINkCNYL0T3dfUzguw0JyA1e8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758038633; c=relaxed/simple;
	bh=Vn1CXOYu67X3q10UuxnXENzj6S0iEW4rMH2EMhrxMwg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=LyhWdL7p5rXrxigVFdbm5DX629h3ISY3vO4kfByVe9B9+xWiCe7kG5TzwdvlTz6cWp1uWBr3Io4T6taChB16AeA5wyqC4mLhNCOySe3hWrZ4AcK48JudFoJuCGUYeG7UAiHiQ3KrtU3CjbOTi1L/lOm94b7R3Hd0KRlW19sfs6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8yGMKDc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8yGMKDc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2570bf6058aso73469835ad.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758038631; x=1758643431; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjRYkKDSWZ234FpoOA4OurthTdLl1h1v+LUENNFI0Zk=;
        b=j8yGMKDcgbkwOor4YqVcPSxnXnpabTYLHuqODhyfkJ0HNWTQ7QRqcitfHc6y0+jCKd
         QcLnXPoZKk7RyYsEjeo3YilZS0bcbL415zUE0t5rHXYL3qLst7F1rnNPvmGT03UiaYqY
         6dk/qlkA4mpoG5Rwh3BBZGd4enwWm+IqdiCXMKQegwvJkCtKcf7AOIpk9PUNlegvJtNB
         wyot8EHEvCPP4ApOJifGXgYESzXnhbSYTwbmhhaVgc9ofAMLKbEG1hLRvVbzfOER7T9V
         hTKQyRED3zE1feIyDQzvrVuGmLy7lpQd3nM8z7shO1jh4qPlGqq9IH5OTVauzgYbbdfg
         vrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758038631; x=1758643431;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjRYkKDSWZ234FpoOA4OurthTdLl1h1v+LUENNFI0Zk=;
        b=tkqB7JL+snA6Q+kVf0qF27lu5fmW8KDutZqsHT5qV2nPv9gEyO9BGoSuOSqK7MHWp6
         XruwIzkssZbkXqMNx2r9bF+zO/MurLYA1jRIUG6g1/5YNgUn+aMvPB2uyoEJU3ItxU7P
         iIt14YMBD84kI88HfJm7AvMeHitMRXw0uS8ThXSlpDg6QPl3mnJpphAx16VrKsdgB5BF
         xiYnrvUM0fXfDCIJtuC4pkRj659o9YJy4/AG8pjYODMXMsajn5nxYBxoEYTLTjf3shGw
         t7nhT6WO9oC3LxaC84TOsZ1551CKM2yK/hl36C91Er4UMoJi5F12mHA75xZZmjzroP+e
         8cVw==
X-Gm-Message-State: AOJu0YxBkICfctPhUZXHfTXSz3KX+bPai15rCnG81/AnDA6hP6XVfVeA
	rs3o4TquTrlOPjIdMhyMo4nsVXPdoHMG0lBjE25fWgtYHkdwriXfxy8lTuWlyw==
X-Gm-Gg: ASbGncuMmF3uyNLIldZAm6NJ//5QVb/l7TPgVrvivOloGTxpJK87lRbe5c6RiFvxan5
	+jHLxaJ4kgErX+UoZaj71rH5sR7/4OR4LGV6RStmGykampmI6Zc68kwGbdfqU8k+6QGR42LersE
	y8d2R1OaJNv6GdNfCSs5keBRuJzJKDR8EFuvG35nflFNHveJgC6RwDywg2MoUxWGsNfEJ1ySrvS
	rBsgIlx8lnte2PfmAB+2OgIBSZSoY8bUJz8amiJt8w/WqoeO9tZePRn6W/LdVx8ULIt23N840Sv
	IKlEmjPZnAIeD3oJoCTjbqPie0IvW7ZEDNgS3Xt9ZaZJ/eOJRm1dYL2LG49mirLjfq/V2W9w8Hr
	sK7YpaUKt2wh22ztqe1sP8IZ1XDuoSONLVns=
X-Google-Smtp-Source: AGHT+IGnfpzQYWQl2L8iBt5Rb3dB+gujZDvwLSSPjXAL9FYOgoxtKI5C3YZjEZEveqY5VdPR7q6ReA==
X-Received: by 2002:a17:902:e84d:b0:25c:e2c:6678 with SMTP id d9443c01a7336-25d241005a4mr246212535ad.5.1758038630521;
        Tue, 16 Sep 2025 09:03:50 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.141.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267fa950089sm2924345ad.100.2025.09.16.09.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 09:03:49 -0700 (PDT)
Message-Id: <pull.2028.v2.git.git.1758038628948.gitgitgadget@gmail.com>
In-Reply-To: <pull.2028.git.git.1754922884439.gitgitgadget@gmail.com>
References: <pull.2028.git.git.1754922884439.gitgitgadget@gmail.com>
From: "Gustavo =?UTF-8?Q?Velasco-Hern=C3=A1ndez?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Sep 2025 16:03:48 +0000
Subject: [PATCH v2] docs: update description for '--mirror' option for 'git
 push'
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
Cc: Gustavo =?UTF-8?Q?Velasco-Hern=C3=A1ndez?= <gustavo.velascoh@gmail.com>,
    "Velasco-Hernandez, Gustavo" <Gustavo.Velasco-Hernandez@netapp.com>

From: "Velasco-Hernandez, Gustavo" <Gustavo.Velasco-Hernandez@netapp.com>

The current description considers only created, updated or deleted refs
locally. However it does not address the case where new refs were created
on the remote end, in which case, are also deleted. The description has
been reworded to describe what is removed, updated or added. (Based on
Junio feedback)

Signed-off-by: Gustavo Velasco-Hernandez <gustavo.velascoh@gmail.com>
---
    Docs: Update description for '--mirror' option for 'git push'

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2028%2Fgustavovelascoh%2Fgit-push-update-docs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2028/gustavovelascoh/git-push-update-docs-v2
Pull-Request: https://github.com/git/git/pull/2028

Range-diff vs v1:

 1:  2be0bf6e73 ! 1:  ab077544b6 docs: update description for '--mirror' option for 'git push'
     @@ Commit message
      
          The current description considers only created, updated or deleted refs
          locally. However it does not address the case where new refs were created
     -    on the remote end, in which case, are also deleted.
     +    on the remote end, in which case, are also deleted. The description has
     +    been reworded to describe what is removed, updated or added. (Based on
     +    Junio feedback)
      
          Signed-off-by: Gustavo Velasco-Hernandez <gustavo.velascoh@gmail.com>
      
       ## Documentation/git-push.adoc ##
      @@ Documentation/git-push.adoc: already exists on the remote side.
     - 	be mirrored to the remote repository.  Newly created local
     - 	refs will be pushed to the remote end, locally updated refs
     - 	will be force updated on the remote end, and deleted refs
     + 	Instead of naming each ref to push, specifies that all
     + 	refs under `refs/` (which includes but is not
     + 	limited to `refs/heads/`, `refs/remotes/`, and `refs/tags/`)
     +-	be mirrored to the remote repository.  Newly created local
     +-	refs will be pushed to the remote end, locally updated refs
     +-	will be force updated on the remote end, and deleted refs
      -	will be removed from the remote end.  This is the default
      -	if the configuration option `remote.<remote>.mirror` is
      -	set.
     -+	will be removed from the remote end. Any ref existing
     -+	in the remote end, but not locally, will be removed too.
     -+	This is the default if the configuration option
     -+	`remote.<remote>.mirror` is set.
     ++	be mirrored to the remote repository. This overwrites the
     ++	refs at the remote by (1) removing what is only at the remote,
     ++	(2) force-updating what both ends of the connection have, and
     ++	(3) adding what only exists locally. This is the default if
     ++	the configuration option `remote.<remote>.mirror` is set.
       
       -n::
       --dry-run::


 Documentation/git-push.adoc | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index 5f5408e2c0..77ce4a27c8 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -163,12 +163,11 @@ already exists on the remote side.
 	Instead of naming each ref to push, specifies that all
 	refs under `refs/` (which includes but is not
 	limited to `refs/heads/`, `refs/remotes/`, and `refs/tags/`)
-	be mirrored to the remote repository.  Newly created local
-	refs will be pushed to the remote end, locally updated refs
-	will be force updated on the remote end, and deleted refs
-	will be removed from the remote end.  This is the default
-	if the configuration option `remote.<remote>.mirror` is
-	set.
+	be mirrored to the remote repository. This overwrites the
+	refs at the remote by (1) removing what is only at the remote,
+	(2) force-updating what both ends of the connection have, and
+	(3) adding what only exists locally. This is the default if
+	the configuration option `remote.<remote>.mirror` is set.
 
 -n::
 --dry-run::

base-commit: a483264b01b977f3e65a4419103c21e6af7412a2
-- 
gitgitgadget
