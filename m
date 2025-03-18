Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AFC18E25
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338948; cv=none; b=cdY1eQoG+yvRTLyNbzCnPl+8NIBMLA4F9Mbz7PnLCy6sjbrLxyROx85bl4CHmEYV9742T0WROj8F/HTXJ2qaKkOTegyFZpokdiciKszpJm7NGFKefoG+l701A/uFy1q1WtdOr45SoNUPsGbZF9CHDVaxRCC28o7d7n/QWVwpDJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338948; c=relaxed/simple;
	bh=ZuiJC6E4ZXii2ZPlKXCl0KFoxEZN5PrHBwqk9EpE/Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPzPrd9g3iqphAQEtpfs4r1xmPorVbMFqmPPKGJoURlmj7e6PRGsMCeBU3Wx5qy4SKHkZ+j8zn0JteevBq1O9covGM6rwgw8cg7J8kRCz1Igrcrx4hIHIVPtfqU0zQ/Hdi7+iAMqYJdi6uvT7ocayzZJU4qwuxF6xvuKa3XDSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cr1QJBxY; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cr1QJBxY"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c07cd527e4so530308085a.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742338945; x=1742943745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oM3HqfK5bVGYgp4jCD05CxuaYpgGbPoYc31Q3dac6Jg=;
        b=cr1QJBxYaIhkMG39TCQ+mnwcuieh5iT5Eoad8hVf/b2SoyJu1+TV+MviMDOR92qtz/
         4P7Ln544tbLdDXJny2zSm2GRsi4X0Zk4CsGCibshcRHUFuDwXqmNB2WoAmpg+fekBnxL
         ZYAoMSlrm2j2enyGltu4str0evkWfeNTtl8PiTPXSQGZRPHQYjfVN5XMEtCiHirOWRnj
         188oofscw5cgRPnjwQT9LspM+FRYT4eoURXlxJVxnc1PXfeSFGH8p+KVAo5DYZ35Uuh1
         pYNhlm4t0t+co8jKOQVm/cBcQxqMdwe3XgeJOrvx7L87e3z2M1vRsA7GMyUUPn/zXOJR
         EqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338945; x=1742943745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oM3HqfK5bVGYgp4jCD05CxuaYpgGbPoYc31Q3dac6Jg=;
        b=XWX4VssTv1NatgPrvaJ8qKfQ0vvjtoap342L/b8+jHWQjH2mpJowfcxehvn8ryE7Is
         og4uskMlYo/pEic0P57lNde0uit9m5VuVaslrnXGfUTZZ5oeRDxhV7RO8KTjDnfBj4EA
         blO1ouVmnLuQotdiY1XHkxWjlEW7KjOQMyxUY78K0pKyswzVuh6cfi5Hye/82+qttQCR
         CNCg4nKmNhqXpmVK1VJsujKmc8rMmXpfamDQl5QN+/XbITYrcPlkLO527Sclok0fhYUB
         43H4NGYBNkGczzFzHdQQoLrIPQwgm/+yvA29UuwQmnfl80PvfInPa4YOInDksJaKSHaz
         MEig==
X-Forwarded-Encrypted: i=1; AJvYcCWbPN75F3lI7NLw1ittL/p9yBl1O4CoCnaEyT6FJCvIn6A1vyZaCziPBWGyXijEXqZ+OMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkoMWt7KrUIyvjJlrG+2bjb/LYN08XW6Cb4jkrF2Pse8Byuh0t
	8VbhAuCDEDv88k/BdoFBJ8vnr7ZS8ySlWZdnx8puAqTTPKiaZBLe3akboZMJIis=
X-Gm-Gg: ASbGncuBtYjm9TDNSXEllgSb5KaHuKWJ+fG84kEDMr4pk/OnHIErsc3lJXO5440ycmO
	nxhQEMwj0uV2dZu8gdOL3ERlhQwEirxnMMS65zqm2ETqnmA9PnFMhlR3+RkPAKc2hD0gV3jcrmv
	f19ZvmfhhfkF3qu9/Sz0WYYkrxpmNY6HhhQKCRDhaHplsaHQrG6TkNy4ZubiQMcmUdfgZxjTBX6
	Ukw86ciDOppx681Liqm8HB4eroTKl7LTQeRUbZ806d8ho/FQQjce/QC3OC9yU8ioimEdyxFN5Yd
	RTxe17Pe7P3euVKkw45NK8PyFE1WSMyYhteeAphts+Leg+8TsbHZXGn5h0YJoHmBbnpAOFhdeZI
	pgfdOVhEnnJIalVzg
X-Google-Smtp-Source: AGHT+IEBn81J/uryzU+SudCYABV8BFnIZNWf1Hf9UKlNS3LnHgcY2FJlANMPnB0XFb+puEt7rdkF4g==
X-Received: by 2002:a05:620a:4115:b0:7c5:43c2:a908 with SMTP id af79cd13be357-7c5a8283c23mr79680085a.6.1742338945641;
        Tue, 18 Mar 2025 16:02:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d72b62sm778597885a.86.2025.03.18.16.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:02:25 -0700 (PDT)
Date: Tue, 18 Mar 2025 19:02:23 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Igor Todorovski <itodorov@ca.ibm.com>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: Re: [PATCH 1/2] fetch: only respect followRemoteHEAD with configured
 refspecs
Message-ID: <Z9n7f2P7AOKD2Pc1@nand.local>
References: <20250318053905.GA2051217@coredump.intra.peff.net>
 <20250318054017.GA2051617@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318054017.GA2051617@coredump.intra.peff.net>

On Tue, Mar 18, 2025 at 01:40:17AM -0400, Jeff King wrote:
> @@ -1918,7 +1905,7 @@ static int do_fetch(struct transport *transport,
>  				  "you need to specify exactly one branch with the --set-upstream option"));
>  		}
>  	}
> -	if (set_head(remote_refs, transport->remote))
> +	if (do_set_head && set_head(remote_refs, transport->remote))
>  		;
>  		/*
>  		 * Way too many cases where this can go wrong

This empty "if" statement is a little odd, though not the fault of your
patch. I probably would have rewritten this like:

    if (do_set_head) {
        /*
         * Way too many cases where this can go wrong
         * so let's just fail silently for now.
         */
         set_head(remote, transport->remote);
    }

, but it's obviously NBD here, just something I noticed idly while
reading the rest of the patch, which looks great to me.

Thanks,
Taylor
