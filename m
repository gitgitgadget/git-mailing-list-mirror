Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A3377A85
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787505575; cv=none; b=Q2FKKJRZRv6Tho7tgnn3FyZjIGBkOVL51vFFF0bwqKnidT2BjGm4r3dA+b5QaPbYYexLU6CQ0Hlu2d6RWxk6BXMW2dcOMMVtKM+Nk8gra1oxi8WziLHVbBovUGIWvzcEnSY4iobFCGl202Pirh2dCHsO791ANPnYAu1DEyIt4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787505575; c=relaxed/simple;
	bh=V/lkhtPYgmhG0tzWhbRYDhZgVoMHYdTKOGHNppCPgOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o14GFJEcnyEHo/lOWCXzSzMrGjogToTP5fDWS4pklQkkZSxvd7icuFXvKGL0wr6nilSxwSK/swbbk3VGLRicOIekPztRmZ5n/ql08vuw/Hu7RqTtAFqOGNRqQHK4KYz+Fd2VQ2sEhdaojWgzgRe9UK4CIuSrfvUkxPigmRAsc2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1LQ7g8q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1LQ7g8q"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d58efc7356so29640945ad.1
        for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787505568; x=1788110368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LljVwFyiglrMg/zwVzYBSwLRf94rzpV0LN7S8JuOI0w=;
        b=K1LQ7g8qRNPpLr70/uYp4MLnmqF+LOBzK9ngTEzZR7wuJshGQYxYfKwI3ob2OzxFdq
         faLoUuMJL0sPuMefvOYduaEBChxY343w7txs/cvy+qsZ0ZAQwKylmFegJ6rIFtSKQW5h
         uOGGXLmXoqISD8VYbm8OtZPOOgcqzkFZaCcuYfRBgGWdsbSx+97NgmK4xdFk70fVbL37
         69jVRHUDnixqXdwDtR5wa/V+pVJwU8dMy2xjhCiWPKu/lgrs5YqrUhnCZZgUmyyuP/+E
         5gm9w/iTK1KyHIXZaFUI6hfomzYfsyu0WJgoFCdati9QuW5rN9/hTH2ro0TYI2Erm7oL
         C9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787505568; x=1788110368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LljVwFyiglrMg/zwVzYBSwLRf94rzpV0LN7S8JuOI0w=;
        b=g59P9qTQmxZI3tkbyw9Iz7vCCHZ5o5Y+vs6dJVl2ppisum1w22TxVzR2pvkEbmfyMj
         c7Khey+uK/HRi9wBSWOFaN7TKWxa79gAXOrwxgV4uMbU0hYTfJMfMq3MVJfih7DnvIsB
         W2rLgnOSo7nh/Naa4PXjk3CRTX5Q4LcUe3PFdwOQSWBE4/op1CUQmQ6IY7bbmCJ/DW5X
         bbAhIpd4kqcxNYqLJV0/4Ful5PXrdR/xlA29t4kb1GrOQQtNyX6t/YqGXHqZp/WBEpiS
         0qHsqvu6VXq3imI5zdYvi2s1Fas9+YIwQyoCQ1DSggUbeW9dUpDVQd6Xl9R0YVW/OwWv
         D8Rw==
X-Gm-Message-State: AFuF++lXA/U7MXIt27cVXHQ7aHNJlSftJAs8P0RpTUPuhh06d2RE27I7
	DpHFGZQceH0Lu8d0Do22pxOHTCsk9N8EIwiV+DZbIPbNEkeOz+Gxa9LIB3ilEA==
X-Gm-Gg: AR+sD10W1JP9MPVG17i3ydfkVvuvetfxoIueF1G9YUuDSva64q/qF295JHDINMVibk6
	pCmS+OVCPugh1OMboTekZjjwX435oyBMO/RUek3WuN6t7RCtMV8XA6yQZzbLlhlGWItDgP6U+qS
	v6IqISwhqg86ypBJ22GaK74xYrFt1hVhOTVR3SVBe3paI1IUq9GhXK8hkPIHnN80R9mpyA4Zand
	9SF+vGIUYofgkjiW3i39oRAMrPVjB8ozjjQGxbALhkPzdSyiWP3VT9DZEpsFLtgburXRmP/EE/A
	ERyPprBLP44F38JA4kR9B/oaYrOgdqhbeVEDdPUqeDMKbLfEX/S6vH23rsjX4rzocadJdrP1ep1
	LGVM5GAtUMA3vxTrfnYZ2Y6epEAltptOn2RJ2deMUziYbDRbc5lNQ/WVc+80EI+tBqnv3s3keNY
	+zQqPyXnr5FwQ8pE8vi0mvz0awDeGdeUZ/Z1LerHuvUPZ4GOOpD2oMpS6zdfhMta7zPvsTcejiY
	Aqnb5QnAWBRdjJsZyIVd8V5bFRJumHk/Ug31uuNQ7q5eTXe3hpv4TyZsrC03kHGoaoOK4nC8Lnu
	AV/cHauiN5mEAgE9hOCCG6MNU2g+kw7YIvYgW71oIMOpDISmbWRmQcnTog==
X-Received: by 2002:a17:902:da86:b0:2d5:cb05:49d9 with SMTP id d9443c01a7336-2d670bd7471mr207751635ad.5.1787505567211;
        Sun, 23 Aug 2026 10:19:27 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f909c6c9sm20822624eec.6.2026.08.23.10.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 10:19:25 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <pks@pks.im>
Subject: [RFC PATCH 06/14] organize: record a label for every source in scope
Date: Sun, 23 Aug 2026 10:18:50 -0700
Message-ID: <20260823171915.2662373-7-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260823171915.2662373-1-mmontalbo@gmail.com>
References: <20260823171915.2662373-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run the reference labeler over Git's tree and record its labels in
.gitorganize. Each source's component comes from the "area:" prefix its
commits carry most often, consolidated by git-layout.map; a source the
prefix cannot place falls back to its filename, and one that neither places
but changes chiefly alongside a component is promoted there. Standalone
programs stay at the root, and a source that stays diffuse is component=?.
Each line also carries the prefix, the #include coupling, and the co-change
profile as advisory signals.

status now reports the whole to-move set across thirteen components:

  495 in scope (113 in place, 303 to move, 79 backlog)

The 79 backlog sources, recorded component=? with role=lib, are left at
the root as the frontier. A public header or program also records
component=? but is kept at the root by its role.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 .gitorganize | 475 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 475 insertions(+)

diff --git a/.gitorganize b/.gitorganize
index 18cf3228a8..522821522e 100644
--- a/.gitorganize
+++ b/.gitorganize
@@ -17,3 +17,478 @@ component:transport = transport
 component:notes = notes
 component:submodule = submodule
 component:archive = archive
