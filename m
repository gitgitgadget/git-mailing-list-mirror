Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9A138487
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166186; cv=none; b=jNU+yR3qMpm71f9l2OTcdzPG+W7surK3k9mvPnnzmBmgeNFdfpwKs4EkVi9k8C1KaIlOQ9Ra5Z7Z/xCRd6mnCXHQbOJvNkMKnGrq10NwvCd7UpPokgBxVC6x3K8L8hjJZ6pvmh9ERyy67glH9UOSoOjhunrv7Z3VPqYPu8u3Q9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166186; c=relaxed/simple;
	bh=2TE/DBVKn0BUnfpe9PX4XPt2JnnoR9Xy7sHgpsFkcTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SBGbufGBDe/QYFhR84bo9cflz9MPsJwsTAlSUfm2QSuja86GIWrrKM7lPNEEA++dtnzOlJJHZ4uzp8DhprEBf/g4Dcb7ZT3rLdQPKz3XTsXhiMU4uY8o/nebffsUiBTRl65ynUwBJuqZbiZo2hzsvSePj/BYp42SdfD3bbdtY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBspKevZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBspKevZ"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso6281833a12.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 12:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707166183; x=1707770983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGVxE/fPlAn9zxe3strNdU55wobvdN8E3gVU1NzKblg=;
        b=aBspKevZGiKCLTln7g8iAnit6hiMmR7L+OCzOEvp2yA42Q3EHD1Yeg6dXWYdjne9NB
         nmy5/+Mc/8G1UaNGhKP/vO9v1wIdSamPlJ1d2sApwqO36bwT7ALww9gMon7OgiMnoWuo
         JdvjXnuZQDf2lrhm9gl+AORCxE0ktKLISDuIsGRUtyfFQfjFUigyTxxnkI5Q7fWoaCCF
         ShDwurX2RZx1mitnPhc5Ovp3Kseh9QM0oxbvJah/xxoY+CeX8zVgUThDFnfnD6801Lkp
         o6rBh6vacweHn/5ninaslLIWa6PVIBOPh58yhw4DCjsHlPaoOZTabIq33RhP9h6dIJrg
         GIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166183; x=1707770983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGVxE/fPlAn9zxe3strNdU55wobvdN8E3gVU1NzKblg=;
        b=T40CBF8RGrm+tZdc+JsAPnZEH6jN0hPJXVB8V/8yC671oiCGxJY+BT6kq612RjhJTg
         6PkMtXaJI1X1XBHG4b3m+/tyOBKeR+2Mri+vIt1suFCvTMDk0q6gyB8YT2ueseV0p2Xv
         MMPnqmXk1B53CsMeUFKw/lzVwAmjPKv+yYKOAXi5CrlQOxyXNo1VhqjFRaXFTw9TtpFD
         Hx5RwKnQZikKnnkeYPm43f4vQ/y3NP8d6v47boQVh8zhuCP5NltnCI4WHFUeatL3/VGc
         TDpqrYc5mZQKSeXf4jKCsM5QpxdLsM1/2n2gKeTUTUI1eQVnbuovhhZPga89PfGobF/f
         1r2A==
X-Gm-Message-State: AOJu0Yxh3Ml9cPDsqUgjLi62stKp9q+nNLDpDCjf/gEox1Emkar9DaKR
	cqU7JRkNrr4GFHSy7ogtHecB0Isra2qCnBdMiIt/6uB+5bOOuYX+jHTZ/DlF
X-Google-Smtp-Source: AGHT+IGz32k8orydCBlmIr9Etr8MogQC5klfjsBdAerBzFlHV8cVeSYjxOhiptaluYlG48GuQYhOew==
X-Received: by 2002:aa7:c88f:0:b0:55f:fe85:ed4c with SMTP id p15-20020aa7c88f000000b0055ffe85ed4cmr293922eds.27.1707166182769;
        Mon, 05 Feb 2024 12:49:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVMb7VKVKgaJh4ZiF4hRjRKvMqDABT4aiRkGS8O565YFwXX5iEM6x8zCxDrCkkMLq0h7kikXVj8Q/M8Z5I5JhLy2YzZy4+fnFlAjg==
Received: from mkb-desktop.bosmans (89-224-201-31.ftth.glasoperator.nl. [31.201.224.89])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0055ef4a779d9sm275551edb.34.2024.02.05.12.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:49:42 -0800 (PST)
From: Maarten Bosmans <mkbosmans@gmail.com>
X-Google-Original-From: Maarten Bosmans <maarten.bosmans@vortech.nl>
To: git@vger.kernel.org
Cc: Teng Long <dyroneteng@gmail.com>,
	Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: [PATCH 3/4] notes: do not clean up right before calling die()
Date: Mon,  5 Feb 2024 21:49:31 +0100
Message-Id: <20240205204932.16653-4-maarten.bosmans@vortech.nl>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maarten Bosmans <mkbosmans@gmail.com>

From: Maarten Bosmans <maarten.bosmans@vortech.nl>

For consistency with the other uses of die() in the same function.

Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
---
 builtin/notes.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 048b8c559c..0e98a820dd 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -310,12 +310,8 @@ static int parse_reuse_arg(const struct option *opt, const char *arg, int unset)
 		die(_("failed to resolve '%s' as a valid ref."), arg);
 	if (!(value = repo_read_object_file(the_repository, &object, &type, &len)))
 		die(_("failed to read object '%s'."), arg);
-	if (type != OBJ_BLOB) {
-		strbuf_release(&msg->buf);
-		free(value);
-		free(msg);
+	if (type != OBJ_BLOB)
 		die(_("cannot read note data from non-blob object '%s'."), arg);
-	}
 
 	strbuf_add(&msg->buf, value, len);
 	free(value);
-- 
2.35.3

