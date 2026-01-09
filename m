Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA536A022
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989139; cv=none; b=ulzLJfBeXUitvJbO3nOztJegp80zGK9vzLeq9uc+yPXbdyiCb4AyIDpsEuzFL8vZ/nX6BRnDbReeTbgLV4FZBXU5sXbNlbP5UUeafxRUxegxArLhkvH6kjw5o740Itsqbm60dr6A7yEwzckXBWPveZ/SlMUBGFh5wh1mrahQyMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989139; c=relaxed/simple;
	bh=9b46Mb73Y7Zax/2EZe/Iej8RoGP33qNmU+9tzgvST2Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qjdPQ3juiHTxMbYrM41io6W0J+xqhgPY6f6ha7qjJN4ZagNKYhCCMAcXJrt+YPqClyg1NLahIORoMgrYQ0+c487f735aknYuuO3cE/yUfeECtLxJGzD+p2MJs8kMtIChxrBrb/qU/f/cLZz5vc3Gm24aVQ9eSKu6ysL1u8GKLxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pe4aUIPp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pe4aUIPp"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b23b6d9f11so488967585a.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 12:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767989136; x=1768593936; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV8OzHSFcIceZz+YHEpJtwlUrOcMv4E5jGSHlfDr+Jo=;
        b=Pe4aUIPpnXGg6/o9NuGTt+uHWT6PCh/K2XrkcPYUVcxoRNNzB0n12N1MkhuHZjjG0n
         fMcX+fTUVVPs/umgoFtjzP4kn/3Kx33zvJySGbfwknuxN+iY6ESbJRox14J24M9dzGP+
         aspdXBGt4oroZQZnNH+TJDMt1OCA13Lu8Iwt9QXI12Fpkapz2F51gX2Rfd7ZTiACeJhu
         WsH9Tf6MLCfDImrfeiZOAE71J6Q93tZ3rQaQc38EJCL2pg0hQjgNJA7zpMmmTnaJgAD0
         iPJQnnst+SwLNUFIWxICf/13qZYIdnHLeo6LqAHCpjlVBdhxoqmwz0gIbINcIuNEk4fO
         EoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989136; x=1768593936;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zV8OzHSFcIceZz+YHEpJtwlUrOcMv4E5jGSHlfDr+Jo=;
        b=bbsIRTHLClVm8rbQS1RQCuX5r7YAqxnw53LsfsdnUrY7ON7SCyIrbp9A4wWE2yYi7k
         i89TlrXiWN0TCqKqvm2M74595caLtJD3hsFVagsd9al5JblY1KL+C+YNKKbcIL7v6Lpn
         fLxpgLCGV8MoaqJAFFm0JoQ08Q7/nIppnMsv23ZCYGhmtAnfe8jku3FKkjhxB+BrG8vS
         xbuQWmJGAdnrqGwktG55D477x2men9QHyZxu9RhfdPXSEJrX+9hK0UQcbieXIyfYcYlc
         1VWjvzlghEEWRH22NCrOw63pThFuc/bWJ+9BftrmtkgHkdD4OmqrePLxwiDMUtSbpm3Y
         HeGg==
X-Gm-Message-State: AOJu0YzLXeeemDFVL+3TO46eBFfDD+6t22Bcn7Bq2WilIiUpvtwUoSrL
	tokAwWXrMLmpYNeA9J4azep6EFSaXUfOppF7oPWMM1GmKX5aY67kNwgkNf2EIKV2
X-Gm-Gg: AY/fxX4eHTyZwCFtVuqDAhzFuHksdHZwd3UPrR7YDsYWGzG9CUFJjSUDNkjAZ1kOc83
	9eYIrcD6gkjd0GVOUVcWxTpnv6Dk7dBWw3zSkPTbS01gsOpMgb/d/S0zLHb5mY5N9iswt/KEVKJ
	let9Il4h6etJKCRQbGNNl1q1lJTJo+iReCEwnLraMIChqqfoFyAjkdYkcdET3e+Qa8+I/PuRwZW
	Sh/0YJetVMR9GtpnSL7EE5xoFeLbhSaz3qq9SSi9yQk5jyNtGtVUuH8XUGEXmN/q58gzYPXH+a0
	e1TYYbFQYP8aS1DniXhrHPf4HDWxSpyxUdmkKxPe4meNJVIPOZevE5T2gP6SppmC6iXu1Z7BbZk
	s7RrWpzTTMZIaL63hThVURTahJ5pq3c9JrBXzN6k6Raj3K9sYguQD2+mJyyA49PDGJ9IFUZNAvj
	hbKpBfFlPp2rQQ2GSHM3W6nWk=
