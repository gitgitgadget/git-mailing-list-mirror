Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4D1CF7D4
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695906; cv=none; b=Axfnentiy2YzzCJUR3BD0TJIMUB2bOJ8OiC2btGfUWkyQiICPIEclYqXvR7FxGchdS1RqP7yXfFfvYVU6QyNDYeja8xWb7v8qBM3g4OYMoal11rjgJmPtGsPjl8HHaNHrd8RTr/F9PFvMLx/pzgtwY7l/lz7XQdCc+E7oErmrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695906; c=relaxed/simple;
	bh=8kWMbc3/Js47iL3ebJlMFEAyZeQ2r+RNcBKkK+UZA5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV/SqMDEA+ERcMu8YUIdJagj2hChoEYkB+UTlx9eDKNvw2VAVAWg9IRAIqj484e5MR7q4ImczogGjf2OWs6PDpQ6K5T6fgJ8/vW+KySQwMyS2xgGCXIn8t4P3YhPKU/rZwXHVG98HRhnBivEjeETzrMrzy4TbKZo2VTOLDCyIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JgyF7wdM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UdhKKGp2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JgyF7wdM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UdhKKGp2"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6FF161380398;
	Wed, 23 Oct 2024 11:05:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 23 Oct 2024 11:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729695903; x=1729782303; bh=GW+lg3u5QO
	Evf6lHh7mdKsFxbBt553L4tvD0KResDio=; b=JgyF7wdMEeu0aYNSqZYTPlbXdD
	564BUpsW4wyNdzd8YTRzwSms9ooVUhF4LLLjBe/FbCVNqJ1XqXZ5rN7GA+JwumRp
	H1QwbHFIUcSLUpi3SQa1JDC9ku5OPnVgnw1VjOhMP224+gYvX6zbXRwBT92dGH6X
	pQXlWD/virCFDWc1MErDY4kjulrbp1mG8xk5Yezpn+PG3YFfoTlKXTJDSn/ivKC/
	azqzL0XtTboo05MX3UmG7/hKTFYlXw1IaUo4ZxUuHAZsbIG+ankucRZDUdL/Mj5H
	V9H4Qk4DgomIhFjHS93zwdolFuIDkUurSugFo6a6R/J3NHbdTPh9mibtrebg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729695903; x=1729782303; bh=GW+lg3u5QOEvf6lHh7mdKsFxbBt5
	53L4tvD0KResDio=; b=UdhKKGp276I0NWkMSNbnIChdkTe6ospJhXOGR7rItB5D
	yt4M+9e41npQv74yYR3JScQupWZBKtGF2KixCv9+KEtIXeuU7R04SL0k9uWlP1s4
	mkVADhGD2I5Tp4z/p2t9eLGc/EnyxxnFhPNIbgIHzuOj6xfJBhpEZOCd6xxeLrIn
	k5INE0s9C0xZdXI3/STSTy4Audb5bhhxWBLawIh/pIXVVeLNBiL2M9jbK7+TdVkv
	LJb4JPu9Pwey6GT/rpFCAw07ZCdvatcOrUJ2tn2AExKkPyfQYqg+odTu4y5Cb3n2
	cqv4sm9bwJAu64V5sFeZp2CbXaq2OsliaGYDEb7TTg==
X-ME-Sender: <xms:nxAZZ_pAkhI-AorQuzgbfOpuFHJvg_nrrihIvZfd_E1kf8rpgVZUfg>
    <xme:nxAZZ5piFEk6lDJwFGQEN9Y-yr7VIFjC9sk_YWRLq-a3JWR68WB8JZ0x46VFqHhTB
    -2q1m5i80NLTDgtOA>
X-ME-Received: <xmr:nxAZZ8OvnNc-Z6GTNqJqmop2FzHhl4KJ6fB27dovoNgRmtyL3pX6bgmirrZW3WnvaT_h-nIiwKEo1O88S8ZOkuUIDq2n-uQZS_uvRFaBhgag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nxAZZy50R_qC12XufL_Em1v4x4_Nq8N-C3i07WmVEH9SowJuJY_YfQ>
    <xmx:nxAZZ-6Pef3xTvoijchOMfvN4lGdyGhZjm4e6h0ZJkVJO7W4n0k2RA>
    <xmx:nxAZZ6i4YLjBFiFLw1K89JdPqv905Y1LW30ltNqzh_wUt-qvuRRhgA>
    <xmx:nxAZZw4hk8RUntKQAltOm_8xUwTnAb9mKXiknUDWDpLPDOdUjvCwcQ>
    <xmx:nxAZZ-FsQYkWhvV-ED-yNoc7hvArmvDCrtA7fxEZTACH6PLx9fEt_E_7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Oct 2024 11:05:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3ee1ec9c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Oct 2024 15:03:30 +0000 (UTC)
