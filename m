Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120C1D555
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 00:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784766125; cv=none; b=avJWGQQriqDIr74BJXxPrMnEfU/XnHKbKm5VN03eJDU7pVhU1QdETayn+AhhP21XoikbdsUqwvd+Adz8RrHF/zqN+rckLRSuB+CVzaRELlg/hdWBG4GnUoLkiiHHbWnU8vqrGjZ4arqRM5mdte7Y4RwlE1hYTlcPLNLw2d4QFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784766125; c=relaxed/simple;
	bh=mK7zqvye9l+yXgQSriZQiyPo5Q0FiK505D/xLPxU1uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lilSORK1DdU+05Q9w1LqPz+OJpvfucuYJgndgrX/WrZ4r4WH3F632nTxYjFaf5Tljw5cX3M4zdkl3+wBnsXmO8T8bMgbY6qFle38wBJ35PsOoL2AYduPgxGagwt350N6Pj8Iw3MBl769Ftuf8qCtzPWD17eHbRo/E8jzKGKq7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftmxW31B; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftmxW31B"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4955aa106b1so703625e9.0
        for <git@vger.kernel.org>; Wed, 22 Jul 2026 17:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784766122; x=1785370922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+Ly7osjtudHl8agm+8CxiRajA90epJJ8/kRZYqtI9QI=;
        b=ftmxW31B1LOkJrXW+ftSt6c1hBw5lyzH0F67ttRcIA7z/c5MQE1TNQhw+3RlJP9QLi
         FMUi4gVS7lA0a3TtzmqOf6Dvqf9ACi3JCnUfkYlU8bjvQWFni6nlrsBLCH1r08bLuksd
         528mwibLFfisQYDkVMCN6bmgINLAfSf4gWFzIx1dL6JzWD+6DhqgjauPdubELOCRYl0H
         jX8Z5hjnIBafyC100mOojioQ6SOc39zE+lATrAtPzy4qh+DwKyo+51fMM41UFGvKR3VH
         cTX+JHn4xZyUCtJqpcTmW6BPwrl1c73UkHnjAUCnzQVm/kk4c0/O+3KqiAhZfQnlUgA7
         fJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784766122; x=1785370922;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+Ly7osjtudHl8agm+8CxiRajA90epJJ8/kRZYqtI9QI=;
        b=DKNWzeaT/mQpWou6+gYCvmBuJfL9nX8hxg6OzCDeWQS17UhP29Nqn2fPJVs3tTo86v
         rR+Fut5K3emKu4ZloZI6fzbPw8h9uIYd8tVZzmp2GgZ6yFypvMG+dZO2KYIS1AdCjPFm
         tUxJgGeNtLekxC7Q2tqfTPg0ku1Ib2f5UQoL7v0lZaDJTdv8Ha0oQSfmQUxVO3JrMo/B
         1ixiH0QHPDPrpK91uWBYmDj9hzNh7aF5BblamToCD7bt7SBUn7uRIiELhi4NRYo3FG6j
         UT9ApuUGQkP8ZgSgNkFIyyAMNpewmhvCaEeNKNrIuuKeVE6GIYy9YkhvuQw90dKiWiHU
         ZCgw==
X-Gm-Message-State: AOJu0Yyczv8niACfnk8Lg92V6Cs1IcGut+n0A4ubnwr0DXbVRSQ8Gbx1
	Sobj/g6fB8bMziAnPw1uLyOoCy5O5I5LaGfy0zTOt/dbDoUdQBSxzEMspoyhMQ==
X-Gm-Gg: AR+sD11kgwiplKDelQ0PsgiPAqgJnqg1970M71v4LIvXgU76+CVisXuO4e0S+O4io3R
	UejBb9BBqtncuDkdFvGeqmBnA3ewxx1xmhcRrzHM6Rde+ey5fNTIBE14fnq7tLzLRW8OlLjMtyj
	gNsyCSb2v1GGK2AqGnROykM7leH9WH4OB4YEWduNYgPBMzoJ/zbGBlX3PnqaQk1tQasOCazYXxL
	PvifmQAV1kAAd8MN+4hVOfvn5LR/XY1noaV6CaWoCqbvlTqDLobib1XF7O6iGqQpQoafUaIL3LW
	67M8PP/rOCKrKg0lIt4q2GGzXJfOiYV9wByvGeANTYWM8/r7d+ACE0l3jqYE39BWeuj1BBmLYqh
	zq1Lw8ipJa1ml41tv+mjrizyJbmzL6/lMzGey1nMylrhBH/HfXmxU6DEgg6TSpGXwRLq6zW22xX
	f/Q1I3F7sDVUiWpW+RQfO/CfP3
