Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3F357D09
	for <git@vger.kernel.org>; Sun, 31 May 2026 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780268589; cv=none; b=s3B03eJgzuoB2/MxdW/BOSv6/Lf3f3ivxOk/SSotdGgWQY6aX3VSDENo8hIbmrDsE7ayL2ucOgVh9PLZ0Xj2arkN4xbMee+/9ako3xdvuneOFmKe3g2e+U/AAH+AleuN2x+qKMLLQ6CF1ahYB/p68jaZNS2rYs2i9eExiCa30u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780268589; c=relaxed/simple;
	bh=buO1usrY0lNiRbZ8y2a0527oeNyCJvhfLWEfo1NeMeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TtCBVQ6Siy/AA6n5iV2LX3xesDY7qXpL+tIS/phLycpkWsFsVpYWCmz+Dpp7/EOtExU1U8QTKYAJGxiELujPVtWcRWo/MdbNRQPWKAYBz+k2HzDrsRto/nGtNXsrE8DONtLvNqTnCXrq3mO7IUXZH3ZFgXT1Dlg5sqv/l8whtLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQdI7bTK; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQdI7bTK"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5174a132590so9748601cf.1
        for <git@vger.kernel.org>; Sun, 31 May 2026 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780268587; x=1780873387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRlW8JTU82FDrHWK2AZErccG09tGi9CMwMTGibzMUdM=;
        b=SQdI7bTKnFpkxNFRL/PSr8b0Gv4wW6X2X+rTtibCXywMkEnrTm0GAZLDGJHsWJvvt9
         gCJUoi2nO4zVSpE+Yo2+9vujeaotFefSInx85DbPSNyvet3PHf1m3f65q5OBpU5MCl+p
         7zt2o9Tu4BPEa/OyiPlAQiGZ4QvMYUmHprREkbQM/NiAIji3TPZLpG5k3LKpjpuXm6pR
         IQK+6m/yGx1cN3dOFArd17Rc9UiLIF1gujVBWS8JZnJNk83549Pjr2VLVCmGhd91SNMF
         AnmGLLLnb9g22uqCvhpkrOknmTt+r8mgLxAAhPsHgqfCCN6C7SVzBkpAc25W4iZf/k8d
         BBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780268587; x=1780873387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LRlW8JTU82FDrHWK2AZErccG09tGi9CMwMTGibzMUdM=;
        b=QVLFTi9VSA2tcnFOVB7XVqJjBmb3LuxC6L9HV4ka92xYZSFke9Z0lQRUmKkmHyzh8n
         t7g5IPVgRKLywxA1hxaXbblRxBD7U/ZvMj8ceZ/kb0zPFt9yED1MnjzOp57SG3N4aMpf
         07gQOEThTGMLPWtGtjxtisvESW7BvTm5b9prHagKgJLFe9iKc1NvLWXn6a1lm1sRE/6Q
         gbv3u2cdyG0ubz/RbQ7ry++s/+2VDECWurAKekhcxe3POHFJps3q/KySSX8l9ZMjkNoX
         ZSPEu7AewY4/ZLQUWGO7ab4/XXJD77YhjT6ICavB9FVwNyzGC4PHj52sXXCgf+va2jGx
         gfpg==
X-Gm-Message-State: AOJu0Yz8zj0jp8ynPpODnkOdvEdNmPsYqxs0e4vA/nCy3RNCrQhq6cdV
	vczckqojR97KK+zOuEJnAFy/00JSPsiUq+0EsP+LlCaTGSbaNPpWk8ZVa2WEe32g
X-Gm-Gg: Acq92OH9AnkHmvLcqvHlx/CKgawy9KpbWSJR2DzVKMjODe5IkQ6iuFz31AeqEgz2muH
	ch6+yTjbf6bMG8F0NscYmoqK6bAcoE4nLulvUvRNgWaEeclMRalOYMf2PuYZnYJ81MphpQ434ma
	2osrmznKr7z1Cs41tRXz0BcdaAVPRv/lW/MrVgMDkLmKD2uov51Bb7M2ZUfzGgFDCAVkCl8KFUr
	Ci3bJ4jXTLw0WaiYfn/U96FwZuwH2V+A1Jofqy7Q5D0t/gDKrI9hqZ8Qx+wPI9winmdItf439PS
	T5K4exLjO37NpSFGz6zxU23SYhF33bapnz+oe8Cj3cfU8ldL14Fz5NHJK0f4+/NqRHQAdYNKRkE
	b/U/GYp5vObEHzPBargYGJwpRUb5k8wrmzECnETiH9l2iS7h9GJSbk+KQPXehWMcR8ABX0lTmfk
	e80fkhHeVd0SRRtDeARITLfIdyVLbBHsvLq1Qr
