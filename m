Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB94923EA8F
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 12:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760875766; cv=none; b=ZRRNehL0Kk6s0j2aC59S3juojWayZW/ZCft/XRIHen80nXmC8gN5wTNLDZc+Sj6ZcIfO/j7DI2ZRPgvsKfNxPLIfcLjmRF+7ItywmIk1pJDfe1wy9x9ALstpQN74dwSjnZYAS3xHTm+45dQ8X6HXXFJPOFGW2F/FdKs4RlGI0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760875766; c=relaxed/simple;
	bh=EiyC0P7lQwaWlQDxB92JShTgg5TFWlwikrc6yFwSo9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kr/Uy6BHKAn/G3u0Wi0pIoUnQqD8mQmXych/w2lPvjYykYyYMp9C4jeU6+5PHhGvOgOByk6fpJyEN2fL+SXs6+z+YFHhzi/soi5rT3lCz/ZxLNwuwiGXW6t2tpooE9z65b+zm6MUvtIIijUJKukGhHoVMulLKuaYSdost6dZ67Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PngipKYN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PngipKYN"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4711825a02bso20180525e9.2
        for <git@vger.kernel.org>; Sun, 19 Oct 2025 05:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760875763; x=1761480563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6Mw567viNXiG8ZWPG2a591mZeo+QSy7zQlmoNEe4Mg=;
        b=PngipKYND7sZ7hF6ao7Xt6QmpZqSqJfhdDZC1abkhwAI31HCChdQYjY6pyPk5lB0xX
         f2exCu7VzrQJkl2JyRThU/ZdMgbsrjfcr4iUdiwi4HfKkt992DQ2KIlUUL8fHMip6Oi/
         2KBKqtNSL6Jyr3nrCaBXAf8oGSjaw6744+uC5KcPVzwY2I7wtrfLF0uEx0eRn6YTOdGc
         zUpHxuGnDf5tZDjxdUPGe4MmOnyE8IEujXo2cBlBH2j8FTNglUVta0/6+Z7i36xvrCtw
         Iql960hyu9Ywp0O2Vt5IGoc5cLXrTHOTnM+1x0tpMlYfKslHo8l6zB/K6dLsQ+uRDQKu
         F1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760875763; x=1761480563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6Mw567viNXiG8ZWPG2a591mZeo+QSy7zQlmoNEe4Mg=;
        b=eeOE4OCf7owobr8X/NSw3WIuU+61uzxpW3sO6yYAyefp610/qdKwq/utrweKiQavfu
         i7CRXX2y92ccb9zgm9TQJmmJhm4OU1cHVvcvMsQuFKSce4wsLXrJTmNM4fma+dT03rhm
         joyz3LNoFm2SWazq2cgL4RjTLI14LSw7wvpA5A/Pb1av2CX7E0+ejeUaTDQUlqt+KUVX
         0aq8OT4ehA3sWszHS3vcd4OT4hLp50rQRkIjRmGoB4ICgHDEoGBACcddQiHk5FjNQu6f
         TXUpti+GelO8UiIz5F8EHDZYG3ivG9vUdHggLappGwYQt+EJzdemKE/lCXEEeXZzTYtE
         aizg==
X-Gm-Message-State: AOJu0Yw4uPs59Wih8dcNDHqRl5K97DIPLRc0OMo6N0aRsyhQoLbhSLTW
	TPE3jCp602DIXoKrFUrYZdkZz3kTp4A+ESoyXHnUC8eTgiQyJGiPtPJE
X-Gm-Gg: ASbGncvUGI1cWStpug50nmBiCsf+pljehQCZQItVLXHJ3kUwVWhMnNB5RQMxJ5GNhGu
	JPTb701qK+jgN3tHF0ylF3jVXfPeJGOxW0lOxTyu1WB+NiO0ugsQ5KvoUhV8z34xeVXllBDqREP
	3kqMSHJirUGDzR2EGBMT5dCc3LqdwJT3HClcEmJ7eA/H3XV/5PT273/+1rGqbNDlRBdC+Prb1jP
	U3TRBoyFYVKg9NswHGVDYZmhHYIekzs9nHte9O7HIZ1TtacDVTaOAlnMl+xCwyszGRKz8mUK7ap
	P3Pac6KytJpx8gLcU6/OLV9fUMuiDFsoLiOBOkwVT32DOpizw604kGrH3IYodw93Z4mXQp2n7eA
	3oAUoNa8K+BKKRdtBcdydZWJwkWCoPEZrZV+akbIAoHaHQFHLji38J/RQ6RIZzJIR5+a8
