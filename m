Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793445010;
	b=HsTitYqPc0+vYcUtJvUrBHd1tSN6vB8GJ+5+MOqX5AThoooQt00GefDQSCqtoQ6Orp5f
	 gTVztP5ukF6Jtbsav5HftuAk7xaqRmqI0E3dFggwObzZx+HL+qguUVaMHyGddWokdSFAR
	 BE7wTCKSIpiUtam54wsBSyJzwDep4Rz5uXS7parY6CMtD3/jjAyPnxsrcea9xn9FQedso
	 uDka2IpXePLJEQuRW22sm2JQWQLDLTXwOx46JBn1Ps3cZWI+qXXqRXWRTOMeGk/+TzRxL
	 BdynJVqKVHVXvUDt+0N1/mVMDtVLi5s8JkqcU94jhk3yvLnv/PYduEP3C1m1o43z8nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793445010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6IR5fKXE6fobKlGM2aV9DDc+2UlBIJWON1EB6nJGS8I=;
	b=289Et1itWXagWwEjwtgfXi3S28ZJm/0gOaZlKeyEgzzeuUH3nqMjqH/0mj2/Q9QljZa2
	 MlhI9fnDxHF5gFhbBFyt+yG23OaRTrzIEggdzuFHolfcxQYgfKFMCy6Y449V1IkjikiAh
	 bV7oRAd7VUKlXiaTPXe35r4kFQ446yQbnR6o0skkA0wJ+uXK1Q1qM7QaqRBT4wsTnMoQV
	 XlclS1e+h2kz9ur3su/j+1xJDQ6wXrtsjaa0xDqWi8D2T/yCc7Sh0rxjzMdGkuF+jF/iq
	 sLFmOcSpR25b0807XNIo8GM50I+MyJi8rAY2J7lMFK9yyJPNycUr9mNRCNTmR56UC1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=InNJmtfq;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993C606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 11:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9993C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=InNJmtfq
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e47347279so939628f8f.1
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793445008; x=1794049808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6IR5fKXE6fobKlGM2aV9DDc+2UlBIJWON1EB6nJGS8I=;
        b=InNJmtfqyhgsoFtZ9SZ09GtyPjncQQlpL2hEqtRIXIKqGR3h+7zE/rb9p/qJ2XtUB8
         UUnKfLGbt71VDjwzLHYwH7CzyJk25MZlsDczi6ELEc9vD8hGoQtL4rWlnC3TQ+XacOUa
         SwT3G4D4MG4MoYb2k4zWx9InP1PsyiMcTrv/ombYD5pKXruWT8GMELkAkojSowJWSnbs
         ezaQ2TUrx8tPw3ZPxqUMQneGoZuoTkMLPk21lh/L/6GTnXjdMuzLMDTYujr6eAnXxUX+
         YiaCQWRAHytTumRaa9/GI5h3F93SGnwOcPySEy0icSx97q5yTkpLgcbJ6uuoZxpQRxch
         5tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793445008; x=1794049808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6IR5fKXE6fobKlGM2aV9DDc+2UlBIJWON1EB6nJGS8I=;
        b=HODnf5hkzxUObHDLs7W6uDg/o2nRK/luT9Gzf4Z2Tz8KF/jvbRFxsna5iaFOmm4bl2
         tj0eQ4HfjalC5Mjy24MP8/m4Wvjd4qikwUL6F2+B4S5ORDKKT3GEI3yanchPzfNBAf9O
         0Km8L6O4Gso4PlCYiAJcDvIt5guJrqql89AIvOwMXK6x8NkIYLyKB+j/Vue/DYIoLqt0
         AtP3Gh1l8yeB9t77xypMmkguU14jxRuDuWPHpB8ZB3uUc5xAtpBAyliTRSUN16FtGQqS
         FwM95LCkK80UP/OEsX+09Dkc0rvtMSP3QkUwQ98BJKR3bdiRaaXuV/IL9wuB/DGJdkQa
         mvLQ==
X-Gm-Message-State: AFq9FYJqDN1/r/paahZTgk5/F1v9+WLUCewca8ddRbIyd3ltRJqOBXxs
	GWCBnsnBdl1NWazK47Ke4al1/9kQV7pa8rRJvHL/3mjLPMaQlMbyXe7LVBYShG1F
