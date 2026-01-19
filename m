Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27ED71DDC1B
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 00:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768783467; cv=none; b=iRP7SEXTTGDrF9EdRr1oaX6bBeWkjknFWUcmH5Y15zixbEUFjENjLrbg+w0kCqRNHZ6DFHSyn/GUwlCVrlPFCYz7MOyCH6mvw+v48R47CEE/2I4fE9ryrYahicQyqy/9k0GLZLcd1vFiCOCAz4qLhVJoTYnbmceE3qkLWZK3oxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768783467; c=relaxed/simple;
	bh=4zq4brfjLOsIyF1mRHirqgLi5nSG8UKbeMyG3zy+9jU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ads7HegmjmU0mJzViCAWzBXAurkCzn5RzziIuGghiswnWVSvfX6iYO28+l0qmqP6uGKhiPfK+ZVjvklPbUIoMQG4yLk4PE36r/pYkPbc+FwQ4+4f4lsaprzMVaHmIoQbu80C+BGqY1g+g/m/i5mm6Pmh7t4QwJuWAglkrvs0poQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLOhq8vJ; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLOhq8vJ"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12331482b8fso5296442c88.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 16:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768783465; x=1769388265; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zq4brfjLOsIyF1mRHirqgLi5nSG8UKbeMyG3zy+9jU=;
        b=jLOhq8vJviVaYLEtFF4CSeITDFzRm6K0rRpJ+CpLz+7xpgY0CVTYDpbacAIjNb/bDo
         zhuUmrDnZApefbLbM+B5cuuM7zirmnWQRwr0fbSigzwLuK1ymGSin0+slnYlH0JeXeZ2
         Io75pHw6a/MRL6ZnDjOikpe2P0myc7iUbHt7G5X4LuZcgO/fWBNzIFfXat7d3tOrxw5g
         6MI0s7QrrMAnVXHJpHUc0JKZ3F1wuXiBU3rZvi+gZjJHsuAyYCUPusGmdtzCIYK7t03w
         rCopCjC+jWvJhGjp44Y/OsvKu0fe1R+e2H3lbOJ2987OlHJlHNXlV+rE+RDQh2s/p3TK
         Q44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768783465; x=1769388265;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zq4brfjLOsIyF1mRHirqgLi5nSG8UKbeMyG3zy+9jU=;
        b=r81978TtClzmanPy4g8VjKymIHRaC2nU1byAXCD4VXdSXFgPy2r7fyjRVM+hdOOswa
         WSOfRRwiYB8MuVdc7s4xmscsc9YzRjCTH6z2YwaUnkiK82857oqQBLNID2URZc6PzFNc
         gjnwMH437kkxb5aCVIdbMgiaB98PUdkWSTqGS8pFwCufyEqLUXy/IVYlAJC+HOa88HWe
         UfWawp+zvBpuoLIdEKHzu1rsZ3MwY+DdFnzF1CQiSEKKP2RfN++g7SgYBc6mLg+0vNe1
         mwa2ZcldSVhujH/FK3jUbxLC2HA4a/jAaEQuCoBo54N8t2ifdlmoLmWZhuCV+EhRoO8U
         orbw==
X-Gm-Message-State: AOJu0Yx5glFqtdlvdfIxw1gl7o+isUknJWY36Zt7+R/Ncyu6B4ILxBS0
	i6HPmHpSDmNfNzvqOZdEYyr7yaggm39joXL0sgT1kwn5G6/xvjNZktlh
X-Gm-Gg: AY/fxX4SN0oTX60FYiKvrjMryMiGuiNWW1/kFdBL9m0mJwkaYRbw0g2XWxxOV2ynrxe
	L/ztG2XmrPbviD766gp9P1TQf8p5VtXTbHVkGItVhq9h0JcOIpyILULqp/SZKYqFlQ+Vh3ZwhWX
	7C/QNrj7i0Ad9zh5/zeeE9WJivKgtNQh2o9sEmI3idU385+m1heXQ3VNXwqfwZAWXt8SJ+gNZaT
	tNOblmb86jW3AurfK/2zoCegJLtWG+5bl+BhrLFTgpnBUFcktm00d/MdcoGVdTbBhXPzOkEarw6
	wAwhum1D3JBa/2IjWHz3shGZahNbOIJuxiZWVvXBuHL1KO3eabRAalnMe++zlB4r0h2kiDjqJen
	e4Aqk9daEM9+0s8Jbi4EcMDrdGduRi6SbH/uxIZCSsKq+EZOdkzsvqrpb6xPXo4e6J9lGrLSRAL
	s4KGwFcCYht/Hwl8uYAqjBEYKq+PVCLJC7WLV7CLYM
X-Received: by 2002:a05:7300:5713:b0:2b0:4e86:8163 with SMTP id 5a478bee46e88-2b6b3f18cd2mr8053739eec.13.1768783465013;
        Sun, 18 Jan 2026 16:44:25 -0800 (PST)
Received: from smtpclient.apple ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm10813097eec.14.2026.01.18.16.44.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jan 2026 16:44:24 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: Git project and GSoC 2026
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
Date: Sun, 18 Jan 2026 21:44:08 -0300
Cc: git <git@vger.kernel.org>,
 karthik nayak <karthik.188@gmail.com>,
 Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>,
 Junio C Hamano <gitster@pobox.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Meet Soni <meetsoni3017@gmail.com>,
 Bello Olamide <belkid98@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <29682837-D2F2-47B7-B1A4-5CED32FCCA49@gmail.com>
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> Hi everyone,

Hi, Christian!

> Please chime in if you are interested.

I've just finished my master's and I still don't know what I'll be
doing in the rest of this year, so I can't guarantee that I'll be
able to be a co-mentor. But I'll be glad to help in the Developer
Pages.

> About (co-)mentors and org-admins, Karthik, Justin, Siddharth and me
> have already expressed their interest in (co-)mentoring in internal
> GitLab discussions. I am willing to be an org-admin too.

A really good team!

> Thanks,
> Christian.

Thanks!
