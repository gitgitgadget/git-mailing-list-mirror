Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008471;
	b=Ki7EiFkin8ozOEZL1VBSg+vghbNffe8aqvFRVWgFEn46xTPrKsBFfsJfpFwY1Pk9UGxq
	 ojPZRuM/eR/e0duhzX1vIicP9tx5A2nhuWhxAvUQmzKqXJSv8TQzMouyUGbd7M9UzVxEh
	 5QxF3qEsydJdlrEXaRoiu4vQEgVGh3VYVdjdvT4TzZHLco/svI8oMOot54KZXgS7yxDcq
	 9lS3ehGioD97RQKQN4qCv3+oG3ctDaFrHuvFQkoM9cIbdHcTunDqP+KDDvdgoW8snmQK/
	 J+cp+t5dOGyEieu/DcVt6I8CkD6aUX5d11qipamNIlO0VW9M23ZF8q5YQSjP96jt7lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=Ceeb8/TTt1kL6Wy8qFo4jmEj65d/ZM96TBnwNqn1GWQ=;
	b=MCW9tVSt6sA7RCWBiNo1tDwWl8W6aORQz3lZWdWF7dTibA9iqzKB12YetvoeLoofVNsG
	 axZ6CSzJzNxO+b5066FBR8toI791xjJowDFTY1lxFOKW3OLW5ILwc/b5qFFeQ2wy4ap0m
	 +KPG3QMOXWGe+jKFc3PnZTQXKAn9fErt6ue0al5fPFWmOkI5Ms0voGJpvElYxKWQp0kXh
	 XKSexeYuT8ytjbaVRlTILmGviUaRKQaZrCnDITtolalHhoVUca6MI8LVsnUlJMNvaM/kG
	 PYz7wTNngLvMU0myV5WFA5JOUrXgHgBmkWYmieQzhrUuHX5z7hws+6mqQ3eTFoWRe1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OPx23kAM;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B6960A260E
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B6960A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OPx23kAM
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-156cbe59622so1999775c88.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008470; x=1793613270; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ceeb8/TTt1kL6Wy8qFo4jmEj65d/ZM96TBnwNqn1GWQ=;
        b=OPx23kAMX4gfWrlz23PZrU/3NPTfReFjsO0FHCSFNHBlpJcZ3QCaWTD37EtiqFC6Ph
         Oqqvw8hQsHZdfdH7piyuG2iqkw1wRLzsBcKXWY6MNa0dRX7veB7cj1rplxW+PjwxPpKG
         83jiEUuCXtB3ZTnzLk3IJJ2UKktLZgW+lukiuRn/fQuBUEyWy1+p9RoiSmMnu/PW6c9D
         ah1x4sbMNEt5iAd1QmePR2yqzKue6OuXKuZuEQw2j0gfykNfWskrCKoWpqC+d7QZ9ZFT
         11WWumn49ovCrnPE7H3q8/jGgrXLfeM+2NXP3Ww2koZbds92ZPIErNfNtc6QsRNiRNls
         X23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008470; x=1793613270;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ceeb8/TTt1kL6Wy8qFo4jmEj65d/ZM96TBnwNqn1GWQ=;
        b=jj2cd663ov1E6Cl9hqNo3fB0Ftp6sVvQX+NFqBWagbfNJJaiCk1/Rr4476ZsAFqzk7
         XBYMTm2CzVLREB8kCBJPLTakmqQnTEoMGYRq7oB0frX4ln4H02x+fA4AR1bnoKn0YMaS
         G/9LUh5HR01tlMXx0dY/uhqdnW3J/lTZItWEivtcrxGBK37SEtin2/7nAiR9Lst7REzS
         sJ+h5sz4eIkvPt9LT+SqlhzsYdSVt/VhCjwLm1KzefgcZLLqnHAY9IGiE7OETg+jlaUl
         7+NmwWWrV78EkcQvDMtthCO+5VrlCCGNX1RXtEzQRbOMYCr14gG9+jauOnNm+mj2qapq
         5iGQ==
