Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1E244676
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745357061; cv=none; b=ER6dnaqKy/ahEbSeHojev/XawshKqIwqTviPrJpE8oBi4Tz18pweW4kJkMt2BfORflbSG+Nf/FpPLHE+/GeUTfjRehmsmqyoqGORTrf778kw5SZYjsGpKN87NM/xmv70z2BhB6xW5mr7DU3Xb9WKJ8ZS+I3tKBUc69D/1O+pFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745357061; c=relaxed/simple;
	bh=h9GypwafKqq6mxoR9QjJ7u5KWebz3UAmhgmxUcNo878=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QJo8skurBm/oRV1yLSkdrKYzLXmA3zSX9CRI20VuMSX3lzc/CmMWUjFcHWr94Bmp7ItsdbSEAkHr0h73ep6CXxxRx8icKmOeZop+iLlqncFfH93g+5vsEHwRoICgJ0kZVvKeaZ0x6TYHyfIlugUdMXeLsHJQs99eJR79vehQAZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxzoW0XN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxzoW0XN"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22d95f0dda4so25195725ad.2
        for <git@vger.kernel.org>; Tue, 22 Apr 2025 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745357058; x=1745961858; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfvYcRR5cwZZLbVYbk4sBASK5oc/dXzAd/BW+SydCr4=;
        b=JxzoW0XNJBaiqmCXNMA6rIvnH3x+IhFs/uIjYFMZLLR88lq4neioQNElUg97PLPe6X
         O79AH/t9rV7Sw2FaxGvWChPjpr8rbD/XrfiOkTz8bwIY+uDwNsO2n2cnSYuhlVqEyVKU
         OaoEHZ22FqLOA6+tml9ILRCGk6MKDoTu8WRAohbUUxO4j5YL0GhglfmVsDld+pKUwBez
         1eDMcgOxBd6t4wPdPfbAvpABLJT7ojXAKlU/rlqhcnzpGyzOFKO3wiDf8oHMiR1dqXRu
         MCFPYSUO7Z+BBBPMbdvmkAhDSkY14JJ4deH5iv5/t1L0NU058fJzQ4t0BvgrpspKuUHm
         3srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745357058; x=1745961858;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfvYcRR5cwZZLbVYbk4sBASK5oc/dXzAd/BW+SydCr4=;
        b=kg+kLTY9B1/VCK3SIPC6BZEPVAg6lqFGoJjbOWQm3XMwWvwXmLMJH/JeB4cwSHDfT8
         4enwI38pqLvG8cRxe7Z4ur6yJ+xiqzdhbzZ9chmsvQe/t2jUYSiqzibbLTiSboNo5wc0
         TYk8f7IT52Jl1AX3J3+Ko/Q4n5N3ENPEgkFGBHrVE3hU5ZTPkUiLMhdCjEfEB5b9T9Pr
         DxDmtIEcAxxwiI2oLr08nXUYa1yQz6ZQ5D5rp0cMEF4qfF5ecx864g4sbFBnMZjM6Cb6
         HfcPuCNc7T/Ip5ZspRXEy5aWoYhTjcVPJd8Qm/V126SEZWAgo6TtcmcscVXMWuesFiDk
         S7Hg==
X-Gm-Message-State: AOJu0YyeliLjDiVxnNXy06V3KgvIy7LwQ+Fg00ENctyRpm106+xdqrcK
	llQgDlTuCsB0s2IK3prqqmPV2FfKjSt+/CxdBJuc1OUFFWhRFRENiYNt9g==
X-Gm-Gg: ASbGncuwzO4wkBhWWIFKLaGquQeLdFh95azPTVOIbB5DtWKm+IuxIOCrKXK34YLcBxP
	Ckaolir/YcpsdsBtPOzUKqy6iAuwPT4+IE2HNPafmYatJtuAnB5fsrPinM4h/wPS/cO0XVsny6u
	8fVVRTQUjL+iBMS572wtGCNNa7TLkRXcJ8KTTl7BhealmL5pbHlQpscX/M0ropLGxZhtQPaeTG4
	A0lMPSihvGFuwedvE5f7Wu4ziDJ9V5CQkWw+HvhipiskJP2YZkFE2bNxyXCUnp7Mdwcuo4L0zmC
	wPkjRGejHK2ISz1eFVYceO5oBvT4ZLhA+jOczfF1nDXry8ju1W3eVfr37/t1RGUJwSyCwABzJmy
	zo9I=
X-Google-Smtp-Source: AGHT+IFI/to8Ju/rWyzlbRZY07iMIwIGy64IYgI/gW56ewgY3aYJBOBi6VKlvoQIH3Dwn9BIVcSMzA==
X-Received: by 2002:a17:902:e5cf:b0:220:d078:eb33 with SMTP id d9443c01a7336-22c536195bdmr256079245ad.36.1745357057550;
        Tue, 22 Apr 2025 14:24:17 -0700 (PDT)
Received: from smtpclient.apple ([2804:14c:32:97e3:2ca3:dc92:5416:e6c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50ed12absm90261045ad.207.2025.04.22.14.24.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Apr 2025 14:24:17 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [GSoC PATCH] json-writer: add docstrings to jw_* functions
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqq7c3hb4cj.fsf@gitster.g>
Date: Tue, 22 Apr 2025 18:24:03 -0300
Cc: git@vger.kernel.org,
 jeffhostetler@github.com
Content-Transfer-Encoding: 7bit
Message-Id: <EE721541-8445-40EF-9AAD-ED88B3961546@gmail.com>
References: <20250418165651.14125-1-lucasseikioshiro@gmail.com>
 <xmqq7c3hb4cj.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)


> But such an array can be embedded as a sub data structure in another
> json-writer with array-sub-jw or object-sub-jw and once it is done,
> it is not "top-level" at all.

Hmmmmm... Perhaps it would be better to replace it by something like
"the main data structure" instead of "top-level structure"?

> Perhaps it may be beneficial to give an overview of the API design,
> at the beginning of the file (in other words, not a per-function
> comment, but a comment covers the whole json-writer API), to outline
> the concepts and philosophy the json-writer takes to build json
> objects, perhaps?

The beginning of json_writer.h already provides a good overview of
what it does, but not exactly to the functions. It also provides a
reference to its associated test (which can be used as examples), but
yeah, it is not exactly an API overview.

> - json_writer is to build a "collection", which is either an object
>   or an array.  An object is a set of key-value pair where keys are
>   always strings and values can be of various types (including
>   objects and arrays).  An array is an ordered set of values, which
>   can be of various types (including objects and arrays).

I think the already existing description covers those higher-level
aspects well enough.

> or something along that line, perhaps?

I liked it, and I'm working on it. But still, wouldn't it be nice
to have descriptions on each function? An overview like that is
enough for me for understanding most functions, but some are not so
clear (e.g. jw_array_argc_argv and jw_array_argv). Or, to not
being too verbose and repetitive only focusing in the less obvious
ones?

Thanks again, Junio!

PS: I'm cc'ing the e-mail address of Jeff Hostetler provided in
the latest commit created by him, since the first message couldn't
be delivered. He was the author of json_writer and I sent the patch
cc'ing the e-mail from the commit that introduced it.



