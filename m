Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793864031;
	b=qBr4/nMSZHhTV+/fFGBiCw9Le/n7o/FoUVeqALWUkNMQ73jlJxGhPmz0NkEnvlWA4RW3
	 N3TqTk4xzj7ok4Ur59TYpczWdpNgZE9apmKbLLHaSqnlN088i2dm+hpZ4Bu/DHcgwm/Fx
	 66tNqB156TmU9UlFcceRqCmFLC6FVvoCclnWRs7aw3bPoffYMITalIxY7OHN1pWSiX9Bw
	 CA7QXeC51L6li07qCMLnw7mQSQ+mYbQ76SJWfGoQQ3a7dRRUJf0Ljr2p2cHkofRS5Q2TE
	 qetksy5IUoKT8wpebTQPBIV6C0X7NW7NuYRyiRzte33oIQ97Uettb1Zk9a8GP+kyIHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793864031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=X4sDs8+yOa2alW70ncq0sc4x6VgtfAzgf5Tc7nj2Y4Q=;
	b=JOmZ6Qlpo1IBj9FHxP88wVPlXkBmz/UBESd24e7DeM7bbEST2uqoi7EhjVtEi/vrlqEH
	 Uy/PF6oy05IzcwXnXmrohSB/pLnE76g4V/Kw8VdPXBRUeqU4y6ltYea9lu+U7UfXa7vXJ
	 CUOz0Zs61Np0kIXZoF4t5kU9L2pv80pDAyw0RskXp8LHwDH9kD21vTdwIkAsLbECnt9TI
	 Jyq7YMhnMNS/7dgQ6kxkyMefUk8SJ6iMS0HB3hSeRF4h2hWZauqdhBx2pebKejODwovfF
	 4QJht8RYtnTHTWJYTEFWTL5shg8vc6w1ExmZMcnz7FY901H4JtmPhTCxcdt8LgFWd7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imRTkZqA;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5A606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 07:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55E5A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=imRTkZqA
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso11179335e9.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 23:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793864030; x=1794468830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X4sDs8+yOa2alW70ncq0sc4x6VgtfAzgf5Tc7nj2Y4Q=;
        b=imRTkZqAbGgnNmm35d0n7PZ2M5iMBrwdwGZFaCIccoiHc7bc7f28Rwy5v4c3kRPPWm
         Kq4KMBlDurB0saQB2i5ToWZxwkCd/UaJc5tue76PprzHkvfwmtsHChgEJSyIUoVvxwbQ
         z6vfcMu9iijTT2umbT4DTL7ydM0XO85b+u2x1h4WY+bpTsJu2nl0hIj70vctQaRGiW9z
         i58HZ/GW/9xy1QFcLb6LUU2vcK4GhtnS0LK/kPvduAeXvHms1SulkombIZfTbg5kYbEW
         ubbwU3L1wUQRdkQztjSarDsPd2381YacU7SxfP2APdEgsnmm81w0KiiWBRfYiH7smi+U
         Uhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793864030; x=1794468830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X4sDs8+yOa2alW70ncq0sc4x6VgtfAzgf5Tc7nj2Y4Q=;
        b=q3RmebZVYJeZJylcfHYVLN00StQpWqMEA3xNqKjeNbSYSzcFZtWX+jH3P25kI4JULV
         q316NMoFIoK2fGq7v7ScKgyKvsKU9eRPgZG4RrYd507HKXWgzgvn0PrkUwJaYuzonADh
         rPXMbX/hInE4d26jkzDX0tQ6BtffvhtfJEM8IInYD29AfaS8iQoS0KhlC4qji76wcp83
         S1FvqShH2uy2karjp7xq7hrcYNr1i9pAvO4Ee14UxPizc4zhIk8BFtw5xyX37pQB+prN
         hYzQVLOQiqY7Iy8+Jr34tsT9KQHI6HV9TTGwRyizKEfvp6AL5IUCRH0Do5jtNIoGRQ74
         Li3Q==
X-Gm-Message-State: APuU4Z+t7P/CFiUk9HaHWDvWzdYUk7ufFI99fbKPpk+ahmXESyiG+isl
	OkUqrxFY/ECbmfiwUpAw/dUXkEpiRIAjo/i3T8j0q/V0UNo4Q3rFXyWD5ZbJox0v
X-Gm-Gg: AYBFou0asxdU9QsreTwz6I6WV6xP00sq48BhB2yWZLaKSWOYfw4RNMQOGQD3id4m9CE
	Y9tqMXvcIx5MlQ8hqg+/3WCHSQJAdDGkDoXwZqRXfkX+Q7owdj1ooFbk/7C/HwertI2eoU//H7y
	WH52RtNwaETNokTt8I7hDd6RH21qYWXEZl73GehmkUCfs2OpgKXEbql5Kh0K4Q2q4QtVPoiO194
	gerWvPoyL/uUBeYqibbhnGeVP026xS/B9NhQh1Jsk9MzM5AQTSgC8PktI5CexyCaqE/YIplbZls
	7tM8A1ImrWxggyCke3fCqciy/3oLMWp90apBgFQBq7YgtpSIOzW6Smdm8OZ6cE8zEvANmDf0/cc
	3MJuCIME2uc+mGn7hZR0uevsPts40xv22k3ITXhFKPT8v+2I45g5UX72fDnzjjPPqpdu+A+WkR5
	5SfZFl4nc8dyUsjhHyXUGImKK1WB0rPXIRB99mTT68sHI8+m+SBeSl732tCDhw74QQKmty34CeR
	1fe+sDjlEBXKNn3uK/Jr4hitUPgiRmdBSeuoYDhydz5UxrZ4S6dtxtOcxhqvq44a3ws66AsD+aR
	mSYRhtk3zMlQvWPl5poXfea5q1hf7YV2xTZ7BnIZAMPNXe3sqvxPpBRCE06IrrVb6hD5qcya6FW
	DE8pVnBYbYq+71yQS65AL/epOpzPtwklfSszlApIUxDvbuL1T
