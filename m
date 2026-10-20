Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509660;
	b=lQy/jbEdHOT2Il8A7leytWKP6a6+v9ISIHfehS/HiZnTA3eiCfdaxfuiacCoyi13yyYq
	 qnGDSbVzCmlcQ0TGgINAZEJ8LbGmdmAkUSt75NmMnUyB1dkdmN1gJCOGIBSlMq2kSOsrQ
	 yoLk6h4ZlIB02IdurNkx40Iprz/FUDPIIr8GsMoM7VFIkfbmOzAx0XRDhsj3LmztjL0U7
	 KIATj1WpG/KGcdSCRJ3b4y9OelJOylQfLBP+CckNPHUHAENVDgK2s9COls3PlszbfHK3Z
	 Rjyhu3lzaJTewgT7+Mpv4BEQwqVjz6Au62v+H22S/5EOADpwrUiZfJs//4AJd4l+RYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pm9KFLtmGWE5QfGKMpYKE8l4xuVGeAotogfwM5r9QII=;
	b=QIS+XkL9CXnqyfUPWtoikFQk7ihhqaY0ZRtk+i8zaMFQPH0DJQJv562poVl9fy8mQPxv
	 VfLkFgmd3ywzKSm8WbTckxCS6AbuRgb4kJzd52uFIxr9nCdaK7Zsq98rXiTr8HbRpKn6C
	 gvhnwLkYEoSra3jeH4rbaLa+Vh4wu3wVPnXlCq7eqQYB4bzoguM/mY0NbFN9ei3aQfRlX
	 bEC/a3jnzwJuhmLnhMumwPo986zHx7ZAT3+/hqYRRji9n9sMh1M0RhCljk2jovkK93Od4
	 +8WQmo4lwRVwXWQsmCplUmq/HyKsuzzVlqHyfrjCBqlA03LJ/wFWPj53fIows56aXTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SS+DjcFe;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73564606A330
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73564606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SS+DjcFe
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso688318f8f.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509659; x=1793114459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pm9KFLtmGWE5QfGKMpYKE8l4xuVGeAotogfwM5r9QII=;
        b=SS+DjcFeJgqUcmU8OgMOeeptnPeiaOmbynkanTjTxiXxCIcKEDhU2kyT/4+NxUO6kU
         oXhGJwxrmPqw7thnvGFKQUo6ZYbNYpdR87CFUyOyOn4XszM61WKO1kq56bxL2WHR0DWZ
         npTiwPprBJYDL4EfFpHuFDvQf/u7zh1ifbDaeMVA4OyjiIE9katk2GI8kgatMJFA50oy
         c6mdALDuBO/WzNUuZOPvBttujDFecLu+r013awqpV5ywUBcNNGi1ZIy4UpewNdRjE5Ip
         eZUDsQKOkR4SscJ0oY3iqBg6nJdP7N7C7oJd5jNfLQ7yOjTmPnEiqm5z0MyOL5T0/woG
         Kxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509659; x=1793114459;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pm9KFLtmGWE5QfGKMpYKE8l4xuVGeAotogfwM5r9QII=;
        b=kD09ixUiI/hXtif8UWFdcHjJQMNPq4YWC04INSz27VK6EN31tBfmjvTMF/mwynOpZj
         j+sFs81V+W7KdRpGSlDFsIg8UWkugX7/QluyszEPqpY7/dLbPYnX+7jObsw3lTEkhNsK
         3UMFhkfd3RH/MzQZeEWMP5LZrv4a90EFGkpC4sFl2SbL9plEm8jeljtHbWizeMEvpQKb
         HmCSY0lJ6FosfxhNfVFcuvytS7t9SFLTm6bdxRRrUCLi/KQq7uRd5OG0pBKzfQXVFauM
         4p223LykzQuZ+WGwB4c/F11zP5UN/P9It1Oi6O0Uwr76oEAafRMTMg677Bvaun/qC0mN
         Khhw==
