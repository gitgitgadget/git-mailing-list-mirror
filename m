Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80AD33CE8F
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 23:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771026929; cv=none; b=u5oBIwaztYg0S7iZhdcldfjxe93/xgexp4eIIjhq7PMdKg5jAb0QffmJuHWACFYaKlxcOO8lI9QoHjeZZCk3jpgG5octbcnSjhCOHQy7r7DmNe1NrqAQBeaAEjZjdtbRQyIm11kDWQwuYHRuK4zSxMDnVUlWdHwE+3jPv5EpN7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771026929; c=relaxed/simple;
	bh=70A6YBudIZBZBzIXOXg8Cr31tyo110WUz4FwxhaB9sY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Lofjm1mdPSNjSriN5HTxq/5sLkS/LarSJWGGe446AO78t8sJ1N529pfE9AUk8e2eYLpWA86FA5b+wSz4hZIiN9SjB/Y8Xwx4BJPeWLekkEHgTuvKtNOM23rdbspTQNnpyNRkc4H+HIgjMvmIUHpGOC89Re/d6fQuIDUdn3ALCxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU2/J/Vz; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU2/J/Vz"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8cb20bcff5aso149155685a.3
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 15:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771026926; x=1771631726; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MsQ9WonvSdIhgTnancCeB/FTbBPOpFWsiKgRVH4QQQ=;
        b=TU2/J/VzPYysBUb+SwyjQ6i953p1Yv3kSZX2wF7vDvrZUTM9rfPNJm0Be4HQKEEv8W
         A8bVeeuekmwJHSOMIA6DpkrRhIHUTu/uh7eJLy4OUeDCuHblQwDtUw7kmKMt5RPSAT1U
         6lNOBvZmD3a5j/uTEZ9L/tpDLxVKDlJyeD9UScX6V2wyIKVeNiIWARJVCtbtDEWnkzCL
         44D4Yb/1hKE4fsNcZ13g0cyn4Z13arrNryL0IKWFtHoEL8iFQkCeiWpHjwY4mWtEOfDv
         1Gdyi54c7b1FbbmPml3Od5yp+tvRZfTHnXtvxEjKRZ1L990tWXMQkqBoTxJhRUfX9/3l
         z/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771026926; x=1771631726;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1MsQ9WonvSdIhgTnancCeB/FTbBPOpFWsiKgRVH4QQQ=;
        b=fuvbUxEwOaFNJtOxGGa0+O/jVrap0DgFi9MM+9pMaUd+GvFXDWZPVuzQFfcdLjz/6x
         zJ7/75MpZUUdrkvN4rxyvwKMAhJfIruOZxHL5iGocethNzPUOp2ULd4XBTGlMkyC5y5W
         aXs8NkRgEAEs1ictoGuJKWFnK/ECwJbR87ptwCyX+RaS6WwUv5gso71tKF4MLJCz5b3S
         o76lysfg6nCb7xKChLboYJ5AzjhjqmKu52dQ19kQaQoLmVckMYDrkjSTHatqNFxt78Vl
         DOMce+4iiWG7IOTASzSULZvNURCuv0VvkQ+rvIyBg++b++NkOjXgipL2FI+61gF3JwQG
         VLJA==
X-Gm-Message-State: AOJu0Yxgl2p5IWVTN3s7VxnYXnaym8XBVWUymMm+btEd5YEdeFX9QO8e
	CEWPp9de6hurm0yjAzXvg9mE9LOXD3uP6jy51bner4257ytrvbtOlkJjGzR9/6B6
