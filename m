Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C352BFC7B
	for <git@vger.kernel.org>; Sun, 24 May 2026 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779625696; cv=none; b=fE4V3T1uyHOg+UjsxLfREdNT2WglkccNhwkyVqc4OpCb5x1vTghuI2HOdT0uNIqgp65Vm+yTJh4P+sJqmrhC6nQwKUjlJNplH5oiy0Zys3Jki62eLL3AQG04WlkhoymtycP4XJvQOtRXjnpQmvFPsJo4qzntjjLY55t5J/2dLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779625696; c=relaxed/simple;
	bh=n4Uj5iuUXuv1k5XY3ajCnrZVg8l/RWc+VRZ87RQm0jQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=WYrf9GjQbGtOLv7hwvZVd+A8ct6uaW5MSzeqx4hLNjla1UTRXzboiuTK1OyWaSlgRGuwLIevPXcvXOqoLdfaufMHLATBQyZyuVTB+nqutW+6U8Nx79wH3Z18A+eDav+FU92IrDO7I2sRZQNaSdPDYazIz8NjUI6Y+dWlsD0dZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pCIWTZdM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pCIWTZdM"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso157699326d6.0
        for <git@vger.kernel.org>; Sun, 24 May 2026 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779625694; x=1780230494; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EhwHE3p3PGO3GGAKtAbXhzqFHJmLxfERfTTdVfvvfc4=;
        b=pCIWTZdMg0u5PGFlBvCTzbLujaLriW3l6gveF78CGsHhnbhOrqLYgACaQadYm7m0DN
         Q2wg0L75O1lDbKWF1HO27r1/IfApjf2PAsqfrNSe+lmhke78CIpTLbZ4boAMI3YldcQN
         Ykt5Ay4GQF/kWqqc5GB6vJC0RczscaDrus/GOzVGd5t5exUR9CDKU5Dj0MUh0FE33qaT
         3GO9PnBtTrp5wq5yCvavosTE+oBPz8da5KQU51lLIl93npZtzOIBEIo6Tz1bcaId2nVr
         5/0z+vtki16cWvk3SsnxPiz6sas5BbTUCbiy3ONJJUG38atqnLhRGn8wLX6JPTupMaJN
         v07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625694; x=1780230494;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhwHE3p3PGO3GGAKtAbXhzqFHJmLxfERfTTdVfvvfc4=;
        b=VHAkOB14m7WBNFv367rJmEGXZzVbnqQBjCN6u5PTFtr+lm4ldzLRi34eo6XN1E8dnc
         7pcn89nE+9qsgdiUl+sWFxBnXQRiv4EQxpVWloiSBkrv+lZlgBnN0LcdOc6t6eiXDOJy
         O89r6SbGip4Q10d39MhE2lIGlfS3N9kTwVEVFVcgD8X8jmxNamwH29+Y9UVa+yjEAH+/
         7oz/FbVxPYpwffGWtAvVvjPygNt+47246V+xeZa+7yWYt9cLn3c4aIgSN5C7fHKKCC2M
         9GHBAZsyad/mAEgdzV6cGgyOvhlt3/W1tZmSdhs4dnNpWuSZpoFzVaLAslUXcAnPK/vn
         sFBA==
X-Gm-Message-State: AOJu0YygVY0UBr5Ta7m37StfpLDEd3Pz2wSL1Hsz59nnufLxnWKAt/pu
	RO2syUjU3/ZYBkb+6lGCu3GH740fRT4k14yKtPtPcC6Lp/lhTWzekDOfRSkRaQ==
