Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76A22B64B
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 02:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729823953; cv=none; b=TRtSeK+AGzQkx6dGBTlMS6H/q5QR3u4q3jNX7W4Y02n04I6YMdB2op+8XmmR4bc2pDRhSWqRYr3XjM8ZdYRxbrzLMhq+GA5JM2eCsGDu8kbD64N2wsNgwBNhbLjAQCn3TETvFqBBTlwmXGps+vXUl4/O+dLuUGe0+4E5rQ5WUuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729823953; c=relaxed/simple;
	bh=CgrXWZQUm+gy79/bKdx9muJ6ms82gR5TX5KmLQRLGyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFObtICrBFrIRlmQLzrqKyy69G3/GrRpV7noY3sUqQskH5Bb6ZP/Qvbq3jLyrskgyi1wQGjIePvB1w7eSjNN2SeRyjKait3u8Mp5WfXImfw5ayHLNYR2v1lVDNIJOccXHaxA9l5ENaBDdc4ZV9nBWo8QHSv+nC3Fz5owZD5pg7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUN1keLe; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUN1keLe"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3e607556c83so952150b6e.1
        for <git@vger.kernel.org>; Thu, 24 Oct 2024 19:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729823951; x=1730428751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgrXWZQUm+gy79/bKdx9muJ6ms82gR5TX5KmLQRLGyg=;
        b=mUN1keLeRDlHaupqYvo7DM/QKASKM2OWSJMtNzql/LiwYhEP+W9hueHzJRNa1XYmox
         Cmvtsri+2Z8RLuR5N1358bKbDlhTHvCs3SrSE9QfkB+S5Vm4zAHp/iRFf/DSX6I8bq3i
         LqRa5YfFOFtaHglmOK5ZmwPWXxWR1M0HoI289babMxxze3tfogyW/HOLc41EU7CN/zGH
         /K7azQYdkKLtVGuCdtOFuml/OTY9ajIzZnSB3gdm3b6Acj3fr+Ex+K2QAq+e0nb4C+Si
         TakdFw6TKXAjNZGoaNpFkz51SzPWhFfECME04cgJ8j2w96GDnaCxVZqstV9l3GmFaMLK
         gE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729823951; x=1730428751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgrXWZQUm+gy79/bKdx9muJ6ms82gR5TX5KmLQRLGyg=;
        b=lDpVGqtM7UcPmWzmgMe+EojC9E47zB+ITpDkRdgsNMoC4miEJGQAcSbfTL9WwkQ8Nf
         BEZr1PW5AdBZs8WacCLQT4hDLiyJI7XzRU9Ym4T6gFCGjvlaqDZDUq/VFh//LfeBxq3n
         Yk5IsnMA9dgXGoF7Lzr2Ll9bfK7CL6t7pUuCEGzpQmX9Pe7js22suWUESRGmUMuePKfc
         1XEC3fQItwPnyrVOg0sS9ZIXdZQUk2Wtd+yv1ugs8oSLbz0O3rzmCPjcIFJtXaqukKac
         ynwLUYvb04yspddP5cqb3lcBvohgSehUqyCpVpTzwqGjkkphRcaE8vCofD3XsLkh0tTy
         S+Mg==
X-Gm-Message-State: AOJu0YyfcabdWfeYpPa0H+vJnygzbN4AbfI+iiZCBuqagTfHC3O8GN29
	t6wSc6bkssRfzRWYD2Vo2MtnQM8d4d/J6HSqd5TutFHX64O95/0o
X-Google-Smtp-Source: AGHT+IHzJoVRQVP9Y/kVVOqh7326otwVJn+LPo4vGYhyGTTrWK7CSnmyW7P3n1efa0P0sKofQ0JorQ==
X-Received: by 2002:a05:6871:708:b0:26f:ddfa:3571 with SMTP id 586e51a60fabf-28ced115c64mr3925074fac.2.1729823950663;
        Thu, 24 Oct 2024 19:39:10 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-290363d15b7sm76982fac.33.2024.10.24.19.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 19:39:09 -0700 (PDT)
Date: Thu, 24 Oct 2024 21:37:36 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, spectral@google.com
Subject: Re: [PATCH v4 1/2] clang-format: re-adjust line break penalties
Message-ID: <xefdxe2vctdtmfm3vfanstfz5q2bgcklj7ymio5bdutioyaxmo@ujixbc5jua6m>
References: <cover.1729241030.git.karthik.188@gmail.com>
 <a8c8df5d95b0defec672ee139acd366219ea3302.1729241030.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8c8df5d95b0defec672ee139acd366219ea3302.1729241030.git.karthik.188@gmail.com>

On 24/10/18 10:46AM, Karthik Nayak wrote:
> In 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29) we
> adjusted the line break penalties to really fine tune what we care about
> while doing line breaks. Modify some of those to be more inline with
> what we care about in the Git project now.

From my understanding, the original motivation for these changes was to
cut down on the noise from the clang-format CI job. These changes seem
reasonable for that purpose, but affect the also formatter in general.

Out of curiousity, would it be possible to just configured clang-format
for the CI job to behave in this manner? Ultimately, I'm not sure that
would be good idea though because having a diverged set of rules may
just cause more noise.

-Justin
