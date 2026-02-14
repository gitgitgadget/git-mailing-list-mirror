Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D2339A8
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771067090; cv=none; b=E/iCqujXI32z8I2TS11RxlGHOsrMBVgCJIvS4JeQMWOeoZFTVuE5iYfmpxTnA62uRHdkt9lscsVzZSKzb/fx0ch14ApOeyA4Pu108v1xLejCmUWs9YC6BlYLwxKUXpfVOycXK2bQeG46fVLH8ziOML7NgGkSlLIY/j833A2AVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771067090; c=relaxed/simple;
	bh=rnrf/NMTySOJkAy/+fMooppesHLbuw3dSFpPRGfI+3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZKNaxYNExDppK+JQiyIzjQ+00yBGzbf0H/TWeHmrSsXFjz82NKjR1aGM7PvSBxFxRkvJ0pNxOjrEs1JQQMKyWiXUbCEC7pLMjP/dqWgYDIYZkQTI/+CMOJe8vi3MmHWwl2YLuWAQrwjQISeF2FgMBqGkN2Gfojd/pFXoledDPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQuBoT4c; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQuBoT4c"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4362c635319so1698439f8f.2
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 03:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771067087; x=1771671887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rOn5xjIfRxZEB5+QFdnVlt1VR3PyabkLi59wJbUENL4=;
        b=KQuBoT4c6IYb7d1z00fyNzBqHM7sf6IrdAZhxPCnfC9L6PmNcEvSju3GcrPWtUCYcW
         U9uOln5/9kvmx1iFXDEZ3m8fF0bd/Cn9yTmfbIdQj59vIWwgFk1RtVZ5j0LLqX5yNC5l
         FbixjBKtfEeRBNGsXhfWe/X9XGhhXIv4KfdMLjcNZNaxELLHe+jdUo0ilUD29Xdwpesl
         Vd2dZf3yMPZDitdE/gshz8ui02t8VvuzcphDI8UC41xcPU5C2vFi7cON8FpcpFKsfNdi
         0zgFzkEtBobCiHETs9MkW5GpVB5VDYAF+NHoWEAz+oSQDpW/0CNPxfTieUU5vNHJ3Gq2
         JXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771067087; x=1771671887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOn5xjIfRxZEB5+QFdnVlt1VR3PyabkLi59wJbUENL4=;
        b=m6/jyS+xL55jT3ve/QT5BBbCKekNUAYKz4yos3ZntL52ixyTAqEK4QXsiUqX/3oVao
         YZaeYlSyCKu5JRwnIsnDwBGLDOHMjgndHSJJEscroi7FC/5cvRv8I/I4fyus/VzG4LuG
         ZPGCZEkG/r2n9HIoZ+CeCyjaLB5x+ZpqgwsjABne61tfGeZxp1JJHXLh9/NduxLeQlfb
         7FUdTgF1NQ1MAPdaCjOlpmn0AlOh2YUd/qNSwtswr8d0ttvKpEzzcu0he2CbxiCXjamB
         kTv67nEJT19qNLkPR5PW/kHc1N31vVHT6vOscn0DeEfOP2Z3YOjmG/DyNt8M6hqc6nuC
         YbtA==
X-Gm-Message-State: AOJu0YyNFdIOcB27Pd0Y4dZKKN8SIOqgMzGOpXOHh8EcJ6vK+So1ncE6
	EMyPKO9HNEZNGlSgh22dJ2zMtJByx4heexiXWQ+EbIdZ4UyLesx1goEjysWv5weQ
X-Gm-Gg: AZuq6aLXBWZfAog82zLGaW4xIO1UfI7jR9QciQMcOZuI7DoB3HbwBfmCGLnB8rIwJGM
	MGOkP/TlQNvAvrDu8KN8B2xThtuVQHCtM81XvGT7QpCdxQjJkGkY2kXsJtACN3SrkmgtcT6DiJ3
	VixPaVhO17JUpOvPYMkzCdpTKaHX1iLfdD8BJlXgDnaaeaBgcBLCgHB0dCiRZFwj9ns2Ewj81kc
	S+3h0f/j5FNAT4u9h/tIPkjdmbneE33lmm7NlzglFYmxLzSWgG5kpgjrMQ9Yw+XmVhWpimWQ1lJ
	vQlsh/UOwH9jHfNb9MA5gCoFvoG3TYz/Y6WPhQTtDkZ5rsp8y+uTZshC8Fvn5lAOY1KbRRPNxn/
	qzGh1NL+yBmyGB74bcZtkXv+CLQayt1ycTQ1RihN+5fzeOpol8h6Ar5hIi+Af5zGKl/VIDzRfsS
	4SzYQxRZuM55QCTOtsrYUvDfpINkD6hCYD0lygBAFtaA==