X-Gm-Gg: AYBFou0N+sSLRWUy2fMQ2YVTqF2izZwIz4Tnzoxu8kliQE5+NqA8dS4VWXWP8NtxHON
	gzVKfVJeOE7hc9YlojFemz2xakoLihOrObqh4I0X2bdRCCwRbID39wWVV6JYhDa/KhxoimsOOBR
	aZFpumsX+lTfwqm72q78Wp3LFVyjKPI4NcZ68FULoldGs6USxJFuQ/9XDySSyOqqo5iNPqu+OF5
	Fk++FLkBslUpdJ8XME3FwJCCyRlF342fkK0dTuRrriqP+HOReic0hX4gPS6YYZgjwxIjvqY/pw7
	d44sNVc27lU3bQ3OOzGYWeSvfJXtWZHGGP31qkV4hO4U9VQSw2pbRXays37FQPSExTvvfpSq3B0
	01LGmDQVk+amGEc60mU7uWU9P5y8khu0T28zGUwNfiCR3xshI+NLO6y/zufBUa42S9ZnhJWLMh9
	DrCO74lF/PNowRZUKxAWukn/dRc5MMlN6R+/laZqSgQcbOYPgqEuPo4BnIL1DTjqTcUIehOGMKJ
	YXxbREAbGGTm/Fo9AU4wSY9O5E/CYcGIjzs6f/0EWpvF/6NjpW6ucB8aubE0hqgzqAIiIPu6yO4
	3LpMvJMygP6mr3j+flvumsCPdkEra+aTuO0NU/f1FK8rt20OAZT/2lPF/cAGfgY=
X-Received: by 2002:a05:6000:2410:b0:48e:6674:3b2f with SMTP id ffacd0b85a97d-48e6e5005c5mr11951228f8f.51.1793445007932;
        Sat, 31 Oct 2026 04:10:07 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71ba7168sm8853670f8f.55.2026.10.31.04.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:10:06 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 0/4] use size_t when parsing and checking objects
Date: Sat, 31 Oct 2026 12:09:56 +0100
Message-ID: <cover.1793444420.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series continues the search for truncated sizes on platforms where
"long" is 32 bits (Windows). It covers the functions that parse, verify,
and check whole objects in memory: they take the size as an "unsigned
long", while their callers have a size_t, so above 4GiB the size gets
truncated.

Each patch addresses a specific component:
 - 1/4: a valid object reported as corrupt;
 - 2/4: fsck looks at only a prefix (e.g., .gitmodules);
 - 3/4: parsing of a prefix (with set_commit_buffer() now dying instead
   of caching a truncated size, as repo_get_commit_buffer() already
   does);
 - 4/4: "git tag -v" doesn't find the signature, plus the int index in
   copy_subject() on all platforms.

There are no out-of-bounds accesses; large objects only fail or are
handled as if they were shorter.

No tests are added because they would need objects over 4GiB in memory,
and they'd only detect the bug where long is 32 bits. I am happy to add
EXPENSIVE tests guarded by !LONG_IS_64BIT (like t1051) if reviewers
prefer.

Not covered here: the pack paths (index-pack, unpack-objects, pack
verification) still pass an "unsigned long" to fsck_object(); that's the
next series. The tree API (parse_tree_buffer(), init_tree_desc*()) is in
the tree-walk series:
  https://lore.kernel.org/git/cover.1793357680.git.gitter.spiros@gmail.com/
This series doesn't depend on the other series in flight and merges
cleanly with them. Based on master 50fe5cc63f.

Elia Pinto (4):
  object-file: use size_t in check_object_signature()
  fsck: use size_t for the size of objects to check
  object, commit, tag: use size_t when parsing object buffers
  tag, fmt-merge-msg, ref-filter: use size_t for message buffers

 commit.c              |  8 ++++----
 commit.h              |  6 +++---
 fmt-merge-msg.c       |  2 +-
 fsck.c                | 18 +++++++++---------
 fsck.h                |  6 +++---
 object-file-convert.c |  2 +-
 object-file.c         |  2 +-
 object-file.h         |  2 +-
 object.c              |  2 +-
 object.h              |  2 +-
 ref-filter.c          |  6 +++---
 tag.c                 |  4 ++--
 tag.h                 |  2 +-
 13 files changed, 31 insertions(+), 31 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
-- 
2.53.0

