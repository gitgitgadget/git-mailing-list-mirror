Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BEA421EED
	for <git@vger.kernel.org>; Fri, 29 May 2026 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087709; cv=none; b=e3+bVt2R9rR30NZWGw+xMIqmqKH4AWzPxopITCyVw/x8eRNUkAKaQcepzN7CMa1jwnN04s58gb3PKTSWgAQaSzjRH9t+IE0KrxnCP0RaUIj9XQXoANNcf47xwd0xr6se8a+TxmOCoodG9sujku/1rvhCiVR+ek8laAZIk35sqZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087709; c=relaxed/simple;
	bh=NNscbWNZtLHlJjRVHSpcfiG7+H4VtxDvtvGYEd7IW2k=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QbecSFJc/9PhjfMVrs0+J5d9f6J6so3mS4GCfxSkcmZszm/RTjw2m9LqQ133o7Or62JgigMO2oQ2yUNKIU+Imlbh/w0rdeIF3sRQoxGWxSBjCC0Bwfd6Q4IwoVt6Fgpi9uzHajHeOmCO1LM4ejL0cdSUOqsLfCoQpDeYlOdEc4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR5yda7q; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR5yda7q"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304f0039c02so1780551eec.1
        for <git@vger.kernel.org>; Fri, 29 May 2026 13:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780087707; x=1780692507; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLVPFsVXWr/9GqFWiU+t+fHbRdYVPyJ+GLw7y0xybYs=;
        b=cR5yda7qcup2Z2cFcwp+IA3DIYuxTEK1pHgzEX59KbxlUSVL3SrP2iQYeT3s8wWaG7
         pHPny/9q1bN3xAeQgjgrEYUxA49oMMWFbYlPt2iLEIvKtq3XVyeI8/IvUdZeX5znjopm
         s8kNqA4BMuZeFSQ0pxO6IdQhe1KWCvxIN+e4stQB9vR+jaVCTFzwZYO8nt3jXsoyT1IE
         49U/6370Xvpz9eE7jfIwVmcdm/255RTouFhHU0hJKZ0yZSy5rPO5BDsOMSiV/nch4ZD5
         H/B5xlq4jRogI6qDtZMPaf4vGRW39E34VGj2CdZHIXKxCB4MIWMSkjm1JXyraxzyWtTp
         6ogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780087707; x=1780692507;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yLVPFsVXWr/9GqFWiU+t+fHbRdYVPyJ+GLw7y0xybYs=;
        b=FHj/58it7/vNrHBwHLJmerY4s1gYUAu/sHUct4FUXvMD+hwkomthCxa3Lc+4Ki2KDg
         h5RFw3uxZgy6kbUh6A2tE8jndicqrx/Q0ebYrBdzjePZZEOyjF0tGMPk5xoW5skfVYl3
         1GCRBaeSutiPzKsDZNEqyfoHfyezKHteABp3T9UC0fBKEi/0Nx4WdQ6gmW44rkUB0gxW
         HT3GHcIvOX2vk+INtfAnRgxfi9prAOYA5EM/PzXEPO44FqohrARUjRMX5lJyLau4wWLN
         hb6H+SEocfri9LObXHsbZP+zCUldLIUS0ANk44U9iy5l3zrHt4+lO/tg5IWaX9O6e4jb
         TZkQ==
X-Gm-Message-State: AOJu0YwvnTsk0SAoGc4PhWFMQnSApn16gWfo+v8rc5/Xfee/UwlKgKji
	syU1s2aaE6TSGWiWnbJezvGlRFdk+d6VC7O71ncS0rf7dEmDhed1rAYA7QJfgQ==
X-Gm-Gg: Acq92OGjGmqWBLOrAwVHlaFOnNIDlg9qWfTI57YNvjYKID0io8cesfVdvFMeYazRQfV
	m4UHH/98amyyqQxCb0LKF7BUDRf+I8PnoOBGbWbNBkTm+VhzhYnV4Q5iIQ0023zbwZLucshP32J
	6brM/bppJKZp1WjDvJ8W4pB0QtNQc5UforBYzY1/WwfOnXdVoEKbD66pk9ajzLTD0MAxtIJhugZ
	8mnTOLTKjrf940l4lilKkWSDxsKdSjVJ0UOrDkXv8Ku6b0MNC+Qv8yYHUSZWZcp7OWETjxAK1Kq
	0eozpl0Adx7c8fybDshsRIVJDjaHj+NEkZgXdnfsVhbi/47Zw7y5Qdte/JWcA7WWYkoUnNi13Yx
	9kjTkwdaAdr3GdybvsKyMegnHpLxx/YNG9w8qJdYrHsLcUuuDiCH/lzpYvtbcm7dcTcqYLZYGMS
	HLbWjDHwagqFjCFSum+vgcAZK/WzY0V2SYOMltmA==