X-Google-Smtp-Source: AGHT+IHWC51WOQLXf9+TW61lmv9g0DRnC3gX/6//fxjenSvt5OoRLAGEttmdAwjdJunwWyDIK1qTrg==
X-Received: by 2002:a05:600c:3541:b0:471:16b1:b824 with SMTP id 5b1f17b1804b1-47117917452mr73342725e9.28.1760875762876;
        Sun, 19 Oct 2025 05:09:22 -0700 (PDT)
Received: from ubuntu ([105.112.227.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471556e17afsm90172145e9.17.2025.10.19.05.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:09:22 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v3 0/2] gpg-interface.c: use string_list_split*() instead of strbuf_split*()
Date: Sun, 19 Oct 2025 12:07:41 +0000
Message-ID: <cover.1760869186.git.belkid98@gmail.com>
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
option.

Commit 2efe707054 (wt-status: avoid strbuf_split*(), 2025-07-31) for example,
in the series, notes that abbrev_oid_in_line() takes one line of rebase
todo list and splits tokens out of this line using strbuf_split_max().
However, no simultanous edits that take advantage of the strbuf API take
place but the tokens are merely used as pieces of strings.

This series continues on this, by replacing instances of
strbuf_split_max() with string_list_split_in_place() where the string from
the split is merely returned as char * and no edits are done on them.

Tests have also been performed on the commits on Github CI. The link is shown below
https://github.com/git/git/pull/2074

Changes in v3:
==============
 - Use string_list_split_in_place() instead of string_list_split() used in v2
 - Change the test for the return value of string_list_split_in_place()
   in get_ssh_key_fingerprint() patch 1 to at least 2 tokens in the split
   list to allow a successful test where the key owner's identity is missing.
 - Change the test for the return value of string_list_split_in_place() in
   get_default_ssh_signing_key() in patch 2 to at least 1 token to allow for
   a successful test.
 - Modify commit messages to indicate the switch to string_list_split_in_place()
   from string_list_split() used in v2
 - Add explanation in commit message about the test for the return value of
   string_list_split_in_place() in both patches
 - Add Helped-by and Reported-by tags

Olamide Caleb Bello (2):
  gpg-interface: replace strbuf_split*() with string_list_split*()
  gpg-interface: use string_list_split*() instead of strbuf_split*()

 gpg-interface.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Range-diff versus v2:

1:  818ca6b104 ! 1:  7da4fded53 gpg-interface: replace strbuf_split_max() with string_list_split()
    @@ Metadata
     Author: Olamide Caleb Bello <belkid98@gmail.com>

      ## Commit message ##
    -    gpg-interface: replace strbuf_split_max() with string_list_split()
    +    gpg-interface: replace strbuf_split*() with string_list_split*()

         In get_ssh_finger_print(), the output of the `ssh-keygen` command is
         put into `fingerprint_stdout
    @@ Commit message
         The string in fingerprint_stdout is then split into 3 strbufs using
         strbuf_split_max(), however they are not modified after the split thereby
         not making use of the strbuf API as the fingerprint token is merely
    -    returned as a char * and not a strbuf, hence they do not need to be strbufs.
    +    returned as a char * and not a strbuf, hence they do not need to be
    +    strbufs.

    -    Use string_list_split() instead for simplicity.
    +    Use string_list_split_in_place() instead for simplicity.

         Note that strbuf_split_max() uses 3 to specify the number of tokens to
    -    extract from the string, while string_list_split() uses 2 because it specifies
    -    the number of times the split will be done on the string, so 2 gives 3 tokens
    -    as it is in the original instance.
    +    extract from the string, while string_list_split_in_place() uses 2
    +    because it specifies the number of times the split will be done on
    +    the string, so 2 gives 3 tokens as it is in the original instance.
    +
    +    string_list_split_in_place() returns the number of substrings added to
    +    the `split.items` so for a successful split of the string in
    +    fingerprint_stdout, at least two items should be added to split.items
    +    so we can always be certain that the substring at index 1 is the ssh
    +    fingerprint even if the key owner's identity part is missing from the
    +    string in fingerprint_stdout.

         Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
    +    Reported-by: Junio Hamano <gitster@pobox.com>
    +    Helped-by: Christian Couder <christian.couder@gmail.com>
    +    Helped-by: Junio Hamano <gitster@pobox.com>

      ## gpg-interface.c ##
     @@
    @@ gpg-interface.c: static char *get_ssh_key_fingerprint(const char *signing_key)
      	int ret = -1;
      	struct strbuf fingerprint_stdout = STRBUF_INIT;
     -	struct strbuf **fingerprint;
    -+	struct string_list split = STRING_LIST_INIT_DUP;
    ++	struct string_list split = STRING_LIST_INIT_NODUP;
      	char *fingerprint_ret;
      	const char *literal_key = NULL;

    @@ gpg-interface.c: static char *get_ssh_key_fingerprint(const char *signing_key)

     -	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
     -	if (!fingerprint[1])
    -+	if (string_list_split(&split, fingerprint_stdout.buf, " ", 2) != 3)
    ++	if (string_list_split_in_place(&split, fingerprint_stdout.buf, " ", 2) <= 1)
      		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
      			  signing_key);

2:  024a44a242 ! 2:  9a6eb6ff8b gpg-interface: use string_list_split() instead of strbuf_split_max()
    @@ Metadata
     Author: Olamide Caleb Bello <belkid98@gmail.com>

      ## Commit message ##
    -    gpg-interface: use string_list_split() instead of strbuf_split_max()
    +    gpg-interface: use string_list_split*() instead of strbuf_split*()

         In get_default_ssh_signing_key(), the default ssh signing key is
         retrieved in `key_stdout`, which is then split using
    @@ Commit message
         This makes the function lack the use of strbuf API as no edits are
         performed on the split tokens.

    -    Replace strbuf_split_max() with string_list_split() for simplicity.
    +    Replace strbuf_split_max() with string_list_split_in_place() for
    +    simplicity

         Note that strbuf_split_max() uses `2` to indicate the number of tokens
    -    to extract from the string, while string_list_split() uses `1` to specify
    -    the number of times the split will be done on the string, so 1 gives 2
    -    tokens as it is in the original instance.
    +    to extract from the string, while string_list_split_in_place() uses `1`
    +    to specify the number of times the split will be done on the string,
    +    so 1 gives 2 tokens as it is in the original instance.
    +
    +    string_list_split_in_place() returns the number of substrings added to the
    +    list keys.items, so we check that at least one substring is added to the
    +    list since we just want to return the first substring.

         Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
    +    Reported-by: Junio Hamano <gister@pobox.com>
    +    Helped-by: Christian Couder <christian.couder@gmail.com>

      ## gpg-interface.c ##
     @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
    @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
      	int ret = -1;
      	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
     -	struct strbuf **keys;
    -+	struct string_list keys = STRING_LIST_INIT_DUP;
    ++	struct string_list keys = STRING_LIST_INIT_NODUP;
      	char *key_command = NULL;
      	const char **argv;
      	int n;
    @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
      	if (!ret) {
     -		keys = strbuf_split_max(&key_stdout, '\n', 2);
     -		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
    -+		if (string_list_split(&keys, key_stdout.buf, "\n", 1) == 2 &&
    ++		if (string_list_split_in_place(&keys, key_stdout.buf, "\n", 1) > 0 &&
     +			is_literal_ssh_key(keys.items[0].string, &literal_key)) {
      			/*
      			 * We only use `is_literal_ssh_key` here to check validity


-- 
2.51.0.463.g79cf913ea9