Date: Wed, 23 Oct 2024 17:05:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] compat/mingw: allow deletion of most opened files
Message-ID: <3552feddb332b31744c2ab723b112b9b08926436.1729695349.git.ps@pks.im>
References: <cover.1729695349.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729695349.git.ps@pks.im>

On Windows, we emulate open(3p) via `mingw_open()`. This function
implements handling of some platform- specific quirks that are required
to make it behave as closely as possible like open(3p) would, but for
most cases we just call the Windows-specific `_wopen()` function.

This function has a major downside though: it does not allow us to
specify the sharing mode. While there is `_wsopen()` that allows us to
pass sharing flags, those sharing flags are not the same `FILE_SHARE_*`
flags as `CreateFileW()` accepts. Instead, `_wsopen()` only allows
concurrent read- and write-access, but does not allow for concurrent
deletions. Unfortunately though, we have to allow concurrent deletions
if we want to have POSIX-style atomic renames on top of an existing file
that has open file handles.

Implement a new function that emulates open(3p) for existing files via
`CreateFileW()` such that we can set the required sharing flags.

While we have the same issue when calling open(3p) with `O_CREAT`,
implementing that mode would be more complex due to the required
permission handling. Furthermore, atomic updates via renames typically
write to exclusive lockfile and then perform the rename, and thus we
don't have to handle the case where the locked path has been created
with `O_CREATE`. So while it would be nice to have proper POSIX
semantics in all paths, we instead aim for a minimum viable fix here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/mingw.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index e326c6fcd2d..ce95f3a5968 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -532,6 +532,59 @@ static int mingw_open_append(wchar_t const *wfilename, int oflags, ...)
 	return fd;
 }
 
+/*
+ * Ideally, we'd use `_wopen()` to implement this functionality so that we
+ * don't have to reimplement it, but unfortunately we do not have tight control
+ * over the share mode there. And while `_wsopen()` and friends exist that give
+ * us _some_ control over the share mode, this family of functions doesn't give
+ * us the ability to enable FILE_SHARE_DELETE, either. But this is a strict
+ * requirement for us though so that we can unlink or rename over files that
+ * are held open by another process.
+ *
+ * We are thus forced to implement our own emulation of `open()`. To make our
+ * life simpler we only implement basic support for this, namely opening
+ * existing files for reading and/or writing. This means that newly created
+ * files won't have their sharing mode set up correctly, but for now I couldn't
+ * find any case where this matters. We may have to revisit that in the future
+ * though based on our needs.
+ */
+static int mingw_open_existing(const wchar_t *filename, int oflags, ...)
+{
+	SECURITY_ATTRIBUTES security_attributes = {
+	    .nLength = sizeof(security_attributes),
+	    .bInheritHandle = !(oflags & O_NOINHERIT),
+	};
+	HANDLE handle;
+	int access;
+	int fd;
+
+	/* We only support basic flags. */
+	if (oflags & ~(O_ACCMODE | O_NOINHERIT))
+		return errno = ENOSYS, -1;
+	if (oflags & O_RDWR)
+		access = GENERIC_READ | GENERIC_WRITE;
+	else if (oflags & O_WRONLY)
+		access = GENERIC_WRITE;
+	else
+		access = GENERIC_READ;
+
+	handle = CreateFileW(filename, access,
+			     FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
+			     &security_attributes, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
+	if (handle == INVALID_HANDLE_VALUE) {
+		DWORD err = GetLastError();
+		if (err == ERROR_INVALID_PARAMETER)
+			err = ERROR_PATH_NOT_FOUND;
+		errno = err_win_to_posix(err);
+		return -1;
+	}
+
+	fd = _open_osfhandle((intptr_t)handle, oflags | O_BINARY);
+	if (fd < 0)
+		CloseHandle(handle);
+	return fd;
+}
+
 /*
  * Does the pathname map to the local named pipe filesystem?
  * That is, does it have a "//./pipe/" prefix?
@@ -567,6 +620,8 @@ int mingw_open (const char *filename, int oflags, ...)
 
 	if ((oflags & O_APPEND) && !is_local_named_pipe_path(filename))
 		open_fn = mingw_open_append;
+	else if (!(oflags & ~(O_ACCMODE | O_NOINHERIT)))
+		open_fn = mingw_open_existing;
 	else
 		open_fn = _wopen;
 
-- 
2.47.0.118.gfd3785337b.dirty

