Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771F130F53E
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159830; cv=none; b=Qv4NVMMfpM5eRUJQZ36SnlB7Yqpq9XdXYD8pPZ7wsZ+b24BtBJozatuiUqefvfJw8K6TaDzto3IJr1xgSdCe0bLDWBa03y++pjbVLLn4vzqMAAtv9+GRkY4iMpf4QPVMwANiV45k0JWTq88fGn6hdJ65m/oUG6l6lXbnr1QNYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159830; c=relaxed/simple;
	bh=0l0uNfdTXQwAys1TiFYPI0Eom2VDpTAvt/mLI5cH8xA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZdNOIYtB9tncuHDdeQN3bBH8OSnVOCdyQZTj57Fx04IrNMJhax1eJQ/+gA5W2rKhKult2+IFBm6XfB/HpRBd7WX69OR8oA0CZggbHLCDpWqGo7NL+6na0BIe9+Ony8Sj7H3O+u1Jk5jZR0tup8HiOIHy14LfwKkpEZBSv/SMExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDWyt26F; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDWyt26F"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso1782077a12.1
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 14:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763159828; x=1763764628; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsZ1kBIkOFLS8l+hVbvwVQygYtNzw/LcMnvfOYjlZ7Q=;
        b=ZDWyt26F/6pOZytvCxn7O8Pc/2a7gWbt7uQVbgwAUT9fnvm4qnRc2JYjB+rZ74kgcc
         KxWkD0EuPWPnvhLJFn49YwFN6/47rB50Tpq5MA5Pt+ZcH4Rt79MaWmQeGSrGV+C2zFDx
         tPQZpb6dk+Ba5mbV2Nka+r8A3UucWipWAFIPy83zxiEB21l/6h+v+gCzbvun/01HRjT7
         OyI61feFCYZBw36v+eX0xKeN+MVC9rJSzgOyvNu2oRyZm1ZmZWCLbS9Tu0+WiQ5xjTXZ
         EtvCIAIS9EmnBWH1V8h1C9fCyqPH4+Kah9RWq6dBKek58kyGevW1yQfv7ulq8e2RPwdR
         PnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763159828; x=1763764628;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IsZ1kBIkOFLS8l+hVbvwVQygYtNzw/LcMnvfOYjlZ7Q=;
        b=IlTu/OIJ6JokwolxbRgm7SpWoL+CGvfUi+xNDmW58UYV+xyDwDWQnbOc4whtx8u1Gv
         9OQjV3ZBZGXL0WnW2TcHkb+3FRPlYkDS9F5lv94aWsTvFLLowhq3iWGZOnVU6PS1WkNS
         2A0TVnCWSA8G/5lIXpNCg5Hp3vnAETNeKRzkqI2i+rwTL7Xgs8w5u2SYfKiv5sGAQoye
         /tRw0izxMtlyedr1cwqwGfQLoQP0PyAR8rPl7P0sGIY740pARFSpi184QwYYeVPvqN0V
         RupiJF8nmAWBrwLY2RTeZ2UmdSLGV60DZbJyT4+bEuggWgk6boq1wDQiEoaTjtMlPgr3
         L7SA==
X-Gm-Message-State: AOJu0YzVUEwncYaX8uah1NTZ73KjUDNksOLeqrrEMtyl4FooPysgmdC9
	fO1qpenopC+EshYxkNcqK6AjuJDvLNgRcWooR/LyM7Su533jt7si8LmuMcRdgpDp
X-Gm-Gg: ASbGncu2e94G4FCZWyZyPDpZ9sALPYgsz9hPpZKnDXNI/PI8mihF+MNJ1acb8tbtbjg
	ulhoYggszt5v1j0RBWmW+kSlbeZ4uMBANx+79xQtvb1GFFz2NymkAJf0GyQsiyPFrw3JnqfNU2Y
	cSlvqGBjIkqGVGgU81l8YMY+dUTcZAaPAAkfEtFK619Lok4i9j4i/VLhWe3AMvJyv2a98VGILNC
	2oMv3pofKfADU/OSNjZcINrGgz9BUeg4oT4VaE8AAJbXJHXJv/qhzazVt3ClU+xraDkOoxA/hGP
	SusD00xwsNrR0m+wFKzPfM6JeW/6VZM8qSgwGgOTxB51UWDG9S0NhDB+9To3DlOmnSgJIE6Xvpz
	OWSxoZ6mmV00Rco04GVT5bcnHPd4iPWoikqgx82AQhA5gseWFSrW2MM79wFBrSttMktIA6jr97y
	SuD8JVBa4ZpYS7
X-Google-Smtp-Source: AGHT+IE/Iqp9ryXL/kSN9y8dTsmbHjdYrk2SVLe9c3pcMFirR94cf44Lx+5tviBhDZaJefWdCQbp8A==
X-Received: by 2002:a05:7022:1083:b0:119:e56b:c754 with SMTP id a92af1059eb24-11b411edb80mr1286441c88.25.1763159828336;
        Fri, 14 Nov 2025 14:37:08 -0800 (PST)
Received: from [127.0.0.1] ([20.169.73.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b0608861asm9625383c88.9.2025.11.14.14.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:37:07 -0800 (PST)
Message-Id: <93f84ae72e42c7321e8ad028e86b8a2e8c7f8f6d.1763159816.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
References: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Nov 2025 22:36:54 +0000
Subject: [PATCH v4 08/10] xdiff: make xdfile_t.nreff a size_t instead of long
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

size_t is used because nreff describes the number of elements in memory
for rindex.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xprepare.c | 14 +++++++-------
 xdiff/xtypes.h   |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 705ddd1ae0..39fd79d9d4 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -264,7 +264,7 @@ static bool xdl_clean_mmatch(uint8_t const *action, long i, long s, long e) {
  * might be potentially discarded if they appear in a run of discardable.
  */
 static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xdf2) {
-	long i, nm, nreff, mlim;
+	long i, nm, mlim;
 	xrecord_t *recs;
 	xdlclass_t *rcrec;
 	uint8_t *action1 = NULL, *action2 = NULL;
@@ -307,29 +307,29 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
 	 * Use temporary arrays to decide if changed[i] should remain
 	 * false, or become true.
 	 */
-	for (nreff = 0, i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
+	xdf1->nreff = 0;
+	for (i = xdf1->dstart, recs = &xdf1->recs[xdf1->dstart];
 	     i <= xdf1->dend; i++, recs++) {
 		if (action1[i] == KEEP ||
 		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
-			xdf1->rindex[nreff++] = i;
+			xdf1->rindex[xdf1->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf1->changed[i] = true;
 			/* i.e. discard */
 	}
-	xdf1->nreff = nreff;
 
-	for (nreff = 0, i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
+	xdf2->nreff = 0;
+	for (i = xdf2->dstart, recs = &xdf2->recs[xdf2->dstart];
 	     i <= xdf2->dend; i++, recs++) {
 		if (action2[i] == KEEP ||
 		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
-			xdf2->rindex[nreff++] = i;
+			xdf2->rindex[xdf2->nreff++] = i;
 			/* changed[i] remains false, i.e. keep */
 		} else
 			xdf2->changed[i] = true;
 			/* i.e. discard */
 	}
-	xdf2->nreff = nreff;
 
 cleanup:
 	xdl_free(action1);
diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 4c4d9bd147..1f495f987f 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -51,7 +51,7 @@ typedef struct s_xdfile {
 	ptrdiff_t dstart, dend;
 	bool *changed;
 	long *rindex;
-	long nreff;
+	size_t nreff;
 } xdfile_t;
 
 typedef struct s_xdfenv {
-- 
gitgitgadget

