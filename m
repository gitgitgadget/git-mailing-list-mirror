Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07813481C4
	for <git@vger.kernel.org>; Mon, 27 May 2024 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796687; cv=none; b=BlJjsIxmDVPYnGmDU9I0CoNqy9lV2U6eyJGDlLBTkjZYE+15FqmKhERW/+XZqii4NI4hYs0afc6YJs+focHB4bzd7TwozZK8Fk+IVUEFiTHZEQGuZPu20VjEZUGQTJ+uvmE9ZR6Ir2EF1KTp+syncHO9feKe6CHlTX1WO0pi7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796687; c=relaxed/simple;
	bh=PVo/WQp+7hqoV68o7dm+IOL5ohRltXT1Myc4xWYZrec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9PVZ3kN7EcAEwxP8O7UzamlYYSz4abE4if1fyx1rpWHBEknhA3aBKnAaK0f/6BulZPiK7Q/T3RO0MLY/Ibkq5V274Beq3ohlZOXay/zaKHG4u4d4HxhBmnW6ZeN/ZK1MQTdYseroM4GO6HQHs2a/P1bUgte4jjMK7lSIKZD6qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xr3mj8fO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr3mj8fO"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f4a52d2688so3888195ad.3
        for <git@vger.kernel.org>; Mon, 27 May 2024 00:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716796685; x=1717401485; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5n0rroD7Z/qfJWR9K4ns38tAXZLj8W6TUEDXAXQGIPY=;
        b=Xr3mj8fOw3kno58KxIGIufZtdgAhp9DiFadM9kbWRS5z+S4ZvZrqw3TnDdyx6hOF3S
         bSYIA2vk2sjinj4PAMrF0UHf99swAapqhDE8z2WGApyYK+FWDFkF+1JHrI4F4hBOy45Y
         MheDzlzLRXIPDaIdRfUVbyJ3vn2JAp1zYAfNkABi2AuxIonYLrBYndIUta4R6uWgY+BG
         P9SmmaZWYFwdpudWUWNfeYRPeUPM5fbAQwGK4pkfg1OalVH/ZZ/ZWTO7zeOd1RpXztMq
         TrudxL2NOQzW2e9rr7QW4Pvz0xKab6f8BW0+Wuwp38ip2g2lM5EwLXjCU/zSJNh+0IkR
         aJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716796685; x=1717401485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5n0rroD7Z/qfJWR9K4ns38tAXZLj8W6TUEDXAXQGIPY=;
        b=MkOnI2Fn5B78iVbUT3T1SKbSrBYlPLcAhZYdBTbeOVKdKOV7kkK2J81w/fPqi3tSI9
         3ZFxK18eu42xTD/5FnTXqrA2sUJFfLVm3hUFGUlJzU0Prk+id5kIa1O94REN4flFLMC4
         J5k5dn7bBwNAE2VZuP6VYD0QmAW3qmmYDibMER12MOC3dU4jsuHTrPkBL8VNwjyVW/iw
         KjSwCGs2clCDo/EszS/+2NWZFmlNlkn9679Cnz5rCY9yD8k9OS3GhzmeFTB6rVcOKwLf
         4er6Qu4l7ycoW+yMh4b+TzZ4VIQcK5/lVKI3aS6SmNT4WXS8XHmBrFkginYt7PAZGELd
         q65w==
X-Gm-Message-State: AOJu0YyvhD2ZAQrPlBEycyi3vjYOlD0zqewHibrt2tcM0pKKCyk9sYBJ
	9K+tcwoZ1prFbnj39hwNa+kfNTZZrqes1nipNbUI8ghqJPdlu77C+FSASpXx
X-Google-Smtp-Source: AGHT+IFBYDpQZMddZBhw1nFrMpgj51+lIA4NiCrjMcIsBJYYQ0rTzIhloZRfgbPLPyLRAlT6XTX7cA==
X-Received: by 2002:a17:902:c94d:b0:1f4:867e:14a0 with SMTP id d9443c01a7336-1f4867e1695mr47426005ad.24.1716796684729;
        Mon, 27 May 2024 00:58:04 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7d0e15sm54538185ad.118.2024.05.27.00.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 00:58:04 -0700 (PDT)
Date: Mon, 27 May 2024 15:57:45 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC]: Implement consistency check for refs blog
Message-ID: <ZlQ8-fv7I_dEp_9_@ArchLinux>
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

Today, I have updated the blog before the official coding period starts
which records what I have done in the community bonding period. Please
follow below link for details.

  https://luolibrary.com/2024/05/27/GSoC-Community-Bonding-Period/

