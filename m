Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD8835B636
	for <git@vger.kernel.org>; Sun, 27 Sep 2026 05:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790488246; cv=none; b=K5p8LARocrkQf+PDhVftuTILi11vllGWziG8OwTqbRmxs3E8fksFYeME3Xydvn7+IwfBODtjc/dpe60lsSkZwAWcHsm6Fn/hc0wHKQCgKUl2y97FvwkO5/jopdfzOS6UiO33ixW6z2QdgHGZWrjIHtqCANQpZs8brksOk58Qw+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790488246; c=relaxed/simple;
	bh=oMGt5q8+G2PUpzoq1cZjb6UwNCmKqTxSdCp0iAagciI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyMX0wthxbh8ovlC0S7bFtbwvGnMA3XGuazc6IAAXBTv+Y9GzWlH33j8Fpx32pegwvNEGGDedgnkq36NUCfwKW5so4mKPEAb0UGVFZ2fX8iE3gSUJ8ZNR5GeAvR9+ow51bt7lipzNi2ZbpVOMx4nefkj/ENxgUNUP1tiDSE5MDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYVqNHyk; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYVqNHyk"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-3468ec309afso39730eec.3
        for <git@vger.kernel.org>; Sat, 26 Sep 2026 22:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790488244; x=1791093044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eMVXdnOd79VUE14vyd/tzTDQhy82O4DzapT2eMxLamc=;
        b=WYVqNHykPCLd5M+El2IAVOjJyrHi3bjATZ1dgr8S2yBIo8cqffaxiih4O7mqxJcXPy
         qStFM73gaFIlaTL24SOWrvKp3MbmW/1T1ft3Gwo1WOEp17/pIPwtnLWONAN8+sSalDM0
         /U0JYeFABT+mr1BmBm6DazrfVFhkLBHIV1MWosu0vr+f7X93ZCPel8duLM7X60EnTvhW
         ifabLCRhvTTTJkLE1HSqFrWRhxi3K9SusNDaznn6/muI0PUr+7owKOsO4edITf+o0+ph
         dhWnryA7c83/WRB6KEnW0pCnqg8SVCLjwPxY82Rz/vl6JVUYXAD70OITRi3ge30SRrXG
         9R1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790488244; x=1791093044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eMVXdnOd79VUE14vyd/tzTDQhy82O4DzapT2eMxLamc=;
        b=Ln3f0wpX87HuJ997qNl8EYE7jaHsbyAvtMuDiNrYTH1jlqs9tRd1JakGP8vMA4HsdU
         idVefomXthHbHgAK3QFYS1ikZJyBjvYidFr7UBRuvLXKGvbEouTJtXutagzZB0RAMy4D
         Bvv34V/WILBBYp+sWNYMiqQobp2UCUCdGU//nLgh3CcePmw1M0QGiTW16nthcZzPcPEF
         z/s4VlN7yCdt2XfRFpJ3IzRoM7EGVIgveRy0CBHMKR7oOq4ajkmTZxcwftIBZFdrB6NA
         UqjIo00PJX0MSu6LRxe0qPY2+fVQOFNsl7W0a3q0K4c6udQftHmmjppSz62moRmcZ4Xi
         zVAQ==
X-Gm-Message-State: AFq9FYJAWfPyIuUE+3KTovP3Zuuh7Qm9JQlKe40JHhTQcQ8dAAU5g2Cc
	igKptgG9SFOB0lcXRDvFn87b+3eKHK9Rcbqx8XIRhEOZGglUfpJZpmFRK2NRYZbkihGpZQ==
X-Gm-Gg: AYBFou1VC8c2wbqk48snu4c6uNtHbGmr3lsZvvgdpnEn/5SxWqqTHQUqkmC/jrACWTp
	zes7nooU44a4CgazIePqmot0rW/MtNUY9qB52aihrOUqAWmVqmz1Cht3MaelpP+h/CJuRxSMArA
	PDFzfO9d8w3Jtl/rG36JT8YJAztLBgftd0SwRjR9wc4N27LoEV5RBuhNpjqp5Zk2st7IZOflcIF
	uktivwl3PLzpLlpO1hPeGB5yIZvjkNYP+2dWvr4aHmhKgBehggWJcyIaGhcRZIWf8ZXCh6dUpM/
	y+4bvhKz88xUmWBsTjoqyBV0l3EHcPksN4TeaAiq+QWTUxgDX0i5wS5QcP0T4ioAhMksCDqK0Wi
	b9bZLM8QpIAURKS3StLCfl/PlT+WMCl+boDJPk43jKc31P2me9IvSjCG2e7gfWQlXwQSaKqH3vI
	MaoYSKqWKzRiuqsL7F3q+36kc2nre8qPKTSQtSR3N0b52rlF8GMgnk84Ma1NWWyUfdjQVvSixg1
	4Gip7ppl7ifYNU1WT4sXOeImC65bLFOec+VqQ4iBX1SuGv4gCXu2LtSlfRNUUnsZq1uY9ffhIRa
	cW4FUK/RCwZmsiAEmPGgc5iIDwUlB8ji6ZearME/0wO5KugGKilF9TON07eM
X-Received: by 2002:a05:7301:1a0d:b0:33b:aea6:17be with SMTP id 5a478bee46e88-3427324eedamr5188643eec.24.1790488244181;
        Sat, 26 Sep 2026 22:50:44 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34571658054sm1318185eec.8.2026.09.26.22.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 22:50:43 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: git@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	Bence Ferdinandy <bence@ferdinandy.com>,
	Philip Oakley <philipoakley@iee.org>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] doc: clarify that set-head does not change the remote's HEAD
Date: Sun, 27 Sep 2026 13:50:40 +0800
Message-ID: <20260927055040.2441925-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`git remote set-head <name> <branch>` never changes the remote
repository's own `HEAD`, i.e. the branch that a fresh `git clone` of
that remote checks out; every change it makes is local.

The current wording, "Set or delete the default branch ... for the
named remote", reads as though the command changes the remote itself.
It was recently misread that way in a discussion on another project's
mailing list, until a test showed the remote's `HEAD` unchanged.

Say that the change is local and that Git offers no client-side way to
change a remote's own default branch.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
The misreading is in this sub-thread of a Linux MAINTAINERS patch:
https://lore.kernel.org/all/arfrW8NmQ4tsCF2I@ryzen/

On a gitolite server, the remote's HEAD can be changed with gitolite's
symbolic-ref command, if the site enables it.  On kernel.org, for
example:

  ssh git@gitolite.kernel.org symbolic-ref pub/scm/<repo> HEAD refs/heads/<branch>

(https://korg.docs.kernel.org/gitolite/index.html#symbolic-ref).  If a
client-side way would be welcome, e.g. a push option that receive-pack
honours, I could look into it.

 Documentation/git-remote.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index eaae30aa88..c9cf17e7bd 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -107,6 +107,12 @@ branch. For example, if the default branch for `origin` is set to
 `master`, then `origin` may be specified wherever you would normally
 specify `origin/master`.
 +
+This command does not change the remote repository's own `HEAD`, i.e.
+the branch that a fresh `git clone` of that remote will check out;
+every change it makes is local. Git provides no way to change a
+remote's own default branch from the client; how that is done depends
+on how the remote is hosted.
++
 With `-d` or `--delete`, the symbolic ref `refs/remotes/<name>/HEAD` is deleted.
 +
 With `-a` or `--auto`, the remote is queried to determine its `HEAD`, then the
-- 
2.55.0

