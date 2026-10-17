Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AED3DAABB
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792224731; cv=none; b=VL5AFL+I8J83WhZPOLq7ULeBNUDGRSKFbZwBE4LCAYfZ/a7Z6EK7Zh5nfPpY87xzq0Zun5sUlTxhN9GFsAVjJ6pTWWKWpSiIE0zMm8lzGPeNgPwgCH73Yp6SQOy9vMw+ja8ljKpn+l+w4E5A+iBczqhgkuZ2SwBoc7pvb6srpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792224731; c=relaxed/simple;
	bh=QjQhXYfd1RRsT7m0QH/C38XfyW3HJtg4Q27tgdXZNCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+CUZ4nnBRkKCUvp3fYD2a59dXrNHGXGXQ6Qo7LYM2FSz9ATBVJ/PlcGoh22jDmgA3PusZOL+Hs60WP7l039lZpE0UQ98ACaNc8Chj6FA6ITRyaP2N48eC37q6hfb0umx+zrfyQEoBQLqQ+YniHuPxdS3ZuVubjpJqqk4dVlME4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8g6Wv4J; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8g6Wv4J"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so196645e9.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 01:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792224727; x=1792829527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VyZh8O4mklsOddh2caBLoOxp7lBZNF3ZmiBmGRcSB9s=;
        b=V8g6Wv4JgMheb0mZKG0baFm/RNFNCA8ot3gQ2d/mGVkerUtoak5yDRd+bVgpaNSn6H
         054SBd3P8te5auzrl7wfW9XrFM3jVJtEW6u07Vu17iz1hNvLtujn4ntHqsKmAwhfTeTz
         7SJHaf0DAlQvYcxIcG40PXUurDSW1HGxG2rSV3ZiY6OCfxjrvB5pwA6YLYpxFcirgZVS
         YV+WBQL1vdYfmLL4vd+XjWCU4oj2Tt3ocr1Qelb8YdGJleT1pL0FxTKPE3iKfiJ9deJZ
         Xl/10sWSyNMtDHVLeTe86UJvfOBodMp9N7dzaPpqza2O0LOjj07RNUKNKpGkN4fs+hM6
         xn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792224727; x=1792829527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VyZh8O4mklsOddh2caBLoOxp7lBZNF3ZmiBmGRcSB9s=;
        b=vLIbl85spoFFAgqQEFslWIByr2P5iqJCmunZTgWpApDR6bAWbrC3wRC1lDZw5V2veD
         ZHMvRkMM5KUjwMJbbnlF6sZkQhKfFXNnYOradcFFRvZsU1SErFmJvysFIrwn9GarhpbF
         Rq39lbf8H55JAW4PesxNGBlEhs/gkVWqClSttqbMCZrS5l+9wFeTw2Xiji/R6KOkZruI
         ir1FGJsahJUilfJRTh6tIEROe/oqvwndlRwuBll4OSpEGA+8vW8t6skTahfDet5rpWqk
         Y7gDEdXhpbzOZTxK8K9ZxS92sCWSrbjuv0wIkm0bN/a+4DeZvDGw20UE/6St+ymReyLh
         ZdBA==
X-Gm-Message-State: AFq9FYKWS58yvM76HC/JQ1HbdI/AfWS1rTm5SLKO5asIXUHfdYvELF7P
	Syu3O7NLAVnst0c1g5KSC1eMTmsWxdvw0WOm9dxvC2Aeinz8fHjRSXZR7lmVOmmO
X-Gm-Gg: AYBFou0e5qgCyrKQmds0FuyIE2B8nBy7jOlt9Sk46eT37EBPMSDgiZbqQmUTnhvgSQ6
	0Q6kwnegVtgc0d38V2F0s89te7kq7CZD4Pwyupksir6k2KiKTL5sNO9+KYfAiPWJB1TP7n7S82s
	wRwxlrL1k7w3RW1QST6dCkwmyiKimTcZTh4gTMxGZmM+2GKjCZ01Qrw/EqvgLq3+Ko+d2JXO3xz
	/I4SmQIgL5iguJ3NXLgHv1aEAHimQjV3hNuYXByylaINpCAMupvQgFu5damEhLpptZddDAtdK09
	6j6VLgk2DWZwrnDPTTwRS6OaBYs33n6HXjLZal5B5aM4jImQuj0SyOTIg2kJPls3ZwJqCqJQzTK
	deTo74PlbkeqZibjU4qwaZ+NU2tTHheLk2b7qxTw/KcFoC2PkbBpiL7B3OE4+Vradl1loZG6i4J
	xSTMmNmGdHKOloM0FM/rNBGWIjSzIiXu66765dUIsWDut1T1otPzbj22miGvge2oi7Bp4XnKgBP
	FjbY0CxmghhI61KCo3mOtV1OATBsw/8QYX3ScS1G+gpqsZZsj0N4aY9OJ5gzjoZcI/w/mBFS5VP
	7Q==
