Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266F31E838
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 13:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320491; cv=none; b=jQcZYVKx4wSp766eOUJvfNun5bP3TlObQ1pJZrZy9dnIgg/FqF1WUA6kdAEmlprolCqR55+VjsXMqVRdmi8xgnTxttT/KWKJB8pSVf6aivFdnkYRKH/OW9yfrdMTA4CgWbwPp54pMoTOLycel9FWvYRvWLJxC+5E6E46PWTufyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320491; c=relaxed/simple;
	bh=joVEVTjnC/F5BP4af7bYE14irKqum2A/qqBwULEjKTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pVg/A7T1B+m6ZS8s0+L+88biA2vJzkqln1nHYc2IBLXSOam3iXOwviM7nXjhdUK92/l65miSqU26IkQ8EMq8K7k3zfIXy9oCQY9SWSPrLOp4oameELJvhhxfhUT2nxNK4D9Iy53vasJbk/lw74rGH2qwKYZNhZwa3pVLwwR5V30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oC6B2yCd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oC6B2yCd"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1019167a91.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320490; x=1787925290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vt3MevLH/bwiOa/4vcSzymvaiPOEzvhwmaVhUkT68UM=;
        b=oC6B2yCdiRqPWVDb7bjyopHiL0wTdqL7t7PbvPxgtFzdl8AylP+21Wu5O+FPFszDdf
         nUnYZHhDMuo1hjoRueFFRPouKZcUobG5U7kIoDSeRCG7xyJ2eDFZvilMfVEaB0yrNp64
         qMLESfpQ2WKDJvZNfyHx1Fd7aO6znmMJPYYPnjAqHFZlX4Fjt8OTPue3LmO80uSfVo3h
         rGgdV+Vt0BD1cJ6q7sp81tAqDeCJR5tY489MB03wdII3lvuZrFbs6vFgjBocL1Bn1to6
         cwbBU5FKe6tav8VR0d8/1trXZPTrFkveaqSVg/lGaayo/Ee1FI++09chIrq4Zg66hPGh
         IsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320490; x=1787925290;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vt3MevLH/bwiOa/4vcSzymvaiPOEzvhwmaVhUkT68UM=;
        b=ngxyW/gOGr6R8xW6x1S6eg4hQYZtGZg5K1G+uz3TC7Dcyjrz2cBM5t47z/9dDXuK/x
         5NyC2cJktRDx5ktBdmmiOPakPnynaC8x3jJqQ0ho3NInIdKJjIH1owsR+waU4ROufkrt
         p2P2VvRfbcjUWtaYOEv01Dxa1EJA6OgtWc4upBSY5qlJF/hlqR0iarSV1AQzOurGS0Lc
         pY39W91R4TGUZ2RSBJf5omvnL6hZNetBkoVd/t6N74JtD5CP4LkfmAqpMO5E9oDaqO/e
         MBHjkokUkyuj3RA6jjLBNHaMLQL1+GnZc2Ow7h0wS9om8E8XfCsoGYtvu+BxckO12VF6
         /Eww==
X-Gm-Message-State: AFuF++k138Ow6KroOSnF3BbT5tUqgJE7WzUZRTeGlVtIU+uE3nbM0vhM
	ZOBtvjh4Zjg7Y24UGX1FWhQsegtltg1O4pskcdhqVm9qkg5JbZucyuDUiZkVwxBO
X-Gm-Gg: AR+sD108R8jF2OB4a/pzxzFkMAILVbFrjeiwzfya/begoTjhALSnXNhoacDXHKfc9W6
	TQVja0MBS3XO13PTqgzlAsbUv3lyGASHBEN2jSCAM4at7ydpZmLXjMHbQ8QhDVJczqkLK3zroe6
	jhkob43ohR6mSdygetQ8nlmSKMAaT33FN4LdGS2LO6c0Qr5Obfkv7aKz9UTmMNUcfUqmKTxdVSY
	/wMftKXafkhWg2Bdg2vke0BolmLBmwu7ZHSTYRHNYQL6HCm8tPShzVLK7PKB+P2pKzlDUZBz4J5
	kkPyS+SRTCHGQPeY1B4xnZptMTKOhZ8kOzsJ0B0MqD+JsyHymZpe0alaZo1AVifAVVyAvAeCFDL
	13ZzkvpLKkdFpUsd60j59Is5aCS4a04UKwO9tK9jnThNRamkBkX3yy7wAgby+rMgpKdQgMwdyxB
	YlRxC7tMhEAiw2vG+Jr6AXy12ysHhs/bF4aS0w/Wl77Ttx6TPWEFigEu3Q/oKmE8Ram5UpCC5CU
	D4UXp8MoE0owKeMDGnJ0Esvf6qYhi7c1FQLhuaU+dkW1WgBruom19SX+T2NKQjsTzDDPcg=
X-Received: by 2002:a17:90b:2747:b0:380:540:d499 with SMTP id 98e67ed59e1d1-395c33cd87dmr12996910a91.6.1787320489750;
        Fri, 21 Aug 2026 06:54:49 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3cde4sm31969308eec.4.2026.08.21.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:54:49 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch 0/2] add unicode support to git repo structure
Date: Fri, 21 Aug 2026 19:23:43 +0530
Message-ID: <20260821135410.429698-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, `git repo structure` always renders its table output using plain
ASCII characters (`|`, `-`, `*`), regardless of the user's locale. This
series introduces Unicode box-drawing characters (`│`, `├`, `─`, `┼`, `┤`)
and bullet points (`•`) when a UTF-8 locale is detected, providing a cleaner
and more visually distinct hierarchical output on modern terminals while
gracefully falling back to the existing ASCII formatting otherwise.

Summary of changes:

- Patch 1 (gettext: fall back to env-derived charset when unset):
  Fixes an issue where `is_utf8_locale()` would leave `charset` unset (NULL)
  when `git_setup_gettext()` returns early upon missing the locale directory
  (such as in uninstalled development builds). Because `is_encoding_utf8(NULL)`
  defaults to 1, `is_utf8_locale()` would mistakenly report a UTF-8 locale
  even under non-UTF-8 environments like `LC_ALL=C`. This patch enables the
  environment-derived fallback (`LC_ALL`, `LC_CTYPE`, `LANG`) whenever `charset`
  is unset, regardless of `NO_GETTEXT`.

- Patch 2 (repo: add Unicode support for `repo structure` output):
  Updates `builtin/repo.c` (`stats_table_setup_structure()` and
  `stats_table_print_structure()`) to query `is_utf8_locale()` and emit
  Unicode box-drawing borders and bullets when running under a UTF-8 locale,
  falling back to ASCII when not in UTF-8. In `t/t1901-repo-structure.sh`,
  tests follow the established `t/lib-git-svn.sh` convention for discovering
  `GIT_TEST_UTF8_LOCALE` to define a `UTF8_LOCALE` test prerequisite, existing
  tests are pinned to `LC_ALL=C` to reliably test the ASCII fallback path,
  and new tests are added to verify the UTF-8 output rendering (including
  when running with a missing locale directory).

K Jayatheerth (2):
  gettext: fall back to env-derived charset when unset
  repo: add Unicode support for `repo structure` output

 builtin/repo.c            | 110 ++++++++++++++++-------------
 gettext.c                 |  32 +++++----
 t/t1901-repo-structure.sh | 141 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 221 insertions(+), 62 deletions(-)

-- 
2.55.GIT
