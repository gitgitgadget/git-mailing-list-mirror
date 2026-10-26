Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008468;
	b=DT1HivTsKPxmuupJyJIuH4Dvs6JDN1ahARP6oBo21EVWGQduMkgbxKX1CayNq5RBxqbL
	 rNvXKTOO+sT40Qo5THC12B4vD8sjpioeO5SNGdAc0m9PVW3kEu3yZBDRK9/B1rq4FAXZR
	 30Ol0fX3Bzm/iqi3z86nSwxS1d2YkYmUyAcd2uySJKmHwd8XO+yroPA9lgyHShLmZ57JP
	 MeCCc3LPti0hboo2ZYQo2YKzlivx9v7mDsitG1NgwxjI3MCkFu7LcILIMpsGoDhHm0ao+
	 by7GbgKtGCCd95dQ+2Y6R4/qR2Okr8HUjZBslFdVzFjQMSR0jFBj/PNKHU5szufe5bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=zT+LQVev9eg722PAR6/YyfOsWktTfp0xkgCRgyEvE+E=;
	b=XyPW9K8i9oYLM1uJCenpfF+IFrz8t71wxEsriXn7rWUdr6HMNjIFDKH6ZQMa7wazU9B+
	 hVWhOqV9njyaJHTq+iEHTXGVjm3mtZuYhFZe+WjL9tFBzUD9BDSOxY0BtYSzZh2DlP5Yq
	 MDPrHjYH7Do39E4i5+JBFMriKGGU4M3ggWvkm2OLt+xHh/OAR9qMG7k0N/8pnYnXr2yWt
	 SZ/GcGSEGvEMW1jaGmAgytSsIdY9S0BuyE0DMc/YNt3vYjt1DqhdPw5xTWaVs4J4wRCPO
	 871VBQUq0zE0jNd26HvQQbjQTIx9qu65joWp7nFJUnbl2Ufw6tB29fae6UwB5VgTt8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QFz7ynan;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C1606A33A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A23C1606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QFz7ynan
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36681e85e87so282716eec.1
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 02:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008467; x=1793613267; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zT+LQVev9eg722PAR6/YyfOsWktTfp0xkgCRgyEvE+E=;
        b=QFz7ynanVR7xkN1NMfhrU1srn3pCIF7qXFb5uiWKdhqYPTcW7NbaZvYUMjzqzWuRJK
         tWPhF/b5rkXXvwdSdArgH25/oL/JwWGvvnpQ9gNTho60+r1GSZM8sO2wWDcNK7k8fKx1
         7MQYxAqDdl63+0gmI12QgJFzI1II8d5O1t/TGQSkTiLZtnJt5FbttgcmgrztSBwcxPmO
         cyajW6Z0/XzTq4cEi/AuowqHprseyoVWMs3xZ8tzKYY+YMk6YGCBFV5tPTUGkOdGv3W7
         2gYGrM7HnrTbSygj+dNuNJK0t4AaosV3r6Vx0XZvg2mni+M7QsHJwNTu/OFgYwfXd89+
         kOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008467; x=1793613267;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zT+LQVev9eg722PAR6/YyfOsWktTfp0xkgCRgyEvE+E=;
        b=P8vPxT9rgXN+cE6wvR+RnMz17PyXIMJ808KBl1lATeG1qg3aTj5tKCeeJhK0AVSfrU
         cNzwtWnGAmrq1eSG6O7o4q/xjqvjP4YZr3j4MEnsg76BSDec502Ie/Iuts+KY9/LkJvE
         /adJFcTiXexvyOfktI18Ewh3s+ZrWw05eYw+jNfRf0n6fD7Mr/mg48LNxoTGkCjAnElB
         zmCIdsaqAWXUNIqep6jmEqqFtExFRqDQeyEv00S+guUABvnjQclBjJef2nY2e7FfxPmS
         eMzzfkCFbxIxepcQu8puf5OVDogRO+QQiYHZzJjZchj5hC7Y1HPrCxs1o76Tc08ry10G
         8RaQ==
X-Gm-Message-State: AFq9FYKEMpOrxzQOph99OZzM+KxDf10u3nYQD66ZJOVYlpPXyrNQs/7y
	Az9MA0+WtaRxf2l+mrHDEYPhj1pMktvPZgNk0hZidB2rP9Wkjb0WYO39nvG2T3JLaS0=
X-Gm-Gg: AYBFou24C0PlMhMcsnOj03Wt608ax9iHg4SRsDGpqnTeUbkPO9bMIKDUO5jIquWD31I
	DyEcnOBHiSaJIqbdpT1aGjVP1GHc8jWV1XHkV63DJctUyqc+tTROnp/RQkzl0AmGFy67YAN0If2
	YwaIEoeepUdxDsqTOF+DLK017j6K7NgemPXC1ejwGr/Fq5Cqt6rU4GkZil66IblF8sXfZaJawov
	m6UHwBE/iZDe+9NdJqE46gjweoJ/fDXHHI6i7f4KiJUdlJsHN5ojU2dSAlc3Zq8IVh+R3VJPytl
	J448cXhHLn/4JKj5e8wSv7ZUO8f444TpOUqSaxQeNxdi72WAxB4KKU3TeiBDDaFkl1baJQtrTVz
	njVCjIrB039jq/v7rL+v0nwbuyXUu3D8fKyQjyUYWgTfwC3lSYYfXMhRwNZgTSQtAit1EgKxr0E
	aA81R/hLQD3MZs4cyZHHZA+7jF7gt6pIt206IGuoeqto+r76AvRilkIZn8DJz2o1nq1pDzf1bMG
	Q9TJokMVHYUusvWnkU4z8Rqp5CY1odPjzjfPh7Me37o+0X8BKrh5hLb
