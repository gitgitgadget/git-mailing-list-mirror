Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C1276D36
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 00:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702884; cv=none; b=bvA6zdJycgDHzOl8aRwL6ESUbL5cOGAy6TifiodbdeL/4SpHy/MYG6IoqW1Ck9ctSwT6JXFTvD4eDYs9vKYngFQirM0DOQ3JOcdgc3SRXfQUYc4Fjclh4LNrJge0UYcegZlSb6xCyz4wJHs3LmNkRYoE+Pz06GP7z9yg5R7vU6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702884; c=relaxed/simple;
	bh=0W4r97DO0jizmYMP3iEmbuI5muP2SnzIWX6E3YIWnAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/EvbVt4fkMZlXKBkHlq1xDBYw/RXsuT3E5XyMQpdHegssq+UQMTvg2BbOV64pnYdqkBzF09brFuJvsj+JjQndu/4S/y6S7PvNdX5eQpomMMKT7BHfogwI7aCZkW5i40FBSE7GuelO8IGnlkmu3OuuFUSADuA+wplgGAlcJALSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=uEMUytLk; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="uEMUytLk"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fcf90d09c6so14110117b3.0
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 16:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1740702881; x=1741307681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hWS37KRYBrIs0BANhwrdmAf0OZDJtNPdtyrf8d4knmQ=;
        b=uEMUytLk3Uqgfg4g1XkKandiClXUdOrY5Cl/+GQgjT8omvC3IDO/LyG6XPqrcR/kez
         0Nog7r1ma+ojEpvOXJPeGVqW90zhHuLyZMczm9AuEOMe6NhjVhztSA3VrVnP81uxx2LM
         mWDhi8gMLx8ri4a5W7MBBsiYzjcBYkEi6vEkyHtc4GTJ42CQjpbx9ejnVA0AyViLdtLE
         bLsAgZygLdOLXZguDQInU1ex5UFOfpvU4CoH2H9uWqNDqyYWpzDVnCWNXkkhrcMO62XC
         creu2E47Oqj7v9hxQMsxH05B6BHrYxwOuhe5Ql3gsPnw1mtw4NEWVFVEO9vL4+UaRwRh
         B8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702881; x=1741307681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWS37KRYBrIs0BANhwrdmAf0OZDJtNPdtyrf8d4knmQ=;
        b=U6x/uAETQG/j6Jq7bQQghsS8DabKzzpiOsVZggncqj8INc/NYt5PRb2mZohxYR29s7
         Aw0U+86SQhC+50vnkaS1QkTJnmiioniygPh0iWe1hYXAZ35GdjZvU3kKSkecQsTf38fT
         EGxJET6rUGDaqEoADhp8x9cE+vnOnWNEv0K52Pa+6Mc5YMJwv0BmrJ1diBQ+bG6+Rtg+
         w+UpdZnNZ2iD87rYtC/9FNA3QlHSG+VicjvOhwuwGrhBJHT8QOIz4bJVuvx79gSMFHMZ
         4FUCicKAmQgwl/p1pdzONaB12eLqL2fyASP9/CUPQoxkFUTZvht2uO7oq3/imkeUxdYz
         g4Sg==
X-Gm-Message-State: AOJu0YzW9RPQrCm4VRPhiLv+Su4LQhTPipGSE8kHCv1glP1ul1dKQalj
	TF4YVNzkwJTBYW6N3pKE2oYB5+dJ8jReAGKbUIr9ojuUTZpioQ+0/M9OsoiHol8=
X-Gm-Gg: ASbGncshpoyxw0KBZ/wiJmTkOCCHX6kdLZ50Mz8xx4TM1F77m1B1Ry26cy5BAu55Elp
	cahUrzgRLhNzN6AWGQbniYaaWs5+Rp/FXW/Jpx1mjva3Hyjeq3xUJjm8Bpv3AIlHnN97v/CNYOJ
	R8OFGh6juaNJLY9xhKMskp30kZ5UQY40wZ9b5mEmm2yiJVnr9C8gT6vfFuA7rcyRUymluUJkeTb
	EBWsSazlpdeTUIacXoPx+jbEQPxiUnyrdacx+k/PdoNFxsVsBEiKFqAQkp67McYqqP0njcrNGqx
	AhdlTgSu2fQMcvZkyQl/mQ5AzTomDzHS6sN4p9G1lnP/0wvHaD/3GUGdCCiD+BDgWeKZnYQBbQ=
	=
X-Google-Smtp-Source: AGHT+IEU/ytV6PD8CflO4LI7scuVAwwt5W5PvGVi2pJU1R6/+GURn1EjWukjQMmbTgBfFsmKIgwbCQ==
X-Received: by 2002:a05:690c:8c17:b0:6f9:e4e1:a86 with SMTP id 00721157ae682-6fd395f0e8cmr59680387b3.16.1740702880709;
        Thu, 27 Feb 2025 16:34:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-6fd3cb9d668sm5177417b3.100.2025.02.27.16.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:34:40 -0800 (PST)
Date: Thu, 27 Feb 2025 19:34:39 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/10] unpack_loose_rest(): simplify error handling
Message-ID: <Z8EEn2LGetE7B4Sp@nand.local>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
 <20250225063351.GI1293961@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225063351.GI1293961@coredump.intra.peff.net>

On Tue, Feb 25, 2025 at 01:33:51AM -0500, Jeff King wrote:
> ---
>  object-file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Much cleaner indeed. Well spotted, and thanks for fixing it up.

Thanks,
Taylor
