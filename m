Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918E543711C
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222364; cv=none; b=TPYjs9VY1JWDAzqtF1Et12kByiEcD25oMjHjTA7z3A9IFaadUxlJnANQVIyL66OpKXmYAs8hqZ5eFgAWryR6N4Rn+8DrMsbx9Xscaa9g8DUwUz6GtRbrQdc6TXj5OMjyLOmfAcVpVLwO5ke/PB+YN/gK4Kaj6gsF4A6404mrvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222364; c=relaxed/simple;
	bh=PIfkcGDAEr++It0JhB4EkyJM4weoEOU8DWYzl4pViyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3g33hSF6I9vDQ77z5DMFqDkF9RuEQAelnIxMJJcYYuo0h/lerDf6ea+SGYNhpUIgYskrElzlRw27u3F+wz6FoXAUH52Ohtb8+Cod7GvQa4Pw4skzJAEvuTqdBhnW6xhOSjfX4v4ILZA3E1DCZHzIkbhu1FPOz9KRoipiuWflas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY7Tpc8J; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY7Tpc8J"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5e9405fbc33so307378e0c.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 00:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792222362; x=1792827162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9trG3PjK3LDGI1DL9Qx0fAfM3Rel4ksaOmPfH9BSXg=;
        b=MY7Tpc8JzCI2grXm1f7WnqAVFtcTOnKiqtpH8GhvlnTcRJZF3un80S9g8togAoU9kU
         78RnsBA+kHF4ovHj46aWpzpu2dC6MApN3LvkC7N3ioahuagi45TSbfXZ++EKBfzV5Fz2
         JgMRrtL+Or/rY/6kBiR3Fu1XpNLuYjtyPR4iEFhm6isqJLJ9UntRld/Q0G8KlOvL6uo3
         EIKcfwj/SwIiPkbStfcDjrByJB/fx59+sL7QkN15S4kiWKXToMu0vqLywQ6umH2dBIJP
         Au8h8y6P/jbD0IqLk61Q17Dq7f4DUpcOXNA2llrqIlFTnM03HsSlgXD4YzyLbkLZeiB3
         YGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792222362; x=1792827162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u9trG3PjK3LDGI1DL9Qx0fAfM3Rel4ksaOmPfH9BSXg=;
        b=pjBeH9cYIE/fIAXorFv1rmM6+l2IqsBdj2iFsEHId0EeC3lV/gx5sDlzVOz6tri5B1
         CGEmNXsoRF8XJjsQn3XwYYYOpZFXr0gIsGdafA0VLW/uRZMRVCgmHx6OEsB8lJ2r4o7v
         XyYZjeWGR1ciXxg6UpEO+xWA+P38an23JRtrCR+2smRk6b8UJSCsg/vcVYrL7bb/mEAZ
         etl5IC0vEU27FHsBFu+nbbdpqZ+8QQpsT5SZK/5Lj/CDDwr9nRhzecCIdfdoMiDYmQpk
         F1I+qUqkKM0tPNxE1feBFDm9HHLzNoF0eu/eZqpyGdzPk/wYcvt3zLoFGMFrmNp43Xig
         Vwug==
X-Gm-Message-State: AFq9FYKZ2dXSYs325FEwF6SNn2DTuQZ2zpha/Cy37N0MvrumvOiC/6TY
	rrGfddT/NNM1mDaaPs3AwJE/R/ELc+qeYt0SfjoHhLQn6hy04PA+cp/OjKVFtw==
X-Gm-Gg: AYBFou2WjT6MmKpSyc6KvPuH4vtA4h38m+puuzeSN7IcnFy5nIBlF2XkLub8T85Hkgm
	dbfvU9AGGw8wb2OnK7LHd6dVoM2t3RmxPBgE1cUvdPGFkrylQpw5rstsvPBm78Se8qig+Wo+/YG
	Q8r1bfJib4QsmdtyVIrD4IteZYjkesU5hF5/dss4zndJaxYjtlp3qp34SJp68TGL/FaDt76Bmsv
	BglOaTtpMXHoyj0mcgvP71BcTaVcnPscLbt5ApdLX/MLFPtbpy1p5AKkv4Ur/sSxNTKc8EOQhl1
	prKVuParMVLhvWMLmNcReFZW4J/WGmOxu6ZqCd4bzuacOT8H/ju1sXzq/2WKbdOKhkyyL9ynDzZ
	G6bEBPVIxPDKvvq3V/A2y7/eQcwvpfZOiDZR5dP5Mu0lchy0LYwu3c4R7S3ZlqyrMAY9eOMqX6Y
	OBW51fpVl0DEZz4pT10HTxhkUFNWE+5dSJZozry6NRxz4obPLoMhFJnTZsFl/U6OyIk6Bxd7bZy
	krhuzAnmkhEnbT802flgLBHZVP0scr8mP99CLqrlcQwndPUk667k9rADY1gGpSMcQ==
X-Received: by 2002:a05:6102:5488:b0:7cc:2bb7:1321 with SMTP id ada2fe7eead31-7cc36aba539mr435045137.31.1792222362365;
        Sat, 17 Oct 2026 00:32:42 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ (162-199-88-188.lightspeed.sntcca.sbcglobal.net. [162.199.88.188])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990835c2180sm3379305241.3.2026.10.17.00.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 00:32:41 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: [PATCH v2 4/4] reset: fix write race
Date: Sat, 17 Oct 2026 00:32:31 -0700
Message-ID: <20261017073231.3357477-5-quark.zju@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017073231.3357477-1-quark.zju@gmail.com>
References: <20261013172315.2997446-1-quark.zju@gmail.com>
 <20261017073231.3357477-1-quark.zju@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Wu <quark@meta.com>

Similar to the previous commit "commit: fix write race", fix a similar race in
"reset" (except for --soft, which does not lock/write the index) by changing
"read -> lock -> write" to "lock -> read -> write", so "reset" now qualifies
the new user-friendly "waiting for index lock" behavior.

Unlike "commit", "reset" uses repo_read_index(), not repo_read_index_preload(),
so it won't add significant work (e.g. lstat() working tree) while holding the
index lock.

I chose to not add a test to t0032-index-lock-timeout.sh, since every waiting
test case there (undesirably) takes 1 second to run, there are already
representative test cases, and the change looks straightforward.

Signed-off-by: Jun Wu <quark@meta.com>
---
 builtin/reset.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 78e69bd84b..0e1aa76aaa 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -346,6 +346,7 @@ int cmd_reset(int argc,
 	struct object_id oid;
 	struct pathspec pathspec;
 	int intent_to_add = 0;
+	struct lock_file lock = LOCK_INIT;
 	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
@@ -477,6 +478,9 @@ int cmd_reset(int argc,
 	if (intent_to_add && reset_type != MIXED)
 		die(_("the option '%s' requires '%s'"), "-N", "--mixed");
 
+	if (reset_type != SOFT)
+		repo_hold_locked_index(the_repository, &lock,
+				       LOCK_DIE_ON_ERROR);
 	if (repo_read_index(the_repository) < 0)
 		die(_("index file corrupt"));
 
@@ -487,9 +491,6 @@ int cmd_reset(int argc,
 		die_if_unmerged_cache(reset_type);
 
 	if (reset_type != SOFT) {
-		struct lock_file lock = LOCK_INIT;
-		repo_hold_locked_index(the_repository, &lock,
-				       LOCK_DIE_ON_ERROR);
 		if (reset_type == MIXED) {
 			int flags = quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
 			if (read_from_tree(&pathspec, &oid, intent_to_add)) {
-- 
2.56.0

