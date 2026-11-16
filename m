Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869515;
	b=idOZx6+rvIGz00VHwZ5N83d8Ws43BkndGoy3QBqIWgYQO19kDSlW8Cq9f5Mt6cql7U1G
	 UvZjAiaCYZKkN3EKvAFCQ8OjpKQemq8fGW9jhiCrpHdMHP3tVGtxsZGwMV++oON4/6WVA
	 eKopuNvEQj2YNUBtbupwab+yqWoT2nopEU3alEkPdyFsK81mkzBypXZhtL5+bT5lVLCgG
	 etPvyQCW/yh5ytBLiOMfTzTh9zSl/wV1FgumaEft3corehoooJEWAu3lyp/Gbps1WB31w
	 XybemanebfwfOXxZ15N2CFQZ5Y8KjG8dRTPXSeB4Swu4cG20aze3Y8cciGtqtWe8Eng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=OrCUrqzcXluMYBJljg0abPs3hdDJ/Tg5YqS4BbtIrJU=;
	b=egRfXMhECAJduYHuspbKpbM9bwdrAjXiiczMaHlo69oE9jDSDZAZcJqlRNyMtEHV4AAP
	 PUrr+WML1MrUxwZCQsUw387wBLGf6dtpf1g5IJPDi2ztUx6GQ1RlhIwVnRl1ppBodik79
	 jGOLhjPtj461lYiXirDjHysAJaJCbSj0kL70dlNuY8gKF1Qupr48YdghizY2ezxrxdeZ0
	 j1egKNswb6AyThs1whQncD+MVwStG14FbXq1SaDRBjsEdrF+MrKT1/T26uoHrbLh2FmXz
	 pOmwSbA2o/RP8Nyk8mS/G2xUZJgHD7GPAJW/RXm8lwGR5ahAPFvek4MNVwoeuvjVooQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DhyAecL2;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDF9606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 22:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CDF9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DhyAecL2
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b71b012e3cso4694707a12.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 14:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794869514; x=1795474314; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OrCUrqzcXluMYBJljg0abPs3hdDJ/Tg5YqS4BbtIrJU=;
        b=DhyAecL2F/eJR3wbCED2JmZUNR9LzfPPxJwnhB4AG+7D323UorcZ2UJfv93DXoFvWu
         R8Qyky3xfV870tmVJ7vr/luucj5BVa2G/+Y669EqS2FC2a/SmDCqv9f9bpaYf1Bm01+d
         ThuBf5yjsFgYMJ5lvbwByqL3YN+GmzHxfo/EGHrY07kCfQYinYaAEgsQ7SI/uZW9gmdi
         5fhOUW6X9obC67pynk9CeEq4305vsH0WTYKcJqLF1uDX4CXk3XD1Tr9WMtWiMiDMBWdK
         stqLMawP3a49yWGLtPQIXPVDH6xj0wFQJRKE75JJCI3B04QIQtp9hcBWU5cBQxHnp+DU
         g00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869514; x=1795474314;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OrCUrqzcXluMYBJljg0abPs3hdDJ/Tg5YqS4BbtIrJU=;
        b=O/pETHuvrys2oDAgCbEo5NYyduWYBE6iys8LdfgH5kmlLxQagrFOUwRbmz+NDXEGeU
         k3+baaBbFj2XVvQWOuAXurYFBXf22fnBSONa+ql8je7C8CLX8375S99qpbr6rK+/m6LP
         VvHQemgPqHf5loF3CX6Jmt3P62XW8EKPSAsP3SyP5ms4KioRCeXQTSvv94tJ79m0Hyyc
         UoxctoTQahTG2uPhtKq4eeYspQ7uR/kYW8YFpkUXeqZ3b0iZkzWUTPX7v2zpkpH6Jfrs
         1CeCBtProcwLE1bQYCBMBdE5XM5QvHtl2QXrh0ivmjW1Y52HL1dYmJHJFXBgpbMWj0qs
         vGSg==
X-Gm-Message-State: APuU4Z9NaJRK9UB2m/JCcijpMaQC7lTAJwpLUXQHjBPgyWEEBkYImkzR
	iNW4rUXlr3IjRO0NP9pwQ3z9lRULLO8ozfbTjrdi5eLdX3fONneqdAXhUZujp2KD
