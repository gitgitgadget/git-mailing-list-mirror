Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416275;
	b=sxHlXjKgDHzWcQCQL8L3m6hk+ri0kL/j22HIMb03W57fVQl2GVUjxYz4qorj+Yl9W622
	 leSK6j4rLStKiZfb9Qffp9BehtgfDW9dfo1fmbWdq4g8RcZirNMUiQGeyba4qmhu+1UAR
	 YweP8F3BsnLT544kLxLg/IRmOBtIwfZmDep/2IdryUCBwtT9vgnUP4deU7LfRSBBnFnvX
	 yK20Zf9JFCIFaV+7XmTtjOzAHsTaYCJijTc/QcSSdzalPfGI/XTVUl5NXudJv3y3PJtbt
	 G3ijaniJkLXUMgNFNGpiFazy9JnXwOLdiP3qSig7y3EgR2Bq6J4Sgb53zD4O0rgXQNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7kjE/oArxzIsWRKWThe4iIHJGqcxU+ycqy0hWSeMhbk=;
	b=u37bmkXCa8kEceN96lqqNdWuQLUSGwkvTdXbogaYBCzI8Lm5OC5pWRUIiNYKWaQqrqhJ
	 aHr7PlODWBOFxwYeThIJDi9sduA/hJRhzFWQzjbO4S7NYlkofsmCIbV2ExbH8EaOqobok
	 ownwjTQIa/PeayQ0Wx0ja5UIa98vwrm1LOX1P7RjBc9NfmXW/54E7wlBlYFWAh6FP93XN
	 gOOUgFDJcBWtDYQrpKhV2Wc7SIHzxpjBj1XnI9mE4xjNRkri7MGfj+DN2L66X1UzlI2R/
	 BwfSgf6soOG8Flb3HLWBAN3gSn1unK7/DqjPa6Z9DOaJIQad9/PTJrPIkq8FASNNeNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fwLzawep;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0306606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 06:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0306606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fwLzawep
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so2131125b3a.2
        for <git@vger.kernel.org>; Sun, 22 Nov 2026 22:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416274; x=1796021074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7kjE/oArxzIsWRKWThe4iIHJGqcxU+ycqy0hWSeMhbk=;
        b=fwLzawepmMsrZRLUDTuX02SEEtqeqZWCk4SxVomZOPqYIUEzHj4DNk1NEpUpU6Eq0d
         xa/f2n9/X8P3yafSjIedhTcaL67WW/zzrf322A9O4UfsiaWILYuSMKwrT5uUmhC3JrIn
         XPZvcd6/Ar1KvG4+1UoJP+NB7zBfWgwsikE4vbBZuwGVlY2+p08F1Mg4Gwy2XNrJRqCB
         PrszN5sY8VbFGImJjG2V2TM7PoMnCeC8LucgmKGLSswwMl/qMMpjaUJRDqH0A6ofyOHe
         uI4w0exyKZ11jLSPrAqBtJhShR/pueUhjLtRkUomyfQrt8JNdllMW1o2mY7pqMKCADVJ
         1FgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416274; x=1796021074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7kjE/oArxzIsWRKWThe4iIHJGqcxU+ycqy0hWSeMhbk=;
        b=jdzFtErKRUcMuxe7G/x+obY9mCl8tVfW+O2nja1mWrc75OALEIxbSgkc/380NgGW/V
         jvOYNDGILa/Dw+mXk3SRekv7E1oCGp0uZcbLwqsrWpyTyn3JYtEPGJJHEk/Aq7Jki/Vc
         2CuuaAWcXCcHn9p/CFWm+fSgh6bDcIJaDmRP1GmY2uEFSZsTnFBHKM42RN2lUHCQxUUA
         lnnuOmM5n0hN5WLzv16JvvE8+5nnW84S5SctomgOwj0056D1NybD9/Fzxske4LDWGRQR
         US4w0kJLGa7YqaXXjTZgfsK7tFvFoWblySZ1RXzPY8g59/G1Ms019hWZL/LoLfO1Yg+q
         M1ww==
X-Gm-Message-State: APuU4Z8skvrXlX9+kapp4k2d1FbtSFuO7SxjgrZ1z1nMghCKNOkwSYnq
	tSDnCwn0ZVWfqsNHucxhvoZETKfsDiFS0WyrrPfa1atttQRgw6K8+uajPYRRv37M
