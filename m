Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0013EFE3
	for <git@vger.kernel.org>; Sat,  8 Feb 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739028765; cv=none; b=bncjB325IrCx/y8JRGjPAbqksBf/hGmhsfFPxFQtrtoCVN2QPptFNwOx6dzZtNWkx2HAu0EXe4QU90YBcb7mFCeDfuIgcfZdH3xKHl4RyusqO6MVfEke0bYx2bwnHhMvcRLR0pW6/CjAVWaBXXZyh5VT9c9l21P2Mr2AuHuUnX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739028765; c=relaxed/simple;
	bh=MF8yLICIt4sSsOD/PUGv0FVJ1NbI0STzTpP3Et8f48Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta7ypOuedUMqMhv8Aejhmzgtl0SrAthv7EYI4CBJ9Z2prC+xTCXXvJeJUXb7zLf2BLmHgdNfNlKCK8+uQVUSCmpMSM3vopzMYwCyB8RSh6LrX9Hz6Ar8Rd1Fb2lrAo6O3w25Vujnwgsn0CYvSM/WUN6TOQR6i2Mt0BhnfhXB88c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXXQOLWx; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXXQOLWx"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f6022c2c3so17293825ad.0
        for <git@vger.kernel.org>; Sat, 08 Feb 2025 07:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739028763; x=1739633563; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gb9kGxK1Igza7l+0MAx3p7Glr/Fh9o480ziCsMJlZgU=;
        b=fXXQOLWxK/NCeCtiYrpaemqZgrJXc0pirMPxhmK+BCcdw7aYea4OA2ufpRoyFkHfB5
         UPyFvqWenGX+QgUTKRc/rhJQzBdKnYZ4wTGqk6A9KPGIoWhTbE+/3yjRGYdRKyLNQJex
         QIo1qcJFYvHpzFMthnex4V134DldUWRJhxFwFA30H5h1Ij8YG8D5zPgiXqmnWmyh4mDX
         Jd+VUcXA8HQXo2JCuxxYYUWYbB6ymwn4g3GvWpgeSQjfi3UIlLrOs8kAdmozB3nMTklX
         LxSA9CCPtjVfxvPilJUUtneccJELOgaDvV6/Hi3bS19ps2NYezblvUmu4rhpCi167GHm
         5Mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739028763; x=1739633563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gb9kGxK1Igza7l+0MAx3p7Glr/Fh9o480ziCsMJlZgU=;
        b=Mwcf/SoReNmra/kyU1o+kGg1zTMFNZuwEjuty9XXwb/yillQFyQYbq0hkQm/xvUVL+
         6TgEb/hZM6/BMp/onjfiA6cqFsKHcxIXtqX1Vw9W8nwInW+8BYMbmzMave6F/lMe81Xd
         Ac/vxL50/sOp6n3lmmfWIkZ6SJGKRCmtWGTGkFRbEAVUp9isp/QMACXxa6skcAGdi7ta
         Q0eqWjpFbB34vgmRNBsU50ge9OR2pLgcSY+v0qxL/1eIJDkWNiJsmpCGk9Wlla0TUMg5
         kjJhSsdJTqvcFZVhyEvE5UZZ2Hzy+tCrX5ehmBLVyxbAQJMsoKWUslrPuGuwf3oSbk7M
         Itjw==
X-Forwarded-Encrypted: i=1; AJvYcCVd41wbN4g3QIqS7Ddhm+7IXDVCKvWJq0UYDi3TCLa1gONyxk2BLsndXgmSQOI7zAB1Rjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSgPensVYjF6nisbPyG1b2Z6oUue54Q6lyGJkiy7/MfrNTjNi/
	8J9Pq6DKNMQySi05ELIHtJZS3iRCgvwo3sv8XOuw1fgBvkYUuJv4
X-Gm-Gg: ASbGnctPMJAPbIPzNgEhfVnv+ttnr7BbnlptwG4Hz4tiKgxiWDJeLsvKeiA+phBTITB
	rrtSKYT0S5Co3l0euXYu1u7kQswyqyZCIsMbGmTBQCT6POHlkZHmQrOXcZ87isbYsEMrA3Az6ux
	p35DD9gP64wmK4WeeBTs7yZFCxxQ1aWy0G6zS2N5UgBZkT0dGa6ckgVWgfvDtg+vHr3j2E+S1ge
	TlPsAPtXLfgahNDfIm4Eq11SxWeSXGU1DZ9OIxUlQCVasatli1lFW8b+KkZtYDHPM37Zw==
X-Google-Smtp-Source: AGHT+IGRON+scAhKbDZML2gPd9eEZxu3YVaQMso4vUgF6HQCIphfeLaixuBr+X5S8fUgmwKq+5ZnKQ==
X-Received: by 2002:a17:902:da8c:b0:21a:7e04:7021 with SMTP id d9443c01a7336-21f4fb9016fmr98692205ad.24.1739028762789;
        Sat, 08 Feb 2025 07:32:42 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f368b4fcasm47851075ad.230.2025.02.08.07.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 07:32:42 -0800 (PST)
Date: Sat, 8 Feb 2025 23:34:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
Message-ID: <Z6d5hCrTwChJ0PVu@ArchLinux>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im>
 <c39c5424-71d0-4b6d-90b1-a6a70f2ee61b@gmail.com>
 <cd90cf17-6113-4634-a774-6df707b73e95@gmail.com>
 <d5cba1a9-fe51-4f3f-970b-3ef8a7a2e459@gmail.com>
 <CAP8UFD0GEmsJDFzVAV1bgBNeD6K3auH4paWEKE6=f0=_E6gifA@mail.gmail.com>
 <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2a76725-5778-4b7d-a266-c3a1431316ce@gmail.com>

On Fri, Feb 07, 2025 at 01:02:25PM +0530, Kaartic Sivaraam wrote:
> 
> Indeed. From all of your inputs I was able to come to the following
> allocation of mentor / co-mentor.
> 
> -- 8< --
> 
> Consolidate ref-related functionality into git-refs
> 
> - Mentor: Patrick
> - Co-mentor: Jialuo / Christian
> 
> Refactoring in order to reduce Git’s global state
> 
> - Mentor: Christian
> - Co-mentor: Karthik / Jialuo
> 
> Machine-Readable Repository Information Query Tool
> 
> - Mentor: Karthik
> - Co-mentor: Patrick
> 
> Implement support for reftables in “dumb” HTTP transport
> 
> - Mentor: Patrick
> - Co-mentor: Karthik
> 
> -- >8 --
> 
> Let me know if this sounds fine to all of you. So, I suppose we could
> pick a maximum of 3 projects but we cannot pick both "Consolidate
> ref-related functionality into git-refs" and "Implement support
> for reftables in “dumb” HTTP transport" at the same time as Patrick
> only prefers to be mentor in one project.
> 

I am OK with this.

> Based on this, I'll tweak the ideas page to mention that we could
> pick a max of 3 candidates.
> 
> 
> BTW, I've just submitted Git's application for GSoC. We should know
> by February 26 about the selection result.
> 

Thanks for working on this.

> --
> Sivaraam

Jialuo
