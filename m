Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089945;
	b=PwVJhZDR2nEEi0VNxMUX5sFf5W0aggHoUDqIFV7bf1qqZU2Ngr9XxiLVImNpRSZuqLNp
	 de4Mc8+1Kjl7KnwAhhlRK9vzDIHrae29XZTGax+ymnslQJn/q2Cn5lGljhM7H07E8C8AP
	 9o+e5Ue/miXsZdkTf0WoJ9S2uvdIPUZ3k/HrAVi0XvLmbXDXqi6lGckMremwpjifbGJcE
	 wbwMC3TNb3smAIk8BYPe0//aHXzUCI5xikQ55KlwOpTffIo5n5uKYz88JxTVgWOswhbcQ
	 KrquEun2kwZCTwDquOXrGSXSejerxi+DPrWrqkejrTShW582uI3SYmcswXWmq0QqpVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=gGQSou4rzbfBW+tGvx0YAJrvDaGM/kc21PsAtAPjW9U=;
	b=IOZ6j+Hwz67KKuYv7GyLe1FdVNEL+WHGKQHJNBaqjBMLa56lZDBur+9bf5uZmvwA+Efd
	 Iam3hb1v43YiAdJp9R0szr3avxnEIecASO9oX7fjmG8EtWUA3ptW3z6ycY9D0uL6YMqwt
	 +PEcLlkFvvg4pGN3xVGsyzFRllgzGPtSGwdjFpkBsm2VFOBgMTCTT6zRQlxlXrJcTfkqK
	 HMjWUnXExt8lHaXATCx0RdY6X6ZosSZ1XQoVp19b8/yFxmLpWVl2NUzixBLclSJtFoXdf
	 2wJMHNDUwTgYKm1VPKdC7eRtQPLwhAHD61hlfOeR+RuGRsvrZhSUNs3N0NGoI7G3mQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pmPjMm6K;
	arc=none smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4E2606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D4E2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pmPjMm6K
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so2810606b6e.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089944; x=1793694744; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gGQSou4rzbfBW+tGvx0YAJrvDaGM/kc21PsAtAPjW9U=;
        b=pmPjMm6Ka4tlL0pJ+grlxw9kriyP3WPYf5TjjgxEm2WC3TptABTghLxSe0pU7CD0Ol
         TQMDfXJc9KJSCjdJnEFSwx0dvL7iM61tHk2EvME9FmwavNAQDChoHaDXdl3sHfyRUZh8
         ybY3+v0J3sJPtmf8K8PIBciL1v2kZIuwp+XljkdxFMs+PfmOjxmSSSTAy3CG5HF2ynvx
         1VEdphAixYostDrmfJCMznOs4XX5YKl2Bm+FoLVeUakr5YdeRZTwDCBTmF+lKPAhDa24
         8hpM25LJtyvDRamhGqmCaqqtb/zCtxc9ImfkdrtdVDYxGfqZ3cUjgAie5X8aqP8Yfl5S
         FRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089944; x=1793694744;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gGQSou4rzbfBW+tGvx0YAJrvDaGM/kc21PsAtAPjW9U=;
        b=WQ6gymTHIE2IwU5Ehhoq4R80PmaXYDrRFmLDEbILEim8n5GuZpWpV08xBgOHc+KpZE
         9ZlcCP4ZuSGgy7m22pJMd4XPvK/v1jIehdoJ5SI+jems5PVTxCzKhaXV11F9eeMBCKTh
         PNcz1mTN2pMIxaQJ3TefLjKVWYfsdrDMWrFhYmCl+mbliDCYoC/fId9orIvjitwTst+l
         MVE9gYjxP/5nmDN1ZC72dohN6C9vLSOECIYKhGVVHbVnd99orQNPdwFx4z3opz4myFkJ
         Sv2Mu+BUfG+kfs+PUazIS/p6zjwTYlSgtdNzLbQZw6UzzNNhIEFCmUN9qPLDHZsFUqNH
         YbPQ==