X-Received: by 2002:a05:622a:8348:b0:50b:526c:541c with SMTP id d75a77b69052e-5173a822969mr98780581cf.50.1780268587271;
        Sun, 31 May 2026 16:03:07 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm78268426d6.8.2026.05.31.16.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:03:06 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	egg_mushroomcow@foxmail.com,
	bootaina702@gmail.com,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v3 09/12] git-gui: try harder to find worktree from gitdir
Date: Sun, 31 May 2026 19:02:22 -0400
Message-ID: <20260531230225.126817-10-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.54.0.99.14
In-Reply-To: <20260531230225.126817-1-mlevedahl@gmail.com>
References: <20260520202411.108764-1-mlevedahl@gmail.com>
 <20260531230225.126817-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-gui, since 87cd09f43e ("git-gui: work from the .git dir",
2010-01-23), has had the intent to allow starting from inside a
repository, then switching to the parent directory if that is a valid
worktree.

This certainly hasn't worked since 2d92ab32fd ("rev-parse: make
--show-toplevel without a worktree an error", 2019-11-19) in git, but
breaking this git-gui feature was unintentional.

There are (at least) 3 cases where the gitdir can tell us where the
worktree is, and we would like all to work:

- core.worktree is set, and points to a valid worktree. This is already
  handled  by git rev-parse --show-toplevel, even when not in the worktree.
  There is nothing more to do in this case.

- the gitdir is embedded in a worktree as subdirectory .git. The parent
  is (or at least should be) a valid worktree. This worked long ago.

- the gitdir is a worktree specific directory (under
  <mainrepo>/worktrees/worktree_name), within which there is a file
  "gitdir" pointing to .git in the worktree. git gui never learned to
  handle this case.

Let's handle the latter two cases. Always check that the discovered
worktree is valid and points to the already discovered gitdir according
to git rev-parse. This avoids issues that may arise because we are
discovering from the gitdir up, rather than the worktree down, and file
system non-posix behavior or misconfiguration of git might cause
confusion.  For instance, a manually moved worktree might not be where
the gitdir points, or the gitdir might be configured with
core.bare=true.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 git-gui.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index abee222903..f48d929da8 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1103,6 +1103,37 @@ unset argv0dir
 ##
 ## repository setup
 
+proc find_worktree_from_gitdir {} {
+	# this is invoked only if the current directory is inside the repository
+	set worktree {}
+	if {[file tail $::_gitdir] eq {.git}} {
+		# the dir containing .git is a worktree if repo allows it
+		# Check that git reports parent as a worktree (gitdir might not allow a worktree)
+		if {[catch {
+				set parent [file dirname $::_gitdir]
+				set worktree [git -C $parent rev-parse --show-toplevel]
+			}]} {
+			set worktree {}
+		}
+	} elseif [file exists {gitdir}] {
+		# a worktree gitdir has .gitdir naming worktree/.git
+		# assure git run there reports this dir as the gitdir (links might be broken)
+		if {[catch {
+				set fd_gitdir [open {gitdir} {r}]
+				set worktree [file dirname [read $fd_gitdir]]
+				catch {close $fd_gitdir}
+				set worktree_gitdir [git -C $worktree rev-parse --absolute-git-dir]
+				if {$::_gitdir ne $worktree_gitdir} {
+					set worktree {}
+				}
+			}]} {
+			catch {close $fd_gitdir}
+			set worktree {}
+		}
+	}
+	return $worktree
+}
+
 proc is_gitvars_error {err} {
 	set havevars 0
 	set GIT_DIR {}
@@ -1176,6 +1207,13 @@ if {[catch {
 	set _prefix {}
 }
 
+if {[is_bare]} {
+	# Maybe we are in an embedded or worktree specific gitdir
+	if {[set _gitworktree [find_worktree_from_gitdir]] ne {}} {
+		set _prefix {}
+	}
+}
+
 if {![is_bare]} {
 	if {[catch {cd $_gitworktree} err]} {
 		catch {wm withdraw .}
-- 
2.54.0.99.14

