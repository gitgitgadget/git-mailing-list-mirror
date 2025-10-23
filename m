Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244392C3745
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761255260; cv=none; b=YqoTwE5i8cQdUMAnXC0o8767ab3H8izxRuav6PeHPetPVZwIBNnAGMPQG2PrAYdenGLD3NJo/K3HrzCPA3G1pcISjt4V0V+O8I0sV1wfiD4pFFUMaXPqCRu9JZXPhBeQacRmmYjKWiBKZY2/LknUPysLXPevrQSYOYrVzhYuZe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761255260; c=relaxed/simple;
	bh=0gYr0x7tzlxDaheHVp5iBBlBPQSMw4eERsFF+TNVDG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHmdXsjjBbVJFk2Xqn/d4+Tq5/6g3JcQ4TpcqNSFQUe1BZ/taI9PDyGpZPjz+zO7rPx0H0g6ma1kaQGZ3KsP/EmPlW0uq662M7WCG9CP5AtHILvJX1b4gy1BOuOGDOI0uWs7AQMMFoInpUAvPCFgcQ0Ym5yOuwHl4t0Nm8rRfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bfpJcbVM; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bfpJcbVM"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-941073ba029so41088239f.0
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761255258; x=1761860058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Er9rWf6KiATD4yUkeoDGlsk5MH7C38eLgTH8kGLr7M=;
        b=bfpJcbVMq+1/h8drY4aKW8hIoLVNmMuipYgBeG2JkKZsF1h/3S9qXIAjD0S8sMA85T
         mY1vkPSyQghStTBk/Lo8inF44SZezC6TZa7t8ALOIhlJGU69brIozCgDzUaPRQJkFhzH
         w8cvCt+OxdzxU+ZByCRwIfYKNrA0lUgnjqm0wrh9lYBuvUUa6xjj+6mB4TMPXtjU95p7
         QrfZdQMkJNXv1WtYRNVzHdqTNjDBMT9LY3z5S66GjS1Bsj6D18sI5pPCZZ2GLIKmw/4G
         dv0iF2Sp4k7ocymA3JIe59t7tjlvlxPEoSbUYWkj0U2NpRIluB/sg4XK0QuyvLDVMr0v
         wBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761255258; x=1761860058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Er9rWf6KiATD4yUkeoDGlsk5MH7C38eLgTH8kGLr7M=;
        b=oCiOlEXBvfuAtz4T5cjpo8R7ADdjhopevPIo4p469Wbrbg6jeCOPT4Q2G9cCKG9w3J
         qxgQRemAOMNj5RzqHMOs/e/KvJQMnITa9U5fn7M1WBvd+/yXmvXXl+6AwPfo875akuAR
         Yicx+liJ6GXxfs73t6g1WuTbDlEE80hKjVZE3Ha6R4NDa9qdYhmxIPLa7v9ZiFTt3ZuI
         v84ozqtzAlB9syN2iUElibQ83+OIoPxwYodUBmcWzgxwpCQeEpRwVZNXndS/ruRejG/J
         PvUblKGpmMSiKPrYzyFPU0TvrXGT9YIrNbRQpxLERsolUHTOKb1ISguxiDHw8Yg4ITgi
         Smyg==
X-Gm-Message-State: AOJu0YzFIQh/So0xoaDyyW7cBAnXJ68jBa9Kmv9KTkp/qEx06LVD1uz4
	04vp5HFg+T2FlKK0J7FB3oH81xSV7BSguYZ5Rcee043ohJCsMossn2K5LTdBxetwME0=
X-Gm-Gg: ASbGnctT41zWxY+gdrJuaLID24OOK78pc6BjYwB9Is+h158hZb7+TOKomRGoMtn6kHw
	QvtlPHKRv7hGbtKRxrrODj1sJVPkxLVdCpd4c2jsUndWBOc0nB7mnm0weKBvMhkNWGcIIzKxsOO
	S0FX6p115SsiXvJmW5yxnp6UwNpLaI+yUnWam5wUzH+XsXQ0XZitJ8lz4MFxqX1Kv7Ejp502f86
	jLHd7JO2fV4MQofos1Wel7M9kdkrPKT655pitbO3NFN2foXufo9VG1hzrwmVYYHDJZ9dqJ5pCdP
	SI+DDCH3J8zHX6hhvbXIWfq9ygkgdV7T+LAUfPkagwgWa1bmFiZCL8XfeSY69wGlvCrojhTcn5a
	m96ahIb7mVtfSMbmxeIBdJb823krL3st+S++HFn2cByqmFZlalBluE87tciitQohTp3HIOPKua6
	0f457LpBYqRxZFTrgvQGr287E1EuNUBi3qk7rV9t2X4TFbzCo+Oz2N//tv+4jaGctPelMlLwkOd
	83emHo=
X-Google-Smtp-Source: AGHT+IEwkTxFVo60YNG3Yc8f7+ntyEZJ6dWGMwx3raOqULSUDH1pcG+JPOoGz7RLmMiwbnX+y21lpw==
X-Received: by 2002:a05:6602:3e8f:b0:93b:c6aa:5e14 with SMTP id ca18e2360f4ac-93e762c1ddemr4165636639f.7.1761255258157;
        Thu, 23 Oct 2025 14:34:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id ca18e2360f4ac-941035144ebsm102893539f.15.2025.10.23.14.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:34:17 -0700 (PDT)
Date: Thu, 23 Oct 2025 17:34:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/9] builtin/maintenance: run maintenance tasks
 depending on type
Message-ID: <aPqfWGN29S+kr9C/@nand.local>
References: <20251021-pks-maintenance-geometric-strategy-v2-0-f0d727832b80@pks.im>
 <20251021-pks-maintenance-geometric-strategy-v2-6-f0d727832b80@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021-pks-maintenance-geometric-strategy-v2-6-f0d727832b80@pks.im>

On Tue, Oct 21, 2025 at 04:13:28PM +0200, Patrick Steinhardt wrote:
> We basically have three different ways to execute repository
> maintenance:
>
>   1. Manual maintenance via `git maintenance run`.
>
>   2. Automatic maintenance via `git maintenance run --auto`.
>
>   3. Scheduled maintenance via `git maintenance run --schedule=`.
>
> At the moment, maintenance strategies only have an effect for the last
> type of maintenance. This is about to change in subsequent commits, but
> to do so we need to be able to skip some tasks depending on how exactly
> maintenance was invoked.

Thanks for writing this down; my initial thought when reading this patch
was that we could distinguish between scheduled tasks and manual ones
based on their "schedule" field. But this makes sense: some of the
scheduled tasks might (or might not) be appropriate for manual runs, so
distinguishing as you do in this patch makes a ton of sense to me.

The rest makes sense and looks good.

Thanks,
Taylor
