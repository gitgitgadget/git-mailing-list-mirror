Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FCF155A52
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139080; cv=none; b=SkQ0Z2aUXQ92CzQtxQz7EubbARMqzzg6K9xnd1caLcyD0Czm7Utt2+Jb+nMIky90j+ZmHSJ4EbcbuiVh7QbXHNK2eL//SDKjtZdxfqzRP99rK+xXwLQ5a1vDQ238PwU8uX10WbLXa7S9+JiupYogICYSfQOJa22awOOVJUob+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139080; c=relaxed/simple;
	bh=yOXE6Iheh7f3rq6AeKqfRHhPzwN8KFpdniH8KtPnktk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Je893FGo2QY2XSF1dunYWPa3nmBgSwwSda8uku/zsHz6J2rs2TnQBC6+4XUdsJxviSC1q6JesJ2GO91Gmtey1bSFohiCZg7wTXLG7pgtmwb9NmzK+B09sDEfuLEbYcBLV/M6rEBREJmh7w2rI9KBUmo9NZfKP/3RMsWekgio3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Nq8J6TFR; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Nq8J6TFR"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7180ab89c58so2378060a34.1
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730139077; x=1730743877; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8zgswO8w+XcZqMbs6T5PapXB7IZypuRDPcbUU1S9OCM=;
        b=Nq8J6TFRWikdC0WB97LnZFoQRTz+v2J6xRk9gY8Clj7iQax3+9FHWZ8vSFbUS+tHsW
         IlJ2Ks42MHJJgT8GCBJqqFJY1ahs95orUOIViJddmtZBvHDLFDz9lt0wJtfJXHwnJZpP
         soM0UjAYC7UwMS+tEWsiaVzM1+ezHJZ61Js6DOQnX3vlLJ3Lt7T7DBD79XEVkUt6QZzp
         ji2l2PX4J4vQAi+LxtZi3LgR2mlqjyVoK42CCISnx0Bfvsh31iReBUkYsgkDz8XkRb+a
         AMpjFWxyhw9uB7U0X+ct9GLlbagZzqnSOFbfbOmm0T5nHtg9vrf0hJ9i6jZc/FI2Jkzb
         mx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730139077; x=1730743877;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zgswO8w+XcZqMbs6T5PapXB7IZypuRDPcbUU1S9OCM=;
        b=omcGhhqxSIQZ358ONT2YhCvOsaTMrKA869CAHvDe5YUFd5q3DbgV1fZZR2dH7raNJD
         kyrv1/iKLmtcydk69pjiwlxP1EMfslzn+/OErFGeq77QcS2xD1ih6TQzMMvpxh5w/6Mi
         6Sf98s1isB1rjXhdIrCjNeIsoXRHXWsKqWYwe2S32/lnuRe6vbhdLBhjBmGpQKQtR5EB
         /1FAkeybH+O4PYmjB6YoIwewOkeoz8TOarTQamufyTZyy2FoPe1EI0PGgvYfrjrpY59U
         EkkC+LLoLGII8O+i7Rw6Ko61Ye9rnXlW0TcgNsQyd3zMFac+ZN/95FmS0qOndtxp54In
         UoLQ==
X-Gm-Message-State: AOJu0YzMN3G6GhPRciSD607BDC0TV1bd53aW/jH0aaIyT0qgxjxAZ7Qj
	kTzJCCkKJgzN103jv8ZHOFm2eriw4HRU1pWXZl9VOCUQAtACA8BrsrnQGr/+2ms=
X-Google-Smtp-Source: AGHT+IGADfIDR9zsLceV0stTqJTIal/E+sKsgK8Ggr/FiwbxRamxWA0IacGnMmnDwKqkT2bhEZ5rUw==
X-Received: by 2002:a05:6830:6113:b0:710:fd8e:172c with SMTP id 46e09a7af769-7186827070cmr9304310a34.14.1730139077268;
        Mon, 28 Oct 2024 11:11:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6baffccsm15589957b3.3.2024.10.28.11.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 11:11:16 -0700 (PDT)
Date: Mon, 28 Oct 2024 14:11:14 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Peregi =?utf-8?B?VGFtw6Fz?= <petamas@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: Inconsistent handling of corrupt patches based on line endings
Message-ID: <Zx/TwhuG4Ni7mf6F@nand.local>
References: <CAExmRTbMCayh+vHW3g=2p=FMb=VKXomEbn7_0t+kK-eF79JnEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAExmRTbMCayh+vHW3g=2p=FMb=VKXomEbn7_0t+kK-eF79JnEA@mail.gmail.com>

On Mon, Oct 28, 2024 at 05:57:54PM +0100, Peregi Tamás wrote:
> Hi all,
>
> I might've found an inconsistency in how git-apply treats corrupt patches
> (representing empty context lines with completely empty lines instead of
> lines containing a single space - usually a result of a "trim trailing
> whitespace" editor setting) based on whether the patch file uses
> Windows-style line endings (CRLF) or Unix-style line endings (LF only).

Let's see if any recent apply.c folks have thoughts...:

$ git shortlog -nse --no-merges --since=3.years.ago.. -- apply.c
    21  Elijah Newren <newren@gmail.com>
    12  Patrick Steinhardt <ps@pks.im>
     7  Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     5  Junio C Hamano <gitster@pobox.com>
     4  Jeff King <peff@peff.net>
     4  René Scharfe <l.s.r@web.de>

Thanks,
Taylor
