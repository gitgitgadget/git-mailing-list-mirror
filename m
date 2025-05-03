Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD4917A31D
	for <git@vger.kernel.org>; Sat,  3 May 2025 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746297865; cv=none; b=B3u3IKFBVFB3KUpy2k2T5EZIYqmYujCcQZb/Nlt5QIkcaS3cvC30dPwXbv2+s641tg15Fsz0qlsKrYyNH7oASL3IaWGKW6BHsJdmx7XoJrhTlikHsxzaAxMqfyBg4PYhwd0yX3/xnIviBRyCdZ0xg3fhAP1aaPGxl8Pw4mSnIlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746297865; c=relaxed/simple;
	bh=0ekJHo105DPXGllXRvGc4uRrhAuZG+3f45ssTM3Au6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gv008osuu5qX8c3xSPRrLzrsnnnPs8PN5Bz0WeR5wfYezoFCgC8PbcaUGrfMWQlyMBWb6wZ76wOFBSmAarb4aoIeKIrIMgaf8TU9NhmjdMS1k9b3Dtn6WQ4nfoh57cc3wmr/KvpldnvAHPCekDAHQB3rjwqEELaQPBRi8qxCFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVttER0u; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVttER0u"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-879d2e419b9so3116304a12.2
        for <git@vger.kernel.org>; Sat, 03 May 2025 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746297863; x=1746902663; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/lIQiSe8fkC3wrpXnRU899SNolkuZziiIz0yPZWaoBs=;
        b=VVttER0uXjj75DX1NN3dLn3z72wW3C4CR19alD4UvVg5Dh8XRCCF+qpfvOh64ALf9x
         gOFi7Kgsk5eyyt8eilrU8vq77dw3yr83y/xHlRVmOuGIQSCLywipx3ZIGxva6/jxAUtL
         TyEBE/xpROi6j3CQM7x6t92YBdgxGII5aoPuKPp6IXwpgskR04bjvc9Utp6bYd0+ic7E
         cWwV+1l+VWp/h3QzIdx+RmtInh+ZUYo00Fq7weYLUaVzYykz4MalaGsxfu+lph62j0Lq
         iGy/1GFLscgyS3vIL100SE/WF5TJtATS0sSDiUFvZ9M3QCdq6FlBbB+qyOviQywCHHIK
         idcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746297863; x=1746902663;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lIQiSe8fkC3wrpXnRU899SNolkuZziiIz0yPZWaoBs=;
        b=XraFVe8sQxP9BbEOvmpELyCDIl+Fw4YJGglIVsvM4WBO+krfUCNE1xQqH2q7/5rIwG
         VeHBv5sHW8GQRjDxljHjrQzoTCWnjRDKTkl925Rf2+IEQ517TblUmbOUrBm/vBa503N5
         RD5A9Nfr8cNp8IX/baq2hZKlwn8q1j9ZrHbw/clzhUrHd8ARYmC1EPtfzlgo2hccVIkn
         gKlHsH+776Fb1tqYY5WZs6iFQJR0dn7L7lxJ/FmbqZ+g9FCCT4cpgBHyvLx6dFC5b7xa
         lW5zMbCOi/Ts4MRaJJImgnktZvVB1O48YP8zzGJj+84HuBb5c/BMUGNLVB+8xa9d0HOd
         JqgQ==
X-Gm-Message-State: AOJu0Yyh1UQE+o8ZKQI70OE/bBlZgbw/FlBrtTj0OAP7FPFOGcRrWltj
	Dhczlf7ECpAcDxbXYoxJurg62KOlCmMhdO1EqCCUgRktEpouL9bm
X-Gm-Gg: ASbGnctPcCTRfZIYQRfGE2FybCxsBZZLYrAEz9kDNFxS+ItPvR41eXVo2yua5VKNnmY
	Hnb5MBplJ0RzWn0bfuaw3YJTx0shL8DStra9WCjpRGb+4B4Suan9u3DgzmXYZxPXSrLUf71BtV3
	+yjUy6GmV4kiCYC0waDxqc6vA9joekqPGCcXWDjWxNZ7YATUDuoDFggm6pDv2QN79/uVGI+3GV4
	0Izx/L5brVG8e1fTvQw9+9/SksUCPUgLDowo6mVPepG/aW8JntSG70osYJI3Fw9bETCRD85sHgx
	gz3z2LJKThR4t/k0Zj5w4XiXo88wNutu4dIaE8aMJehykPxKTVjtQ7rG/sFIuTGL1h24t/XCjbj
	NqQ==
X-Google-Smtp-Source: AGHT+IF1SEviE0eioa1uXntxGvL1L6sLMllkwmRgDNxm+32cuKnUovEAYF9s8xq5WYBEOmDg+Z04Ng==
X-Received: by 2002:a17:90b:4c51:b0:2ee:b4bf:2d06 with SMTP id 98e67ed59e1d1-30a5ae52d16mr5169450a91.19.1746297863346;
        Sat, 03 May 2025 11:44:23 -0700 (PDT)
Received: from fedora (static-198-54-134-143.cust.tzulo.com. [198.54.134.143])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b5683esm2726135a12.24.2025.05.03.11.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 11:44:23 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org,  shejialuo@gmail.com,  Jeff King <peff@peff.net>,
  Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] wrapper: NetBSD gives EFTYPE and FreeBSD gives
 EMFILE where POSIX uses ELOOP
In-Reply-To: <aBY6BPnuSfslYlYt@tapette.crustytoothpaste.net>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
	<20250503041718.42195-1-collin.funk1@gmail.com>
	<aBY6BPnuSfslYlYt@tapette.crustytoothpaste.net>
Date: Sat, 03 May 2025 11:44:21 -0700
Message-ID: <87tt61mt4q.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'll just add one resource for people who might like to look into these
> kinds of things more.  https://man.freebsd.org/cgi/man.cgi is the
> FreeBSD man page viewer, which lets you view manual pages from the BSDs,
> Linux, and some proprietary Unix systems.  It can be quite helpful for
> finding and fixing portability issues like this or just seeing what
> command-line options or arguments a certain Unix supports.

Gnulib documents most portability quirks too [1]. For example, it had the
FreeBSD EMLINK and NetBSD EFTYPE with 'open("symlink", O_NOFOLLOW ...)
documented, but for some very old versions released around 2014. Now
that I have confirmed it still exists from this git test I have updated
the documentation there [2].

Thanks,
Collin

[1] https://www.gnu.org/software/gnulib/manual/
[2] https://git.savannah.gnu.org/gitweb/?p=gnulib.git;a=commit;h=c0c646e29fbda0a6eadd6012d8ed1eb33b6c3968