X-Gm-Message-State: AFq9FYK/9zhUMGEdBMEujlCAkZyUbFh7PHuVqzRxO0Zc7Tddconus/BN
	V10fShLhXiy9wyPpIehzX75V8SW0BSSkthCHRTIKCvYQ1qofHWe51j39hXLJmg==
X-Gm-Gg: AYBFou3DoyMeYF7snSojER649B1N/0BTHc8dCZkFG78VcvXxHOzAAqKTUG7cum1PKYa
	qBa1GRsuk1xmt/LnNY8sMkQWpaFf5iKkhkKJP9HIZZcte6o9NKBpkscQ5V5konNZxuvel6XSeSv
	ezRulZVH+0TIDjFoX8LF6BECeyR8nniGo56HPSmm7re7KT8zF2cSYFp2a6PX0EO048JC4njlhHK
	11G+mknMGyN43Xi/uLZedKOmUTyE1dqsNt6gy4erDXg9Eg6nSHCgrvHJBib2GCY1fBzPhtaOQQR
	wUZ8o0eesACGuTCmd7NYRfsQmQSQjXZMapeDpQmmF6nWTXbCIpArtaB30irr9S5i/Hwb0roEcfH
	esCD+O64mtoxXTxZP7SBUGcvCbZLqJN7CmOd1aOg8CSY2YxSuRBcZWhfYGf1+nJBnN0Mf7WWkAV
	pW6FKYslUciBLR615rQAOsCC6WRqWrXPFnCXSABZL4K+E8xMgCwkCMJ6nXFhvK1ZmdqxQImI8rQ
	w==
X-Received: by 2002:a5d:5a50:0:b0:48e:7fb:aed3 with SMTP id ffacd0b85a97d-48e07fbaeddmr17450372f8f.17.1792509658363;
        Tue, 20 Oct 2026 08:20:58 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823ca7sm6307355f8f.38.2026.10.20.08.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:20:57 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 2/7] stash create: remove duplicate changes detection
Date: Tue, 20 Oct 2026 16:20:37 +0100
Message-ID: <d56b7c6f67274175416f4d5344675a9679d31f96.1792509606.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.56.0.134.g299a3c16181
In-Reply-To: <cover.1792509606.git.phillip.wood@dunelm.org.uk>
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk> <cover.1792509606.git.phillip.wood@dunelm.org.uk>
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

Before it creates a stash, git checks if there are any unstaged,
or uncommitted changes. If there isn't anything to stash it bails
out. Since ef0f0b4509 (stash: optimize `get_untracked_files()`
and `check_changes()`, 2019-02-25) "git stash create" has checked
for changes twice, once in create_stash() before we refresh the
index and then again in do_create_stash() after the index has been
refreshed. That commit claims it is an optimization but it is not
clear what it is trying to optimize by checking for changes twice,
especially as checking for changes before refreshing the index is
unreliable (the scripted version of "git stash create", called "git
update-index -q --refresh" before looking for any changes).

Avoid checking for changes twice by removing the call to
check_changes_tracked_files() from create_stash(). In principle we
could remove the call to check_changes() from do_create_stash()
instead, but it is more convenient to keep it there, rather than
require each caller to call it instead.

The remaining callers of check_changes_tracked_files() sensibly read
and refresh the index before calling it, so it no-longer needs to
call to repo_read_index().

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 3e50ccfb40..f461f002e5 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1248,9 +1248,6 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	if (repo_get_oid(the_repository, "HEAD", &dummy))
 		return -1;
 
-	if (repo_read_index(the_repository) < 0)
-		return -1;
-
 	repo_init_revisions(the_repository, &rev, NULL);
 	copy_pathspec(&rev.prune_data, ps);
 
@@ -1662,8 +1659,6 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 	strbuf_join_argv(&stash_msg_buf, argc - 1, ++argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
-	if (!check_changes_tracked_files(&ps))
-		return 0;
 
 	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
 			      NULL, 0);
-- 
2.56.0.134.g299a3c16181

