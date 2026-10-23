Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792774252;
	b=Ag6taXbed3qTiYUhgTV4VkqOphaI8b+4yhG51m3FX3dRnSboso9FURMNdRICYB5VK6AN
	 y/a/ljPd+j1No5S5KLtj36YYHShYPiVuDWNgFxQhQUlQg9bLAHB+6RKlETxbwNWXFiOFZ
	 pIuQqvC2KTQtUrHnVXyO8iwTAZhMianAa5eHep0B/Wls83gyH220Gl04g7u5++6orcfxJ
	 MCrOcyuAopDpEJBcaob7hfFdjEdHgdmzJSQGYeNwQF0+f3aFpfs2qHPffxkIBqhaJB2L5
	 xn9daN3KrM7XqZHbBYbkiYMbzRp18+l9B/45LLrY1dOwKyyNwuNjBowlAdAA+uJ0sWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792774252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=gBm7pMWWDc4CIqlU9iZ89EyNEzqb6fcHki2miGQ9Yik=;
	b=J+6XUwzbXM7TN8GX4r6NKO1NLLD3/4XZ/OVCKcrhBMrsFPeJ6dHI/eEKX2P0hOqA45TO
	 lFsx6qRSXLDW0IJiVwKKvrNJex3gBM0YCIVs1ihtEtzuw/Mifb4WLI5T6qGnz3N0zdvsD
	 6pETmMyB82aLof8gAL/zb7yfigu71tGlu36LDtXWnW21z4CKywoFizurJRQv068R2hpuu
	 yVgrucyQ8/JCIfZZU7aWMiXnnGUTBF7S5xijHAADHPlzsO1vxmdoDRn3WMinHrs+SSeBq
	 AazWCdH6fS6ueEcHJU2hgiA6bUPDnWtV2pjfi+DFc/EZ2fmjWIyrjSHv6qmrD9J2ryA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AZL70Lm2;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C85606A31E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 16:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1C85606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AZL70Lm2
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ea759cc9b6so3665415ad.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792774251; x=1793379051; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gBm7pMWWDc4CIqlU9iZ89EyNEzqb6fcHki2miGQ9Yik=;
        b=AZL70Lm2BBPOzQEYPq+DHT9Sxik3q4vYvOvWDeI69LCVDhnsr+yFnI5iyq741MJ5c0
         w6X7M4IU0aZJkG+uborl90jLWTE4raYbmemqPdBwpQgM2UpXvifvjFUY+Gu5t0et4A9h
         xV/fwlegsglFGnyFDQwRd3jU5LCILhe07hSvR+sGMNhadqwTtSSDwJQYN3utVy75GHQV
         00a0Cy8M3d+kwqtS4nqDSsfmcei66Vz/LJ58po0rLwU+c0g/tultUv3ARteU4eki1Fjd
         IbYdx/MXIizelxzGypeo0UMoC8ahhuV4GKDmgSlZXuzag3pbBNMXkhGDUH23HHi3sejZ
         rySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792774251; x=1793379051;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gBm7pMWWDc4CIqlU9iZ89EyNEzqb6fcHki2miGQ9Yik=;
        b=WBXjPvkQoVQS2RWVfTYYDlb9o1sUGUGdd8B0DG0m6S2UyerM5NXBgArSUIzRObzuMM
         p/WLOW6kHo7fsXpiGSCGCn6s93BbCbZNtrBltV7+fJIZg9BDLEAD6E+3ENdO7PAXQIpI
         VtzKf+8UXCUB7wDGQT8kwZ4O6uVpYR0GZ6dsj2l5XfYccQNFLQoKSnFtghsa20GX8M5z
         h7xCjHOR2StbFy4NahfNtfAAClMOH/d7arcJRHtTrFCt/rHZ5q/I5BLdXOnRy+M7hCPQ
         bqH3zlBf5XkPyfEp4iopBwfWMV6Z/POJlFO2aWbOYGlFB2sTLs6Xq2x0U6gfmD0DxSnJ
         vQPA==
X-Gm-Message-State: AFq9FYJvFXkJrWi5RDjg951DC8hJFBEMOBY6wtlcxOqR//XlUrdQ+f8D
	hiDYFFgfON1ZQ8Rn4BsKHmZ0uXnMgzqCHb+Xs1lmVAW33Btbs/UpqnPoUcQnSw0z
