Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09563E485
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758312; cv=none; b=jiCKbAqyquGeB7b66t5YHH9RYxLytVTA1EJQxb56L2mRy9nc3/9PdE/YN5/wGPkFr/Wnsad1kBU+o6SKd6QBcquuyRXRe5bClOXHJcTSXogE9WXJHoA3TYJLQLvfmYKmTZwu/33raOxotXigAgK03KmdilyDtq1gTdZxIXRQghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758312; c=relaxed/simple;
	bh=rgm3suO2ad+3ivL90APDk1qg31/fN5Jo+MlKnWTFezk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Zy0VMfa/KvVWYkFit4STqtYfDiRydgl893WPlJXGVahDCBgDJmiqBrfKRSvH0XRWaml0evu13KkboIsQZb2VpkyPbLMTWSmxH0KwwpBTyr3PEfVIdWs0SLb1BiqK4p0WMnPthca4OupTiUJt50/WHYjt78kskP4i77cD7BoasLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TanNRIZP; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TanNRIZP"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4c081a0d56eso83104e0c.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707758309; x=1708363109; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ag3/nCkdPt6XBEAaeV+aFn7UYaiymrfRo0tNrw86h0s=;
        b=TanNRIZP0aXGK2TafKOP3Tv9zr7HJbgIm13eg0wgQjglsm+w+J4gxf5i0cu1P0uN6L
         zAMnjJn90p2cwBcQYhwWDR1l49D+WVP3x7QTKHvv8oSzSQM3uIwqwadO15acMNIaXcBk
         NQHZjyGslhNYyh/rIrFhy5yJyjoaP0X/gNDIXN4PXzq94zIsWdkH8W+b8e2GX1VQTsWD
         x4swsyJvBnU9wvMUsE7cF78+mRHpOjdo2ZnmuwYCY2cYwdhDomXJIhFB4LBQ5Fr0mkHb
         jLiYxIs4VZBVJ2m05fcBD7V/nBhFFKTT0uPB4Y2TkfO1ccvl+OzsYtMjSOeQbj81Uvky
         0tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707758309; x=1708363109;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ag3/nCkdPt6XBEAaeV+aFn7UYaiymrfRo0tNrw86h0s=;
        b=d/+vGH/xBZVjW3WMSstUjXdIYjxr+uQ6UfvM5kphh1EFfJz/aJsCeBRTduUAdqqoO8
         kGyv215u6d9LQ46j1ZIEV+EFVTviQ5Picz7sM5DW4pvx88Rdvci9BB+mzyEw3yGf0rt/
         HIqHgWWsL+lgM4JhEwwAyBRG87+sV1mvPe2dc88cQD7AnOM5dxXnpVZ65AYDiauBfNRh
         /kRDzFd4y8EU/vg0/Roud5lk+H+lZ7r/YTE3hUCUjCY5oqhaU6A4KZIivUPyPoobSI+o
         dm1fcql3c14pwfiCXz5YbaH1Ck16hUAw5KbVBPta8W7PcuB38m8yoj23ux/PFwxX1ufu
         u+qQ==
X-Gm-Message-State: AOJu0YzVnb2P3o4dTy3BVnfP5SsZSkgwN5GxGC6KMqDuaQpNCSMRABq4
	gxERj2aHnS95mPrEwZ1+xDeDEFYttVCIVWY1Mi6IMO7L1sci8y3Iae7CjSZLgl/yfF0k2rzRaJF
	t3vYAVLwy5EzrEAJ6nOHF1Y8uQxz1C6lrq6U=
X-Google-Smtp-Source: AGHT+IEDlqknzX+EKr+iUmEeAN1P9XbmSaRrdRM2tdyejG6EKUSA7IOdWqzRLeckLtgwDk2zc7x7/sVW1DxFhLvu49U=
X-Received: by 2002:a67:f888:0:b0:46d:14ac:da4d with SMTP id
 h8-20020a67f888000000b0046d14acda4dmr4851980vso.15.1707758309301; Mon, 12 Feb
 2024 09:18:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABn0oJvg3M_kBW-u=j3QhKnO=6QOzk-YFTgonYw_UvFS1NTX4g@mail.gmail.com>
 <xmqq8r3p7glr.fsf@gitster.g>
In-Reply-To: <xmqq8r3p7glr.fsf@gitster.g>
From: Xiaoguang WANG <wxiaoguang@gmail.com>
Date: Tue, 13 Feb 2024 01:18:18 +0800
Message-ID: <CABn0oJupUjbu2k0adFqcjryj6=XtmwQzb0vMGtYan8WccPtYxA@mail.gmail.com>
Subject: Re: Bug report: Incorrect GIT_FLUSH behavior in 2.43.1 (regression
 and breaking)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 1:11=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> > And by the way, only accepting GIT_FLUSH=3Dtrue is quite breaking, it
> > drops the compatibility of GIT_FLUSH=3D1
>
> I do not think so. If the polarity is corrected, git_env_bool()
> would say "that's affirmative" when any one of the "1", "true",
> "yes", "on", etc. is given.  If you have been passing "1", you
> should get the "always flush" behaviour.

Oh yes, you are right. There is a git_parse_int call in
git_parse_maybe_bool, so if the "flipping" could be fixed, then
everything should be fine.