X-Google-Smtp-Source: AGHT+IEXjmRJU0Kb52gLPM0fszOyv5aVall1icbfBVTn7p+4rIiizpG5gfBKri/c+75Cp+wnNLrYJg==
X-Received: by 2002:a05:620a:408c:b0:8b2:1568:82db with SMTP id af79cd13be357-8c3893925e9mr1320653985a.29.1767989136387;
        Fri, 09 Jan 2026 12:05:36 -0800 (PST)
Received: from [127.0.0.1] ([20.161.67.219])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51ba4bsm886339785a.34.2026.01.09.12.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 12:05:35 -0800 (PST)
Message-Id: <fb6aa461da7c60db07950d19a453cc75d8ddefcd.1767989115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
	<pull.2018.v2.git.1767989115.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 20:05:13 +0000
Subject: [PATCH v2 16/18] mingw: try to create symlinks without elevated
 permissions
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

As of Windows 10 Build 14972 in Developer Mode, a new flag is supported
by `CreateSymbolicLink()` to create symbolic links even when running
outside of an elevated session (which was previously required).

This new flag is called `SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE`
and has the numeric value 0x02.

Previous Windows 10 versions will not understand that flag and return
an `ERROR_INVALID_PARAMETER`, therefore we have to be careful to try
passing that flag only when the build number indicates that it is
supported.

For more information about the new flag, see this blog post:
https://blogs.windows.com/buildingapps/2016/12/02/symlinks-windows-10/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 59a32e454e..3e2110a87a 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -331,6 +331,8 @@ static const wchar_t *make_relative_to(const wchar_t *path,
 	return out;
 }
 
+static DWORD symlink_file_flags = 0, symlink_directory_flags = 1;
+
 enum phantom_symlink_result {
 	PHANTOM_SYMLINK_RETRY,
 	PHANTOM_SYMLINK_DONE,
@@ -381,7 +383,8 @@ process_phantom_symlink(const wchar_t *wtarget, const wchar_t *wlink)
 		return PHANTOM_SYMLINK_DONE;
 
 	/* otherwise recreate the symlink with directory flag */
-	if (DeleteFileW(wlink) && CreateSymbolicLinkW(wlink, wtarget, 1))
+	if (DeleteFileW(wlink) &&
+	    CreateSymbolicLinkW(wlink, wtarget, symlink_directory_flags))
 		return PHANTOM_SYMLINK_DIRECTORY;
 
 	errno = err_win_to_posix(GetLastError());
@@ -2846,7 +2849,7 @@ int symlink(const char *target, const char *link)
 			wtarget[len] = '\\';
 
 	/* create file symlink */
-	if (!CreateSymbolicLinkW(wlink, wtarget, 0)) {
+	if (!CreateSymbolicLinkW(wlink, wtarget, symlink_file_flags)) {
 		errno = err_win_to_posix(GetLastError());
 		return -1;
 	}
@@ -3523,6 +3526,24 @@ static void maybe_redirect_std_handles(void)
 				  GENERIC_WRITE, FILE_FLAG_NO_BUFFERING);
 }
 
+static void adjust_symlink_flags(void)
+{
+	/*
+	 * Starting with Windows 10 Build 14972, symbolic links can be created
+	 * using CreateSymbolicLink() without elevation by passing the flag
+	 * SYMBOLIC_LINK_FLAG_ALLOW_UNPRIVILEGED_CREATE (0x02) as last
+	 * parameter, provided the Developer Mode has been enabled. Some
+	 * earlier Windows versions complain about this flag with an
+	 * ERROR_INVALID_PARAMETER, hence we have to test the build number
+	 * specifically.
+	 */
+	if (GetVersion() >= 14972 << 16) {
+		symlink_file_flags |= 2;
+		symlink_directory_flags |= 2;
+	}
+
+}
+
 #ifdef _MSC_VER
 #ifdef _DEBUG
 #include <crtdbg.h>
@@ -3558,6 +3579,7 @@ int wmain(int argc, const wchar_t **wargv)
 #endif
 
 	maybe_redirect_std_handles();
+	adjust_symlink_flags();
 
 	/* determine size of argv and environ conversion buffer */
 	maxlen = wcslen(wargv[0]);
-- 
gitgitgadget

