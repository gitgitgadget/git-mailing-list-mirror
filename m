Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296247;
	b=fMfrAURqcuUo6G+1ER0v5RXRyW/4koDpkBiPThTxgcH8ui1/Hw18T3bUroDmS6no4aQQ
	 BP4+pirreZ2IobW/vo/4wyD27TNIbgMRn+fEKl1/6+wSccGbnCfO8aCRzv5QPT1JPECKR
	 lF22vyusSbEJk947WeGwCzidFV0LJstmyHAw7xucfR5bcW0AQe1YMy4PUdXBOCUeUdvSv
	 UXOJ3NCOQxH133B+cy3HWbnhPyJ/njifTiG57bhq6D73QuHZ+mJK///cTqAx/DllI/H+M
	 lcBP02/bTIlUx3OEaDlOQrZp/LhbeZ1T4baQlHnWJk7fR9sJVg7RV5/rSR1dJbhrCdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=SO8YdVtJ59WtrVckJs4Y+gfGI1+aG8xdfxxj2hgU/TQ=;
	b=mb+T9sZzmVkRy0Zi+Y5DrAd5KkY9L+xBd9t3L/LQIxR5jkk2ZxrGTP2x1mwFajFgkTyo
	 d2ap73V8DuoTuqGtg72yTTQBxuH15HteiVb+/yTDZzADIVUovJCRXbpvBVepNfns8ys8I
	 003hYWSIeHuPpI8byoTQBaqtgRVPRAcPqpZZh/cbEdE6VTJS6m33sELA3eM3EDZCCvBih
	 1MSGOLIPihpwtVfC0JdBh1taH6DzKzGBO5WiOzXXFwoowikMIbq92q3d8eUaPP00BY9qg
	 q8kdJFl6r8cVag7LiOPg6h++oUWRvRbvSAN4TlXaMQlmu3CiyK8KFRp91VWMx77atfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BPSY4ZUR;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5AC60A6F7C
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC5AC60A6F7C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BPSY4ZUR
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6e560e00a86so1050221eaf.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296246; x=1794901046; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SO8YdVtJ59WtrVckJs4Y+gfGI1+aG8xdfxxj2hgU/TQ=;
        b=BPSY4ZUR7tPKVu3j9Lhz2x4n3w3amdpNUnPVkVnUU4VjDsojsckyIWbblxXVPTOP0P
         ONrA01r7BZdkZTnQqnF9kdtluqtPhAVitRNQerCOTY629DVs9tg1NTD0HZw+wjWS9jo/
         GlTjPE6VPZ4wq35k/u75/t2fS0vaHhvb7lyzZDYgpdqrGmX2/5zUVbQ3gBKYmazy3P32
         yDrkE12++JoQJUThSTmGP2rGM7316DPdYLnJsZ7Liv/kXkpY6tc/+Qaee852Xn65JMlr
         rIgWBbVvtTZGFGfGYo3ZG18gRxHt21pFQnBkQfcouf/dQQ8MjE5VjkbF4Bmxnqz0KTJK
         +PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296246; x=1794901046;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SO8YdVtJ59WtrVckJs4Y+gfGI1+aG8xdfxxj2hgU/TQ=;
        b=jf+bqEdEIpvQFtO8g3GfqlBQ2QcSPK01zwEkjInfjknNCuDUNqckd7nMTwlrwmpg8x
         RwswQMs3IJICXrSOyXnzvYM/9W0Ln5t9OhTkOsQFfZ6sMRHIz2IFrOnVXYv6nZsq/hd4
         G909+PIg93pCribLLVaSP42sKMRnPCKkNL0pstoUnJY4IMp3/l/xVRezIWWUJdlf5pEy
         c3BSGufUdIeJkV4X1k6dbJ1h/4Ps6I3kzWiAxIVix8zc5AQuOQ5+VlhDwWMAB7r1klnJ
         raUMhSIgQb1z+k+44SEEUSuHhrsqqz59mwcjtYz/Xsrf8Qa9sT1OZdhpXqNjGUc6eZrx
         yD+g==
X-Gm-Message-State: APuU4Z+bkepZpXKqMOZmBhrACh3pzgwPP+2LtqC1G8+vbxXKxPck2BgP
	8CBgtGPTKz9SLFNQlUWfRFctqSrNi+H5RkED1/O+7Oz3cAn3Ggcd/7Tt+rI7VetH
