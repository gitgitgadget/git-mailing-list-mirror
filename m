Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445E3090D5
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145486; cv=none; b=McrtP/HPx0cOQK8QYId7mwc9BUov/aMBovzJ9NNqsLWNH9epZs1sp5nErLuRXslRZlcUr2Ej+k/F1mUsAVWc3J1aDMsdGVf79EyF4vMJ+0VbcaltxT68BsExLsqIencd3D5+c3a18LxAPv8E/aTgEDOnd2ZGPuks8cTXxvffLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145486; c=relaxed/simple;
	bh=Xh69z7VBl2TxqOXyI2G19xqGIkMyrQnL38iW7mUAw8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSlNk2qVxzEE6geI5/c0BRnDUgZmTiUTWXbQRhS7wcavHe7Jr0p6cUGO2Dd23VxCHsm8GYrSoFAN0FdRcrgwjsIZP9tpNeb0Nmpn+ABCIsAnAoRWc/9JHLmAaDIeOUeZ8dmOBaH5HenZfCmFUz6mycj8fcqTS+WVbwPlaUAXbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrbFSqRr; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrbFSqRr"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-246151aefaaso31471285ad.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756145484; x=1756750284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mgozqbUWrMRSEIUREFfcaxcXYm2hyIyo9WdqN10GJK4=;
        b=HrbFSqRrgMmJVpeQ3hNsCMZfEKy3JbJ5LAE/skGe6xxwGWABZmX96Ebzz9UxQ6WsPR
         v18h6x8FS/7gAyP9Bfv5W6Y5CSvWjxvMPvRawz4aL35FJZpAMwCbqk0aFED7rt7uzOFg
         khbX95lPB71Bx9/udKcICoHxlJbACknorRCAzMx4oezlOFKrkNtbceFjbKFh1xFgRAzz
         waA+6oZBsaL8LDUL72BbLFZ8Dxdzo0G9hY0UNxudE1DMOBx7gzgrLQjJRBCDz33gO74l
         jBnCC+pAPlY/kKqBHJ62jFUlIt5UeVFpW2Y+z9bDx5KmK04LLdUgS9qtgi6hkptVwjN4
         Uf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756145484; x=1756750284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgozqbUWrMRSEIUREFfcaxcXYm2hyIyo9WdqN10GJK4=;
        b=FbcWUDnCL6OqcBTSjYnak2c8RprwL80fbMqIcCQeg+u+McUsr3+YI9lF3JFKBCm0su
         vG1Oqo4bKY6JDDc6u3XUvH8pTrYnRhHMVTeuBQKUtUF1+W3WCDBAMPL5L8av41axZr7m
         ikSxsrZYqVgNMEpKjV6rfg0ZgDDSuS8hRDHQYjqaLknhgg/eMvQnW1sXVhb2BvraIWre
         yeON7TQMArbVOLdNq0gIRDfb6JkCxkQxp0wz64XowkxevkjQNGRxer7QJNlrvdaJGlTN
         FLHAzav18G2VbGNEDzPYsJT/IXux6knOtQ2cyPZIcMuP+hC3uN8z2H19VlDzDIJd6tmi
         YTGA==
X-Forwarded-Encrypted: i=1; AJvYcCXkUcVAZshdCHHDjurYxv5YgxVgRsdDlu5ZMReL6wOMuFXUu/iXI7jq1ekqmC+9cagFTD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtrwAVD6n0ZziUoYoQ8ef3QVHTC36Dh1kJeApwRFUUBiF8FYhs
	xyXGCfdm4GwKhWTov0UcieTqIdYeE++SHHNqwJYQKSdyy/z+e80j9pU2
X-Gm-Gg: ASbGncv/Ax4SaCKe7pW404T8Gxformjusb7J2E570Qqn1NYL5MLjCoBYzou4qZ40Fiz
	A9JTiFBQoeHKGZVZartfAwGj7+YaaMdmafXp9HhosQxcJaPQsMwR9ku/M8J3zQKd39r7790UvcC
	ZvRlSkx5npbliI9Zayft0ylFrdIoNosCMZvN+60afwQN4u2i4dsBJwvHXuEiYiC/t8F8xGNa7yt
	jmtgJVWQk0cHuvD2NP0sZjxWVHgIz3dog9spsUGZCT3JAqG4xdjiSBwmg3zyNXi8uMGOEVc6+4g
	qJ6Cns3ZGiDt4Lk2EKvS/48VVfyIcMuuXserhjtiWliyCyNN4Zk0Hq8T6bY3N7B5riSOq4JYiID
	MqOYdDC9yoyctsoBtbFLBVHRZLq4daLA5xHm5UIsUsE19TwyzfvFSqRiYWVKhucIT+jUC9Bmviw
	==
X-Google-Smtp-Source: AGHT+IHXCM27MHdyb6lzlQ6qttAzojzrWt8yZgcZxd3FCCepByoT9/hFNpdHdBu89IwBSpwc8ABONg==
X-Received: by 2002:a17:902:d584:b0:244:9912:8353 with SMTP id d9443c01a7336-2483deee807mr5242875ad.6.1756145483766;
        Mon, 25 Aug 2025 11:11:23 -0700 (PDT)
Received: from Reys-MacBook-Air.local (c-73-70-17-6.hsd1.ca.comcast.net. [73.70.17.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880a99sm73687345ad.121.2025.08.25.11.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:11:23 -0700 (PDT)
Date: Mon, 25 Aug 2025 11:11:21 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, Nicolas Pitre <nico@fluxnic.net>, 
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] progress: pay attention to (customized) delay time
Message-ID: <jq5ul4zwdex6peuub3upwzxz3d5zcnuh7adseyg6wa6dpiu4ci@fuwe2t2vbguo>
References: <pull.1960.git.1755955377.gitgitgadget@gmail.com>
 <86bf04c7-6315-46ef-8297-42efc3ed322d@kdbg.org>
 <xmqq4itxvi3z.fsf@gitster.g>
 <08f405a6-fd2e-40d7-850a-574356b4009e@kdbg.org>
 <2d56de10-f829-4bc8-9c76-76eab6b137ae@kdbg.org>
 <xmqq349fs5ee.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq349fs5ee.fsf@gitster.g>

On Mon, Aug 25, 2025 at 10:00:25AM -0800, Junio C Hamano wrote:
> 
> >  	struct strbuf *counters_sb = &progress->counters_sb;
> >  	int show_update = 0;
> > +	sig_atomic_t update = progress_update;
> 
> It is somewhat misleading to use sig_atomic_t for "update", which is
> never updated via the signal handler.  It confused me a bit during
> my initial reading.  If it were
> 
> 	int update = !!progress_update;
> 
> it would have made it more obvious what is going on, at least to me.

In that case, I would suggest doing instead:

  bool update = !!progress_update;

Carlo
