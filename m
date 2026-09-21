Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B942E423
	for <git@vger.kernel.org>; Mon, 21 Sep 2026 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034484; cv=none; b=AGYbmNOeHe7TebgQOePksEn4WFv5uTVbuDZnQgKQ7AgD/NX0dKqGUA6dLJkt24rDnCQOtwg26SAzkMovxNAwzTiSYE23TxYhppAKzzbtJdJEF9XCcs9TEWNkht1jUmy4VThTdtDXA2hdDv+831XKWodoT24t1ynDNh1ND4mWyw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034484; c=relaxed/simple;
	bh=TvmeZj43Pb9tAYECHG5w5BNa5aWbn4VIboffESsA5sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvJd/y+zn3Yn8A3IpnjIB3TIFHJWDTCuVdGDM1JvRmIfvWsiLQormeYLIpn/GAE7XdYQSp+j0vIQD2PbQjxFqF3yqZjuzVm1RkmUEXkMsb+q6MwmxAQ3GCbrYGRsLSLFub5gCnV8GmOvW+tEoM5VAg0PdHAKgBppHQXt+Ai18jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VLK8CRDO; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLK8CRDO"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb751so3002132a91.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2026 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790034482; x=1790639282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4BhBQKfT9MU+2sDxvoD3dRPd3Vo0ajtdQLZ49+mdMsA=;
        b=VLK8CRDORmfARzbLdTRl9WdQvnK5i5+orotzJ8nbH7ez6HBpgUL4Xt7S/W3KfOflN0
         a0BMuZR+kpRaaogHwemMfbi61DsxCU9fDFAs+kuqVULha1m2Uy3jq0v9r32hzmsWJ05F
         t+hAOJ+XuQbJqMTRonwCV7W+7g1oy/nBKZU8+4vznbn5P8ckAQwvwAWlWfvsiReuK6CT
         nwXafANom2zh0/PuYKM5UszDnzXH0hwwsfoBE/DUQM4/fRmuM4Z0MwNXC3LogPiAGalP
         caA99m6jyDlQkYkh2S2MbF1tX5K55GFByrdeil0QRU3KaBn95vk0Zk87Zo1hXP5rHmaL
         V75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790034482; x=1790639282;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4BhBQKfT9MU+2sDxvoD3dRPd3Vo0ajtdQLZ49+mdMsA=;
        b=MTnBRw6R3kVnogRi58QxLVlgowFWChhmvVm45WbYQPOnjvskRuVb30iY51s4Dco7YR
         51C7RI7ph8KYQsURoXqrNnTEMPzQWglpJzDJneQQHDYaluT2x3U0RyeXGZ7sHLcimbu2
         0ntxkKr/wOX/OBI6EvpegMb+Qw6CnfU3pc44+cqJ5BWQug0E8T8PCkmGaXH5aesVlAV7
         kKZ+0D5nt/lBDUwDDREl7Tst3LzGbyzs8f5AnUv8KW+pTOKMlewX4Xvag8RMr16I3j63
         /oqKtHJg5hptDQ79+3PJvZqBjddP/SZyRAJkx+SrWA4ukn5Na1/eyv4C3cMzwFF5B9cP
         vdHw==
X-Gm-Message-State: AFuF++nQTYKimKunCuW19KVwPfJfB8Y9bexwa/eH0v4u3PYYkbcaTi8t
	Zdmrurxt1L1z7Ws7sUN9K5zzhasmVyAUTPblDdS5muXI3HmNCWlzREG/Kj80vmqN
X-Gm-Gg: AYBFou1k9BBLz0xsXArWyceurjxpyeukosUZ6R+K65dObBuIPXeGZuxmARo8OjrYvc5
	1wz2mDIr5RIEcAsoneOeoBP9dF3n07ZD2eY98G9cMxgHWY8ERKG+iz62KQUdWa2Js71fT3M0IVh
	86wDGpT/DEa7DjFowRoIkwPHQEolu44jMuxdikrUKjKMRsA/SZhZmK/xtkbJweWeedYx9odxzCS
	ufwSlQMiwHSOAfN5kqFRswqbJqDiVyA7pIAAgWzWwM5Kn5pwGJ6Ows8RzVhEpuaA9EJ9IqRaUF5
	p7adzSu7qGscDyXbuLZhuhQScYAlwYSUnUbCf1v0WDzpAP+Yz+VplXaOBYim+69JsSm+zmmKtbB
	HoMooZi+HCmhXJfyKplMgwXYp+b1JHfXlzh1C8X7+bkbDfIY92o7fQmWS9JajvPlcUDVtJ5jNJg
	eMoEj/jOa9TcNX84DlefJCUrsZ+oJ0URRyfYNE+hOC84Vl5MMCUeD4P/ba1msitcPhDw2n1KCCw
	21KVYAgAlvx25ahKXVHMBoW4jCHnPZCApT0O5gEH1b8yRtsmHLQg5KNoLNALQ9qTzM5Q4Nu5pBi
	57TyIvL3fBNhpSWn4FmmST2NT+cBJLq+