+[labels]
+# The recorded placement of each source; edit a line to change it.
+# apply --labels-only fills in unrecorded sources; --reseed re-derives all.
+abspath.c component=? role=lib prefix=abspath cochange=setup:12,diff:6,refs:5,index:3,submodule:3
+abspath.h component=? role=public prefix=abspath cochange=setup:1
+add-interactive.c component=? role=lib prefix=add-interactive includes=index:3,odb:2,diff:1,refs:1,revision:1 cochange=diff:19,index:16,revision:16,odb:7,refs:6
+add-interactive.h component=? role=public prefix=add-patch cochange=odb:2
+add-patch.c component=? role=lib prefix=add-patch includes=setup:3,index:2,odb:2,diff:1 cochange=index:10,transport:8,odb:6,merge:4,refs:4
+add-patch.h component=? role=public prefix=add-patch cochange=odb:1
+advice.c component=? role=lib prefix=advice includes=setup:2 cochange=transport:18,index:12,odb:9,diff:8,revision:8
+advice.h component=? role=public prefix=advice cochange=transport:14,index:9,odb:6,submodule:4,pack:3
+alias.c component=setup role=lib prefix=alias includes=setup:2 cochange=setup:8,diff:4,transport:3,convert:2,index:2
+alias.h component=setup role=header prefix=completion cochange=setup:3,transport:2,pack:1,revision:1
+alloc.c component=odb role=lib prefix=alloc includes=odb:6,setup:1 cochange=odb:54,revision:8,diff:6,pack:6,index:3
+alloc.h component=odb role=header prefix=alloc cochange=odb:16,refs:1,revision:1
+apply.c component=? role=lib prefix=apply includes=index:5,setup:4,odb:3,diff:2,merge:2 cochange=index:93,setup:43,diff:41,odb:26,merge:24
+apply.h component=? role=public prefix=apply includes=odb:1 cochange=diff:2
+archive-tar.c component=archive role=lib prefix=archive-tar includes=archive:1,odb:1,setup:1 cochange=archive:59,index:12,diff:9,odb:9,transport:8
+archive-zip.c component=archive role=lib prefix=archive-zip includes=diff:2,archive:1,odb:1,setup:1 cochange=archive:57,diff:12,odb:8,index:7,transport:6
+archive.c component=archive role=lib prefix=archive includes=odb:5,setup:3,convert:2,archive:1,index:1 cochange=archive:54,convert:42,odb:39,index:36,revision:31
+archive.h component=archive role=header prefix=archive includes=index:1 cochange=archive:58,index:3,revision:3,convert:2,diff:1
+attr.c component=convert role=lib prefix=attr includes=odb:3,setup:3,index:2,convert:1,refs:1 cochange=index:55,convert:54,diff:41,setup:26,revision:22
+attr.h component=convert role=header prefix=attr cochange=convert:50,index:13,diff:9,archive:8,setup:3
+banned.h component=? role=public prefix=banned
+base85.c component=? role=lib prefix=base85 cochange=diff:4,pack:2,convert:1,transport:1
+base85.h component=? role=public prefix=base85 cochange=diff:1
+bisect.c component=revision role=lib prefix=bisect includes=odb:5,revision:5,setup:2,diff:1,index:1 cochange=revision:61,odb:32,transport:31,refs:13,diff:9
+bisect.h component=revision role=header prefix=bisect cochange=revision:29,odb:2
+blame.c component=revision role=lib prefix=blame includes=odb:5,diff:2,index:2,pack:2,revision:2 cochange=diff:68,revision:66,odb:56,index:29,pack:22
+blame.h component=revision role=header prefix=blame includes=diff:1,odb:1 cochange=revision:19,odb:7,diff:4,archive:1,index:1
+blob.c component=odb role=lib prefix=object includes=odb:2 cochange=odb:131,transport:12,pack:11,revision:10,refs:5
+blob.h component=odb role=header prefix=blob includes=odb:1 cochange=odb:33,revision:4,pack:3,transport:2
+bloom.c component=pack role=lib prefix=bloom includes=odb:4,diff:2,pack:2,setup:2 cochange=pack:38,revision:25,diff:15,odb:6,index:2
+bloom.h component=pack role=header prefix=bloom cochange=pack:28,revision:12,odb:1
+branch.c component=? role=lib prefix=branch includes=refs:3,setup:3,odb:2,submodule:1,transport:1 cochange=refs:62,transport:41,setup:28,index:19,revision:12
+branch.h component=? role=public prefix=branch cochange=setup:8,refs:4,submodule:4
+builtin.h component=? role=public prefix=builtin includes=setup:1 cochange=diff:15,index:15,transport:12,odb:6,notes:5
+bundle-uri.c component=transport role=lib prefix=bundle-uri includes=transport:5,odb:1,refs:1,setup:1 cochange=transport:28,setup:7,odb:4,merge:2,pack:2
+bundle-uri.h component=transport role=header prefix=bundle-uri cochange=transport:14
+bundle.c component=transport role=lib prefix=bundle includes=odb:3,revision:3,setup:2,transport:2,diff:1 cochange=transport:63,odb:24,revision:21,refs:17,pack:10
+bundle.h component=transport role=header prefix=bundle includes=revision:1 cochange=transport:37,revision:5
+cache-tree.c component=index role=lib prefix=cache-tree includes=odb:5,index:2,setup:1,transport:1 cochange=index:94,odb:69,revision:27,transport:21,diff:20
+cache-tree.h component=index role=header prefix=cache-tree includes=odb:2 cochange=index:42,diff:4,revision:4,odb:3,refs:1
+cbtree.c component=odb role=lib prefix=cbtree includes=odb:1 cochange=odb:9,diff:1,merge:1,pack:1
+cbtree.h component=odb role=header prefix=cbtree cochange=odb:12,pack:3,setup:1,transport:1
+chdir-notify.c component=? role=lib prefix=chdir-notify includes=revision:1 cochange=index:2,archive:1,merge:1,revision:1
+chdir-notify.h component=? role=public prefix=chdir-notify
+checkout.c component=index role=lib prefix=checkout includes=setup:2,index:1,odb:1,refs:1,transport:1 cochange=transport:16,refs:6,setup:5,index:3,odb:2
+checkout.h component=index role=header prefix=checkout includes=odb:1 cochange=index:4,diff:1,odb:1,refs:1,revision:1
+chunk-format.c component=pack role=lib prefix=chunk-format includes=odb:1,pack:1 cochange=pack:20,odb:1,transport:1
+chunk-format.h component=pack role=header prefix=chunk-format includes=odb:1 cochange=pack:15,odb:2,setup:1,transport:1
+color.c component=? role=lib prefix=color includes=setup:1 cochange=diff:21,index:14,revision:13,setup:7,transport:7
+color.h component=? role=public prefix=color cochange=diff:18,index:12,revision:12,transport:2,odb:1
+column.c component=? role=lib prefix=column includes=setup:1 cochange=transport:6,setup:5,diff:4,revision:3,index:2
+column.h component=? role=public prefix=column
+combine-diff.c component=diff role=lib prefix=combine-diff includes=odb:5,diff:4,revision:2,convert:1,refs:1 cochange=diff:198,revision:67,index:35,odb:16,transport:16
+commit-graph.c component=pack role=lib prefix=commit-graph includes=odb:9,pack:4,setup:2,refs:1,revision:1 cochange=pack:206,odb:125,revision:47,transport:34,setup:22
+commit-graph.h component=pack role=header prefix=commit-graph includes=odb:2 cochange=pack:92,odb:14,setup:9,revision:8,transport:5
+commit-reach.c component=revision role=lib prefix=commit-reach includes=revision:3,odb:2,pack:1,refs:1 cochange=revision:38,odb:17,pack:15,transport:9,index:5
+commit-reach.h component=revision role=header prefix=commit-reach includes=odb:2 cochange=revision:32,odb:9,transport:8,pack:3,refs:3
+commit-slab-decl.h component=odb role=header prefix=commit-slab cochange=odb:6,revision:1
+commit-slab-impl.h component=odb role=header prefix=commit-slab cochange=odb:7,pack:3,revision:1,setup:1,transport:1
+commit-slab.h component=odb role=header prefix=commit-slab includes=odb:2 cochange=odb:8,revision:2,transport:2,index:1,merge:1
+commit.c component=odb role=lib prefix=commit includes=odb:10,setup:4,revision:3,diff:1,index:1 cochange=odb:403,revision:147,transport:87,pack:57,setup:45
+commit.h component=odb role=header prefix=commit includes=odb:1 cochange=odb:237,revision:205,transport:49,pack:25,notes:22
+common-exit.c component=? role=lib prefix=common-main
+common-init.c component=? role=lib prefix=common-main includes=odb:2,setup:2,convert:1 cochange=setup:1
+common-init.h component=? role=public prefix=common-main
+common-main.c component=? role=lib prefix=common-main cochange=setup:5,transport:4,convert:3,index:1
+config.c component=setup role=lib prefix=config includes=setup:4,odb:2,convert:1,index:1,refs:1 cochange=setup:274,index:93,diff:75,refs:48,revision:46
+config.h component=setup role=header prefix=config includes=setup:1 cochange=setup:100,index:30,transport:23,submodule:21,merge:6
+connect.c component=transport role=lib prefix=connect includes=transport:7,setup:4,odb:1,refs:1 cochange=transport:238,setup:19,diff:13,index:10,refs:10
+connect.h component=transport role=header prefix=connect includes=transport:1 cochange=transport:58,refs:1
+connected.c component=transport role=lib prefix=connected includes=transport:3,odb:1,pack:1 cochange=transport:39,pack:31,odb:7,diff:6,index:5
+connected.h component=transport role=header prefix=connected cochange=transport:23
+convert.c component=convert role=lib prefix=convert includes=convert:2,index:1,merge:1,odb:1,setup:1 cochange=convert:59,diff:43,index:41,setup:30,transport:30
+convert.h component=convert role=header prefix=convert includes=odb:1 cochange=convert:29,index:18,diff:8,setup:8,archive:4
+copy.c component=? role=lib prefix=copy cochange=pack:6,transport:5,diff:3,odb:3,merge:2
+copy.h component=? role=public prefix=copy cochange=transport:3,merge:2,convert:1,setup:1
+credential.c component=? role=lib prefix=credential includes=setup:3 cochange=transport:13,index:4,odb:4,convert:2,merge:2
+credential.h component=? role=public prefix=credential cochange=transport:6
+csum-file.c component=? role=lib prefix=csum-file includes=odb:1 cochange=pack:49,odb:13,index:10,transport:10,diff:8
+csum-file.h component=? role=public prefix=csum-file includes=odb:1 cochange=pack:44,odb:8,diff:5,index:5,transport:5
+ctype.c component=? role=lib prefix=ctype cochange=setup:3,index:2,odb:1,pack:1,refs:1
+daemon.c component=? role=program prefix=daemon includes=setup:3,transport:2 cochange=transport:77,index:14,setup:13,diff:7,refs:5
+date.c component=? role=lib prefix=date cochange=revision:17,odb:16,refs:14,setup:9,diff:7
+date.h component=? role=public prefix=date cochange=refs:7,revision:4,setup:2,archive:1,odb:1
+decorate.c component=revision role=lib prefix=decorate includes=odb:1,revision:1 cochange=diff:6,odb:5,revision:5,pack:2,transport:2
+decorate.h component=revision role=header prefix=decorate cochange=revision:4,odb:1
+delta-islands.c component=pack role=lib prefix=delta-islands includes=odb:6,pack:4,diff:1,refs:1,setup:1 cochange=pack:20,odb:17,revision:7,transport:7,diff:5
+delta-islands.h component=pack role=header prefix=delta-islands cochange=pack:6
+delta.h component=pack role=header prefix=diff-delta cochange=pack:27,odb:19,diff:5,transport:3,convert:1
+diagnose.c component=? role=lib prefix=diagnose includes=archive:1,index:1,odb:1,pack:1,setup:1 cochange=index:4,revision:4,odb:3,pack:3,transport:3
+diagnose.h component=? role=public prefix=diagnose cochange=revision:2,refs:1,transport:1
+diff-delta.c component=pack role=lib prefix=diff-delta includes=pack:1 cochange=pack:24,diff:7,index:2,odb:2,transport:2
+diff-lib.c component=diff role=lib prefix=diff includes=index:6,odb:3,diff:2,revision:2,refs:1 cochange=diff:150,index:124,revision:47,submodule:18,odb:8
+diff-merges.c component=diff role=lib prefix=diff-merges includes=diff:1,revision:1 cochange=revision:18,diff:17,odb:4,refs:3,index:2
+diff-merges.h component=diff role=header prefix=diff-merges cochange=diff:11,revision:4,merge:1
+diff-no-index.c component=diff role=lib prefix=diff includes=diff:2,index:2,odb:1,revision:1 cochange=diff:76,revision:21,index:19,refs:8,notes:7
+diff.c component=diff role=lib prefix=diff includes=odb:5,diff:4,setup:3,convert:2,index:2 cochange=diff:610,revision:121,index:100,transport:71,setup:69
+diff.h component=diff role=header prefix=diff includes=index:1,odb:1 cochange=diff:471,revision:83,index:29,submodule:18,odb:14
+diffcore-break.c component=diff role=lib prefix=diffcore-break includes=odb:2,diff:1,transport:1 cochange=diff:71,pack:8,revision:7,index:5,merge:3
+diffcore-delta.c component=diff role=lib prefix=diffcore-delta includes=diff:1 cochange=diff:26,revision:7,odb:4,index:2,refs:2
+diffcore-order.c component=diff role=lib prefix=diffcore-order includes=diff:2 cochange=diff:19,index:8,refs:7,revision:7,pack:5
+diffcore-pickaxe.c component=diff role=lib prefix=pickaxe includes=diff:3,odb:1,revision:1 cochange=diff:97,revision:15,notes:3,odb:3,merge:2
+diffcore-rename.c component=diff role=lib prefix=diffcore-rename includes=diff:2,odb:2,transport:1 cochange=diff:188,index:38,revision:37,odb:21,pack:17
+diffcore-rotate.c component=diff role=lib prefix=diff includes=diff:2 cochange=diff:14,revision:5,pack:2,merge:1,refs:1
+diffcore.h component=diff role=header prefix=diff includes=odb:1 cochange=diff:175,revision:11,merge:10,submodule:4,odb:2
+dir-iterator.c component=index role=lib prefix=dir-iterator includes=index:2 cochange=index:7,refs:1
+dir-iterator.h component=index role=header prefix=dir-iterator cochange=index:7,refs:1
+dir.c component=index role=lib prefix=dir includes=index:7,setup:4,odb:2,convert:1,refs:1 cochange=index:343,diff:61,setup:49,odb:37,convert:29
+dir.h component=index role=header prefix=dir includes=index:2,odb:1 cochange=index:236,odb:13,setup:12,submodule:11,convert:10
+editor.c component=? role=lib prefix=editor includes=setup:2 cochange=transport:20,setup:12,index:8,odb:4,submodule:4
+editor.h component=? role=public prefix=editor cochange=transport:1
+entry.c component=index role=lib prefix=entry includes=index:7,odb:1,setup:1,submodule:1 cochange=index:96,diff:28,convert:20,setup:17,odb:10
+entry.h component=index role=header prefix=entry includes=convert:1 cochange=index:18,submodule:4,revision:3,transport:2,convert:1
+environment.c component=setup role=lib prefix=environment includes=setup:5,convert:3,odb:2,merge:1,refs:1 cochange=setup:281,index:77,odb:48,refs:36,transport:28
+environment.h component=setup role=header prefix=environment includes=setup:1 cochange=setup:135,index:37,odb:15,refs:11,pack:9
+exec-cmd.c component=? role=lib prefix=strvec includes=setup:1
+exec-cmd.h component=? role=public prefix=argv-array cochange=refs:4,transport:4,odb:1,setup:1,submodule:1
+fetch-negotiator.c component=transport role=lib prefix=repo-settings includes=setup:1,transport:1 cochange=setup:8,transport:7,index:2,odb:1
+fetch-negotiator.h component=transport role=header prefix=fetch-negotiator cochange=transport:7,setup:3,odb:1,pack:1,revision:1
+fetch-object-info.c component=transport role=lib prefix=cat-file includes=transport:3,odb:2 cochange=transport:7,odb:1
+fetch-object-info.h component=transport role=header prefix=cat-file includes=transport:2 cochange=transport:7,odb:1
+fetch-pack.c component=transport role=lib prefix=fetch-pack includes=transport:8,odb:7,setup:4,pack:3,revision:2 cochange=transport:303,odb:96,revision:46,pack:40,setup:25
+fetch-pack.h component=transport role=header prefix=fetch-pack includes=odb:1,revision:1,transport:1 cochange=transport:108,odb:2,pack:2,refs:2,diff:1
+fmt-merge-msg.c component=merge role=lib prefix=fmt-merge-msg includes=odb:3,diff:2,revision:2,setup:2,merge:1 cochange=revision:10,odb:7,index:6,diff:4,setup:4
+fmt-merge-msg.h component=merge role=header prefix=fmt-merge-msg cochange=merge:3,setup:2
+for-each-ref.h component=? role=public prefix=?
+fsck.c component=odb role=lib prefix=fsck includes=odb:9,setup:3,convert:1,index:1,pack:1 cochange=odb:113,revision:46,transport:43,pack:20,setup:15
+fsck.h component=odb role=header prefix=fsck includes=odb:2 cochange=odb:50,diff:5,revision:5,transport:5,refs:4
+fsmonitor--daemon.h component=index role=header prefix=fsmonitor--daemon includes=index:1 cochange=index:1
+fsmonitor-ipc.c component=index role=lib prefix=fsmonitor includes=index:1,setup:1 cochange=index:6,transport:2,merge:1,notes:1,pack:1
+fsmonitor-ipc.h component=index role=header prefix=fsmonitor cochange=index:2
+fsmonitor-ll.h component=index role=header prefix=fsmonitor-ll cochange=index:4
+fsmonitor-path-utils.h component=index role=header prefix=fsmonitor cochange=index:2
+fsmonitor-settings.c component=index role=lib prefix=fsmonitor includes=index:3,setup:2 cochange=index:17,setup:10,transport:2,diff:1,odb:1
+fsmonitor-settings.h component=index role=header prefix=fsmonitor-settings cochange=index:11,setup:4
+fsmonitor.c component=index role=lib prefix=fsmonitor includes=index:4,setup:3 cochange=index:37,setup:16,transport:4,merge:2,refs:2
+fsmonitor.h component=index role=header prefix=fsmonitor includes=index:4,odb:1 cochange=index:24,setup:7,diff:3,submodule:1
+gettext.c component=? role=lib prefix=gettext includes=setup:1 cochange=pack:5,refs:3,setup:2,transport:2,merge:1
+gettext.h component=? role=public prefix=i18n cochange=transport:2,setup:1
+git-compat-util.h component=? role=public prefix=git-compat-util cochange=setup:48,index:35,odb:22,pack:21,diff:17
+git-curl-compat.h component=transport role=header prefix=git-curl-compat cochange=transport:22
+git-zlib.c component=? role=lib prefix=git-zlib cochange=archive:2,odb:1,transport:1
+git-zlib.h component=? role=public prefix=git-zlib cochange=archive:3,setup:2,odb:1,transport:1
+git.c component=? role=lib prefix=git includes=setup:4,odb:2,convert:1,index:1,revision:1 cochange=setup:70,revision:54,transport:47,index:28,diff:25
+gpg-interface.c component=? role=lib prefix=gpg-interface includes=setup:3,index:1,odb:1 cochange=revision:25,odb:22,setup:13,transport:11,diff:8
+gpg-interface.h component=? role=public prefix=gpg-interface cochange=odb:22,revision:15,merge:4,transport:3,refs:1
+graph.c component=revision role=lib prefix=graph includes=revision:2,odb:1,setup:1 cochange=revision:38,diff:23,index:4,odb:3,transport:3
+graph.h component=revision role=header prefix=graph includes=diff:1 cochange=revision:19,diff:2,odb:1
+grep.c component=? role=lib prefix=grep includes=diff:4,odb:1,revision:1,setup:1 cochange=diff:40,revision:28,transport:10,index:7,refs:7
+grep.h component=? role=public prefix=grep includes=diff:1 cochange=revision:23,diff:10,transport:4,index:2,refs:2
+hash-lookup.c component=odb role=lib prefix=hash includes=odb:2,index:1 cochange=pack:14,odb:12,diff:1,index:1,merge:1
+hash-lookup.h component=odb role=header prefix=hash-lookup cochange=odb:10,pack:8,diff:1,merge:1,revision:1
+hash.c component=odb role=lib prefix=hash includes=odb:1 cochange=odb:15,diff:2,setup:2,index:1,transport:1
+hash.h component=odb role=header prefix=hash includes=setup:1 cochange=odb:32,pack:11,index:9,diff:7,transport:4
+hashmap.c component=? role=lib prefix=hashmap cochange=diff:33,revision:19,index:17,refs:13,submodule:13
+hashmap.h component=? role=public prefix=hashmap cochange=diff:39,revision:23,index:18,submodule:14,refs:13
+help.c component=? role=lib prefix=help includes=setup:4,index:1,odb:1,refs:1,transport:1 cochange=setup:19,transport:19,diff:9,index:8,odb:7
+help.h component=? role=public prefix=help cochange=diff:1,odb:1,revision:1,transport:1
+hex-ll.c component=? role=lib prefix=hex-ll
+hex-ll.h component=? role=public prefix=hex-ll
+hex.c component=? role=lib prefix=hex includes=odb:1 cochange=odb:7,revision:5,notes:3,transport:3,refs:2
+hex.h component=? role=public prefix=hex includes=odb:1 cochange=revision:3,odb:2,convert:1,merge:1,pack:1
+hook.c component=setup role=lib prefix=hook includes=setup:4 cochange=setup:37,transport:10,odb:8,refs:5,diff:3
+hook.h component=setup role=header prefix=hook includes=setup:1 cochange=setup:34,transport:6,odb:5,refs:5,pack:3
+http-backend.c component=? role=program prefix=http-backend includes=setup:4,odb:3,transport:2,pack:1,refs:1 cochange=transport:57,pack:41,setup:19,refs:14,revision:13
+http-fetch.c component=? role=program prefix=http-fetch includes=setup:3,transport:2 cochange=transport:46,setup:10,pack:9,index:7,refs:7
+http-push.c component=? role=program prefix=http-push includes=odb:7,revision:3,setup:3,transport:2,diff:1 cochange=transport:272,odb:134,revision:82,pack:60,diff:34
+http-walker.c component=transport role=lib prefix=http includes=transport:3,odb:2,pack:1,revision:1,setup:1 cochange=transport:73,pack:40,odb:17,index:11,refs:7
+http.c component=transport role=lib prefix=http includes=transport:4,setup:3,odb:2,pack:2 cochange=transport:195,pack:71,odb:27,diff:8,setup:8
+http.h component=transport role=header prefix=http includes=transport:1 cochange=transport:149,pack:15,diff:6,odb:4,archive:3
+ident.c component=setup role=lib prefix=ident includes=setup:2 cochange=setup:19,revision:10,odb:6,refs:6,pack:4
+ident.h component=setup role=header prefix=ident cochange=setup:3,revision:1
+imap-send.c component=? role=program prefix=imap-send includes=setup:3,transport:1 cochange=transport:47,diff:16,index:16,refs:9,odb:8
+iterator.h component=? role=public prefix=refs cochange=index:2,refs:2
+json-writer.c component=? role=lib prefix=json-writer
+json-writer.h component=? role=public prefix=json-writer cochange=transport:1
+khash.h component=? role=public prefix=khash includes=odb:1 cochange=odb:7,pack:5,diff:4,revision:4,index:3
+kwset.c component=? role=lib prefix=kwset cochange=convert:2,diff:1,pack:1,revision:1
+kwset.h component=? role=public prefix=kwset
+levenshtein.c component=? role=lib prefix=? cochange=diff:2,revision:2,odb:1
+levenshtein.h component=? role=public prefix=? cochange=transport:2,diff:1,refs:1,setup:1
+line-log.c component=revision role=lib prefix=line-log includes=odb:4,revision:4,diff:3,setup:2,pack:1 cochange=revision:52,diff:48,odb:23,pack:15,notes:8
+line-log.h component=revision role=header prefix=line-log includes=diff:1 cochange=revision:20,odb:3,diff:2,setup:1,submodule:1
+line-range.c component=revision role=lib prefix=line-range includes=diff:2,revision:1 cochange=revision:14,diff:8,archive:1,odb:1,pack:1
+line-range.h component=revision role=header prefix=line-range cochange=revision:13
+linear-assignment.c component=? role=lib prefix=linear-assignment cochange=diff:1,revision:1
+linear-assignment.h component=? role=public prefix=linear-assignment
+list-objects-filter-options.c component=revision role=lib prefix=list-objects-filter-options includes=revision:1,setup:1,transport:1 cochange=revision:39,transport:21,setup:9,diff:6,index:4
+list-objects-filter-options.h component=revision role=header prefix=list-objects-filter includes=odb:1 cochange=revision:40,transport:17,odb:4,diff:3,refs:2
+list-objects-filter.c component=revision role=lib prefix=list-objects-filter includes=odb:5,revision:3,diff:1,index:1 cochange=revision:32,odb:13,index:10,diff:6,pack:3
+list-objects-filter.h component=revision role=header prefix=list-objects cochange=revision:16,odb:1
+list-objects.c component=revision role=lib prefix=list-objects includes=odb:6,revision:4,diff:1,pack:1,setup:1 cochange=revision:91,odb:68,pack:40,transport:28,index:15
+list-objects.h component=revision role=header prefix=list-objects cochange=revision:32,pack:13,transport:4,odb:1
+list.h component=revision role=header prefix=list cochange=submodule:2,transport:2,index:1,revision:1
+lockfile.c component=? role=lib prefix=lockfile includes=setup:1 cochange=refs:18,index:13,setup:9,diff:8,merge:3
+lockfile.h component=? role=public prefix=lockfile cochange=index:5,revision:4,diff:3,refs:3,odb:2
+log-tree.c component=revision role=lib prefix=format-patch includes=odb:8,revision:5,diff:3,setup:3,refs:2 cochange=revision:222,diff:112,odb:112,refs:31,transport:16
+log-tree.h component=revision role=header prefix=format-patch cochange=revision:64,diff:11,refs:3,odb:2,transport:2
+loose.c component=odb role=lib prefix=loose includes=odb:5,setup:1 cochange=odb:31,pack:18,setup:7,transport:6,refs:2
+loose.h component=odb role=header prefix=loose cochange=odb:8,setup:3
+ls-refs.c component=refs role=lib prefix=ls-refs includes=setup:3,refs:2,odb:1,transport:1 cochange=refs:26,transport:17,pack:10,revision:5,odb:4
+ls-refs.h component=refs role=header prefix=ls-refs cochange=transport:11,refs:5,submodule:1
+mailinfo.c component=? role=lib prefix=mailinfo includes=setup:2 cochange=transport:5,index:3,notes:3,odb:3,revision:3
+mailinfo.h component=? role=public prefix=mailinfo
+mailmap.c component=? role=lib prefix=mailmap includes=setup:3,odb:2 cochange=setup:13,transport:11,refs:10,index:8,revision:5
+mailmap.h component=? role=public prefix=mailmap cochange=setup:8,revision:4,transport:2,diff:1,index:1
+match-trees.c component=odb role=lib prefix=match-trees includes=odb:5,setup:1 cochange=odb:33,index:15,notes:15,revision:12,pack:10
+match-trees.h component=odb role=header prefix=match-trees cochange=merge:1,odb:1
+mem-pool.c component=? role=lib prefix=mem-pool cochange=index:6
+mem-pool.h component=? role=public prefix=mem-pool cochange=index:4
+merge-blobs.c component=merge role=lib prefix=object-store includes=merge:2,odb:2 cochange=merge:9,notes:3,diff:2,convert:1,odb:1
+merge-blobs.h component=merge role=header prefix=merge-blobs cochange=merge:2
+merge-ll.c component=merge role=lib prefix=merge-ll includes=convert:2,diff:1,merge:1,setup:1 cochange=merge:11,diff:6,transport:4,convert:2,index:2
+merge-ll.h component=merge role=header prefix=merge-ll cochange=merge:11,diff:2,convert:1,notes:1
+merge-ort-wrappers.c component=merge role=lib prefix=merge-ort includes=odb:4,merge:2,index:1,setup:1 cochange=merge:7,odb:2,notes:1,revision:1
+merge-ort-wrappers.h component=merge role=header prefix=merge includes=merge:1 cochange=merge:9,odb:2,revision:1
+merge-ort.c component=merge role=lib prefix=merge-ort includes=odb:8,index:6,diff:3,merge:2,revision:2 cochange=diff:41,merge:32,index:23,odb:23,revision:16
+merge-ort.h component=merge role=header prefix=merge-ort includes=odb:1 cochange=merge:19,odb:2,revision:2,diff:1
+merge.c component=merge role=lib prefix=merge includes=odb:4,index:2,merge:1,setup:1 cochange=index:22,merge:6,setup:4,diff:2,odb:2
+merge.h component=merge role=header prefix=merge cochange=merge:1
+mergesort.h component=? role=public prefix=mergesort cochange=odb:1
+midx-write.c component=pack role=lib prefix=midx-write includes=pack:5,odb:2,revision:2,refs:1,setup:1 cochange=pack:100,odb:20,refs:7,transport:6,setup:4
+midx.c component=pack role=lib prefix=midx includes=pack:5,index:1,odb:1,setup:1 cochange=pack:220,odb:34,transport:11,index:6,setup:4
+midx.h component=pack role=header prefix=midx cochange=pack:134,odb:5,setup:2,transport:2,refs:1
+name-hash.c component=index role=lib prefix=name-hash includes=index:3,odb:1,setup:1 cochange=diff:43,index:39,revision:18,setup:14,refs:12
+name-hash.h component=index role=header prefix=name-hash cochange=index:7
+notes-cache.c component=notes role=lib prefix=notes includes=odb:3,notes:1,refs:1,revision:1,setup:1 cochange=notes:37,odb:29,diff:10,index:10,revision:9
+notes-cache.h component=notes role=header prefix=notes-cache includes=notes:1 cochange=diff:7,notes:3
+notes-merge.c component=notes role=lib prefix=notes-merge includes=odb:4,diff:3,notes:3,index:1,merge:1 cochange=diff:54,revision:41,odb:37,notes:36,index:30
+notes-merge.h component=notes role=header prefix=notes-merge includes=notes:1 cochange=notes:18,odb:2
+notes-utils.c component=notes role=lib prefix=commit includes=setup:2,notes:1,odb:1,refs:1 cochange=notes:33,odb:15,refs:9,transport:9,revision:8
+notes-utils.h component=notes role=header prefix=notes includes=notes:1 cochange=notes:17,odb:6
+notes.c component=notes role=lib prefix=notes includes=odb:4,setup:2,notes:1,refs:1 cochange=notes:63,odb:58,revision:41,transport:36,index:24
+notes.h component=notes role=header prefix=notes cochange=notes:55,revision:20,setup:9,odb:3,refs:2
+object-file-convert.c component=odb role=lib prefix=object-file-convert includes=odb:5,setup:1 cochange=odb:8,setup:2,transport:1
+object-file-convert.h component=odb role=header prefix=object-file-convert includes=odb:1 cochange=odb:4
+object-file.c component=odb role=lib prefix=object-file includes=odb:6,index:2,pack:2,setup:2,convert:1 cochange=odb:183,pack:96,index:55,setup:30,transport:27
+object-file.h component=odb role=header prefix=object-file includes=odb:2 cochange=odb:113,pack:30,index:12,notes:5,transport:5
+object-name.c component=odb role=lib prefix=object-name includes=odb:8,setup:5,index:2,revision:2,pack:1 cochange=odb:46,pack:31,revision:23,setup:19,refs:18
+object-name.h component=odb role=header prefix=object-name includes=odb:1 cochange=odb:5,revision:3,refs:2,index:1
+object.c component=odb role=lib prefix=object includes=odb:8,index:1,pack:1 cochange=odb:265,pack:61,revision:55,transport:34,refs:17
+object.h component=odb role=header prefix=object includes=odb:1 cochange=odb:187,revision:54,transport:41,pack:29,refs:20
+odb.c component=odb role=lib prefix=odb includes=odb:7,pack:3,setup:3,index:1,submodule:1 cochange=odb:123,pack:64,setup:13,transport:12,index:8
+odb.h component=odb role=header prefix=odb includes=odb:3 cochange=odb:117,pack:71,transport:16,setup:13,index:10
+oid-array.c component=odb role=lib prefix=oid-array includes=odb:2 cochange=odb:13,pack:10,merge:2,diff:1,revision:1
+oid-array.h component=odb role=header prefix=oid-array includes=odb:1 cochange=odb:3,diff:1,index:1,refs:1,revision:1
+oidmap.c component=odb role=lib prefix=oidmap includes=odb:2 cochange=diff:11,revision:7,odb:6,refs:5,index:4
+oidmap.h component=odb role=header prefix=oidmap includes=odb:1 cochange=odb:6,revision:4,index:2,transport:2,convert:1
+oidset.c component=odb role=lib prefix=oidset includes=odb:1 cochange=odb:17,convert:2,diff:2,transport:2,index:1
+oidset.h component=odb role=header prefix=oidset cochange=odb:17,revision:1,transport:1
+oidtree.c component=odb role=lib prefix=oidtree includes=odb:2 cochange=odb:14,index:3,setup:2,diff:1,merge:1
+oidtree.h component=odb role=header prefix=oidtree includes=odb:2 cochange=odb:9
+pack-bitmap-write.c component=pack role=lib prefix=pack-bitmap-write includes=odb:7,pack:6,revision:2,setup:2,diff:1 cochange=pack:132,odb:32,revision:27,transport:10,diff:4
+pack-bitmap.c component=pack role=lib prefix=pack-bitmap includes=pack:7,odb:3,revision:3,setup:2,diff:1 cochange=pack:232,revision:30,odb:18,transport:14,refs:7
+pack-bitmap.h component=pack role=header prefix=pack-bitmap includes=pack:2,refs:1 cochange=pack:117,refs:5,odb:2,setup:2,revision:1
+pack-check.c component=pack role=lib prefix=pack-check includes=odb:2,pack:2,setup:2 cochange=pack:59,odb:26,transport:23,diff:11,index:10
+pack-mtimes.c component=pack role=lib prefix=pack-mtimes includes=pack:2,odb:1 cochange=pack:10,odb:3,transport:2,notes:1
+pack-mtimes.h component=pack role=header prefix=pack-mtimes cochange=pack:4,odb:2,setup:1,transport:1
+pack-objects.c component=pack role=lib prefix=pack-objects includes=pack:3,odb:1,setup:1 cochange=pack:66,diff:17,odb:16,transport:9,index:5
+pack-objects.h component=pack role=header prefix=pack-objects includes=pack:2,odb:1 cochange=pack:44,setup:5,odb:1
+pack-refs.c component=refs role=lib prefix=pack-refs includes=refs:2,setup:2,revision:1 cochange=refs:12,transport:8,index:2,merge:2,odb:2
+pack-refs.h component=refs role=header prefix=pack-refs cochange=refs:5
+pack-revindex.c component=pack role=lib prefix=pack-revindex includes=pack:3,odb:1,setup:1 cochange=pack:94,odb:7,index:6,transport:5,setup:4
+pack-revindex.h component=pack role=header prefix=pack-revindex cochange=pack:32,odb:1
+pack-write.c component=pack role=lib prefix=pack-write includes=pack:5,setup:2,odb:1,transport:1 cochange=pack:88,odb:21,transport:21,setup:14,index:10
+pack.h component=pack role=header prefix=pack-write includes=odb:1 cochange=pack:72,odb:13,transport:9,setup:5,revision:1
+packfile-list.c component=pack role=lib prefix=packfile includes=pack:2 cochange=pack:3
+packfile-list.h component=pack role=header prefix=packfile cochange=pack:3
+packfile.c component=pack role=lib prefix=packfile includes=odb:8,pack:7,setup:2,index:1,revision:1 cochange=pack:317,odb:134,transport:52,revision:36,index:27
+packfile.h component=pack role=header prefix=packfile includes=odb:3,pack:1,revision:1,setup:1 cochange=pack:234,odb:66,transport:32,revision:9,setup:7
+pager.c component=? role=lib prefix=pager includes=setup:4 cochange=setup:23,diff:9,transport:7,revision:3,submodule:3
+pager.h component=? role=public prefix=pager cochange=diff:3,setup:2,revision:1
+parallel-checkout.c component=index role=lib prefix=parallel-checkout includes=index:4,odb:1,setup:1,transport:1 cochange=index:26,transport:7,odb:6,diff:3,merge:3
+parallel-checkout.h component=index role=header prefix=parallel-checkout includes=convert:1 cochange=index:12,convert:1
+parse-options-cb.c component=? role=lib prefix=parse-options includes=odb:3,setup:2 cochange=revision:10,transport:10,diff:7,odb:4,refs:3
+parse-options.c component=? role=lib prefix=parse-options cochange=index:14,diff:12,setup:10,transport:10,odb:6
+parse-options.h component=? role=public prefix=parse-options cochange=diff:7,merge:4,archive:3,index:3,refs:3
+parse.c component=? role=lib prefix=parse cochange=setup:6,index:3,pack:2,convert:1
+parse.h component=? role=public prefix=config cochange=setup:6,index:3,pack:2,convert:1
+patch-delta.c component=pack role=lib prefix=patch-delta includes=pack:1 cochange=pack:23,diff:2,odb:2,transport:2,convert:1
+patch-ids.c component=diff role=lib prefix=patch-ids includes=diff:2,odb:2 cochange=diff:73,revision:34,index:14,odb:13,refs:12
+patch-ids.h component=diff role=header prefix=patch-ids includes=diff:1 cochange=diff:15,revision:3,index:1
+path-walk.c component=? role=lib prefix=path-walk includes=odb:9,revision:3,index:1,setup:1 cochange=index:2,revision:2,transport:2,odb:1,pack:1
+path-walk.h component=? role=public prefix=path-walk includes=odb:1 cochange=index:2
+path.c component=? role=lib prefix=path includes=setup:2,index:1,odb:1,pack:1,refs:1 cochange=setup:78,refs:29,index:26,transport:15,odb:12
+path.h component=? role=public prefix=path includes=setup:1 cochange=setup:23,refs:13,odb:11,index:10,pack:8
+pathspec.c component=index role=lib prefix=pathspec includes=index:4,setup:3,convert:1 cochange=index:89,setup:23,convert:16,diff:16,revision:9
+pathspec.h component=index role=header prefix=pathspec cochange=index:67,diff:11,odb:9,convert:6,submodule:4
+pkt-line.c component=transport role=lib prefix=pkt-line includes=transport:2 cochange=transport:102,pack:6,convert:5,diff:5,odb:3
+pkt-line.h component=transport role=header prefix=pkt-line cochange=transport:94,pack:5,convert:4,odb:2,diff:1
+preload-index.c component=index role=lib prefix=preload-index includes=index:6,setup:3 cochange=index:52,setup:15,diff:12,revision:5,merge:3
+preload-index.h component=index role=header prefix=preload-index cochange=index:2,setup:1
+pretty.c component=revision role=lib prefix=pretty includes=odb:3,revision:2,setup:2,diff:1,notes:1 cochange=revision:115,odb:72,refs:29,notes:23,transport:19
+pretty.h component=revision role=header prefix=pretty cochange=revision:26,refs:7,diff:5,odb:5,archive:4
+prio-queue.c component=? role=lib prefix=prio-queue cochange=odb:5,revision:5,diff:2,pack:2,transport:2
+prio-queue.h component=? role=public prefix=prio-queue cochange=odb:3,revision:2,transport:2,pack:1
+progress.c component=? role=lib prefix=progress includes=setup:1 cochange=index:11,diff:6,setup:6,pack:4,revision:2
+progress.h component=? role=public prefix=progress cochange=index:5,diff:3
+promisor-remote.c component=transport role=lib prefix=promisor-remote includes=setup:3,transport:2,odb:1,pack:1 cochange=transport:32,setup:15,odb:6,pack:5,index:4
+promisor-remote.h component=transport role=header prefix=promisor-remote includes=setup:1 cochange=transport:18,setup:7,diff:4,index:3,revision:3
+prompt.c component=? role=lib prefix=prompt includes=setup:2 cochange=index:7,setup:6,pack:4,diff:3,transport:2
+prompt.h component=? role=public prefix=prompt cochange=transport:1
+protocol-caps.c component=transport role=lib prefix=protocol-caps includes=odb:3,transport:2,setup:1 cochange=transport:6,odb:3,refs:2,merge:1,setup:1
+protocol-caps.h component=transport role=header prefix=protocol-caps cochange=transport:6,refs:2
+protocol.c component=transport role=lib prefix=protocol includes=setup:2,transport:1 cochange=transport:21,index:4,setup:4,refs:2,diff:1
+protocol.h component=transport role=header prefix=protocol cochange=transport:5
+prune-packed.c component=pack role=lib prefix=environment includes=pack:2,odb:1,setup:1 cochange=pack:13,odb:7,setup:5,diff:3,revision:3
+prune-packed.h component=pack role=header prefix=? cochange=pack:1
+pseudo-merge.c component=pack role=lib prefix=pseudo-merge includes=odb:3,pack:2,refs:1,setup:1 cochange=pack:21,refs:3
+pseudo-merge.h component=pack role=header prefix=pseudo-merge cochange=pack:17
+quote.c component=? role=lib prefix=quote cochange=index:15,diff:12,transport:7,odb:6,revision:6
+quote.h component=? role=public prefix=quote cochange=diff:8,transport:6,index:5,odb:5,refs:5
+range-diff.c component=diff role=lib prefix=range-diff includes=diff:4,odb:2,revision:2,setup:2 cochange=diff:49,revision:26,index:9,submodule:8,setup:7
+range-diff.h component=diff role=header prefix=range-diff includes=diff:1 cochange=diff:13,revision:4
+reachable.c component=pack role=lib prefix=reachable includes=pack:4,odb:3,refs:2,revision:2,diff:1 cochange=odb:60,pack:57,revision:47,transport:17,refs:14
+reachable.h component=pack role=header prefix=prune cochange=pack:5
+read-cache-ll.h component=index role=header prefix=read-cache includes=index:1,odb:1 cochange=index:8,diff:1,odb:1,revision:1
+read-cache.c component=index role=lib prefix=read-cache includes=index:10,odb:6,setup:4,diff:2,submodule:2 cochange=index:240,odb:81,setup:79,diff:67,pack:46
+read-cache.h component=index role=header prefix=read-cache includes=index:2,odb:1,setup:1 cochange=index:4,setup:4,diff:2
+rebase-interactive.c component=? role=lib prefix=rebase-interactive includes=odb:3,setup:3,index:1 cochange=revision:4,transport:4,index:3,odb:3,merge:2
+rebase-interactive.h component=? role=public prefix=rebase-interactive
+rebase.c component=? role=lib prefix=rebase cochange=index:3,pack:3,setup:2,convert:1,diff:1
+rebase.h component=? role=public prefix=pull
+ref-filter.c component=refs role=lib prefix=ref-filter includes=odb:6,setup:5,refs:3,revision:2,index:1 cochange=refs:112,revision:59,odb:41,transport:40,index:30
+ref-filter.h component=refs role=header prefix=ref-filter includes=odb:2,revision:1 cochange=refs:62,revision:7,transport:6,diff:5,index:4
+reflog-walk.c component=refs role=lib prefix=reflog-walk includes=refs:2,diff:1,odb:1,revision:1,setup:1 cochange=refs:34,revision:26,index:13,diff:9,transport:8
+reflog-walk.h component=refs role=header prefix=reflog-walk cochange=revision:23,refs:19,odb:6,archive:2,index:2
+reflog.c component=refs role=lib prefix=refs includes=odb:3,refs:2,setup:2,revision:1 cochange=refs:18,transport:13,odb:9,revision:7,diff:4
+reflog.h component=refs role=header prefix=reflog includes=refs:1 cochange=refs:8,odb:3,index:1,revision:1,transport:1
+refs.c component=refs role=lib prefix=refs includes=setup:6,odb:5,refs:2,submodule:1 cochange=refs:373,transport:133,setup:116,odb:82,revision:77
+refs.h component=refs role=header prefix=refs includes=odb:2,setup:2 cochange=refs:352,transport:55,revision:34,setup:25,odb:16
+refspec.c component=refs role=lib prefix=refspec includes=refs:2,odb:1,transport:1 cochange=refs:27,transport:26,index:2,submodule:2
+refspec.h component=refs role=header prefix=refspec cochange=transport:31,refs:29,submodule:3,index:2
+remote-curl.c component=transport role=lib prefix=remote-curl includes=transport:9,setup:3,odb:1 cochange=transport:226,diff:9,revision:6,setup:5,archive:4
+remote.c component=transport role=lib prefix=remote includes=odb:3,setup:3,transport:3,refs:2,revision:2 cochange=transport:272,refs:91,revision:56,index:51,odb:30
+remote.h component=transport role=header prefix=remote includes=odb:1,refs:1 cochange=transport:245,refs:24,index:12,revision:6,setup:2
+repack-cruft.c component=pack role=lib prefix=repack includes=pack:2,setup:1 cochange=pack:8,transport:2,odb:1
+repack-filtered.c component=pack role=lib prefix=repack includes=pack:1,setup:1 cochange=pack:1
+repack-geometry.c component=pack role=lib prefix=repack includes=pack:3,setup:1 cochange=pack:25,transport:2,odb:1
+repack-midx.c component=pack role=lib prefix=repack includes=odb:3,pack:3,refs:1 cochange=pack:23,refs:3,setup:2,merge:1,odb:1
+repack-promisor.c component=pack role=lib prefix=repack-promisor includes=pack:3,setup:1 cochange=pack:8,odb:3,revision:2
+repack.c component=pack role=lib prefix=repack includes=pack:3,index:1,odb:1,setup:1 cochange=pack:31,transport:2,odb:1
+repack.h component=pack role=header prefix=repack includes=revision:1 cochange=pack:28
+replace-object.c component=odb role=lib prefix=refs includes=odb:4,refs:1,setup:1 cochange=odb:8,setup:6,refs:5,pack:3,diff:2
+replace-object.h component=odb role=header prefix=replace-object includes=odb:2,setup:1 cochange=odb:11,setup:9,pack:4,revision:3,merge:1
+replay.c component=? role=lib prefix=replay includes=odb:2,merge:1,refs:1,revision:1,setup:1 cochange=transport:1
+replay.h component=? role=public prefix=replay includes=odb:1
+repo-settings.c component=setup role=lib prefix=repo-settings includes=setup:4,pack:2 cochange=setup:65,pack:17,index:8,transport:8,odb:6
+repo-settings.h component=setup role=header prefix=environment cochange=setup:40,pack:7,refs:6,odb:4,diff:2
+repository.c component=setup role=lib prefix=repository includes=setup:4,odb:3,index:2,transport:2,refs:1 cochange=setup:141,odb:39,index:27,refs:18,submodule:17
+repository.h component=setup role=header prefix=repository includes=setup:2 cochange=setup:157,index:31,refs:25,pack:22,odb:19
+rerere.c component=merge role=lib prefix=rerere includes=index:4,merge:2,odb:2,setup:2,diff:1 cochange=index:54,merge:29,pack:26,odb:25,transport:25
+rerere.h component=merge role=header prefix=rerere cochange=merge:16,odb:1
+reset.c component=? role=lib prefix=reset includes=odb:3,index:2,refs:1,setup:1 cochange=index:9,merge:5,odb:3,notes:2,revision:2
+reset.h component=? role=public prefix=reset includes=odb:1,setup:1
+resolve-undo.c component=index role=lib prefix=resolve-undo includes=index:4,odb:1 cochange=index:33,merge:5,revision:4,diff:3,notes:2
+resolve-undo.h component=index role=header prefix=resolve-undo includes=odb:1 cochange=index:12,merge:3,archive:1,revision:1
+revision.c component=revision role=lib prefix=revision includes=odb:9,revision:8,index:4,setup:4,diff:3 cochange=revision:379,diff:194,odb:181,refs:109,pack:101
+revision.h component=revision role=header prefix=revision includes=odb:4,revision:3,diff:1,notes:1,setup:1 cochange=revision:304,odb:48,diff:24,pack:19,refs:15
+run-command.c component=? role=lib prefix=run-command includes=setup:2,index:1,pack:1 cochange=transport:27,index:21,setup:14,odb:8,submodule:6
+run-command.h component=? role=public prefix=run-command cochange=transport:21,setup:8,odb:6,submodule:5,refs:4
+sane-ctype.h component=? role=public prefix=sane-ctype
+scalar.c component=? role=lib prefix=scalar includes=index:3,setup:2,pack:1,refs:1 cochange=setup:9,transport:7,pack:4,index:3,merge:3
+send-pack.c component=transport role=lib prefix=send-pack includes=transport:6,odb:3,setup:2,revision:1 cochange=transport:177,odb:29,revision:17,refs:15,pack:8
+send-pack.h component=transport role=header prefix=send-pack cochange=transport:39
+sequencer.c component=? role=lib prefix=sequencer includes=odb:8,index:5,merge:4,setup:4,revision:3 cochange=revision:84,odb:83,index:77,refs:60,transport:55
+sequencer.h component=? role=public prefix=sequencer includes=index:1 cochange=revision:5,index:4,notes:3,odb:3,transport:3
+serve.c component=transport role=lib prefix=serve includes=transport:6,setup:3,odb:1,refs:1 cochange=transport:53,refs:7,odb:4,setup:3,index:1
+serve.h component=transport role=header prefix=serve cochange=transport:9,refs:3,submodule:1
+server-info.c component=pack role=lib prefix=server-info includes=odb:5,pack:2,index:1,refs:1,setup:1 cochange=pack:40,transport:34,odb:33,setup:13,refs:10
+server-info.h component=pack role=header prefix=server-info cochange=pack:2
+setup.c component=setup role=lib prefix=setup includes=setup:4,odb:2,refs:2,index:1,revision:1 cochange=setup:177,refs:47,transport:44,index:39,odb:24
+setup.h component=setup role=header prefix=setup includes=refs:1 cochange=setup:70,refs:8,index:5,revision:4,submodule:4
+sh-i18n--envsubst.c component=? role=program prefix=sh-i18n--envsubst cochange=index:3,diff:1,transport:1
+sha1dc_git.c component=? role=lib prefix=sha1dc cochange=diff:3,odb:2,revision:2,setup:1
+sha1dc_git.h component=? role=public prefix=sha1dc cochange=odb:2
+shallow.c component=revision role=lib prefix=shallow includes=odb:5,revision:4,diff:1,index:1,refs:1 cochange=odb:83,transport:73,revision:31,index:20,refs:14
+shallow.h component=revision role=header prefix=shallow includes=odb:2,setup:1 cochange=revision:10,transport:7,odb:5,diff:3,index:2
+shell.c component=? role=program prefix=shell includes=setup:1 cochange=transport:10,setup:4,revision:2
+shortlog.h component=? role=public prefix=shortlog cochange=revision:2
+sideband.c component=transport role=lib prefix=sideband includes=transport:2,setup:1 cochange=transport:51,revision:6,diff:5,index:5,refs:4
+sideband.h component=transport role=header prefix=sideband cochange=transport:23
+sigchain.c component=? role=lib prefix=sigchain cochange=diff:2,transport:1
+sigchain.h component=? role=public prefix=sigchain cochange=diff:2
+simple-ipc.h component=? role=public prefix=simple-ipc includes=transport:1 cochange=submodule:1
+sparse-index.c component=index role=lib prefix=sparse-index includes=index:7,setup:3,odb:1 cochange=index:42,setup:17,diff:2,odb:2,revision:1
+sparse-index.h component=index role=header prefix=sparse-index cochange=index:16,setup:4,merge:1,revision:1
+split-index.c component=index role=lib prefix=split-index includes=index:2,odb:1,setup:1 cochange=index:46,odb:5,revision:4,pack:3,merge:2
+split-index.h component=index role=header prefix=split-index includes=odb:1 cochange=index:21,archive:1,merge:1,revision:1
+stable-qsort.c component=? role=lib prefix=stable-qsort
+statinfo.c component=index role=lib prefix=environment includes=setup:2,index:1 cochange=index:9,setup:6,diff:2,odb:1,revision:1
+statinfo.h component=index role=header prefix=statinfo cochange=index:8,odb:1,revision:1
+strbuf.c component=? role=lib prefix=strbuf cochange=index:16,odb:12,setup:11,revision:10,transport:10
+strbuf.h component=? role=public prefix=strbuf cochange=revision:15,index:14,odb:14,diff:7,setup:7
+string-list.c component=? role=lib prefix=string-list cochange=transport:14,index:8,notes:7,refs:7,diff:5
+string-list.h component=? role=public prefix=string-list cochange=transport:19,index:6,notes:6,diff:5,refs:5
+strmap.c component=? role=lib prefix=strmap
+strmap.h component=? role=public prefix=strmap
+strvec.c component=? role=lib prefix=strvec
+strvec.h component=? role=public prefix=strvec cochange=submodule:3,revision:2,index:1,transport:1
+sub-process.c component=? role=lib prefix=sub-process includes=transport:1 cochange=diff:19,convert:12,revision:11,index:8,refs:8
+sub-process.h component=? role=public prefix=sub-process cochange=convert:8,transport:6,refs:5,diff:4,odb:4
+submodule-config.c component=submodule role=lib prefix=submodule-config includes=odb:3,setup:3,submodule:2,index:1 cochange=submodule:60,setup:41,diff:36,revision:27,odb:22
+submodule-config.h component=submodule role=header prefix=submodule-config includes=odb:1,setup:1,submodule:1 cochange=submodule:54,setup:9,odb:3,diff:2,index:2
+submodule.c component=submodule role=lib prefix=submodule includes=odb:5,setup:4,diff:2,index:2,refs:2 cochange=submodule:134,diff:83,setup:66,index:60,revision:49
+submodule.h component=submodule role=header prefix=submodule cochange=submodule:128,index:22,diff:21,transport:17,setup:6
+symlinks.c component=index role=lib prefix=symlinks includes=index:1,setup:1 cochange=index:23,diff:3,archive:2,convert:1,revision:1
+symlinks.h component=index role=header prefix=symlinks cochange=index:9,diff:1
+tag.c component=odb role=lib prefix=tag includes=odb:7,setup:2,pack:1 cochange=odb:189,transport:36,pack:32,revision:29,refs:14
+tag.h component=odb role=header prefix=tag includes=odb:1 cochange=odb:60,transport:10,revision:8,refs:7,pack:6
+tar.h component=? role=public prefix=tar-tree
+tempfile.c component=? role=lib prefix=tempfile cochange=pack:5,setup:4,index:3,odb:3,revision:3
+tempfile.h component=? role=public prefix=tempfile includes=revision:1 cochange=revision:3,diff:2,index:2,setup:2
+thread-utils.c component=? role=lib prefix=thread-utils cochange=diff:1
+thread-utils.h component=? role=public prefix=thread-utils cochange=transport:1
+tmp-objdir.c component=odb role=lib prefix=tmp-objdir includes=odb:3,setup:2,index:1 cochange=pack:24,odb:23,setup:8,transport:5,revision:3
+tmp-objdir.h component=odb role=header prefix=tmp-objdir cochange=odb:8,revision:3,setup:1
+trace.c component=? role=lib prefix=trace includes=setup:2 cochange=setup:26,transport:13,index:11,odb:4,diff:2
+trace.h component=? role=public prefix=trace cochange=transport:6,index:5,odb:4,pack:3,revision:3
+trace2.c component=? role=lib prefix=trace2 includes=setup:2 cochange=setup:2
+trace2.h component=? role=public prefix=trace2 cochange=setup:2
+trailer.c component=? role=lib prefix=trailer includes=setup:2,odb:1,revision:1 cochange=transport:13,revision:12,odb:8,index:7,refs:6
+trailer.h component=? role=public prefix=trailer includes=revision:1 cochange=revision:7,refs:1
+transport-helper.c component=transport role=lib prefix=transport-helper includes=transport:4,odb:2,refs:2,setup:2,pack:1 cochange=transport:210,refs:23,revision:16,odb:14,index:12
+transport-internal.h component=transport role=header prefix=transport includes=transport:1 cochange=transport:42,refs:3,odb:1,submodule:1
+transport.c component=transport role=lib prefix=transport includes=transport:12,setup:3,odb:2,refs:2,submodule:1 cochange=transport:482,refs:35,setup:31,submodule:29,revision:21
+transport.h component=transport role=header prefix=transport includes=transport:2,revision:1 cochange=transport:249,submodule:6,odb:4,revision:2,diff:1
+tree-diff.c component=diff role=lib prefix=tree-diff includes=odb:3,diff:2,index:1,setup:1 cochange=diff:115,odb:56,revision:53,index:36,notes:12
+tree-walk.c component=odb role=lib prefix=tree-walk includes=odb:4,index:3,setup:1 cochange=odb:70,index:61,diff:31,revision:24,pack:13
+tree-walk.h component=odb role=header prefix=tree-walk includes=odb:1 cochange=odb:64,diff:23,index:23,revision:21,notes:7
+tree.c component=odb role=lib prefix=tree includes=odb:6,setup:2 cochange=odb:212,revision:45,index:36,pack:25,transport:21
+tree.h component=odb role=header prefix=tree includes=odb:1 cochange=odb:75,revision:12,archive:8,index:6,pack:5
+unicode-width.h component=? role=public prefix=unicode
+unix-socket.c component=? role=lib prefix=unix-socket cochange=diff:3,revision:2,setup:1
+unix-socket.h component=? role=public prefix=unix-socket
+unix-stream-server.c component=? role=lib prefix=unix-stream-server
+unix-stream-server.h component=? role=public prefix=unix-stream-server
+unpack-trees.c component=index role=lib prefix=unpack-trees includes=index:11,odb:3,setup:3,submodule:2,convert:1 cochange=index:262,odb:49,diff:41,transport:19,revision:18
+unpack-trees.h component=index role=header prefix=unpack-trees includes=convert:1,index:1,odb:1 cochange=index:75,diff:9,odb:6,setup:5,merge:4
+upload-pack.c component=transport role=lib prefix=upload-pack includes=transport:6,odb:4,revision:4,setup:4,diff:1 cochange=transport:198,odb:88,revision:80,refs:55,pack:34
+upload-pack.h component=transport role=header prefix=upload-pack cochange=transport:18,refs:5,submodule:1
+url.c component=? role=lib prefix=url cochange=transport:12,revision:8,diff:6,index:2,refs:2
+url.h component=? role=public prefix=url cochange=transport:9,revision:4,submodule:1
+urlmatch.c component=? role=lib prefix=urlmatch cochange=diff:3,odb:2,revision:2,setup:2,transport:2
+urlmatch.h component=? role=public prefix=urlmatch includes=setup:1 cochange=transport:1
+usage.c component=? role=lib prefix=usage cochange=index:3,odb:2,diff:1,revision:1,setup:1
+userdiff.c component=diff role=lib prefix=userdiff includes=setup:2,convert:1,diff:1 cochange=diff:41,convert:34,archive:11,index:7,transport:6
+userdiff.h component=diff role=header prefix=diff includes=notes:1 cochange=diff:40,notes:2,archive:1,merge:1,revision:1
+utf8.c component=? role=lib prefix=utf8 cochange=revision:6,index:3,setup:3,transport:2,convert:1
+utf8.h component=? role=public prefix=utf8 cochange=revision:6,index:2,setup:2,transport:2,convert:1
+varint.c component=? role=lib prefix=varint cochange=index:2,transport:1
+varint.h component=? role=public prefix=varint cochange=index:2,transport:1
+version.c component=setup role=lib prefix=version includes=setup:1 cochange=setup:8,transport:2
+version.h component=setup role=header prefix=version cochange=setup:8,transport:2
+versioncmp.c component=? role=lib prefix=versioncmp includes=setup:1 cochange=setup:5,pack:3,transport:3,index:2,refs:2
+versioncmp.h component=? role=public prefix=versioncmp cochange=refs:1
+walker.c component=transport role=lib prefix=refs includes=odb:6,refs:1,setup:1,transport:1 cochange=odb:70,transport:55,revision:42,refs:24,pack:17
+walker.h component=transport role=header prefix=walker includes=transport:1 cochange=transport:19
+wildmatch.c component=? role=lib prefix=hex cochange=index:4,refs:3,diff:1,odb:1,revision:1
+wildmatch.h component=? role=public prefix=? cochange=index:3,refs:2,diff:1,revision:1,setup:1
+worktree.c component=refs role=lib prefix=worktree includes=setup:4,index:2,refs:2 cochange=refs:73,setup:53,index:22,submodule:13,pack:11
+worktree.h component=refs role=header prefix=worktree includes=refs:1 cochange=refs:61,revision:10,pack:5,setup:5,odb:4
+wrapper.c component=? role=lib prefix=wrapper cochange=setup:21,index:16,pack:6,transport:5,convert:4
+wrapper.h component=? role=public prefix=wrapper cochange=index:2,revision:1,setup:1
+write-or-die.c component=? role=lib prefix=write-or-die cochange=pack:6,setup:6,index:4,transport:2,convert:1
+write-or-die.h component=? role=public prefix=write-or-die
+ws.c component=convert role=lib prefix=whitespace includes=convert:2 cochange=convert:24,diff:18,archive:9,index:5,setup:5
+ws.h component=convert role=header prefix=whitespace cochange=diff:5,convert:2,setup:2
+wt-status.c component=index role=lib prefix=wt-status includes=odb:5,index:4,setup:3,diff:2,refs:2 cochange=index:149,diff:83,transport:55,refs:45,revision:45
+wt-status.h component=index role=header prefix=wt-status includes=index:1,transport:1 cochange=index:89,diff:10,refs:9,revision:4,transport:4
+xdiff-interface.c component=diff role=lib prefix=xdiff-interface includes=setup:2,diff:1,odb:1 cochange=diff:73,index:5,merge:3,notes:3,refs:3
+xdiff-interface.h component=diff role=header prefix=xdiff-interface includes=odb:1 cochange=diff:62,index:2,notes:2,merge:1,odb:1
-- 
2.54.0

