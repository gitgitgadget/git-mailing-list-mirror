Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83A1CA80
	for <git@vger.kernel.org>; Tue, 21 May 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716306538; cv=none; b=J7Az7K819VDheQYyosS/YJxGHvFZNsPYNtEH9H6gmA+2aYydToPXoCJRC+2zMO8bcB8bna0nq/N+5P6Zoy6OM+FzCgsQF/QYTO70OOG4sHsHeA9r+u1z6yy9FSjvLIILLjtHOh7Fq0oq9gXE9Y/fEiEIOdDeBjxjUT/+LO/rBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716306538; c=relaxed/simple;
	bh=MIwgKMqi0jqZtWfWYfASawerrtwxDNjl+SNFjqzb6TM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=KF696uRUzyLT7DcIWOJ+EOKz7PaIhN3gL668UVo5xDr9OUvAx64OkR+9PL3AFBjh6AtIajF0mh6BQHsXAyK8dcjAcatG6/VJQhIlsuHY74WCrkRw9XLczMipRZLN0lGZqES+svnQ3LvAbFYDusgamrWhZSy2D0+C/nPdvsjNPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIah98ze; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIah98ze"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-420180b5897so32097155e9.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716306535; x=1716911335; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sXKGcoWRCyj3ViJNXOUpceMkdtyvf3DDoDg2aD1yYuQ=;
        b=EIah98zeGA/j5b1ULShbksH2EDir7ckEc96rxh42pSXcWlhoz8cofFnJOVOLqyNMzU
         1kMey1VVcHMEpZvrGUMZHUOAm9CZpTvLYmM8o8t+uCUaDHqO9myffT5+4l5XwUqsE+uf
         q/pwtF2fI8xLZx/AbikZq4n299rhoowfLFmgIoZYnwS+fqqHEMuY2A27+0ei1UZ5UlW5
         UZ4a3gqp1qGyhC/tlO0vTnC20Cz6hHHYvPJXDmOPZ1G308YIJydviSl0n7N8Jn+gVzhP
         8XS0d3l69JPKftSaJRqmjRK2Nk3wmAHxwdcQRjHwpzOUOPKwcxqfgCQ9HxKID2UJ8uQa
         QoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716306535; x=1716911335;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sXKGcoWRCyj3ViJNXOUpceMkdtyvf3DDoDg2aD1yYuQ=;
        b=sLSp5SUtPbTNrK3NtqsezWf8cBAKdGb7tIl76FGiKOOT7vsVIRhxufCuR51riEkZKF
         Hv8fcExcX0df/DZg0mUjXQpLpShYwFXNQ5L2/+mhQR4CyR3P85eG7ZH1PesAjGKn4+/+
         CUNzmxf32bUBljD/TZvLU69dvoBBbiQv4+VJDIAeBmaZiYWgHCreIINR0KM0FybVaVhf
         mFJcfufRe+1FOfG8MyoM4DNEHrFhpYZdgYrh2GUMWGR29Cc7pJlk+GQW39wh+6Geo++j
         iR7ixXSIvMiobHRONHbmznZmY6OE5Ei9gsBVA8Tdybj2tZmXbAExNSKRn14tcyoTwBmZ
         u7Mg==
X-Gm-Message-State: AOJu0YxQFgDBmFaSPauGhtpW8DNnQIva/+8tfbqrylsWEYCv98SmMkgs
	TmMm1JUSiovqao81R4Rhvjp8CBbwwUG7V12wUVIzfMs+rZiNIrIWX1ID2Q==
X-Google-Smtp-Source: AGHT+IFkT8lXjyL0Z2GQcc6WYc2HpW3YB6K0wN3meEMeBRGrDWPU/06jBdtdYNHGgldLs9ajBNYYaA==
X-Received: by 2002:a05:600c:4f0e:b0:420:151e:b205 with SMTP id 5b1f17b1804b1-420151eb4f3mr194782605e9.39.1716306534389;
        Tue, 21 May 2024 08:48:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87b2648fsm505357425e9.7.2024.05.21.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 08:48:53 -0700 (PDT)