X-Gm-Gg: AZuq6aLefs3OmEwxf1joKoJJWRqXJWd0Czvy25bcTCQwdByJL2Gziq6k3ADTbpZU683
	I82PU0+Q33CynvNrKoDq5Y7R/Xdp4ESs7MSgNrFqV/omhKskFSeW5ZOcvtdYOibjL8hnYkPN7ts
	a9U5wVjPr7+VaXAcSRQyq1W9pPIdtLPKBF1oX50EcPTqtvlaITjRmexBhPWG7263XdxkbV05LIi
	modGGYCz5YxqmF8FicHzFHLJHt36hPrB5dlwLuL2PlfkGAk3tV0TFCxmsy0f7zgBDbMp+JdgsC0
	YkZKwJ8g40ZLwv3db1I7Ahq9redgKVNO8RacRRzBQlxO2z1zWlhM5ZpBLVibgnxwtwYFrjZYpLf
	2vWxIh9WzGIG3AfKMrzXxmgeUSNPI/PS/Npkp+KAHu/IrAuD4P7keYZ0jFx+PLFTPXSxVNOn6u/
	FFBiyyKj2wxP2j6Tck8Mc0bUta
X-Received: by 2002:a05:620a:2807:b0:8b2:f191:2b3a with SMTP id af79cd13be357-8cb42428be2mr445001085a.53.1771026926063;
        Fri, 13 Feb 2026 15:55:26 -0800 (PST)
