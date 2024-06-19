Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751DE53E24
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766029; cv=none; b=lSmukI6ic72j/AcJ1bk4rTuBqHlT6LzGSBmHlkc9x0JIbASfJ61YGDpk0Wx6Q/Ru483OJF49JZbquB0iGHYvE7XDIuEEQWFbmSF/F164MXFySEUxW6l0XOrwUXwRc39F64UBbOR7FnyzNjDsJnhScw9wMzDtImHgYPMlE53BZRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766029; c=relaxed/simple;
	bh=hGflWmrr4wNRFZWU59RTxX5tUfS6QxhpFY90w5BxwzA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cIeWojxsZz8SYDo94WAKjjWpSBBlM4rrfgQY9k78NELqdVQoCAL0q6A72Xn+lHpke/VGMJDY9Vbia0YuiYORUBi2dmTdB7JCq4TfzJT3k7640cKOK925+vf8TOH9ASQSTJfUlFAuRSzyjDzymRlg2r74EyjPT+I3prEB3mBPfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMcTCW16; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMcTCW16"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-35f23f3da44so5524820f8f.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 20:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766025; x=1719370825; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B1kBECs0y3/R6p9HHdBMpnqoLUd5fr92TsN7p8Py3A=;
        b=hMcTCW16NRahU6eGlVpNF0ZD0tfRNgyrvTBej/40I/r3vhs+NGIfjkz3RqEI9/JMrX
         GbKCiesjJOMSVb4zvvbCiDNqEiZ81CmqtNQ8iBnkq7Q1ah0rlitYZUgwSebDMjNk6Hef
         y/+A1MaturTg79/etQRk56zBoprTNRxKTOzzsHjibvS7QPLqhAFutIo+s1L6BpCX+ab6
         p1kFlYG3lhzfDa1lM+zGysMU2UPfcewv4Y9BWSYey2KT1Fiu3VkTGCHTzqcJXMfwSDip
         sdd5i1W7jcFbIdYTL8tSqZKy3PEaTqYYsDr9tYo3cp7jfe2xvuXROkJnUWsjJ0/FmOJO
         VnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766025; x=1719370825;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2B1kBECs0y3/R6p9HHdBMpnqoLUd5fr92TsN7p8Py3A=;
        b=F+kMr9lv4RuJCR/b18O8bgr59B8Cu5Wq15Ne4TwbfHPUGWdC9SeuARpiMVzFFa9CKt
         rZ7k6lDyOLQ5t22HDI4xjmLuSqMj5xmdT5p/Iq8IBDABkK00+uonQHK3WOjmHjablBoF
         uYdZOJ1oQWPws+yU8dcBYZs0TfOaLOa6bARQlRtMXAWIAShM6B164+PuRbbnkR7T/Ppe
         ROndQryf8aJ5cRRk/OfWfpcrJKoJk3zAeaamNykib3SEb50pLwPfxoebwtHyJCjgZseC
         hh7IBOd1FmTcDf+kCue68jeg1m2Aq9D8wkZhIvuSc948bAMonMXf8b9ou6+cHxjWgfAn
         qxCg==
X-Gm-Message-State: AOJu0YynfDEvocLhxR3Y7+Rvw9Dh31R5Iw2skTZhrmSyf8apmteKkzoN
	2T+pOI974SyQOe8Wn/pg3ZYKlGV+m0V3iV22RXj1wAz+eFTjmvBR7WMzTA==
X-Google-Smtp-Source: AGHT+IGeMiEqt1s/V9iAIo8LjE2U2lQpjO6PsenCoy3V4YGEiu82kwjKm+gz34hrely+rhLsvfKLRA==
X-Received: by 2002:a05:6000:235:b0:362:40cd:1bc with SMTP id ffacd0b85a97d-363178982camr859689f8f.24.1718766025134;
        Tue, 18 Jun 2024 20:00:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075104b2esm15700914f8f.101.2024.06.18.20.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:00:24 -0700 (PDT)
Message-Id: <034b91db1d2ed78995b52c014de313744972ff40.1718766019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
	<pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 19 Jun 2024 03:00:15 +0000
Subject: [PATCH v2 3/7] merge-ort: fix type of local 'clean' var in
 handle_content_merge()
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

handle_content_merge() returns an int.  Every caller of
handle_content_merge() expects an int.  However, we declare a local
variable 'clean' that we use for the return value to be unsigned.  To
make matters worse, we also assign 'clean' the return value of
merge_submodule() in one codepath, which is defined to return an int.
It seems that the only reason to have 'clean' be unsigned was to allow a
cutesy bit manipulation operation to be well-defined.  Fix the type of
the 'clean' local in handle_content_merge().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index dc62aaf6d11..be0f5bc3838 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2109,7 +2109,7 @@ static int handle_content_merge(struct merge_options *opt,
 	 * merges, which happens for example with rename/rename(2to1) and
 	 * rename/add conflicts.
 	 */
-	unsigned clean = 1;
+	int clean = 1;
 
 	/*
 	 * handle_content_merge() needs both files to be of the same type, i.e.
@@ -2184,7 +2184,8 @@ static int handle_content_merge(struct merge_options *opt,
 		free(result_buf.ptr);
 		if (ret)
 			return -1;
-		clean &= (merge_status == 0);
+		if (merge_status > 0)
+			clean = 0;
 		path_msg(opt, INFO_AUTO_MERGING, 1, path, NULL, NULL, NULL,
 			 _("Auto-merging %s"), path);
 	} else if (S_ISGITLINK(a->mode)) {
-- 
gitgitgadget

