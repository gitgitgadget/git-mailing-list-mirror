Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2734C61
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 01:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710552867; cv=none; b=arEi6o8I2xeipolZ3QEfWBE3Qs8P/kJS4b3mC9LvcQkfP39My6p8Lzdq9GkFi4hC97Nm5JLte61VQ9T3Pjy0nmPNnY0eQEQykePJUgUwK+Du+Bg67gAszyS8tTfgsVArEQcYDEIFSP7CGtaYj5NFBqOBaKwk7j4TIKyEq0nS0Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710552867; c=relaxed/simple;
	bh=haFukB1uuDAqpLveZPnDs+hHCnXqAcVMyzuBpRS6xzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tebhkgBrMRiDe1cZaNVawzshqvxmRWubC8Z1k+EOzKQJKsVlz1CYV1yNkXl00LEsm15NXqjStoWNXvHz8Ctj+JftrEt0hIbu72YbkW4fSr/t05Wfs/0uHOUZF3mdx3etp5P7ZT8SwfKuFd2b4rXRYMuzyn8nnSja9JfycJf60ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=qu83atW5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="qu83atW5"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-789e4a4d3a5so82510385a.1
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 18:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1710552865; x=1711157665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lKOZX4KA4S5p5o8bL3/uT00yVF5Ly7k5HEdMHr6tnnI=;
        b=qu83atW54TPgdJFdlZ3S5je8mHzAyMug7qOeC8F5muDR+2WEYyKGYXbX0PuI09Am98
         vfw++jNQUar+kyLCvIho1YGL/QpNoOwd4u2v7JMwp/CMCsUFXJV5PeQ8yh51AzDaAI5H
         CVKIcVGwp8uOM7+GWTQpm5ScgUHs5HVf6rHGbWcCg/9nzbC+CpRfKQN+lekG61GyaX7G
         UZaoGWLe3v3W0UJXYMWulvvXgdc6RHv4aiqX7fPQq7Noe4aSeNRNXdx4I7Ia0ChN2gen
         9E4zHdLK+kVNnsd7WOKa3RXp1WsKdCYhrHWsYdSLICFBej78Eiu1edAIxRMHFxi698Ok
         JWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710552865; x=1711157665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKOZX4KA4S5p5o8bL3/uT00yVF5Ly7k5HEdMHr6tnnI=;
        b=LCqFGpArGhC/P072B4XdjolE8X/MTG3uw6wD0/mf1euV7oM6pWq0GsBDGf/PplQCon
         yZpA7Z6KCltpGZ+PA3a9CEXxbKsm6E3KILpEMN912uqNg7jN5g4gtJbkAQvf15Xy1VxH
         ot5vxO/PvmaRTZFO4xUXAtzNDEoXRIjiPUOAS9iWqZGUdAcMUnoOKvuKBlzF48AJobiO
         M++OJap6U1cz4vqJl1SzbOIv5q/XN/b1JWXFknn0RbcuZZGzka2xFfNA5BHZpbms/OwP
         kRzSEJXJSm6Qfr2x264orS33dxG0UVcnpGthRWvPL2yzLURnYdJ2SvMP7m5uQrUt3PD/
         xLtw==
X-Gm-Message-State: AOJu0YzxeeOgz5V5Wx0S8OmKYrU/klZ5cKxYs+oxuuvDmPRcZ665XTGt
	hoMfvpT2/welMAzBGmEesZZn9j6pU6igNDlV2eI2dHueIgXL/CnlyRULjgxf1Ug=
X-Google-Smtp-Source: AGHT+IFBcVTub/OWVcD5B4ZRW1H6CbqDfu0OM4mVtsi3bumxIdCSoxH0BLY7zpENVBaGXxy5lz6B8Q==
X-Received: by 2002:a05:620a:1474:b0:788:23d9:63d4 with SMTP id j20-20020a05620a147400b0078823d963d4mr6998057qkl.44.1710552865006;
        Fri, 15 Mar 2024 18:34:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k16-20020a05620a415000b00789eb376b80sm349917qko.78.2024.03.15.18.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 18:34:24 -0700 (PDT)
Date: Fri, 15 Mar 2024 21:34:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Beat Bolli <bb@drbeat.li>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2 09/22] t/t4*: avoid redundant uses of cat
Message-ID: <ZfT3H7IiewuhAA7M@nand.local>
References: <20240305212533.12947-1-dev+git@drbeat.li>
 <20240315194620.10713-1-dev+git@drbeat.li>
 <20240315194620.10713-10-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240315194620.10713-10-dev+git@drbeat.li>

On Fri, Mar 15, 2024 at 08:46:06PM +0100, Beat Bolli wrote:
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index 12ac43687366..578641467753 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -313,7 +313,7 @@ test_expect_success 'rename/add handling' '
>  		# First, check that the bar that appears at stage 3 does not
>  		# correspond to an individual blob anywhere in history
>  		#
> -		hash=$(cat out | tr "\0" "\n" | head -n 3 | grep 3.bar | cut -f 2 -d " ") &&
> +		hash=$(tr "\0" "\n" <out | head -n 3 | grep 3.bar | cut -f 2 -d " ") &&
>  		git rev-list --objects --all >all_blobs &&
>  		! grep $hash all_blobs &&

This and the two similar transformations below it look good to me. This
obviously isn't the fault of your patch (nor should it necessarily be
its aim to fix), but I wonder if it would be worthwhile to extract the

    tr "\0" "\n" <out | head -n 3 | grep 3.bar | cut -f 2 -d " "

pattern into a helper function, since it's used in a few places in this
test script.

That's just a suggestion, and shouldn't hold up this patch/series. Maybe
just some #leftoverbits :-).

Thanks,
Taylor
