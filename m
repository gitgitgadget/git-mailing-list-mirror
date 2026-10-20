Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509663;
	b=ClJTJPtDCCE3pdnCshKoRBS/r2CPhQvyhXfcLVffiUZK3lYpfzc7C4iyN6MXHKTtITUE
	 PjEGcixBabocG1ZNihGUXcznS4JSwhJW4DSoWy8ARIPqrwF2MYEqM//TKYmcbNRgxRWMb
	 tzR42MMXcGIYz6qI2umtVZx+WfKNWRBLdzhOiaAa18l9OxH7kZHxcUXuwJ4zOr0jsiCto
	 SJC3k+M7pyRV4v1peIL3NK7CyKCTPkjT1BtdsVdvYRiGtDvneeBK+Qg4HSSM67ByVUrgj
	 czjN2pk5idMbBHGhbIU1SZDe2Qq3OAftldPifGOSfKpeKMIedWL0uXVdHsYqvH1298w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:Reply-To:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8gxvILfny4AJqOd+78eY8j1hngOmrkmVucA4OiGoloE=;
	b=hA89IOl0uCh6b0pzvZm18T3SzLzIRjzFXHMRsI/QiCIrKahxbPvsCdeCW6/XSk8wul8J
	 zOXnoMMP4oPmZAQDARBf28KzhgsO9bs+5jWRkmRC10A8WsV+ltQvOA384L2eio/PUQlgZ
	 StlYQZ2X54ndzpf3yNsLsXyGn0y03H3f8N4GzkGdiwhUoXUpW7AUd0GIYrU56wmbyFz0h
	 T/BD3avCR/1xKR8gJFqgIvQaIfraFp634EzWVFGxdYb72yoyU1Uuq+FaIHJ6YvjQBmerz
	 gZY5PsomD9XqbIcWf89x1kVYqjGn/fjfG1/1wHLlasq8tnqI+IcqsbPZcENUyXPSFaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="owUI/Um5";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C167606A330
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C167606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=owUI/Um5
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1dec056ddso19210105e9.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792509661; x=1793114461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8gxvILfny4AJqOd+78eY8j1hngOmrkmVucA4OiGoloE=;
        b=owUI/Um5uciemAA0kHg0eWhGJyd5iqFql9uGMQEak+AG4Bn5ar0oE2KfwBkDHwbrcX
         rB7OGxAPdiCYnWm7WseAaN3kUPuJr7KSLDqYeD7rfXTxoXMRdKLFEmtdvf49Iv7+lTeJ
         M0/R1tyctJVZaRpddIiN3WJmsngPvncLJ/WkXkC5B38LFKV/samDfDE7Yn/QbV4kibeE
         QHna+oG5WZeE8bPxvykvImaK9Nacs55adKO4ioZNqqNQ084C9soxqK4el5YDs5w6CG6Y
         jXzwaSYFK/tbs34eBUj2SBYXaYcUD9w97VazgHDQ5ylFdrpN/4m3NciOxXrdf3SWhYdj
         PT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792509661; x=1793114461;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gxvILfny4AJqOd+78eY8j1hngOmrkmVucA4OiGoloE=;
        b=GA1yMQQG4UbTtMeeGgtd6ptfFFMmdducH1yKGI8mQaA5XufEwzVfHXw8hLvOQik2FJ
         bQhTuw21hNW4i+6AoV4M65rPq8G6isII59b69b7NvNDJ04hk6GNB932EotKCYJ4ObZI5
         WFI76rCJKeh2Smo6IXNLB1P+b+pq0Kc9NhP1kiHaUhyep54MKtoQ2ORVWAQbjsdgoVRE
         2ul/oWjeWU3PjfJYCR41/gF/H2ZpvM8Jq4YfmMQZF7oZlt8fG4IgFqegL4yiP3msKHGu
         YwHRYR76EpmIVJG9WzHTtnNDT5amW9RnbjCz196U0fFdGvj2QglPJnFjb1nKHz/Tf8lb
         qVDQ==
