Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089940;
	b=5kfOU1luMq3lVMpSvMvqS6x1D4DSaSH3agEeomb/0iXhsrI3p0IyYaQG+Fj69ozfd7o/
	 I/LCbEqF3M8ndIjyVnvPNfyaUlM7OCslnrsAtXIDd+VeUbWpUyByUCGrogjAzBCCMs5ZZ
	 LKAvG0VOo+kr+qq9AAhljHgkX+3bMETEdrNmF2YnAYY1LJVXg1c33lyT2Kt0S8tS4Q2iZ
	 7Tu4j193OsAUYJPa5wIEp88kMSiz4L/swEWdKT5jOJXa1UQkaGhH0YU+83RuoXd29AJ4o
	 SCVLgEd+qezE3gTgDFBXksu8jeW4yZdo/jYii0CGoqqFALfow2tOyIc1OND6gIq0fKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=e7jlbb9rIEqQmZb5UXclylIfYFAvjy1Gk3cm8kH0SI4=;
	b=SBWMJbz06SCci2oZxECSrFXlLOJJnJaSaRU9kHIWkudBqCNWlnUlqTKQ1RghjdQeF/Lo
	 890wfqWmUKHYK7tNDG8t5rM7vArWfPp5lhyQv7+NCpneYMrRqLmLPKECJHiaMDZv9VDwa
	 GbFNBZuo9PNbYnmhETuKbAdsj5w3ndaB6whLj09n/J2210hO/DdjJSmzqCew8YtiLVKfA
	 TiSPc/C+9TIE6cT6GBWjoPFyaZnsdEKXvlInVuUC8PpPWU6RCPmWWl2JHGueShQWBJDaL
	 IZkm3z0skIYX//U2hK4wmkZAFA8MxWeANdS1KvB/KFQZaKBk606+Zy7w4YYbGoM6tSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RgrcoBOP;
	arc=none smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F074606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F074606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RgrcoBOP
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-706113e92f9so2259467eaf.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 01:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089939; x=1793694739; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e7jlbb9rIEqQmZb5UXclylIfYFAvjy1Gk3cm8kH0SI4=;
        b=RgrcoBOPpV3HAyrQeKJUgRbX/Gw2IKVh7uNzOrD+cVWoBBZ+cmBLUoXymWRG0Wy6KQ
         8oqVouccWMlarxktIeUovZJd+W+j49DiJbbzZK3O58pQuRoFIUAPrtkqAg4N5+yhDLGu
         xcbbmmdYML1Ux1j7FMH+WyJqbfrfmkhU/UDS25nCuK2vau9+bax2dRmkdA8QSS7T9rXd
         3w96C9Bl4z8nw+i5mIKLpZJzj3TeUZa8M7AAvprnvFKO+Ck1ob7rC9rLu1PuS3rdfCKG
         ogdoDrDpJUMdhU9b/zGf4Fn5TtcWLWU5T3odt9G4myMfih5Q9kGG4JaLvdVur2JQYGz7
         hDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089939; x=1793694739;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7jlbb9rIEqQmZb5UXclylIfYFAvjy1Gk3cm8kH0SI4=;
        b=ulco4+4FsS0H19WUsBNUcsFaSNUq9unvScSByb8el37oUhKeyOT+jMV9em4ZYoUc6M
         AxqSrHmMzDd/oktKivUTuqn+8T0WfC2Xnvma+ngJdB58aW/JQfJzTU8EsRjfO7/ALRK0
         vIh6iDltiTVykSfWl/YXraxQXGIwC8C95M1jJLXaXKtrwgqDdCxt4rZFVO5OUOn1QB8C
         DXqu/VzDg+shXb/WMihfUP36Lu2eQyIRcMD83xInttjgrBl/iHecetFnR1g3A3Ctgr6H
         UyOUo7qsPfAS7u9aanRnvHswug2uaVoUIb/+XElkhbDSOzksG95gMIVFNG1aIvsT8iVm
         s7RQ==
