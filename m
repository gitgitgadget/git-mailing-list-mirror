Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437386;
	b=5ZPutfDdBh2e78IkyPMYX3eAKne+Zwr6hkU5RhgTJ3mvVXjq/5hA640PkwM4jf9JocAh
	 ieZYdzAw/etAEv95dws9zwHPlQm6u1fGuiREW03+7a26fBew5HHoxD4i00jyVvl6J7Jvx
	 pAAVLA3cM75e9GWrYsxENGI1somiGjIBYPGF17DV+/lFAGhdCWMIdCMURFvC8R7ufg/Zl
	 mXL1rF3EsGs9zB6Aewv3+O7brxSMjn+9PZfPrID5pBSrzQz9Dqi22zHTMBW0/cNTV6fyW
	 4vT8aJ5FWULGZ7WHDvoKjidOsMC/RGkHIL/WxGNmM46X81dOFG64CMBlU2RTJvnrUOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437386;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=z4HRt/fY+AjTL5JrfkABTWbQy+5v2lKCnRPwfdiyyIo=;
	b=RjeJbTRLL3DiGkCangEA9/LaAXpW0NtOLPXEGpPlgi5nYtE5bm34xXWoC+yrkOAS169s
	 F5vNnNtR86peS6TtK75m3UwNtqJnzd96PV6qMvRsvsEk88czJHCRATe5qXPM9TfexompP
	 Snu5+reqla/9/Ku8/G5pNj/V1a5hag3+qggEPe+phiBKBiaC7bflijeQCrtzqOp3XFeUE
	 RFY69WVHnV1h5sOT8PJ0YxMWT70A+H4bhKSoKOmPZzrHvv6vYM/5eA/zfZ9FRwP7wpP7+
	 mZq9E0y+G+bGXeKhqPlVkKUP3qpBJMlNpxj82NFMvWluPK2mnIxtZzUlMqIhep7S8ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bnead8AW;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AC160A3801
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36AC160A3801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bnead8AW
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6deb848ddd7so2272511eaf.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 14:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794437385; x=1795042185; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=z4HRt/fY+AjTL5JrfkABTWbQy+5v2lKCnRPwfdiyyIo=;
        b=Bnead8AWSPoC4v2VswBL3vWtCk9aCMioj9Ypu4VDOc8P9+Gar3ZF3+w4+534qRH5iz
         fcvEfLHtEhC8ffYCzBj1ny52k73Xys8Zwftl89NGt8I6l4dM6EWA5UcDuiw/Z11k3h5k
         90cITGtBO49xl7k/w5LJ8vSJiBUaxhMHFA6ehW8+qglC2fE0tGj6pJFJozx38SNT/I2W
         faya2mSGx5kPOXsNj40MqUXaGarWVrfwpvFoZ5RmCkhgaFBkXRGnsnB7Asf7Bx2AIQ1f
         Zyc6pBOfTT/H06ppaF5pB3Aom8qBdlk12WIAzsM+J3wN4JlrbVbi7nOlROzpTSbmbRcG
         PUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794437385; x=1795042185;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z4HRt/fY+AjTL5JrfkABTWbQy+5v2lKCnRPwfdiyyIo=;
        b=0guLyYIbgAfqSIm+FUJVPjukViLSQWfGHTfSGHiCVymDuby7fB98XXbR1ZStm4tE3Q
         is5U1M8JNGb6Gmlh2i7+esGz1Alq6lpnvd/UlWBmh4/rpcldsonZq2wjUUEBmDvmM6BI
         ohJ/7NaRZISEz8R6Ct2rXKfYfhU3sBe9E1ku2mGnhXhDgStVs/KEfDBzo1+K7R/EIs2D
         K3IjkQX48RT+urdBfMzDsshUWfc4Ra8X1P7KlIBDsvphTWHvRe8TErVqnvOGJKbek7aY
         LI8Z+uMV3ZUWFPTDMQQtchxb3pLUe1oai5ysIy55YXEkUkbD1y1gU8EDjTSQOG4cnEOT
         wQpA==
X-Gm-Message-State: APuU4Z95ZBTDUSg0FZBgLP3dwbxqfIx7enlIlxSkdZOtLnt/rXHqD5H6
	Hca3ebpwcdoqSUZzJZGZX7+u8N8OaXdjwWiFlwTUJtB7PLRJlGHKNzbqUsTnbo46
X-Gm-Gg: AYBFou3TfENNTlni76ZavLDwxHrcj5uZYH8/a19M8ZdoTW+tStWY7V7biug903ZErcU
	0Zm06mKuEShrhcyRaty0k5OvdDTy3EhhaRZB49kSKnjmWgkOu6YfQ56Pc5TYW8nxPujRnZh8wOl
	LfbgmOhUyzt6+bbSC7oe0/pgkL4+speNSEdGFad4iK+dN9eB6eW87cXUGsJhtf0bwV4k7UC6qyN
	mfBRqgrRhz6i4TyEd0rVZ+fPOM0iI/yiDyLkypPLyBU5srjP8qsMfdBewnNpgPTnp/LGFjaBQP9
	xBfMTXr8yeETC57SgR3c/Z69NxQSwNBV4bLLaPOD25whp7Q+HhUkLeFJoMmYjdSycHa/mfgWhpC
	SlPAV8f6PKs+KLTSmg1gJgIf6M2BKPfFBpBsRKZFzPNO8/VZPjkCAJnsg9OSsHVYAbNTbylLZpu
	sEdvpiINLB+kOfxpf/oX4WCpIYIgScJ0uISWNP26MNLhJYF71EaybA/Ti5HdM3upFkgUzAhMx7p
	b8uhj/wWbelR+Tq62NNnC4YiQHGw9rgKMznXSL39/vsgQDW8w3unh5613w7L6XMdXmMnRtSwiBr
	zx2y04VtWN77Sex1DjKBJ2w/mDUJEHwWxA1LjZvH8QuRFeSNgrL2fiEV
X-Received: by 2002:a05:6820:c2c7:10b0:703:c2a2:cca5 with SMTP id 006d021491bc7-7191796833dmr1979949eaf.82.1794437385042;
        Wed, 11 Nov 2026 14:49:45 -0800 (PST)
Received: from [127.0.0.1] ([130.131.199.169])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-718a94588d4sm5179146eaf.6.2026.11.11.14.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:49:44 -0800 (PST)
Message-Id: <4d5d2ce04ed4ffe1fdaa38cb1a9481b7239bf7e1.1794437355.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v3.git.1794437355.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 22:49:13 +0000
Subject: [PATCH v3 13/15] config: handle NULL value for remote URLs in
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

