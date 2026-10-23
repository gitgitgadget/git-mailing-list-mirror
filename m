Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767832;
	b=ty9j1b8dk2/n+BWymEXKpZeTViqWN/TJbkuWrVYgS/xzTdj56mTXgtLtZqMxQcXEKr5f
	 koEn+b676stPV3OmjYlCclpLSKmyz23i5+edQokrFA/UfwG0pbrcGN8ukbIfWUPD7xUQY
	 rO1nzwB6+BZJGsP3pJ0kAncnIrnnx+lGOQTlnuIE3SwoGHh7dZ7iGI1DCGuqpmMXQu9Pr
	 PJqvf+uMdyZFppSeRGdLU7T5uP6VBnvE++8UWg36KzL0thNx4wapOrz2MHvaSekBrVAAo
	 6uDImsGedqqUDOU1VDiWuifsl9Z0iqFCz+GiuRZjfcRc6wQW1jqqMuEvCTifsr7EZgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767832;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Hu6qNvDcVnsLRpT+eOUhCB3wWjxMTnnhghbG5HcsQ9U=;
	b=IyR5Bj/acc+Efmnw2+AqUgi8kVWPunnc8FoUQMkA1fnsBco3V7nOLtOUavI1U0ryCxLA
	 LTX++F+VM0+fBTTqviHBZX8ANgSQn9oqvI1WioyJJUa7VdqkclR8Aza+4gvkfL5xu60rN
	 i71KLEqz+gpg4TdJ/OJqYhk+RID0vmi4pIq372uPUVe1tSMvLcYVtdq2vId6b+cbn9C81
	 hnLEp1swgO2ce3yK4fI08lFoQoleMJcKv99mm3iwwLZQ0xZAgZY3Ezo6N8Ed+TvUfO9Xg
	 LCUqJm7Xgh4kTmRhxEaP4Wd9MVzhzzdq0C4anIvGotYrg1UMEhcBsM0LolJjjz9+rOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JlnVjP+G;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCCA606A336
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFCCA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JlnVjP+G
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so603775f8f.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792767830; x=1793372630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hu6qNvDcVnsLRpT+eOUhCB3wWjxMTnnhghbG5HcsQ9U=;
        b=JlnVjP+GgTQfcXzHiYD9OmUt+bzna6cv/Z9PF+ok3Pf+fJrmyVDjwexC/QvhLJAkIH
         2SpIYlGYAr29ZR/FxAuyXaceKfqgC20f+TjqmlJkpSkwm33gvklIfxo873guomomy2Am
         0UOvuzZ+NsAtXdvd/xdxRfgB7GI5ELFLOZbgTVwyYgUmkd39Ehx9dTahyo2yB9TTX2Mw
         8p2ayT8dDc1lR9+oMyOhH1T7paI9OsJteSzh2bdH5IUuK+p4J4bLWcGHxUY5ltg8V+UP
         SS3mWMDgHUEScLJx1nblLdW6XRpNArtGeXHhgqg6B/hW/E4nK0ZWUn1HLIptwHJKsKCJ
         dOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792767830; x=1793372630;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hu6qNvDcVnsLRpT+eOUhCB3wWjxMTnnhghbG5HcsQ9U=;
        b=w8zd2HvmF4ZZ0Fh3y2GZPyRISL+q39kyNQf0Xg1u58nTra5tQviAbPaSdsAuHnohu5
         KCvV5W8vw3gHB/8F4C5uIHIS6ebM8hxNMM+f22lhRNC0ALae5mXvS179taLkG2wXwsxT
         V/VTaIQKw8m8DpXeSeZKduC9qJ3XJZMBPBN4OVNAPrpSn/aUE5Z1LD5y6zb0yqY3txIZ
         l8TL7OU5FG0KXViTrufoWJLs4IM0P7AciAUbsNdBF1Z30dF8CzBb1fi+79vRIQBWe3as
         iXa1gH6Up8JA5qaK3LpTPWvM+w22C6eMWxBvESwzixgNdOHfOKTQ4nwYstm3wnKqE/lP
         9w7w==
X-Gm-Message-State: AFq9FYLb/wd2dzaJ1g5f54+ZoaieNjM3W38jUXLRqTplRgPPIlaKQWX2
	PZ1WXj69zjg+PFbWwyCLlbr89KRkYZHI7Ud9AFv9bzNmzm+tUlGBIj/DA9z2RA==
