Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645DB1DE4FB
	for <git@vger.kernel.org>; Tue, 20 May 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733247; cv=none; b=e9hRfE2IAIx/f15IsY9cH/TyBO3M1dV18pns5WgKywPDRo5dORnxCmvlbxL72kkdGVne/SrB4sbmWfmkTJM8EZIyQg8cyvw+pBfxznnR/Y2B77lMYkSBiPXhdQoK0fO26y2GCxK95EjWgRCKSJaPePU4SHL0ns4JiSJC3mp7SzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733247; c=relaxed/simple;
	bh=as2LMvIOEQL0AVJBmHLMg7DAOQKXp1U0sBQ/X/uSlBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCwJuDF8g3ZmV5FqLJ8tcC7HZraGxrX2ijbYfDra/vZC09s02ll1ULOaR/KJvHjKysucaPERDvwnOWEccXWytxvbl5OO01HKWPn3uyxR7uHHnDjXepuNPKu4pATSF2XsFowwLoVd1kS2xN+ViJipV3J0CmGT/meDdLrMfp+FfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeAC3QTq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeAC3QTq"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso67098215e9.2
        for <git@vger.kernel.org>; Tue, 20 May 2025 02:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747733243; x=1748338043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a1k+3/nKPI8Za8vNwLrevH1iS9AsfG7pfbvSFP6t2cs=;
        b=CeAC3QTqjyIiXja8B3QtWMCOdhhbWNISl/1SlvWVMT4r1V+737PJ07vdONaqjSUgjL
         DMGUNlUXfQuInqNt4MblU4vLenOfV2ibXvegT8o2L84/XA7fNATqJaM0xOBSH38JCOZ5
         sNGbVnW3hZPH6v4WR13fdMjEzO6CtQAsijDK9PwJLq1dgTWPkJG6Qauoj5Azp8njHvwU
         amP3oLNcsyIlQ/kyWE5SO6kn0O0GPAasbG8Sq8MlP1zFM9yxkA3o6e+c/28fV+nfAOlK
         Sww+gtWYaiMf5W3EwbtXXzRfzU3v+D/1SkK2F1eUa1ePH8R6fEE0GrbBXWK4z1vgEpJ8
         6zPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747733243; x=1748338043;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1k+3/nKPI8Za8vNwLrevH1iS9AsfG7pfbvSFP6t2cs=;
        b=FPTRLkx0CIqbJsJyehSblb1hbVbkRram6mGh6KLB4x0MeCzTcNVN46+ibhZ5ZNODGG
         Br7ZA+XiKjWT9IfzprB3M/IwPk+oHwSixTzIvHqm7AKXHwjn+496i5db+ru1ha6ZQNkc
         lMmZo2LD+TiZIYgIQmra7M28lKc4LaeC3fW3svEiMPOXe8yNOlPfRreuCtgj1ItadYxb
         Q8A1XAkgv4aYmG7Xk2CBLYLRosQYTA1y/uIdmQgYTFSTm7Lypq6dtXQlGGH5n0loFKRJ
         iWdrs5R4cKRfn/1g6J5odXiB7jDnTLuTVsYyNCnztA8HosnL8Uw88QnBMajZQtWz2UJ5
         c9rg==
X-Gm-Message-State: AOJu0YxCsdTNjjCIFSOhIOpOrw4G1IoD2KtNgS5FwkWfuwATEP24Kbfx
	WuB/KNZ9QFUS1GjYOSzbqz08oVzlOggRgwJ4gshIFnvWO9AbyXIrOa6HB2fRoQ==
X-Gm-Gg: ASbGnctygJgxb2B2sG1pJvNaR6ewQFJNsujSjqT2OTjC4i5s57Zuw57dngWKwkJVgBh
	w6ccrVCI3a/uvtZjmM1dBcOAde5DyUyyB9Rgrd0/OuEVO9RxY9uWtwivuKDsxAlYyJ/GE8MdqA2
	MUDrtGAv+6ap+cTn7FkvEYnO3B6g78ZuKajY5BJNPlrHJvT4qUhGjFrDF/eOkMP+cnBVuVlu/OG
	otAVAsATUq/87pAgzY+ljNyaJmoISYviR0P2pBVBoCvifYcTx9kac2fKxAzukGN5jepl/TZnW4x
	55SRklr9NIy5ZhQMIQI6m5yuQom2BXGWkwJk5eUjxWoyygqTNcM1/cs8KB+4qveBiL8=
X-Google-Smtp-Source: AGHT+IGNoIR9Mn5d5Bm+nnik9jd5LFmLvvw8HT92d4mNoF1FKAQBWIXp8rp31UF7NVnGKlH42RIMfQ==
X-Received: by 2002:a05:600c:154a:b0:442:d9f2:c753 with SMTP id 5b1f17b1804b1-442fd6647e7mr128504895e9.26.1747733243249;
        Tue, 20 May 2025 02:27:23 -0700 (PDT)