Received: from [127.0.0.1] ([145.132.99.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb45f13a61sm189274285a.7.2026.02.13.15.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 15:55:24 -0800 (PST)
Message-Id: <6d2a48a3b7f61c068392e66933caaf1d78055857.1771026918.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
	<pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 23:55:08 +0000
Subject: [PATCH v2 03/13] config: make 'git config list --type=<X>' work
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
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Previously, the --type=<X> argument to 'git config list' was ignored and
did nothing. Now, we add the use of format_config() to the
show_all_config() function so each key-value pair is attempted to be
parsed. This is our first use of the 'gently' parameter with a nonzero
value.

When listing multiple values, our initial settings for the output format
is different. Add a new init helper to specify the fact that keys should
be shown and also add the default delimiters as they were unset in some
cases.

If there is an error in parsing, then the row is not output.

This is a change in behavior! We are starting to respect an option that
was previously ignored, leading to potential user confusion. This is
probably still a good option, since the --type argument did not change
behavior at all previously, so users can get the behavior they expect by
removing the --type argument or adding the --no-type argument.

t1300-config.sh is updated with the current behavior of this formatting
logic to justify the upcoming refactoring of format_config() that will
incrementally fix some of these cases to be more user-friendly.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-config.adoc |  3 ++
 builtin/config.c              | 35 ++++++++++--------
 t/t1300-config.sh             | 70 ++++++++++++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index ac3b536a15..5300dd4c51 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -240,6 +240,9 @@ Valid `<type>`'s include:
   that the given value is canonicalize-able as an ANSI color, but it is written
   as-is.
 +
+If the command is in `list` mode, then the `--type <type>` argument will apply
+to each listed config value. If the value does not successfully parse in that
+format, then it will be omitted from the list.
 
 --bool::
 --int::
diff --git a/builtin/config.c b/builtin/config.c
index b4c4228311..4c4c791883 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -318,21 +318,12 @@ static int show_all_config(const char *key_, const char *value_,
 {
 	const struct config_display_options *opts = cb;
 	const struct key_value_info *kvi = ctx->kvi;
+	struct strbuf formatted = STRBUF_INIT;
 
-	if (opts->show_origin || opts->show_scope) {
-		struct strbuf buf = STRBUF_INIT;
-		if (opts->show_scope)
-			show_config_scope(opts, kvi, &buf);
-		if (opts->show_origin)
-			show_config_origin(opts, kvi, &buf);
-		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
-		fwrite(buf.buf, 1, buf.len, stdout);
-		strbuf_release(&buf);
-	}
-	if (!opts->omit_values && value_)
-		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
-	else
-		printf("%s%c", key_, opts->term);
+	if (format_config(opts, &formatted, key_, value_, kvi, 1) >= 0)
+		fwrite(formatted.buf, 1, formatted.len, stdout);
+
+	strbuf_release(&formatted);
 	return 0;
 }
 
@@ -872,6 +863,19 @@ static void display_options_init(struct config_display_options *opts)
 	}
 }
 
+static void display_options_init_list(struct config_display_options *opts)
+{
+	opts->show_keys = 1;
+
+	if (opts->end_nul) {
+		display_options_init(opts);
+	} else {
+		opts->term = '\n';
+		opts->delim = ' ';
+		opts->key_delim = '=';
+	}
+}
+
 static int cmd_config_list(int argc, const char **argv, const char *prefix,
 			   struct repository *repo UNUSED)
 {
@@ -890,7 +894,7 @@ static int cmd_config_list(int argc, const char **argv, const char *prefix,
 	check_argc(argc, 0, 0);
 
 	location_options_init(&location_opts, prefix);
-	display_options_init(&display_opts);
+	display_options_init_list(&display_opts);
 
 	setup_auto_pager("config", 1);
 
@@ -1321,6 +1325,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
+		display_options_init_list(&display_opts);
 		if (config_with_options(show_all_config, &display_opts,
 					&location_opts.source, the_repository,
 					&location_opts.options) < 0) {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9850fcd5b5..362e580604 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2459,9 +2459,13 @@ done
 
 cat >.git/config <<-\EOF &&
 [section]
-foo = true
+foo = True
 number = 10
 big = 1M
+path = ~/dir
+red = red
+blue = Blue
+date = Fri Jun 4 15:46:55 2010
 EOF
 
 test_expect_success 'identical modern --type specifiers are allowed' '
@@ -2503,6 +2507,70 @@ test_expect_success 'unset type specifiers may be reset to conflicting ones' '
 	test_cmp_config 1048576 --type=bool --no-type --type=int section.big
 '
 
+test_expect_success 'list --type=bool shows only canonicalizable bool values' '
+	cat >expect <<-EOF &&
+	section.foo=true
+	section.number=true
+	section.big=true
+	EOF
+
+	test_must_fail git config ${mode_prefix}list --type=bool
+'
+
+test_expect_success 'list --type=path shows only canonicalizable path values' '
+	cat >expect <<-EOF &&
+	section.foo=True
+	section.number=10
+	section.big=1M
+	section.path=$HOME/dir
+	section.red=red
+	section.blue=Blue
+	section.date=Fri Jun 4 15:46:55 2010
+	EOF
+
+	git config ${mode_prefix}list --type=path >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
+'
+
+test_expect_success 'list --type=expiry-date shows only canonicalizable dates' '
+	cat >expecterr <<-EOF &&
+	error: '\''True'\'' for '\''section.foo'\'' is not a valid timestamp
+	error: '\''~/dir'\'' for '\''section.path'\'' is not a valid timestamp
+	error: '\''red'\'' for '\''section.red'\'' is not a valid timestamp
+	error: '\''Blue'\'' for '\''section.blue'\'' is not a valid timestamp
+	EOF
+
+	git config ${mode_prefix}list --type=expiry-date >actual 2>err &&
+
+	# section.number and section.big parse as relative dates that could
+	# have clock skew in their results.
+	test_grep section.big actual &&
+	test_grep section.number actual &&
+	test_grep "section.date=$(git config --type=expiry-date section.$key)" actual &&
+	test_cmp expecterr err
+'
+
+test_expect_success 'list --type=color shows only canonicalizable color values' '
+	cat >expect <<-EOF &&
+	section.number=<>
+	section.red=<RED>
+	section.blue=<BLUE>
+	EOF
+
+	cat >expecterr <<-EOF &&
+	error: invalid color value: True
+	error: invalid color value: 1M
+	error: invalid color value: ~/dir
+	error: invalid color value: Fri Jun 4 15:46:55 2010
+	EOF
+
+	git config ${mode_prefix}list --type=color >actual.raw 2>err &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual &&
+	test_cmp expecterr err
+'
+
 test_expect_success '--type rejects unknown specifiers' '
 	test_must_fail git config --type=nonsense section.foo 2>error &&
 	test_grep "unrecognized --type argument" error
-- 
gitgitgadget