X-Received: by 2002:a05:7300:ef83:b0:2c5:b972:b436 with SMTP id 5a478bee46e88-304fa647572mr691636eec.23.1780087707406;
        Fri, 29 May 2026 13:48:27 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.227.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed30fff3sm2066334eec.12.2026.05.29.13.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 13:48:26 -0700 (PDT)
Message-Id: <d6c833dd4282f6060a98bcbb3edcb6a5913e988c.1780087700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
References: <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com>
	<pull.2120.v3.git.1780087700.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 May 2026 20:48:16 +0000
Subject: [PATCH v3 3/6] sub-process: separate process lifecycle from hashmap
 management
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

subprocess_start() and subprocess_stop() couple two concerns:
managing a child process (setup, handshake, teardown) and
managing a hashmap that indexes running processes by command
string.  The hashmap suits callers like convert.c where many
files may share one filter process looked up by name, but
callers that manage process lifetime through their own data
structures do not need it.

Extract subprocess_start_command() and subprocess_stop_command()
so callers can reuse the child process setup and handshake
machinery without maintaining a hashmap.  subprocess_start()
and subprocess_stop() become thin wrappers that add hashmap
operations on top.

No functional change for existing callers.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 sub-process.c | 29 ++++++++++++++++++++++++-----
 sub-process.h |  9 ++++++++-
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/sub-process.c b/sub-process.c
index 83bf0a0e82..33b0bbc831 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -49,7 +49,7 @@ int subprocess_read_status(int fd, struct strbuf *status)
 	return (len < 0) ? len : 0;
 }
 
-void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
+void subprocess_stop_command(struct subprocess_entry *entry)
 {
 	if (!entry)
 		return;
@@ -57,7 +57,14 @@ void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
 	entry->process.clean_on_exit = 0;
 	kill(entry->process.pid, SIGTERM);
 	finish_command(&entry->process);
+}
+
+void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry)
+{
+	if (!entry)
+		return;
 
+	subprocess_stop_command(entry);
 	hashmap_remove(hashmap, &entry->ent, NULL);
 }
 
@@ -72,7 +79,7 @@ static void subprocess_exit_handler(struct child_process *process)
 	finish_command(process);
 }
 
-int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
+int subprocess_start_command(struct subprocess_entry *entry, const char *cmd,
 	subprocess_start_fn startfn)
 {
 	int err;
@@ -96,15 +103,27 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 		return err;
 	}
 
-	hashmap_entry_init(&entry->ent, strhash(cmd));
-
 	err = startfn(entry);
 	if (err) {
 		error("initialization for subprocess '%s' failed", cmd);
-		subprocess_stop(hashmap, entry);
+		subprocess_stop_command(entry);
 		return err;
 	}
 
+	return 0;
+}
+
+int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
+	subprocess_start_fn startfn)
+{
+	int err;
+
+	err = subprocess_start_command(entry, cmd, startfn);
+	if (err) {
+		return err;
+	}
+
+	hashmap_entry_init(&entry->ent, strhash(cmd));
 	hashmap_add(hashmap, &entry->ent);
 	return 0;
 }
diff --git a/sub-process.h b/sub-process.h
index bfc3959a1b..45f1b8e5e3 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -52,10 +52,17 @@ int cmd2process_cmp(const void *unused_cmp_data,
  */
 typedef int(*subprocess_start_fn)(struct subprocess_entry *entry);
 
-/* Start a subprocess and add it to the subprocess hashmap. */
+/* Start a subprocess and run the startfn (typically handshake). */
+int subprocess_start_command(struct subprocess_entry *entry, const char *cmd,
+		subprocess_start_fn startfn);
+
+/* Start a subprocess, run startfn, and add it to the subprocess hashmap. */
 int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, const char *cmd,
 		subprocess_start_fn startfn);
 
+/* Kill a subprocess. */
+void subprocess_stop_command(struct subprocess_entry *entry);
+
 /* Kill a subprocess and remove it from the subprocess hashmap. */
 void subprocess_stop(struct hashmap *hashmap, struct subprocess_entry *entry);
 
-- 
gitgitgadget

