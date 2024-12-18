Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479217C91
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 01:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734484607; cv=none; b=A5doDyEnCqm4Xtlls4FZYv/piL3lV+bx9xVoVwUFvq5Lxn2Zha5S+HeusC0Qlk0OEH94YF0FTIiJe7Rq5QKOdoutMvZxaruQtPfaQI/IeAHisc+/wvmR5HzUWWebtIm2cdEAleafA37/VxYyah+m8ULeH4U+eBrCNX9mtsyfy7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734484607; c=relaxed/simple;
	bh=rGJFyoeD2CO/gABL7bNPC46XZEQRYaxDr+pA+X2NwGY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Lvgn2m+tkTE5dkQJzBnwU3L05EOjO5sbNkV8ja/Xeh7V8DTgaG7EhUgoRD/G26IogJGuBrlljHWxLxmsTwrgGeLKATTICn6fAy9dSlzkxYQ5J6jI+vI5tW18opnl/l1ZNCBZcEp/5VfqNI8dvOZ+i0hs4l6mHcpYSsmG8XqSAnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZprnQ8p; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZprnQ8p"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4362bae4d7dso34193905e9.1
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 17:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734484603; x=1735089403; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTk3FCg3WmbWbBq20vw3YV5oLYk6W8URFLGH/ceFh70=;
        b=JZprnQ8pJmvf2BPBL2B/I8zfyR9ilxqRw+jNo0Tei47kKy8rpwLlULHAtQFtKQ1RHA
         VIQOMHhc4/sq6BtAByH0/rU7APS+RXqaXRrvU3feWV9MNjQ+mSSi0JEWnNrtHIETN0UL
         XAnaHjkkrmZgTePs9IyRyqRXvmLiZLOileFZXPVOeBkPMzd2yoV0rtXPfU0zkyeCiP2p
         RUNX6e75MBvXYSfAYJaVjCR13gkv6y3/VO/YQp3TxMlfZ1Eg7WxkSRHJeztvFfxMFenD
         0S1ZnQm8M9I6ozl9vEqOvHi8RyhdlJ0qnRK4MJSU6X0AFWd6rLHBfhR7OgpKsbW0hR4T
         ppOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734484603; x=1735089403;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTk3FCg3WmbWbBq20vw3YV5oLYk6W8URFLGH/ceFh70=;
        b=O7EepMcmRk9/S4t3BbZgSjuHPrwcKr8TV81PxSglTcgXHv2rPy4Q6TqaGoa+Q/8rY0
         qwbyn0U2z4C0F8roAdEAGiYlSOO2DLG9qBIJlrIPPi6fGGn5L8RKFWpy3pt9+/WMwCMU
         WOn6TYoJwjzEr5Ta4Y3KP1EIAggSkDFIrsSMCZvOKhuumlx5EWynbLMuIhUtXZPCQhgE
         GvrTUi8nQtHlQYp8lCqZGOu8nANEoHyf2y7N/WM3V8KFE+2wjxqMcmcCdAznxZ/V3XlK
         qcAnGa/5t/HuyyXn2rHvUbZ3WiBzLWD/4kWDZFR+XFtNtPjgJ3ah98xGQ9PSLweHVhtR
         dC3g==
X-Gm-Message-State: AOJu0Yy0Z2ds0hHCBpwsnMwuHlLJ7HDU4JJVZ1c6p9SqRn3ONkK2t55y
	u86yANPSiCD9in5ZYB6V/wRNU4l/po6yc2mAEzgEq9rZhp7sHEYBaoDobw==
X-Gm-Gg: ASbGnctCQ+3qZ2LKjs1g+4JmVdiQX6bd+BdquDtYtSnoMRNMKAB/Gn+FfWCCemK2NCL
	OeMBacVBYu/cl5KRwukE8DWV6V3xazdB5zeu9/3AmH0Ei9JWGSebIjij+1za86dQOhzdtThuLRF
	ZIoAGEPgouDOKSOs1e08BTBisxoL+vVRwIeD8rlcwxCUqm/GIgnuCbPPr3J39Q1yOGVdu3eEY3y
	4eWlm500saSM+MXCRMbAtZiCan/GXtzJwT0YDs9m28RRGq6Ka5eU+vopw==
