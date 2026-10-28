Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188505;
	b=ZRrrXtBrtmhxJbYzNbYllrAyxZ3wEFBjGK90mCMjFdfCiFMaNABnLZYVJONy8r5kqPou
	 YlkRX4e4LrEaSHP63u0g9LgVjhjZ3GRtyzuXPc0RaVr/x4kydxHsq/2moOZa36bZLTd6Y
	 Ds4u7JM7sSz70FRcu6WN0TGGrlqiAZDy4mvGseVaZj8M/Ze2UP1IZRRYQyO1xZ0kSUbZO
	 t+MNJrhSzFe1NkwhQtoNrYYUYgLH3Xtjj1UyA5Ox4O1qBmTi7hKNnIYn1t9IK7u8z20u+
	 VCMCuHEB7lWyJBcUEHBBo+WR/h+nitIgnpI/6asHz21DDy2fEQS5QYFSKiCqy8qHk7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=e7RMUywCrARq1fVy5SQBLnQLeJo3UnHOCXW1C8/Be00=;
	b=LglP8OIyiYcgp4+Jakci+Kei4aspsPeDa/g8dRVI/APQ2Df3Zv9U9Ty2m1pDyWu4XTsv
	 H6XQZDqi/ZWIm+EpqjHhQy3/JeZquJIRguuYR2NKFNFraf5km5RsaN6gUhaQf00nsuGkd
	 eYGqetZaJH5TId13M8GyxZMREbrw9QzorrYGF2TiAuDA+KbTZzzzDAoRDxfX0un5n943c
	 LO2fj8oKTDr3MDB9D6q9+ze+cnwboNP74WgSKXaOSCsrZo73ABBv9aM21mS5UvhIv+27+
	 menTo5wlrwuGPbvjun/HmuY0zvaoqxX1n0zLOU+IfdJwFCO13ebnuolC/M54CXj2AUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MGVWHOkw;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7816F606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 11:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7816F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MGVWHOkw
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-19305bcb72cso799081c88.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793188504; x=1793793304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e7RMUywCrARq1fVy5SQBLnQLeJo3UnHOCXW1C8/Be00=;
        b=MGVWHOkwqZyQX8/shfTuAtrb01vCBQNOHjtlPjCeFmxhrvv4+Are4TjqhH7o5qdr87
         IUJDQ0USHqvPtMn11st2tVa9WLqrDBfX8rtRW14CeGBIS8Gntv8yQ6GouLBRoIp4mjrL
         PPEqroVHRcvWp73v5iTFBc1dQp2Jy1vbZsSdmgfFXEyKScUj+vNxQiYACI6kN5Ngfpo5
         GH30TDBam3uD9brA+U9Dc7vSe5h6d9uD4pxA457n78+g44m6IiBs0KyyWNSlV7LQUZmP
         aKBoeWjCO2LlomrduelOAz86LqZD/k2uTaQtx39iCciSzbqvO/Tw1LpwG4fIvL6oqc25
         MMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793188504; x=1793793304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e7RMUywCrARq1fVy5SQBLnQLeJo3UnHOCXW1C8/Be00=;
        b=mQgld4iA2SeuhJuwNjDZRfthC9ElUaAQHW5s7Wh8IBCe0MyZal03t6i3h6EmVAZv17
         o2THFFx6D6Ye3qM9WXTEAumOagjNano0S/Iyn2IrwxPt6llBr1+LfTER1oynR1qnwbbk
         t/O/IXr0e/eL6yBxO8MMqgQ/WIwFXXrltqbkX6uwT+MoYMXe6nXXenmVkAwLSRBfZhoo
         bHzQpuAEubAugP64PAfmjYvdPOJ5yXfEl3bBHKKiO+ATEhaL7hOkBmuZ9gsrB53jnbK2
         b93upQhi/FMCCl1wCSkYTXS0Ofg6dThfWlWo0zYz59cVZ8twsstFvkmdkuq9nBWCOb6C
         21+Q==
X-Gm-Message-State: AFq9FYL7vKwXjEwB+kh8aS6q7GraIYvvjlhwecoqlzlRX7OZpKQv0y9e
	jBb2TKn2J1W2mo3jAYNLheeGWVW6pQNSlVGcVJ3oPMIGWdQkJzYgdv+f5U+EvQ==
X-Gm-Gg: AYBFou0P/dO76Axj6uZB37IJx7xhYwavvH5tfnTRplrydPbjvazXRGlB1geGXUVMovy
	Z3Ppy7eMIJSFq1otYiLZYjhHQUFQM/mIB37wP+Run4T0evpWNxaZfqZou5xLfNz9HdFwR0zW//Y
	0wcTP3yFujddKECItdQpVVswx/JeUIMUro3Q/1WLa7/u391dvMaGQiN7hkTAEhrK9cQA/I7jbym
	tS72LCCcSpyyuNEKj6woSYqTlmf3Gn84p+09Qyiww/V5wektnz9fTyPXpEDo396auW2E20uKAvj
	ZnT+lWXVAVljKG3G2RebvU6xiIehTv1tnABjB/CO6ilyJv0X+uSxkpu2fVZr3ISq6zrTQ3NmBqu
	bxUHDgNhKZ9s0DTppgJx2yk9LAitdMI9d4oPwBwGYEDjYpPopBbb6SxhxyjHxuaO7grY+TkTSTc
	vDOy6FRJ3tMU+ZI32Ua836AX/kga4gC9QQLAE+ABNKX0ErjMinOle2eA2Pn7CPFps/cwhnwLEDX
	7LaVSkWiay+cNtOJbitlI5hn7sBSR9i83DO01HXUj1j4GKejwkj2/2o3zzkSraWDVUZTBeOuLIu
	O4z7YnKeZqBP6XdXyyQnOewvwgvU91XMNBGioMCx0zOsTFsfamDgGhMk
