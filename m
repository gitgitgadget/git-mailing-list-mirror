Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CD716FF54
	for <git@vger.kernel.org>; Thu,  2 May 2024 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672538; cv=none; b=rY/9bfiSb6sCwxW5B70+krrDgW7gxdNm9Kdy1GtjunuO4denwGDgxZcr+mr+EuCEKjhxGvqNuOV2F23MC8S0Bn5YEBQlIZRsB1WHEv6KVpM89b99iz6txu7TFFV0gB4BZESzb2apikV1dWsVrH6uB22MoeF6//lAPqXNMzC9qoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672538; c=relaxed/simple;
	bh=N6z1yTsyeNSSUx3Cn2JkykjQ1LCeAPJC2UYwnpGEUdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s++CmWyJ4cOmMhQ00jysBnWNJpOOb/Dyl8oqJbXx3KQ0Kw82ezN/hPV5Ygtn/YDl6HzKbOfC9uml+sgPQBA800EG4HuBxSp/9AQdU8QHQ+Sef+Heq48RNgd1DZh92J/mcbqv/ow9oJPDQhRv9dqrjEgia6L6x/FcpWlHDkdttRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=EDqfoJom; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EDqfoJom"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-437610adf96so55370431cf.3
        for <git@vger.kernel.org>; Thu, 02 May 2024 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714672536; x=1715277336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wubsJ8ixoTXxzQ781codhG3ug2RC8PHh2TrbRx5sHMo=;
        b=EDqfoJomS2gmTOUfjpfFOC89/j15HQKwid4wK7jc6tLT260u3zyFTxNwrs0hhg1YQc
         ELglrm8nWf6o+0aPVMi7Znd5+37cYGeXEIu1U8E/4jZfAMe0CgFg+nnHH3IOD3ZNGQbk
         L1xmslu9zOIHICo+7ntA86+VWV/I6aA8oiwFVc4i3G9kS7wJmGwoOm+XDwrORF8bDJ3B
         d7kAIOHTxLscYRwuHi+KLU0h4fxbehhasEuBMtLe1jhchWe3wTJzQG1XuiM9Xp2PCNRn
         t1w5FesRw8z2OmyPemMBnMfCYqlbTemJG7nehJCvL1Sj+mj6tZdd+eWsZXeVb2s36QAz
         QdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714672536; x=1715277336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wubsJ8ixoTXxzQ781codhG3ug2RC8PHh2TrbRx5sHMo=;
        b=QLYMigktAdvKcwbGonNlLgMdlp9xjRY1kVKSQ0Vsj+GStJjCMWZivLLNRA+MT80hsK
         n9TLD/tTA5QI8w6ETCFk93YyBtBmczSsKZtybiwzGxT3bL8yKY3zQmhPZkcllKYO6qKe
         ja6ieokGLtaY84snuHSS9WrMljqlhqqj/COuAlidFrdKBwGmmDX4a0BcsPDdaWRmYSww
         AAygKPMv1d/UJ4i79OsjED4rRPgo1gEbc2hrXDQZo5vw1xAQ+ttJq5QtWBCQeLOw6I5j
         sK6dUJCPKCtbwp3Gx3WQI/N1dn4b2Z9zcrdJUyfDmN2nsIizyM1q2xXLBX2KUOJ87QGZ
         Wt4A==
X-Forwarded-Encrypted: i=1; AJvYcCUbP8W7nZV3fIKZpDJz0cUWuXP4EPb6VsxdqdUVkvioUWVCE0TQ7yVaQR7n5ixohVPt0SlKGDhwFRY3eZBhxuJD9cf2
X-Gm-Message-State: AOJu0Yxu8cXHM8qBppr6T666WB+syQFY/tHtGwj2oM8gIdn9eEOg8HqD
	xVGSUXEVrmTWIv+1KIVXrzP+flzuKa5ghC2cY17VH/PemH+7eSxXr2oSZNrqp/M=
X-Google-Smtp-Source: AGHT+IFYNrJBDM6YvA+GOwIa/4lRqa5HJMUBjZpTezLdC9jy1ogkfSDwrm7w3H7V7KvFVCa8dI7mBg==
X-Received: by 2002:a05:622a:1652:b0:43a:f949:85b9 with SMTP id y18-20020a05622a165200b0043af94985b9mr314420qtj.32.1714672536136;
        Thu, 02 May 2024 10:55:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ju1-20020a05622aa04100b004399f2d06d1sm668384qtb.74.2024.05.02.10.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:55:35 -0700 (PDT)
Date: Thu, 2 May 2024 13:55:34 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Dhruva Krishnamurthy <dhruvakm@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: using tree as attribute source is slow, was Re: Help
 troubleshoot performance regression cloning with depth: git 2.44 vs git 2.42
Message-ID: <ZjPTlrMdpI+jXxyW@nand.local>
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
 <20240501220030.GA1442509@coredump.intra.peff.net>
 <ZjLfcCxjLq4o7hpw@nand.local>
 <ZjPOd83r+tkmsv3o@nand.local>
 <xmqqfrv0ds7f.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfrv0ds7f.fsf@gitster.g>

On Thu, May 02, 2024 at 10:44:20AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Instead, this patch changes the behavior to only fallback to "HEAD" in
> > bare repositories from check-attr, but leaves pack-objects, archive, and
> > all other builtins alone.
>
> I thought the whole point of the exercise was to allow server-side
> (which typically is bare and cannot use anything from the working
> tree) to pay attention to the attributes.  This patch rips that out
> and piles even more new and unproven code on top?  I am not sure.

I thought the point of John's patch was to allow just check-attr to read
from HEAD^{tree} in bare repositories, and not to touch other commands.

I could be misunderstanding the original intent of John's patch (the
commit message there isn't clear whether the change was intended to
target just check-attr or all of Git). But my hope is that it was the
former, which this patch preserves.

I do not know whether servers should in general be trusting
user-provided attributes for things like "delta".

Thanks,
Taylor
