Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851AC1D9A72
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788480; cv=none; b=rWf5fV/VIgd90x9iRyiizGo+KZ5oUaVZQ5MNTDIYvHc68BG6yc4o6EnAntEcW0SyrO0IX/LQO49sl62iheLmmv7OApXhlb37wNWNsW4PqML7UWGSUu72idbAMBiscn+eq9kjNxuEh5lIBbXKAn1kgLZwovtysN0suq3MgMc8N3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788480; c=relaxed/simple;
	bh=PuAp/B12uApzi6jVUdzZfwGSx/wNRhPXzeUt58u71Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POrshPVx1J9wAwE1O0q67S7+Ud3fmr9GvhBSPD03T/YbgQvv3E/wg3G042w3kxplXX30lhrir05os7W+qW4lJzi30nTOR9Hnl4VOY/xrj9eXtpOqk7Q1doiHB8W07ebpJZ03QwiSCcE9Bz4z6frMTJd5R+p/05GdRTPdxeS94Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=sCNfjh/r; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="sCNfjh/r"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2e2d013f2dso1323904276.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 09:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729788477; x=1730393277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5xVuUllkKLnOgNB1wQcwf3PqP3bVmJpJ1o8nxw2+1Y=;
        b=sCNfjh/ro5VluidB4O4r7D1xkm/VKway0YPI5JYbA6uNUVAQffOcPd/lw/I4FUnVJS
         jPZGhhXgaaolNJtTIokiqKTru98g7gS4D6GO+jUYdsSL9lJKk5r8N4+c5YNAu3jLjKYW
         O8JdmZpLZ0hlh6B9t5l6qC3j8CZh3pb6G7i7kMqpXNmZ5ybUvgdMVzm1JAQ10iyfkDck
         xiCzVy6yyXCPLMjjbGc+2xHcH3ndSbFOnqGqe1QerOVt1ivyo8YWYbpONjaaVWeqqMRI
         U2jXz6iUfCOO7SSEP6qmN0NzeavhR1M5V+eiH6yYw6lCPq2jCcDjDxEOqotnOmTrlVUN
         sNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788477; x=1730393277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5xVuUllkKLnOgNB1wQcwf3PqP3bVmJpJ1o8nxw2+1Y=;
        b=N4tXQSY9q5yBKW+26zN+8ejqakZ9eV9eu3xgkW71Z7CpM/GG5hvzszqF2PcPojOAjG
         iGZi14yvmvlw7wdm0ip42JUd4pCLEZ0yzItE3setLOm2gAo/GkfOzysJcVCLa/PBuaum
         +QZIWtR0f3y/39QJldZ19qDI/DC5ebFtmnv6mPqkyKbeOiF9V0FmOXzbbGYtGfFUup4g
         DiBC1JXvcXQUEnOk7GxG70qYKYDyjhVtK6StEvUx8ceDadPyH3RmtnGmo/8pcy8wIiS0
         Y935fkrX4tizALsxMx6p2aS8rXnCPbGa5xkhFwp5OVQr5vPA7WzUPH41t5OCYARmUbwF
         zWLQ==
X-Gm-Message-State: AOJu0YybWWVUkmlCg56X9rMsuD92v+zXA2AC/nsr1wW2443ydPTqhJD8
	tLMwjxPkOW+4eKm71568URITsao9I4tr1diAt6b7Sb6VBCO91RmSn91kDEtaR3ImchOZfCgALHz
	zXzo=
X-Google-Smtp-Source: AGHT+IHZb5xUoqq2BKXRthEQH/7uY3q7APZESWUjZjaYDoYJd0GbFqXd2SYem6N78KJQArp4gOvMBw==
X-Received: by 2002:a05:6902:2089:b0:e25:e5da:461d with SMTP id 3f1490d57ef6-e2e3a6dc67dmr6258463276.57.1729788477528;
        Thu, 24 Oct 2024 09:47:57 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bdcaec280sm2031472276.43.2024.10.24.09.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:47:57 -0700 (PDT)
Date: Thu, 24 Oct 2024 12:47:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 0/3] compat/mingw: implement POSIX-style atomic renames
Message-ID: <Zxp6Owj/y/dEuBYd@nand.local>
References: <cover.1729695349.git.ps@pks.im>
 <cover.1729770140.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1729770140.git.ps@pks.im>

On Thu, Oct 24, 2024 at 01:46:08PM +0200, Patrick Steinhardt wrote:
> Patrick Steinhardt (3):
>   compat/mingw: share file handles created via `CreateFileW()`
>   compat/mingw: allow deletion of most opened files
>   compat/mingw: support POSIX semantics for atomic renames

Thanks, will queue. Can other reviewers chime in if this looks ready to
start merging down?

Thanks,
Taylor
