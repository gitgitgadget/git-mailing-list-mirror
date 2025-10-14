Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3AC246BDE
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469570; cv=none; b=cjALCV3ipkv6z+wtLbzFn5FbqPCRseEBCdfxRjMh/pT0LcmoxNdxFDakerF/Yeg2gvO3UkeDZgpQLr14HfbsrO1b7w1YAV9K/ZZfCu3gIPxKgul9EJQQnMIi7yRnPO8GHMDa82XDAl8u3Uu3mbdVYJ5WvrN1j5uG+ap6gaA+AZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469570; c=relaxed/simple;
	bh=MWZF4kXQpfpSZo/qj0b7JEeVuMi1j6RvZmaVAM5dLGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlb6qF6eoAbYZ6+nbt1mq7Rl1QdhFr7ynbmk2KApyyBRU+JK7bSo1NhLvc7dMkTuBgYtqxn0ddYivnAfP3BxtcqYl4dEMxm5rToCNc2h45vt+/gLvJ1tBNZX7FjVkhrQLT14Z0mGE077405Cd35alK5okRlQeRpIAHMld2rqf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek5TGvqz; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek5TGvqz"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30cce892b7dso2748304fac.1
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760469568; x=1761074368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cJMyIVsr7c+1DSgmMuxpOpzeK5h+Eti2tSOcjhFWzxM=;
        b=ek5TGvqzA7fD3tfAGnkq7qoX8btBRaaO7IHYCtXgiWo7FoM4hmzTUV4NiKy3V2PJKS
         x0RaIZNL5ZtJcA4WY2vXb9iyLG9pVS0MgfmeLtUjKDRhKb15NZeOpWenAsMVv04LiBLI
         nLeb5QgiT1Rxv1cYOGXGxpk+RLxFHEMnUfC0j/OeSpOiYjwFNxywM1uljHRpRpbOelG6
         tkoqi690AojY6mA0EeQlahTk7Es7T6bgF43+/zOvTJOscwuV+RKTJlLeM0oUajU3diVN
         gbvKbI9LjzQI3mdkoG6EGDvkd5YcQv8+wlwNpJ1oZmtKwdSr6lIc18MnyzvgoC55BC0T
         vCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469568; x=1761074368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJMyIVsr7c+1DSgmMuxpOpzeK5h+Eti2tSOcjhFWzxM=;
        b=NowzdiRsMU4Ql8l2EiVGTFVj3cg4FDcmXPzmRO2SVFdclpaYEEL0TiZZORpSN6xujh
         i3Yx2B+mGfQswpuNJPcjW0QKFWLEoYUDe3PLlRrw7dxh8ujyNI3BkoFBcEnROK/ZDu2G
         Ju6d7G5x0RYWI8tiOhnG5YyOOsnDqfrFGNrPZ1L0f/PqIHnZZGEJ7Icjn4PMcdmNaEyF
         JoWPHAMU5DgZpY+sZg3MBoqLcJog/1OlGd3trTWsGZFA+sB1ZXmAGZnrMdRU1DYFxdyL
         7wB7jsyepQqmoyVdOuE2kyDFOOcTpxBX2+PnZJ3Me9x2hpQz4nGcyL277FKwSCDqUBMw
         FXrg==
X-Gm-Message-State: AOJu0Yx5vdE6XfnnjkS/RtdvgBJckPSsegMl+4RfMMBuru+ACNXN5v1D
	k6U5Xjiqa8WraGxQqZrmi04LivPNjJG0cPJkSwFu++gPFsOFrdUgphRmTj41/g==
X-Gm-Gg: ASbGncvVwWhLR8I3l0+XBHVdGeOnapgIX8zp6gbrk7lG552hdmvY+j7Sjs+KISFT6oz
	GQpHJ2d8clGnEEvIZXu3F57OxWUf/OuqSVVRYWz1qol+DTycb9JRQpz4ou0G9xvpCf3rgqcg/Hf
	kK349/FaXYl6BD5JdrDQWntcyUw+tHOzOrenc5dYQZZlL4bACiCx7X6gSeopDUoCHe8croz7+2d
	yElPPWfwwoeLctdMwAjs//1qi4u1E5xYVhUTi//y/+daZPfyFuSeNF4RD2ut5Jx+axRvM4ACsUQ
	9K5MpcKvFN2jAXEPDjb55bUc1d1PSs2RQGLo+CKClG+Te9jMPYjzE9d1G0BcnvrHAIGRwz4Z1Gj
	hbFlpUCYpyPNSWAL4CM4s4iRvd9X7bVP1WsKBPy6HROM/dV0eMZkzAKbD
X-Google-Smtp-Source: AGHT+IFyonhYp0VhuJ77mCkhfwH1FIu7n6AS34BzWG2/TXiNfLz+jrBDxyBMLamsHRAilt0WQLyp3g==
X-Received: by 2002:a05:6870:d0ca:b0:347:c80e:7187 with SMTP id 586e51a60fabf-3c0f590d8c8mr12572114fac.10.1760469568347;
        Tue, 14 Oct 2025 12:19:28 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-3c8c8b69aa7sm4724671fac.9.2025.10.14.12.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:19:27 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:19:27 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 0/6] packfile: remove `packfile_store_get_packs()`
Message-ID: <snzz23patquqnveygmcqema2mogrehe6ndnjom5zfzu6mrkhzl@j36yhxbdcgdt>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
 <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009-pks-packfiles-convert-get-all-v2-0-0d73b87ce711@pks.im>

On 25/10/09 10:01AM, Patrick Steinhardt wrote:
> Changes in v2:
>   - Some commit message improvements.
>   - Adapt `packfile_store_for_each_pack()` to `repo_for_each_pack()`. On
>     the one hand this provides easier ergonomics. On the other hand this
>     will eventually allow us to handle object databases of a different
>     type more easily.
>   - Link to v1: https://lore.kernel.org/r/20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im

Thanks Patrick for the pleasant read. I've reviewed this version at it
looks good to me. :)

-Justin
