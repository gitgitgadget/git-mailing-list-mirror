Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7E7462
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 05:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712554024; cv=none; b=AkCJh3YwZ/aB+lHPSfFxLi5RMayNNlMeedUYO52lVBnOoMNj3qYAKuXYSvbjIjvCxjqEjGggahhR+A92rIhpe4KWJAudpfoyLAEuLnONdW9jeXB2loy//+CgVOwT3xax9RbLh3tfegVfJThu4YxfLMl5sF4TGiaJFAl1t9KK/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712554024; c=relaxed/simple;
	bh=T5iRtO+8L2PhKi2C/r88gPDskMJduAuBdLcDYmXx+Zc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sS3SK9UJf2n+QoJhLNKogQ9SU0vb1GXXhNlgCG+ssNoMddSvdQs+GqEM2xHKVeRqqZbN+jQ7AMQD8sOHylghGUhHqop4Nc6qomANVJ1X7D92BFpYcg2NrpkQIYG8j3p3+J7xxKrpd1tK7/mLogqL3Pnfd+kg3mwUYn0RR4v0TGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/uk9AJw; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/uk9AJw"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so55008021fa.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 22:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712554020; x=1713158820; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFuLCCDrM8ei6fwj7WKW3UL9hnxpYMJF2Odma71edHU=;
        b=Q/uk9AJwaNW4vDKYU96Mzb4GOGNXBVRBPHJyYsDlXmRktCCgiJ8KqaK1KwQyZVrBXf
         TlqYBN0WCykQ9Yh9d81JMEpDhT6hG2Cj5+60P7PaX99Ef+3C67CTgVvu1HEga1SmX9cZ
         13AyYWNDwYBlMNAzX7boaJ+iB3LNpx7DFtzc+SKYfz4L7cpcCjhmrvMCNCfUBxerBrx9
         rY3EpoDgOxCK5d9gSw+kGSU1ZfHsd/705L+WX4mu0/PJ1dTvToFjGmP1Gp6eDSjALyCY
         8ZgbnX+pPkhU/yw2HhOFk5UPWWx2fouDVoEWVVodWja47ybJgOQd6Oa2FQJuw1cJ11BG
         TxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712554020; x=1713158820;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFuLCCDrM8ei6fwj7WKW3UL9hnxpYMJF2Odma71edHU=;
        b=LUE8LVkQyscXHzpQdq8kDghjlFWEI5mR+QUPUieA0CC5qCm4Xu4rClp0sgRXDIWCYD
         lcQ5TTDPG9wmNEUNXay4LCiiFhBo8Xe+uvFCOKwVmOsSNEcTBmW36rb1tXPLgZ60UuVs
         QBM/phgaNcnx0gsLi1ODA9CApveYMEh6WNfp7ik/kpp76gsoT9LKBXMYvG/ouumeNHf9
         F4wy60ZbrfwaLlFMbQPcMP4qYsbV/SmIWoN78T3GQxdpM+KQiFGnZrDmUKfxrkJWx3TF
         VGgLwdlxLqoOcCf8TNz/ne13Ptg0Tw0dGwx8VGCkBNPY1f6QwrtKg3Eu6g3G3Mg/zpXZ
         3CNA==
X-Gm-Message-State: AOJu0YwnX4n62r0OqYt6ed+IcBDVxAi/m7GMcoMp43A1JW0RE6lh9cIi
	xV11rPytubNVTc2o+/qj4U/j5NXiszO72aHY500z7bbx69ArplEjuSxvT1Oc
X-Google-Smtp-Source: AGHT+IFiWs7I1S8yPJ0FFTx7N7TRzUvxWODuudr3c7fxvi2Om0F8uNJm1bxJMYuyLYxw6FhG4PDCWQ==
X-Received: by 2002:ac2:4467:0:b0:516:d8e5:4e13 with SMTP id y7-20020ac24467000000b00516d8e54e13mr3450319lfl.26.1712554019493;
        Sun, 07 Apr 2024 22:26:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z8-20020adfe548000000b0034335e47102sm8016467wrm.113.2024.04.07.22.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 22:26:58 -0700 (PDT)
