Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781B1DB55D
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743181410; cv=none; b=cLrw6CKS3YEl+VRlynaCxN4s9ObztbDrLjZKeL/8IUJ0K6d71uTVnvzs0X1HIY9XD+0EK7tEAcXixG9oX5P9Nm9tSjxofYCeX4lbZyeo34RnqdJc/yPxsjvErQNBepkQ2hH6qU103/Woq8Clwxwj8IvtaC+mGJcg4CQAQykj04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743181410; c=relaxed/simple;
	bh=iYtNqlSwK9xdOd7w7JXdt9lzWtMhCh3w82NHPqCmNy8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fwyvW3VfNmxBZLItyH7Noh5u9Oq320bcaByKC3KTyEu+3K/EFRiRZMsqwQ3g54yEi0I6lultgt9vLNacNHh9NycEMMkC+fNibdVv0Js4gNmp2zqXqKOVhUsboxkCVpXYI3d+gKGNuW95ZEJYbHY6YW3hGdWdrAFojWQywTcBc+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWzr6j2p; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWzr6j2p"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso22960565e9.3
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743181406; x=1743786206; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ri9PCJXsCOzURLlVbX1fPSc/GQL94KYQsCCsTgfwmnE=;
        b=YWzr6j2pHxpyPu3UW2ujnTr1MhPWaYRlWSCO0BZ2PKEK2j/zvIsHo/qNjUrW+1/BBl
         RVJ87HRp1SQ/IcXGgjEXLfeRezdiR6E+B/AFQY7yjKe8xrUnBnz8xw6WSAJBea6Y7WYK
         TjRXKLQXYbZ48dV6WgtEjyQOP+h2T1wiL5mX+LolU6ifryIO7kz9qeDJg53Hnji/lndm
         M5wm/KC0t3piOckB/amnujuA4utXHB31W5Gy9A6H7bdIACL4ci5ovV9X4US7q4dlzuk8
         7HZFOPEKmaJp6QuIbR6Tw3LAvXDu+4iKagcnNNopmbQ4iuBn2neTgFX3gCevH9X58+zI
         0OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743181406; x=1743786206;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ri9PCJXsCOzURLlVbX1fPSc/GQL94KYQsCCsTgfwmnE=;
        b=pCe/jXZVk9D/hI+kJMOYMyrUJKtp6hY9X5UigvOb9/Q6YMSscdmRM3/kNK1QAcxw7q
         GEMeA6W7zis7f7cl7t0BIvLEh2v6iIGXQzqf4r1XhPJWzSI7W/C5coFufe0JN1bm8vqE
         ziJ9HdTe/GUVsvfL6HyE94wiUJ8eqnuo6dKx/Es85Ahg4rUvhgV200JyF9hMZFz2pAuk
         t3Z1tJNu7CiRvXWIQWTk1YeQM0VD5MmPQqP02WR5FXTZbpX1znSXVnE8NKZ1MpL7Gn6v
         gyIQ4dV1JIJx35b7VW1XUwH7ZONwBfo9fyfMp+G1BU2BoSAXtzTi1vDCadcxM0qNjQt5
         vshg==
X-Gm-Message-State: AOJu0YyYNYHt5BxFZRSSZJU4TaZZDKhknbV/v2n+AQ/J8f/EzRfGKxzl
	1RQ3bl5bM/3huelbNwe+QRFOHZ0SyqZUaje0PIJWfao/eDjLS81rqSexkw==
X-Gm-Gg: ASbGncsbBwMsHsDyZ167gaetH0I4NK0XTB8iKJyx70YQa/YlNrzSSMtbRtv6G2CVgMI
	pOPVpgBS9Ibi1OOGOq9PAwd/5+dFbrFmdm8TvCqM4zZQ8Wd5r3xbzdkoNXq7hnJNz0dNt5hIDGF
	uC01yR6ksp4meN++cZCnW68gmJtYAJBwP4sgOYgFF/cYfg5sBYayYrZB+WOCP4ScGxrAObIvFuX
	ss6eLBqORqjjTdHDCbka5q6ge7PmCiG1chaCbOwjSZzr66kJpPEAtdHhTS2Kf6K+uhfk4cgb9yj
	suts1DCEXJGHBaTOn8eI0ubDlLh3Lp0HzaOqCxrO4KzxFA==
