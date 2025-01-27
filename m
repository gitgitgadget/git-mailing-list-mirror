Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E81FE454
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737981703; cv=none; b=IpUY/f0wLmIkgDWdYqpHBeQYOcE+IlSIdsclZN1/Hfl6AZDswv/gHBVcZHGl9mN/C+aNp4pGxcDX+bva/MBoUh8M6s5czbJ1+zcOlXFCpfh7DsAK568at/NQh/m+BYcDe9t5GNCiB7pGZ2xOhS0IQXP+pNXyUjoKU5Iwypg8xqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737981703; c=relaxed/simple;
	bh=j5AiWWljneRoXyTFVOiSC9bzd20MfaS8a+s3dE5dhno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT3j+NkT2cMIQI7MSyCLSALwgdSLrz5Lh3Liqzj4j2xkBQccjz4/Jy1r358Eq2oJwMIjfXnj7clUI4qDJsUiQkgY61H61TUx7Hc25D2O8pwHO8c28qX0rQK42DKNDAjI6iA92PRt9hEci3rnRNCe4GVKnlih42NIv1qbPAhGvZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRH1Ehjw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRH1Ehjw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21a7ed0155cso69859035ad.3
        for <git@vger.kernel.org>; Mon, 27 Jan 2025 04:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737981700; x=1738586500; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=suzl5PrtVFY7x1Bi3/9VDjSWscSYkCqNGe6eV6Z77Jc=;
        b=SRH1Ehjw429RvkGBYelH2OjAUT6YxlqYBELwV7eFWHtvdIQkruUz9caSYvF6rhDBsU
         Zo32BW78qS/rlRVmPfJQ/41Qqsi6c8hx1uaNUKWkiSmXTnYUvowyhPnKnEn7Jzpti7k7
         YotZDnO3EaybiMdOZ0J4xGgl5kYm1SQb9J0E/FBU5g5sDFacuzwLi43v8f5TZTUSyAlp
         R/cKpwGjlNUFma0t3HRUNGTOstEpsxA6LqOs7iv+TZwz3ouOj1Z5wmnR+pFNeYmaanqe
         jovJZ2M3KWz7fHGTKc7NL9c889pwdXodtdIgmy78SZWAEbb4HuY3R1uS0GZ5AC3p80u2
         th3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737981700; x=1738586500;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=suzl5PrtVFY7x1Bi3/9VDjSWscSYkCqNGe6eV6Z77Jc=;
        b=IzeO33KcTa2dLFcnuhTue+5IXriEXMKLoAClYh1e2SuxWphqaUqbB3x3u+7tNdPzt/
         wRYgVaecpnPAoXhI/PzK8Hq5v+Ohwn4mQVU5VrqP/skDsN0uZDO+xCGIhB8WaXI8BLwY
         JkeKiErprF82goFd9X2ddIKux9VCCmjfJ2Ml+2+QdYwBYNsvQpNnQ8URYa/VcgvfdfL/
         UcxNKmjGam0vTpMYMF8ESl5Pp+Q3gWTN5I74OtLaADo+GpVXjvISPhTtFXRow284NxRF
         wsbacb5+w2W5kb3O4GVd1NyzQTTzDvXFSiZ7cVWCZmmPjPsxAwJzHqN7zhde7kkmgpNp
         sDaA==
X-Forwarded-Encrypted: i=1; AJvYcCWrw2dA/qKDvbrBqQ10u2/QEsd2cl9dwMVF8sPnommmWOv6cEipanGsm8HkH53wS+HskzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+LmLDtB8WXL7JN9dWDHu3kJHy3aq+vXhIGQoZAS2ja7HTKr8
	l7UmhIl7CjAFTBeJieZeewgXorqm4dh6oSGewn2T7OID5sREdkIv
