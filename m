Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3285226B6
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070043; cv=none; b=WOJ0LCiVVsFNCYysk6IPSA4/q/QmF4Nv/2pY+A1embAi65/1lhvAzi5NRrPdQfTGqBKmnFA46F3h8m3UP5CEF9hkMmmNYVButUa4BCZcYpqWGocKKVczOTYlAvfoe7V7mtfzTHWZhOksBeHxAVZ/aaojPBz5SYc7ZFPE9VocrFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070043; c=relaxed/simple;
	bh=HtwoNEul6keUKWX4VO6gYPRgl7GnpXw8mf/1KZlDCkU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=EPUO44Tt4jfBk3jPn5V/UL5WRppXs/css07K5fTtAxG8Y7jjkvTqLnJAi+Yw9EGziLVuLi60WqsddgZImX0FQ2+obkAk7DX88igtdrnva7o3RuHFa0Nmt2Fpy+joJnBXAbBqu4bQPbC+HFJNXVkQNu8DXwvSkSs+bRMIEHXDSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgY93YpR; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgY93YpR"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso2116925a12.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792070041; x=1792674841; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jFnU2ykjeRxlvod6xCgm4EhbFjspUb/VW5qoAuvX7Bw=;
        b=WgY93YpRqH1LMyHHUcrm5QTpHF8YY4ktL7GYd/8IJpvqX8iJmEdUllGd6q48SZtHbz
         5GV9Bg7eS97B9bREiVYQV7V882DWJ1AXvo2kRx27pO43zDkjVN/h5HvKrs4QUwokd5us
         DfwisdnJMcGhyF1xQGcgCvr1iO4/U5nh4JOEevupnWDPByEaV8bNXnOo5qWv/7yr4edc
         FMaT1761cakFufnS7CJqtJNhtrvFFKE2fnYYliFliQO/SIf9s9ui62WNeibxYz+69Wlg
         j/1NrEFeu4J+SLVaEBa3Py4gHA9se0Kog7y2MmF5YvOjU3cN9A+a7dF5ORNwc+j3KVPx
         6PXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070041; x=1792674841;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jFnU2ykjeRxlvod6xCgm4EhbFjspUb/VW5qoAuvX7Bw=;
        b=wbLxOuXuRh51tBJRCk4ZSeoZeXPKqtMstBMIH4XVUBkYIf+IYY5g0thgPnAj6pa4vm
         bw/ViRpF4A4GHieL39vppeCitdl+tq5e4JkBd1mr6N+LVeyJwm0dkhoi38tfC7T57Cpt
         ZiXARWhbqxxdp4fCayXK+mpW5pQmQKwNJcQuFnnjVbbUTs12SNsu1PtXrBAPSUtxteGs
         1E8WtXNMWY//fsyEJx9K0Qlu6ujsuHJS/cDI5GG/GV+4j718NQHow6cnpeXlVanbdLsV
         x2aeYMWOeCxCN+GPLsgHMafwCvhEvlMNJjCdal4nUbKbmJbhPjr9X2li4dKW3UqrkEQE
         huLg==
X-Gm-Message-State: AFq9FYKaHgMt+x2K04n0ZO1FHnEDPkCwiA1GY5j89DQppnD88AMshLqv
	j5AEqril/lnvTLuCXIOo+hUB6wJry1Z5tnQ76e+9YuMbakmuLP47+pj0/GVgV/dB
X-Gm-Gg: AYBFou3SGpDvkQSmUMEQyNDwIq+2J/Aj4JaP46nwNB+ZuqNER8IyxjItXgIiVhnriXD
	ZrVRqEDBLArLH0Uxe+OCkAebE5F1ElgEsQQ3NrE1Gg6tBPb4cGqHeRJhS8Tf6ISBzgs5GXKiqXz
	xiIXa3KU7102W9UxQf1ni9eobmKysYsWTcaGklCT4R7NijYAwNyHaoB5TdAWJO0P5NpQDJBc/nP
	jLHqbCU6r79kS8Mi3rK/aA6sqDrtqqpukUThxq4GP/v1/yXKUoQQjLqdfAkZ4bPLZZHvqfaCj2C
	Sid1wiovjfxe/ilfyjRmwGCYkM4EFJ1tS0o72LNTrF8+bWcpMytYTmIx5G3D4Wq7OHTzmHq7c0i
	Uv/3vmS34Rf1VXSo2WAcBysBpI9vnIql3QctKXrCqQmXCBo395CaxfXD8wcw8Skktp/nq2oF1C8
	gugk1ecVpWFiNsyu5+yiCOeTx7bGNyboUmKxeemwGnXrpDfVQhIapPsTZq0yaKF4RS1XCF1yxwd
	w==
X-Received: by 2002:a17:90b:3a48:b0:3a7:8350:3f7e with SMTP id 98e67ed59e1d1-3ab3ae76c0bmr14080706a91.44.1792070040910;
        Thu, 15 Oct 2026 06:14:00 -0700 (PDT)
Received: from [127.0.0.1] ([20.112.122.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7548sm4611394a91.1.2026.10.15.06.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:13:59 -0700 (PDT)
Message-Id: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 13:13:55 +0000
Subject: [PATCH 0/3] reflog: add --operations and --historical-branch
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Create a better reflog. Follows the discussion in
https://lore.kernel.org/git/akZfm-igZKeHaDST@pks.im/.

"git reflog" lists every step of a rebase and every branch switch, which
makes it hard to see what was done and on which branch. This adds two
options to "git reflog" and "git log -g":

 * --operations shows one entry per command, folding a rebase into the entry
   that finished or aborted it, and leaves out entries that change no
   branch.
 * --historical-branch decorates each entry with the branch HEAD was on when
   it was recorded.

Harald Nordgren (3):
  reflog: name the strings that mark switches, renames and rebase steps
  reflog: add --operations to show one entry per command
  reflog: add --historical-branch to name the branch of each entry

 Documentation/git-reflog.adoc       |   4 +
 Documentation/rev-list-options.adoc |  19 +++
 builtin/branch.c                    |   3 +-
 builtin/checkout.c                  |   3 +-
 builtin/rebase.c                    |  17 +--
 log-tree.c                          |  21 +++
 object-name.c                       |   3 +-
 reflog-walk.c                       | 172 ++++++++++++++++++++++--
 reflog-walk.h                       |   3 +
 reflog.h                            |   6 +
 revision.c                          |  14 ++
 revision.h                          |   2 +
 sequencer.c                         |  13 +-
 t/t1414-reflog-walk.sh              | 198 ++++++++++++++++++++++++++++
 wt-status.c                         |   3 +-
 15 files changed, 455 insertions(+), 26 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2448%2FHaraldNordgren%2Freflog-operations-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2448/HaraldNordgren/reflog-operations-v1
Pull-Request: https://github.com/git/git/pull/2448
-- 
gitgitgadget
