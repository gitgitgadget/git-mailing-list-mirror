Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5700D37E5D5
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790683219; cv=none; b=ROm1Or0B6Cs73fzf2GNB2M+78FB6nn7GoVLfUY4qqOOuG9cofVREPGvW0YuTJXSMYtJkOFstEKusFF5Ak8YE3A4Rfh1I66eLkDz+dKNKOxhuOFJQKKlEMpzEFa0QDv3ZfCkaBC7BmmCUN3/bH9Dd+AlIyeUcao96pNA0akZsPO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790683219; c=relaxed/simple;
	bh=JYW1RmSy9pCJ7EZ4U5r1I0+kmIUMeOz1IEQsVNQMjM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYWUaf5VhEpx7iC73Ls5UJzeaA32MaWwISwWKUP9YmzSRDilYOdlF1yn7lUpivyCiWMyAXGki0rFer8aJ3yE7Gutiu7yLpISjs2FJ2x/LHPJJqNbxG6xsnLckmiducoyWoZCdoKj4/QdoQqW6HSzTzmkGKaOXOqOwrY+MuVclHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByBRIiZb; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByBRIiZb"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-880483985aeso1754117b3a.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 05:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790683217; x=1791288017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLjlR5ge4Qok+LJxHI0n0KXoyTub6ERnXJcVXhY7IFw=;
        b=ByBRIiZbKeZPPJem71x3FV6EBq/RHU7khaYedP+Hvr9IA2YxtTaM86kKoHy1muqizs
         bVMEbpRpSsJwA+nD3bVBdiqLNZNA+/Cs0fbj8I+5Qq6Q/syl1CG/PSpElP5R5ExZlVPF
         qdZ8bzjgId3gepJy1arqt8bi7bcSRbRFeR+WDgFLOd3AwdWv9tgmxTkgc/hV0n1nS2zb
         ISnK0jdZE1GZ5c4fwoLrvYNA15eXVgFrciWYKtE4djSmyhlOEg6TnyElDwTw0XQokjL0
         pNHJdRmcW2h7hXhAqcD7HvnT3U49nDtM2EnXcGxwYMvMEjuSpiFxa5Vq6FhmEwprlN2y
         /+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790683217; x=1791288017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yLjlR5ge4Qok+LJxHI0n0KXoyTub6ERnXJcVXhY7IFw=;
        b=M7vGjAXH/ar5UmhTpecRn0uo9YxrW7rEKBnrVh8smb86nwjyILyeo7PYG33TTXd3no
         SxIeVhAv+T4ZW/gejpIP3wYdga00dvlI7ivLN60OgzZA5V2a4M9v7leijGB3gTjZ+3aT
         Ur5jd3tCcQlTPTzmK5fd0j4fO0tu9RjMehewRT+hsQlW1VkaxWTuVdZCL/0l4GIugBoX
         In3NtBPQ7IVUIquQ7U3nxN7RwtV32n7DI4aXTYv4waebCUPwQ0ubPZUUfTSK80QeBL+m
         KnogU3R5m1VNpQteYa2vgk76UBANAMo5YC3U+/2ymh0rZdFTtNAHbLGEbgd7YNM1yVTZ
         73UA==
X-Gm-Message-State: AFuF++kCFDcDAGQthzYhwx/LfHXablfCjWVuLw0JhKsP6PC6MSnbd6Pl
	cHAeE6lu175gSnr8KOyDelL3Je30P9Syzkt8CEN9VVoMno6OTh7aNatM2uXkE9Y3dOKnBw==
X-Gm-Gg: AYBFou18jqQbIMYx7h7zG8QZD9AbxQkkmfmkOR6SEC39DwJt9wULWs72p//kehvTwaZ
	leYHytdPCZuGJxCwlqz4pWKqa0IlmMY40zZXr3Io/LmqpEWn8+ouepZB4p9f2XOExf7iHrs2bIk
	fDd37DuRO34WaL14OQrurKxiCSnniiiXKZEA+6JPBOI/LxkASfNgX50x3ptY1azJanfrzYF347S
	8sJE9mB5vsnXl3cKZvOfWFXrNC/CvumZ31c8HbMvNQG+C4N/lRXHvzrROwQKRcrP8r8TdbsCDXd
	xTYT7vGFaabed7/r123igT7Ucd8+gtvYn3V8oZTYacOogvubBoYelSNbeoaLmibuZxs7cDP36Be
	5MzMJ1dgefCrK8f1E5V0DKWbJExy36aWVPXyEChJRhIMJZLX5BkU4ehK0S0JBMYAqqyZH+2GVob
	2u/YK51F9jaNFKJ0HG7etC50Ii+X2/dXXGandh/tCkq/fOSzxGtgY84rvIgKsIeNyFk7LzvGtF0
	gwxB3u9cTl0hwIy1qBPmeJYVkSHO0HG6CwWZQY6QqxiWJVeV6lyVUD/1hx/zt7kowHZjx1E8RoZ
	Z+Y2RRrTzzM1vxqgyhXdspg+cbqQNwHsvsAi7AiRpXIM6XBtAAu4WTdY2kICiboTR7REWg==