X-Gm-Message-State: AFq9FYIkS0hMgqT324QjTTmFSaXMN+53Jwvzq1qlg45OApeYBhTFj8mq
	YM1lizayMGRMmXqm6L/96XkbkWg+nQkXyU/H4pzmYoSPNV6d+Y1kTvAK23CGkhNf
X-Gm-Gg: AYBFou0/GtLRYbpFePdWtB4cT1Mnwv6LtytLg8dFhn5rljWZr6zNDP3H00Om8tbhhz5
	NOgiJs046Tlhkr4W/A4kRcxymVmW7NUOzKE0D4gTuDm6JKIF/SAC6WlkcP3D8/XGgVdsAMB1Msu
	wFUaH2HL+OA93cRtAc7sgru1p79Kx+4SXPryZ5o/xXuJKdhhuyHfx2ZuepY0gd8xlTNSEJRXeBF
	8fMke1Bf/n66C1N54+GqhtV2htNQxLHn+GA/WwlOHINUeV3sl1Y24k2Tv4YqsDNAlhiBXk+sX9i
	lXST8jPqD7gxtb0bdEd40qr076AkMAe6jUH6E5M3NXb3KSxy1tolDH+xbbUFV5KJ9JoF3xIbpPB
	NNC61KLO5MtfGwnXEHKAzPHDUHG24/kAYjzsMWiWb1lwna0UztMSy2vIOYetT943daLbVZW1WaM
	ZTij001i2rKyf3VtRIzfduyVfLGSyFD8NRHpJLtmnf/FkXtrwgVl17IRGBQNyd5Hoh4978QogRp
	8JBxEOTD6youYfVQD8OUGFecOpETZ43c1K11mToybxjJHvv99eEcvlplPg=
X-Received: by 2002:a05:6808:2383:b0:4f5:c4b9:dc14 with SMTP id 5614622812f47-55c0026cefamr5928120b6e.13.1793089944384;
        Tue, 27 Oct 2026 01:32:24 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.36])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0429c932sm7409531b6e.7.2026.10.27.01.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:32:23 -0700 (PDT)
Message-Id: <c6dda879aadf5255bf4601f4a96d91e22e72316e.1793089936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2403.v4.git.git.1793089936.gitgitgadget@gmail.com>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
	<pull.2403.v4.git.git.1793089936.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 08:32:16 +0000
Subject: [PATCH v4 2/2] ci: fail the build if perforce, git-lfs, or JGit fail
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
 ci/install-dependencies.sh | 63 +++++++++++++-------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 203e8401cf..d35c64102e 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -93,23 +93,26 @@ ubuntu-*|i386/ubuntu-*|debian-*)
 
 		wget --quiet --directory-prefix="$CUSTOM_PATH" \
 			"$P4WHENCE/bin.linux26x86_64/p4d" \
-			"$P4WHENCE/bin.linux26x86_64/p4" &&
-		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
-			rm -f "$CUSTOM_PATH/p4"
-			rm -f "$CUSTOM_PATH/p4d"
-		}
+			"$P4WHENCE/bin.linux26x86_64/p4"
+		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
+		echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
+		p4d -V
+		echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
+		p4 -V
 
 		wget --quiet \
-		     "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" &&
+		     "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
 		tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
 			-C "$CUSTOM_PATH" --strip-components=1 \
-			"git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
-		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" ||
-		rm -f "$CUSTOM_PATH/git-lfs"
-
-		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit" &&
-		chmod a+x "$CUSTOM_PATH/jgit" ||
-		rm -f "$CUSTOM_PATH/jgit"
+			"git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
+		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
+		echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
+		git-lfs version
+
+		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit"
+		chmod a+x "$CUSTOM_PATH/jgit"
+		echo "$(tput setaf 6)JGit Version$(tput sgr0)"
+		jgit version
 		;;
 	esac
 	;;
@@ -120,9 +123,13 @@ macos-*)
 	brew link --force gettext
 
 	mkdir -p "$CUSTOM_PATH"
-	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
-	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
+	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz"
+	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d
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