X-Gm-Gg: AZFdTZcAirLzrN3B332CmcWpB30opLqYo1bwO4Xr08xco7+PJZGlJ0MVVvSTRReU670
	wUPk3ctvNcYqZKnX3gvXuosulo9MN0UTyzKdnlTGt9pnymc+r8BRWLXz9n+tnIPY+utYiBuqlno
	/LgM4OUUtSY0sRmR6ThdUJ+SosEI76tZnvgm+ORTazTs5kD0nJxH9A+/TVHPa+iyqeY/NmExggM
	XxK6vzRT3mdCUG9HmBJggYCbnJMxjOP+LDoyO/1dnLUofyWlopJgIj//FhRyiZs+QqA0orExCnp
	pZyvxTq7Czwv25h9xmwcBf4h1XvfVvZl7F9QqHocNjH2hfkLG9qEsIXzyVb5Kk895sEjNQ2wb0t
	l5NkOeTSPPG4ylsCt3G1hohbU0ZjDNO+4bvNPZGvqnt6y6ST8/b3afkUU0cngAGUbtspKCWKE7E
	y0D/PwGsEzQbEvZEEUwCA0BvhCvo6uwyYOCV4JxK72fQa8dsjiHYRRgaZc5jU0GvIIv7c9Gtyhe
	NjE9Ft5GSN0gscHcd8FJylG81DNbwJ6UHHyIocDNatdG1SZmtDnNRS8AvvQZjpR3vwi57wTCArc
	9WSX7q4/5gc0fKDasQMXVrXkjQDYtit3uk4yxXTehW5Yw2KDXauHETQkVGq7Hf/FQ47XZWrDo6M
	AoNoQrsAB9M9PJV2NjRM0
X-Received: by 2002:aa7:8e0d:0:b0:8c9:4ad:abec with SMTP id d2e1a72fcca58-8c904adb5e2mr6089711b3a.29.1795416274141;
        Sun, 22 Nov 2026 22:44:34 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873c1e2f3sm4798671b3a.54.2026.11.22.22.44.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 22:44:33 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 2/3] remote: name the original URL when relative_url() fails
Date: Mon, 23 Nov 2026 12:14:21 +0530
Message-ID: <e2c5464356520ee4c8474b9cacc6b02323714b1b.1795415793.git.aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1795415793.git.aniketgupta3001@gmail.com>
References: <20261105152842.566318-1-aniketgupta3001@gmail.com> <cover.1795415793.git.aniketgupta3001@gmail.com>
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

When relative_url() cannot resolve a URL, its error message does not
name the URL it was given but what is left of it after some "../"
components have already been stripped off. With a base URL of "./a/b"
and too many "../", it says:

    cannot strip one component off url '.'

which does not help a user to tell what is wrong with the URL.

Name the URL that was passed in instead.

Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
---
 remote.c              | 2 +-
 t/t0060-path-utils.sh | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index be561d633e..ee10c7a003 100644
--- a/remote.c
+++ b/remote.c
@@ -3176,7 +3176,7 @@ char *relative_url_gently(const char *remote_url, const char *url,
 			if (chopped < 0) {
 				strbuf_addf(err,
 					    _("cannot strip one component off url '%s'"),
-					    remoteurl);
+					    remote_url);
 				free(remoteurl);
 				strbuf_release(&sb);
 				return NULL;
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 56faf5fe73..0d16b2c884 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -394,6 +394,15 @@ test_submodule_relative_url "../" "$(pwd)/addtest" "../repo" "$(pwd)/repo"
 test_submodule_relative_url "../" "foo/bar" "../submodule" "../foo/submodule"
 test_submodule_relative_url "../" "foo" "../submodule" "../submodule"
 
+test_expect_success 'relative_url() names the URL it was given when it fails' '
+	cat >expect <<-\EOF &&
+	fatal: cannot strip one component off url '\''https://host.example/a'\''
+	EOF
+	test_must_fail test-tool submodule resolve-relative-url "" \
+		"https://host.example/a" ../../../../../../x 2>actual &&
+	test_cmp expect actual
+'
+
 test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c" "../foo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar" "../sub/a/b/c/" "../foo/sub/a/b/c"
 test_submodule_relative_url "(null)" "../foo/bar/" "../sub/a/b/c" "../foo/sub/a/b/c"
-- 
2.54.0 (Apple Git-157)

