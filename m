Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3261E2C1590
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775606; cv=none; b=g45RFoi2P6zjWBD6ZXiIpr6WH0+ZRqD2C/d39rJf4MKZV9Nq7wgb3C5IQIUd5Z50OMrWlY7i4zhB9ygMd1igU5Cl7Pzwvi6BMchutZV3gt7CKJYA9AZGM4rTZM9PARhY3Uqaw/jRQbvGeIbqOsNOUXtwJlCxDVVmxbtAQYx18eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775606; c=relaxed/simple;
	bh=gbCUogLnvjNLI/BY/w8D1vynaF/2+S3cVZ0CYiuKDLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4s+bXs87p5Ze36fcMCgm/FMhkT0oMBRmqIwbnYH0iiietUCU2TsroOwgBioEEw/IU54Jf/nvkKvPqJlvx278ZUep2ZwBdMoD9SlTlipmPYxNFA6bPGIctzyepYcculi0ab2SsEJg9tWADSqwgjiu+aeWkKvyb33V0MsmJeU0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpOW5/MM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpOW5/MM"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23508d30142so75478835ad.0
        for <git@vger.kernel.org>; Tue, 24 Jun 2025 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750775604; x=1751380404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jYewRu27HyCezElAPAt2qKOGDsxrQPqdny+AqxkvT8E=;
        b=cpOW5/MMaWC/dOQJGEXhYRyUHxjBCUEMNqSzqoxaWwOZF6mWumtU1wCN3CgRtJspPA
         IXvbruvZKLvahToetMPyF9PIyXD4JEszHCF94o7wT5eOQB8Y4a6LOOn23/QJQei8z7Xa
         NHwZUPM2muWxtK4I2fFiZbr4BHPbRxdUOR1y97aQlWmpaE2RroXylPaKgklKJoBzFIlE
         Dw1l9YPu661vH0WJiLjZrxGH1bEITCZuIhH3UQHKSytoadnIKuLh8yY8SJCaEHWoP7Yc
         DwyeDafFxiKejqOKF1G54Yw7gd0voR3CTdTb5lK58Run6gVCe911qX0Nn0aDaeFeWAFR
         t9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775604; x=1751380404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYewRu27HyCezElAPAt2qKOGDsxrQPqdny+AqxkvT8E=;
        b=O29c9GtcDwBjiZEvWTs/nfWQhXXyxMJ+yzEJM7EbFnbjmh0bsnpM7dKMXebU1XaySq
         il9QMXOta3Kk2ssChMYA5RGNTYMxyuBVoTg5GrY5vvPThjzHqwOoKGiz53qrgjLYuLs8
         u1g5ln+IY0C7opHRqJKlXjiZ97aPY4MRok2n6IZFe67aTADZPPABA6zruTGkOr9RMAxd
         q/Hg5YKUUMY9BUqn4ZzKqzS/OARQOuO/8h3UESV0krgkZDiLY1S0ZZpen9tu7U7tJPhL
         er604kRznKSf6BFRL8plFyNu/xKN7Yv+IDtMaY1gPOox4LHg9+moAAIajKczzFc/EVDe
         o7Ig==
X-Gm-Message-State: AOJu0YyKV/s9dMruSQlA7WS2trFNYX0tn4xdHjbObwXYeZxVeH7+q753
	5AKuFxvieRmnligN5l57hy8c4T9IxBwfU45+7uS5MusrE3K5q05cdJlGFzD54w==
X-Gm-Gg: ASbGncuGMFFxUsqVzUrOXVS/M4PbEBKHwN6/jwpdGeBV8OLCX4sHiDGAKcLfrSt9v8U
	794J9Su055UO10Kf4f5j4wjSSr0mM0j2itp5ervBg/z0iCVBnIHFHDyqnTwxdSj5wJp8WMzsooQ
	6DhiSH85W31zcaMWiGTPmG59EiNHU2FFQvuOXDmT/n220xzA784F3ErOGW2NEltaOqkrvFPFiin
	1Jz2DLcN1UnuxqlMkssjcOMtSd7UnOer9ZbaX8zp55yZPqVuUb/PnRi1npUG21QQNjuV3zUxiui
	XfKCfXfAbertuX4ZilfB9qW//N1qcMFT7ejiWLxhjoalBJ8iJkAHP0EE8YmmI2frLh08QKf7MeD
	5j6LVVcUJdW5CPOASdkmC+PIW7clfAvBSyw==
X-Google-Smtp-Source: AGHT+IHdU79sIY+kfxhs7LcBR61FOCqvAc85LJuqaQ0U6YNcE2Dbpba1f0w14kjKpdNE3XBZFAPr8w==
X-Received: by 2002:a17:902:d508:b0:234:bfcb:5c1d with SMTP id d9443c01a7336-237d9afa4f4mr301447285ad.40.1750775604194;
        Tue, 24 Jun 2025 07:33:24 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:3680:a1f2:fbbd:17b8:f31c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8650f51sm110261075ad.148.2025.06.24.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:33:23 -0700 (PDT)
Date: Tue, 24 Jun 2025 07:33:22 -0700
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] daemon: explicitly allow EINTR during poll()
Message-ID: <ixvokc6osmpxbhsla2s22yldtf6kuyxptnx2f6jh3cchteett4@ubvbyxpb527c>
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
 <a450bdb0066912d135dd242090b012de0bc18180.1750774122.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a450bdb0066912d135dd242090b012de0bc18180.1750774122.git.gitgitgadget@gmail.com>

This will need the following fixup on top:

---- >8 ----
diff --git a/daemon.c b/daemon.c
index 542e638223..f5f0c426c3 100644
--- a/daemon.c
+++ b/daemon.c
@@ -912,7 +912,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
 		add_child(&cld, addr, addrlen);
 }
 
-static void child_handler(int signo)
+static void child_handler(int signo UNUSED)
 {
 	/*
 	 * Empty handler because systemcalls should get interrupted
