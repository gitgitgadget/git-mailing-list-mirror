Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792790153;
	b=v8skYLIbxcB+jFgHQH7zGKckSewQ3rGTLWcSI6sJyw1R+xbbQskIqCbxJ778/EpStR9I
	 ri3BwvdDg7fMCvNtW/uf0N+73hXJH6YMjYrRXVEpNZGYJ8AsShQzq34ju3MVsh6d0l++h
	 VLYgwEA0x0mxF/VMtSY3DpR+yahdl9c0wgwvvw6FsWacxBoCJ2T9+e4ko+am7C8pDA3nN
	 Hx5oT0IxTR35i2DjYuy1CAGKH2opOFgu97Av7u0EG9yIGAHCXLUXDNHX4PImG1Zr1cSN3
	 9jQs9hO3umwidqnWh7iCepxgX96RjPn9S2uHE2WTVlehQXeZfA4jzDU8fYXrfK0Zrow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792790153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WmI1Q6e7pp32QhNTi0LP7WV48Ajo6uCMZaKPRwRsOms=;
	b=RzC+y72T2z0ONaRKJiYk0bVjTA+m+ZEHmGO/yDNQYuB7C8QSnGdpNCi0kQkalbl935H9
	 leV9MlBEqDfC5iCf0iZzCbsJhr1EagCmEMW83DnOsy1qURrAnioy8VmvGxNdfG/MLbf7e
	 iE75bPu55QgEeJuXvjc5coLuByk8cHIhs3Rsyd1Ncj1Wxv2Zh5SfoJ+y/HWVwqAWTnus4
	 kGxgsDplQn/cODET4Dnx1O4eI8mMbf5iACfZUV8IbHvscWG/YwwPO3pEY7L02wJa428N+
	 KcFVSUMWBJJJbWf0XJdZfObEiURKA9XABYTXP5tY+bm29YZcjnXFWC2+KcF9VBEwaRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o1p8nzRy;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1546606A31B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 21:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1546606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o1p8nzRy
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48df8fe8513so1154900f8f.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792790151; x=1793394951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WmI1Q6e7pp32QhNTi0LP7WV48Ajo6uCMZaKPRwRsOms=;
        b=o1p8nzRyxtT/VtfRzqrldbi2Z0fuSPKZWDzEVfA/ACHCeLUR1Y53v7sp7XQ6DOmICh
         BGeXutUIhQhNaGeeYcyrBigQn4NgXhDNqsFa5s1TCACbP9/5TZ/EzWsJj/C1IiNG9KD/
         71wQgpm5LYSu4mCOqFlGirE9NBjd5YtZOt6N3eye3y77hxfw5ZMqF+LuocxZFlzfyCQD
         uWSVn0+YZJp+A3Up5wUTSbGz+P1HlMZc1ToukVGUltrgOwTO7BFRkxfPucYWCtm8lxcC
         HnnP4kYUt1+kVK4mHoF1L2bLQJpnX25VGN3oG2fPMr4jdepwuEMFPlSNYz2GCsFTEtKj
         Mq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792790151; x=1793394951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WmI1Q6e7pp32QhNTi0LP7WV48Ajo6uCMZaKPRwRsOms=;
        b=F+iXJU9aPCq3DXSnhqnb5Xrw3YCqLIOzOnIP2E8KPqKXUFew38cdb/wPHNbK06CLE/
         pOYu7iSGaPpg4t304mPR6J7ugRF5hwfkXBdvZxvk1i+QnByRvgv83XXpEEo5JXXXltSR
         6kALkvXeo1W1ZPksa+s+QexSsdX+ewkdjNiEvj40FZw03lwSOBkvkMmrxZV0naeYoynT
         RpdM7y8cKHrgAQdXnDHKeBAdavw6jmujx8nRWqzLgSTp3gdomNPImqycdpTJnr6uSojh
         41mpLpXuNoCbEszcxyv8m4t5GfCCs5DHIwxhbHOVpbWtcpYg0kJzYqeTffLKKOyASCz3
         3UrA==
X-Gm-Message-State: AFq9FYJptB3yND+XMLufW1427XTBRQH+g/RnARQjxS4OgnGJETMKg9Ce
	ca1HnBZ0xo6Od+ej7hCxliD/xBVVGTQGIajzApiRDHB93MxAoc2MgBFI88DWsJMG64N6kQ==
