Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391FB13B2B8
	for <git@vger.kernel.org>; Tue, 31 Dec 2024 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735611521; cv=none; b=DvEyPWC4sfYKRdStzVAU9OXztKAhbxByChQ53v5LdWtlwBuopSXc3byXQvDZmShim7cxIvmQLmTcOyvV9D3KScGZhxXKlskqpn/jsZwbeL+7ftP4jBnJjYWWEpFG6I4gSZaoWDPzzL//3Uy9yC8CYTvymcz22a/ppHAnBVewZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735611521; c=relaxed/simple;
	bh=oV2K3RMAEeTgYxf1BJ0PaJ4cc7u/M5GQ67eKQZgqkW8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OXA5RPEM7CHbe0hRAQMlq23fxc2bxHV4jFuOXCTwS1cTWtfWHda4JuXfJK8rpMdpyj+YSIntIAqIsUXQLnYr54kD1zie8fJ73zBRX3IFR3LoMnYow7TKK9WaJSnb3odulnAK9rNX4ww65IHOt/VHC6AZ+Q3Rf0Ufn1g7Lokg574=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1pEFJsp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1pEFJsp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436281c8a38so69539735e9.3
        for <git@vger.kernel.org>; Mon, 30 Dec 2024 18:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735611518; x=1736216318; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q26BvtnsuSsvW6l1iFQ2+lkiaTIpu/8kYVIAVV3ESWo=;
        b=i1pEFJspZa9vbeG/yVzU2NRn0DnqlIu/OXRVIQ68/bZfVItNB7h2Dr97Wp48+ORIY5
         vhcTF2iTcXmbVTRH4KvUs5Pg3U9pd1PvK092Y0nMxHEqImy54uA8H2rCPgbdwVGWZoi3
         O3hGDhkesuUGHdsmi31K0ZHaF8319jbfC4adzBbDkfosPLClpqz2J1T7Cn0LjBuwA3Z9
         K9pK8/iQtmfPFVHuRnPG4xI6E0DBynuvbRKm8BLmth+ZFs8UmQmH5YKXPokqjgBoN74u
         2+DtmvEl3PeqUsENEAKOc+qyhFsEsHlIObdywxuSVKislwaotlMYmmWuTGtih0nBo2iC
         Zenw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735611518; x=1736216318;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q26BvtnsuSsvW6l1iFQ2+lkiaTIpu/8kYVIAVV3ESWo=;
        b=Kfh8VxVGgjI1wuK3m18WMXXcwITIlzGllLFAHPxk1/x6s9XKIB/FZTlqS+rcMEH2l7
         QlWq1/Ua6dP3/ftZ9RZzvGAmVf597Lta6UPR3GWYKDGJwTW5wImZYCckDDTOhLqiMSAF
         GedspdpfZXX+S879vmRWsdaJNg6Oj39Vyzi445LHjhhvxPYP1MK3LFEHMr+5Qtd9Sy8/
         CiK87XUzMBO7zbBJrKFLYeFPnxCL/0bIe0m1m15Vfh3FHNu/st9WsPrz14pUMWtXtiGS
         8ncZ5vWwU8AyXWe9N5uaDNwZjXnATQt53LV9cpJBHxYhdECG0oF5S1jPd+Sd3Btz049V
         ddZg==
X-Gm-Message-State: AOJu0Yw0gM+MiU7qJlHmGqvpwUH5NkYfv3FbrunDH1cDcSH8bmTeayww
	hbbIJoplHFQMcwTf4d/O5Gio1haCXnTqUIzhAYAEQCEtTEL+/wPHAqVBQQ==
X-Gm-Gg: ASbGncuyNm16fwyb7Da7Bc9QitgDP+gsn5QqU5JCE6s4tKKBX8EmyJxLiIWKf3fbNvO
	SP4Q6kbxzz0e5x68QVk7Qivn1DoxUrXOk9cupcM76Wk6Nv1rxwQlHOlKUCRWAZMIImfDcO7B9j8
	LJa7xf9TDgI9Y3/+H57wSg5zS+OrM/Scj4z2PnZuX63dE1gxjitXt5flA37nBdwq1OzN8uDJnoJ
	dtNArmSgkWg1mSXsSMma/RicPwz+ne5dRpsLuPXCDKy8QUJZLd+NPW2zg==
X-Google-Smtp-Source: AGHT+IGw8rXP8ip6aa7iJ52uAJ9Z+icd1FI7yOkaNty/P7qsbllnEpWvjObxN19MYzUJSclsbE2IaA==
X-Received: by 2002:a05:600c:45cd:b0:434:effb:9f8a with SMTP id 5b1f17b1804b1-4366864619dmr341031415e9.15.1735611518022;
        Mon, 30 Dec 2024 18:18:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6c66sm415788365e9.5.2024.12.30.18.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 18:18:37 -0800 (PST)
Message-Id: <579757957d21faaa8dd9228a191d82f663e93c03.1735611513.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1843.v2.git.1735611513.gitgitgadget@gmail.com>
References: <pull.1843.git.1735041177817.gitgitgadget@gmail.com>
	<pull.1843.v2.git.1735611513.gitgitgadget@gmail.com>
From: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 31 Dec 2024 02:18:33 +0000
Subject: [PATCH v2 2/2] fix(gc): make --prune=now compatible with --expire-to
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
    me@ttaylorr.com,
    ZheNing Hu <adlternative@gmail.com>,
    ZheNing Hu <adlternative@gmail.com>

From: ZheNing Hu <adlternative@gmail.com>

The original `git gc --prune=now` attempted to delete all
unreachable objects. However, after the introduction of
`--cruft` and `--expire-to=<dir>` in git gc, `--prune=now`
can now compress unreachable objects into a cruft pack and
store them in the specified <dir> instead of deleting them
directly. This is beneficial for recovery in case of data
corruption during repository GC. Therefore, update the
handling logic of `--prune=now` in gc so that `-a` parameter
is only passed to the repack command when neither `--cruft`
nor `--expire-to` are used.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 77904694c9f..8656e1caff0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -433,7 +433,8 @@ static int keep_one_pack(struct string_list_item *item, void *data UNUSED)
 static void add_repack_all_option(struct gc_config *cfg,
 				  struct string_list *keep_pack)
 {
-	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now"))
+	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now")
+		&& !(cfg->cruft_packs && cfg->repack_expire_to))
 		strvec_push(&repack, "-a");
 	else if (cfg->cruft_packs) {
 		strvec_push(&repack, "--cruft");
-- 
gitgitgadget