X-Received: by 2002:a05:6a00:1391:b0:880:a155:d2d5 with SMTP id d2e1a72fcca58-880a155e378mr9009491b3a.5.1790683215557;
        Tue, 29 Sep 2026 05:00:15 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-885e25e0bdbsm671975b3a.52.2026.09.29.05.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:00:14 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Niklas Cassel <cassel@kernel.org>,
	Bence Ferdinandy <bence@ferdinandy.com>,
	Philip Oakley <philipoakley@iee.email>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v2] doc: remote: say that it only affects the local repository
Date: Tue, 29 Sep 2026 20:00:10 +0800
Message-ID: <20260929120010.840402-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927055040.2441925-1-matthias.goergens@gmail.com>
References: <20260927055040.2441925-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nothing that "git remote" does changes a remote repository.  "set-head"
updates the local refs/remotes/<name>/HEAD, not the remote's own HEAD;
"prune" deletes stale remote-tracking branches, not branches on the
remote; and so on.  The manual page never says so, and wording such as
"Set or delete the default branch ... for the named remote" can be read
as acting on the remote itself.  It was recently misread that way in a
discussion on another project's mailing list.

Say it once, near the top of the DESCRIPTION, rather than in the
description of each subcommand.

Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
Changes since v1, following Junio's suggestion:

 - Say once, near the top of the DESCRIPTION, that "git remote" only
   changes the local repository, instead of adding a paragraph to the
   "set-head" entry.  The "set-head" paragraph is dropped, as the
   general statement covers it.

 - Drop the remark that Git offers no client-side way to change a
   remote's default branch; it only made sense next to "set-head".

The misreading mentioned above is in this sub-thread of a Linux
MAINTAINERS patch:
https://lore.kernel.org/all/arfrW8NmQ4tsCF2I@ryzen/

 Documentation/git-remote.adoc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git-remote.adoc b/Documentation/git-remote.adoc
index eaae30aa88..315100409d 100644
--- a/Documentation/git-remote.adoc
+++ b/Documentation/git-remote.adoc
@@ -28,6 +28,11 @@ DESCRIPTION
 
 Manage the set of repositories ("remotes") whose branches you track.
 
+`git remote` changes only the local repository, i.e. its configuration
+and its refs, and never modifies a remote repository.  Some subcommands,
+such as `show`, `prune`, `update` and `set-head --auto`, contact a
+remote repository to read from it.
+
 
 OPTIONS
 -------

Range-diff against v1:
1:  fc517f8ddd ! 1:  b20a2e51ab doc: clarify that set-head does not change the remote's HEAD
    @@ Metadata
     Author: Matthias Goergens <matthias.goergens@gmail.com>
     
      ## Commit message ##
    -    doc: clarify that set-head does not change the remote's HEAD
    +    doc: remote: say that it only affects the local repository
     
    -    `git remote set-head <name> <branch>` never changes the remote
    -    repository's own `HEAD`, i.e. the branch that a fresh `git clone` of
    -    that remote checks out; every change it makes is local.
    +    Nothing that "git remote" does changes a remote repository.  "set-head"
    +    updates the local refs/remotes/<name>/HEAD, not the remote's own HEAD;
    +    "prune" deletes stale remote-tracking branches, not branches on the
    +    remote; and so on.  The manual page never says so, and wording such as
    +    "Set or delete the default branch ... for the named remote" can be read
    +    as acting on the remote itself.  It was recently misread that way in a
    +    discussion on another project's mailing list.
     
    -    The current wording, "Set or delete the default branch ... for the
    -    named remote", reads as though the command changes the remote itself.
    -    It was recently misread that way in a discussion on another project's
    -    mailing list, until a test showed the remote's `HEAD` unchanged.
    -
    -    Say that the change is local and that Git offers no client-side way to
    -    change a remote's own default branch.
    +    Say it once, near the top of the DESCRIPTION, rather than in the
    +    description of each subcommand.
     
         Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
     
      ## Documentation/git-remote.adoc ##
    -@@ Documentation/git-remote.adoc: branch. For example, if the default branch for `origin` is set to
    - `master`, then `origin` may be specified wherever you would normally
    - specify `origin/master`.
    - +
    -+This command does not change the remote repository's own `HEAD`, i.e.
    -+the branch that a fresh `git clone` of that remote will check out;
    -+every change it makes is local. Git provides no way to change a
    -+remote's own default branch from the client; how that is done depends
    -+on how the remote is hosted.
    -++
    - With `-d` or `--delete`, the symbolic ref `refs/remotes/<name>/HEAD` is deleted.
    - +
    - With `-a` or `--auto`, the remote is queried to determine its `HEAD`, then the
    +@@ Documentation/git-remote.adoc: DESCRIPTION
    + 
    + Manage the set of repositories ("remotes") whose branches you track.
    + 
    ++`git remote` changes only the local repository, i.e. its configuration
    ++and its refs, and never modifies a remote repository.  Some subcommands,
    ++such as `show`, `prune`, `update` and `set-head --auto`, contact a
    ++remote repository to read from it.
    ++
    + 
    + OPTIONS
    + -------
-- 
2.55.0

