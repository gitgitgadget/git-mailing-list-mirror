Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF1F39AD34
	for <git@vger.kernel.org>; Tue, 26 May 2026 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779814057; cv=none; b=gZHwf4cLx/sZox0l8YIpKL0I8w3uzGkmI/5XkSrVdats40rS4esTQtm95xpEUq72+5f3p5j3UevCn4uZJM1OfRb5Y7XwpSje2nUw97N4ztRawaSXEONXhIGjaD8QIfX/DkwIw3jNaZ19C9DeXR8LHGmNVS1Z8BBpRM9U0s+9j1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779814057; c=relaxed/simple;
	bh=Yw5nfYsf53EG+uABNd6GDJMpmS67kZjY+S5HgpWkQn4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cjDrzs51uiRh4DmE6pHJpB8aSXEh0tq1xh+ZGc7TYaF3wN6jqpnu9TYuE8pnkgFO+OqzoLvo3kKA0TcAzEwdUeSnHgO6HO8vWzuSB8ePvpm34rIWD7Itnr3y+CN0V3EVgV6p/hqIok8rSDFeLIrOaTfEJLP0pk/5P7Fk1cx+8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OoE4mbo0; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoE4mbo0"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8c92737a8d3so69535686d6.1
        for <git@vger.kernel.org>; Tue, 26 May 2026 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779814055; x=1780418855; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n82duB4s25VqXt9LPAMQyVZGr0bDZ324k++SKfNa/D0=;
        b=OoE4mbo0ALfHPN2mzrUyVMZriQgdAasM4keAFNd1X5QJ8yUjjfUIqY9EZX6YnzKLb1
         7Vo//oYLO0H2MyfvZQFf6S3POfBWTCA/z3oT/EhOxy8on3Zn+OXqHngisyyvkLZlgK12
         LF0WJ2rVbwBnsBWHmqaE4kPI4qU3YEPnIaRXUwpW142YqcfEx8anXAQqI/5O83v+sku/
         XGUQ+tagkYe8E4BN85D9PuZZyNLYXr6xbMGu4hi/d5D/xfDyBv3QiuGCMbIyrTTvd9Lz
         MzMqGDmftC4+cUrJYqrlpHp7ONHozltQCya+YUMiYj9PmXGQ/5sykvoBH7OIlj48UnFm
         Lsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779814055; x=1780418855;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n82duB4s25VqXt9LPAMQyVZGr0bDZ324k++SKfNa/D0=;
        b=KkNSrttnlfJNPdtWerCytmf43W08r81LZ//+7cUmGQB3hLkZ4HipkbvCI7KJ+uZRV5
         NSNvoc9uecjirmVG+93t0AOc7iha/AqNw1e6WTu9MLX02yMl7S8l/xdvPD+tP2oH+YWz
         qI3WNfo5mefVAgD/3f8hkGVAZUCRAR3dYsX4EoZHznlgaMkucaGSJvWADwq08I72hko0
         qSlzNZ4WAx7DVQobjJUCdubD+iJTcRf5vcGjcFJWcerqYu7CpgqgBWGc6rDAnrHPoPcY
         wQTOWAx2iz6SIquZLMHiZ3vU6InnPfVJkhUPbtz8kYHk2Z3lDhiPEqc6miTYZwHqB5B/
         Ocog==
X-Gm-Message-State: AOJu0Yzt5XAaW/Hgw4Ok51X7K7NppG1EA0nPgYXF6t8F8vhiaLx0z8Ql
	LR0yUn3j/hNpfw3wN+46bmMr5qRdJP9AxvorvkLvX0iOVJrDMRvsb/hbcnqhcw==
X-Gm-Gg: Acq92OENR9JMQnpIr0cBkQKGKVVgEBM92KlvsFq1UOy2j79TidSu1Hv0F6le1m5nT3N
	V9jJun81IqM+5tai82lKdonFspPQy6fwoVHdJKof67cwExPIeD1HgA/HHX1/a7KbzYRXA6soMtN
	LvNLevvLen84fy6G7Hv6NbEUnE7GCGe4sCN83nwCGYG6tz1bEbNH2oWHqz0qJf/eDmNOtBYuSXZ
	epTnbR/0aL3lrelPEz3Bob5NcWbr3Us76Qpcv5BLCaJExW4n5wzfEAZgbnDiyi2mlm8tKkduWvw
	h0WRyF4oG/sZPu8DOVX0Nf5pf7ADfmZIUC7gbGbMtiIAYBswRy0mNoHYCwql2SdIT/K3Zkhh9ro
	v7ud4vZaxpVShajlWXW10VUHqFXB8geebwpth1Wc2z5089YPAgZnIJlkHr+xtW/qCntx3rWbiGF
	u2VU9HMyxgwGAb8/nU58BPxdA=
