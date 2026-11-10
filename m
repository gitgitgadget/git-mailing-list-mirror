Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296242;
	b=mHVtnsGGTf01ckVTu/r5uHRvuoJ57lM8B1UEPeq+Ro4bQzu6T+3p7d4A1w7WYONjKYnj
	 K5SjAPKp6fkBr8lLKHKT0ScAHl6sDBZfIh5aAcVwcYHJbIEHyqEfOxGW9Lkt6XTJGkOyn
	 sq0JhtoVY9Zb45VVDx1EsBgMrwwDM7vV3y17oQ0E66+R8t6DncA+6zZLGWiz/8S72BHsv
	 xA31NgrEnpTNIG53Yi6w8oZqOSzeNIq/wWdznbX5P1fo4BLEjQZ887BxyeWD1HoKJ7vX7
	 myzUsGmF6OZuohLXn0pIa+gdL1TP3tYemW+JcPKTubv+LN3vPbWTZyY17wV2n15AEkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296242;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=z4HRt/fY+AjTL5JrfkABTWbQy+5v2lKCnRPwfdiyyIo=;
	b=3kGfPDBvO9V3F6o84CY01lZzb06GYgSinAb1B20t2rJZQzQ/r48X+jvSxnwrAM5cIA7w
	 hc+M4e3wbwGXXobs6NB7XMv6m2a278KDDGOmjlOcK0rW/stII/1zvyGrEbOKSBazgcBEM
	 iKgbrqDGCase+ZpEJ1TAGalqZRJTLzmLJh9SbQxtAlMUI/8osnSILiQDbgAYk002kWICz
	 8IU9fhU2L5JXoSONvPkeJVjLa74anA42+tHRVj46dm8l3QgznqpZiHvO/aZq7Zc8Mt0Mw
	 6mfsGRBePUcYlXyx1gxbJeVdCyfr8NzHZPxvA7yddrBuXl/iWDCobgGNFe9EIottcZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ta0h85K2;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232A60A2615
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E232A60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ta0h85K2
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso989172eaf.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296241; x=1794901041; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z4HRt/fY+AjTL5JrfkABTWbQy+5v2lKCnRPwfdiyyIo=;
        b=Ta0h85K2uSiJmWAqY1fqnSOHZVcyCuXar3ybmaK+aDNm3dXg9WuWsSxCkkX6/+s1sl
         +Milg1zDb8lu4BBCxtekCuqs7XWJk1NyV3x4M7+iuFZdEo0uX1+wSIE8wC8DLZaDnlbC
         YwXeDGz2ciJN1aKXKwtiEtuezeNY6fwTSb0CR2HqruVLZbmY1OKOJ+QUs1U9Z2/Vxhyh
         6aphObNpDuuseGW0HFe6dACmrVPszoubZ4txu2Gsar8abM6SQB6KaBAujaR15gd1iKLx
         UT2ixmGzU+DCRHlbrLTPWKYyOqe3cRqr5Ppzh3Ih24OVkwAIU9SGsbtyNDyFJ7xO3sC0
         LjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296241; x=1794901041;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z4HRt/fY+AjTL5JrfkABTWbQy+5v2lKCnRPwfdiyyIo=;
        b=2fcKcoiZm9wNpItA3tzJm2FoPAfdIhroVIdFaFZ/Xkxy5DLw6ti0ZNXBF4ciagV++t
         i+6MjTkyneXnXqDD3I7R+XE7T7JMk1DpSBRcYBh6yTEdXqHu6D/ehafdsp9T11S2ngGR
         TF8cnLvL608R9XhBTaZ1+l8b5+A4+WFyEeMiauCN9zSbVpru6/I3JmZbvMwTWTzFMSRE
         0hA/aktyyVkLCCIUbQkwRBJW05E6s82BhCN8Qnw6i3LcpnBlgkkzIi0/zuVNQAcFu22L
         6/0eYcgHKUV0Vc+kci1x4Ur4+eOAWpfhXH0FmB2WfWr16Ebf/AM4FjsPg0x/248dN3dS
         fH2A==
X-Gm-Message-State: APuU4Z/JPs60b+RBCcmCtCPBzZZvXMOWQVkiXNnMhqjKGTerrKEM35CP
	iAGPkEIN4LMFrgvFBuscFW1b9YGJmiar5Ow0+WeUbje/SrKMFv+2MZxHKW32CYGm