Received: from berwick.broadband ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f062c7sm23544255e9.14.2025.05.20.02.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 02:27:22 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/2] stash: fix and improve "git stash -p <pathspec>"
Date: Tue, 20 May 2025 10:26:58 +0100
Message-ID: <cover.1747733203.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
References: <6292feee7c4347efad31e9fb2a1763779b7df133.1747407473.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

"git stash -p <pathspec>" should imply "git stash push -p <pathspec>"
but that was broken by a code cleanup in c3713cede7 (stash: eliminate
crude option parsing, 2020-02-17). This regression is fixed in the
first patch. Although "-p" implies the "push" subcommand "--patch"
has never implied "push". That is fixed in the second patch.

Thanks to Junio for his comments on V1.

Changes since V1:
 - Split out the regression fix into its own patch

Base-Commit: 1a8a4971cc6c179c4dd711f4a7f5d7178f4b3ab7
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fstash-assume-push-with-dash-p%2Fv2
View-Changes-At: https://github.com/phillipwood/git/compare/1a8a4971c...98ad3de97
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/stash-assume-push-with-dash-p/v2


Phillip Wood (2):
  stash: allow "git stash -p <pathspec>" to assume push again
  stash: allow "git stash [<options>] --patch <pathspec>" to assume push

 builtin/stash.c  | 10 +++++++---
 t/t3903-stash.sh | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

Range-diff against v1:
1:  6292feee7c4 ! 1:  2cd67f5cd85 stash: allow "git stash -p <pathspec>" to assume push again
    @@ Commit message
         Historically "git stash [<options>]" was assumed to mean "git stash save
         [<options>]". Since 1ada5020b38 (stash: use stash_push for no verb form,
         2017-02-28) it is assumed to mean "git stash push [<options>]". As the
    -    push subcommand supports pathspecs 9e140909f61 (stash: allow pathspecs
    +    push subcommand supports pathspecs, 9e140909f61 (stash: allow pathspecs
         in the no verb form, 2017-02-28) allowed "git stash -p <pathspec>" to
         mean "git stash push -p <pathspec>". This was broken in 8c3713cede7
         (stash: eliminate crude option parsing, 2020-02-17) which failed to
         account for "push" being added to the start of argv in cmd_stash()
         before it calls push_stash() and kept looking in argv[0] for "-p" after
         moving the code to push_stash().
     
    -    The support for assuming "push" when "-p" is given introduced in
    -    9e140909f61 is very narrow, neither "git stash -m <message> -p
    -    <pathspec>" nor "git stash --patch <pathspec>" imply "push" and die
    -    instead. Fix the regression introduced by 8c3713cede7 and relax the
    -    behavior introduced in 9e140909f61 by passing
    -    PARSE_OPT_STOP_AT_NON_OPTION when push is being assumed and then setting
    -    "force_assume" if "--patch" was present. This means "git stash
    -    <pathspec> -p" still dies so do assume the user meant "push" if they
    -    mistype a subcommand name but "git stash -m <message> -p <pathspec>"
    -    will now succeed. Tests are added to prevent future regressions.
    +    Fix this by regression by checking argv[1] instead of argv[0] and add a
    +    couple of tests to prevent future regressions.
     
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
     
    @@ builtin/stash.c: static int push_stash(int argc, const char **argv, const char *
      
      	if (argc) {
     -		force_assume = !strcmp(argv[0], "-p");
    -+		int flags = PARSE_OPT_KEEP_DASHDASH;
    -+
    -+		if (push_assumed)
    -+			flags |= PARSE_OPT_STOP_AT_NON_OPTION;
    -+
    ++		force_assume = argc > 1 && !strcmp(argv[1], "-p");
      		argc = parse_options(argc, argv, prefix, options,
      				     push_assumed ? git_stash_usage :
    --				     git_stash_push_usage,
    --				     PARSE_OPT_KEEP_DASHDASH);
    -+				     git_stash_push_usage, flags);
    -+		force_assume |= patch_mode;
    - 	}
    - 
    - 	if (argc) {
    + 				     git_stash_push_usage,
     
      ## t/t3903-stash.sh ##
     @@ t/t3903-stash.sh: test_expect_success 'stash -- <pathspec> stashes and restores the file' '
      	test_path_is_file bar
      '
      
    -+test_expect_success 'stash --patch <pathspec> stash and restores the file' '
    ++test_expect_success 'stash -p <pathspec> stash and restores the file' '
     +	cat file >expect-file &&
     +	echo changed-file >file &&
     +	echo changed-other-file >other-file &&
    -+	echo a | git stash -m "stash bar" --patch file &&
    ++	echo a | git stash -p file &&
     +	test_cmp expect-file file &&
     +	echo changed-other-file >expect &&
     +	test_cmp expect other-file &&
-:  ----------- > 2:  98ad3de9770 stash: allow "git stash [<options>] --patch <pathspec>" to assume push
-- 
2.49.0.897.gfad3eb7d210