X-Gm-Message-State: AFq9FYI7/kdbWfFd0kqwoslkhtbmrvejmSuOfSSEK4YkWTtJr2d56hfs
	T+NnXaH+5tHaGntiVk4N/pyUQf6DI+6ESXpuBLa0PSvqDX9MIvbmmAxVwrH3zfZAGVo=
X-Gm-Gg: AYBFou1kPYqZNzSKswIx753NnzWD9zRiIsMU1Hks+ByHtIuPLHKEpk+BxRJBpbvmvMz
	gm9yoRc+emjY2x2my4CR8Lyt0paZ4UWTtT8AWD1FlEyUpTsLGVM5f6KVOXXAs9dAx8S3J2ZOLGb
	a2qxxHqsER/OoW2vNczGqtT7Z0sxHa+/I4blidCIuCVs3qc+LPLrO13PN2w8rnfiap/Spoj4Jm7
	EnWSAvmJJEunyKsf4FskVsBi9JgHRTvPtWzOCJ1rgKxf0/VHcP8+SRasbwBEaVJ+xRK/KZuwqkl
	uD2Gkbq7Q5+ngbywsvU5K15N/ruX6Wl7U9byCqAgxL1WZcKxs8kyM2xbIUN3CLQqmwKc7HSgFSP
	Y0t9PjEJMsy+m70fG4O+z32jPsZ/NgNBwrCtSZ7vfa2f9vCozMosbm5kkZ0i0L2FbBhn1Wtl/Hr
	wOCCu0stwxuw8ariswSuGMafNZmbOHhc4a6Ksep70Iw2BNjnG6X3XnUCvoJUagwDkHlGYW2624/
	lxSpjuSbEm4W9YKHtEp2TIZD/eiltV5+PWekWm9MxfggWKUoNp9of9i
X-Received: by 2002:a05:7022:b057:20b0:19a:ace1:793b with SMTP id a92af1059eb24-19aace17b02mr9018114c88.18.1793008470185;
        Mon, 26 Oct 2026 02:54:30 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.98.33])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19886f790e4sm22962515c88.0.2026.10.26.02.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:54:29 -0700 (PDT)
Message-Id: <a57cfbb2a5c0f34e44595c3b688b18c760258685.1793008465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2403.v3.git.git.1793008465.gitgitgadget@gmail.com>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
	<pull.2403.v3.git.git.1793008465.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 09:54:25 +0000
Subject: [PATCH v3 2/2] ci: fail the build if perforce, git-lfs, or JGit fail
 to install
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
 ci/install-dependencies.sh | 49 ++++++++++++--------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 203e8401cf..7c3c6ad434 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -94,22 +94,25 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 		wget --quiet --directory-prefix="$CUSTOM_PATH" \
 			"$P4WHENCE/bin.linux26x86_64/p4d" \
 			"$P4WHENCE/bin.linux26x86_64/p4" &&
-		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
-			rm -f "$CUSTOM_PATH/p4"
-			rm -f "$CUSTOM_PATH/p4d"
-		}
+		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
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
+		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+		echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
+		git-lfs version
 
 		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit" &&
-		chmod a+x "$CUSTOM_PATH/jgit" ||
-		rm -f "$CUSTOM_PATH/jgit"
+		chmod a+x "$CUSTOM_PATH/jgit"
+		echo "$(tput setaf 6)JGit Version$(tput sgr0)"
+		jgit version
 		;;
 	esac
 	;;
@@ -123,6 +126,10 @@ macos-*)
 	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
 	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
 	rm helix-core-server.tgz
+	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
+	p4d -V
+	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
+	p4 -V
 
 	case "$jobname" in
 	osx-meson)
@@ -170,30 +177,4 @@ Documentation)
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
-- 
gitgitgadget