X-Received: by 2002:a7b:cd14:0:b0:495:5062:17f9 with SMTP id 5b1f17b1804b1-49573cffcb4mr5109135e9.30.1784766122039;
        Wed, 22 Jul 2026 17:22:02 -0700 (PDT)
Received: from ccjmne-arch (82-65-84-247.subs.proxad.net. [82.65.84.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f8635c8d7sm8840518f8f.21.2026.07.22.17.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 17:22:01 -0700 (PDT)
From: =?UTF-8?q?=C3=89ric=20NICOLAS?= <ccjmne@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	jacob.keller@gmail.com,
	=?UTF-8?q?=C3=89ric=20NICOLAS?= <ccjmne@gmail.com>
Subject: [PATCH v2] submodule: resolve insteadOf aliases when matching remote
Date: Thu, 23 Jul 2026 02:21:32 +0200
Message-ID: <20260723002132.3989727-1-ccjmne@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260721213042.3357346-1-ccjmne@gmail.com>
References: <20260721213042.3357346-1-ccjmne@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When ca62f524c1 (submodule: look up remotes by URL first, 2025-06-23)
introduced a mechanism to identify which remote is to be used by a
submodule, it compared the URL stored in the .gitmodules inventory to
that of each available remote.

The URLs of remotes are rewritten according to url.<base>.insteadOf,
whereas those stored in the .gitmodules aren't.  When such aliasing
applies, no match can be made between the two corresponding sides, and
the procedure degrades to its fallback logic electing either the only
configured remote if there is only one, or "origin" otherwise.

That behaviour is unfortunate when no remote is called "origin",
because its last resort will have a submodule update command look for a
non-existent remote-tracking reference and fail to proceed, instead of
using the remote whose rewritten URL matches.

Resolve the alias in the URL inventoried in .gitmodules before comparing
it against those of the corresponding submodule's configured remotes.

Signed-off-by: Éric NICOLAS <ccjmne@gmail.com>
---
Thank you for your guidance.

Changes in v2:

- Reword the commit message more purposefully
- Adjust the implementation as suggested, avoiding a superfluous
  variable
- Tidy up the integration test

 remote.c                    | 14 +++++++++++---
 t/t7406-submodule-update.sh | 19 +++++++++++++++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/remote.c b/remote.c
index b17648d6ef..b1fed58e79 100644
--- a/remote.c
+++ b/remote.c
@@ -1821,17 +1821,25 @@ const char *repo_default_remote(struct repository *repo)
 
 const char *repo_remote_from_url(struct repository *repo, const char *url)
 {
+	char *rewritten_url;
+	const char *remote_name = NULL;
+
 	read_config(repo, 0);
+	if ((rewritten_url = alias_url(url, &repo->remote_state->rewrites)))
+		url = rewritten_url;
 
 	for (int i = 0; i < repo->remote_state->remotes_nr; i++) {
 		struct remote *remote = repo->remote_state->remotes[i];
 		if (!remote)
 			continue;
 
-		if (remote_has_url(remote, url))
-			return remote->name;
+		if (remote_has_url(remote, url)) {
+			remote_name = remote->name;
+			break;
+		}
 	}
-	return NULL;
+	free(rewritten_url);
+	return remote_name;
 }
 
 int branch_has_merge_config(struct branch *branch)
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 9554720152..10adeabf0f 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -256,6 +256,25 @@ test_expect_success 'submodule update --remote should fetch upstream changes' '
 	)
 '
 
+test_expect_success 'submodule update --remote resolves URL rewrites' '
+	test_config_global "url.$(pwd)/.insteadOf" local: &&
+	mkdir alias-super alias-submodule &&
+	(
+		cd alias-submodule &&
+		git init &&
+		git commit --allow-empty --message "Initial commit"
+	) &&
+	(
+		cd alias-super &&
+		git init &&
+		git submodule add local:alias-submodule submodule &&
+		git submodule update --force &&
+		git -C submodule remote rename origin upstream &&
+		git -C submodule remote add fork user@host &&
+		git submodule update --remote
+	)
+'
+
 test_expect_success 'submodule update --remote should fetch upstream changes with .' '
 	(
 		cd super &&

Range-diff against v1:
1:  ed507998b3 ! 1:  4363eb3cb1 submodule: resolve insteadof-aliases when matching remote
    @@ Metadata
     Author: Éric NICOLAS <ccjmne@gmail.com>
     
      ## Commit message ##
    -    submodule: resolve insteadof-aliases when matching remote
    +    submodule: resolve insteadOf aliases when matching remote
     
    -    When ca62f524c1 introduced a mechanism to identify which remote is to be
    -    used by a submodule, we had it compare the URL stored in the .gitmodules
    -    inventory to those of each available remote.
    +    When ca62f524c1 (submodule: look up remotes by URL first, 2025-06-23)
    +    introduced a mechanism to identify which remote is to be used by a
    +    submodule, it compared the URL stored in the .gitmodules inventory to
    +    that of each available remote.
     
    -    However, when using URL aliasing via url.<base>.insteadOf, we store
    -    in .gitmodules the URL pre-resolution of the alias, whereas the
    -    corresponding remote set up in the submodule reports using the
    -    *resolved* URL.  This mechanism therefore fails to find a match then,
    -    and resorts to the fallback logic, which does use either the only
    -    configured remote if there is only one, or attempts using "origin"
    -    otherwise.
    +    The URLs of remotes are rewritten according to url.<base>.insteadOf,
    +    whereas those stored in the .gitmodules aren't.  When such aliasing
    +    applies, no match can be made between the two corresponding sides, and
    +    the procedure degrades to its fallback logic electing either the only
    +    configured remote if there is only one, or "origin" otherwise.
    +
    +    That behaviour is unfortunate when no remote is called "origin",
    +    because its last resort will have a submodule update command look for a
    +    non-existent remote-tracking reference and fail to proceed, instead of
    +    using the remote whose rewritten URL matches.
     
         Resolve the alias in the URL inventoried in .gitmodules before comparing
         it against those of the corresponding submodule's configured remotes.
    @@ remote.c: const char *repo_default_remote(struct repository *repo)
      const char *repo_remote_from_url(struct repository *repo, const char *url)
      {
     +	char *rewritten_url;
    -+	const char *url_to_match;
     +	const char *remote_name = NULL;
     +
      	read_config(repo, 0);
    -+	rewritten_url = alias_url(url, &repo->remote_state->rewrites);
    -+	url_to_match = rewritten_url ? rewritten_url : url;
    ++	if ((rewritten_url = alias_url(url, &repo->remote_state->rewrites)))
    ++		url = rewritten_url;
      
      	for (int i = 0; i < repo->remote_state->remotes_nr; i++) {
      		struct remote *remote = repo->remote_state->remotes[i];
    @@ remote.c: const char *repo_default_remote(struct repository *repo)
      
     -		if (remote_has_url(remote, url))
     -			return remote->name;
    -+		if (remote_has_url(remote, url_to_match)) {
    ++		if (remote_has_url(remote, url)) {
     +			remote_name = remote->name;
     +			break;
     +		}
    @@ t/t7406-submodule-update.sh: test_expect_success 'submodule update --remote shou
      
     +test_expect_success 'submodule update --remote resolves URL rewrites' '
     +	test_config_global "url.$(pwd)/.insteadOf" local: &&
    -+	mkdir aliased-super aliased-submodule &&
    ++	mkdir alias-super alias-submodule &&
     +	(
    -+		cd aliased-submodule &&
    ++		cd alias-submodule &&
     +		git init &&
    -+		echo line >file &&
    -+		git add file &&
    -+		git commit -m "Initial commit"
    ++		git commit --allow-empty --message "Initial commit"
     +	) &&
     +	(
    -+		cd aliased-super &&
    ++		cd alias-super &&
     +		git init &&
    -+		git submodule add local:aliased-submodule submodule &&
    -+		git submodule update --force submodule &&
    ++		git submodule add local:alias-submodule submodule &&
    ++		git submodule update --force &&
     +		git -C submodule remote rename origin upstream &&
     +		git -C submodule remote add fork user@host &&
    -+		git submodule update --remote submodule
    ++		git submodule update --remote
     +	)
     +'
     +
-- 
2.55.0