X-Gm-Gg: AYBFou3PUsfnMt1F/kAvCo/kJHrqQpEnw6ncBpF0MyU71Mzv4VZCKn9owPsV5K+9p0s
	DBwx5euOIcVYIVQeiWe5J8MazKxOdmzmphLnHs3pPWys7dK1rw8DDQGWFWroyB39yAQn5I6zvm4
	Vq74WgsZaBECYebZ97nnN3BsxzGAQPtb5OQn6fNjWneomzJ6tcxERQFgPOMeqpBv5Fi9kmhXadf
	p5TsKl1yMm0NzbUbTP85tlb95YMDu33la37M3XaBG1iML+UtGwjQthJtTrd4Dbjw3z0oGpyMWQ8
	823+eJSz/sKdKFGlB6lfs45ZMTVXLlPe42obUFOyXdW0qbuDHaqS/nRgxz50v2lEdifGMjkW8Zp
	r23KWs/v/p79ftZHNUxi5gMaku9+cZFInJL88mA4YRdD11s+SDPSNzlDcEEYW92dYaH7oP/yuQA
	SxnlMckOSrVS6C4IwkjLCMwljtXgpFkVMAi4VKnlXdwEsivlrG7Xa1BqNhvz8qRzD08ng7Otmtu
	aaXzi1uXsBWzoXxOV9rbHBp8u/sYNArKIyD0J653JrxxKd7eZdYvapYlbQ=
X-Received: by 2002:a05:6000:2004:b0:486:f9ea:796f with SMTP id ffacd0b85a97d-48e387d65ddmr4221702f8f.41.1792767830139;
        Fri, 23 Oct 2026 08:03:50 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d427e68sm296326f8f.52.2026.10.23.08.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:03:49 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4 3/7] stash push: remove duplicate changes detection
Date: Fri, 23 Oct 2026 16:03:31 +0100
Message-ID: <785d2a663daf5f48cab1672e6f07d2252938ca1a.1792767795.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792767794.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792767794.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
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

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Before it creates a stash, git checks if there are any unstaged, or
uncommitted changes. If there isn't anything to stash it bails out. "git
stash push" checks for changes twice, once in do_push_stash() and then
again in do_create_stash(). While duplicating the checks for staged and
unstaged charges is fairly cheap because they stop after finding the
first changed path, if we're stashing untracked files then we visit
them all twice. Avoid that by removing the call to check_changes()
from do_push_stash() and checking the return value of do_create_stash()
to see if there were any changes to stash. If check_changes() finds
there are no changes do_create_stash() now returns CREATE_NO_CHANGES
rather than CREATE_EMPTY. This enables us to distinguish between there
being no changes and there being nothing stashed, so that "git stash
push --patch" when nothing is selected, and "git stash push --staged"
when the index matches HEAD, still exit 1 rather than 0.

As we're not calling check_changes() in do_push_stash() anymore, we do
not need to refresh the index there either because do_create_stash()
refreshes it again before calling check_changes(). Avoiding the extra
index refresh saves us two lstat() calls per changed path.

There is still one small change in behavior as, if there is nothing
to stash, we'll now try to create the reflog for stashes before we
realize that there is nothing to stash. I don't think that should
matter in practice.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 5137456da7d..7259f6374ce 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1338,6 +1338,8 @@ enum create_result {
 	CREATE_SUCCESS,
 	/* No changes were stashed */
 	CREATE_EMPTY,
+	/* There were no changes to stash */
+	CREATE_NO_CHANGES,
 };
 
 static enum create_result stash_staged(struct stash_info *info,
@@ -1542,7 +1544,7 @@ static enum create_result do_create_stash(const struct pathspec *ps,
 	}
 
 	if (!check_changes(ps, include_untracked, &untracked_files)) {
-		ret = CREATE_EMPTY;
+		ret = CREATE_NO_CHANGES;
 		goto done;
 	}
 
@@ -1595,6 +1597,7 @@ static enum create_result do_create_stash(const struct pathspec *ps,
 						     "worktree state"));
 			/* fallthrough */
 		case CREATE_EMPTY:
+		case CREATE_NO_CHANGES:
 			goto done;
 
 		case CREATE_SUCCESS:
@@ -1609,6 +1612,7 @@ static enum create_result do_create_stash(const struct pathspec *ps,
 						     "staged state"));
 			/* fallthrough */
 			case CREATE_EMPTY:
+			case CREATE_NO_CHANGES:
 				goto done;
 
 			case CREATE_SUCCESS:
@@ -1732,18 +1736,6 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		free(ps_matched);
 	}
 
-	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
-					 NULL, NULL, NULL)) {
-		ret = error(_("could not write index"));
-		goto done;
-	}
-
-	if (!check_changes(ps, include_untracked, &untracked_files)) {
-		if (!quiet)
-			printf_ln(_("No local changes to save"));
-		goto done;
-	}
-
 	if (!refs_reflog_exists(get_main_ref_store(the_repository), ref_stash) && do_clear_stash()) {
 		ret = -1;
 		if (!quiet)
@@ -1757,6 +1749,12 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 				      patch_mode, interactive_opts, only_staged,
 				      &info, &patch, quiet);
 	switch (create_res) {
+	case CREATE_NO_CHANGES:
+		if (!quiet)
+			printf_ln(_("No local changes to save"));
+		ret = 0;
+		goto done;
+
 	case CREATE_ERROR:
 	case CREATE_EMPTY:
 		ret = -1;
-- 
2.56.0.134.g299a3c16181