X-Gm-Gg: AYBFou0coAXFT98zEgLeGxCMImO1PZ0CqymJgfQT+umoWuSszRo5gz3vabdVYKVO5fu
	z6KNBigc+zTTPGdU0SYhdbCW4GMEYWhdWipR83dwBjRuGYnlV3iICE58wTj4JCXFtraim7N/Ec4
	DwpgpyKrKUp/hZDpxUdI1F5U4SeTj21jMr/Oghtc5gqqqg1yKzn6W4zXnd2mQDYzhB+xpLGSUEV
	NWeMypbg/TW6gBvd7hrhK8WMegHH6v3d0NMkHtZoUTxNHjS19EQGZ7Xr51DxN0rzIqd+haMa8j/
	wTu4XKU70D4nuZJNlObVlv4Aiqz0iOySzXqhQbq7hVUd7OsVwn0dYj1MORaHZ6aIFPOb77+96+9
	IRtFrLu22cPCMI5p/KerJ/5yVTxKLWh9f/H00xrgCocN2gOKSIjaIxGDIiXm2165L1Rvthg6VSk
	NdZch4+XiNLIWp1lnbj82zPBzVsKjoNaSvwRVj6uNoqPqhfRyv8a9vjNhmOZbA1kZFUDM9g6DUg
	+sAAl5e89fvf9qL67f1xo4Il0QGNVjQiLtltIzQgErPbJfgnCslK/gXZ4fMyKhMuBo8BYTj7LeJ
	nDvYTpQ0NQevoIaeWmV0EaHCZrt2sUXqpGJVtsJ0N774nSRqEhDBbW8+
X-Received: by 2002:a05:6820:a64b:10b0:6fd:4277:16e7 with SMTP id 006d021491bc7-718a5766e9bmr602082eaf.23.1794296245684;
        Mon, 09 Nov 2026 23:37:25 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a94588d4sm1230773eaf.6.2026.11.09.23.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:37:24 -0800 (PST)
Message-Id: <12f841e5fff5cdb2686063fab69437655ec49b6f.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:45 +0000
Subject: [PATCH v2 15/15] config: handle NULL values when listing colors and
 expiry dates
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Jeff King <peff@peff.net>,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Colin Hinton <colinlewishinton@gmail.com>,
    Matt Hunter <m@lfurio.us>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Miklos Vajna <vmiklos@collabora.com>,
    Junio C Hamano <gitster@pobox.com>,
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

Since 2d4ab5a885 (config: format colors quietly, 2026-02-23) and
9cb4a5e1ba (config: format expiry dates quietly, 2026-02-23),
"git config list --type=color" and "--type=expiry-date" pass every
value to color_parse_quietly() or parse_expiry_date(), which do not
handle NULL. So both segfault when any key in the configuration has
no value.

Skip such a key quietly, as both already do with a value that does
not parse, and as "--type=int" does with a key without a value.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 builtin/config.c  |  4 ++--
 t/t1300-config.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 2554322317..f786c0b123 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -366,7 +366,7 @@ static int format_config_expiry_date(struct strbuf *buf,
 {
 	timestamp_t t;
 	if (quietly) {
-		if (parse_expiry_date(value_, &t))
+		if (!value_ || parse_expiry_date(value_, &t))
 			return -1;
 	} else if (git_config_expiry_date(&t, key_, value_) < 0) {
 		return -1;
@@ -384,7 +384,7 @@ static int format_config_color(struct strbuf *buf,
 	char v[COLOR_MAXLEN];
 
 	if (gently) {
-		if (color_parse_quietly(value_, v) < 0)
+		if (!value_ || color_parse_quietly(value_, v) < 0)
 			return -1;
 	} else if (git_config_color(v, key_, value_) < 0) {
 		return -1;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 8fb920b1ba..3322b0bf4f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2648,6 +2648,16 @@ test_expect_success 'list --type=color shows only canonicalizable color values'
 	test_must_be_empty err
 '
 
+test_expect_success 'list --type=color and --type=expiry-date skip keys without a value' '
+	git -c section.valueless config ${mode_prefix}list --type=color >actual 2>err &&
+	test_grep ! valueless actual &&
+	test_must_be_empty err &&
+
+	git -c section.valueless config ${mode_prefix}list --type=expiry-date >actual 2>err &&
+	test_grep ! valueless actual &&
+	test_must_be_empty err
+'
+
 test_expect_success '--type rejects unknown specifiers' '
 	test_must_fail git config --type=nonsense section.foo 2>error &&
 	test_grep "unrecognized --type argument" error
-- 
gitgitgadget
