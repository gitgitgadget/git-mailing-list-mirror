Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4320D14A4E1
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723886772; cv=none; b=imr4WtPeSt+LTXNEkh27c6OH/Fy59CJYnS6gwicma6czJWRQ8FBBkZNIInJ2HdfKp9I0TKZGOw7BtZYu/EiA9ALWKQGIlWZUDkOGQuWr6GMSQ7DrLGjDR6aonQpAsfNcU5cYF7pl/WwSZ47TWta8K51o4j12VCX7vj0Tz6zbYvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723886772; c=relaxed/simple;
	bh=04M2SA6KLr1ytY4c4zDyaG6UDDk0NJk+zVZ7zJ5EVPg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AkgV8x9KkbB6TNqJO31R2l9+HOTIxRsADTw53MsmoSc5Rdz1c0CCh7IlEGcBZ5ZqPkkoHy3JeRGe/Mcp497+msfqF2RGqfoE+bB9GZlNXVAFo0QGrtUDMNQdD0CeWQSGNe0ireJFaT217JQE7zv92N3aoSyRiqlsTNgkjcWOPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a53SmrWo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a53SmrWo"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4281faefea9so19401695e9.2
        for <git@vger.kernel.org>; Sat, 17 Aug 2024 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723886769; x=1724491569; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u/SlEvxWfmaS8KDcb/mxNvkCVF5nerHKz183zR9kGw=;
        b=a53SmrWoa2RpEciH26/grbVy7LpWPHYa0d95HAIljnai5kwyLHrN8EW+O3vgPGYpCk
         DTw4XFq8brGdNsxPOt2dqj02LYYbtf1n3DC2HOeZs0R/uygLUfnJi9bnWz0YPOL+9qD/
         BfnDJFM2859FmfVoepsGVFViFyLOxK0xlEbGiacACNDOsJaFKdo8EgdDMcU+ghC7poEV
         Fr9IEq1nEcZ5jPTVcT48XUMTZgYPtkeDrSpilgZqDaLjC+AMB+m+zezptkmNtJpnagoU
         hAF2alZbFXfX07NOhmr5fBfOQ6cq9G7b9vkg4ySLMO8p6158luzPD+IOZPJXQayx7ry8
         22cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723886769; x=1724491569;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u/SlEvxWfmaS8KDcb/mxNvkCVF5nerHKz183zR9kGw=;
        b=aiw8Jn3+a7uayNFaYzXSUSMfhdLRzGZWrrgirVvgrSSJ1us7A2LyxZhzz15SyXEcF6
         GgtmyhtnoSdZyDUvKKQS43Hstrm1bNPyjEKWiZoQ6r79sG24CeshXgeGVuwa7cVI4f+i
         eVXDKRTQ0rfuQy1ivl4Ok9EBFG5F50/yr2uAk3+M+Kw0VZVLQgxsWOAlndpmRcyFILee
         lUgV0oQ2L+EBm90oUswdLVlitfHqMFsOSE1S5cxqfi1hy+wBDmKngD+t/SMLTD/cu/Vl
         R40rUPTOTb6/LMJjIw/hKIWo1b4TpqItkzNPwJPUId0OqSxA8r9h0n5OJkKnLIxOztGl
         0tSw==
X-Gm-Message-State: AOJu0YyU8PQhRdRAWheVo0PouFdaw7ii0EOG5xrn1LK/m9RwQ1VkCtOB
	8Bj09SpXZfHMGSOT+8h0qScI51ldoV/xo1hgkYb+LirwzQdwARV71Gaaew==
X-Google-Smtp-Source: AGHT+IHkQp8FYNYI/iiz0ys0KrOZMkDozV9YIu4gNcVioA+B3690oYDd1J8X9besrKmcbE54jWaCxg==
X-Received: by 2002:a05:600c:4f56:b0:426:61af:e1d6 with SMTP id 5b1f17b1804b1-429ed7cc6a7mr43099695e9.29.1723886769221;
        Sat, 17 Aug 2024 02:26:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded18468sm96982165e9.2.2024.08.17.02.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 02:26:08 -0700 (PDT)
Message-Id: <633e71a01d3b7e3e66fdca35136a837ba4975b58.1723886761.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
References: <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<pull.1750.v3.git.git.1723886760.gitgitgadget@gmail.com>
From: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Aug 2024 09:26:00 +0000
Subject: [PATCH v3 8/8] git-prompt: support custom 0-width PS1 markers
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
Cc: "Junio C. Hamano" <gitster@pobox.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Patrick Steinhardt <ps@pks.im>,
    Avi Halachmi <avihpit@yahoo.com>,
    "Avi Halachmi (:avih)" <avihpit@yahoo.com>

From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>

When using colors, the shell needs to identify 0-width substrings
in PS1 - such as color escape sequences - when calculating the
on-screen width of the prompt.

Until now, we used the form %F{<color>} in zsh - which it knows is
0-width, or otherwise use standard SGR esc sequences wrapped between
byte values 1 and 2 (SOH, STX) as 0-width start/end markers, which
bash/readline identify as such.

But now that more shells are supported, the standard SGR sequences
typically work, but the SOH/STX markers might not be identified.

This commit adds support for vars GIT_PS1_COLOR_{PRE,POST} which
set custom 0-width markers or disable the markers.

Signed-off-by: Avi Halachmi (:avih) <avihpit@yahoo.com>
---
 contrib/completion/git-prompt.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 6be2f1dd901..6186c474ba7 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -129,11 +129,16 @@
 #    strings (SGR color sequences) when calculating the on-screen
 #    prompt width, to maintain correct input editing at the prompt.
 #
-#    Currently there's no support for different markers, so if editing
-#    behaves weird when using colors in __git_ps1, then the solution
-#    is either to disable colors, or, in some shells which only care
-#    about the width of the last prompt line (e.g. busybox-ash),
-#    ensure the git output is not at the last line, maybe like so:
+#    To replace or disable the 0-width markers, set GIT_PS1_COLOR_PRE
+#    and GIT_PS1_COLOR_POST to other markers, or empty (nul) to not
+#    use markers. For instance, some shells support '\[' and '\]' as
+#    start/end markers in PS1 - when invoking __git_ps1 with 3/4 args,
+#    but it may or may not work in command substitution mode. YMMV.
+#
+#    If the shell doesn't support 0-width markers and editing behaves
+#    incorrectly when using colors in __git_ps1, then, other than
+#    disabling color, it might be solved using multi-line prompt,
+#    where the git status is not at the last line, e.g.:
 #      PS1='\n\w \u@\h$(__git_ps1 " (%s)")\n\$ '
 
 # check whether printf supports -v
@@ -309,8 +314,8 @@ __git_ps1_colorize_gitstring ()
 		# \001 (SOH) and \002 (STX) are 0-width substring markers
 		# which bash/readline identify while calculating the prompt
 		# on-screen width - to exclude 0-screen-width esc sequences.
-		local c_pre="${__git_SOH}${__git_ESC}["
-		local c_post="m${__git_STX}"
+		local c_pre="${GIT_PS1_COLOR_PRE-$__git_SOH}${__git_ESC}["
+		local c_post="m${GIT_PS1_COLOR_POST-$__git_STX}"
 
 		local c_red="${c_pre}31${c_post}"
 		local c_green="${c_pre}32${c_post}"
-- 
gitgitgadget
