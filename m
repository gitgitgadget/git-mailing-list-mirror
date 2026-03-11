Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B4635A3B5
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256150; cv=none; b=ntYKivxrB17P8vcpHF6OK1QM2M2rlXoIC4jrBnIh9t/KmXuEa6QWv3izSr9Cs+oTEPW3tGH2540q3hZO032FRYq++zUi6z7cVT2u/1p7ZVXDlz3CKwPqPPV8azov3cbTEil0u3fUy45IZFGd8B/KufZZXpF9BySj9dmAjvDIoPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256150; c=relaxed/simple;
	bh=AxP64KXCZf0F/eB48hIYxoklTE9Nj5zKXrU8wdW/Fso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeQuGsbkUYNOeqFfduFWoAzL7ovbn3ky5eUKyrak/EqUafN6daahApLP1Ih/GOBRd36xGnhe5Seh4W9LXsZVgZVw7wJyn92RAA1Tc+f3OJJ1368GG7u9cuhpddh7HaLDR0bcN71eRJvy4JBF/Aodq45ni2u12QCH9rqzXzqAXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1srmAQa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1srmAQa"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so1664075e9.0
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773256147; x=1773860947; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QjwQeWrabUwr7o0pgcTuIHXSiIbPf7ElC9n3K7Gbuzg=;
        b=f1srmAQakFqo9OxcsnB1AmythKO38EkQ0r1bTsLa6+RLplF/j0AAJm75JoxMcBsiW9
         j2DAyAukLYlOTYX9Rwwqky94KF3dB56boyS7cP8E4oEoYXcsBaxw/oSICamisySBGAt/
         ItL/p9g3epp2ZfklJLcx260qCwUbhWKdQOQ17YT0i0GfaPu6gvuSeAYRHvH5x3nmRUAJ
         /W+5OnYcdyrmH8HKnMVGvsvz52W9N92r6INGfajwRtwp4+e0HezghkZypDdWjFUH7/2k
         GL2zMykWi5T8XDmabxYez70xTIXYD2zcsjV4qnJGHJql2XpLv2aslMQgRhi7x9b5ojeg
         Kflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256147; x=1773860947;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjwQeWrabUwr7o0pgcTuIHXSiIbPf7ElC9n3K7Gbuzg=;
        b=Ogcr0A3Bd+AhRS79ojYYGNSQCX8voHWPX9J/tkENmuxGi1ZLx5Y/us/XB7YZ/nw8i6
         e1cNjZj5tYEzePqVaXvZUgpGxyQtq3o/wkd//IB8KRXcTL9084+8gq7df8NCOlkTenz5
         jc2VAv+5EXBbUD2XAllDDKijAFSc30ODGDNDN43c2vxGpYMGtPLV+HHLLX3Bi8XPexZ5
         RVV0EKVoANE3nNd6Km6n1qlpMGOQJM4dOd6LIP+wPaYm2BRkv8A4CRw4Uk59I22Td9Uj
         ZmxiBjq5FjuOLG3vs32xWATIHJ9ijgCxOSyTSwBcezufU8fTxIjDoslidtxKdkDYSnmn
         VPBw==
X-Gm-Message-State: AOJu0YzwAb+GWISqEFwgzJeemAR5ob8YHqq+W73ktZX2WGwV5A3aAgNk
	wCN8ujHwaXT0BZYWMZ+ma6rhgSNed8Qi4bd8T0pUJqJ6BhsXVibFsNNr
X-Gm-Gg: ATEYQzzlAMshD1YVznQiEERREg1x/dQY+XdpC0nvxlr4oGNpfNVSGxufQ5iQt8pF0sn
	5mskp9r4/SwMhzYENiimocMq4XujyJmWbZCW6m7xH9Y7x0Y1NRdWIse3zO9BL9yLzdwu4m3+bPf
	pXfUWJQlLgJPLbirn9AjBEIp42bJFi+0MoqlIfyJmtp6p9rKALveUV06BXq8QkpyeTETBaQ8VoA
	48Ufb+2iTypSh4SmnXA6nfRr84AO3kWkhBbhUuaqTQxus+gEli3bliXwmlBMjetTVVdczn8+uqK
	fu1MTT3xJ2xePMoD4PA1hLDc+PQEl6P9yg0nrCSHz/GTsXRrZaDTi3a4PbmpTgQ/V+7JZ4unLiz
	SaNA++MJCgeJJUBWz/E+r42hgmXB7l/6Do2fxzmE17UVsC8DAfySOnNL7z46Rmzz6baxnaU6+js
	OL3JyJQGUw9gxUk4FrhZw=
X-Received: by 2002:a05:600c:314d:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-4854b0e8111mr67599835e9.12.1773256147037;
        Wed, 11 Mar 2026 12:09:07 -0700 (PDT)
Received: from gmail.com ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0d4977sm25352235e9.19.2026.03.11.12.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:09:06 -0700 (PDT)
Date: Wed, 11 Mar 2026 22:09:04 +0300
From: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org, christian.couder@gmail.com, karthik.188@gmail.com, 
	jltobler@gmail.com, ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, ps@pks.im
Subject: Re: [PATCH 0/4] wean start_command() off the_repository
Message-ID: <abG88QUMLptyirHg@gmail.com>
References: <20260311151923.4178655-1-bkkaracay@gmail.com>
 <041604ef-0bdb-4c40-a9e1-60c38ae664cb@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <041604ef-0bdb-4c40-a9e1-60c38ae664cb@web.de>

On Wed, Mar 11, 2026 at 07:18:10PM +0100, René Scharfe wrote:
>Only gc, pull and auto-maintenance set close_object_store.  If we
>changed them to set a pointer to the object store they want to have
>closed instead of a binary flag then we could leave the other callers
>unchanged.

Wow. That's... elegant! I have never considered that. I will start
preparing v2.

Thanks,
Burak Kaan Karaçay