Message-Id: <pull.1711.v2.git.1712554017808.gitgitgadget@gmail.com>
In-Reply-To: <pull.1711.git.1712495507815.gitgitgadget@gmail.com>
References: <pull.1711.git.1712495507815.gitgitgadget@gmail.com>
From: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 05:26:57 +0000
Subject: [PATCH v2] midx: disable replace objects
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
Cc: blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

We observed a series of clone failures arose in a specific set of
repositories after we fully enabled the MIDX bitmap feature within our
Codebase service. These failures were accompanied with error messages
such as:

    Cloning into bare repository 'clone.git'...
    remote: Enumerating objects: 8, done.
    remote: Total 8 (delta 0), reused 0 (delta 0), pack-reused 8 (from 1)
    Receiving objects: 100% (8/8), done.
    fatal: did not receive expected object ...
    fatal: fetch-pack: invalid index-pack output

Temporarily disabling the MIDX feature eliminated the reported issues.
After some investigation we found that all repositories experiencing
failures contain replace references, which seem to be improperly
acknowledged by the MIDX bitmap generation logic.

A more thorough explanation about the root cause from Taylor Blau says:

Indeed, the pack-bitmap-write machinery does not itself call
disable_replace_refs(). So when it generates a reachability bitmap, it
is doing so with the replace refs in mind. You can see that this is
indeed the cause of the problem by looking at the output of an
instrumented version of Git that indicates what bits are being set
during the bitmap generation phase.

With replace refs (incorrectly) enabled, we get:

    [2, 4, 6, 8, 13, 3, 6, 7, 3, 4, 6, 8]

and doing the same after calling disable_replace_refs(), we instead get:

    [2, 5, 6, 13, 3, 6, 7, 3, 4, 6, 8]

Single pack bitmaps are unaffected by this issue because we generate
them from within pack-objects, which does call disable_replace_refs().

This patch updates the MIDX logic to disable replace objects within the
multi-pack-index builtin, and a test showing a clone (which would fail
with MIDX bitmap) is added to demonstrate the bug.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
    midx: disable replace objects
    
    cc: Taylor Blau me@ttaylorr.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1711%2Fblanet%2Fxx%2Fmidx-ignore-replace-objects-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1711/blanet/xx/midx-ignore-replace-objects-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1711

