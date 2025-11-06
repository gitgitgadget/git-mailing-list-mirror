Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277532DAFAA
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762465925; cv=none; b=buA12CnfvT0WZuoAmqDo56hFo+0PfAiIwYXGpimITYxu7Sfp2/5jN8YPDPsuhSE8M0emEEJMu2Fp34UVfPockcr/3ttdgSmnlZ3SofrFxG+IxC/EEfUMKoyl+dyek2SEfZCYobSUdZdemRYhOQG94oWLtDiI152Of7Uqlby5Zuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762465925; c=relaxed/simple;
	bh=PfDz15IJTp4L6xaJZUodn30sCDAjOxgD43h6mbSmNr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3Antl7C7iMqfTTfibdCQbtKNRm6kB6viIGvr/ssZylPWee/i9X2qF8Y8oGaZffBmbFJB3z/LKx4OFJ0TQP3RLKF+HrJzW9rU0LeOX0AO0GbAy7Tn9mObaTcfqyyYlFarr6gpHyz83m7G2FbB2djXjsARTbYJAsDX4vtE3WEPxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjYsOXqz; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjYsOXqz"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c2878bdf27so61506a34.2
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 13:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762465923; x=1763070723; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqULEeCa1xOgYD3XmEFROidOVIidKJmiAdPOOnKOwP8=;
        b=bjYsOXqzGbT3DbfyPKLjZs7wQvZ5WZp41TV8Zp+k0pn3wXv6Dv1Mw7BvMILYYNcKCp
         74+qrjhlRWRVELekDdciSNKTrBT/wh5FTtBeM0kFeN7EFkSNbepdQMxdczeU2UZpbwJi
         TQxWj9spl6O60Md5razio+VtiWnTHP9y/AbcmKdwWi14D1bicyTrbC4JbVzNqJqQm0dM
         a4Cg6MouNlVRKw8pVY5Mm7XQVtvXmNpj9iOv70Oo1mGeiGavrrcKf0EnBoP0TRhjU7vG
         Tgs1rR4hqG8MfP6Iu1vQBj3GsLG1pMfyAAr5bhR7UnAuiUSdsgEQf++D3uZBize97STF
         efYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762465923; x=1763070723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vqULEeCa1xOgYD3XmEFROidOVIidKJmiAdPOOnKOwP8=;
        b=LSN7WST0oNyvCcbEdr1yMKFtKpnDn83Yy3wNvs2TXmdbQPyMCqZMXJh27QpWh5lk9I
         BUz3HjFDt7unllU2BbsiRzUcZ2ECrnUaaV2jYvKQYLFoj98lJXDptu36RfQR12ObgK8r
         1nAZilPc2tU0sGOiBKYWpKbEjv2+7ZyZu8e7EecN+rC5zaO4aAB26x3cb+xKGvBq9YhF
         aSXovM+C8LtNiC+MceTslvjluV6KDeEG1+clMYKPcwn5iqpthPj1n48MDu23X4aM6u8i
         yvjgjNzxSpCRq4TPMljLdaGH86n8ZVTyRARC4EpzY98flY88KkKDIevDYCSdUScC/3vz
         SYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw2yKhteRiUmR0GMB7/XGfB2rY1tJPp5xuZ1g7wL9UKUIA/VICPgQi05ZpYf+LPZEonX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KIv6wstw/Ab5jIJOwhP0+KPK7PIoYMYj3UaqxXgXRZTCYcqk
	5l6yYgSTZVx3dZL9g8DuyKNDOFQlj8nGLP8rOFcVHfSWVVcR4MTehHzq
X-Gm-Gg: ASbGnctNPHS/CHK/kg+zO0putGsyhMwXtdtVgcc/Hg/2JxC6bvw6ISKLy8/V2Rtj+Qb
	FCmO16rijjoZtMl+46AsWZGaLIfd7iDW1XDaqZWPXKrKAzlAwKIoSwFaOQewwRqgmD6G+nx7r2g
	ILBEp0kzu95Jsm76WYiSc8P/rJ2Dc2q0xPQVxtw/zbm79EgzfaeB/YvuWY0bmquAZpOalPL9Ma2
	VORKc3aH2TgbrP10UABx5BXrgagz5P/VZ7xvIlUCvMtq8cunH1rM+8pZPoLEa/hQPLKUvWRIwn5
	2i7uRKEIuZIOtVnp72RwwgKyhw1qbHZlBoPJMym57nxSC/pgJVZietMQsnYyig8L2OS4vVQC+ct
	5uevY5NedmDIyiU92WR77G8erusRtleK8IQ58f8JJ1S7+UXlSBw2u5HP+rnRjfqpRKm31Hg==
X-Google-Smtp-Source: AGHT+IFIIKlJPfRFuCkdNrui27UwqF79eMY+augynhFc0UU9WZq1unD26Wmor5h+BWX6iiQ+b50jHQ==
X-Received: by 2002:a05:6808:3a0f:b0:44f:78fb:7b11 with SMTP id 5614622812f47-45015ecf3c5mr480104b6e.39.1762465923111;
        Thu, 06 Nov 2025 13:52:03 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4500257fc6esm1253188b6e.6.2025.11.06.13.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 13:52:02 -0800 (PST)
Date: Thu, 6 Nov 2025 15:52:02 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	karthik.188@gmail.com
Subject: Re: [RFC PATCH] diff: add option to report binary files in raw diffs
Message-ID: <id5zny6t4cr5eaow4ttvdmaksywazvgraq56m2x3wviw3rij7v@fhjfhva5favl>
References: <nxl3sgs3h2psylifnbwcjmubdfmfhj53jjun5nsa4aqq5robh7@quga463ajvbu>
 <D80AE9D4-EE8D-4CAE-9212-2A592F45AB90@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D80AE9D4-EE8D-4CAE-9212-2A592F45AB90@gmail.com>

On 25/11/05 07:14AM, Ben Knoble wrote:
> 
> > Le 4 nov. 2025 à 19:17, Justin Tobler <jltobler@gmail.com> a écrit :
> > Also, maybe this info could be on a newline following each raw diff
> > entry? Something like:
> > 
> >  :100644 100644 a1961526 e231acb1 M    foo
> >  binary=yy
> >  :100644 100644 31eedd5c 402a70d7 M    bar
> >  binary=nn
> > 
> 
> Whether combined or separate, self-documenting output is nice. Separate might be easier for line-oriented tools? Having to split on commas and loop looking for keywords seems like more work than just processing a line at a time. Idk.

Ya, I'm also a bit torn on whether a single line or multiple lines would
be best. I'm currently leaning back towards using just a single line as
I do think it is somewhat nice that each diff entry itself is on its own
line. Ultimately from the perspective of the parser, I don't think it
should matter too much whether its splits raw-extended output on a
command or newline.

In the next version, I'm thinking the output will look something like:

  $ git diff-tree --raw-extended=binary,crlf ...
  :100644 100644 a1961526 e231acb1 binary=yy,crlf=nn M  foo
  :100644 100644 31eedd5c 402a70d7 binary=nn,crlf=yy M  bar

Thanks,
-Justin