X-Gm-Gg: AYBFou0X/rvsLpDO5NISmPO71GWpYiRK8m9kLTPl/IqbhGBWMCYF3uj7Ye1iadI+seP
	KJPx+ZarZTZ/jH9zY3sWuYBlmxNJLhOtoLmpdcWN8WBNf7UoXuBZVOPm6VguJTAnGgTBxGqeSPb
	OX6KJmUpotPLk5har1qJUV2Zi5YoppASz+haKounyUh0Iro+Jn2OyXXJmpuGVf0Da8Ib+5gkZB+
	DEVrb2ubK1wb2ELm3mC6ibjB9mD9uQw9wcTBxI0ELk6CTPxT7JeBw35fEzvEMNwrs84O9gn3/aQ
	H6k7rmyUpJoccFA5AmYNGit+fOg5J+egPakXMJCdONGEY+VKPqyy95S/TPC3Jq1Wq2qBB+iI9za
	MgjpD4zKkZKMU9WkIMV4riSop2wAvsmQA2zjJs+HEUOm2TtcD3cAa/ARIOXNOKDc9kXhIJG0p2r
	nRMxPSsOinAExL/UqFpv0RvoWBWPoDBGG8E69jdTicYnGOzG8ssUYmwQVHuXmkhncjc0NFW0UU5
	v5xdI/JRW+VNZstrBAsy1Me+u7SNB+PKuSWD6jlJs/k6axyzXjmdQxGNMvumxqN/GVtBzcEJGuB
	xDj2d6hZEiK7jfKF1Jqlrtz/URciStFmTYz6GamE9lKMbblFHB2S0crZBduhSmGzBWwEt/bqRHw
	xoq7vcfo5+tE+1VE1rr22q2XhLfas1oYV1ti9KOrp+Kt2+XOkkcPG5SUh
X-Received: by 2002:a05:6000:2213:b0:48c:58d5:30fb with SMTP id ffacd0b85a97d-48e3eb26a0fmr326556f8f.5.1792790151021;
        Fri, 23 Oct 2026 14:15:51 -0700 (PDT)
Received: from localhost.localdomain ([102.88.167.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3bcdsm334600f8f.13.2026.10.23.14.15.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 14:15:50 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH v3 1/2] remote: add repo_for_each_remote()
Date: Fri, 23 Oct 2026 22:15:32 +0100
Message-ID: <20261023211533.73433-2-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023211533.73433-1-okhuomonajayi54@gmail.com>
References: <20261022105641.68963-1-okhuomonajayi54@gmail.com>
 <20261023211533.73433-1-okhuomonajayi54@gmail.com>
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

for_each_remote() always reads the remotes of the_repository.

Add repo_for_each_remote(), which takes a repository, and turn
for_each_remote() into a wrapper that passes the_repository.
Callers that are given a repository, such as
unique_tracking_name() in the next patch, can then use the
remotes of that repository.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 remote.c | 14 ++++++++++----
 remote.h |  2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 71170f36a9..d18f39d19a 100644
--- a/remote.c
+++ b/remote.c
@@ -869,14 +869,15 @@ int remote_is_configured(struct remote *remote, int in_repo)
 	return !!remote->origin;
 }
 
-int for_each_remote(each_remote_fn fn, void *priv)
+int repo_for_each_remote(struct repository *repo,
+			 each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
-	read_config(the_repository, 0);
-	for (i = 0; i < the_repository->remote_state->remotes_nr && !result;
+	read_config(repo, 0);
+	for (i = 0; i < repo->remote_state->remotes_nr && !result;
 	     i++) {
 		struct remote *remote =
-			the_repository->remote_state->remotes[i];
+			repo->remote_state->remotes[i];
 		if (!remote)
 			continue;
 		result = fn(remote, priv);
@@ -884,6 +885,11 @@ int for_each_remote(each_remote_fn fn, void *priv)
 	return result;
 }
 
+int for_each_remote(each_remote_fn fn, void *priv)
+{
+	return repo_for_each_remote(the_repository, fn, priv);
+}
+
 static void handle_duplicate(struct ref *ref1, struct ref *ref2)
 {
 	if (strcmp(ref1->name, ref2->name)) {
diff --git a/remote.h b/remote.h
index cca02033b9..2a0bf416d9 100644
--- a/remote.h
+++ b/remote.h
@@ -140,6 +140,8 @@ int remote_is_configured(struct remote *remote, int in_repo);
 typedef int each_remote_fn(struct remote *remote, void *priv);
 
 /* iterate through struct remotes */
+int repo_for_each_remote(struct repository *repo,
+			 each_remote_fn fn, void *priv);
 int for_each_remote(each_remote_fn fn, void *priv);
 
 int remote_has_url(struct remote *remote, const char *url);
-- 
2.56.0

