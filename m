Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA73334C00
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 22:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001002; cv=none; b=MOzAmOK4wYW9cKWLQY38hD5k36dQzNg64jptdH1vUiqOZ4mi2LNEAu+xYo/NV8u5KEUSfZiTAhzb3ROUOAUaDzPaZx1gaf+TTqgAgXzZPfRUXrUoamux1wAmMHIMPvs4Q0yobbA4WcmTKTgf1Y6GXZZpe+06k6wS6x2xUdHJQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001002; c=relaxed/simple;
	bh=awCK1aZiur+ectvS/IgpFJ67Yhmql4QCCYWi8b09vFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VT04hoMh4LkU1rK8CFNZHH7a41Ul3rQlFylnhHcysRsRhO+iy1MSsyPcYMczQ5hnP9FZ1+ZdJzxEMuX3ycy4OCFMNjkwZjW1DsNwsg4uPyn+KGoG4a/EKK2YGfdKttt4siRy/bsqMdLYIdzPJsERBgzFDjRV4YS+rKawsw6hsA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNQ+6BSV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNQ+6BSV"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-474975af41dso1019215e9.2
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 15:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761000999; x=1761605799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8SGYBVeyzojizCDs25TooLy/kitMeKvblaMH29utvo=;
        b=TNQ+6BSVNDkpnXA36YUaBSt7TeW2Pamo2LOZTnIxIAYvucvsRt3DasxRx4Jbs3UVv8
         7dymowshhCd9nuyg73RykKfKknrzuEDAJ8Iyd3XnM7icQNORu9rXpDYIt5L4N9LfOtcz
         DpQMGYc1nVmsu5Up6F4ellQOkxFbwl31eQOrwwo4afUhu0i3jTmCtX+X0oXA+NuWWFK0
         uLragoKyS/istQe1Gf4FeWDYHdMCBG7bpSHhl8o46qwvzNhtz6GZ/32J728F6rjYAod5
         6I9Q/AvZLxjltj3Ue00pFgGQ9MhYIXe8jUwsoX+hUQokno6jrIs5eqg3izN3dqs+paKa
         l2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761000999; x=1761605799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l8SGYBVeyzojizCDs25TooLy/kitMeKvblaMH29utvo=;
        b=mWRSoF1ChkkfKdNRWdySx2ovVvK1/7Id530pVTD8TgSmxGAVCVrIllcEe9CuofW60Y
         xvsUTqJ4/aFope5nArqLvpAdhtCQqlbTtUdFMQZ7BcdqWkqoTE47mVyXWz8weDp9uZkN
         /sYKiZ1Urg5+JWr92c4Y5e9hOoc2VHV9Qww0KgfKmi72ppSLPFl8Cz/xtQ0Mo1dl+Pwe
         2gMSf2zql8/c7rJ10gxlVZ1Y5LjQbOxxm8dkEV88cziluVn8sX6MWuEaglFMFz+SH2tm
         IyZtYjfaOG3NSENldSS82rnRgIKJNlU40+6goeWOmtYUzzCusZvjDEsc/pMgq3JDjEBj
         GgPQ==
X-Gm-Message-State: AOJu0YyMK0BwxRlhQ9IYgmjitp/Yxrd1N/qWrYrf4Yb7HWWsuV80Sw8V
	X22IJEw6e4iIdWesz5JtQCETuU6g55k2XkZ5ZlOVaLiHMYy9uPvDo7DX
X-Gm-Gg: ASbGnctFMnLvWueoEbmFc9Kh9dfP91rdMk1NVqDqucpWdJ9XeJaH/AN5xh42MTGAjj8
	pAJ3E1KymdL0F7sAQkH0As13gQJW/y5aa8/txxXwHLQE6WbAdGRRcQvdn6tCPOU0GWz0Tl2FyXc
	j6+4HZviVmTWu1KLYoMF6b2bbZZvsOj2QOHYxIwieghVQ6jAS7T6G0ohv0aQb4mjewfSIyudYpw
	L84ZccVAsny5/DErNwCeQqofOzlIRzJRRMFQz0/YmEheTG4hfRaXI1NCwdWRf7z61rQqn1LzjnI
	ylOIBBqPO7dlUJmLKoMdX6r8Hjxfbi5RKDqQS8yriuGyzuZqQNiZAoAMzIc7h/OcyKb5atoBGBz
	doJWA2gsd/aNpS6j2RJNS09r8TfR3GNoh9q9h4ruZGUAtIu+ytUcHP4bMeGQJuQyBNQ==
X-Google-Smtp-Source: AGHT+IE3U8Py/TnKlgAb+yuZkB8zVegwoUpX0ypEmMzXcr+AfBvtelTcNxBETphTw9i2b+93zY5CeA==
X-Received: by 2002:a05:600c:a214:b0:471:ff3:a7fe with SMTP id 5b1f17b1804b1-471179123b8mr73554135e9.19.1761000998879;
        Mon, 20 Oct 2025 15:56:38 -0700 (PDT)