X-Gm-Message-State: AFq9FYJka5zXcKevvPk0pTLNL6EqUmP7Oid5lXIZHae5cM7L/zlRBEaK
	N9vc3Tg6isTXI13+mX39AFtmVkfc7OPbHymwn3CefKBW+mVJQZtV3F+Ly6T+HnUi
X-Gm-Gg: AYBFou2uezTHMmoIW4tB4HbNfvL1UsGsQ8Rl2imwyaQZqPZHda551Q3NImY2llqqM+4
	SgUVqV9+zJhaE+prX2HazR6KGSudbFPZoA+xxN72kH224SxEhzSF8L/JCZo4QjbQnfzEW5fuIyt
	AOoPz0zrKt2iwI0qOvFH6UWN6p/hCIK7/Jzp1oD4UO6Q+0+v8oRKLUaou17k5IV6kTFE4cyKKnr
	lkC9Bn1LmVwVlhoThg7ZTpaVgeTuKqHr7cGV1G/jwmpmLcmZhHSIxa4sTehJ4Qumcv4DMSPmrq9
	IabnBQGsOvuEp1dk/m1KvfEYWyBVkJmVSQjopMB6fie68kHXeFQTXkIKfVTzDm7MTbEooikntRK
	4Gf12pChD9msVxbwgaVlT3qpWKKYVqwkhB6xcuPN/FUe6439VpIGGjmjoW/JJjiMU5szMpyIKY/
	eBe6RFZ0Og3Ef+0aol0VZl8Jpo0Olq93ASrSef3llOamxxPzz5/J259qWbsX+BT/1U7mqdKvmB5
	w90HtPDq7SPBzHUMlLkd08w/Uc9aVzHh0UU1+Gi6IlDzv4suUMdqWZ2DHQ=
X-Received: by 2002:a05:6820:7099:20b0:708:d037:c504 with SMTP id 006d021491bc7-70ba0e12c28mr3379036eaf.31.1793089939148;
        Tue, 27 Oct 2026 01:32:19 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.201.36])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a843225d69sm6259556fac.15.2026.10.27.01.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:32:17 -0700 (PDT)
Message-Id: <pull.2403.v4.git.git.1793089936.gitgitgadget@gmail.com>
In-Reply-To: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 08:32:14 +0000
Subject: [PATCH v4 0/2] ci: fail the build if perforce, git-lfs or JGit fail to install
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

Changes in v4:

 * Drops the && chaining between the wget/tar/chmod install steps for
   perforce, git-lfs, and JGit, since under set -e a failing command inside
   an && chain is exempt from aborting the script unless it's the last one
   in the chain, so the chain was silently letting an earlier failure fall
   through instead of stopping the build.
 * Reworded the quarantine-removal commit to lead with the observation (the
   call does nothing and can go) before the history, fixed a dangling "this"
   reference, and added that the same holds on GitLab CI's macOS runners,
   not just GitHub Actions.

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

 ci/install-dependencies.sh | 64 +++++++++++++-------------------------
 1 file changed, 22 insertions(+), 42 deletions(-)


base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2403%2FHaraldNordgren%2Fci-scope-optional-tool-warnings-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2403/HaraldNordgren/ci-scope-optional-tool-warnings-v4
Pull-Request: https://github.com/git/git/pull/2403

