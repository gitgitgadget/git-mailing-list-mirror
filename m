Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C071217F4C
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 21:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892109; cv=none; b=ZgcEfkRJ4TizNMoPKj1rgy+kFziuRRo801kuN+/mcV6NIBAxHmCRGRhc6cNJhdsfnJvOykurDJF6jGgyx+BkyrIXFcBmPLcrF+NzRh8CCfZRva4v4epeh0fRd7wA6/VGsStRVPxCUn1GfKsRqNwD+GQvrpvpCYjYQzzbjVhQ7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892109; c=relaxed/simple;
	bh=TlxY2gbhK+7+fMmpN6jp0x4VENGzJ3ZF4119MyUZsAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4zNymbkY5+OWXPEp0m43lk8OUh00/mbzKSnGcYsJRe45Og3/K35rE2Xc+oLkRwkz4RJNTyOY/gtpwjOgZYZWulUaM0+GA6HWqkGZcqzqseqjF5dxHQN/5dByQ11dOiL8FBoB+h5fz7sJsj4UxySXPyvTDZAueHhInkM7ftRFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LYV05UFD; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LYV05UFD"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e33c65d104so23716647b3.3
        for <git@vger.kernel.org>; Fri, 25 Oct 2024 14:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729892107; x=1730496907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCb/u1JVYZ7xzxuNbQcRiB+fqz6hZyNMVAwyYxOJzcw=;
        b=LYV05UFD1KbcJlsU2/pkzAezaHN66wK6bFCXOEc657kV6fmcdZ1HB+u74AkdRvcXOC
         z7syu4Grt2zRo5irR58oT8aqh6mTMIflhFIWNHicVb3PXaxxvNmopJBNVM9K6lyNbBS7
         DQtrQgxkWbfTp8PZXaWeOohcOdhM5z8Ue3/o/QLgySG0LS1yuonLCasvF7uyxfzTS9Sf
         pg9NsvFINGaCgTtDjy9TC+36oq4fIZaTPM//PBZFD+9Bhcc3wc6HyfEjqvp2uTdYC/W7
         3qyk+2sxiYt9zKFdxiMa24KPyRMwPjopu5fVUuswcV7etfWo9tK7jsjw1asBNxT9EwSH
         FPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729892107; x=1730496907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCb/u1JVYZ7xzxuNbQcRiB+fqz6hZyNMVAwyYxOJzcw=;
        b=MdLn6PYT0c/Jboj9orgZKV8gYKssBqGRu5sLooalaAuR1C1C6WcPAtLe2JyDs1nKt5
         BWCrmPvcfAXCYkMgl6rU2n4rxc/sGRxZyzJP5UdGTVMMwvGpUh0IScuu0lNVYyuf1ibK
         j/qLgRR1TQCyVJJyfAEA4cFu9WYcH2Im64qagLFAnnWx6Etx/iF1ArTu1waiPVq47wwk
         v8hlbCT1MG1PCI2My0IU4vZigONFn0eMoYbh9TLiuN4UV2piUgkJgjSR0TvmKgnGrlnS
         a7+fzZr0cxrO/qANpylTYMoaHQ4H6kC7ghwNZjvP1F8izDmnUEdOnYvss+wP7glGWmIE
         YBjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXUDhNQ4IAS6Fej5ZsShNZO0dvKLzJmkrp4ly23BptQV0FFoy8b9cbRRjg2skZrrFOczU=@vger.kernel.org
X-Gm-Message-State: AOJu0YygmagTNkuax3WMg1I10gHV87D70VnVfQi7tZcq3xrwUP8t4BnK
	nUMQtIRzkUbSZHnwkCGgChaR0E89NtfMN4zvoxzyG4k7mBZhIcJya02ICxcwdNHdiORsrfuKpD9
	Vs7U=
X-Google-Smtp-Source: AGHT+IF+AnOzESCAqoKRKxlikM3dcQI9+BcGe/kqWBMwx4h5yIJg90Z6IhaMhwM7vUTImPCfGC55YA==
X-Received: by 2002:a05:690c:f87:b0:6db:d586:72d4 with SMTP id 00721157ae682-6e9d897c447mr10236057b3.18.1729892106987;
        Fri, 25 Oct 2024 14:35:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c95afdsm4377397b3.107.2024.10.25.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:35:06 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:35:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/11] dumb-http pack index v1 regression + cleanups
Message-ID: <ZxwPCWuhrZoSJg1v@nand.local>
References: <BA07EFA0-0793-420D-BED9-ACD7CEBE0112@townlong-yak.com>
 <20241020012455.GA599236@coredump.intra.peff.net>
 <20241020024022.GA615104@coredump.intra.peff.net>
 <Zxa6ixwP2aOJdfmL@nand.local>
 <20241022051402.GB1247135@coredump.intra.peff.net>
 <20241025064148.GA2110169@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025064148.GA2110169@coredump.intra.peff.net>

On Fri, Oct 25, 2024 at 02:41:48AM -0400, Jeff King wrote:
>  16 files changed, 153 insertions(+), 101 deletions(-)

I was glad that you worked on this, because I figured I might end up
~tricking you into~ getting you to take a closer look at some of the
other potential fixups in the dumb http code.

The series was a pleasant read, and it looks quite good to me. Let's
wait for some other reviewers to chime in before we start merging this
down, but otherwise I think this is good to go.

Thanks,
Taylor