Received: from ubuntu ([105.117.8.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce3aesm17675856f8f.48.2025.10.20.15.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:56:37 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v4 0/2] do not use strbuf_split*()
Date: Mon, 20 Oct 2025 22:55:19 +0000
Message-ID: <cover.1760997183.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch series by Junio Hamano with link below,
https://public-inbox.org/git/20250731225433.4028872-1-gitster@poddbox.com/,
notices that the array of strbufs that calls to strbuf_split*() provides
are merely used to store the strings gotten from the split and no edit are
done on these resulting strings making the strbuf_split*() unideal
for this usecase, with the string_list_split*() being a more suitable
option in those cases.

Commit 2efe707054 (wt-status: avoid strbuf_split*(), 2025-07-31) for example,
in the series, notes that abbrev_oid_in_line() takes one line of rebase
todo list and splits tokens out of this line using strbuf_split_max().
However, no simultanous edits that take advantage of the strbuf API take
place but the tokens are merely used as pieces of strings.

This series continues on this cleanup, by replacing instances of
strbuf_split_max() with strchr() to get the required token around the
delimiter where the token from the split is merely returned as char *
and not strbufs and no edits are done on them.
This makes the code cleaner, faster and more efficient.

Tests have also been performed on the commits on Github CI. The link is shown below

https://github.com/git/git/pull/2076

Changes in v4:
==============
 - Use strchr() to extract the required token over string_list_split_in_place
   used in v3.
 - Modify commit messages to indicate the switch to strchr() from
   string_list_split_in_place() used in v2 and reason for prefering strchr()

Olamide Caleb Bello (2):
  gpg-interface: do not use misdesigned strbuf_split*()
  gpg-interface: do not use misdesigned strbuf_split*() [Part 2]

 gpg-interface.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

Range diff versus v3
====================
1:  7da4fded53 < -:  ---------- gpg-interface: replace strbuf_split*() with string_list_split*()
-:  ---------- > 1:  2879d9be36 gpg-interface: do not use misdesigned strbuf_split*()
2:  9a6eb6ff8b ! 2:  a830de15ec gpg-interface: use string_list_split*() instead of strbuf_split*()
    @@ Metadata
     Author: Olamide Caleb Bello <belkid98@gmail.com>

      ## Commit message ##
    -    gpg-interface: use string_list_split*() instead of strbuf_split*()
    +    gpg-interface: do not use misdesigned strbuf_split*() [Part 2]

         In get_default_ssh_signing_key(), the default ssh signing key is
    -    retrieved in `key_stdout`, which is then split using
    -    strbuf_split_max() into two tokens
    -
    -    The string in `key_stdout` is then split using strbuf_split_max() into
    -    two tokens at a new line and the first token is returned as a `char *`
    -    and not a strbuf.
    +    retrieved in `key_stdout` buf, which is then split using
    +    strbuf_split_max() into up to two strbufs at a new line and the first
    +    strbuf is returned as a `char *`and not a strbuf.
         This makes the function lack the use of strbuf API as no edits are
         performed on the split tokens.

    -    Replace strbuf_split_max() with string_list_split_in_place() for
    -    simplicity
    -
    -    Note that strbuf_split_max() uses `2` to indicate the number of tokens
    -    to extract from the string, while string_list_split_in_place() uses `1`
    -    to specify the number of times the split will be done on the string,
    -    so 1 gives 2 tokens as it is in the original instance.
    -
    -    string_list_split_in_place() returns the number of substrings added to the
    -    list keys.items, so we check that at least one substring is added to the
    -    list since we just want to return the first substring.
    +    Simplify the process of retrieving and returning the desired line by
    +    using strchr() to isolate the line and xmemdupz() to return a copy of the
    +    line.
    +    This removes the roundabout way of splitting the string into strbufs, just
    +    to return the line.

    -    Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
    -    Reported-by: Junio Hamano <gister@pobox.com>
    +    Reported-by: Junio Hamano <gitster@pobox.com>
         Helped-by: Christian Couder <christian.couder@gmail.com>
    +    Helped-by: Junio Hamano <gitster@pobox.com>
    +    Helped-by: Krisoffer Haughsbakk
    +    Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>

      ## gpg-interface.c ##
     @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
    @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
      	int ret = -1;
      	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
     -	struct strbuf **keys;
    -+	struct string_list keys = STRING_LIST_INIT_NODUP;
      	char *key_command = NULL;
      	const char **argv;
      	int n;
    + 	char *default_key = NULL;
    + 	const char *literal_key = NULL;
    ++	char *begin, *new_line, *first_line;
    +
    + 	if (!ssh_default_key_command)
    + 		die(_("either user.signingkey or gpg.ssh.defaultKeyCommand needs to be configured"));
     @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
      			   &key_stderr, 0);

      	if (!ret) {
     -		keys = strbuf_split_max(&key_stdout, '\n', 2);
     -		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
    -+		if (string_list_split_in_place(&keys, key_stdout.buf, "\n", 1) > 0 &&
    -+			is_literal_ssh_key(keys.items[0].string, &literal_key)) {
    ++		begin = key_stdout.buf;
    ++		new_line = strchr(begin, '\n');
    ++		first_line = xmemdupz(begin, new_line - begin);
    ++		if (is_literal_ssh_key(first_line, &literal_key)) {
      			/*
      			 * We only use `is_literal_ssh_key` here to check validity
      			 * The prefix will be stripped when the key is used.
      			 */
     -			default_key = strbuf_detach(keys[0], NULL);
    -+			default_key = xstrdup(keys.items[0].string);
    ++			default_key = first_line;
      		} else {
    ++			free(first_line);
      			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
      				key_stderr.buf, key_stdout.buf);
      		}

     -		strbuf_list_free(keys);
    -+		string_list_clear(&keys, 0);
      	} else {
      		warning(_("gpg.ssh.defaultKeyCommand failed: %s %s"),
      			key_stderr.buf, key_stdout.buf);


-- 
2.51.0.463.g79cf913ea9