X-Received: by 2002:a05:6000:208a:b0:433:1d30:44c with SMTP id ffacd0b85a97d-4379792bf14mr8322913f8f.43.1771067086856;
        Sat, 14 Feb 2026 03:04:46 -0800 (PST)
Received: from localhost ([102.88.77.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a6desm11949187f8f.10.2026.02.14.03.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 03:04:46 -0800 (PST)
Date: Sat, 14 Feb 2026 12:04:44 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH v5 2/4] add-patch: modify patch_update_file() signature
Message-ID: <a3affdec45ee6ba9b9b7d133d70599c8f490bb05.1771066252.git.abrahamadekunle50@gmail.com>
References: <cover.1771066252.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771066252.git.abrahamadekunle50@gmail.com>

The function `patch_update_file()` takes the add_p_state struct
pointer and the current `struct file_diff` pointer and returns an
int.

When using the `--no-auto-advance` flag, we want to be able to request
the next or previous file from the caller.

Modify the function signature to instead take the index of the
current `file_diff` and the `add_p_state` struct pointer so that we
can compute the `file_diff` from the index while also having
access to the file index. This will help us request the next or
previous file from the caller.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 add-patch.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index df8f2e6d74..8e21ea1246 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1441,20 +1441,21 @@ static bool get_first_undecided(const struct file_diff *file_diff, size_t *idx)
 	return false;
 }
 
-static int patch_update_file(struct add_p_state *s,
-			     struct file_diff *file_diff)
+static size_t patch_update_file(struct add_p_state *s, size_t idx)
 {
 	size_t hunk_index = 0;
 	ssize_t i, undecided_previous, undecided_next, rendered_hunk_index = -1;
 	struct hunk *hunk;
 	char ch;
 	struct child_process cp = CHILD_PROCESS_INIT;
-	int colored = !!s->colored.len, quit = 0, use_pager = 0;
+	int colored = !!s->colored.len, use_pager = 0;
 	enum prompt_mode_type prompt_mode_type;
+	struct file_diff *file_diff = s->file_diff + idx;
+	size_t patch_update_resp = idx;
 
 	/* Empty added files have no hunks */
 	if (!file_diff->hunk_nr && !file_diff->added)
-		return 0;
+		return patch_update_resp + 1;
 
 	strbuf_reset(&s->buf);
 	render_diff_header(s, file_diff, colored, &s->buf);
@@ -1499,9 +1500,10 @@ static int patch_update_file(struct add_p_state *s,
 
 		/* Everything decided? */
 		if (undecided_previous < 0 && undecided_next < 0 &&
-		    hunk->use != UNDECIDED_HUNK)
-			break;
-
+		    hunk->use != UNDECIDED_HUNK) {
+				patch_update_resp++;
+				break;
+		}
 		strbuf_reset(&s->buf);
 		if (file_diff->hunk_nr) {
 			if (rendered_hunk_index != hunk_index) {
@@ -1577,7 +1579,7 @@ static int patch_update_file(struct add_p_state *s,
 			fputs(s->s.reset_color_interactive, stdout);
 		fflush(stdout);
 		if (read_single_character(s) == EOF) {
-			quit = 1;
+			patch_update_resp = s->file_diff_nr;
 			break;
 		}
 
@@ -1623,7 +1625,7 @@ static int patch_update_file(struct add_p_state *s,
 				hunk->use = SKIP_HUNK;
 			}
 		} else if (ch == 'q') {
-			quit = 1;
+			patch_update_resp = s->file_diff_nr;
 			break;
 		} else if (s->answer.buf[0] == 'K') {
 			if (permitted & ALLOW_GOTO_PREVIOUS_HUNK)
@@ -1810,7 +1812,7 @@ static int patch_update_file(struct add_p_state *s,
 	}
 
 	putchar('\n');
-	return quit;
+	return patch_update_resp;
 }
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
@@ -1859,11 +1861,15 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		return -1;
 	}
 
-	for (i = 0; i < s.file_diff_nr; i++)
-		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr)
+	for (i = 0; i < s.file_diff_nr;) {
+		if (s.file_diff[i].binary && !s.file_diff[i].hunk_nr) {
 			binary_count++;
-		else if (patch_update_file(&s, s.file_diff + i))
+			i++;
+			continue;
+		}
+		 if ((i = patch_update_file(&s, i)) == s.file_diff_nr)
 			break;
+    }
 
 	if (s.file_diff_nr == 0)
 		err(&s, _("No changes."));
-- 
2.39.5 (Apple Git-154)