X-Received: by 2002:a05:7022:b903:b0:199:4f68:7710 with SMTP id a92af1059eb24-1a6c86c607bmr2669197c88.2.1793188504346;
        Wed, 28 Oct 2026 04:55:04 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([2406:7400:12b:66b5:b36d:2c4:846e:bbe6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75f7fb28csm6350819c88.18.2026.10.28.04.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 04:55:04 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/5] setup: provide hint about auto-discovery boundaries
Date: Wed, 28 Oct 2026 17:24:02 +0530
Message-ID: <20261028115412.169748-5-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.56.0.283.g7d13445134
In-Reply-To: <20261028115412.169748-1-kaartic.sivaraam@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20261028115412.169748-1-kaartic.sivaraam@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the same spirit as the previous commit, we want to improve the UX
of the Git repository discovery case when the GIT_CEILING_DIRECTORIES
environment varaible is set. For instance, consider the following
scenario:

  $ cd ~ && git init                    # dotfiles repo at ~/.git
  $ echo 'export GIT_CEILING_DIRECTORIES=$HOME' >> ~/.bashrc
                                        # stop ~/.git swallowing every
                                        # non-repo directory under ~
  ...weeks later...
  $ cd ~/.config/nvim
  $ vim init.lua
  $ git status
  fatal: not a git repository (or any of the parent directories): .git

The error message is a bit unhelpful as the gut reaction of the user
would be to wonder why their ~/.git directory was not discovered even
though the message says it checked the parent directories. We can't
really blame the user for not remembering that they had
GIT_CEILING_DIRECTORIES configured in their ~/.bashrc.

Improve this error reporting UX by giving an additional hint about the
ceiling that auto-discovery was bounded by and also mention what
GIT_CEILING_DIRECTORIES was configured to. With this, the user would
see the following:

  ...
  $ git status
  fatal: not a git repository (or any of the parent directories): .git
  searched from '/home/user/.config/nvim' up to '/home/user/.config'
  $GIT_CEILING_DIRECTORIES is set to '/home/user'

Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 setup.c                       | 29 ++++++++++++++++++++++++++---
 t/t0009-git-dir-validation.sh |  4 +++-
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 8f6b609240..87fcead87e 100644
--- a/setup.c
+++ b/setup.c
@@ -1997,9 +1997,32 @@ static void repo_discover(struct repo_discovery *discovery, int *nongit_ok)
 		repo_discover_bare_gitdir(discovery, &cwd, dir.len, nongit_ok);
 		break;
 	case GIT_DIR_HIT_CEILING:
-		if (!nongit_ok)
-			die(_("not a git repository (or any of the parent directories): %s"),
-			    DEFAULT_GIT_DIR_ENVIRONMENT);
+		if (!nongit_ok) {
+			struct strbuf message = STRBUF_INIT;
+			const char *ceiling = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
+
+			strbuf_addf(&message,
+				    /*
+				     * TRANSLATORS: The first %s is ".git", the
+				     * second and third %s are the directories
+				     * where the search for a repository started
+				     * and where it stopped.
+				     */
+				    _("not a git repository (or any of the parent directories): %s\n"
+				      "searched from '%s' up to '%s'"),
+				    DEFAULT_GIT_DIR_ENVIRONMENT, cwd.buf, dir.buf);
+			if (ceiling && *ceiling) {
+				strbuf_addch(&message, '\n');
+				/*
+				 * TRANSLATORS: The first %s is the name of
+				 * the environment variable, the second %s is
+				 * its value.
+				 */
+				strbuf_addf(&message, _("$%s is set to '%s'"),
+					    CEILING_DIRECTORIES_ENVIRONMENT, ceiling);
+			}
+			die("%s", message.buf);
+		}
 		*nongit_ok = 1;
 		break;
 	case GIT_DIR_HIT_MOUNT_POINT:
diff --git a/t/t0009-git-dir-validation.sh b/t/t0009-git-dir-validation.sh
index fed1b045bb..ab3d2593aa 100755
--- a/t/t0009-git-dir-validation.sh
+++ b/t/t0009-git-dir-validation.sh
@@ -101,7 +101,9 @@ test_expect_success 'setup: discovery fails when a valid git directory not found
 		cd parent/no-valid-git-directory-within-ceiling/ceil/sub &&
 		test_must_fail env GIT_CEILING_DIRECTORIES="$(pwd)/../../" \
 			git rev-parse --is-bare-repository 2>stderr &&
-		test_grep "not a git repository (or any of the parent directories)" stderr
+		test_grep "not a git repository (or any of the parent directories)" stderr &&
+		test_grep "searched from .*ceil/sub.*up to.*ceil." stderr &&
+		test_grep "GIT_CEILING_DIRECTORIES is set to" stderr
 	)
 '
 
-- 
2.55.0.1003.g10538fe699