X-Gm-Gg: AYBFou0r3pSECnT6a5pW8Dc3dNjx0YfE/w23FOrJHNluPdesWo6q+blPDMMiC93RNc9
	NC/YBxEsWsbdhbG9Q2TY5vL3RFt8CfQsV8hR44ycLYnik56gIBg5qodiT/lqx3iGK/4D46SjUTd
	HUcUTevRTG+aOjw7q1Q5/WV4Fgd2XJy8OuOz6UbU3MUqDXD3IPUZz8zS6o/GTZXjZM0fetKNAbY
	qkof80qSuWYTM/zj7AWay1HkiSc7LhTg/E0r5u+UqZyIaHWFXGWaSZhmmYRnJEv6W5GrZ6k4HQ2
	yXArnoABEZcdZ2cSIBKktSNI4+Va+tnug+w7de8cWTb1iGwwtDijWkF6FsoPqARRb21h+HkEuix
	y5GhC6lBwojgQjzkDVYH+X1TbxNZw0T5DF6M0Chk6vKpNn3SN79Hgm21qOU36Xi+VCsvuFXzL9m
	w8PDG/nhBGm279HqEkBs06wR5YupCBkrNYoxJzmtzdInaUgRB4G8EcRmcJmeLihL+CvIflROKEJ
	sIK5IFUfNBQpQ3+GB59F6bI8h1xPX0RoWWpQltzfcQIlPa71q+zW0j+SdqQ3yaDiUwTAmhI01E4
	nuAMz1Ihf/N5IKZYED15/RdRm4hg+Y6B3RA=
X-Received: by 2002:a05:6808:c123:b0:4d6:92b3:5c8d with SMTP id 5614622812f47-5683ce289fbmr1297414b6e.67.1794296240819;
        Mon, 09 Nov 2026 23:37:20 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905f2faf5sm1446596b6e.13.2026.11.09.23.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:37:19 -0800 (PST)
Message-Id: <080106d5ea21d3e520dd28772435dcb32918c0a3.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:43 +0000
Subject: [PATCH v2 13/15] config: handle NULL value for remote URLs in
 hasconfig includes
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

When the configuration has an includeIf "hasconfig:remote.*.url:..."
section, a remote.<name>.url without a value makes nearly every git
command segfault, "git log" too: add_remote_url() passes the NULL
value to string_list_append(), which copies it with xstrdup().

Leave such a URL out of the list that hasconfig:remote.*.url patterns
are matched against. It cannot match a pattern, and wherever git
reads its remotes, handle_config() in remote.c already rejects it
with the usual error. Commands that never look at remotes keep
working.

Assisted-by: Claude Opus 5.5
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 config.c          |  3 ++-
 t/t1300-config.sh | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 5976a418d5..5b823b3dcd 100644
--- a/config.c
+++ b/config.c
@@ -342,7 +342,8 @@ static int add_remote_url(const char *var, const char *value,
 	if (!parse_config_key(var, "remote", &remote_name, &remote_name_len,
 			      &key) &&
 	    remote_name &&
-	    !strcmp(key, "url"))
+	    !strcmp(key, "url") &&
+	    value)
 		string_list_append(remote_urls, value);
 	return 0;
 }
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e3f8064889..8fb920b1ba 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2970,6 +2970,28 @@ test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url in such
 	test_grep "fatal: remote URLs cannot be configured in file directly or indirectly included by includeIf.hasconfig:remote.*.url" err
 '
 
+test_expect_success 'includeIf.hasconfig:remote.*.url skips a url without a value' '
+	git init hasremoteurlTest &&
+	test_when_finished "rm -rf hasremoteurlTest" &&
+
+	cat >include-this <<-\EOF &&
+	[user]
+		this = this-is-included
+	EOF
+	cat >>hasremoteurlTest/.git/config <<-EOF &&
+	[remote "valueless"]
+		url
+	[remote "foo"]
+		url = foourl
+	[includeIf "hasconfig:remote.*.url:foourl"]
+		path = "$(pwd)/include-this"
+	EOF
+
+	echo this-is-included >expect-this &&
+	git -C hasremoteurlTest config --get user.this >actual-this &&
+	test_cmp expect-this actual-this
+'
+
 test_expect_success 'negated mode causes failure' '
 	test_must_fail git config --no-get 2>err &&
 	test_grep "unknown option \`no-get${SQ}" err
-- 
gitgitgadget

