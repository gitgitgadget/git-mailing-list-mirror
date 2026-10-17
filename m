Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F50743DEAC
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792275110; cv=none; b=Yc8z1tGMDXwkKJGVNPNcU4KSJ4SfZJ36uTLJcyRj15+UA1BG6MLUFG3Gcu/21HYjsdVqPw7IYWkljk53UFtMOIKYqwbAX834+2bTsBhI0cY62Z2jqIqfvK+lhfQtdCjZgVL5bpz8s7k0w48MShrfSUDHL7U3zwyTnT3ju3PuNHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792275110; c=relaxed/simple;
	bh=aYCEkvxLkraEWgaCYYyTmGlQSoCSIJUP2FdkaBLz5IU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=rbrjzm3q37trnhmemPnJ2tIZWnsPBz1OWK2Iz5v5QcWzdCz87TpfEiPefjJNr2qx5IILU+vFMhHmkzlsScNf1E67pTR8F4nLuAVyEs67/KwSSioX4p94aF+zZ+OIDAa3iek38sR8z3WoXenRhMVOwYwu0vaAnorqLF+k+Q3UtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oS+RpcY5; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oS+RpcY5"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3514b90bb89so2579496eec.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 15:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792275108; x=1792879908; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v+HlR+I8lODrRV4k5UNVO1Clv05kAqIMtf9qDFfWTj8=;
        b=oS+RpcY515dj21em3uakhSnpwdBoTOg7SRu7N/aD8sWXugBVMrsqjU3G6Ohcvg+Pxa
         uet8GIb/A+sjvT6xIsXl7Flp+Cla+uNz7nPaJypdFMzPEmFLTJmYWuIFGhNad+HrcpAF
         l1N/opO/2/2NWKLw1DwkIZgICcFVw7j6EaNOKguVeS442G060QpVhS7mm3Hpx/NDKq2O
         Pe5HA3vRCETeWtIMJ5KS7AaGB93VXGCOoL5fa20ErKWAAwv9o5UtuJ/y6Xv59b5rP/Ib
         lPHQCFu26p0LOgfv39d4FIGgTBW2pEv9wuKBY5ZuHN3AiC7maCEeJdn5+cvhtemP/lvA
         XEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792275108; x=1792879908;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v+HlR+I8lODrRV4k5UNVO1Clv05kAqIMtf9qDFfWTj8=;
        b=bkaiH/0KRR1ExOU7wvc47RenljyEtbIL6zBNjCNejWpz72g7Z0J6r38qEuO6E/d9yp
         xwUiyfQJsWfjyfaka4BDn0vhokO2t4TutcgBtGlWHDtxXdU468h+UvcGn6FOzEgHlFeK
         uGhsCMKieBev7JkYUB8+tsIxbBa2KcWIhRbpw88OCG7HQSO9mQ1waUofWhx8XYWk4mRx
         6Ykb5CxfIwJRc249XaCdE2xYpkQHkgCA8OiGO+lGyZbKte+MblrnGgFcvsScLnFDrC5h
         aqD32eRMfWh99rfhM95SSCt3puV0Wr8jNipjhRZm9YhnQPF8u0AUwAdY3PL+BYlKWgik
         mCxA==
X-Gm-Message-State: AFq9FYKEu28ZYmQPj5gHKXKnaeHox8lo5jwr1p2uqeJBor5JZiXEy8ME
	VIntrR1mWV2UnvuXqWzuiVT/T0SrZxhsSNaU6sBCIlGZ7R2c1StgOtSjUmzkJCj6
X-Gm-Gg: AYBFou3GpK6vGqul1SPDpa/BR/jGxg880OCelGpc6spO8xROOunShDd+W6ap9S4ZgYo
	QrYSLn7NxMs7v92YYzPNy6UUttLXX0MS3OwnAJAER5aVQraigT4NDHy4pHH7dj4oCJIMkL2Ef11
	JfckBvJ0QTrBsT+9RfelminUsiODFEfRNRxOjmuFdDSsjSDr0BM8a+/V+ncARMS27Eu4FVZYG5H
	qsTU0+DZYy2xBvI1lRoE746o4a3Zo0C85Wi2blLn/P86wCcgV2kYYn6QEKowmWH5QwjKqPFtJoT
	1KcS2d37U+juNn8fwL6Zftqo0nls6V4B3YcIHGoxGTGZszBZdGliDsgb2GYMGDxdKL3wvljsuKa
	gS5pLhPE7NBi0F8mxGmVIgJbkDC7SjZs2wTpSy0aVKGqwNqTVS9uFoqXaxb3G6bgrN0MBdojiiG
	246F/Lc9NNq/LQgI+1JlyoHfMdcUgLot9QUO6SzHI/fQB05q7snDmUuev5nml+DhteKS9Qucc=
X-Received: by 2002:a05:7300:e9cc:10b0:361:167c:2364 with SMTP id 5a478bee46e88-361a146d9dfmr5687926eec.8.1792275107975;
        Sat, 17 Oct 2026 15:11:47 -0700 (PDT)
Received: from [127.0.0.1] ([4.236.92.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm34249504eec.24.2026.10.17.15.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 15:11:47 -0700 (PDT)
Message-Id: <pull.2455.git.git.1792275106640.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Oct 2026 22:11:46 +0000
Subject: [PATCH/RFC] upload-pack: fix slow fetches from a shallow repository
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Fetching from a shallow repository with a long history can hang. In a
homebrew-core clone with 900k commits, fetching one new commit into
another clone took 7 minutes. The same fetch over protocol v0 takes
about a second.

Over protocol v2, the server goes through all of its history to work
out which of its shallow commits to tell the client about, and a
history with many merges makes it go over the same commits again and
again. Protocol v0 lists all shallow commits and lets the client sort
them out.

Do the same in v2 when the client does not ask for a depth. This also
makes `git clone --reject-shallow` refuse a shallow repository over v2
in every case, as it already does over v0. For `git fetch --unshallow`,
which still needs to go through the history, visit each commit only
once.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    upload-pack: fix slow fetches from a shallow repository
    
    Fix git fetch hanging for minutes when the remote is a shallow
    repository with a long history.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2455%2FHaraldNordgren%2Fupload-pack-shallow-walk-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2455/HaraldNordgren/upload-pack-shallow-walk-v1
Pull-Request: https://github.com/git/git/pull/2455

 shallow.c     | 3 ++-
 upload-pack.c | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/shallow.c b/shallow.c
index 8e244a5669..921db5e17a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -209,7 +209,8 @@ static struct commit_list *get_shallows_or_depth(struct object_array *heads,
 				*depth_slot = xmalloc(sizeof(int));
 				**depth_slot = cur_depth;
 			} else {
-				if (cur_depth >= **depth_slot)
+				if (depth == INFINITE_DEPTH ||
+				    cur_depth >= **depth_slot)
 					continue;
 				**depth_slot = cur_depth;
 			}
diff --git a/upload-pack.c b/upload-pack.c
index 197bcfa279..844bf80575 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1718,9 +1718,8 @@ static void send_shallow_info(struct upload_pack_data *data)
 
 	packet_writer_write(&data->writer, "shallow-info\n");
 
-	if (!send_shallow_list(data) &&
-	    is_repository_shallow(the_repository))
-		deepen(data, INFINITE_DEPTH);
+	if (!send_shallow_list(data))
+		advertise_shallow_grafts(1);
 
 	packet_delim(1);
 }

base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
gitgitgadget