X-Received: by 2002:a05:600c:6095:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4ac182dc30fmr357317715e9.22.1793864029418;
        Wed, 04 Nov 2026 23:33:49 -0800 (PST)
Received: from HP.zuku.co.ke ([41.212.14.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b452eb99b1sm87652045e9.3.2026.11.04.23.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 23:33:49 -0800 (PST)
From: Tanga Joris <tangajoris@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	usmanakinyemi202@gmail.com,
	Tanga Joris <tangajoris@gmail.com>
Subject: [Outreachy PATCH] annotate: pass the arguments to blame unchanged
Date: Thu,  5 Nov 2026 10:31:01 +0300
Message-ID: <20261105073101.1449292-1-tangajoris@gmail.com>
X-Mailer: git-send-email 2.56.0.386.gfebd08c307.dirty
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

cmd_annotate() puts "-c" in front of the user's arguments before
calling cmd_blame(), so "--git-completion-helper" is no longer the
lone argument that parse-options looks for. It falls through to the
diff option parser, which answers it. So "git annotate --<TAB>"
offers the options of "git diff" instead of annotate's own. There is
no --porcelain, while "git blame --<TAB>" offers it.

The "-c" is not needed: cmd_blame() already checks whether argv[0]
is "annotate" and sets OUTPUT_ANNOTATE_COMPAT itself. It has done
that since 7ceacdffc5 ("blame -c" should be compatible with
"annotate", 2008-09-05). argv[0] is always "annotate" here. git.c is
the only caller of cmd_annotate(), and it strips "git-" (and ".exe"
on Windows) from the command name first.

Call cmd_blame() with the arguments as they are, and remove the
strvec and its copy. 9a48fc1da2 (builtin/annotate: fix leaking args
vector, 2024-09-30) added the copy, because cmd_blame() changes the
array it is given. It is not needed anymore. Since 1dd7c32daa (git:
refactor builtin handling to use a `struct strvec`, 2024-11-20),
handle_builtin() already gives every builtin its own copy of argv.

Apart from the completion helpers, "git annotate" gives the same
output and exit code as before.

Signed-off-by: Tanga Joris <tangajoris@gmail.com>
---
I found this when I tried teaching git.c to set up gently for
--git-completion-helper, like it does for -h and --help-all. With that
change alone, "git annotate --git-completion-helper" segfaults outside
a repository. I plan to send that change after tj/drop-no-parseopt is
in 'next', because it also needs that topic.

To check that the output does not change, I ran "git annotate" with
and without this patch, with 45 sets of arguments, and compared
stdout, stderr and the exit code. The arguments cover -c, -l, -t, -e,
-p, --porcelain, --incremental, -L, -M, -C and others, plus error
cases. Only the two completion helpers differ. t8001 to t8015 pass,
and t8001, t8003 and t8013 also pass with SANITIZE=leak.

The test is in t8003 and not t8001, because t8001 skips everything
without Perl.

annotate is the only builtin I found that changes its arguments before
they are parsed. describe, merge, reflog and cat-file also call other
commands, but they parse their own options first.

 builtin/annotate.c            | 22 +---------------------
 t/t8003-blame-corner-cases.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/builtin/annotate.c b/builtin/annotate.c
index 7f754f2309..c1f258993d 100644
--- a/builtin/annotate.c
+++ b/builtin/annotate.c
@@ -6,31 +6,11 @@
 
 #include "git-compat-util.h"
 #include "builtin.h"
-#include "strvec.h"
 
 int cmd_annotate(int argc,
 		 const char **argv,
 		 const char *prefix,
 		 struct repository *repo)
 {
-	struct strvec args = STRVEC_INIT;
-	const char **args_copy;
-	int ret;
-
-	strvec_pushl(&args, "annotate", "-c", NULL);
-	for (int i = 1; i < argc; i++)
-		strvec_push(&args, argv[i]);
-
-	/*
-	 * `cmd_blame()` ends up modifying the array, which causes memory leaks
-	 * if we didn't copy the array here.
-	 */
-	CALLOC_ARRAY(args_copy, args.nr + 1);
-	COPY_ARRAY(args_copy, args.v, args.nr);
-
-	ret = cmd_blame(args.nr, args_copy, prefix, repo);
-
-	strvec_clear(&args);
-	free(args_copy);
-	return ret;
+	return cmd_blame(argc, argv, prefix, repo);
 }
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index 30e7960ace..6824f33332 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -303,4 +303,14 @@ test_expect_success 'blame does not coalesce non-adjacent result lines' '
 	test_cmp expect actual
 '
 
+for opt in --git-completion-helper --git-completion-helper-all
+do
+	test_expect_success "annotate $opt offers the same options as blame" '
+		git blame $opt >expect &&
+		git annotate $opt >actual &&
+		test_grep -e "--porcelain" actual &&
+		test_cmp expect actual
+	'
+done
+
 test_done

base-commit: 0ffa3e35c7c82ab8d0de226149fb03b3f7674d05
-- 
2.43.0