X-Google-Smtp-Source: AGHT+IHC147nW3SIkjUzWpHigSD/9nAUb4ZZcHWpbqGnAMGQwDfllRJiTmtBEA8UOEJ+X/lLnJgDeQ==
X-Received: by 2002:a05:600c:4f82:b0:43c:f689:88ce with SMTP id 5b1f17b1804b1-43db62b75c6mr1983895e9.20.1743181405609;
        Fri, 28 Mar 2025 10:03:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a422dsm3172883f8f.93.2025.03.28.10.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 10:03:24 -0700 (PDT)
Message-Id: <e297b71ba123b642c2e724d7dda475fa52dfdeaa.1743181401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Mar 2025 17:03:20 +0000
Subject: [PATCH 2/3] wt-status: also abbreviate 'merge' and 'fixup -C' lines
 during rebase
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

When "git status" is invoked during a rebase, we print the last commands
done and the next commands to do, and abbreviate commit hashes found in
those lines. However, we only abbreviate hashes in 'pick', 'squash' and
plain 'fixup' lines, not those in 'merge -C' and 'fixup -C' lines, as
the parsing done in wt-status.c::abbrev_oid_in_line is not prepared for
such lines.

Improve the parsing done by this function by special casing 'fixup' and
'merge' such that the hash to abbreviate is the string found in the
third field of 'split', instead of the second one for other commands.
Introduce a 'hash' strbuf pointer to point to the correct field in all
cases.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 wt-status.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 1da5732f57b..d11d9f9f142 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1342,9 +1342,11 @@ static int split_commit_in_progress(struct wt_status *s)
 
 /*
  * Turn
- * "pick d6a2f0303e897ec257dd0e0a39a5ccb709bc2047 some message"
+ * "pick d6a2f0303e897ec257dd0e0a39a5ccb709bc2047 some message" and
+ * "merge -C d6a2f0303e897ec257dd0e0a39a5ccb709bc2047 some-branch"
  * into
- * "pick d6a2f03 some message"
+ * "pick d6a2f03 some message" and
+ * "merge -C d6a2f03 some-branch"
  *
  * The function assumes that the line does not contain useless spaces
  * before or after the command.
@@ -1360,20 +1362,31 @@ static void abbrev_oid_in_line(struct strbuf *line)
 	    starts_with(line->buf, "l "))
 		return;
 
-	split = strbuf_split_max(line, ' ', 3);
+	split = strbuf_split_max(line, ' ', 4);
 	if (split[0] && split[1]) {
 		struct object_id oid;
-
+		struct strbuf *hash;
+
+		if ((!strcmp(split[0]->buf, "merge ") ||
+		     !strcmp(split[0]->buf, "m "    ) ||
+		     !strcmp(split[0]->buf, "fixup ") ||
+		     !strcmp(split[0]->buf, "f "    )) &&
+		    (!strcmp(split[1]->buf, "-C ") ||
+		     !strcmp(split[1]->buf, "-c "))) {
+			hash = split[2];
+		} else {
+			hash = split[1];
+		}
 		/*
 		 * strbuf_split_max left a space. Trim it and re-add
 		 * it after abbreviation.
 		 */
-		strbuf_trim(split[1]);
-		if (!repo_get_oid(the_repository, split[1]->buf, &oid)) {
-			strbuf_reset(split[1]);
-			strbuf_add_unique_abbrev(split[1], &oid,
+		strbuf_trim(hash);
+		if (!repo_get_oid(the_repository, hash->buf, &oid)) {
+			strbuf_reset(hash);
+			strbuf_add_unique_abbrev(hash, &oid,
 						 DEFAULT_ABBREV);
-			strbuf_addch(split[1], ' ');
+			strbuf_addch(hash, ' ');
 			strbuf_reset(line);
 			for (i = 0; split[i]; i++)
 				strbuf_addbuf(line, split[i]);
-- 
gitgitgadget

