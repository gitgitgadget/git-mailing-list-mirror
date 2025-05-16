Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA0D1519AC
	for <git@vger.kernel.org>; Fri, 16 May 2025 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747405699; cv=none; b=DCq6/YggzccJyrhBEaHgPCQebii0XEE5KckVqJW8NOmTjM9Sq0lRQPGtdM7w6ffxXWhBHVNgi92TsSJhaKlr8Z3qFTc3Z9kouy9RiNjIcv04OBOnEChZcnDRE+iaIgA0NXqKb9UQLA2YH/kEamFmZqJsw/e4qh+pCf7FjHsSxuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747405699; c=relaxed/simple;
	bh=NjPGrwDQZBM3OXLpAvpnvqYvNH5svfNDppSdUZET0Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmyJxm1inEMB0tjyWKKZdgilYM8xcxltQ6XXjCZklNpRLZmwsVZAqw4Ol8xU7qWcntypH5vPFzgdpi/tOpPmn8/NX6GqI8LtIYCZXfmkuexWt8bgiABo4WhJcBYGzh0vU0QsAIn8vIx2QoJYqZNHylW4RkcSo5xmYmIJI7wDAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name; spf=pass smtp.mailfrom=chrisdown.name; dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b=xCKxzYhM; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="xCKxzYhM"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0ebf39427so2021473f8f.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1747405694; x=1748010494; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHwmhw/VTGZimy9fk1mggyfXDNa3Bmg1S2dA2A8f0h8=;
        b=xCKxzYhMZBDxFjRprjoKzWRIROUyJuvxqmjZqG4NgbthfSOmR+awyAfstWbj92kA+B
         xDV19/7RKwcgaSxg1LosMmP3npWjtA36mfSt+3d7uaIy27f5i3xaQkS2daIjGJ/PlaPW
         bAoBwi1+tZTBC8MaKzs75gCwXZkpPp5KCOeXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747405694; x=1748010494;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mHwmhw/VTGZimy9fk1mggyfXDNa3Bmg1S2dA2A8f0h8=;
        b=gEFexjtEB9jx43Izl4+8F/lrnz4dzOrKbcnkyCyFNlbv20jX1RJASIsPE36mo4nBU5
         6KMUOT1FiQnd+gw0WF1mISs2RF5txT/FvRpodo9CI9y9YJtl+DGsKsaxE0DyPXaWpTeX
         mXgJnY1F2lsokQTg6WGBOfqp1CyogrdJAHWYWbcwyE/2FCndjLD3OcSfr6pD80378v+8
         EOFPbmVapluU5OEGw9fHpNFNnSmGM7nTQEO8WIy++5X87sAPRA+qnwUF8JkdCC3qXQVv
         Z4Fa1r1kwgtGM2X9JJCiPGxj5TBNmx84hU1+QG1R1qHygd0YAVix4K8nH+hQfaFoB2bG
         Aq4g==
X-Gm-Message-State: AOJu0YxnSGNYAR+ODNlhuBfE/o/AYlbclA1Os7T3mB9cgKftn2FZ57kZ
	Bs/duUSaruFFD3aRV+kSk3UF5V/K9/qCRxaUPyXOcRWyT6O9D4kLAMjIa7ivz//3yyk=
X-Gm-Gg: ASbGncux7wdqcOpM1a16eZI1cFLY57WYjQB36ohoDw2XYIcVnZolvLOx2g37sSVk+n0
	f/LL+h6ywi66+Vuof+L5/+L6FY1+raHQ7UbnBc9Z/iU/x+Ju9YJGBjO0XI/pOc3qmZ1ZElKT7A6
	60h5lkD5Yo+UeAyxZ3fpmh2/Nt3hPEYf++UPZigIDBsIcsCTdUis7ZatPaffZxv3XxdKFOb8rZl
	CSNRlW3MHVoHOk4AZbD2Q5apUiyTBRiEFTSZZLuna2DM/4t4JoSG7wdm8MtpP7GlwAiTRA8T9Aw
	Syo2T3YodSs/uKjh24QUzTEBHQnDjPFgOSpEfy72aXWcZQJr
X-Google-Smtp-Source: AGHT+IEMkGdwydSNfvcQLEJvxYKRrBgd87gU6v1pPYpSsO94z8lDORk8w/6nOL70tO+xWbd7KA4hQA==
X-Received: by 2002:a05:6000:430b:b0:3a0:b9e1:2a1f with SMTP id ffacd0b85a97d-3a35c849ea5mr4383310f8f.51.1747405693725;
        Fri, 16 May 2025 07:28:13 -0700 (PDT)
Received: from localhost ([93.115.193.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3622b8a3esm1886850f8f.14.2025.05.16.07.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:28:13 -0700 (PDT)
Date: Fri, 16 May 2025 15:28:11 +0100
From: Chris Down <chris@chrisdown.name>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	kernel-team@fb.com
Subject: Re: [PATCH] commit: Add commit.signoff configuration option
Message-ID: <aCdLe_W4wg8q4pkx@chrisdown.name>
References: <aCTI7VjK5QMht3ws@chrisdown.name>
 <167ABBF2-8DFB-4F1B-B5AA-93024FE8CA9C@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <167ABBF2-8DFB-4F1B-B5AA-93024FE8CA9C@gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)

Ben Knoble writes:
>Just in case it wasn’t clear: I think the patch is reasonable ;) I only meant 
>that Junio had provided some background material that should probably be 
>addressed, and now you have. Thanks!

I didn't think that at all :-) I thought it was really helpful that you pointed 
these out, thank you.
