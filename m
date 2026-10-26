Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793018412;
	b=YSYl/mRy7+11sQcMfe9SnbXIHKiS0+Tyh9RPCfrDcITXjhic4IbdYurBxg/onWDa53HR
	 gP+oLMP2ERQEFnQOzJujB4RjghI4+NE5DsYhCuBtSow5h9YTPC1IcWfarMTb7+NZsq6DZ
	 i9oKkwPdOp2YPgAK/YbeDopbTjcpPLn5xW3yR9HSa8wGVtzlfPaN6sB76JmSAlz3ZmMGu
	 LZ9yywCbZV+zG55N38xT8wbqJO8nOqEOQC9yt/X8a0CrITommt6ZKlfpDydSgn368fVeq
	 gdIyhbzEYJV02GNLLOy4qmViG0f9yy4aX7/nyCBinoBaBnpGXVbFKv0ZTna9Tv6at2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793018412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
	b=BEkahgQZHOenhkCy9Su1CTfa0nVU9S5KruUgJVYHYgEJ5BS1jwedJ2ZA87nmc9Nr2A9I
	 HUEK9CgGZVWYz6bY4F17If6xBgfQvgIPDyCk9NcNbZkLmJMdJP/kNQ/zpDoMu2MQDZdFt
	 HjC0YbqMHRk5t96zaJMFzD+DH8GyakhNGdc2rgRHzhlq0LlkSuxVHLPpQPI+e/ec3SkRQ
	 2ORWPuJKt9gNHyjV6cV6zooMxSl1Zo7tAyJ1X/1O0v21W5z+ZKccfiHv+ItiHN96yUDaG
	 ih/49wWuEVa+wy6tw4MMSngXZYxeKejIGZOCZtqSAB961+PZ3pn9i/YZP7Zr7TlRfWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ro1xZGO+;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB52606A32A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 12:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CB52606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ro1xZGO+
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so12551995e9.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793018411; x=1793623211; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
        b=Ro1xZGO+UtpaUwW4F9dZhoV0MDn+6gChkmK7rupUWnZiBtX13a14Iytpi6emCP0oMf
         YHyJpC+R/VuslpKzdkxrcxlKixcE+OcoEjY4d7P3AeSAwyejnqwPFPGS9H3Lao3Yq4jL
         vdK/X/33ZvsbX87fmQauPRlAqDnttC3bkt82tWbcmmGgA+MYA48VsLlC+sYlSCXfFFe9
         BqE1WF5Wvlxm7WmcZJXNnORHLVZqDsgM4wQ4Cdv/f7QKh7z5f1kdONvUSqd73UE46nr8
         9J2sfjwN+jC97Il6B4pg7MWaUi9rCPsaq5e4XmTgkD9bV6j1kbQIpsoRNHGSvWKiQzK4
         peMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793018411; x=1793623211;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=atLJWz8cXQbgEe1TNShMXj7VmM7iFZBbO+F6RiNZk0c=;
        b=sTd/2bTr0F+292Ejv4ETNdIvR3lMqSCcdP3fPxUZdx0rw9jOxlD70RIQDjDDXQw70X
         57bV6H/i/sblpEV8gIuCrqBAYa6x+lNML/f56Zi6SZUrUmMIGiEGEcXhgBLJKSuKX23j
         JwbLvorSqC+37378eafF4Bxs1GOramiuVkl49sxk3N+v4+UG+isiS9vn4lwyUmSNzzm4
         7v2OUKXXqcvYTBU0FklSuGAGurdIyv/eaiN9okfzoWcQvi666mUCdbwTOYxYgrdeAUSd
         9/SbIQYqndOpRddolnWQ8voCXqiZ7/kIYGVzk3vf5tSyzhJrWrWg293sVFvLYJQlauzB
         R+3A==
