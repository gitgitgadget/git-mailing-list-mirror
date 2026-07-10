Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43041CB4B
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683613; cv=none; b=UvTf+XRYmbXk/x2KY5Zej6bJjhU55+2CJEeJjvNwvUZrh6vCXAjeGJ6Qv65dEk6B7YXbNnQ7X3pWwSVdNabzaQxsP/rwHQ5Nf2t6LswoLjqYRbrw1r+zRasWZTzZf9GTLvQPpCU9R5zuVEaRN79CaKEGrhRG5Iv9EKtdtJDNuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683613; c=relaxed/simple;
	bh=J45cIBCD/CJX+cJQg5BTK1qg++hPlZoPMVsoiJ7NKhk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E98ToCnlp9hZHoaIIBoYQA63X3lgvc+vnuzSOLY3WqXo/2cE/oAz/YFqzDFVUjwN8diUk2C4iP3c8nYdkNhUDTvHFskUH2mf8zc70BSQtatPyXYmMNKKjFynuvAaMOgejR2gGo0vcZrFBWljMxLuXcZRJxE+wkAg1OhCUL0Q3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5pLxn0q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5pLxn0q"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ca64c3ce5fso10556365ad.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683586; x=1784288386; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3/AZZzpJ9qPAtx498qquW55OXxDQhQBchm9shD4ykVo=;
        b=V5pLxn0qGbtrQ74HuZxSK8UTlvYbIn7IAuSWTiMxzzAokukQEce1axl6Cx8ouGwt7I
         0RmRTGu5OJds3A6Qwz6D5LfMXZF4FwV/zm8fEMWEDuOzG8AN63xxehm1eC1PNVpwi4sY
         e07ed5vKXwegJhD1Mir9EUrnueEhssgK6Q6dlgVU9ZTgHr+WjAyqfqBnFn0PKa+4dCKt
         2JRf7XT/vFaihLIzb4RnJdd6SiZqJflLx2cJnKPx7OaIn42BkWT5oLflg8SnCMeZKdet
         QamngNYzUNuhCSKsslKUdGqnj99NqWY3Yrh/H/U3Q6on8/IvCY41hL/8n7ShXYWu3LjA
         J+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683586; x=1784288386;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3/AZZzpJ9qPAtx498qquW55OXxDQhQBchm9shD4ykVo=;
        b=XY2fTkBEoH9VviCuAVY3UkssADj4RwxBFakwGnbamSWgbHWR8/+7VydmT/wYb5iEcM
         2qXtkxIsqXPVOaiCdWIKs9Ke4Tl7NRvK/SwOy5zMOUmq8O2ySpJt4hibbOpyXDVv5VyQ
         FlChVcLAB0rzdlogd77VqKhvoJoiuknN5N4gOInVyLgF6ezps9okepRCZzUpNKuGSKK6
         fC9CQiMn/ZkP9iVdmHZxUlX5/xWkYuJ8qw0DVWfNdJ6cGynlJ2ezYfGVqcn1YzxRf7//
         efkA9dx/glczXSDgC2w9EiaJuAZNQtBF2XlIyXLqTLZgK07bPK0WSGzkZcdpcs4JyKyb
         30hQ==
X-Gm-Message-State: AOJu0YyU0yJmLe+7y/nei3afWwH54ldH6w/1d8rYyP8jTADXbsQm5mbU
	XnI5mjHb0zszQETcGcYyIDEHbNE0zNalqdxjvDYxgVf8QjYNFWtAu+38N+PCX0iB
X-Gm-Gg: AfdE7clDc+04INpDrAwMi2CwuZHHX4IRaaCucEgxO7rmSgiYnKeTDftogFoHWH2h7hm
	QBiH9c92agIcX/cptNQApOWNeHaFBkTyhCZuI9TrHmFym6u8suRi8oydVTuV9+QgEblxwtNQA8n
	spyDP5RSGzpyfq9HTk4ggzeDRw1uwYeX1naT9qaPssrU2N9zPZbiBnAs2DCKhcZCzZ/vw7ERH13
	QeZQRFZo4fMw3VCZYMqph25+LpXrh1+2v3NCFV9/fgeE91/bxog0Bd9JCEZnNWsQkiK/Eurty4c
	5he0PshVboRO/IAYo8z3RRVn7347FGE0eaJFAIsAvXRnFIf1Lh61Dc9RTo8fPFjfWRJZe+K23B1
	of6FZtWut3LPagFR/xn6xCMr9Vyrbxv0JGzxd4mru94b/S7V3PhMkUaiO100gwzIgBBQ14TCLOE
	y1d/Q87Fq+RGhDpQFI
X-Received: by 2002:a17:902:cf07:b0:2cc:5f9f:54ed with SMTP id d9443c01a7336-2ccea45e034mr101236255ad.27.1783683586039;
        Fri, 10 Jul 2026 04:39:46 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce7b3755a3sm15868915ad.80.2026.07.10.04.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:45 -0700 (PDT)
Message-Id: <285f019fb3c3f1d3eb6066de93315acf273dca69.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:28 +0000
Subject: [PATCH v2 04/12] reftable/stack: guard against NULL list_file in
 stack_destroy
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When reftable_new_stack() fails partway through initialization
(e.g., reftable_buf_addstr returns an OOM error before
reftable_buf_detach assigns p->list_file), it jumps to the error
path which calls reftable_stack_destroy(p). At that point,
p->list_file is still NULL because the detach never happened.

reftable_stack_destroy() passes st->list_file unconditionally to
read_lines(), which calls open(filename, O_RDONLY). Passing NULL
to open() is undefined behavior and will typically crash.

Guard the read_lines() call with a NULL check on st->list_file.
When list_file is NULL, there are no table files to clean up
anyway, so skipping read_lines is the correct behavior.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 reftable/stack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1fba96ddb3..3fc3c0b2d1 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -171,7 +171,8 @@ void reftable_stack_destroy(struct reftable_stack *st)
 		st->merged = NULL;
 	}
 
-	err = read_lines(st->list_file, &names);
+	if (st->list_file)
+		err = read_lines(st->list_file, &names);
 	if (err < 0) {
 		REFTABLE_FREE_AND_NULL(names);
 	}
-- 
gitgitgadget

