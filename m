Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296218;
	b=Gzl57BIh5fMJwDKXdhoLGxubx2PUVLpo1lrNBI/1Arn0fEsPSUH2IhhB/+ZAPQZVMylS
	 /mgK1f8VaIGhI6h3Je2bpQKlR8edc8xiMlWKpwrvcKiQ9+DJgVg1p7TP04gl+Hn91fkjM
	 5O4BH5vH7yR+/f0tj8m3XoAhO6/VFzT2vBSv/y5l674rXmPzR42JRTrhwmOWZYZjOgVmG
	 xbk1/dPKxDiBCVecbgNxAvR4903DoR0xd9UZmblJK49oit0ERVMV5XgJ9i+iBEDyEGOkp
	 +kUO3J2NwF1cfcvCs7E/TVDaa61exQZjufoUeSr9TTaNG6+aA66RWG7eZ46+5zLJPVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=RDXTSRorkwwGKpfGvPjIEs9FY39cF/2a0R5Y5rHIouk=;
	b=gV7WpLJzkOxnOAvxGP3+le7z2HEhz/DgQhGKB0ik1ZXDGehgfGDLreBi2ur6hkLZfzUZ
	 nbFVM5f/lbqMmAo7NswZxbQNEcTxh1SztYFIXzNJbRQnLPAYYRt0hzn6q0YK1lRNj83TM
	 bTCoQ4897nNbDuOTqEDcW42jXiXDkPUb9FIw15xlUiF9TpioIhjtn5rynvKMByskkF1ZM
	 jXucb66mfPqTIf0OTZj2YXemtYRqUuZlGNIyshNyA7MhJerpYZQpjz46g7sciJExIR8qJ
	 +wqtOakn3aNtmx1fJ5okwWW6o9L5tXqYe7Z6LkRNAxeTw2j+w3UR5dvqaa3VdgM/eSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U2sle67i;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634460A2637
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 07:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E634460A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U2sle67i
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4f48d91ba7dso930139b6e.2
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 23:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794296217; x=1794901017; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RDXTSRorkwwGKpfGvPjIEs9FY39cF/2a0R5Y5rHIouk=;
        b=U2sle67ib6l4AxR+gyOqAvKaAL0sv9qaKCSc5+i3GE0YwbAKoL2FPERw05RXk/GP2o
         PymPE1qrogz3tg4SuzswUIotZIOUFziGTYeaQGyVCFhJ62XdaU8vmn23gTCp2U5rI7hD
         jDmr+miZS9JRjzM7VwC7GFuiUhwj2O1LEzXHOSbVdGRv4zsTmP3UPvTFzziO7qDHtjAU
         vOYdsm5ynn+ezQmjn5j9YczegMemVZE8iA+/bpFC2/UjUGPLxmvzsjJmxh7lN/X/m+DP
         6TpmeaZxtcKYggR/CK39l1OQlKTMs5cwk9Hk74JvXIjX8nIMIPFpKszVmwCAKADYxqUe
         iTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794296217; x=1794901017;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RDXTSRorkwwGKpfGvPjIEs9FY39cF/2a0R5Y5rHIouk=;
        b=1E/jA9aPGeZpvPe0A9z6GM2PvhNrHGrn7JXOrKN3QlR0am5rVafIK/OUn0TZ4x6yB0
         5nAaAdVny+gABWiQDsbD7IFj5BeaiLKc9biLaz8xIAZCsP5q+sQUr0e4fNetLOoQ8kQj
         zSHxlYR/uP7l1W05LIL9DeMnmOB20/kn3oit5Rtu1bNLPMbACVxsFcoag97sydTTjzQo
         t3VF8MwsTkPqrY2526TFdS9mZdvFtBaLPqTFuZwN6oDmAUR01onWZeYXuTjwOuvuQWnx
         gHPKxFmmpbTF/6Ic0fkTSM37SWykjxmr/uqYOpVU8ayCH55cS+vv5wKN2bbPq3COb64p
         p6GQ==
X-Gm-Message-State: APuU4Z+WJZk2JE8QMSQwsJOCnxq5ENe1sQ/M/oaVPZUnMuCF1EqBYtC/
	2EAZW58tVQzAOc/lrSfOWLhumGywtxbs5ayOc0qhvK1wz2tVdCh4E1jz5WglpBrN