X-Gm-Gg: Acq92OGlmrLjupdbfndxDLd6bRQzivVvaOH8A9BZJOoNKoGXdi4hqzLO5yCMBBsxoPT
	PG6anWCsbyUTZrSB6qCkZjHLBI+eaNYAJr5rY8Wkbuxz2cHoJWZ2JLwblGsPBHYUwkwudNol/C2
	IssBMwD/TEooTQmMP0C7Sk9DNsJCkGTlktSpfFG6LHNsZrunEY9mJ+btuppCaXfADvAPGl3mu/f
	qEGzHkpYSfv13Kch0q9pBOrJsPVH2MQ/ok6kjenBUASd2SZIf8F6ZHQ0q89e5rd5AmkAeNolaug
	KIHaDKkt07pOhE04iOUsjoyQ6Bq4ceo8lNOAJ66qs56phE6T6gnCkLM9D58FiZRttjGKoBeSQG+
	twwQThfP6WuTrXNjYZc+Z88ZBU293hwri0tsz1/hjudMNmkeTBPrcjU6AvYJrRx4lCPoDbnAZSC
	aNaXNVH2uzCKj4zst9mkUJi6DdkCfItBmQX7fd
X-Received: by 2002:a05:6214:3018:b0:8ac:a689:34ce with SMTP id 6a1803df08f44-8cc7b6a26e7mr171102026d6.45.1779625694297;
        Sun, 24 May 2026 05:28:14 -0700 (PDT)
Received: from [127.0.0.1] ([52.150.30.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ffc87dsm83398796d6.21.2026.05.24.05.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:13 -0700 (PDT)
Message-Id: <pull.2123.git.1779625693328.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 12:28:12 +0000
Subject: [PATCH] fetch: pass transport to post-fetch connectivity check
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

When fetching with a transport that sets `self_contained_and_connected`
(as index-pack does for self-contained packs), check_connected() can
use find_pack_entry_one() to skip connectivity verification for refs
whose objects exist in the new pack. This avoids sending those OIDs to
the rev-list child process.

However, store_updated_refs() never passed the transport to
check_connected(), so opt.transport was always NULL and this
optimization was dead code for post-fetch connectivity checks.

Thread the transport parameter through store_updated_refs() and set
opt.transport so that check_connected() can take advantage of
self-contained packs.

On a large repository (2.4M commits, 374K files, 10.9K local refs),
fetching 200 new commits:

  Before: rev-list connectivity check  22s,  total fetch  36s
  After:  rev-list connectivity check   5s,  total fetch  14s

The remaining 5s is spent verifying refs not contained in the new pack.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
    fetch: pass transport to post-fetch connectivity check
    
    We're working on reducing git fetch times on a large monorepo (2.4M
    commits, 374K files, 10.9K local refs). Profiling showed the post-fetch
    connectivity check (rev-list --objects --stdin --not --all) dominating
    wall time when there are new objects.
    
    While investigating, I noticed that check_connected() already has a fast
    path for self-contained packs — it uses find_pack_entry_one() to skip
    refs whose objects are in the new pack. builtin/clone.c passes the
    transport to enable this, but store_updated_refs() in builtin/fetch.c
    does not, making the optimization dead code for fetches.
    
    The fix is a three-line change to thread the transport through.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2123%2Fspkrka%2Ffetch-transport-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2123/spkrka/fetch-transport-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2123

 builtin/fetch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a22c319467..647fd1c30c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1213,6 +1213,7 @@ N_("it took %.2f seconds to check forced updates; you can use\n"
    "to avoid this check\n");
 
 static int store_updated_refs(struct display_state *display_state,
+			      struct transport *transport,
 			      int connectivity_checked,
 			      struct ref_transaction *transaction, struct ref *ref_map,
 			      struct fetch_head *fetch_head,
@@ -1228,6 +1229,7 @@ static int store_updated_refs(struct display_state *display_state,
 	if (!connectivity_checked) {
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
+		opt.transport = transport;
 		opt.exclude_hidden_refs_section = "fetch";
 		rm = ref_map;
 		if (check_connected(iterate_ref_map, &rm, &opt)) {
@@ -1432,7 +1434,7 @@ static int fetch_and_consume_refs(struct display_state *display_state,
 	}
 
 	trace2_region_enter("fetch", "consume_refs", the_repository);
-	ret = store_updated_refs(display_state, connectivity_checked,
+	ret = store_updated_refs(display_state, transport, connectivity_checked,
 				 transaction, ref_map, fetch_head, config,
 				 display_array);
 	trace2_region_leave("fetch", "consume_refs", the_repository);

base-commit: 6a4418c36d6bad69a599044b3cf49dcbd049cb45
-- 
gitgitgadget