X-Received: by 2002:a05:6214:401b:b0:8ac:b328:1314 with SMTP id 6a1803df08f44-8cc7b512311mr308008856d6.10.1779814054380;
        Tue, 26 May 2026 09:47:34 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.87.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80decd3csm145926836d6.12.2026.05.26.09.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:47:33 -0700 (PDT)
Message-Id: <ec2bdddf814e018c543d0e2bb393ae8c144207aa.1779814052.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
References: <pull.2122.git.1779814052.gitgitgadget@gmail.com>
From: "Evan Haque via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 16:47:27 +0000
Subject: [PATCH 1/5] git-son: add command to create independent child
 repositories
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
Cc: Evan Haque <evanhaque1@gmail.com>,
    Evan Haque <evanhaque1@gmail.com>

From: Evan Haque <evanhaque1@gmail.com>

Introduce git-son, a new porcelain command that creates an independent
child repository inside the current working tree. Unlike submodules,
the child is not tracked by the parent; instead its directory is added
to the parent's .gitignore and a "parent" remote is configured in the
child pointing back to the parent's origin URL or local path.

This gives users a lightweight way to spin off a related repository
that knows where it came from without the coupling that submodules
impose.

The command supports two optional flags:

  --inherit    fetch the parent's history into the child at creation
  --branch     check out a specific parent branch (requires --inherit)

Assisted-by: Claude Opus 4.6
Signed-off-by: Evan Haque <evanhaque1@gmail.com>
---
 git-son.sh | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100755 git-son.sh

diff --git a/git-son.sh b/git-son.sh
new file mode 100755
index 0000000000..a212c7b69f
--- /dev/null
+++ b/git-son.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+#
+# git-son: create an independent child repository that knows its parent
+#
+
+SUBDIRECTORY_OK='Yes'
+OPTIONS_SPEC='git son [options] <name>
+--
+inherit    fetch parent history into the son
+branch=    start the son from a specific parent branch
+'
+
+. git-sh-setup
+require_work_tree
+cd_to_toplevel
+
+inherit=
+branch=
+while test $# -gt 0
+do
+	case "$1" in
+	--inherit)
+		inherit=1 ;;
+	--branch)
+		shift
+		branch="$1" ;;
+	--)
+		shift; break ;;
+	-*)
+		usage ;;
+	*)
+		break ;;
+	esac
+	shift
+done
+
+name="$1"
+test -n "$name" || usage
+
+if test -n "$branch" && test -z "$inherit"
+then
+	die "fatal: --branch requires --inherit"
+fi
+
+parent_dir="$(pwd)"
+parent_remote="$(git remote get-url origin 2>/dev/null)" || parent_remote=
+
+if test -e "$name"
+then
+	die "fatal: '$name' already exists"
+fi
+
+mkdir "$name" || die "fatal: could not create directory '$name'"
+
+if ! echo "$name/" >> "$parent_dir/.gitignore" 2>/dev/null
+then
+	rm -rf "$name"
+	die "fatal: could not update .gitignore"
+fi
+
+cd "$name" || die "fatal: could not enter directory '$name'"
+
+if ! git init
+then
+	rm -rf "$parent_dir/$name"
+	die "fatal: could not initialize repository in '$name'"
+fi
+
+if test -n "$parent_remote"
+then
+	git remote add parent "$parent_remote"
+else
+	git remote add parent "$parent_dir"
+fi
+
+if test -n "$inherit"
+then
+	git fetch parent || die "fatal: could not fetch from parent"
+	if test -n "$branch"
+	then
+		git checkout -b "$branch" "parent/$branch" ||
+			die "fatal: could not checkout branch '$branch'"
+	else
+		git checkout -b main parent/HEAD 2>/dev/null ||
+			git checkout -b main "parent/$(git remote show parent | sed -n 's/.*HEAD branch: //p')" 2>/dev/null ||
+			echo "warning: could not determine parent HEAD, starting empty"
+	fi
+else
+	echo "# $name" > README.md
+	git add README.md
+	git commit -q -m "Initial commit"
+fi
+
+echo ""
+echo "Created son repository '$name'"
+echo "  parent: ${parent_remote:-$parent_dir}"
+echo "  inherit: ${inherit:-no}"
-- 
gitgitgadget