X-Received: by 2002:a17:90b:5305:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39e54dcd917mr24517125a91.6.1790034482105;
        Mon, 21 Sep 2026 16:48:02 -0700 (PDT)
Received: from MU00187702X.tailf3e3b4.ts.net (dyn-49-127-54-221.its.monash.edu.au. [49.127.54.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a067021ca6sm1453088a91.2.2026.09.21.16.48.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 16:48:01 -0700 (PDT)
From: Yongqiang Tian <yqtian668@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	j6t@kdbg.org,
	l.s.r@web.de
Subject: [PATCH v3] compat/winansi: fix die_lasterr() argument formatting
Date: Tue, 22 Sep 2026 09:47:56 +1000
Message-ID: <20260921234756.77997-1-yqtian668@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260921062114.14450-1-yqtian668@gmail.com>
References: <20260916042312.35891-1-yqtian668@gmail.com> <20260921062114.14450-1-yqtian668@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During WinANSI initialization, duplicate_handle() reports the handle
when DuplicateHandle() fails. die_lasterr() collects the formatting
arguments in a va_list, but passes that va_list to die_errno() as an
ordinary variadic argument. die_errno() consequently formats part of
the va_list representation instead of the supplied handle, producing
an incorrect fatal message.

The helper also converts GetLastError() to errno, losing the exact
Windows error code.

Remove die_lasterr() and report GetLastError() directly at its four
call sites, following the existing Windows diagnostic style. This
passes the handle to the formatter correctly and preserves the Windows
error code. Keep the existing %li representation of the handle.

Helped-by: Johannes Sixt <j6t@kdbg.org>
Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Yongqiang Tian <yqtian668@gmail.com>
---

Changes since v2:
- Add Helped-by trailers for Johannes Sixt and René Scharfe.
- Move build validation details below the separator.
- No code changes.

Validation (performed for v2; the code is unchanged):
- Built compat/winansi.o with DEVELOPER=1 using MinGW GCC 13.
- Built and linked the complete git.exe.

 compat/winansi.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/compat/winansi.c b/compat/winansi.c
index 3ce1900939..088734a1df 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -436,15 +436,6 @@ static void winansi_exit(void)
 	CloseHandle(hthread);
 }
 
-static void die_lasterr(const char *fmt, ...)
-{
-	va_list params;
-	va_start(params, fmt);
-	errno = err_win_to_posix(GetLastError());
-	die_errno(fmt, params);
-	va_end(params);
-}
-
 #undef dup2
 int winansi_dup2(int oldfd, int newfd)
 {
@@ -462,8 +453,8 @@ static HANDLE duplicate_handle(HANDLE hnd)
 	HANDLE hresult, hproc = GetCurrentProcess();
 	if (!DuplicateHandle(hproc, hnd, hproc, &hresult, 0, TRUE,
 			DUPLICATE_SAME_ACCESS))
-		die_lasterr("DuplicateHandle(%li) failed",
-			(long) (intptr_t) hnd);
+		die("DuplicateHandle(%li) failed: %lu",
+		    (long) (intptr_t) hnd, GetLastError());
 	return hresult;
 }
 
@@ -609,16 +600,16 @@ void winansi_init(void)
 	hwrite = CreateNamedPipeW(name, PIPE_ACCESS_OUTBOUND,
 		PIPE_TYPE_BYTE | PIPE_WAIT, 1, BUFFER_SIZE, 0, 0, NULL);
 	if (hwrite == INVALID_HANDLE_VALUE)
-		die_lasterr("CreateNamedPipe failed");
+		die("CreateNamedPipe failed: %lu", GetLastError());
 
 	hread = CreateFileW(name, GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);
 	if (hread == INVALID_HANDLE_VALUE)
-		die_lasterr("CreateFile for named pipe failed");
+		die("CreateFile for named pipe failed: %lu", GetLastError());
 
 	/* start console spool thread on the pipe's read end */
 	hthread = CreateThread(NULL, 0, console_thread, NULL, 0, NULL);
 	if (!hthread)
-		die_lasterr("CreateThread(console_thread) failed");
+		die("CreateThread(console_thread) failed: %lu", GetLastError());
 
 	/* schedule cleanup routine */
 	if (atexit(winansi_exit))
-- 
2.34.1
