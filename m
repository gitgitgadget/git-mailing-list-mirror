Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60131197C
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223921; cv=pass; b=bDokFRFZzSJNDQMp53z70vGeJjwYVFGvMf5gqBevnO4Zrqmz+fqEJf+fQbTe228/Gu83dfy/ITuVaz2cZ/hYgDy6R+QOoy+NWG/9AftpOJa9Iq9uSpicUHtBPXoIQ1nQK0F4ps84G14BfhUG6gG3Gb0+6KaQTJnzPmwnyQHUKYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223921; c=relaxed/simple;
	bh=CPpOGOL6slVbmDOK3/SoPYnnTdt/MdicIkh5000siZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUNc7lUUK/z59KelHYTjgBUXa/jDQywiu7oQ1ESVI3MwA95pWb2cPwOxNJ/wfbN+Y4KHyFJ18W61f9oNbFqesYa06sfT9+JyJFq4Ag6q5rBgQ9t1VlTPTdnSS5qT2jClRYwFAKqVTWhsmNip3yp/ZPpSNsgGSUbXvfCg2k8cqD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=iW9Bdb0y; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="iW9Bdb0y"
ARC-Seal: i=1; a=rsa-sha256; t=1770223906; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L4RoNIxwaqrWxUXuQ5cC6HyeNTDv56S0ZHyPda86icTfoZOa4TaHqSd5DjEjsCjaGMtHc1r+RpKttq/UMVPYNnp6loRdHRxuYyXYyeZLWcOYJrQwM31YtWnZd5g4IYF1htVbvmVVztJNZjfvrHDq9utIIdYJInD6MHZ360BwS+w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770223906; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k63GSY/V3oCN5C8kJsYiWdZNg2qmGBeUvt0omyA01bc=; 
	b=GU0SoKd1XPamJ3tshc4NW/Hyp7/KZphReGoEBpWvMkHh/Is5LtJk8gRzoAoeQlHd8hk2dwx0xljyUzIxjMzQxRCoFEi3/rZsJrsQpbEcBkuaMp5mPYLxgF+E929N8jrzuHDm4aA4huNl5YFWq7Kk9RumnyXjXha7iYcCv0jxHME=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770223906;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=k63GSY/V3oCN5C8kJsYiWdZNg2qmGBeUvt0omyA01bc=;
	b=iW9Bdb0yOLY2UMnXU3mHZsvykZsVuOYUlcP4HfpVw8wqQC2aA7XJ1xeIj+zdK9Dl
	bOuwCb2NfWQoIj/oTGyREq2Uj6YQvY5KuDhyYSTAnJTdgQhK1RqyUSEK8tE3gsGWoXd
	MfGYaRwtpw3qr8KmCq6slneHjiQgIJxQKUHetSh8=
Received: by mx.zohomail.com with SMTPS id 1770223902895723.222180560817;
	Wed, 4 Feb 2026 08:51:42 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 0/4] Specify hooks via configs
Date: Wed,  4 Feb 2026 18:51:22 +0200
Message-ID: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hello everyone,

This series adds a new feature: the ability to specify commands to run
for hook events via config entries (including shell commands).

The config schema is identical to the one developed by Emily and AEvar
a few years ago [1] though the implementation is significantly different
because it's based on the new / cleaned-up hook.[ch] APIs. [2].

For simplicity, hooks are still executed sequentially (.jobs == 1) in
this series, just like before. Parallel execution will be enabled in
a separate series based on this one.

The hook execution order is this:
1. Hooks read from the config. If multiple hook commands are specified
   for a single event, they are executed in config discovery order.
2. The default hooks from the hookdir.

The above order can be changed if necessary.

Again, this is based on the latest v8 hooks-conversion series [2] which
has not yet landed in next or master.

Branch pused to GitHub: [3]
Succesful CI run: [4]

Many thanks to all who contributed to this effort up to now, including
Emily, AEvar, Junio, Patrick, Peff, Kristoffer, Chris and many others.

Thank you,
Adrian

1: https://lore.kernel.org/git/20210715232603.3415111-1-emilyshaffer@google.com/
2: https://lore.kernel.org/git/20250925125352.1728840-1-adrian.ratiu@collabora.com/T/#m41f793907f46fd04f44ff1b06c53d20af38e6cb2
3: https://github.com/10ne1/git/tree/refs/heads/dev/aratiu/config-hooks-v1
4: https://github.com/10ne1/git/actions/runs/21676691521

Emily Shaffer (4):
  hook: run a list of hooks
  hook: introduce "git hook list"
  hook: include hooks from the config
  hook: allow out-of-repo 'git hook' invocations

 Documentation/config/hook.adoc |  17 +++
 Documentation/git-hook.adoc    | 131 ++++++++++++++++++++++-
 builtin/hook.c                 |  53 ++++++++++
 builtin/receive-pack.c         |  23 +++-
 git.c                          |   2 +-
 hook.c                         | 188 ++++++++++++++++++++++++++++-----
 hook.h                         |  55 +++++++++-
 refs.c                         |  23 +++-
 t/t1800-hook.sh                | 158 +++++++++++++++++++++++++--
 transport.c                    |  23 +++-
 10 files changed, 633 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/config/hook.adoc

-- 
2.52.0.732.gb351b5166d.dirty