X-Gm-Message-State: AFq9FYKq/16+TRNsD0Txre5Zntr9b38nXWl/eUbfOeIcgb0s9Ib0GWto
	UEJ68COoVJ/xqhD2gh7uWCzcW5vG4rMdj3dIl+u45PNu46YvbRWMb0wS1GEzc57sleE=
X-Gm-Gg: AYBFou1PLFs8LzWy5gkgUQxKiI0kIotQv0F2fBmCnGbF0OQAbk6hNCcJurSViq8jYJy
	kRPto6Jv2MpMdEJkiERpWD0+1AaYeby8jCYjplzwLn0El9FAXLOEKVsyQ833g3xZ1YBTkPLvHtB
	BjQBPf8i/sbaIftOWQZ+MDF3uOgihE1v6n41z5lcFyG1lqCMZyelXnokqQVXRVED0ebq6HVW5NC
	JiTrNN3xlSLDABeL880/n6hcPN30PRxkG1Ks5GddskiPI4fHEFp+cNkYqBHajZ0FbaOQk9CrEfR
	CSrgBO8mHN+1bk0PJLJc4ZGImy7pXfQ5gmdf9uaAiEmAsVCGGrRRsclsSwClzGTBwkI6HI6fhWZ
	2liX3DNCP/4SS8eIB8FQmQqgbRqgbZ/vMo3zoReh5oAeMQuZI4OkktC6ae1cL127R0NdS3P2V1K
	XR1uQezE1xj2VuNWYrjAdHA2nzowtxUQoAf5Mu7hWKxMPU65yGkVGTB379PugC8pdC2Ok95lCY9
	ZqNpx+EmDG2tkhcEpEzTHlRdrqUYYSiixog5XTDDyIU65ZF1TLiKCmzgXE4
X-Received: by 2002:a05:600c:3f07:b0:4a1:813f:2a60 with SMTP id 5b1f17b1804b1-4a35ac91137mr109616035e9.11.1793018410391;
        Mon, 26 Oct 2026 05:40:10 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.191.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdd5b3sm16150194f8f.53.2026.10.26.05.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 05:40:09 -0700 (PDT)
Message-Id: <02351af1b5bb25b4125e85c52de9070ac6af2e64.1793018405.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v5.git.1793018405.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 12:40:02 +0000
Subject: [PATCH v5 3/6] doc: git-rebase: link to new merge conflicts guide
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ps@pks.im,
    Jeff King <peff@peff.net>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

Remove some of the detail about how to handle a merge conflict, since
it's explained in detail in the new guide, and there probably isn't
enough detail anyway.

Leave the steps since rebase is special and has a `--skip` option which
the other commands which cause merge conflicts don't have.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..da70aff498 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -46,10 +46,7 @@ If there is a merge conflict during this process, `git rebase` will stop at the
 first problematic commit and leave conflict markers. If this happens, you can do
 one of these things:
 
-1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
-   and make edits to resolve the conflict. For each file you edit, you need to
-   tell Git that the conflict has been resolved. You can mark the conflict as
-   resolved with  `git add <filename>`. After resolving all of the conflicts,
+1. Resolve the conflict. After resolving all of the conflicts,
    you can continue the rebasing process with
 
    git rebase --continue
@@ -62,6 +59,9 @@ one of these things:
 
    git rebase --skip
 
+See linkgit:gitmergeconflicts[7] (or `git help mergeconflicts`)
+for a full guide to handling merge conflicts.
+
 If you don't specify an `<upstream>` to rebase onto, the upstream configured in
 `branch.<name>.remote` and `branch.<name>.merge` options will be used (see
 linkgit:git-config[1] for details) and the `--fork-point` option is
@@ -1284,6 +1284,11 @@ include::includes/cmd-config-section-all.adoc[]
 include::config/rebase.adoc[]
 include::config/sequencer.adoc[]
 
+SEE ALSO
+--------
+
+linkgit:gitmergeconflicts[7]
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
gitgitgadget