X-Gm-Gg: AYBFou2KfWnSmuhbUNczIgdyqXm2Fqi9ves0Zn8X3IdHSevKQw+HPtFGdEt5Zbe4qS8
	EbDDBScdF5UKRACYM6R+6MVfUHdXfwEubCKcckeZqYskw1XEMlhn16a2TkozG62vOC8RPaKXHiS
	0lUL9+AV0hynmw+tJJo6UqdjSzi6rYcqsw3jkgIP8m7Xw+ZygVk65VORoJaHOFxWUKQ8VIUpxHz
	jp+qxIuLNBgcXgRehtXKV7zbTCiA0MFQbVWbq1F0HqHISAErdEKg3yKWon6Iv884Mwt3akPxK85
	le4BE+7YQsp3UmTX2uPNi73SFUjfbHI99DFZfsvgypu6vKR+i525ojUyDcG9AwqkYNwN6dFt34r
	6+zAhkH4wMRzXA96XnaiXwDfMeSPGnkmj4z8NaUiOszPOOqfr5bCMrE0ZA7bS73MJtZLs+zx0ws
	eSNEFFGhAK7WQHiZf98GxHFK/WYvERIGsneQD2zOvTz/sArGWsIVJatNo+iJYNuqWTHObb3L6Fz
	DLMCDg4tL4XPd3Ou06kIYJP8bfhdaJ1KL0pfvA1gR0Ts+/yXs+By1UjPc4=
X-Received: by 2002:a17:903:1aa6:b0:2e5:e1de:9c3c with SMTP id d9443c01a7336-2ea7c33beb0mr25985615ad.47.1792774251154;
        Fri, 23 Oct 2026 09:50:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.128.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea94770593sm2692075ad.50.2026.10.23.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:50:50 -0700 (PDT)
Message-Id: <pull.2403.v2.git.git.1792774249888.gitgitgadget@gmail.com>
In-Reply-To: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 16:50:49 +0000
Subject: [PATCH v2] ci: fail the build if perforce, git-lfs, or JGit fail to
 install
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A failed install of perforce, git-lfs, or JGit was silently
tolerated. The corresponding tests would just skip and the build
stayed green, so a broken download could go unnoticed indefinitely.

Fail the build immediately instead on the platforms that install
these tools. The presence checks and warnings at the end of the
script are gone too, since we already know by then that everything
installed or the build wouldn't have gotten this far.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    ci: fail the build if perforce, git-lfs or JGit fail to install
    
    Fail the build if perforce, git-lfs or JGit fail to install on the
    platforms that install them.
    
    Changes in v2:
    
     * Perforce, git-lfs, and JGit install failures now fail the build
       instead of being silently swallowed. Removed the presence checks and
       warnings at the end of the script, dead code once install failure is
       fatal.
     * Version output (p4d -V, git-lfs version, jgit version) moved inline
       right after each successful install.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2403%2FHaraldNordgren%2Fci-scope-optional-tool-warnings-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2403/HaraldNordgren/ci-scope-optional-tool-warnings-v2
Pull-Request: https://github.com/git/git/pull/2403