X-Gm-Gg: AYBFou2AZ+45gzcE/VRfEEoBdwz4tILA8P8Js1DQI2awd9dSAKAXEGAGI8rbu0cMQLk
	mocOGSWO4VczS5SzKftUKZeVNmXg3FCilcjtWpE6hHgMGMAQE+rShh/YGhRpLRb3Qw9isjrV5d/
	wcFqx93mYIl+xaJEeHzW+rw7xiXJiewvKOMntDlp8h6IeHGGsVWF1EBQrRTqOsT/A2RPW1CSUHO
	AqmAFFeUzWD10CzOEJv547rh2kYGVbniYKSy/mBW8t8efRjerLQx+Gb1cSIdZ4so3ZKkvAcS1c2
	Bzrbry9ti7w4WAAucQlUQ/yaNsfvo5e2GaWhRcQheSschJZ4Ovd48Hdu5gdF9Xy85A8Slmwb+zX
	qK0SVpLvt2eq4Pn5gpQ3OeYTF7OIKCEHyUwWTQXGrs6EsG0sNQvYrQWLNXP4HrMqRkXkJcCZrHO
	LPAmZ2SeBjwGBYLe51EH+bUYO659AH7PksHKeFsoAKzaxllaIY2RwivPP3u4e8T6iw8iF1+dec4
	ZggTrpqkLMPmW5N/loHAmPX9SU9Boq52BIBfK+vHbC+NDqvV1ajx8d37SZ1CCHOYMi8srRtry0o
	nky1lIiltAlhGV9ummaTSU1fL1vG02MzNdE=
X-Received: by 2002:a05:6808:308b:b0:564:3fe1:2fad with SMTP id 5614622812f47-5683ccb51b1mr1482208b6e.42.1794296216769;
        Mon, 09 Nov 2026 23:36:56 -0800 (PST)
Received: from [127.0.0.1] ([135.119.111.130])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905738049sm1571927b6e.10.2026.11.09.23.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 23:36:55 -0800 (PST)
Message-Id: <d3fd6290e0e07285cc8133b5cdbfee424ba0037d.1794296205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
References: <pull.2297.git.1794040967.gitgitgadget@gmail.com>
	<pull.2297.v2.git.1794296205.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 07:36:33 +0000
Subject: [PATCH v2 03/15] add-patch: handle NULL value for color slots
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

With color on, a color slot without a value, such as
color.interactive.prompt or color.diff.frag, makes "git add -p",
"git add -i" and the other interactive patch modes segfault:
init_color() passes the NULL value to color_parse().

Read the slot with repo_config_get_string_tmp(), which rejects a
missing value with config_error_nonbool(), as "git diff" already does
for color.diff.frag and the other diff colors.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
 add-patch.c                |  2 +-
 t/t3701-add-interactive.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index f27edcbe8d..ad581eb4ae 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -295,7 +295,7 @@ static void init_color(struct repository *r,
 
 	if (!want_color(use_color))
 		dst[0] = '\0';
-	else if (repo_config_get_value(r, key, &value) ||
+	else if (repo_config_get_string_tmp(r, key, &value) ||
 		 color_parse(value, dst))
 		strlcpy(dst, default_color, COLOR_MAXLEN);
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 6e120a4001..33050ccc53 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -815,6 +815,18 @@ test_expect_success 'colors can be overridden' '
 	test_cmp expect actual
 '
 
+test_expect_success 'a color without a value is rejected' '
+	git reset --hard &&
+	test_when_finished "git rm -f color-test" &&
+	test_write_lines context old >color-test &&
+	git add color-test &&
+	test_write_lines context new >color-test &&
+
+	test_must_fail git -c color.interactive=always \
+		-c color.interactive.prompt add -p </dev/null 2>err &&
+	test_grep "missing value for .color.interactive.prompt." err
+'
+
 test_expect_success 'brackets appear without color' '
 	git reset --hard &&
 	test_when_finished "git rm -f bracket-test" &&
-- 
gitgitgadget

