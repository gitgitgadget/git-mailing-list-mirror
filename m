Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA6A2676E6
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719622; cv=none; b=sb7YZdqyI3ZR67evotGuj99Byehce56Np2JOdmZyt65063+n5Aq5JA3lKuGW/bcmOxtPsBoZmpr7vU9aSMAh6tv9IHNQ+ki5soNOr0h66XYKj8XQsXmFVS/EjvYn2p+Ctpz33gptTeGqmJUgYP8yQguiGlrIiBBYjV64vMdu8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719622; c=relaxed/simple;
	bh=OrV1gBIqpNz987uJCHh7x7vj6fFh1M5axuPtHHh8RJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8J49g0nlxvWR4ACEai60K28I+n8LtYMm68W5aD0GvOQ9RGS+Sx1QSZhy+EcppQwELX6oVjHAot1Uc8D+cbbcvCUWxIkbD+IOTcXweerYixx22jpsU3izGC6n+ELNdmho4lb/DzMhbhvCJ7fttRH3aFcaFJIzS1spqWb1vrj6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmDGqJaO; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmDGqJaO"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d60157747so2328117b3.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755719619; x=1756324419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zUt5L0xvHRq78cSx8C91Cc0IEIhtyaXDa3Rnjab7yFo=;
        b=PmDGqJaO1MaAjN7U1zBSYsnbKC4qq8DC+SPBnGVQG5zy/z/cmPVjgYelPmOqILumJp
         yoWkM5mkTgq+4uBb/PnCxCIksDnyX4JhGuo5bqIN2MoDZS8WqOdeIAjmziMXv44itwmk
         B3vtitLUJAAYBiF+lXHEHlDFGEq9DX2olSYabUO253zVrbFUeFLK9W2Zl9bDO6FadzBa
         iwMzNoJEsqtVZi/ZMQ3kRUBqZ5fUmXTqnIIp+lsRY1gXBLtPQJdRYgkDRIMKHn70wEvU
         jceAecPP0KBm6Htmk3gJRn+/Aw/lV8dfNFQyFmRD1HkCtjV9EV2FBTsjeCUisZACWVgd
         hNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755719619; x=1756324419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUt5L0xvHRq78cSx8C91Cc0IEIhtyaXDa3Rnjab7yFo=;
        b=m8utgK6U7cmJBffBvmLIkrRu8dfNAUk5ZrcNcdVTP6B7NwSYkjCxug+vZKj9gl57ck
         eOeMRHtRJoUUH4iWNwkfnspPdSLr83gJsqSf6Jko2g4TpxLoKFDtxY9kDtnOjLpbCKew
         CoaYXBFC4OoRQzAHP1rnbUJvgGAlkVBerGvTB+kyVdKxt2rSrgrQoikqNCABOfIdUOjG
         SsEhKmsS0zn0+SwXV6PSymLb77NTY+nXEB93kEL9/JyLmCKcz90DYztbONSK/EQpUCaq
         RFTv5Qf6A0ws7LdWHTlh1D9tLMsWD8j7/2z1N9jqltYMJV9dShDJeBX+FfaxKWAUtY9M
         ZFxg==
X-Gm-Message-State: AOJu0YzoqnjW5b3AKNiyOQ7ZmYpaH8bxWKV65twheAbJjSiMcRKw5Tar
	0tCYBEgxI6ski65RW9VWwC8rf2/TEYULqQPdTA+D8rKDJP68LuVBuHhPNaBEjQ==
