Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE076CA52
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040252; cv=none; b=LVJyeE+3yPn1ub66rhBFJBGQMHGWUHtCJd40dWhQy5PEVurl4CQ11DtJfNHqSIhcfyW3nRRtUNrKW4xt7qBDnxkgmPuhWFaj1ytcn4DqEaIyUXI26jNDr9ZZIe9aMp7T87eap8qdRhlwJijX+QDMoAsWQkHX+Raums7PKBUT0aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040252; c=relaxed/simple;
	bh=mRrDjG8ZWfNkHjTmt9ha80Zm6my7SjIpitenstj4+aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Scu3oXxkIKUAEUC6MSMLGtxGTZxCaHXr+GaT0Yyc3jKdQlvzkgXvzUx6tZz8wz3TD2dADgrFbrFRmSyyl7t8bvpIMsaVxfAUgR6cW99kPi0zCcYbe7xX36SztrJecBPKE0wnITwjInzyk2jT1kLHwuycFvrfnMcUnRLPIIkckkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gsXDGipt; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gsXDGipt"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78fba1a1b1eso8604737b3.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769040244; x=1769645044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mRrDjG8ZWfNkHjTmt9ha80Zm6my7SjIpitenstj4+aY=;
        b=gsXDGiptAq6QpmgSsx2vV1g9/ETC7e5rZLESi74odVReIC4qPxrOg+w56X8UK+h0Ru
         c986mpdwhjpbdCnCRtLbq54WzI9JA8E28K5HFFvsOmEFrNkQ2U/xfbCO3CP90hbC0Mnh
         xwxZ8jDOYBEgXXZvXoQLTZ7uhEOt5B9qtl5y0DGnnOvSVcG8MmFF2/D4/OMwD4iWyu8c
         SgkFf5wBVuqRSj3nV+W1ouzeJDefzOdvYG5DJe6XD9BWELj1JwEOfLfqm8W8Z0e84cHq
         ZXeL6r2syARILZ0/8i4gWvGGYR/pHq0cNly3D0vUxKVJjZG2C1mocQNMrN/qlto5j8jJ
         ikbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040244; x=1769645044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRrDjG8ZWfNkHjTmt9ha80Zm6my7SjIpitenstj4+aY=;
        b=Xf3iYY5nXBJNyOa7phvHjSdTT9X063834R5DkJfmqOF/jYBicpVjNy4QagtW0Aq7G+
         +aYLa3+FOwvdZWhVCY8RjUrtiCZwg2n4JnYPJtNcSAdwd/CwH0A3ke/aiAfcBNp2kGa+
         my1Mthl/Lyva/8tB49Tb6jpwLF+E/mTiB2T3CWdTOFsL3ajV1+XwfBlPOkHUp5P9S82Y
         IFm9b8zGFMG+4G0QIU8FoMCrAMiH+5ogS5ODZaBD184rXXCUbdRRCCCKV0f/VvMEImsO
         y76/qBZLyeXDXXWFllb67UY8NIOA9wPFpm1a/49GfuUR+R/pFNoCP3fCZCFkEoBl/+Sm
         SIcA==
X-Gm-Message-State: AOJu0Yy2Cs1D7wBHAlt7DI3GEwFcmkpWFnaN5b17IecOizooma5bIXUL
	PE1MQcTFBwIT9PDp8NYQaFOLDf7owj/yBRVOeLyqBLv6hemFJ0uiQgr9RW7WsQmnzGDGhHTEUIv
	WTETTLes=
X-Gm-Gg: AZuq6aJLuIIVDErS6jLbfmQFiVnSXfe8ERUuUBjsFDwUHBEDEX4acPoX586zdhVYfLm
	PMz1vuzY9HnHJRS2tuexAocogwCngXW6OCjAx+4/vJJcGUL1BR4FHueCwFPB+gcTDRUMMV6CfM+
	0BcYrB6rLfmnRFKTL9AGZWr7aNIOe12ITNSaEcP1qqlbaKvKTEaKeDoaoua9LMkIRdkbXnSINzu
	q3uc/So+7o2y5t/t6IjaxaPvSIIcXe3+BBbXS5hTzj58BSDWo0ujYTmogSd4NY9Xs4J8KiL18wb
	XVZI82218eT/57hybx6KIyw+fxqMBqWgh/9lawev3OdPF34/+SnCJyMBCtR0vxVSRiBX1G/0j/i
	fbKA3qf7sxeWJQ8EZzFLx5UFIByQtT0HWwc+Dfah2HLPxYxVDtcT6etwQNCudQrB0VlvefIWrI3
	imjPULGSodXXnIh4NucaVSs+EnheLHBF3Gahr6TArEeoGA8m+45MUMLvZyclD1lnyvMASIrWiN/
	ny3TsL8uHHY9/+0aQ==
X-Received: by 2002:a05:690e:d8a:b0:63f:96d7:a369 with SMTP id 956f58d0204a3-649512ac8dcmr928667d50.28.1769040243851;
        Wed, 21 Jan 2026 16:04:03 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6494686dd20sm1795608d50.22.2026.01.21.16.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 16:04:03 -0800 (PST)
Date: Wed, 21 Jan 2026 19:04:02 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/14] object-file: extract function to read object
 info from path
Message-ID: <aXFpcms/adskOx3X@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-3-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-3-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:19PM +0100, Patrick Steinhardt wrote:
> Extract a new function that allows us to read object info for a specific
> loose object via a user-supplied path. This function will be used in a
> subsequent commit.

I think that I'm a tad unsure of this interface. I understand that for
the existing object storage mechanism that having a path makes sense:
loose objects are stored in files which are referenced by their path.

But this feels like a leaky abstraction to me. If we are dealing with an
object store implementation that uses entries in a database, or
arbitrary blob storage, do they have an equivalent concept of "path"?

Perhaps this is clear later on in the series, but I think at this point
I am a little unclear of the direction.

Thanks,
Taylor
