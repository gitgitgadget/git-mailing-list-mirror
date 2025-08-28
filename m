Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0C2EB857
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756371538; cv=none; b=cNrN0+Cd+L8XNfX2RWtYUg4VOYEEna8APtEkAK5b5/Q8EM5RcW8idlUKp4CPUxo0d4bH02LAB7qhgSYXcaFXldhcx800X/VGfIkbX23Vr0wzGIbb5jZopA6PQlT/S6kFHaMzXKnn/y11aeR2dWBQUd0rYQrSKp9jOvdjcyJXyxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756371538; c=relaxed/simple;
	bh=9z+LxaUjw7vSYp7YmOuTJ5x4jbQ8ziTXTqETWkAoVWY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iwzXVZCo6r+ULiZWdo/ClaCnQmbw0mh+0agnD0mUIYiNHZf2h4f/UU9p/ic5ZgtWYp1QBmhICvOj5tXBC0A4BcueuA7L/nYQakPITqszq+C6iok1e4UgH4GWItXuc5uSWQYIUY3k5j1kd2V/NOehPQ4tDBdIacTTZYjA8jFDHmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdA21i4J; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdA21i4J"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c51f015a1cso445529f8f.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 01:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756371535; x=1756976335; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoDSGlgqY6pD7lTm+BwFOt4SLOsqOlLAaa8NUNHvAmI=;
        b=OdA21i4JVtw1sYtR0hfvDekVkaEU+ZzKMdMwKwHjIT0uiaJbn7/xNy8C42wVteRH4F
         1Oy86reCd+n9gKXNHDIU6VtokwXzfamR+zyzCpfm6SAkra+N9yzY96SX951KmWaIyB+7
         MXXe9wIkVif6zL1WgOsol9cFTXY8s/lOnF+dO6SDHufMiGYFWLeic+QdSO/8fa5Bl9Ep
         Ps2oqBR39UsaVhCUy3fbgwxJjKGqchFTbKj4f9d4UaLom4bzX7OIz0KeqpwAE2kqZIjt
         gRttQtr9uWMwnFpsLDS5q4TKaqNUzCLrsgeFLlGkICYQiKI76Y7Pg+//nq6k07bYN0Bf
         QU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756371535; x=1756976335;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RoDSGlgqY6pD7lTm+BwFOt4SLOsqOlLAaa8NUNHvAmI=;
        b=LIo44MvR4VYbvyszVNXBk4b/k3HEqCglLwCzbFRcUxDC71DP3WDEwoi9x4JxZxA6mW
         tc1kZalMaJRHEEz/WgwrHWO5BUtZjCSDjK3519COQU6wEzMgy1N91lS7Cyx3GTgQrHSL
         SUFGPc2klcfgIpbVRcnFGT79ZVLvMGdZRyy2shlcaKVCUxZ1vSYeMgANMzlov1NXLCgl
         fY9lCYFvsLnS7jDCKzkky8pHWv165iHR8WWAbzFK2MQNHd+8u9VZFHLd6gkvASymAPNZ
         rJgrk21YL0F9bcMHrau5gpE5DmP+PhVrHFRCp7j4ut+YyBd8GZDwgCpBeNWXyvoChUkS
         svrQ==
X-Gm-Message-State: AOJu0Yy2Vpj8NUgjrHY9u8cCHPIzsFlsCiCozeR2oF/klFXwf+plSb+k
	Sw0Norgsw+RECh6ieTa5fkMFtnhzyWRhAW9VAfH2qgnA5izhjzxXR1ILCmTzdQ==
X-Gm-Gg: ASbGnctn/XZRMeqUykaW/krv744PPpIdx34GS/tEGbCTiGz6F5DUURDXoD0WuTCi/a0
	M2UU6WCGpn64pV+X4MyO9+HJkDHXEcFFzzA8SB6GkloDfGYbPVpa9WxDuhI1skKbYhk4cE41sTg
	mStzPer/Cj7KBZNq4F8Q2mlMC3JtT53jAHMxnpOecxfCT9Dw7iHOpSSKHKKffjT8aCKIM28nT+K
	lWwrX8Jo0eeQj6YT/tF6gFxoo6Zb+Xz206Tcrjd0UsBRFnQcBpKZ4ngKprU4KB2IjoavEH2NzFu
	ss+XK1wG9Ql/Sugw78CzrXUZtVzcjInKCOuq9zTaVafl5X6DEU1g2qOxKnopUHYH4NHQ5v2kZoS
	uvVjgZLXxT9kcBrHYf8oQmQqi6jtf5eFCBfT7lg==
X-Google-Smtp-Source: AGHT+IHiWM1gEKOLRnbKcJmdQFT5bA9QknnI4b4yNxziHvdxrhcqDLPsf8Ir7XuOuNwrqx/1nzbxXQ==
X-Received: by 2002:a05:6000:991:b0:3c6:df53:6968 with SMTP id ffacd0b85a97d-3c6df536b93mr16172305f8f.13.1756371534729;
        Thu, 28 Aug 2025 01:58:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cca0dd7014sm6357564f8f.13.2025.08.28.01.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:58:54 -0700 (PDT)
Message-Id: <2e7e2c1524a73b3c1aaf28baf5689be4093f62ed.1756371530.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.358.v2.git.1756371530.gitgitgadget@gmail.com>
References: <pull.358.git.gitgitgadget@gmail.com>
	<pull.358.v2.git.1756371530.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 08:58:49 +0000
Subject: [PATCH v2 3/4] git-gui--askyesno: allow overriding the window title
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
    Pratyush Yadav <me@yadavpratyush.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

"Question?" is maybe not the most informative thing to ask. In the
absence of better information, it is the best we can do, of course.

However, Git for Windows' auto updater just learned the trick to use
git-gui--askyesno to ask the user whether to update now or not. And in
this scripted scenario, we can easily pass a command-line option to
change the window title.

So let's support that with the new `--title <title>` option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui--askyesno | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/git-gui--askyesno b/git-gui--askyesno
index f7312c70c2ca..d0c801c42c7c 100755
--- a/git-gui--askyesno
+++ b/git-gui--askyesno
@@ -5,6 +5,10 @@ exec wish "$0" -- "$@"
 # This is an implementation of a simple yes no dialog
 # which is injected into the git commandline by git gui
 # in case a yesno question needs to be answered.
+#
+# The window title, which defaults to "Question?", can be
+# overridden via the optional `--title` command-line
+# option.
 
 set NS {}
 set use_ttk [package vsatisfies [package provide Tk] 8.5]
@@ -12,10 +16,15 @@ if {$use_ttk} {
 	set NS ttk
 }
 
+set title "Question?"
 if {$argc < 1} {
 	puts stderr "Usage: $argv0 <question>"
 	exit 1
 } else {
+	if {$argc > 2 && [lindex $argv 0] == "--title"} {
+		set title [lindex $argv 1]
+		set argv [lreplace $argv 0 1]
+	}
 	set prompt [join $argv " "]
 }
 
@@ -38,5 +47,5 @@ pack .b -side bottom -fill x -ipadx 20 -ipady 15
 bind . <Key-Return> {exit 0}
 bind . <Key-Escape> {exit 1}
 
-wm title . "Question?"
+wm title . $title
 tk::PlaceWindow .
-- 
gitgitgadget

