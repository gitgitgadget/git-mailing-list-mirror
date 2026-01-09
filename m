Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA713369211
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989140; cv=none; b=NUYLY0slkRc0S6QOmablmMIRngnEv/qHMTXa3eURNU+o0nma3mEJNlVIVGd8O8EPzGuY7lTMRNcyCW0PRqHOw3xi2Rz8Bpb3IvJ0VQSBMTkwrimsrRZPxdaWx+nkiv9OMKSQHgfYlDASBzmTJYWXHGHxI0pnKCbohoz03cjPe9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989140; c=relaxed/simple;
	bh=xmRj2o1zdJYHskrnh6vYUdHR0BaZEU2uki7Ja0ciyj4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=thiAIJhZm3oea/GBDPQgrGBgzHu1FTa5YTcHIWinmmbjrW44foiu+b8lLFChKyf+y2dxg47ILHUBZqhFVbYWhwq47VkFucObc1V+TEXMcAyDbkwb0Ug2XYPu6yPzi9lqNPC0tasmrQD+gF7Wr1VsbBz+Ts2pzJ+toDd3gOUdg8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/Z3dcrI; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/Z3dcrI"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8bb6a27d3edso463496785a.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989137; x=1768593937; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5Msj5vV3i+oKs/g4MUQND19CRj0aLwYGgkEiNIlm74=;
        b=I/Z3dcrIqZNN9zF7BaUusxccKwRI4y3lTSw4JldBKKPk9XZueudyIvB9KVwXTRtHam
         FSckAU36cMvVujxtL900DSz7qbK7V7LFnGeO/UEq+tYkjkXOUmIpuOnqJuVzTt6cFcs4
         IL+DHqY7ByBha+Yjmag18G+ALRUZ3INPfy85j0oCF5jUre2/TK9X0yH7EV7Lx2jn349I
         2BReXjvI5vh4wTfzyqHp2Ck0Nwjqk/86MuWfN+KWtwgrRbQ4GB/YxzFkoUCMfBICOH8Z
         hyCGgErGzjJ5wHkIZvAd92NoKjMhSmoQRciVwqXQvs588NQdyboZ7QpYKrXJYxzj5A0f
         zpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989137; x=1768593937;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5Msj5vV3i+oKs/g4MUQND19CRj0aLwYGgkEiNIlm74=;
        b=jhX5QZRE0lx39ALWJUHUAFrbyW8nf+fHvm4TWouYxgFhM+iVWucIlqkvylnRKpnytV
         sHzHRPZnDrEVTOICzXAK68Ff5v8aoaJ6AbuYIyu3dJ0yu+VdxPKPFzNb0pORyXi1anVM
         BMr6AguGb9EFV83Z81iA/QGM+PhepEDqfS3coeb93b/DSS5is6//YOZNemyhS4zUGWin
         dmSX+qn57engEBBUzJVk1Fd2Es/NcYXst623welkavyrNUnQt9BDBBgxVvZ1kKZHxko8
         b2zBrodaeS+6NLlC6l9JmwfCR7u0Jf2kDqT2GygC8LO2CCOsMqN6zHKrFGO5NVy8DfMY
         5rgw==
X-Gm-Message-State: AOJu0YxSUPXtXesF//is5C5xE+AOOtguDTQIvUdayzPd6f5zIa9J5yFt
	hXDMNMqyls2d4+W3Z7FfJLc+Ae+RfFeI+dKJSQPDWW2mnrxo7tb+uhwcjnRFYJi4
X-Gm-Gg: AY/fxX5kUqvqrvD0rk67OP/9IDhM8JC8TY0onsSU3Sq/S7Ec94KvIj3FlpdBepf3757
	dSt6ljJbrPpvtaCh/15zn1gEI6OwvAzG8Sroe3DjWEaEGKkMWN3VA2MXL7xYkjVEvGYXOTOBMjI
	XY3K23wFUb0Gv7C41QbcyGbMD+3VuNZnCT2cUG8l4BPiR+ofQfKfk4mrdmzITnxCm39ZK8SlHYX
	HX0xniGVarujI3ImIOST62pG57XdltZzyRLG3J4ggjcqbP1txw50aJsubJO7PQzkmIXXT6HKTP+
	zs+Lh5MXzkQ6y4BzR4VZ55Byzj8cDh7hu3RtbNtEpnbBy1QAUUMdyPAJXcS9TwpE7zXdVZJ/W0x
	S1gEDCI+4dmgcsVrX4mO1Nud92+0hPKxg8VMusFDQnOvd3BKOi04XX6bFicLZfJ11msdSXGnXz7
	wfDy/5Pp7q+Q18
X-Google-Smtp-Source: AGHT+IFO9XTJehhZn9GtRbbjuBH6KMMcfi2bHUgQZaEN4j8Toplc3FXGSVEMYdZToGlHsWmRBqxTGQ==
X-Received: by 2002:a05:620a:440a:b0:8b2:e177:eca7 with SMTP id af79cd13be357-8c38941c5e0mr1464380485a.65.1767989137425;
        Fri, 09 Jan 2026 12:05:37 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b917dsm928816585a.17.2026.01.09.12.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:36 -0800 (PST)
Message-Id: <40c3f7f36e945c49cb8c86a431cdcca2d728ec82.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:14 +0000
Subject: [PATCH v2 17/18] mingw: emulate `stat()` a little more faithfully
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
Cc: Ben Knoble <ben.knoble@gmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Karsten Blees <karsten.blees@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When creating directories via `safe_create_leading_directories()`, we
might encounter an already-existing directory which is not
readable by the current user. To handle that situation, Git's code calls
`stat()` to determine whether we're looking at a directory.

In such a case, `CreateFile()` will fail, though, no matter what, and
consequently `mingw_stat()` will fail, too. But POSIX semantics seem to
still allow `stat()` to go forward.

So let's call `mingw_lstat()` to the rescue if we fail to get a file
handle due to denied permission in `mingw_stat()`, and fill the stat
info that way.

We need to be careful to not allow this to go forward in case that we're
looking at a symbolic link: to resolve the link, we would still have to
create a file handle, and we just found out that we cannot. Therefore,
`stat()` still needs to fail with `EACCES` in that case.

This fixes https://github.com/git-for-windows/git/issues/2531.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 3e2110a87a..628a3941d2 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1273,7 +1273,19 @@ int mingw_stat(const char *file_name, struct stat *buf)
 			FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, NULL,
 			OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
 	if (hnd == INVALID_HANDLE_VALUE) {
-		errno = err_win_to_posix(GetLastError());
+		DWORD err = GetLastError();
+
+		if (err == ERROR_ACCESS_DENIED &&
+		    !mingw_lstat(file_name, buf) &&
+		    !S_ISLNK(buf->st_mode))
+			/*
+			 * POSIX semantics state to still try to fill
+			 * information, even if permission is denied to create
+			 * a file handle.
+			 */
+			return 0;
+
+		errno = err_win_to_posix(err);
 		return -1;
 	}
 	result = get_file_info_by_handle(hnd, buf);
-- 
gitgitgadget

