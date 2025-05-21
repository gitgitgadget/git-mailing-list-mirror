Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335A425B660
	for <git@vger.kernel.org>; Wed, 21 May 2025 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822998; cv=none; b=cenO15R+dL4xlPB0QYRCu6nGLpH98SlLxFxlFENwh44PnqEtkw3fpR3Hd5zklxEHPiBKlt4BqlA9kkwpwdcqkmaoOhuHqPBfqC45rkY8RaJvRc7H228GbzgCGA9KMDwgmW9cImletkmEIXINA6T7VXF9v42JWwi62Q3zVrP0R4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822998; c=relaxed/simple;
	bh=O/IvcjasHNc6z5hEb3DJbG2FYTojX7w3Zc5UvAA37H4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=kL7pFNkH3wHnz022u9K66TZ9D/mZf5C6AlxxJwsvgN8GHlX/MxhRMgRqD158Nl7kMm/cMRB4F6KytKuWvjj94YHCuUQg9ccmpyiM7vyTCQIwoWhJ4aNrdjo4h6KsO3kMJ8TqqRok1wzn+gutzM+hxKLnJLSOCdLm7Rc94dHLqVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjTIr9PX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjTIr9PX"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so54612285e9.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 03:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747822994; x=1748427794; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHqiiutBSUKUbrnxJXNdJuJqdnKsIgDnKMMJPkGq6Ts=;
        b=NjTIr9PXw1X53RobsRjGPEvRKQgzhx+5vszbFWUY+tnHmFdXuQnVth/pdhSdmePexn
         VZgciX3b+kcPK5tB2+2jYkkdXKEAGJgqcgVCp+dgeizbbQPsXalxvmR3NuXZE7fh4DF/
         stXBhCr3ONkAN0pSkA9KvA54d9LJAaYWGCh+unW+fghrMa+JzCudEXsmo38rZ3p062So
         EhDYVwKQc2NHpIUouAUljqk+VXujZCnnrAv2jFAWeVA3UZV2Qz3XsVKygXlYmQ4ZIiPW
         oQy1qm9pWuwUhDewrXhbmFZdTOINABFUckGRqD9DIiGh/MyxphLZyIEaldJs7tZNUzNl
         n+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747822994; x=1748427794;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHqiiutBSUKUbrnxJXNdJuJqdnKsIgDnKMMJPkGq6Ts=;
        b=PBNOB1jvGu/0jYvJ9YzCWoqAPNj0E5Flvlz1DcT9pH0ux0H+S9Ci6I46HIZTeo5k89
         zxBTJXe1Fw+rGhVp8obAgwwsZlQhYchmrk7L0FY7wksnUm662EzIWMnqNDE2hsDHSPGL
         PRbJEWUw7dpO9+pZLWteWh+EwGxAUQYVPM0jRNMmaS9qnTkFXwyAZbj/rKZ6KfxGN2HE
         CeIgLLhAjNCQJHRGhIfAZFKeG0n2347Ew4jtC9tKM/t4qIDvfOIQXcpJQeddbKu+E169
         JenySFsGjD8MM5l6zLfhHVUYLIBsetHtIgKETwCrmpRpATktN6w6PIkgR59AjOsTMlnk
         ALfw==
X-Gm-Message-State: AOJu0YzTnhcLrMliwHa3nH/Xo66za00j6nCb55G+yZXrYeHtK2WF5tYX
	lkBe/GYjmpUC7GtDJOcUf6iNaUMrbSj2E/j1rnzvqM7S1y851StkpLmZLSR7aA==
X-Gm-Gg: ASbGncujIcGRswd/uCNxEty6JewDyEanD26jLlJWLKETK6F+ajQ5ys3ApozwXSWo0WB
	IJzTotW00MTGRprkDx1ppxEx5wpnA7KB/v0QqZGuUrCQ1jAfq9z2dmG//ov3Ur+0q80DAWDYga+
	0mqDTYdmrMuAnM1Ifns3WrEGFUSaozVvlT78jMJlJojh9XYQHIUzarappgFSLk/XY/LMLKfvChT
	jTQxv9YFirB5a2NFy4k8NDy7G6H6aHru23HcdWsMkIVkWONh0HUps4eJl0oBH6vnhTdTx8TCWNF
	VCG4eb7Hpls3vsQBlIbvWCgt/bCpzByBzhElpc5cucRSuJaQs5FJ
X-Google-Smtp-Source: AGHT+IFCnVLWJVWIKXMLuOwnYMHFhZj1TRpYywj/sR6A39NQVAZHNIbVlNJiU3pc7pOije1t87AZbQ==
X-Received: by 2002:a05:600c:a42:b0:43b:cc42:c54f with SMTP id 5b1f17b1804b1-442fd6276f7mr186690825e9.14.1747822993806;
        Wed, 21 May 2025 03:23:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3648baa6asm16898949f8f.91.2025.05.21.03.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 03:23:13 -0700 (PDT)
Message-Id: <pull.1925.v2.git.1747822992457.gitgitgadget@gmail.com>
In-Reply-To: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 May 2025 10:23:12 +0000
Subject: [PATCH v2] cvsserver: avoid precedence problem between ! and %s
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
Cc: =?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>,
    =?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>

From: =?UTF-8?q?Ond=C5=99ej=20Poho=C5=99elsk=C3=BD?= <opohorel@redhat.com>

With perl-5.41.4 and newer, git-cvsserver fails to build because of
possible precedence problem[0]

Added parentheses avoid this issue.

[0] https://metacpan.org/release/ETHER/perl-5.41.12/view/pod/perl5414delta.pod#New-Warnings

Reported-by: Jitka Plesnikova <jplesnik@redhat.com>
Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
Signed-off-by: Ondřej Pohořelský <opohorel@redhat.com>
---
    cvsserver: avoid precedence problem between ! and %s
    
    cc: "Kristoffer Haugsbakk" kristofferhaugsbakk@fastmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1925%2Fopohorel%2Fcvsserver_parentheses-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1925/opohorel/cvsserver_parentheses-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1925

Range-diff vs v1:

 1:  42c03c4b044 ! 1:  a15f924657c cvsserver: avoid precedence problem between ! and %s
     @@ Commit message
      
          Added parentheses avoid this issue.
      
     -    Full credit for finding the issue and coming up with the fix goes to
     -    Jitka Plesnikova (jplesnik@redhat.com)
     -
          [0] https://metacpan.org/release/ETHER/perl-5.41.12/view/pod/perl5414delta.pod#New-Warnings
      
     +    Reported-by: Jitka Plesnikova <jplesnik@redhat.com>
     +    Suggested-by: Jitka Plesnikova <jplesnik@redhat.com>
          Signed-off-by: Ondřej Pohořelský <opohorel@redhat.com>
      
       ## git-cvsserver.perl ##


 git-cvsserver.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a4e1bad33ca..076c10cb2c2 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -5009,7 +5009,7 @@ sub escapeRefName
     #   = "_-xx-" Where "xx" is the hexadecimal representation of the
     #     desired ASCII character byte. (for anything else)
 
-    if(! $refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
+    if(! ($refName=~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/))
     {
         $refName=~s/_-/_-u--/g;
         $refName=~s/\./_-p-/g;

base-commit: cb96e1697ad6e54d11fc920c95f82977f8e438f8
-- 
gitgitgadget
