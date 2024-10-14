Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A92615575E
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941147; cv=none; b=HRUVkK+4dX0aMXMuImuEq+kcOTDn5Wt1VZr6hd6tCvfNRZ4tPyhDE5CFi+tm1CCWOd5TLSa9QU4mB2XBD5niBZkjaEVcojqtu1/xXPDysEsE3slRIx7+TcX+DsSqLQI6yGRcgg7FNB0DftSYgjVMIHsYV7RDnUcyObMEuWRf1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941147; c=relaxed/simple;
	bh=Eh2K48LnZx9chgPs9Ttu2Nss7iG9kjoBgwkohF1Z/Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRYzsd3YewFaK2ElcG5v4z0pDp06Fef1HUxIYmB77NH+AIUB/Nc3PPKeGHHCbaxiBVVzjpDUXAOEvmOhwcn4865NYxdd/PGsIJBeNZtkaJco9dRqu4Mn6DVTHacgSSYUOIdYIEZsGsF5vtLd3SSy7llfRLVhcOd6CKuCiyclFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=WXwaKmEf; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="WXwaKmEf"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e34fa656a2so26543907b3.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728941143; x=1729545943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Eh2K48LnZx9chgPs9Ttu2Nss7iG9kjoBgwkohF1Z/Zw=;
        b=WXwaKmEfv8qDTxHoRx3dpqd7brypZyPpSr3ushezERZfMj8LOZZQcvGDLeJ/5PqkbX
         1B8UgX3Zrjtj0vmwGw9j0ncoC9UDaUBHEAKQodN6TnpHRTf/mpn2X0LcdphQLIkjjVvA
         eQ1Rg3uW9bFhMLoU7cB6pWeRM3S8Zgvj4qnurasfvjrGfh0fOr8xPB+e+BmQtqp4WhTL
         XPWPBLdI86BwXmpFAeZLwJZcA7yl4xchhSflpDPjEsW0BqEVgWKYRCsJ34hKUBA+i7Hm
         3GKuFMBQCLqmzu0G3I3vTmOMrDHELrKS2vOTaGDwrU4uK5IkIu9dlCgmuhav+7X1z6+k
         ijQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941143; x=1729545943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh2K48LnZx9chgPs9Ttu2Nss7iG9kjoBgwkohF1Z/Zw=;
        b=GttRUnG519ibl1IBm3LRYXvjzJNQBeL3OuRkQedmi3LvJj93fLHvNErW4F1dO0910Z
         nypE5iTuqmxxnXJfq7xQ5TOM5OOu7iqpIzP6BCvZakEa5yHKOm8Eup1f9qsFgxS4f6R6
         xeQzrouRzRaYhDTwZ8BSoFN882lWjlKua6/U0Hwf4kmPoZ6jlD2/3Lis8yoFoRNhaSXG
         c+3R6rfItmbVghLtK+EilyvW2kgmcCVbfCg2VNC0JoBdcGe7KBoTatmAu8cQM3WmXD27
         A+IArD49YExSeueZWx4Hy5BPMyNKLr2hxkdk1/WgJz+xo967bTKrRtmJnSwi3PBa2C13
         qeHg==
X-Gm-Message-State: AOJu0YyFvO+9v91lQCcLeGoWPD2gHlUSLVqdZQx7bhs05OSdDaxf2K4V
	pTKw4Jo9mcMnLzsinR9flOl+RcQ8+fYw8tGA80BEWJFIZoi4dCy1116jd2gDdBk=
X-Google-Smtp-Source: AGHT+IHeG07m+oRsgdZP8AvpV5vLE6umDZVkC6NGTyNLhIKYEZlVxj8dWSDvJOxJvAf6EnesbdhXEQ==
X-Received: by 2002:a05:690c:3687:b0:6e3:39b6:5370 with SMTP id 00721157ae682-6e36434db3amr75265427b3.24.1728941143439;
        Mon, 14 Oct 2024 14:25:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332c298b4sm16766527b3.91.2024.10.14.14.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:25:43 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:25:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Luca Milanesio <luca.milanesio@gmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Martin Fick <mfick@nvidia.com>
Subject: Re: Should object repacking only update server-info for packs
 instead of doing it for refs?
Message-ID: <Zw2MVqi0FLcMuR8Z@nand.local>
References: <LV8PR12MB9407CB282D1FD4998C659D29C2442@LV8PR12MB9407.namprd12.prod.outlook.com>
 <569E3AEA-AC68-4186-B38C-2E47DAB9890E@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <569E3AEA-AC68-4186-B38C-2E47DAB9890E@gmail.com>

On Mon, Oct 14, 2024 at 09:33:17PM +0100, Luca Milanesio wrote:
> > It seems counterintuitive that an operation designed to repack
> > objects would be performing maintenance of any sort on refs?
>
> True, it should not touch info/refs IMHO, as you’re really not
> changing any refs.

Right. I don't think that the current behavior is a bug, but just that
it's doing unnecessary work from within 'git repack' to update the
info/refs file when it's known ahead of time that the refs haven't
changed.

I think it's reasonable to skip this step when repacking, but of course
we would still want to update info/packs (assuming that the repack
wasn't a noop, of course).

Thanks,
Taylor
