Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F299210F8
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 22:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826269; cv=none; b=C5/w8GlUKK+pYVLDvXs9v3I+6gZul4hB3J+1a+nqwn5Zhk5qF2rJ8qOwOcGbkeEuEfCaE7v7Qxf0y/MIVXJqez8SZIqWsfiwDmsaxPkD26bpdZlFqVrebU2BOXrMGDByaglb7bkuu/4i+eNPUnCoAvpzNcri2cXxPWX7gtu4HRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826269; c=relaxed/simple;
	bh=lFx4UUNNex51rDub3/42d+2wiTBBKQSLfT5KxSQFbdM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=fxCDv6NE8IWoM8+9sRvxrq+5Gzh3yVGDOgJzpyThSfW1i4Y12Las9gmY6tvorpJifMzosb0ZIwDW+evOwPVrjpHynPwJdv8IdB+1M/xLZ6mhSSf1SqWLJFpmjpidC1C1hymCUOMI11ejtOEG2OebGDLJbedoACDiU7eyLDp9PRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLYvjGgV; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLYvjGgV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so10625495e9.0
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 15:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713826266; x=1714431066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVa/kbBvXpNVX/OVXyY4UbsUdzYQTrRebjBxnXPqSaA=;
        b=fLYvjGgVBQhCvWUnL5vEOJsb8E9e7pcbMEyOnucN2S3w/Lr4Lb+ab6qX7KUan/1jg+
         P3cY3M5ZAZN5HiIB+DkkOoYC8UHvHzabVA+i8F1uY45HLoknNyFyf4uQwNRXu4CDJiIv
         e3L204LxWbjnaGdrz+2hHq88DIJ23AXycIdrifcscPm9ikonsEkfgpeP8GjdGi1jGSDR
         pbT/25IxXsqKaiZJ+BGtBNkRjSZkQ+OQmCoiijczYPP30zLpgUjtMEOE60ruxQ2chLDL
         RbjvXydz1jHsji5TancOt5JfsJCck+w4LMHu+lG8gMMYOGRFviVl8rV7nJQyVcIZBCpe
         Ni+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713826266; x=1714431066;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVa/kbBvXpNVX/OVXyY4UbsUdzYQTrRebjBxnXPqSaA=;
        b=O+b87uV/0MCkzD3hy1q59gjbDf9f4kWM8ofxfjOao+Dm4DkhadAqm6aC0Wemq/vwEy
         6vH4xdmfEnNjLddlAk1UDbrKFqe276ljWCyG8DaLOYcpIqMvVg2lz+mSDUFeVsyGoMRr
         CSv996vz0mDfnPdgwsPvy8/3c5slLRWTmB7xwnWjmDdpJl10wOAkA2V0l0xOg9FqW6no
         YqcDPFCSt8k41td6dbccKrUeHqiTD2gxfsQWsG7/cVcyo+j8tW6W0GuArJI0e2zTXVzB
         aa/mzn/nYTpXMFJqlCHV5BxQCcuZsUL4BoMvBoYe88pVy/nwULzsK21IfGlssY+LDvBW
         FHhA==
X-Gm-Message-State: AOJu0YyxXkF3vV7XjjkpWk/IQ4FDO+kjsxyO2AUsiAsbFbwQVgatMKEA
	DCRzxR4doXi/fAXiYuMR6R1swP6sIrqN9OSq+zO9uiB0zO/K+jKwW50jyA==
X-Google-Smtp-Source: AGHT+IGKki3p16vhy0ou8BgUjbrKmNM+SQ/Nmv0hf8+yp96vp2j+cKoH0v187uNDjl9shJX95smDBg==
X-Received: by 2002:a05:600c:5112:b0:419:e3b9:b384 with SMTP id o18-20020a05600c511200b00419e3b9b384mr755654wms.11.1713826265867;
        Mon, 22 Apr 2024 15:51:05 -0700 (PDT)
Received: from gmail.com (247.red-88-14-44.dynamicip.rima-tde.net. [88.14.44.247])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c138b00b004187450e4cesm21833999wmf.29.2024.04.22.15.51.05
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 15:51:05 -0700 (PDT)
Message-ID: <69f86760-96ff-4c62-9649-4627652b7c19@gmail.com>
Date: Tue, 23 Apr 2024 00:51:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/4] mark t3701-add-interactive.sh as leak-free
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Content-Language: en-US
In-Reply-To: <b7b2d0d2-245e-440f-a7cc-fa0df1ce73ad@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rubén Justo (4):
  apply: plug a leak in apply_data
  add-interactive: plug a leak in get_untracked_files
  add-patch: plug a leak handling the '/' command
  add: plug a leak on interactive_add

 add-interactive.c          | 1 +
 add-patch.c                | 1 +
 apply.c                    | 4 +++-
 builtin/add.c              | 9 ++++++---
 t/t2016-checkout-patch.sh  | 1 +
 t/t3701-add-interactive.sh | 1 +
 t/t4103-apply-binary.sh    | 1 +
 t/t4104-apply-boundary.sh  | 1 +
 t/t4113-apply-ending.sh    | 1 +
 t/t4117-apply-reject.sh    | 1 +
 t/t4123-apply-shrink.sh    | 1 +
 t/t4252-am-options.sh      | 2 ++
 t/t4258-am-quoted-cr.sh    | 1 +
 t/t7514-commit-patch.sh    | 2 ++
 14 files changed, 23 insertions(+), 4 deletions(-)

Range-diff against v1:
1:  18e4c7f653 ! 1:  75cb700eab apply: plug a leak in apply_data
    @@ Metadata
      ## Commit message ##
         apply: plug a leak in apply_data
     
    -    Plug a leak we have since cfb6f9acc3 (apply: accept -3/--3way command
    -    line option, 2012-05-08).
    +    We have an execution path in apply_data that leaks the local struct
    +    image.  Plug it.
     
         This leak can be triggered with:
     
2:  21d6c2dd16 = 2:  bee002b0ae add-interactive: plug a leak in get_untracked_files
3:  f69a6a30a1 = 3:  7d1a94dd91 add-patch: plug a leak handling the '/' command
4:  5d9607f153 = 4:  fff7e48949 add: plug a leak on interactive_add
-- 
2.45.0.rc0.4.gfff7e48949