X-Google-Smtp-Source: AGHT+IHaZWseJ82HZWoEtXo2Ml38HfjwDH4mlldbYDh4JHnTAc8EzVSorBWe7/Ob4NFYByubKhrzBA==
X-Received: by 2002:a05:600c:4f0c:b0:42c:de2f:da27 with SMTP id 5b1f17b1804b1-43655343e03mr6122805e9.2.1734484602987;
        Tue, 17 Dec 2024 17:16:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b119b6sm3380265e9.22.2024.12.17.17.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 17:16:42 -0800 (PST)
Message-Id: <pull.1550.v2.git.git.1734484601471.gitgitgadget@gmail.com>
In-Reply-To: <pull.1550.git.git.1689608291732.gitgitgadget@gmail.com>
References: <pull.1550.git.git.1689608291732.gitgitgadget@gmail.com>
From: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 01:16:41 +0000
Subject: [PATCH v2] Prefer fgetc over fgets where possible
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
Cc: AreaZR <gfunni234@gmail.com>,
    Seija Kijin <doremylover123@gmail.com>

From: Seija Kijin <doremylover123@gmail.com>

fputc is meant for single characters,
fputs is for strings. We are better off
inserting sole \n characters as
characters, not whole strings.

Signed-off-by: Seija Kijin doremylover123@gmail.com
---
    Prefer fgetc over fgets where possible
    
    fputc is meant for single characters, fputs is for strings. We are
    better off inserting sole \n characters as characters, not whole
    strings.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1550%2FAreaZR%2Ffgetc-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1550/AreaZR/fgetc-v2
Pull-Request: https://github.com/git/git/pull/1550

Range-diff vs v1:

 1:  f833a7cc857 ! 1:  26f329befbd Prefer fgetc over fgets where possible
     @@ Commit message
      
          Signed-off-by: Seija Kijin doremylover123@gmail.com
      
     + ## bisect.c ##
     +@@ bisect.c: static void show_list(const char *debug, int counted, int nr,
     + 		subject_len = find_commit_subject(buf, &subject_start);
     + 		if (subject_len)
     + 			fprintf(stderr, " %.*s", subject_len, subject_start);
     +-		fprintf(stderr, "\n");
     ++		fputc('\n', stderr);
     + 	}
     + }
     + 
     +
     + ## commit-graph.c ##
     +@@ commit-graph.c: static void graph_report(const char *fmt, ...)
     + 	verify_commit_graph_error = 1;
     + 	va_start(ap, fmt);
     + 	vfprintf(stderr, fmt, ap);
     +-	fprintf(stderr, "\n");
     ++	fputc('\n', stderr);
     + 	va_end(ap);
     + }
     + 
     +
       ## wt-status.c ##
      @@ wt-status.c: static void wt_longstatus_print_tracking(struct wt_status *s)
     - 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%c",
     - 				 comment_line_char);
     + 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%s",
     + 				 comment_line_str);
       	else
      -		fputs("\n", s->fp);
      +		fputc('\n', s->fp);


 bisect.c       | 2 +-
 commit-graph.c | 2 +-
 wt-status.c    | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index d71c4e4b44b..3b1e034013f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -179,7 +179,7 @@ static void show_list(const char *debug, int counted, int nr,
 		subject_len = find_commit_subject(buf, &subject_start);
 		if (subject_len)
 			fprintf(stderr, " %.*s", subject_len, subject_start);
-		fprintf(stderr, "\n");
+		fputc('\n', stderr);
 	}
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index e2e2083951c..b649598916a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2696,7 +2696,7 @@ static void graph_report(const char *fmt, ...)
 	verify_commit_graph_error = 1;
 	va_start(ap, fmt);
 	vfprintf(stderr, fmt, ap);
-	fprintf(stderr, "\n");
+	fputc('\n', stderr);
 	va_end(ap);
 }
 
diff --git a/wt-status.c b/wt-status.c
index 6a8c05d1cff..75b8e900a4c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1227,7 +1227,7 @@ static void wt_longstatus_print_tracking(struct wt_status *s)
 		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "%s",
 				 comment_line_str);
 	else
-		fputs("\n", s->fp);
+		fputc('\n', s->fp);
 	strbuf_release(&sb);
 }
 
@@ -1832,7 +1832,7 @@ static void wt_longstatus_print_state(struct wt_status *s)
 	if (state->merge_in_progress) {
 		if (state->rebase_interactive_in_progress) {
 			show_rebase_information(s, state_color);
-			fputs("\n", s->fp);
+			fputc('\n', s->fp);
 		}
 		show_merge_in_progress(s, state_color);
 	} else if (state->am_in_progress)

base-commit: 063bcebf0c917140ca0e705cbe0fdea127e90086
-- 
gitgitgadget
