Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCF2DC35A
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834731; cv=none; b=pW+R7Zq2y6iVohFKwZjs918eCmmyVCs7tqt0tOAc6rYZ3qwXqC7Rqp/CMNJZuFk/yEoonPApCqnSzegxpZ1LSVINwoCUKuA8gVMRFpaI6qWbLMzPMHQt68Zs2WWaT7cVlzWLSFxjdMRiftO27Nm57aWapKZBZJit7XmwOH2hURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834731; c=relaxed/simple;
	bh=HeFsKZytmQCQj8JuzjV1hAUiTS0bBFgH4L9KGUuy2IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIquKJwrhZ2NgCHpNgb5A7vTnORpnICMdlt7ZrOfzjXxnxIYOQyq0xE22cM68fN4hTvxhgRLILYU0xkCcbtfZFVfk3AQB/NYZ5bPJFt0MZRaCMlSLaUWWHC7ucAg6nTPGHveGG7NBLNns0uLsbRobssk0xDaBtCb7DGfBdAa7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epYL9HfZ; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epYL9HfZ"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3ec3cdcda4eso2924719fac.1
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 13:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765834728; x=1766439528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeFsKZytmQCQj8JuzjV1hAUiTS0bBFgH4L9KGUuy2IQ=;
        b=epYL9HfZR/r7eLUxbqzJyNbObMEMkB1ookW+IlZO1ETkeLRv3bk1QUbl+Z4a1hCgZj
         6WdNQsF5RDo/5APjMgf1MHxHqb+sQL0LzxOxpzEayeSjON5F+9sJOR6FSbK9uPonFatk
         DSS/E7+6/Ju9vi5xGyQSLbASewo2NwKxjs97GSolFDJY2fhnMZ9lRbu/xu5e6qn0uvrt
         AawlTP3Kl2NBpsoZhcmdS8kriyF6Tdr6PQvybl6LsVoYrkr5x2S3Hd8JHW16y6P9HDTB
         P+WoF2inSl02iW+PjwWHZoortECbB/qJ+tC6OGVnM0Hq0EoI3OvCfxJPMUTygcEBciYv
         CSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765834728; x=1766439528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeFsKZytmQCQj8JuzjV1hAUiTS0bBFgH4L9KGUuy2IQ=;
        b=WGxq2y6CT+/fPyhec8bKnbwWmnsAhLBmYtvVmDxrS3RTbeDN2x1dTNlokWqqSMTu3H
         hMMLAJLW0NS/9k1p70CV9rkyGAr6HLGPYTj8ptAcir6+OolBjjPUd0hYFZUTF21Zamv9
         9Gc9Jy3oU1y2vRqwMBnZNPAX9NhJa9O4sSF0YAKVkuW+Sqw/AsE+hMVqder8R0tsPhc1
         fWxlBhLgY842YnNdflp9Yq12xMbP+jcmmxHLzjTl0Jx5OzfJuBdz6duePtrkKQOn0ybH
         ABogu/YyzCRSXOtcFCcuDbKbDhsusLDCm0DO1q7HJu2sc4X6/p/JrVGdwKxbDgJI8xTX
         6y1A==
X-Gm-Message-State: AOJu0YwuKAsuFjhxdz0pmjDojWs8TqFWTBu8dZghOE6BsfvYS5rHc00q
	tzQkrQZ07EjfLYy/Ayu05sNz7m4OYwo+q1+S6r1bNcf/K2R13Ogpmqzg
X-Gm-Gg: AY/fxX5dTzbaOBo9oEErir3bDNZga+yVCEp8tum1Xr/GKuYx+GZg48D6byevWNBnsuM
	LbXPAvnnQmJfA+F2aMxXCc3s/+qnXa5fNyMXOHM8IXDZ6PsKjR6m5pJRg6shAf57537Zu6Fy4F7
	J/+DUCbO2d4FVEzZofNeDS3oaP+/V2sn6boaB3mLhwzK2fbzp3MPMqTt+CjgD7LV2I6CxY0jnSl
	0pdXgtA1heo1OqOHhZS+E/SULPK2mLtMLmWbEcNOjYOddeOFpQKQwh3GZYX28XoTMb4PRFkaxb/
	ksL0XJ2Mn2KRpLwD8Qfgc2BbDBwHZ608LQHSNRbG07mbao7H3JQKEfhw9hK+1ct2zjibtmuoAtq
	Ts1k/jFhTGBrg8W2C98rXnC1vYVmd68MO8MUc4pWcAzWKdXGCRpXGX1WroEPzb6LfnsD+72OE5B
	tbS9zz
X-Google-Smtp-Source: AGHT+IHsBxr07YWYINwXlcRe3wdfB5y4idrzs6jkihIsMk6WMQC6AxIbbI7y6qtsncoZ6SN3+cq73w==
X-Received: by 2002:a05:6870:3211:b0:3e8:9ac2:a4db with SMTP id 586e51a60fabf-3f5f8c1572dmr5699958fac.36.1765834728315;
        Mon, 15 Dec 2025 13:38:48 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614e374ffsm5158427fac.16.2025.12.15.13.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 13:38:48 -0800 (PST)
Date: Mon, 15 Dec 2025 15:38:47 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/10] packfile: pass source to `prepare_pack()`
Message-ID: <sohvmebpsi67epmtm527grrxfl2yxljehk4masb3zfljbaffqd@szgp3mgqteyo>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
 <20251215-b4-pks-pack-store-via-source-v1-2-433aac465295@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215-b4-pks-pack-store-via-source-v1-2-433aac465295@pks.im>

On 25/12/15 08:36AM, Patrick Steinhardt wrote:
> When preparing a packfile we pass various pieces attached to the pack's
> object database source via the `struct prepare_pack_data`. Refactor this
> code to instead pass in the source directly. This reduces the number of
> variables we need to pass and allows for a subsequent refactoring where
> we start to prepare the pack via the source.

Just passing the source around is indeed simpler. This patch looks
trivially correct.

-Justin