Range-diff vs v3:

 1:  e85ce85d92 ! 1:  c1ee3fcb7d ci: drop quarantine removal for macos perforce binaries
     @@ Metadata
       ## Commit message ##
          ci: drop quarantine removal for macos perforce binaries
      
     -    A file downloaded with wget never gets com.apple.quarantine set,
     -    only Safari, Finder, and AirDrop apply that attribute through the
     -    LaunchServices quarantine API.
     +    The xattr -d call that strips com.apple.quarantine from the macOS
     +    perforce binaries has been doing nothing for years, and can simply
     +    go.
      
          5ed9fc3fc8 (ci: prevent `perforce` from being quarantined,
     -    2020-02-27) added this to stop p4d -V from hanging on a GUI
     +    2020-02-27) added that call to stop p4d -V from hanging on a GUI
          confirmation dialog that never comes on a CI box, back when perforce
          was installed via Homebrew's --no-quarantine cask flag. When
          49af448197 (ci: reintroduce prevention from perforce being
     -    quarantined in macOS, 2022-05-12) replaced that with a plain wget and
     -    tar download, it kept an xattr -d call as a precaution while noting
     -    that call already does nothing on GitHub Actions. It has been a
     -    silent no-op ever since.
     +    quarantined in macOS, 2022-05-12) replaced that with a plain wget
     +    and tar download, it kept the xattr -d call as a precaution, while
     +    noting that it already does nothing on GitHub Actions.
     +
     +    A file downloaded with wget never gets com.apple.quarantine set in
     +    the first place, only Safari, Finder, and AirDrop apply that
     +    attribute through the LaunchServices quarantine API. The same holds
     +    on GitLab CI's macOS runners, so the call has been a silent no-op
     +    everywhere since 2022.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
 2:  a57cfbb2a5 ! 2:  c6dda879aa ci: fail the build if perforce, git-lfs, or JGit fail to install
     @@ Commit message
      
       ## ci/install-dependencies.sh ##
      @@ ci/install-dependencies.sh: ubuntu-*|i386/ubuntu-*|debian-*)
     + 
       		wget --quiet --directory-prefix="$CUSTOM_PATH" \
       			"$P4WHENCE/bin.linux26x86_64/p4d" \
     - 			"$P4WHENCE/bin.linux26x86_64/p4" &&
     +-			"$P4WHENCE/bin.linux26x86_64/p4" &&
      -		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4" || {
      -			rm -f "$CUSTOM_PATH/p4"
      -			rm -f "$CUSTOM_PATH/p4d"
      -		}
     ++			"$P4WHENCE/bin.linux26x86_64/p4"
      +		chmod a+x "$CUSTOM_PATH/p4d" "$CUSTOM_PATH/p4"
      +		echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
      +		p4d -V
     @@ ci/install-dependencies.sh: ubuntu-*|i386/ubuntu-*|debian-*)
      +		p4 -V
       
       		wget --quiet \
     - 		     "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" &&
     +-		     "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" &&
     ++		     "$LFSWHENCE/git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
       		tar -xzf "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" \
       			-C "$CUSTOM_PATH" --strip-components=1 \
     - 			"git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
     +-			"git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs" &&
      -		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz" ||
      -		rm -f "$CUSTOM_PATH/git-lfs"
     +-
     +-		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit" &&
     +-		chmod a+x "$CUSTOM_PATH/jgit" ||
     +-		rm -f "$CUSTOM_PATH/jgit"
     ++			"git-lfs-$LINUX_GIT_LFS_VERSION/git-lfs"
      +		rm "git-lfs-linux-amd64-$LINUX_GIT_LFS_VERSION.tar.gz"
      +		echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)"
      +		git-lfs version
     - 
     - 		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit" &&
     --		chmod a+x "$CUSTOM_PATH/jgit" ||
     --		rm -f "$CUSTOM_PATH/jgit"
     ++
     ++		wget --quiet "$JGITWHENCE" --output-document="$CUSTOM_PATH/jgit"
      +		chmod a+x "$CUSTOM_PATH/jgit"
      +		echo "$(tput setaf 6)JGit Version$(tput sgr0)"
      +		jgit version
     @@ ci/install-dependencies.sh: ubuntu-*|i386/ubuntu-*|debian-*)
       	esac
       	;;
      @@ ci/install-dependencies.sh: macos-*)
     - 	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
     - 	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
     + 	brew link --force gettext
     + 
     + 	mkdir -p "$CUSTOM_PATH"
     +-	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz" &&
     +-	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d &&
     ++	wget -q "$P4WHENCE/bin.macosx12arm64/helix-core-server.tgz"
     ++	tar -xf helix-core-server.tgz -C "$CUSTOM_PATH" p4 p4d
       	rm helix-core-server.tgz
      +	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
      +	p4d -V

-- 
gitgitgadget
