Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7EB29BD91
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 22:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771020642; cv=none; b=VjrAn6qXq7nl6/MVuTYCWG8YvK5d/Efq54O5Sc79T462equcp9s+kyXG1bJ6iUK8hPHhHWv9RGVo17Tw4/Fj2P7Uu+zDq6STRQPEUafQ4JDn9aXAoGwbtbnvR47A6MFNzutJ5wbrXhTty6hcUcB9lQ4yX5+QJA17y+jB9huhCUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771020642; c=relaxed/simple;
	bh=ROkWgT/TmuBuR4dAWhQYLaYFsR9DD0JHboHTW1sSm08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHcVS9ZOAc18u+m9vTqXTdv3czq046PYWBDcGM9Oxxb36yVoto6KM3VwLfCuZoLqQlRb+/H7Fxpa8ggYs8ao3QztDP8MjNamCuy3IhoS9BkIuwuq26WxnWW+AyOuYWYprLfgkelLkW6fIdo1Yr5/OgImeQAG7ty5/YMAGWT3lOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhJTLn5k; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhJTLn5k"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48370174e18so9320625e9.2
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771020639; x=1771625439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtOJ78jt22d4EeEUW5CHaKOR43BUybXlUu+fvmTvuug=;
        b=RhJTLn5k0g3Hd1bI6syh44Kz5DxShOfvXG8DmAXQGEEel56no28kSz3cd+GcfYn8RK
         zM8c8lwb0KfiXbkKfc1lPrc85RgN75K7IdCC9oW4TRgvtAsHv+v8aq8iu23phNOoA8c/
         LJ18sMoP+MmV4MbRXCb7bPpjvKWbrz4eX8uLbsGjAoiAk8yWOJrCANmKCy3TwmlgiOEj
         oMWoLpiPxBaUeN3YtWBNnmGcPAkaBd2ocEWqKcYwnq8FvICq7L+1zxF4nKAf45392nlo
         Jp0nLEpjRUHhHUergLLkBdbmH0mFIIFG02DcaBn7Bopt7L+sXk6G1oblhyGXhwGWmmrn
         26eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771020639; x=1771625439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtOJ78jt22d4EeEUW5CHaKOR43BUybXlUu+fvmTvuug=;
        b=E3clJPkTtlaLF2r0hQE+VEKaXgQgEkcAawKAXN4CJDfViO7HYArM1PoUtVX+0vRfX9
         UnVTBbziqgHmWsI1Fq4kDszlpALOxnIOEMcmTVhwFwtH6ZBkYuItMNAVgwp6EmGACUQG
         Y0I4vR0cyOxrcLh0JypIPIg7ENoZ1tca9oNeQ05MvBE2ZI/rfynDI6laxYMoljig/cDC
         JSU0MEQsl5H2rCFFYblyBEkkVOgN9XnL8W0/pZn36l6MfrJl6ZchxVaCHS6rM7W6eK0J
         t4VUZwcK2R0+EyIV5xd1hv4HwOanANYcuMkGFSu/qJBLbMWBmemTINC3KAjHgMjxdFi9
         50Kg==
X-Gm-Message-State: AOJu0YxAqR8mYc7H9jbSO9gjLhsxcD9DduD1KNnBqKDE1NHdIlJYe+Zq
	7Ex3Bvx/7AQPoSDY7joVtUXTCehjhc8fhh6Qzgx5LsdaLdj9AuQLLaIq/cOPBpU5
X-Gm-Gg: AZuq6aIglwnFgqNwEWdt1pifu4P+yMXL822WH/aC1AmMiyqHQLhHGuAfL9XbChddcqU
	p1ddFlgUDYFEXBxMYKb3iF9NP/JpjQ9erilRi9XGuhDOvtjeQNVUn2Y3VAPxrxP2unBZNdHpx2h
	dzXAN7ieodWHHLpQpzLcNNh4cM/BTOTUP5X9sxhABChNQl3tTylo8Z/v5CEMPuz8ouSM+Gk7sCQ
	ECQ5BUfaulPleTbAa7NdyRoz3d7VWNcmnnzopBFWnuCZeJekZY7pxuiKrWAysTiWXGlNUlE7FhL
	LBqdWp8p7+SLLqsnxJgj7Fd4pbZC5ie+eryYoZ0Xtwrx2ePZNcV90qKKjhXlid5KSEYr9h3mXMy
	Geo78PqX8UTQGO61NRzozf6U9qJFd5G+AgJvNxziA//lvhkumQExosB4QRlBSZYJabkJZgvs4N1
	QdjIwpLdErt3FFnG/bzYmaNK03ooh5Cg==
X-Received: by 2002:a05:600c:444f:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-48379bd742amr11771435e9.24.1771020639418;
        Fri, 13 Feb 2026 14:10:39 -0800 (PST)
Received: from localhost ([102.88.77.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d77b3sm316262075e9.2.2026.02.13.14.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 14:10:39 -0800 (PST)
Date: Fri, 13 Feb 2026 23:10:48 +0100
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
Subject: [PATCH v4 2/4] add-patch: modify patch_update_file() signature
Message-ID: <906f25e184d744f9d23681600a0d9e440b7f07df.1771015581.git.abrahamadekunle50@gmail.com>
References: <cover.1771015581.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771015581.git.abrahamadekunle50@gmail.com>

The function `patch_update_file()` takes the `add_p_state` struct
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
 add-patch.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index df8f2e6d74..673ea659ff 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1441,20 +1441,21 @@ static bool get_first_undecided(const struct file_diff *file_diff, size_t *idx)
 	return false;
 }
 
-static int patch_update_file(struct add_p_state *s,
-			     struct file_diff *file_diff)
+static ssize_t patch_update_file(struct add_p_state *s, size_t idx)
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
+	ssize_t patch_update_resp = (ssize_t)idx;
 
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
+			patch_update_resp = -1;
 			break;
 		}
 
@@ -1623,7 +1625,7 @@ static int patch_update_file(struct add_p_state *s,
 				hunk->use = SKIP_HUNK;
 			}
 		} else if (ch == 'q') {
-			quit = 1;
+			patch_update_resp = -1;
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
@@ -1821,6 +1823,7 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
 		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
 	size_t i, binary_count = 0;
+	ssize_t patch_update_resp;
 
 	init_add_i_state(&s.s, r, o);
 
@@ -1859,11 +1862,17 @@ int run_add_p(struct repository *r, enum add_p_mode mode,
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
+		patch_update_resp = patch_update_file(&s, i);
+		if (patch_update_resp < 0)
 			break;
+		i = (size_t)patch_update_resp;
+    }
 
 	if (s.file_diff_nr == 0)
 		err(&s, _("No changes."));
-- 
2.39.5 (Apple Git-154)

