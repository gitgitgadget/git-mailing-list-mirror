Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632939;
	b=MTcmnjn5TPZ0guSzG0scGv/yOi+HwL+ykQyop3n56L2o+eDYfUrJs65TSnIbGcCppCZm
	 7n7wlFebVhzExUweWS1jbk95T53fiyw3utHr00vODedswMeN3p962uHnM50F/SfUJhT0I
	 A9PSruqgb8QGb57L9BylP4XVuvW08wR23SrcP453Db6Ozc8ggXXhaVETBmNnhSFaqlNto
	 gahGG74wX6h0FqYwMoCAcddLmXUnGdY8hblyo+HjToWCrm0RpXzACG9SThzlDkL+8DuJ4
	 iDoCk2qWSdCxW7rC5KklS0jYnRidAz18CDhe5zAWTlwBLN8m6BIuC9sySVhDtMClGVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=5mZovQZGpN31BlV+9MF/22gQPa+Lhr/ATGpQVj6z1m4=;
	b=oagBFZT1Ul8VuDSASL0ZJdeXLeYL5Jg4SpGP5HTjLlrSeY1UKhkv3yf5QXuxtgHk7F5F
	 DtfwIpmLO4V9hmzaYJF801MIiZPferyg3znGZDGkfPptWixjMTkc9GqoA135LhXGH/Mpc
	 x7T34qhq8Gda/iDd/tKbBsERnAJ/PTGnVYu1+bRiVX5003jtK+K3tseX3WtsKZRet1/rr
	 ridLT/NDeOTGjkWoH0g02DZLpvzoewDs/wCA/UvroZXnIlIefQPQ7AuMY1tzprkKPXnTc
	 nyOuALfwx5UsRO9W34R0NAo7SufYHpxvloaBCkUsIwPBK414OS9/Ut4sAQSNBy7lZzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="a6/jtW/C";
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4C4606A321
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F4C4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a6/jtW/C
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55d3563e50eso41359711cf.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 10:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795632938; x=1796237738; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5mZovQZGpN31BlV+9MF/22gQPa+Lhr/ATGpQVj6z1m4=;
        b=a6/jtW/C541HGY4KKB12A5093vHvMKO2ybD2pNzkbPKHZXE+qhSpJT/SXkN1QM3LxP
         Ii/G/20+A+0iIFIZYQPSORxwXudOTYMwcTjM7P9MuL3j2eL2h5UI5mLOsOgt5mevugVw
         76LmimqRm2OpidwwHxcRA1eV7rbgA/huADfg5fqtVDJJZyDRmlDa58Fxz6wW+JSMcw4c
         Bkel6azcSOJepsQlZm2rgsYwZHWc+jCuz4SRt69e3lJLMdrzOvHQ0J08p7h5dbL74f1J
         R41kFxdMbFWA6QSZUtqUm5/rqs0H+ejwld46b2pnrWmB8t68iPGkQnVtfZJCbffPeFqk
         9+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632938; x=1796237738;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5mZovQZGpN31BlV+9MF/22gQPa+Lhr/ATGpQVj6z1m4=;
        b=aFX6QcphyevwSoX6VyNINAU0Epxfzxd8pvU9JyY+9woDMcjwcgtZGbLSYOyc5pRyDh
         3+2EUa5egHRk2Rq1ALTj/HiYk0XA59zvjkIoTOLUHRanL71PDYQhvIKC9iJoXBrdU4G0
         /dc2aSTEfNtjKXFywcW5msS2s5mtYadYQ/0NILlV600Ck8KweMMmyjpBo2Dnptsh4prY
         1TAOHRmh/cSgQVHu30mjW0THCCXFynDgtVWBRIasXpAQ1wJ6kfV2vJPQ5toiPm/8UtDT
         ng6pTQO1UvyeG4/RUmaTCHACLMogXqSjVMDxlIdE6mVytfJHTkxV2p6mjSGK9BEDRnjE
         sIpg==
X-Gm-Message-State: APuU4Z+YMcoSZ/cBYbhJF6dfANUC3ZpgLcClWX69eMF7v60f7HyR6uRl
	rfknVZI+yPZ86i+dv2DJi4/JTpSgKVxeVXzgPVqhlggyYTedltfl1baOhpgOqRiq
