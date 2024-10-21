Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207191C9B82
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540386; cv=none; b=uAqpsT2hnO6Z4AC0TnGTaOWUcYjmM1bvRkrNiDWmOYKISHr1WmtjsFtz3YKXtiYjs1I+MXvQVfsIM9lYGYX8J/klR09W5cqJElsr4VJkYKQoyVdRaicD+OPSgJJJehzPVBa2812lP618vL03BOBq3KWBWR5dFFHLwTprmt8ssrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540386; c=relaxed/simple;
	bh=6h6GNzdLWnqa8hJAO8H69wXr/p56+M+P5E7tcIk59iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCy5TF04C+wcuDTaqtowuWx/1BruYD/Y2hU9oPF04iPDEpJR8Ve2k1t42sSmsCoEtXfx9qn3l1yxmXQyx0tzL2LzJafwXjKKYUf8qzqf3uAeK54fR9pUsEyfzNVbEBawBwa4PJgEofDrgIsBF1XW3KkNbql3iEXQImUwJPG8h58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jAXiThbC; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jAXiThbC"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e59a9496f9so54790397b3.0
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729540384; x=1730145184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e3np3yJCX/hVcWr44HYjCugFdGxbDyHVeRlJpH724/Y=;
        b=jAXiThbCuS3Iay5NC7rXdbp0n1WfgQmA6zmfNz7RW9xX0UYmvN12Dipuar0QL+dj9Y
         6Xm552qc6htoZ06ByEYJeeuYX0XzPw/RKmRPtoxPGKCpgCR7NuqDWfboUtNm7TE++2Fg
         2oCSj/M4LWZNmtPlRajJ/c6Wl4w+HdKUKm33fS2HZnoBHarneEKPZ2C3Le38eFTyFG1J
         9+xc2AEcCg/KfIRBNFPVppWFi+2jmdbdHA5Mc64Q3SkMgCd3PpoH2ZflbjzNsfET0yoN
         9OoKuV307EiUsd7z6YFCp4/ofLPxC9Gn8skuW8qm4lz5xHPOdlh2yTCeAJCKpb/SyEmZ
         gRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540384; x=1730145184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3np3yJCX/hVcWr44HYjCugFdGxbDyHVeRlJpH724/Y=;
        b=NzH2WZY6S3kXiNR8HnKz18FylY8U9Ynv7mk45TFhh6XbUSviRPg6eCNkD1HCC8oYUY
         drAr9hHjPhyPas9Byn0SD7/kHkWbzhTWUXfzbRgountFEHrrdhuFtsVvzUeXJPHFAkuB
         bhwY0xuLEAZwv8heNH2Kz9zBxgSLhiF8Baehtid26R+B+1X+7oJp4+Oo/+8KWW2MJMH8
         e3Gu4X4gOpBdPkmUhPK41ms8Uva7rP497Qz69UQaMe7lXubDvofm+uU3KdvpkJzlTdTx
         Fiy6toKU81ZPpvjyHckzKxjvPoWBpS3S+Q1i2hT27aljAGQ63ZDetmGaZn0iqAMe3Q/i
         sXeA==
X-Gm-Message-State: AOJu0YxKKQMkBSoOXXMQ4cw1drK3dKD/XDAIOHRclhXOl60mEp0OX/QV
	bkBQlAV30UftTIOq8vmeaNMKgwO2S8qdtSXRxnIPNh83xBIbmTOfEgj1V4dIXGA=
X-Google-Smtp-Source: AGHT+IEigWwXgFsGoJM70+RSRbCWS+2fgTy+Z5P/DtqeLogkny3jXrv9hRndh4+xdx3I8yil0LZzfg==
X-Received: by 2002:a05:690c:9989:b0:6dd:b9d4:71a1 with SMTP id 00721157ae682-6e7d8211324mr2478517b3.16.1729540384162;
        Mon, 21 Oct 2024 12:53:04 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5cef939sm7771677b3.107.2024.10.21.12.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:03 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:53:02 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>
Subject: Re: [PATCH v4] notes: teach the -e option to edit messages in editor
Message-ID: <ZxaxHmIP0iJZfvHr@nand.local>
References: <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com>
 <pull.1817.v4.git.1729534340786.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1817.v4.git.1729534340786.gitgitgadget@gmail.com>

On Mon, Oct 21, 2024 at 06:12:20PM +0000, Samuel Adekunle Abraham via GitGitGadget wrote:
> From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
>
> Notes can be added to a commit using:
> 	- "-m" to provide a message on the command line.
> 	- -C to copy a note from a blob object.
> 	- -F to read the note from a file.
> When these options are used, Git does not open an editor,
> it simply takes the content provided via these options and
> attaches it to the commit as a note.
>
> Improve flexibility to fine-tune the note before finalizing it
> by allowing the messages to be prefilled in the editor and edited
> after the messages have been provided through -[mF].
>
> Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>

Thanks, will queue.

Thanks,
Taylor