X-Gm-Gg: ASbGncsq9Lhenh2B/P5912CzMJs7JTsmRdkcJlYB6/F7tYFAO3WcpDXjdiVFTTjJZnV
	9bKeMY6d/fllxWcu73m5ta4JDuYCo6PJZMKIrwGdXukRyFfJMW7w4aAu+6gg6VS1HTb8GL2OpB5
	7/+37XgY3L41d8ygLuExTWVc3XweDhRshtD7DHSoMxmjOwwyBQEMfeqkWSdy+S0VHP2B9vuEkru
	Kn2DTm6qsQUEeS49/cGfc1UUzgThB4zpyX8Bwd003uwMCkVXyInVe9K+Zo=
X-Google-Smtp-Source: AGHT+IHH2FPex6h2CehQrPc52aZyf6/OftJGeu+S2jMBnhgyzji7Z/gULnwZW8YiypbNTdhsi/zctA==
X-Received: by 2002:a05:6a20:258b:b0:1e0:ca1c:8581 with SMTP id adf61e73a8af0-1eb214c7b53mr53826673637.21.1737981699921;
        Mon, 27 Jan 2025 04:41:39 -0800 (PST)
Received: from localhost ([2604:5040:11:69e::e973])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72f8a77c85esm7008963b3a.128.2025.01.27.04.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 04:41:39 -0800 (PST)
Date: Mon, 27 Jan 2025 20:43:09 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	karthik nayak <karthik188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: Git in GSoC 2025
Message-ID: <Z5d_XbPfQQBnwgQf@ArchLinux>
References: <8c8e8797-8de9-4684-94a0-f6c17a592dc5@gmail.com>
 <Z432QXJb_TfzNBa2@pks.im>
 <CA+ARAtqfXo75PzzB3cQjDbvLxwytUK=xJiGG=VHZ1sNCcfyktQ@mail.gmail.com>
 <Z5c-jFA9OAT9x5s7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z5c-jFA9OAT9x5s7@pks.im>

On Mon, Jan 27, 2025 at 09:06:36AM +0100, Patrick Steinhardt wrote:
> On Mon, Jan 27, 2025 at 12:19:26PM +0530, Kaartic Sivaraam wrote:
> > Hi Patrick, Christian, Karthik and Jialuo,
> > 
> > Thank you very much for your interest in volunteering as a mentor!
> > 
> > On Mon, Jan 20, 2025 at 12:37 PM Patrick Steinhardt <ps@pks.im> wrote:
> > 
> > > I'd be happy to mentor this year again. A couple of ideas:
> > >
> > >
> > Thank you for suggesting these ideas, Patrick! I've incorporated them into
> > a draft
> > ideas page for now. You can see them here:
> > 
> > https://git.github.io/SoC-2025-Ideas/
> 
> Great, thanks a lot!
> 
> > Kindly suggest any corrections to the description, project size /
> > difficulty as necessary.
> > I've mentioned potential mentors based on what I'm aware of so far.
> > 
> > Patrick, Christian and Karthik, kindly mention the ideas that you're
> > interested to
> > mentor.
> > 
> > While I have not included them as of yet, I wonder if the following ideas
> > which we
> > had last year[1] could still be retained this year:
> > 
> > - Implement consistency checks for refs. The idea could be about
> >    implementing further ref checks which Jialuo appears to be helping
> >    out with. We could leave it if Jialuo prefers to continue working on
> >    the same in a flow.
> 
> The biggest omission right now is the reftable backend, but that one I
> plan to work on myself in this release cycle.
> 

I am happy to see this. If you plan to work on this in this release
cycle. I won't touch this. I'll review to learn more knowledge about
reftable backend.

> I'll leave it to Jialuo to decide whether there's anything else in this
> context that would make for a good GSoC project, as he's been the
> primary driving force here.
> 

One thing I could think about is to clean up "git-fsck(1)" to make the
boundary between the ref checks and object checks clear which means we
need to remove unnecessary checks and reorder the program sequence.
However, I think this is a little risky for a GSoC project. So, I'd like
to implement this later on my own.

Thanks,
Jialuo
