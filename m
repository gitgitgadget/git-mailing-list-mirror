Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCA390980
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403178; cv=none; b=uAyP6co+Xw5+24mZBEvsTXN1ndMEDWwmUcbtzTBNbj879hQHnQk7Ub5UtvsLWJ2MhP+4Fv5BaatEJ5UBUHV3LJWDt1r4duL4eSwuzRfqa3E5YAMA4s4VhyFfs8j9LC1HV56XzLuq36+5aMcvLarQlAPXWrYQrZBeMBntZpwb7tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403178; c=relaxed/simple;
	bh=eF8oTAlgb/9vhvWHCjhMc7xXP3nrqAtbP/WQTDUDURc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=og/JpTuOz173RFfvNvYAxY5u4eZh3LRaMZgJFrjwS88mH6mf9jdPJ678vJ5dcOm2g+2px4XWtO63kDyoT5LR+lC414Yey1FDpoQNe6U9X45cbX4hhf4WiM7JvR21S8k0372lFU1yb9VQ4038CTWJPZ52YCQu8T7PhAUgRCgnd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRWD2ljb; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRWD2ljb"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ad9a9be502so13283005ad.0
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 04:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773403177; x=1774007977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXe1/sbL8FBluHrOcJKTNAq0aoPbok1l+4MikIuM8ug=;
        b=QRWD2ljbr0JGzvsjhYzVFALMOmsD6wy2ZiaITG2HuQ1Uh/skr4A3jq5/NNQvRAGPsO
         aCNr6ndj+VWL/x6Vr/b6DqlWr6zda1HMD38PsLKEy8qN4ckWgNCizaZ6JGiT4TkB7pb0
         G27SVmAfdJ+tVplykdxUX/D3AxX1N6roY4G4Qwj0Rzosq6Zmu3XjaSLbI7foEOUrMQsG
         1LfqRPTEfE4wvWqWSQVZdIgzYTCmID5krUS74QIGwxYI+/WNOSFfrk5qEOzIk+zG+nuX
         wDgdcaUKl3q4jrTUwhtk8TFMz08XDWdxL/GSz5QqavcpuCJf9gMV8suVGkRTmEfqGT6B
         Qi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773403177; x=1774007977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXe1/sbL8FBluHrOcJKTNAq0aoPbok1l+4MikIuM8ug=;
        b=QdxolYaem+slofAr9iyyNRXeT3pRVH1M2pK+ZCjDS7AiY/rukgG5KcF8s6La3KXY2c
         bDvquSvhVgC7rf/ejOy78TiTW8+qTFSlPXRY7njX57oKgJjNumYFJ+lkYk71u4Ty2ro0
         AAL7vYU/rghA4DzK9GvBfaLhRZyG3QYTHAceYKTZHP3KbnCOyTkUqAHAnyJiw78+IMOM
         2luuIHdJ1a9OjLXgOMWW2CgNuNKwZVGe7tO9PaH7RAeSNSftQxWTbY+PAY/AIedOHfgK
         3PVJQ1OQHpWTbcavLG4KvARSslrX24aJsAlJ70IKZvRe86VB/AWKYFu/8Yp6w0WbXgjl
         ILcQ==
X-Gm-Message-State: AOJu0YzF6DUR/s94legV75efzyHmFYbQzsICRG8w/0xd6JT4KRpYjXVU
	HzFwWhjKNdzqNKgGF2pmDPynUwXsuCqjwfWaIoc4K20WCVGmKnIXO5dPvE+iNzndcWQ=
X-Gm-Gg: ATEYQzxJ6H3nTixBSuo2JecnkK62NxL2f6CJmnW0b/Nb6aufn+hDbj1Q6EbGYyOH9p7
	ZG5dv32uM6ZNAyTGio7fUKOfySXPQc1/D7rHtqcDj7DLGuCEEcrvRiFfhDQHZqujNcxOAooA18y
	2I0NdbZ0PTmVcZ9d27hL2davTPDFV54/6VVK8RJRY7aPnqSLniXIXsDHPPmUlKw+0RRafo98eiY
	DKPSwIwoMZyLLyi30sWBUEN07/9UXk9sPnSrzFPuF5cKQCirbDLd5/nvNrm0dESr5VentXtmY/B
	utjBInmdQ9GWuMruaQ7uCzFMfpchiiai98tOsYNpFwfCYUZPJppr1sn9mp6k4Ry3SofBMDnS6ci
	KMrvM14zKXBFFE2/v/Eucs8zlg7cNAHHu0kq9rNLN3wr73iIXjGEhZAvjmRpuyzy/YZvP0vDhsS
	aZL32xli5PTs4jq2/Q85VAnIDd3KG6pxGwKgpOPP/nSFhPa+Kl758l9b7ZPLWx1DuoU2AdyRXZX
	RSpTx8/XhwGc/0si03d5dSy4OsESk4FcBZIJ/mesh85wCMz51Zq9nTzCIKmUC9fF9CWnQ==
X-Received: by 2002:a17:903:19d0:b0:2ae:4f15:1aba with SMTP id d9443c01a7336-2aecab22c09mr32290355ad.30.1773403176816;
        Fri, 13 Mar 2026 04:59:36 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56e0b8sm27333585ad.16.2026.03.13.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 04:59:36 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: rleone@scaleway.com
Subject: Re: [PATCH] gc: add git maintenance list command
Date: Fri, 13 Mar 2026 12:59:31 +0100
Message-ID: <20260313115932.15259-1-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <pull.2201.git.git.1772040758787.gitgitgadget@gmail.com>
References: <pull.2201.git.git.1772040758787.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> char *config_file = NULL;

>	if (config_file) {
>		git_configset_init(&cs);
>		git_configset_add_file(&cs, config_file);
>		if (git_configset_get_string_multi(&cs, key, &list)) {
>			/* No repositories registered in custom config */
>			git_configset_clear(&cs);
>			return 0;
>		}
>	} else {
>		global_config_file = git_global_config();
>		if (!global_config_file)
>			die(_("$HOME not set"));
>		git_configset_init(&cs);
>		git_configset_add_file(&cs, global_config_file);
>		if (git_configset_get_string_multi(&cs, key, &list)) {
>			/* No repositories registered in global config */
>			free(global_config_file);
>			git_configset_clear(&cs);
>			return 0;
>		}
>	}

Here the branches look too similar, after the third line at the else it becomes
exactly the same. If you notice, global_config_file is initialized as NULL
then in case of !config_file, its value comes from git_global_config().
Anyways, there's no need to separate the free logic because both NULL and
git_global_config() can be freed.

you can avoid this by extracting the diferent logic from the else

  if (!config_file) {
      config_file = git_global_config();
      if (!config_file)
          die(_("$HOME not set"));
      global_config_file = config_file;
  }

and then the rest of the code is common for both cases

  git_configset_init(&cs);
  git_configset_add_file(&cs, config_file);
  if (git_configset_get_string_multi(&cs, key, &list)) {
      free(global_config_file);
      git_configset_clear(&cs);
      return 0;
  }