X-Gm-Gg: ASbGncuuB2jW1qfRtkP1BLp2K5zDSznNve+ahSzHd4m/flTQ6zOHFNaE+yNV3doy+c+
	Lolq/mDODfh3ixWUvMlqc/7sTGHg8ysUm6VPU2vQFknx1HiYgorGOEnDkAzNfw7EhTLqurcBQMQ
	A9aBjubEdhHzT3dfjvZ4veo9Un7sOEz5xLbAIt+P+FKpAkWaqHRCYC7I8FLzsMBQ3JAWclU3EWf
	+qH8QZ0RoGPSj9+jVjON8zSuPiHnmFtqwUUtCQTm6C1Lkt+P88oaQif9+GEtbuARdCeB8nYohKR
	xG+6A/yBcLF0m09TD/M0mvJxyNCqvHxGm+ZvBk16uwCJYzhtKQ/5Oy8/+v7MybR01fUWOpYhG9U
	oL2D3KA4xkMxj2YqmJhT94reWkSf1BcRnYFK2hEqspRQntZA54kmEYa8LzMsHB9s4mZowxkuCXw
	GLKqiN+9Pc3boTlqmIV1vR
X-Google-Smtp-Source: AGHT+IFWSG6FnYnOp4Syyr2BO1eFdIRcLkDMTTlRPAGEkHUrWJQEqvv2a4rmI8QoPXgvVTAZNwMlsw==
X-Received: by 2002:a05:690c:350a:b0:71a:41be:133 with SMTP id 00721157ae682-71fc88bed60mr1338327b3.14.1755719618585;
        Wed, 20 Aug 2025 12:53:38 -0700 (PDT)
Received: from USROMMRAPPAZZ01.infor.com (pool-74-105-50-139.nwrknj.fios.verizon.net. [74.105.50.139])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e058dbasm39055987b3.47.2025.08.20.12.53.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Aug 2025 12:53:37 -0700 (PDT)
From: Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH gitk] gitk: add README.md with contribution guidelines
Date: Wed, 20 Aug 2025 15:52:29 -0400
Message-ID: <20250820195229.45943-1-rappazzo@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 README.md | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 README.md

diff --git a/README.md b/README.md
new file mode 100644
index 0000000000..adf7a0ba85
--- /dev/null
+++ b/README.md
@@ -0,0 +1,63 @@
+# gitk - The Git Repository Browser
+
+This is the official repository for gitk, a graphical Git repository browser.
+
+## Repository Status
+
+- **Official Repository**: https://github.com/j6t/gitk
+- **Integration**: This repository is regularly merged into the main Git repository (git.git) via subtree merges into the `gitk-git/` subdirectory
+
+## Contributing
+
+Contributions are welcome! The preferred method for submitting patches is via email to the Git mailing list, as this allows for more thorough review and broader community feedback. However, GitHub pull requests are also accepted.
+
+All commits must be signed off (use `git commit --signoff`).
+
+### Email Patches
+- Create patches from this repository (github.com/j6t/gitk), not from the `gitk-git/` subdirectory in git.git
+- Send patches to the Git mailing list: git@vger.kernel.org and CC the maintainer: j6t@kdbg.org
+- Follow the Git project's patch submission guidelines
+- Include `[PATCH gitk]` in the subject line
+
+#### Creating and Sending Patches
+After committing your changes:
+```bash
+git format-patch -1 --subject-prefix="PATCH gitk"
+git send-email --to=git@vger.kernel.org --cc=j6t@kdbg.org *.patch
+```
+
+For `git send-email` configuration, see the [documentation](https://git-scm.com/docs/git-send-email) (search for "Examples of SMTP Servers").
+
+For information about subscribing to the Git mailing list, see [subscription info](https://git.wiki.kernel.org/index.php/GitCommunity). Note that subscription is not required to participate in patch discussions.
+
+### GitHub Pull Requests
+- Fork this repository and create a feature branch
+- Submit a pull request with a clear description of your changes
+
+## Building
+
+gitk is a Tcl/Tk application. It requires Tcl/Tk to be installed on your system.
+
+### Running directly
+```bash
+./gitk
+```
+
+### Installation
+To install system-wide, you can use either `make` or `meson`:
+
+```bash
+# Using Make
+make install
+
+# Using Meson
+meson setup builddir
+meson compile -C builddir
+meson install -C builddir
+```
+
+Both build systems will handle setting the correct Tcl/Tk interpreter path and installing translation files.
+
+## License
+
+gitk is distributed under the GNU General Public License, either version 2, or (at your option) any later version.
\ No newline at end of file
-- 
2.51.0

