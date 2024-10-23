Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D4142623
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714277; cv=none; b=HgqleeM+AFNyxt4yXsMcP97I9U2uBfyrD1f9TIUKgPMGRWFClkj1mCUOhJ/YG95gKm/+hJVafzWAkwJJlIcu6B9R79B09ozi9/vQ5Z7Kf/7wugQqeQ6Puje6AWGX7fo3fklS5g2jXOl40paIo1f7iF85GVgjPpm2j94HdeZcSOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714277; c=relaxed/simple;
	bh=4SqE6qe26hELZj4meqI5jEeXhU+YSBBz9Kdu/cdAm+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDZTWq8sfia/Om/6Sk5EwpO3A+IwSiI2eTZskG62csr2Ly6J0oEg7u86Uo4n2+Z2WletdJywhzfL/jJRTtfZ4X3MHNjaIWKivZxXdFTWyZKYOQI5GNQgv9NtXbqJdhbXIXgE+OUIUr3iLmodo0B2G6vLUdZ2k3lySUVYJWo2iQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=xsYm6HIl; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="xsYm6HIl"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e377e4aea3so1300117b3.3
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 13:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729714275; x=1730319075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxTY2kQY1Qcjpif7C/rA3++J7PWev0JmKPaeEwYF/qQ=;
        b=xsYm6HIlmSRxpgRbQsSRiq/kizrXoeAzEg9P6aIXZDJG+D72Ga1DCFhrKWVd7qRgy0
         YNXhV5MmejQRjupoqD7W7vDbRzqAk5PSvR2tSynZqVz5a98aQsgHg1laZCymTOCGToq1
         ihuediDgm5Et7lfkYiJBBDEJNjRE8xMLpmiO9k/AXSo+NmW8yK0ouqWK7qgeMfU/Hdl+
         8sY4UlpGffqKmrTZDCjpqJ99dBo/IGRCnt/13TrhCz9U9I7yW5cPKwqiJtsg+xKOCLDF
         062iosRLYo5ruZ/0f+yHpyuXkHhIaLpNl8us/zURREskz1xSd2Jcm1GykSowCaoFdaiw
         KMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729714275; x=1730319075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxTY2kQY1Qcjpif7C/rA3++J7PWev0JmKPaeEwYF/qQ=;
        b=qb1aPP0bNvqFzi0LwO3j2dyUJOKbXbfOQ1ljCS2Ht6uoTDdR1jKhdC3FXLtk/l8PqY
         m8UWIibXru71CTiWu+4MGTjCD9r5Q2OhNk32B62BhekbiQqwhNLlB4M00Dl77ti9dwpO
         Z/LLqOgLoFHB00DmwVdGBPI6/jU281flf1riGFgp9BZyBstE7ujAEZWZqEFcA73n9erB
         pyCYADnj7mxsZ4EYBwRsb3fT5KuH5uifOVFFTw7D1aBlrJAZeyGKA68pKFu0C0XC1GCJ
         mMB9EA+Nwi9fA/G+dc5M08W/TMY0HWQhrwK7rW1rrf5urErH5k2D04W3blm6IDfk9sce
         TOSg==
X-Gm-Message-State: AOJu0YyOZalSt7b0IfqQfV1hZcnrzApBxp7GWLhCsPs1MsX5uBhJFR/G
	6IrBY86qe0pUvW334zGDe4ErYzNWMSTSweU13pl68MECaJPdlbqIzhghiT3WYOs=
X-Google-Smtp-Source: AGHT+IEPiAtE3Khp9dGVxddJMt+JByWWR5DltyiWQAnHcvqZY7DH5dMCqfFUj2ySZRXMJyTRxeM1mg==
X-Received: by 2002:a05:690c:f14:b0:6e2:ac0a:8926 with SMTP id 00721157ae682-6e7f0df5ac6mr39679567b3.9.1729714274970;
        Wed, 23 Oct 2024 13:11:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f5c32sm16922687b3.18.2024.10.23.13.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:11:14 -0700 (PDT)
Date: Wed, 23 Oct 2024 16:11:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Emily Shaffer <emilyshaffer@google.com>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>,
	Han Young <hanyang.tony@bytedance.com>,
	Jonathan Tan <jonathantanmy@google.com>, sokcevic@google.com
Subject: Re: [PATCH v2] fetch-pack: don't mark COMPLETE unless we have the
 full object
Message-ID: <ZxlYYQ9VULcqj/YT@nand.local>
References: <20241003223546.1935471-1-emilyshaffer@google.com>
 <20241023002806.367082-1-emilyshaffer@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023002806.367082-1-emilyshaffer@google.com>

On Tue, Oct 22, 2024 at 05:28:05PM -0700, Emily Shaffer wrote:
> This change is also still in RFC, for two reasons:
>
> First, it's intermittently failing tests for me locally, in weirdly
> flaky ways:
>
> - t0410-partial-clone.sh fails when I run it from prove, but passes when
>   I run it manually, every time.
> - t5601-clone.sh and t5505-remote.sh fail nonsensically on `rm -rf` that
>   should succeed (and does succeed if I stop the test with test_pause),
>   which makes me think there's something else borked in my setup, but
>   I'm not sure what.
> - t5616-partial-clone.sh actually does fail in a way that I could see
>   having to do with this change (since I guess we might download more
>   packs than usual), but I was so confused by the other two errors I
>   haven't looked closely yet.
>
> And secondly, I didn't write tests verifying the breakage and that this
> change fixes it yet, either.
>
> I'm going to work on both those things in the background, but I wanted
> to get the description and RFC out early so that folks could take a look
> and we could decide which approach is best.

I am a little confused. Here you say that this patch is still in RFC,
but the subject line dropped the RFC present in the first round. What is
the state of this patch's readiness?

Thanks,
Taylor