X-Gm-Gg: AZFdTZeQJTAtNYlD5+U/hEgxm8BBUo0AKgUqq2H+y0ydgMnTByNtw91kj7snric/i4W
	1DUUyOOSSh8/Q3yP5qQqPetWmJQgrIERPYgtrA5HGth3VN3oPmjb+pL7mpLousTKZlWgoZbINVl
	rRh6fdxIu2aJbKAlE7arI6v60g7nbbafLBCcKXry6W83mYrTBfvHVb/MgQ+ly46n0L6MI/WmHsL
	3QRBnYCNPkdhNIubtjpSCo7+NAdun5m+0v4275DtFCQTqQRx+4MvJ/q2GhzjMbfjebFv1HM8qNc
	fcdzWsaQ2/+rCiFz969kHz97t3+Yz5vCXrg+yEqqbn+KbPjg3s4sDadgZ1SulBh5OnU6ez7XsnL
	TCkUhRGEItkxlzXMVTGmJMvNmkgCy3FaIZeOHf+DreevU3TKblO/3sNJuhPQHCWcjv+QpONRSpO
	2x5Jfdt2RDxsV0I2H6Z4K/HuI57PBX0TZqE1FmoWXrb1qpFXrAv8uXTz1RM10qEyR9hqxoYLYfJ
	9n99BEKcpn8NLnDAzp0qWcTFd9GBcBO/1BMoX4Ubb0OpmoYUkXU/UvIQ9TbB5/bElxh7blj7RnD
	AUHAZRgKTny5lZrDyFjckkwlze1tUtaJsQ==
X-Received: by 2002:a05:622a:1206:b0:55d:2ac6:29ab with SMTP id d75a77b69052e-55d76aa6486mr366661671cf.54.1795632938531;
        Wed, 25 Nov 2026 10:55:38 -0800 (PST)
Received: from [127.0.0.1] ([20.228.220.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882e2d1sm162403081cf.14.2026.11.25.10.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:55:38 -0800 (PST)
Message-Id: <bc1e30f6d05cf3e724a454e4c922a33f34c5a55c.1795632934.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2429.git.git.1795632934.gitgitgadget@gmail.com>
References: <pull.2429.git.git.1795632934.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 18:55:34 +0000
Subject: [PATCH 3/3] remote: reject invalid branch names in add -m
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git remote add -m" only looked at its argument after the remote had
been created and fetched from. A bad name such as @{u} therefore got
as far as a network fetch before failing with "Could not setup
master", leaving a half configured remote behind.

Check the name up front, so the command fails before any remote is
created.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/remote.c  | 8 ++++++++
 t/t5505-remote.sh | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index b04cbe70b6..35c6a1f7fd 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -226,6 +226,14 @@ static int add(int argc, const char **argv, const char *prefix,
 		die(_("specifying branches to track makes sense only with fetch mirrors"));
 	for (size_t i = 0; i < track.nr; i++)
 		validate_tracked_branchname(track.items[i].string, mirror);
+	if (master) {
+		struct strbuf ref = STRBUF_INIT;
+
+		strbuf_addf(&ref, "refs/heads/%s", master);
+		if (check_refname_format(ref.buf, 0))
+			die(_("'%s' is not a valid branch name"), master);
+		strbuf_release(&ref);
+	}
 
 	name = argv[0];
 	url = argv[1];
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 4bf97db6af..867ada059e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -273,6 +273,13 @@ test_expect_success 'add -t with an invalid branch name' '
 	test_must_fail git config get remote.badtrack.url
 '
 
+test_expect_success 'add -m with an invalid branch name' '
+	echo "fatal: '\''@{u}'\'' is not a valid branch name" >expect &&
+	test_must_fail git remote add -m "@{u}" badmaster bar 2>actual &&
+	test_cmp expect actual &&
+	test_must_fail git config get remote.badmaster.url
+'
+
 test_expect_success 'without subcommand' '
 	echo origin >expect &&
 	git -C test remote >actual &&
-- 
gitgitgadget
