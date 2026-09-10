Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31B63A785C
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789020347; cv=none; b=BPkRP64cYHYNe+KqHp/70qDUK4WpKmbbPkywhHkgHXsN/d0TnhpLjdkftEqbnI1TfaViJTeqkjwVYXRben4+wzDf/BdyAP+CN7nQafkMnjA+Zp+W4XXqZ9gJh60kK/ySBnKsXmYEr71q50eHRihDWqtMtkR8nwjqm9lLRxJZNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789020347; c=relaxed/simple;
	bh=o9nWf2lo8c03OAAsoK/WMDIy+n5cg5pjk7eCiGCHQO4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lq+Skehl2L9Hgi1quCbiRpTYp3yRiu9tOTFUSKQn9HkWJdTMt++2fL+ffe7M8RmUs6xLz/mAT7Ciy4WyOSxW/akcmmMin0rUI+zbIEfBuSrpotQs7lwYw+w88ZM4Hok2V9fe4y2s4qWIfYar1Om+gfVNPbcwi+wACOCoc6blDsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ6wAtHW; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ6wAtHW"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747eb79fbso7545325ad.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 23:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789020345; x=1789625145; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=44Ska1f9X14kdSG1R7e8e884jBbaleQFRFWdAsaN+FE=;
        b=TZ6wAtHWsdeaF36h1FvQzI7F7xFpIX162/zsQk923Q9Ylj7PSupbEfSLK0maIoH2CF
         fNFM52B7ECSghdVgQSBULI2MZGUsEqDW4c23pM+qr1PO5NNp39iuoEknWQYYsMfqzuU0
         5IvfXe2NugGiEmU+wg1/vWGkEqfOX1ia8zKR25cg15ad9AI1SyBVaQ1YtABoPkk2qeMS
         0zAn8jMY2lJXhgEBTNUYiOq2okjNaufMTUp3NDFRaNFVX1ukiZ2KrgepCQXQEInl0npG
         xCc/2P3rRB0Kn/2qf/Iwxs8ZDCJ1KPx6tuATClD/PugiopQKEDxh8/vs7q8j/i0q1QVC
         ZyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789020345; x=1789625145;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=44Ska1f9X14kdSG1R7e8e884jBbaleQFRFWdAsaN+FE=;
        b=JIHe+g3CDtL5hMGpJ6OVSgdA5HKBSptTGh2tzXxZ9mW/u/6AX3gTp/iW/SJvmIP8CF
         JroiLrL61Z1HPljqn30FqTTRDgaB7rVEfjdAZ+awYz9ar5TEhy2OICb1/gv+HBuQXfyQ
         d6Yc5n8jTda9IR0EXmkwLZLyNjh0saJwKQfcK+D87pOe9MbdpTXrcjsVSTDHkD9owNe/
         6kAiwcbJgVq7vyeNs2xAM/1BdLY1MnJ+UG3ZKR8wO3uJnckrZH8tKSn/LvVj1aEmm4Fl
         uhimJetu7WYRYeF9NRo6voF9pb01DE1/EB5yF1ZCshPXS7T4p9/8y69moeDXn2mUEqch
         9Uug==
X-Gm-Message-State: AFuF++kaamqRF40q13DAXCpHrn7YI1L+F933C1wTzy/iNrCXAFlmLXoI
	Z5fLO9exTFS1nGJdppVjzJOFz5h+kDapIyf0eH8es8+3DLENY0HC+SsiAVSdzA==
X-Gm-Gg: AYBFou0WSpzsPYaRlNR+5B8x+1bz8jlonj2B+a85T+gLxjcafQ/I1bbuG3LdHLOgGZ6
	m88YetIhwcPL3uyLJZXEvt0hRm8bmScSkT95rKbyE1ej/NDCEL300FTp/O02FVDRVkrScxcS9a/
	MSjIQc5Vfj65dNyJf4iD2n9BtACrbjiJ8MaJ2oXrKIJMxTyWP3RUh/8vhOAHjvHRucB+SHPvT9B
	dgBpdENT+UjoArZc6OSrr86SwZJ4/HBq+UVBN1cGpTrrS/7CdKg6E7SdA4kOQ4oCVsF0fBzXBaB
	ftVwgHb/u+Gp3+2ylIYDUJHDlVyM4FEFSH51LyKYzdMn7xqSYkfGf9vz+sIx825STZv7bE/cIBt
	49t1Kx2lfYdpFewIrAkIvqQXDQnedc+ztHAqyF4VABqZoKtvUPy49hqtd/nGJhEJ1bib1uB+gwc
	0Vv2HBOaUE4/A50tBwDXHMhPePrbhPNZBuF9C4YILrg8pKCM8C4IIyqNEiE0JuNRjicJ5hpx/HO
	82QZXeGPAk=
X-Received: by 2002:a17:90b:3e4d:b0:37f:e326:6557 with SMTP id 98e67ed59e1d1-39d709e74ffmr9078418a91.4.1789020344960;
        Wed, 09 Sep 2026 23:05:44 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.110])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33b95282a73sm1074567eec.31.2026.09.09.23.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:05:44 -0700 (PDT)
Message-Id: <1bbd0dc6aaa362a942d47fc2e4630ca6e7f14cd1.1789020327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
References: <pull.2195.git.1785939999.gitgitgadget@gmail.com>
	<pull.2195.v4.git.1789020327.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 10 Sep 2026 06:05:25 +0000
Subject: [PATCH v4 11/13] mingw: ensure valid CTYPE
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A change between versions 2.4.1 and 2.6.0 of the MSYS2 runtime modified
how Cygwin's runtime (and hence Git for Windows' MSYS2 runtime
derivative) handles locales: d16a56306d (Consolidate wctomb/mbtowc calls
for POSIX-1.2008, 2016-07-20).

An unintended side-effect is that "cold-calling" into the POSIX
emulation will start with a locale based on the current code page,
something that Git for Windows is very ill-prepared for, as it expects
to be able to pass a command-line containing non-ASCII characters to the
shell without having those characters munged.

One symptom of this behavior: when `git clone` or `git fetch` shell out
to call `git-upload-pack` with a path that contains non-ASCII
characters, the shell tried to interpret the entire command-line
(including command-line parameters) as executable path, which obviously
must fail.

This fixes https://github.com/git-for-windows/git/issues/1036

Helped-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index e0fbd2c66d..afdc1ef2db 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -3185,6 +3185,9 @@ static void setup_windows_environment(void)
 		if (!tmp && (tmp = getenv("USERPROFILE")))
 			setenv("HOME", tmp, 1);
 	}
+
+	if (!getenv("LC_ALL") && !getenv("LC_CTYPE") && !getenv("LANG"))
+		setenv("LC_CTYPE", "C.UTF-8", 1);
 }
 
 int mingw_platform_has_symlinks(void)
-- 
gitgitgadget

