Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7C51EB4B1
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532650; cv=none; b=YZHiFL9MAD/hSmTKqTFFM2dAtx34N1wkKRH5iL7Yd2/rXtJeURlkpdl3TG24Y1CF3PYGawWj7aF3S06MRwEt0Z91Tr/9cb+Gn0IQj47W27J56UoEt5JUlpK/6T1Q7WJD1F7o/EOcT2THdXlVxTGXmwnM7lKvtgrAK+pO4LM6D1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532650; c=relaxed/simple;
	bh=kjYSHSB8WkZXswWHFnKU5kS7TEKjU6q3kkNExhdqhy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce6VNkJ4IJnQBDml7CBdv2sL3JeslRaQUuFONUbJdKF7xiBRRLO7hddZGjKu3wLWbZ16bXNSCR4q8JAO5CO738U+PFq9pyARDPT8pBdZlQGuD0gLjyLJzdGLiIiLsO5DZxy2j+/lBTVwZ6jWgsEh/2r6Q37dTg7RYrASl991qN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QoW5E5xs; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QoW5E5xs"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-66599ca3470so59877607b3.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1722532648; x=1723137448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjYSHSB8WkZXswWHFnKU5kS7TEKjU6q3kkNExhdqhy8=;
        b=QoW5E5xsYpnWjs2wyjdmPRoySnWvmwGt7VT+Rmh4ts5Wv9uHA/Lehddg2iyzflmF8S
         iVmopm+ka0qYL5CkaWF3K2dGWFjPcPuQw9lx12yIbrjUSaVKydCiqT2FTCLnvFCK3gDE
         pN9tkt73C/BoBwL5Zuq4gOyd2shvu1YEV/JM/5vENDL4rUwodx+u2r6j8qVKpnWnm60m
         zxYeGo2CimDo5P/pmYJOJq65oaXGSa7yz9HFAaEvWEpSTKUXc05HvON4KxJ/qQcgQwrA
         KLvDavzrFTvSDoeTsZHx2/0sqWwSSE9FXt17N51lH8dYjry+eiUbLAOKuqZZ7TysTu/7
         OTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722532648; x=1723137448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjYSHSB8WkZXswWHFnKU5kS7TEKjU6q3kkNExhdqhy8=;
        b=Jwze5frKVgns6cGM7e7wHaiG0KCZDNx+PWC7kvdeKd61XX8fLE9DXymzfBsdWWgC1a
         gVA/utdoBeLN+FodUqi4erBMnjSlIb4IKsxjVl/te73EjzrtJ85NtmWCQbAo+VamUQDg
         ZEaS3ceTkgplhaHSkRO3svY/kVH//PHADSooVW26X8AMvCLcw6rdqwcejWHm78gcen/9
         StiwG9R3egzH6mMU5Bgb7cKD2YD+VbGNzdWAuds5ZfvaI+F/6ZXU6oKbulmDqFAW4Zta
         9vjG6w+DqDZUbGZJS8x3alix1/iRJkbT3UdVwv1lnPzfhlCH7Q5L7rd2yhZaxhCxiNdw
         Q9tg==
X-Gm-Message-State: AOJu0Yy+iZrp/53MPUwSJD1+3XDeC6xUdZ0AkqoQoVDblnyimfO0IEYj
	m8/T4BC+SvVhRwIfjaKYh8UWGBiYWJGurzdd+flwebRdQS5Qkj2COoR7WiswO3Y=
X-Google-Smtp-Source: AGHT+IFZIuRonqAGbbK0c1u7EJ0gluQAaACiXdjKfelsU/DrYys6rX32PQgbvMf0yXtIlE1a5k58kw==
X-Received: by 2002:a0d:e087:0:b0:65b:a403:9eba with SMTP id 00721157ae682-6895ffbd37dmr8224417b3.11.1722532648211;
        Thu, 01 Aug 2024 10:17:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-689af65b19fsm161907b3.10.2024.08.01.10.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:17:27 -0700 (PDT)
Date: Thu, 1 Aug 2024 13:17:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: Re: [PATCH v2 00/24] Memory leak fixes (pt.3)
Message-ID: <ZqvDJpNxMkvd3hSZ@nand.local>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>

On Thu, Aug 01, 2024 at 12:38:06PM +0200, Patrick Steinhardt wrote:
> Range-diff against v1:

All looks reasonable to me. Thanks for incorporating mine and others'
suggestions, and again for working on this!

Thanks,
Taylor