Message-Id: <pull.1723.git.git.1716306532869.gitgitgadget@gmail.com>
From: "Ivan Tse via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 21 May 2024 15:48:52 +0000
Subject: [PATCH] dir: fix treat_leading_path() to return false on
 non-directories
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
Cc: Ivan Tse <ivan.tse1@gmail.com>,
    Ivan Tse <ivan.tse1@gmail.com>

From: Ivan Tse <ivan.tse1@gmail.com>

If treat_leading_path() encounters a non-directory in its loop over each
leading path component, it should return false. This bug was introduced
in commit b9670c1f5e ("dir: fix checks on common prefix directory",
2019-12-19) where the check for `is_directory(sb.buf)` still breaks out
of the loop but doesn't return false anymore. Instead, the loop is
broken out and the last state result in the loop is used in the return
conditional: `state == path_recurse`.

This prevents the warning "warning: could not open directory" errors
from occurring in `git status` or `git ls-files -o` calls on
non-directory pathspecs. The warning was introduced in commit b673155074
("dir.c: stop ignoring opendir() error in open_cached_dir()",
2018-02-02).

Signed-off-by: Ivan Tse <ivan.tse1@gmail.com>
---
    dir: fix treat_leading_path() to return false on non-directories
    
    Hi there!
    
    I wanted to provide some extra context on the behavior I'm trying to
    fix. I noticed in one of my git hook scripts that it was showing a
    warning error message when running git status on a deleted directory.
    You can reproduce with the following on the git repo:
    
    $ git status --short t/non_existent_directory/
    warning: could not open directory 't/non_existent_directory/': No such file or directory
    
    
    However, this warning doesn't show if you give a non-directory from the
    root of the repo:
    
    $ git status --short non_existent_directory/
    
    
    Also doesn't show if you give it a directory in gitignore (/bin is in
    t/unit-tests/.gitignore)
    
    $ git status --short t/unit-tests/bin/non_existent_directory
    
    
    I found it strange that sometimes git is able to detect non-directories
    without warnings. Even stranger, an older version of git didn't show
    this warning in the first example.
    
    After running git bisect, I was able to track down the commit that
    introduced this behavior: b9670c1 ("dir: fix checks on common prefix
    directory", 2019-12-19).
    
    Before, that change, !is_directory(sb.buf) would break out of the loop
    and return 0 since the branch of code that changes rc to 1 hasn't been
    reached yet. The change introduces the conditional state == path_recurse
    as the new return statement. This state variable could be from a
    previous iteration of the loop which is causing this new behavior. The
    fix is to ensure the is_directory conditional results in the overall
    method returning false.
    
    I'm not sure if this is considered a bug or not since it's just a
    warning message. If this isn't noteworthy, then feel free to ignore this
    pull request!

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1723%2Fivantsepp%2Fitse_untracked_warnings-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1723/ivantsepp/itse_untracked_warnings-v1
Pull-Request: https://github.com/git/git/pull/1723

 dir.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 2d83f3311a7..5cb56f3a3e2 100644
--- a/dir.c
+++ b/dir.c
@@ -2771,8 +2771,10 @@ static int treat_leading_path(struct dir_struct *dir,
 			baselen = cp - path;
 		strbuf_reset(&sb);
 		strbuf_add(&sb, path, baselen);
-		if (!is_directory(sb.buf))
+		if (!is_directory(sb.buf)) {
+			state = path_none;
 			break;
+		}
 		strbuf_reset(&sb);
 		strbuf_add(&sb, path, prevlen);
 		strbuf_reset(&subdir);

base-commit: 4365c6fcf96caac73dcc412aa25db34cf8df48d5
-- 
gitgitgadget