Range-diff vs v1:

 1:  b1c838965ab ! 1:  1be25b55c5a midx: disable replace objects
     @@ Commit message
          Codebase service. These failures were accompanied with error messages
          such as:
      
     -      fatal: did not receive expected object ...
     -      fatal: fetch-pack: invalid index-pack output
     +        Cloning into bare repository 'clone.git'...
     +        remote: Enumerating objects: 8, done.
     +        remote: Total 8 (delta 0), reused 0 (delta 0), pack-reused 8 (from 1)
     +        Receiving objects: 100% (8/8), done.
     +        fatal: did not receive expected object ...
     +        fatal: fetch-pack: invalid index-pack output
      
          Temporarily disabling the MIDX feature eliminated the reported issues.
          After some investigation we found that all repositories experiencing
          failures contain replace references, which seem to be improperly
     -    acknowledged by the MIDX bitmap generation logic. During cloning or
     -    fetching, git-pack-objects, which may make use of MIDX bitmap to find
     -    objects to pack, would give wrong objects even if we explicitly
     -    specified not to enable replace refs by GIT_NO_REPLACE_OBJECTS=1.
     -    Indeed, this issue appears to have persisted since the introduction of
     -    MIDX.
     +    acknowledged by the MIDX bitmap generation logic.
      
     -    This patch updates the MIDX logic to disable replace objects during
     -    operations, mirroring the handling seen in single pack index scenarios,
     -    i.e. git-index-pack and git-pack-objects. The added test uses
     -    git-rev-list to give a more intuitive check.
     +    A more thorough explanation about the root cause from Taylor Blau says:
      
     +    Indeed, the pack-bitmap-write machinery does not itself call
     +    disable_replace_refs(). So when it generates a reachability bitmap, it
     +    is doing so with the replace refs in mind. You can see that this is
     +    indeed the cause of the problem by looking at the output of an
     +    instrumented version of Git that indicates what bits are being set
     +    during the bitmap generation phase.
     +
     +    With replace refs (incorrectly) enabled, we get:
     +
     +        [2, 4, 6, 8, 13, 3, 6, 7, 3, 4, 6, 8]
     +
     +    and doing the same after calling disable_replace_refs(), we instead get:
     +
     +        [2, 5, 6, 13, 3, 6, 7, 3, 4, 6, 8]
     +
     +    Single pack bitmaps are unaffected by this issue because we generate
     +    them from within pack-objects, which does call disable_replace_refs().
     +
     +    This patch updates the MIDX logic to disable replace objects within the
     +    multi-pack-index builtin, and a test showing a clone (which would fail
     +    with MIDX bitmap) is added to demonstrate the bug.
     +
     +    Helped-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
      
       ## builtin/multi-pack-index.c ##
     @@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'tagged commits are selected
      +		cd repo &&
      +
      +		test_commit A &&
     -+		A=$(git rev-parse HEAD) &&
      +		test_commit B &&
     -+		B=$(git rev-parse HEAD) &&
     -+		git checkout --orphan=orphan $A &&
     ++		git checkout --orphan=orphan A &&
      +		test_commit orphan &&
     -+		C=$(git rev-parse HEAD) &&
     -+		git rev-list --objects --no-object-names $B |sort >expected &&
      +
     -+		git replace $A $C &&
     -+		git repack -ad &&
     -+		git multi-pack-index write --bitmap &&
     -+		git rev-list --objects --no-object-names --use-bitmap-index $B |sort >actual &&
     -+		test_cmp expected actual
     ++		git replace A HEAD &&
     ++		git repack -ad --write-midx --write-bitmap-index &&
     ++
     ++		# generating reachability bitmaps with replace refs
     ++		# enabled will result in broken clones
     ++		git clone --no-local --bare . clone.git
      +	)
      +'
      +


 builtin/multi-pack-index.c    |  3 +++
 t/t5326-multi-pack-bitmaps.sh | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index a72aebecaa2..8360932d2e7 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -8,6 +8,7 @@
 #include "strbuf.h"
 #include "trace2.h"
 #include "object-store-ll.h"
+#include "replace-object.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]" \
@@ -273,6 +274,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 	};
 	struct option *options = parse_options_concat(builtin_multi_pack_index_options, common_opts);
 
+	disable_replace_refs();
+
 	git_config(git_default_config, NULL);
 
 	if (the_repository &&
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 70d1b58709a..1fb3b0f9d7a 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -434,6 +434,27 @@ test_expect_success 'tagged commits are selected for bitmapping' '
 	)
 '
 
+test_expect_success 'do not follow replace objects for MIDX bitmap' '
+	rm -fr repo &&
+	git init repo &&
+	test_when_finished "rm -fr repo" &&
+	(
+		cd repo &&
+
+		test_commit A &&
+		test_commit B &&
+		git checkout --orphan=orphan A &&
+		test_commit orphan &&
+
+		git replace A HEAD &&
+		git repack -ad --write-midx --write-bitmap-index &&
+
+		# generating reachability bitmaps with replace refs
+		# enabled will result in broken clones
+		git clone --no-local --bare . clone.git
+	)
+'
+
 corrupt_file () {
 	chmod a+w "$1" &&
 	printf "bogus" | dd of="$1" bs=1 seek="12" conv=notrunc

base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
-- 
gitgitgadget
