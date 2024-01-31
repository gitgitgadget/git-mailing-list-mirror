Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096038F8F
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706729004; cv=none; b=Vn4EB+EiJKIxylqEPOhqllIWS9dEZ4vq7HBV1dfS4M3Ooo9k7Yu+F7+jBpbK5vd44+1C7X76hsArblnhzWpOSHuDbaItXLH7CRANaE7zyalgPQJ2ZvvS0chLBdfTkeV51thGb7dgv7gGNqEnz1nbiTYAWh6dOYlhKsc6AEPGHCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706729004; c=relaxed/simple;
	bh=Qw2Zl2Rp0MI7hUq8c46FKHGUDSu0iD7E2qINVOGKbdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kwey/C2v1ulcQfLKVjEr1EWP2zYdqFIlhqCHWUklPVuvdnVFRq/cy8dcrZfOvdN3J0kNlEXAzFQ+nBIj702sVD8TA2OVzlGl9PHo7xJ45QHKyrGfCaujaJ2DI762pJFLCbEW/ZLc1szdoNRscHMnPCV43mFDpnOvixJytpHq6c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jgXXJACn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgXXJACn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d71cb97937so975755ad.3
        for <git@vger.kernel.org>; Wed, 31 Jan 2024 11:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706729003; x=1707333803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jltsvj/HIEE0MSssR1stP/IVk0vkuzDsQdEPpWEobmA=;
        b=jgXXJACnx9+cNM9Dc7CvDTCnx9cxggq3TzxqdgwfTLmRR38qzMPwHtGMOffc/lgShx
         fp6TrS1nKjXy3hd7soGzrAjJ9SMWlueTQeTTgBLBQT2fPXxhpLSE65YWK400htii0tcm
         glHhp5zjbkAFN2Q9MOFhFtfiLWh4Gh1IibMivzndolBMc+ZwpTZYGBP5kepbsSYw9NBI
         80K6vXmCmJUWlZYo/nTt1aNMAPZyf5/kJ9aBtzJ/OHzvkktY1iYHdehtFU9ywtipiE8B
         TC+jwOn3jqjyWW0HDIOSxZtrzK4nverzJ1W17kmaJAbt8VjDELUYEFyvdSrNVpYCA13u
         afOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706729003; x=1707333803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jltsvj/HIEE0MSssR1stP/IVk0vkuzDsQdEPpWEobmA=;
        b=WlHqS9qyZKgDWXoznkMv7sWyecaisn8JS4u/wq3LL/+0IiRBicn5zj9NnT61pUPlyA
         14MLNGTAT6nmF1y67SzpslaunFtMJS2j5094ubNQj+UWIVr1I4DxPREEKj9cTDmhIwvJ
         hWQpZsXsMCYDNOs3dOpdJrWJvFh+Q5KTPjoFq7zrqc7V6PspjDiRA4HF+t+yqRQegIar
         wrStpBDLp0SyESOJnKU8sCst9vezuUVWc9tdjikUkjBRurjl7tVhT1SL37phE5tycXuz
         o9p8qBPt4OILnhoo856bYL+E6CbMPC7ulbceYRZvSqne7vTsSR5S0xcmu051qxdWF1M6
         6hYQ==
X-Gm-Message-State: AOJu0YxONjZXcTRTfuXywGDJDr5dn3c4qGGlTGciTwvaSYoHq5WyARkH
	nBDNV2X3Qme3O9LEQsRXilFtD72hVc2lhB611FpuYyoFUtDN3APX/gR+y2h2
X-Google-Smtp-Source: AGHT+IEnfMNtsGpPmgv14HJ2uG1Np1RHFBII3ADQOnOTBHtA+ATBv8z04lDMROatFUX3RvNgfiHwOw==
X-Received: by 2002:a17:902:ecc1:b0:1d8:a108:2cab with SMTP id a1-20020a170902ecc100b001d8a1082cabmr3164406plh.67.1706729002478;
        Wed, 31 Jan 2024 11:23:22 -0800 (PST)
Received: from Carlos-MacBook-Pro-2.local ([2601:640:8e80:1270:fc94:809e:19f2:d7a6])
        by smtp.gmail.com with ESMTPSA id y5-20020a170902e18500b001d8d52905e9sm6552160pla.0.2024.01.31.11.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 11:23:22 -0800 (PST)
Date: Wed, 31 Jan 2024 11:23:20 -0800
From: Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org
Subject: Re: FreeBSD CI suspended on git/git and gitgitgadget/git
Message-ID: <22cfob7wthmveupp5w7dbdtbparybcsdagoitwneqw6f2cmhs5@x3tnbbftvtyw>
References: <d2d7da84-e2a3-a7b2-3f95-c8d53ad4dd5f@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2d7da84-e2a3-a7b2-3f95-c8d53ad4dd5f@gmx.de>

On Wed, Jan 31, 2024 at 08:11:46AM +0100, Johannes Schindelin wrote:
> Team,
> 
> I noticed that there is a problem with the FreeBSD runs on Cirrus CI (see
> e.g. https://cirrus-ci.com/task/6611218006278144):

Thanks and sorry for not catching this earlier.

The proposed[1] "fix" runs successful and might allow (albeit with the
warning about prioritization) for this job to be restarted:

  https://cirrus-ci.com/task/6173598017126400

As explained there, FreeBSD 12 has been EOL for a while and therefore this
update was long overdue and will need further tweaks.

Carlo

[1] https://lore.kernel.org/git/20240131191325.33228-1-carenas@gmail.com/