X-Gm-Message-State: AFq9FYIkW27CNkt5Ydrok0cvu/yzRVNOzFcXD+nIdp/bveXCsOq8hYah
	TTCxaaPG7SXk32j0e3pil81rWQdA/WKQDe1LT8QA5r729DzQcTJJ0Ip1D610/A==
X-Gm-Gg: AYBFou1IY6/gkUKEqKP66zt9ANp5csDMYMDkRcJwYZ4wzpobQclN0AJdBiMR1HOEqED
	IhxLbhwx4bwLFEIr45znFPD9zoAElaOhscFDpqZa3UqphVwFjEGlN0QFt/rMIIA6nYCe9DW0Spz
	ZY484333LCy1BmzAmK40mBDeApswRUkmdj98cmAd8ObJ9wrHzoEObhsWbeSGkz7dHRRNbcGJ/DC
	s72zGpi03DfoxKkQ078Xbb6AQAVGj1nRimO0BnPZSKMFkNPKbhnqkbPsfT42aIKvMzfisqVVOLo
	NkRryxzIeDk0bKWwNy6BvSTsMsBylr3YqAWRZdml8HqN3CEqbxEpNyKJPlaLBfl4VSOeGyN8HfZ
	Mj9lJdV+JiWJLHwcjxxlKrd57Z9HSbAr79HiD1p5aj6h9QlVqCKQbK3xOOszEfnXj1zU0lAiD7J
	JmY8bFYNLnc0QApPrjHcgNSBOhmB4nttg6qXu6wYz0ikd1lQ8/CRBUyAW26yAvvvgqMbKpUtVWq
	Q==
X-Received: by 2002:a05:600c:4e8a:b0:4a1:d307:b52a with SMTP id 5b1f17b1804b1-4a1d7628838mr247659565e9.19.1792509660365;
        Tue, 20 Oct 2026 08:21:00 -0700 (PDT)
Received: from berwick ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d823ca7sm6307355f8f.38.2026.10.20.08.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:20:59 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96?= <kazumasa.shigeta@kanamei.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 4/7] stash push: avoid duplicate calls to preload_index()
Date: Tue, 20 Oct 2026 16:20:39 +0100
Message-ID: <a9875ba5b3595adde9e830c1ccb641633bab7454.1792509606.git.phillip.wood@dunelm.org.uk>
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

do_push_stash() needs to load the index so it can check that any
pathspec argument refers to tracked files. To do that it calls
repo_read_index_preload() which does not just load the index, it also
calls preload_index() which lstat()s all the files to see which ones
are up-to-date. do_create_stash() then calls repo_read_index_preload()
for a second time which lstat()s all the changed paths again and then
calls repo_refresh_and_write_index() which invokes preload_index() for a
third time. So we're preloading the index three times when we only need
to do it once. Avoid this by making the callers of do_create_stash()
responsible for reading the index and use repo_read_index() rather
than repo_read_index_preload(). This saves two lstat() calls per
changed path.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/stash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index aec79ed473..b4fe7465e4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1526,7 +1526,6 @@ static enum create_result do_create_stash(const struct pathspec *ps,
 
 	prepare_fallback_ident("git stash", "git@stash");
 
-	repo_read_index_preload(the_repository, NULL, 0);
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
 					 NULL, NULL, NULL) < 0) {
 		ret = error(_("could not write index"));
@@ -1662,6 +1661,7 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 
 	memset(&ps, 0, sizeof(ps));
 
+	repo_read_index(the_repository);
 	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
 			      NULL, 0);
 	if (ret == CREATE_SUCCESS)
@@ -1707,7 +1707,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 		goto done;
 	}
 
-	repo_read_index_preload(the_repository, NULL, 0);
+	repo_read_index(the_repository);
 	if (!include_untracked && ps->nr) {
 		char *ps_matched = xcalloc(ps->nr, 1);
 
-- 
2.56.0.134.g299a3c16181