X-Received: by 2002:a05:7301:2f31:b0:369:d8e1:7bad with SMTP id 5a478bee46e88-369e84d7714mr9641979eec.34.1793008466520;
        Mon, 26 Oct 2026 02:54:26 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.98.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369f44bd644sm16241833eec.15.2026.10.26.02.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:54:25 -0700 (PDT)
Message-Id: <pull.2403.v3.git.git.1793008465.gitgitgadget@gmail.com>
In-Reply-To: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 09:54:23 +0000
Subject: [PATCH v3 0/2] ci: fail the build if perforce, git-lfs or JGit fail to install
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
    Harald Nordgren <haraldnordgren@gmail.com>

Fail the build when perforce, git-lfs, or JGit fail to install, and drop the
warnings that used to fire on every platform regardless of whether it even
attempted the install.

Changes in v3:

 * New prep commit drops the xattr -d com.apple.quarantine call for the
   macOS perforce binaries, it's been a silent no-op since perforce's
   install moved off Homebrew in 2022, confirmed wget downloads never carry
   that attribute.
 * Drops the explicit echo "error: ..." / exit 1 blocks for perforce,
   git-lfs, and JGit, relying on set -e (already active via ci/lib.sh) to
   abort on the first failed install, matching how every other install step
   in this file already works.

Changes in v2:

 * Perforce, git-lfs, and JGit install failures now fail the build instead
   of being silently swallowed. Removed the presence checks and warnings at
   the end of the script, dead code once install failure is fatal.
 * Version output (p4d -V, git-lfs version, jgit version) moved inline right
   after each successful install.

Harald Nordgren (2):
  ci: drop quarantine removal for macos perforce binaries
  ci: fail the build if perforce, git-lfs, or JGit fail to install

 ci/install-dependencies.sh | 50 ++++++++++++--------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)


base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2403%2FHaraldNordgren%2Fci-scope-optional-tool-warnings-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2403/HaraldNordgren/ci-scope-optional-tool-warnings-v3
Pull-Request: https://github.com/git/git/pull/2403

Range-diff vs v2:

 -:  ---------- > 1:  e85ce85d92 ci: drop quarantine removal for macos perforce binaries
 1:  dde1b38567 ! 2:  a57cfbb2a5 ci: fail the build if perforce, git-lfs, or JGit fail to install
     @@ Commit message
      
       ## ci/install-dependencies.sh ##
      @@ ci/install-dependencies.sh: ubuntu-*|i386/ubuntu-*|debian-*)
     + 		wget --quiet --directory-prefix="$CUSTOM_PATH" \
       			"$P4WHENCE/bin.linux26x86_64/p4d" \
       			"$P4WHENCE/bin.linux26x86_64/p4" &&
     - 		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
     +-		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
      -			rm -f "$CUSTOM_PATH/p4"
      -			rm -f "$CUSTOM_PATH/p4d"
     -+			echo >&2 "error: could not install perforce"
     -+			exit 1
     - 		}
     +-		}
     ++		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
      +		echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
      +		p4d -V
      +		echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
     @@ ci/install-dependencies.sh: ubuntu-*|i386/ubuntu-*|debian-*)
       			"git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
      -		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" ||
      -		rm -f "$CUSTOM_PATH/git-lfs"
     -+		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" || {
     -+			echo >&2 "error: could not install git-lfs"
     -+			exit 1
     -+		}
     ++		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
      +		echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
      +		git-lfs version
       
       		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit" &&
      -		chmod a+x "$CUSTOM_PATH/jgit" ||
      -		rm -f "$CUSTOM_PATH/jgit"
     -+		chmod a+x "$CUSTOM_PATH/jgit" || {
     -+			echo >&2 "error: could not install JGit"
     -+			exit 1
     -+		}
     ++		chmod a+x "$CUSTOM_PATH/jgit"
      +		echo "$(tput setaf 6)JGit Version$(tput sgr0)"
      +		jgit version
       		;;
       	esac
       	;;
      @@ ci/install-dependencies.sh: macos-*)
     - 
     - 	mkdir -p "$CUSTOM_PATH"
       	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
     --	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
     -+	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d || {
     -+		echo >&2 "error: could not install perforce"
     -+		exit 1
     -+	}
     - 	sudo xattr -d com.apple.quarantine "$CUSTOM_PATH/p4" "$CUSTOM_PATH/p4d" 2>/dev/null || true
     + 	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
       	rm helix-core-server.tgz
      +	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
      +	p4d -V

-- 
gitgitgadget
