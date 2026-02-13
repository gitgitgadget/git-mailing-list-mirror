Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC35221F26
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993309; cv=none; b=nPhmgO0AQ+ujAkSvfRZ83/7wvzJ3v7bxNwDdsjrHholgPa//HtOJ7p9V8EqgiBayyLHajg2NkJBme38kIRYkXIbZ7LeuoaJ+PDHK49N5VYjuWl9V0aT44Pdxfu1tga3Cf4MHe1yP3Mq3M8DOo3/f249DeQO8IAD9lwgO+s0MKVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993309; c=relaxed/simple;
	bh=eYYbf2Fx9bx/F7NBONguUlzrSFkhd/ioraDgDAqlxYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7j3EdgQ9yfplZows5wK8lDxjTCa64AaO1tuyAwdTlaCJUA1XaY+AmJV0Yr7bbAKJgI2FpV2SkFWTFhthXEPK6/c5PAwMeKd1VetNEaV1VGEeFJCGMmfEocxszm7R4N4b4aHxmycXY/4Ac/KhdnmjTb8KSIvnx9KX7+hv9Kf5ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILteLd+O; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILteLd+O"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48336a6e932so6177585e9.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 06:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770993306; x=1771598106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=62ihkrQu9LB7XprCQcm5ZTWs10qtBK8XPnDPP2voSL0=;
        b=ILteLd+O8529nxT1fcUE46I2Yp/xsE2j4aVaUS3FK3FfDpyaNNFrjVz7O4XWT7FaXK
         m+PkxJozeRcioVoMwVZfvzGYUP2bhLRjjQFOLoC8Dju+IFCdhQhlY2xwJYyZW0tpIi+z
         u/2G8G12f1hZsBtupg2/A8+LKDRd8Ylpehfa35skdwvG1NeWKy+43JGPiIfzmYxXN8g9
         F7GBxGdjiB/qIFn7wkiDlyCdc5+VA+BYBnXiruXOW5ruUnCTz9RdBGQPVlz7n60D8Ajs
         +THYtIXCJayRIRpmu40dSgLVamjISWW/yD46/hbVnm3jZosA8IxE1Q1VSrzdewMcM0xW
         dxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993306; x=1771598106;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62ihkrQu9LB7XprCQcm5ZTWs10qtBK8XPnDPP2voSL0=;
        b=Ss9deOtxi7+O7b0UNWMWVH9Y5CgGSdh4Ofj1rbGgoaWiu9O1vrrrNbO0MnQhhApF+A
         v3Cn6yPxrfU3rO1gi9N6Pde7sQ7APNYC+iKZVykZL7Gp0DunK6g/d7OAB8jErQznYuIE
         bFGinZhVokTHWvcmhhnWy4wcx6FKH1GkUteqBor9DaW6mXZgBvRvNmRneqsQm5/lpfBy
         DSAtj4LFA0raxDZrm8JGgzsaqO8jYnweQEk4n2R3JXp6JWcBjwQagvZqMJ93fUECn/0E
         A1p07/YaVHS9nCBOWWNFtxDfBtqMMF9GNjXDnVshaiISOVc5ZSKlRAZjyeRgpmUvlpSK
         agvQ==
X-Gm-Message-State: AOJu0YzzBacwd/IUow6HLqOZ4pKzqYu7A9LTKEnW/8A/YYky6cr4QDWr
	gTPtILq7Luci3xrsslLzgK6jcgeJh75zLkj+owxMsw1kfDqZ4qSPx9P9HytE8cYH
X-Gm-Gg: AZuq6aJq1CDtEg7CsunB6QkDYb7cWQyRghCo174LLgYtKA1sUnnxXkd911z+KbvdaWy
	sVwYYGYntxaT36CHT/CEf10vksLIg4oSOvsdKiH9NCRHRluoR0QNfq6BjdiGgDz4vaDMBN1vUVD
	YEuPyD35JP9IcXISJmpAWsiNLzEe+/dXrpDDBxLEFpUgCXjqFwYX9cAinekBkf1HWAmSzUxk2ji
	knTatTZfG5LO0RStD8PzwmyumT4F6Qj4M2Oe7aeomrIuiLZhqVMuZR9Ib/wIwLamz2Z97dmluY/
	mz90H3QkUauu7giHcpgxXWzWR+6/aNI6Ez3o5kCYIA7UEVCuUZLxGR7xaQ+OB0Cf3FaeUZq9+Yu
	dJy0nR9WrMd+9FuAna5o4zUXcAxokPR5v7MRSOhQ0g0K4XygWx4MKZrdOZsPk0JXYT6se5TmXuH
	KK4okumz2ADLZeX2O0/hyjinFYGho=
X-Received: by 2002:a05:600c:1c22:b0:483:6de6:37ad with SMTP id 5b1f17b1804b1-48373a7b9fcmr32562085e9.34.1770993306297;
        Fri, 13 Feb 2026 06:35:06 -0800 (PST)