Range-diff vs v1:

 1:  3ce51dc322 ! 1:  dde1b38567 ci: only warn about perforce/git-lfs/JGit on platforms that need them
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    ci: only warn about perforce/git-lfs/JGit on platforms that need them
     +    ci: fail the build if perforce, git-lfs, or JGit fail to install
      
     -    perforce, git-lfs, and JGit test git's own interop code, not anything
     -    platform-specific, so installing them once on ubuntu-* (all three)
     -    and macos-* (perforce) is enough coverage. debian, i386/ubuntu,
     -    alpine, fedora and almalinux never install them, yet the presence
     -    check at the end of the script warned on all of them anyway.
     +    A failed install of perforce, git-lfs, or JGit was silently
     +    tolerated. The corresponding tests would just skip and the build
     +    stayed green, so a broken download could go unnoticed indefinitely.
      
     -    Scope each check to the platforms that attempt the install, so a
     -    warning means one actually failed.
     +    Fail the build immediately instead on the platforms that install
     +    these tools. The presence checks and warnings at the end of the
     +    script are gone too, since we already know by then that everything
     +    installed or the build wouldn't have gotten this far.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## ci/install-dependencies.sh ##
     +@@ ci/install-dependencies.sh: ubuntu-*|i386/ubuntu-*|debian-*)
     + 			"$P4WHENCE/bin.linux26x86_64/p4d" \
     + 			"$P4WHENCE/bin.linux26x86_64/p4" &&
     + 		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
     +-			rm -f "$CUSTOM_PATH/p4"
     +-			rm -f "$CUSTOM_PATH/p4d"
     ++			echo >&2 "error: could not install perforce"
     ++			exit 1
     + 		}
     ++		echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
     ++		p4d -V
     ++		echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
     ++		p4 -V
     + 
     + 		wget --quiet \
     + 		     "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" &&
     + 		tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
     + 			-C "$CUSTOM_PATH" --strip-components=1 \
     + 			"git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
     +-		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" ||
     +-		rm -f "$CUSTOM_PATH/git-lfs"
     ++		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" || {
     ++			echo >&2 "error: could not install git-lfs"
     ++			exit 1
     ++		}
     ++		echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
     ++		git-lfs version
     + 
     + 		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit" &&
     +-		chmod a+x "$CUSTOM_PATH/jgit" ||
     +-		rm -f "$CUSTOM_PATH/jgit"
     ++		chmod a+x "$CUSTOM_PATH/jgit" || {
     ++			echo >&2 "error: could not install JGit"
     ++			exit 1
     ++		}
     ++		echo "$(tput setaf 6)JGit Version$(tput sgr0)"
     ++		jgit version
     + 		;;
     + 	esac
     + 	;;
     +@@ ci/install-dependencies.sh: macos-*)
     + 
     + 	mkdir -p "$CUSTOM_PATH"
     + 	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
     +-	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
     ++	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d || {
     ++		echo >&2 "error: could not install perforce"
     ++		exit 1
     ++	}
     + 	sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2>/dev/null || true
     + 	rm helix-core-server.tgz
     ++	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
     ++	p4d -V
     ++	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
     ++	p4 -V
     + 
     + 	case "$jobname" in
     + 	osx-meson)
      @@ ci/install-dependencies.sh: Documentation)
       	;;
       esac
     @@ ci/install-dependencies.sh: Documentation)
      -else
      -	echo >&2 "::warning:: perforce wasn't installed, see above for clues why"
      -fi
     -+case "$distro" in
     -+ubuntu-*|macos-*)
     -+	if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
     -+	then
     -+		echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
     -+		p4d -V
     -+		echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
     -+		p4 -V
     -+	else
     -+		echo >&2 "::warning:: perforce wasn't installed, see above for clues why"
     -+	fi
     -+	;;
     -+esac
     - 
     +-
      -if type git-lfs >/dev/null 2>&1
      -then
      -	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
     @@ ci/install-dependencies.sh: Documentation)
      -else
      -	echo >&2 "::warning:: git-lfs wasn't installed, see above for clues why"
      -fi
     -+case "$distro" in
     -+ubuntu-*)
     -+	if type git-lfs >/dev/null 2>&1
     -+	then
     -+		echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
     -+		git-lfs version
     -+	else
     -+		echo >&2 "::warning:: git-lfs wasn't installed, see above for clues why"
     -+	fi
     - 
     +-
      -if type jgit >/dev/null 2>&1
      -then
      -	echo "$(tput setaf 6)JGit Version$(tput sgr0)"
     @@ ci/install-dependencies.sh: Documentation)
      -else
      -	echo >&2 "::warning:: JGit wasn't installed, see above for clues why"
      -fi
     -+	if type jgit >/dev/null 2>&1
     -+	then
     -+		echo "$(tput setaf 6)JGit Version$(tput sgr0)"
     -+		jgit version
     -+	else
     -+		echo >&2 "::warning:: JGit wasn't installed, see above for clues why"
     -+	fi
     -+	;;
     -+esac
     - 
     +-
       end_group "Install dependencies"


 ci/install-dependencies.sh | 59 +++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 33 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index d57dce5663..dad35db78b 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -95,21 +95,33 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 			"$P4WHENCE/bin.linux26x86_64/p4d" \
 			"$P4WHENCE/bin.linux26x86_64/p4" &&
 		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
-			rm -f "$CUSTOM_PATH/p4"
-			rm -f "$CUSTOM_PATH/p4d"
+			echo >&2 "error: could not install perforce"
+			exit 1
 		}
+		echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
+		p4d -V
+		echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
+		p4 -V
 
 		wget --quiet \
 		     "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" &&
 		tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
 			-C "$CUSTOM_PATH" --strip-components=1 \
 			"git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
-		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" ||
-		rm -f "$CUSTOM_PATH/git-lfs"
+		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" || {
+			echo >&2 "error: could not install git-lfs"
+			exit 1
+		}
+		echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
+		git-lfs version
 
 		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit" &&
-		chmod a+x "$CUSTOM_PATH/jgit" ||
-		rm -f "$CUSTOM_PATH/jgit"
+		chmod a+x "$CUSTOM_PATH/jgit" || {
+			echo >&2 "error: could not install JGit"
+			exit 1
+		}
+		echo "$(tput setaf 6)JGit Version$(tput sgr0)"
+		jgit version
 		;;
 	esac
 	;;
@@ -121,9 +133,16 @@ macos-*)
 
 	mkdir -p "$CUSTOM_PATH"
 	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
-	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
+	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d || {
+		echo >&2 "error: could not install perforce"
+		exit 1
+	}
 	sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2>/dev/null || true
 	rm helix-core-server.tgz
+	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
+	p4d -V
+	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
+	p4 -V
 
 	case "$jobname" in
 	osx-meson)
@@ -171,30 +190,4 @@ Documentation)
 	;;
 esac
 
-if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
-then
-	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
-	p4d -V
-	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
-	p4 -V
-else
-	echo >&2 "::warning:: perforce wasn't installed, see above for clues why"
-fi
-
-if type git-lfs >/dev/null 2>&1
-then
-	echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
-	git-lfs version
-else
-	echo >&2 "::warning:: git-lfs wasn't installed, see above for clues why"
-fi
-
-if type jgit >/dev/null 2>&1
-then
-	echo "$(tput setaf 6)JGit Version$(tput sgr0)"
-	jgit version
-else
-	echo >&2 "::warning:: JGit wasn't installed, see above for clues why"
-fi
-
 end_group "Install dependencies"

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
gitgitgadget
