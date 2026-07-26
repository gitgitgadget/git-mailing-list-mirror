Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174AA3BE62A
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 18:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091894; cv=none; b=EcabuJ5ApEkRIccsgO4eEZfrA+WM+EQUhsL8T1Ivu620AbSNCWPe+qa289n538bikI2tWI7Qw0DbMbNmPBwkPFHKoNSllc1JfQUyL1dZhUexREB4Hd9xzijaDcSfvvVzd9Byzgd1GZS3DK+nnknJW+g+lI1baA1CqisU/Bc0YXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091894; c=relaxed/simple;
	bh=QtdmL+gWbDnszPFL3rdQ7vT5v8e8YiJzIiPdXEiKV+E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Hf05Dxvfe2M1Qz3vgWAethrzYRhdGbY6hP1msBA5dK9I/hIj2UC2MOg35ne0wvK7PcyiJ93rusnmN6GmsQxJlJaMC1+SoOGRL7GUuLqvtwZusRzoNxdcL0LnvPavf1wDBJlpZwCy8h7rXc10pyYkJxfjzlR1Orf9XKkoWqbs6Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qr+/A6Cf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qr+/A6Cf"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ce7d2adef4so25013425ad.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 11:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785091892; x=1785696692; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TE7tDKBkdwisr1c9mLpYjFAaDuwy96fYtPG8oo1KLmg=;
        b=qr+/A6CfuI1T3goHUzD9QU3Qy4TgmXO4bwZvciisQNCcy1SL6CgwVCuKWP5Q8mn1se
         A+xp5G94mTKWIzi633dD/txf6p4S6kO/bw/5kMvyMHG5KqD6L38fUbbcLhfVzqbAmAOY
         QfpcY2CCWYcEP049ytuYH/xSOKPmELF5p7lh/YiLZrqVMnKKMELNsuOil10j5OlKJ5n0
         fh70Xp8ARwkWdkvt8m5MjNBzVnImx/oQbvQEL3Ep49vb50MbC3KNePE9VdBEh4FqVcfW
         CHBFdqzoDbdpKMVtyo3ek4oBMT7HSr3Zr3V6l/MY/Mv2jSgLQaEDOvwEiv2t5GKh3ndv
         5jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785091892; x=1785696692;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TE7tDKBkdwisr1c9mLpYjFAaDuwy96fYtPG8oo1KLmg=;
        b=TULZSZKuh9raD6q9QTEs3RXdtaKLcumT+dsAjsPW7gEzBcm0yuJCGiwmjRo7Sqolbp
         QJvP6m0wlaidH1sOdwAHTeHeCpHXCzGg8NrrhfD142nU37uvbXNi1EbrQXaNLfLKk+of
         kTml0GbYU7H6JX2sgpXXF+pVzJvjecXWcs+MepuNBXtT2abFTzcS+clUhgigL5E8oX/I
         mz3OsLfJs0sVN6oS8KrB5rKJlC63A2lpW2eDpRRyt9rlkirIG4/D+SKPHPaJa/zF8goD
         7jUe8gb9aoWlUa1tklOoWXKRLKNzOoCPwxE2oKy57t3Ull7bMHjjEfHNpyrbH75o1bpX
         iCXQ==
X-Gm-Message-State: AOJu0YysYfQ/ILnywF6cHE5PtBAYFk38s1gouPixBiGwUTnwcxc4jHuu
	D6Wb5YdoHLL0xbdPw95BJ4yqaEy2oek4B7W6mbKK6rFAaDtpIi2Mc683UTjWXw==
X-Gm-Gg: AR+sD1015AEiqERbrGJzHTuFdLwK1yTLugflIBvjbJTV7kuDcPJ0oUWLq3KMnP3uRee
	oFlsYCui5gDS7tRGZsWpLFwa4QOjsyQtiejT0GumCX3wYqkCDMOS3uJ+yC9eHVQXDmlq6hJKcZk
	SwEIkeWlqbXfXOa0jfCgWv0z/iaRQJQRKeORjmO2AsvxbDfx9bwbWBKEZFGbERpe99pqe02SLds
	gw/HCVkQ9ZHL/3Jtf786Zch7LnOVj2f5kIKgkyc3Mxp30Bu7X5cmLf5ZtBUzKNsaLe+OrXeVF1u
	dSx3lMZkC0n9w5MrXdgpsJk1LFTCP36FByv7ww9UOeYHUBlpjc/ogWsNiYfHggUFO55DqUQScmz
	ejeuaVwvSDaSlQnu6UPnlzK1TeSpHSgTwKyBJyqP4WYWsA05IzUJ/ZwZ4yEVlf9FNSAhWbO60m+
	c7fyLR
X-Received: by 2002:a05:6a21:908f:b0:3c3:bbe6:95c7 with SMTP id adf61e73a8af0-3c67da2e44dmr5102541637.17.1785091892504;
        Sun, 26 Jul 2026 11:51:32 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.229.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc44cb92sm38092027eec.13.2026.07.26.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:51:32 -0700 (PDT)
Message-Id: <b4a1ff4deac34ad20475f06ae4bfe52f582aec8a.1785091889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
References: <pull.2120.v5.git.1784149323.gitgitgadget@gmail.com>
	<pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Jul 2026 18:51:20 +0000
Subject: [PATCH v6 1/9] gitattributes: document how external diff drivers
 relate to diff features
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

The "Defining an external diff driver" section explains how to
configure diff.<driver>.command but not how the driver relates to the
rest of Git's diff machinery.  In particular, the command only
replaces the textual patch: word diff, function context, color, and
the like cannot apply to its output, while the summary formats, blame,
and git log -L do not run it at all and keep using the builtin diff.

Spell this out so the scope of an external diff driver is clear.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/gitattributes.adoc | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index bd76167a45..2c4fbfd7f1 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -784,6 +784,16 @@ with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
 See linkgit:git[1] for details.
 
+An external diff driver replaces the patch Git would otherwise
+produce for the path: Git runs the command and shows its output in
+place of its own.  Output features that post-process Git's diff do
+not apply to it; word diff, function context (`-W`), `--color-moved`,
+and coloring all act on Git's builtin diff, not the driver's output.
+The driver is consulted only when Git generates a textual patch.  The
+summary formats (`--stat`, `--numstat`, `--shortstat`, and
+`--dirstat`), `git blame`, and `git log -L` do not run it and
+continue to use Git's builtin diff.
+
 If the program is able to ignore certain changes (similar to
 `git diff --ignore-space-change`), then also set the option
 `trustExitCode` to true.  It is then expected to return exit code 1 if
-- 
gitgitgadget