Received: from berwick ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e11f5sm257083905e9.4.2026.02.13.06.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 06:35:05 -0800 (PST)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Matthias Beyer <mail@beyermatthias.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	pyokagan@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 2/2] templates: detect commit messages containing diffs
Date: Fri, 13 Feb 2026 14:34:49 +0000
Message-ID: <494f4df6865f81eba42584ead81327c9a305d0d4.1770993281.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
In-Reply-To: <cover.1770993281.git.phillip.wood@dunelm.org.uk>
References: <20260206090358.GA2761602@coredump.intra.peff.net> <cover.1770993281.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the body of a commit message contains a diff that is not indented
then "git am" will treat that diff as part of the patch rather than
as part of the commit message. This allows it to apply email messages
that were created by adding a commit message in front of a regular diff
without adding the "---" separator used by "git format-patch". This
often surprises users [1-4] so add a check to the sample "commit-msg"
hook to reject messages that would confuse "git am". Even if a project
does not use an email based workflow it is not uncommon for people
to generate patches from it and apply them with "git am". Therefore
it is still worth discouraging the creation of commit messages that
would not be applied correctly.

A further source of confusion when applying patches with "git am" is
the "---" separator that is added by "git format patch". If a commit
message body contains that line then it will be truncated by "git am".
As this is often used by patch authors to add some commentary that
they do not want to end up in the commit message when the patch is
applied, the hook does not complain about the presence of "---" lines
in the message.

Detecting if the message contains a diff is complicated by the
hook being passed the message before it is cleaned up so we need to
ignore any diffs below the scissors line. There are also two possible
config keys to check to find the comment character at the start of
the scissors line. The first paragraph of the commit message becomes
the email subject header which beings "Subject: " and so does not
need to be checked. The trailing ".*" when matching commented lines
ensures that if the comment string ends with a "$" it is not treated
as an anchor.

[1] https://lore.kernel.org/git/bcqvh7ahjjgzpgxwnr4kh3hfkksfruf54refyry3ha7qk7dldf@fij5calmscvm
[2] https://lore.kernel.org/git/ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org/
[3] https://lore.kernel.org/git/d0b577825124ac684ab304d3a1395f3d2d0708e8.1662333027.git.matheus.bernardino@usp.br/
[4] https://lore.kernel.org/git/CAFOYHZC6Qd9wkoWPcTJDxAs9u=FGpHQTkjE-guhwkya0DRVA6g@mail.gmail.com/

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 templates/hooks/commit-msg.sample | 54 +++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/templates/hooks/commit-msg.sample b/templates/hooks/commit-msg.sample
index b58d1184a9d..f7458efe62f 100755
--- a/templates/hooks/commit-msg.sample
+++ b/templates/hooks/commit-msg.sample
@@ -15,10 +15,60 @@
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
 # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
 
-# This example catches duplicate Signed-off-by lines.
+# This example catches duplicate Signed-off-by lines and messages that
+# would confuse 'git am'.
+
+ret=0
 
 test "" = "$(grep '^Signed-off-by: ' "$1" |
 	 sort | uniq -c | sed -e '/^[ 	]*1[ 	]/d')" || {
 	echo >&2 Duplicate Signed-off-by lines.
-	exit 1
+	ret=1
 }
+
+comment_re="$(
+	{
+		git config --get-regexp "^core\.comment(char|string)\$" ||
+			echo '#'
+	} | sed -n -e '
+		${
+			s/^[^ ]* //
+			s|[][*./\]|\\&|g
+			s/^auto$/[#;@!$%^&|:]/
+			p
+		}'
+)"
+scissors_line="^${comment_re} -\{8,\} >8 -\{8,\}\$"
+comment_line="^${comment_re}.*"
+blank_line='^[ 	]*$'
+# Disallow lines starting with "diff -" or "Index: " in the body of the
+# message. Stop looking if we see a scissors line.
+line="$(sed -n -e "
+	# Skip comments and blank lines at the start of the file.
+	/${scissors_line}/q
+	/${comment_line}/d
+	/${blank_line}/d
+	# The first paragraph will become the subject header so
+	# does not need to be checked.
+	: subject
+	n
+	/${scissors_line}/q
+	/${blank_line}/!b subject
+	# Check the body of the message for problematic
+	# prefixes.
+	: body
+	n
+	/${scissors_line}/q
+	/${comment_line}/b body
+	/^diff -/{p;q;}
+	/^Index: /{p;q;}
+	b body
+	" "$1")"
+if test -n "$line"
+then
+	echo >&2 "Message contains a diff that will confuse 'git am'."
+	echo >&2 "To fix this indent the diff."
+	ret=1
+fi
+
+exit $ret
-- 
2.52.0.362.g884e03848a9