X-Gm-Gg: AYBFou2jeDuZC4Qyo8CIFpMu7tL5/w5zlJi61Mh+O6alfruwlVGpSC+wtVNmRgcgEQb
	YUTZPov0ODwqLAes3/7PGf219hm9GthXQJbSOGUwdZbZljK67P6MKDXD5u1zW91RKANZrHcWHP6
	BzHNhsDc5gOHFYM6BAUT6VThMlYzt6533x0BOOds6WsnqDvcBFnCSlm/G/0yFkaPOkVrSWt1+NB
	g9cHjxGPRyQhFsRZ2MQ2GG0wDqfdueufcwTM+BAw64crOze3nA70lhr20Z8XjKJAWs63QWKi+QA
	ZeOdoCyyIttAgz8EG+QXO+nDfD5sLftRsGUwHR4+rHlR5H8SHtdc6d2gzszWQZPJC5xuCf8hbY3
	L4pqz8syW04YWoJH+q95Ekz3ESr7fO1JoFFeaTGzUeZ7KE3efbdCd5GSOMdfA6sM5kEVSiEHO5/
	khriOzo5L5FI6YZEvOtI0rSv+T453bnjl2DoItepgxIAOzo4SYel672/RnN3MwhrHRTNsP70Qsx
	OHbwUF5/XSQi6KwwsZrkMxTjjaOxjXJ8tsezh+xu4To0Fywi+zJre1elktKnvQL7ZSBaBp55J2v
	KzWPs3879z5COcnBCvMrigeJUXs+qZ3Ow1jIlMogM+aJkCJj5QU3OAg/pKsAZ7DAs5q6kqTuLw8
	ZgnK6L4i7I2Kg0dUkc8mhULd98lDI17ZOugHXBOz2Ar90okXJUCGJSytJqAEVV5UhBxp9yO1EPd
	8je2t5RUVlKLSxm1QbokmhXzQ=
X-Received: by 2002:a17:907:3d10:b0:c49:cfcd:69e5 with SMTP id a640c23a62f3a-c509643dcabmr968543966b.32.1794869513741;
        Mon, 16 Nov 2026 14:51:53 -0800 (PST)
Received: from pampelmuse ([2a02:810d:a1:6000:5181:7d70:73a5:ff41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b427ddsm472940666b.43.2026.11.16.14.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:51:52 -0800 (PST)
Date: Mon, 16 Nov 2026 23:51:48 +0100
From: Andreas Wendleder <gonsolo@gmail.com>
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: submodule: linked-worktree submodule hits BUG() in
 validate_submodule_legacy_git_dir()
Message-ID: <avuJBGlB3pRU3JU0@pampelmuse>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With submodule.recurse=true, switching branches in a superproject worktree
whose submodule is itself a linked worktree of the submodule repository
aborts:

  BUG: submodule.c:2414: submodule name 'sub' not a suffix of git dir
  '.../.git/modules/sub/worktrees/sub1'

Reproduction (git 2.56.0; the code is the same on master, next and seen):

  #!/bin/sh
  set -e
  export GIT_CONFIG_GLOBAL=/dev/null GIT_CONFIG_NOSYSTEM=1
  g() { git -c user.name=t -c user.email=t@t -c protocol.file.allow=always "$@"; }
  rm -rf w && mkdir w && cd w
  g init -q -b main sub && g -C sub commit -q --allow-empty -m s1
  g init -q -b main super && cd super
  g submodule add -q ../sub sub && g commit -q -m add
  g -C sub commit -q --allow-empty -m s2 && g add sub && g commit -q -m bump
  g branch other HEAD~1
  g worktree add -q --detach ../wt main
  g -C sub worktree add -q --detach ../../other/sub HEAD  # takes the name 'sub'
  g -C sub worktree add -q --detach ../../wt/sub HEAD     # so this one is 'sub1'
  cd ../wt
  g -c submodule.recurse=true switch other

submodule_move_head() expects validate_submodule_git_dir() to return < 0
and then dies with "refusing to create/use ... Enabling
extensions.submodulePathConfig should fix this", but without the extension
validate_submodule_legacy_git_dir() calls BUG() instead. A linked
worktree's git dir (modules/<name>/worktrees/<id>) never ends in the
submodule name, so this setup always hits it.

With extensions.submodulePathConfig enabled (repositoryformatversion 1),
the same commands no longer crash but die with the "refusing to create/use
..." message, which recommends enabling the extension that is already
enabled.

I would expect a linked worktree of a submodule's repository to be
accepted as the submodule's git dir. If it is meant to be rejected, the
legacy path should return an error instead of calling BUG(), and the hint
should not suggest the extension when it is already on.