X-Received: by 2002:a05:600c:3046:b0:4a1:87fb:c8c0 with SMTP id 5b1f17b1804b1-4a1c66a71cfmr83822415e9.5.1792224726405;
        Sat, 17 Oct 2026 01:12:06 -0700 (PDT)
Received: from u.ad.analog.com (sgyl-40-b2-v4wan-169439-cust3365.vm6.cable.virginm.net. [92.234.157.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd5035bbsm9993400f8f.44.2026.10.17.01.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 01:12:05 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2] pretty: fix lost indent after newline in %w()
Date: Sat, 17 Oct 2026 09:11:50 +0100
Message-ID: <20261017081150.2295695-1-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014172333.2224123-1-andy.koppe@gmail.com>
References: <20261014172333.2224123-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When strbuf_add_wrapped_text() meets a newline followed by a
non-alphanumeric character, it treats it as a hard line break and jumps
to the new_line label. That code was written for the case where a line
gets too long. It moves past the space where the line was broken by
setting the next line's start to 'space + isspace(*space)'.

After a hard line break, 'space' already points to the first character
of the next line. If that character is whitespace, it was wrongly
skipped, so the line lost one column of indentation. This affected
things like code examples or multi-line list items starting with "- "
and continuing with two spaces of indentation.

Fix this by skipping the space only in the line-too-long case. In the
double-newline case, skip the second newline explicitly, because that
case relied on the old skipping.

Add a test for this, and update the expected output of the "magical
wrapping directives" test in t4205. There, %+d emits a newline followed
by " (tag: ...)", and that leading space is no longer lost. With a wrap
width of 1, the space now causes an extra line break.

Document the %w placeholder properly, removing the reference to `git
shortlog -w`, which has different defaults and isn't concerned with
paragraph reflowing.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/pretty-formats.adoc | 9 +++++++--
 t/t4202-log.sh                    | 6 ++++++
 t/t4205-log-pretty-formats.sh     | 2 +-
 utf8.c                            | 4 +++-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
index 2ae0eb11a9..4fb0419715 100644
--- a/Documentation/pretty-formats.adoc
+++ b/Documentation/pretty-formats.adoc
@@ -169,8 +169,13 @@ The placeholders are:
 	    on the next placeholders until the color is switched
 	    again.
 ++%m++:: left (`<`), right (`>`) or boundary (`-`) mark
-++%w(++`[<w>[,<i1>[,<i2>]]]`++)++:: switch line wrapping, like the `-w` option of
-			    linkgit:git-shortlog[1].
+++%w(++`[<w>[,<i1>[,<i2>]]]`++)++:: set line wrapping and indentation.
+	    Output is word-wrapped at _<w>_ columns, with the first line
+	    indented by _<i1>_ spaces and subsequent lines indented by
+	    _<i2>_ spaces. A width of 0 disables wrapping. Omitted values
+	    default to 0, so ++%w()++ turns off both wrapping and indentation.
+	    Newlines that are followed by an ASCII letter or digit are replaced
+	    by spaces to reflow paragraphs. Existing indentation is kept.
 ++%<(++`<n>[,(trunc|ltrunc|mtrunc)]`++)++:: make the next placeholder take at
 				  least N column widths, padding spaces on
 				  the right if necessary.  Optionally
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 06552a6271..5895780e8f 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -94,6 +94,12 @@ test_expect_success 'format %w(,1,2)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format %w(11)' '
+
+	git log -2 --format="%w(11) This is%n  the %s%n  commit." > actual &&
+	test_cmp expect actual
+'
+
 cat > expect << EOF
 $(git rev-parse --short :/sixth  ) sixth
 $(git rev-parse --short :/fifth  ) fifth
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 4be5c51489..0733f22d58 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1139,7 +1139,7 @@ test_expect_success 'log --pretty with invalid padding format' '
 test_expect_success 'log --pretty with magical wrapping directives' '
 	commit_id=$(git commit-tree HEAD^{tree} -m "describe me") &&
 	git tag describe-me $commit_id &&
-	printf "\n(tag:\ndescribe-me)%%+w(2)" >expect &&
+	printf "\n\n(tag:\ndescribe-me)%%+w(2)" >expect &&
 	git log -1 --pretty="format:%w(1)%+d%+w(2)" $commit_id >actual &&
 	test_cmp expect actual
 '
diff --git a/utf8.c b/utf8.c
index 96460cc414..bb55bf357f 100644
--- a/utf8.c
+++ b/utf8.c
@@ -322,6 +322,7 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 					space++;
 					if (*space == '\n') {
 						strbuf_addch(buf, '\n');
+						space++;
 						goto new_line;
 					}
 					else if (!isalnum(*space))
@@ -333,9 +334,10 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
 				text++;
 			}
 			else {
+				space += isspace(*space);
 new_line:
 				strbuf_addch(buf, '\n');
-				text = bol = space + isspace(*space);
+				text = bol = space;
 				space = NULL;
 				w = indent = indent2;
 			}
-- 
2.56.0

