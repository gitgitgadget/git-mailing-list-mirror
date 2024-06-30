Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3413D53A
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719762833; cv=none; b=s2OOmXlViFN6fshlYK3ARhlgMAEAdARNwJc5t73jG4iUSH/rd1JtRfgLePTdNpYUGjotcYLxm2h3OsL3nGF/3QAmrTqC03jeTVW92SgsVwWfGULvD9aGtFgRHMRfYxymSZljpc9+wtO7qefDM641LOAWZf+iTiS+hu9GAgFDf2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719762833; c=relaxed/simple;
	bh=PtnaNoH6zczrGOy6/Y91jLMkUptC2GEYbpTtO3gn/S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvrQ1IV9w3lRLQyeQchiwyKYbpxEPNDZA9SiTorpNnuPoOAzT7UXVpBFtXKXWmMKa58udXoQEX8U8y7PZMGzPkcGeifv3PYG5Zleszb1k13FpTlJR4j9z/PQImwBkweyqkKDQyytcd5H9uAE30SpeLRfbL8ccONf61B0vPwobpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdS2ef5Y; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdS2ef5Y"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d63332595cso977975b6e.3
        for <git@vger.kernel.org>; Sun, 30 Jun 2024 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719762830; x=1720367630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTtqqQmVzZcYtHcysrZJgUw7gob+WH4Yn5s5Kptl0Ms=;
        b=ZdS2ef5YqSr+QK+eIJZL99RSJnPnIlqnet9rHNai3CY7rwTyg7ZTyvakacUvubjpfp
         jsajwSUkaz5QnSDstLL+CKP1JO7PszHDRWBaD5iXNxzst55c0FMTkkbLcI253hD8UwBT
         sOvxsDSLM3CiT27hmZVv8Ok7zyedmDE8CW578E7CyBduIh+j+laDx5wUrlssi8cXbo8u
         8AzSZSUzmV0yAB0UF5p1tsxRfswgakES8RppCcVa48uJa7czIrzDFz8Z2e5J6NF3Kv1F
         duyVrE+CdOmQ0XnUldYu4WCcQ040286ReVjSBs4VltQKnAdoZG2XAkd3eHdOdHEqRgJk
         Xp6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719762830; x=1720367630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTtqqQmVzZcYtHcysrZJgUw7gob+WH4Yn5s5Kptl0Ms=;
        b=diXG1l+LrhLvswEtC6mBvUBFCyqi5IQtmBmBOmdr344uSeIviJxeNtyzNM1bQTxf6v
         vynoIkPcp8C+lOzrGd78IvNAqrvv/bK2QH4eTO8xZB5jEk1bm45i+iJplbIarRDaZqdL
         QbIrQ2q3rm+Jqhne3ptGluCCp/Xeuj6ZReSUjFt5tb9E9l+lNgDlpYVfPKbQPUl//Gw0
         RAi8sSaoncUTcDIjIN1gMNy55nV/UQm9HLaHAdhGYf5lh1HXFaE6CgYh69RdLGEffLge
         ZQ9QcMv+9NRnnAi7CambLU6e0gfhPsMz3Tf2eFNeFg3rq5iz0BFWp6L2atjlCTDtygF1
         fOoA==
X-Gm-Message-State: AOJu0YzBneqtvArfdpjnHkHMTN/vS3XpVACElGn7M2J3sPlYvnYeDHOZ
	BKoAsJvk38AWClC35wy8VVBKAWGfCBpgyZcCS/Ll+YMDihAvsMgwKp7cmwmE
X-Google-Smtp-Source: AGHT+IH3DcIvV5icWsYsxUd2DeC6QFJtsiTp6hmD4OxeTyCfBPSI1o1oD6bq48/942Zb0jurmvprZg==
X-Received: by 2002:a05:6808:f15:b0:3d6:2d45:a791 with SMTP id 5614622812f47-3d6b3c86bbbmr6247976b6e.32.1719762829642;
        Sun, 30 Jun 2024 08:53:49 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708048935ddsm4821844b3a.189.2024.06.30.08.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 08:53:49 -0700 (PDT)
Date: Sun, 30 Jun 2024 23:53:45 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC]: Implement consistency check for refs blog
Message-ID: <ZoF_iUr3QSswT1yG@ArchLinux>
References: <ZlQ7j9HYVOpP2Xga@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlQ7j9HYVOpP2Xga@ArchLinux>

Hi all, due to the reason that I need to prepare some work for master
graduation and move to Shanghai for FTE. I have delayed my blog one
week. This is my week 4-5 blog.

  https://luolibrary.com/2024/06/30/GSoC-Week-4-5/

Thanks,
Jialuo
