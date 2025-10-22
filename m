Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AC67262A
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 00:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092900; cv=none; b=tob6kyV+SYUdLVFZXPA+hUYR53BBF4aXLklAN4z66RzhH3pJ+clqB0fqR31dJ+Q5BkeRFHt3xQ4wFQTj3urN1eeoA+8QRFIUcJICnR0Zd4OD3BmPAWaShurjCwwIHJRck0OH+jZsmr212RHqWuOVMaFv8vVlg0mkmlOTnhJz0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092900; c=relaxed/simple;
	bh=rCisxRvOc+imPapOb/MYjzTUHWYiORDDf0ekPkb0QGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ei3TnJfGzyx5vfSyieuVSr3Gn5gUFvGCqHoedPT3sLpm2w1aBtsjLvUKlztuqfqfmrRo3yzIEh9AOqZpEXQzUtl0VgoXN5RCR+2kQdzWJIevcE0ekHT4/APgZURSGb+t4UL5ptUt7h/1muVM1IgXxPbi+23w/b5ytrHOONxZi5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ImWcgRwr; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ImWcgRwr"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-940e06b4184so244479039f.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 17:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761092898; x=1761697698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gVLcamMpYuBXWMngQVofvLBHXjMSbVL/U/6ljVcRGy8=;
        b=ImWcgRwrFgjgbqHya2y2KPu4EWqCR1yTeAjs5Go3lNpAEr4axnGJpPbBwhG0d3a9Sc
         fDp3aohVyWwZ8A3MAe98+OXEB66Y1i2fGVc1GmgyueQIrsuKlbw1zajM2JuQUFHLtCKq
         7nQv9Yd7JE0GZnxuzOsyyfNMNpfcBisjWceBlmB1ceP/gUcNFvKkBmluFeCp+fxXuwGW
         FNrflxqmZY87iAZpXeuk0LtUSJZomgzS/dC8noKmYO5f7zn+KNtLi0qy9P8ygXVSYBdx
         0a+MpWRyQSHJj/bGRUqBaVRj/ZKtkI0Hzo9Oqa5w4EKG4AyXVm+Gt4xn8C35rPep3D74
         Vmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761092898; x=1761697698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVLcamMpYuBXWMngQVofvLBHXjMSbVL/U/6ljVcRGy8=;
        b=vil1KnN9804DsI46leUWBOwL9wZ2UygnOHB4ddWxMuCdUWGQD8WpHFaYxPoe9K7RTS
         EYvNM04yekMJcWQBDeXQhjfTw4PTUZXJ8/UpHBqzQpFZD8gxLm3qbovbw/ex3AoTtHXk
         lzLTiodZbhvuDJfxaSZkViSWtB4+A1Cs35TmqVIt13FXZ7lmI4X1NrxrdIbtTN/Hma0l
         zCT4K+Nw9QHvaxuKh32Ggqpph/fcPVt1jmVjUD1DmSz6n/CGgR3Eb5dqgrR4OhQMyaUL
         wZoM64DQC81Bn4XbKiEocf6zLRpB7j/kbVkEVg7MgtUJ8c7zm13j6uNSYmGfi6D4pLRh
         4d3A==
X-Forwarded-Encrypted: i=1; AJvYcCW6SXFKb4mE9XSB4tc2eaLzxnealkr6Xo1OifXOLU/I/j5c0zGk16vuqVuLUtBxjyyjZhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwglPfJ0DTbWEwnOKJQN38rQ9LekdsMBWNXJ21XeYeIEsZxtFv2
	XOUe8QMWERomfY7VTx6OsZSEzzTJEq4KSuYCi7AoQj+Aogh2p6USsw/UagO5Swo8O8/sG99MkQ4
	JWb/ELBf8lA==
X-Gm-Gg: ASbGncvw+Zqcw9oW8bSEm1K/8NzxgCwqWSXhaNUzPULSXa3blvFeXJPgKvsGsrAu/Bz
	WhJE21yID+0zoIuV2zmHfHJSZLmFuplc7hVxtUQ2RtGRQgB0WcvmqHc5Gie3zVVmzzJUwnbxlDV
	zCYWopbQKqkVKWNqab8hjJsaEuSCxYehDJTyWS9RZnb6EXQQQmG431O63oO2/X9v2MU5XzDlvVP
	Kh6mjqfcBI/TKtfTrEZMKiremiyQL+loSSa9kd1fhT26UeHwEsHjbhw6SbLhXahIo9VFrqXGYEX
	+6DGJSvoFugcCBbi3CCgxWERfF3oMQaZKEgkrPiebe/73k2S/OvEjaMMnzsXPROExXHXXwOBaNb
	8blu81Xl8ZUJGvut/3R6QW3dCktlkEPV18AHZxNZnHl/GtXXwVYcIfTnCGrSsNgYj7mz19dOAte
	SOkQkx/49oEJEYfhscSVqChCy4S/h8W+Enux9TI+bC0adC8CrwQiZuQFzaF5dBGMcbNc6vFaNDe
	Q2tSUKhzkmYD9DYSw==
X-Google-Smtp-Source: AGHT+IFDWv7kqoWsqjkuS1TS7oYnbi8P0ryK+cDWk8akb/IAFtpbAlRLYyVt/BuX+SCGJefiTmjeTA==
X-Received: by 2002:a05:6e02:2591:b0:430:9fde:33bd with SMTP id e9e14a558f8ab-430c5234cefmr275792995ab.1.1761092897769;
        Tue, 21 Oct 2025 17:28:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-430d06f9fe3sm47694495ab.2.2025.10.21.17.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:28:17 -0700 (PDT)
Date: Tue, 21 Oct 2025 20:28:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] last-modified: implement faster algorithm
Message-ID: <aPglIBiTYpH4I3UN@nand.local>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
 <xmqqy0p4uoqc.fsf@gitster.g>
 <aPgkwnq87UeusC6v@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aPgkwnq87UeusC6v@nand.local>

On Tue, Oct 21, 2025 at 08:26:42PM -0400, Taylor Blau wrote:
> -static size_t path_idx(struct last_modified *lm, char *path)
> +static void last_modified_mark_non_treesame(struct last_modified *lm,
> +					    struct bitmap *active_c,
> +					    char *path)

Err... this should be const, but otherwise I stand by what I wrote ;-).

Thanks,
Taylor
