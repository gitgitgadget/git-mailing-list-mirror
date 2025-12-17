Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E6397D32
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980552; cv=none; b=fCU4EdilqKHzoIxmkH1JPHOtgm99rxCI8gwLJtjxov/uMH0Wm5bulAGPDtcHk7kkRGl0jKih4srsQzMxJ/7ggk9A62wEvtLbyHlC+XCpWR6OmXjWrXcuxY9S2x+kh2Bw/6AIxgKWWopA5tLrW1odHNsnDtxj1sVnfdr+HDacxAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980552; c=relaxed/simple;
	bh=zd1Z+1UAXorBfHKXCkOG+qF62mOQHqKxlwGHiyjqSzI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uXL97BscgNuCEr/5RdbWYb2m1HG2SKJS/8VBkA+I1wCOadmhpJ9brkHK5kbabAuQ/duHBLeuE6MF27rU2dutl/GJQwBnGzSYeO8ax3MWfdRD+CPyoSjBhG79Lo5cLWDr2sc2N5/i/osM+5qREx+dKw4Mse6+IPVBlQe9Xt46wfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aEjaeUyp; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEjaeUyp"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b1e54aefc5so513892185a.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765980547; x=1766585347; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXrdBJcx9SPN5UpIGqhbNa2l3FDpMziKoxgdqPIeMt0=;
        b=aEjaeUypB6DZmiQCIAfB3PAukMllsrt+jJ2F7GLdEnlx0Gh3qgMSoNwW8Wjd5wktXX
         md3lQ8CT3DicYYFyBn0OaSAx/iAe4A0gxJ+0nQ86vMSXivdThqLmGgStZfZqKawG2sCq
         C/NG/n0eBDrXOoLNlTbIec/xJY1+rqDuQNlwoTdpA03PH02ppqhH47s/djsq2K4Ffgr3
         iH2I9mL9NIqE/Qg/DEaoPRkxYLJAqibNrEJe4dWUhvqtT9y5S39onuuomw6TYHyrrVHI
         FOuwzAWiSg+QEgsjJGIRspMRE3Jg161YePV3daak3ez2SqUlMpxhoZ3DeKppNr8yuWhg
         PJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765980547; x=1766585347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hXrdBJcx9SPN5UpIGqhbNa2l3FDpMziKoxgdqPIeMt0=;
        b=foxI5GrT2hyuHUXc6LkMpvBXC/aUZq8yYzVOP1MjvA2RhMIOyDL6nXVbc0b5dX2XQc
         v16WEvs2wvWXfkl2gCVvlnFKfuE3bMCr5zRwZJztpx/DWxgKw8ks/X83sR0rx63dBhhI
         ayHKICAtB+nE2i1xy2UNzUunDjNf+eu1VZu+Ib0Oe14PgJXjwHO/dGy7ppeWZlKAihTP
         QEsIUqOmFM9BPWs7qjynjcn0kl1bEaSyL8ESTkCaazUp4BUdoVNbLvU7qxHI3d0e9aFk
         5EdkFsuCJ9KrsslZ8p9FNpMzX9+Vk6vAja96Hxp1t0RkmyGTj3V8ajUA6/OCjh38tPzi
         Xm6Q==
X-Gm-Message-State: AOJu0Yz3xg8rFTv7QST329RNf7/29UBTa8wYgwixjIBg1ouD6RHb874+
	jsDKrO7AgaSmNXvW0+6Y4NbyNepxCOyCj7ooBrzTPXSOV4Jr1P2BaRiDhkeTy9Be
X-Gm-Gg: AY/fxX7jisVOGiNUWH4fltLwLR/wrwa20EOwZdaHzUvpasb1HJlBigjrbgIVhaFnP44
	cHhj5sku4xW0awyJa1eu/STtC8seQAI5wJ/WlWFDd8nXLSAZuz30L07mbiN9sJQRnFfSFAmg+kF
	VDvzRICMDllXlg0HjInk0D7uw3iCIICYd/GHvjDHZvEqdPnQhZQL/5gyawYv4WMT9YsS0/4oeh2
	DokIoUqk2RRKyCGS5hwKc2TYYSYnsY2bHYyPCwo8STJY8N2Jo5/1TQX45yGhuFmxK25ilPyLRTw
	PKPs3EUVimr2SFf/7Wdf3tQrQvzjK0Vrokvl1hlk9h/8Zzt6HyZlKD2iDrPNQhsOJt4nmX54Ef9
	GIsH13cwa+KWxBYVKIL2joYj3OsI2aPnIvU02+JVKxNnlJioHCDf4YxYKVn8/Zu85YKcpjQU7oq
	2kBosuHTJOv5w=
X-Google-Smtp-Source: AGHT+IHdI8F4TvM1wHY5dFcmsAFU3IL4Jip1EW07iGkDJmKvBnOo8379s9ekup8EY2D2XwL+KzMjow==
X-Received: by 2002:a05:620a:6919:b0:8b2:5cdd:6a16 with SMTP id af79cd13be357-8bb3b3708d5mr2439341985a.82.1765980546685;
        Wed, 17 Dec 2025 06:09:06 -0800 (PST)
Received: from [127.0.0.1] ([48.214.53.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be31c76507sm407015885a.48.2025.12.17.06.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:09:05 -0800 (PST)
Message-Id: <25313cea76e059d01a0607d0d5291b62011f4526.1765980535.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
References: <pull.2018.git.1765980535.gitgitgadget@gmail.com>
From: "Karsten Blees via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:08:45 +0000
Subject: [PATCH 08/18] mingw: change default of `core.symlinks` to false
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Karsten Blees <blees@dcon.de>

From: Karsten Blees <blees@dcon.de>

Symlinks on Windows don't work the same way as on Unix systems. For
example, there are different types of symlinks for directories and
files, and unless using a recent-ish Windows version in Developer Mode,
creating symlinks requires administrative privileges.

By default, disable symlink support on Windows. That is, users
explicitly have to enable it with `git config [--system|--global]
core.symlinks true`; For convenience, `git init` (and `git clone`)
will perform a test whether the current setup allows creating symlinks
and will configure that setting in the repository config.

The test suite ignores system / global config files. Allow
testing *with* symlink support by checking if native symlinks are
enabled in MSYS2 (via setting the special environment variable
`MSYS=winsymlinks:nativestrict` to ask the MSYS2 runtime to enable
creating symlinks).

Note: This assumes that Git's test suite is run in MSYS2's Bash, which
is true for the time being (an experiment to switch to BusyBox-w32
failed due to the experimental nature of BusyBox-w32).

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 26e64c6a5a..0fe00a5b70 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2862,6 +2862,15 @@ static void setup_windows_environment(void)
 		if (!tmp && (tmp = getenv("USERPROFILE")))
 			setenv("HOME", tmp, 1);
 	}
+
+	/*
+	 * Change 'core.symlinks' default to false, unless native symlinks are
+	 * enabled in MSys2 (via 'MSYS=winsymlinks:nativestrict'). Thus we can
+	 * run the test suite (which doesn't obey config files) with or without
+	 * symlink support.
+	 */
+	if (!(tmp = getenv("MSYS")) || !strstr(tmp, "winsymlinks:nativestrict"))
+		has_symlinks = 0;
 }
 
 static void get_current_user_sid(PSID *sid, HANDLE *linked_token)
-- 
gitgitgadget

