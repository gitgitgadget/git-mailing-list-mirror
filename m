Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2A28FD
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707173095; cv=none; b=BINdG/+8SuFxW+xc1QjtFmXQl6TbBNLdFGKBYa3wnRVCqQCvQUotVdLuNgYjz22IadUFqXq4ALAl2a29kivVzHSeOUSH+PiXSeb7LxLR9BP2jX3rMB9udjiCpvJV9F8Vu79w7RrwrKJLfeQHx9PT2y3XIoTA46bEZ/wrbuye+Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707173095; c=relaxed/simple;
	bh=XO8QxT2Zdzvnmc6WfnF/z51jw58rrYSMeCwdyoxFBwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6mTCtJIy/a2aJEY/pRq/+S1A3+y5bOzBUBn6DOafd/PHF0Rr5LN6TlKZMdfcsb9hv7s6h+sx6FHNtekZJR4S2BxRMtGQLStLNhMirq6JYWVN1Iz7wAURN8IjyNJ2K+YTxMluIoiOLDCGM++m4h2bRpIxv9mik1HucjEHXuZQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ayb4KmG1; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ayb4KmG1"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6818aa07d81so30458876d6.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 14:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1707173093; x=1707777893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c2zsnYx0+PqLCb2DAx/cs3jdZbpH52yMQrTE6N3AYQM=;
        b=ayb4KmG1Q8Ggk+PNcbHSfPBQzG+cUznILr5uvptL8/CaZYQYlMgYcsQlCRl2sY/f5I
         X7zhLwiZOF5/5Oym4cwm6ZIZIPUC70sNkC931J8HP3aiOrcWa4cwS4EoJ4L2AflKXMfT
         FougwQoXFX6agzZi7x66p60r35GqRvIj3EnWMnqyNvQYVCiv0MBiQhH/U38Ha7Cvewrw
         VFkIhJfcwDQISrVAPleMLZO5Br1RTasi2AT/cLzak3CpWi7rJhVHg2S4Z/wLhewJ/BP+
         2KPtsjRiBpQUFR0Ygu00Tphpcgyx7w24r3IV+XclCVxZoAs4WGyjInTo5sz+/Kaz69jx
         3vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707173093; x=1707777893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2zsnYx0+PqLCb2DAx/cs3jdZbpH52yMQrTE6N3AYQM=;
        b=E/455EZwMniWmo57qj2VfcwgshI15bz5PTbrnvciXOkiG0lv+pItPsainqRyzMSTAY
         O+ypzZKpOCutd9mJf7oYioe20xyyENK1DOAdWQZX615DfgtsDB7QfGySijXCjqHj0Fgg
         hrPMNh0+HCpJmgQBjRgvPGAwkmrEqhRacHXXnxsJrvb9z8Pm4oMbOI6r0N8+EZPMOVQl
         so89iy9St3KZHvBQ+FM59WtxThDK0D+C2PF1kyp2pV8QY6c1Bq9f9yfjdbhxLsGWAVPf
         NWg8fTqa2B4Lz4NweBSFoJuUdIoylr3L0BsogkDQ89S7BiZnVmCHUCVY1och73BEe6wF
         mKOA==
X-Gm-Message-State: AOJu0YyU7fFwuDwet+IK3hmfIaZaWyALQgOVPWXrnVoeFUJQBwPpIR2m
	4SQm3XLf8hFmGb39+3/49/ORxnBfEo5aKIOnHTCcuSm0NQ0NJdSk8hY5WsQeLjk=
X-Google-Smtp-Source: AGHT+IGkYTCNmJkDQunSeUUnHKlu+LNf3wiJqtIBUgYBe/18i/PT7kJD8YEMrYZS4nsagp9WopJckg==
X-Received: by 2002:a05:6214:e6d:b0:68c:96cc:e70 with SMTP id jz13-20020a0562140e6d00b0068c96cc0e70mr402685qvb.14.1707173093227;
        Mon, 05 Feb 2024 14:44:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXKDGyl5hm9UaaxvrvpUpxtlE3U3a5nZ0ITl4kDxBSXK9L4P8DD8+2bRCeU5wAI9K59tHhDZ1fOeW3Yp1LyKq1BIVOokf+oQsfSY6QU9mkmlA==
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id dm8-20020ad44e28000000b00681785c95e0sm425575qvb.46.2024.02.05.14.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 14:44:52 -0800 (PST)
Date: Mon, 5 Feb 2024 17:44:51 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] t5332-multi-pack-reuse.sh: extract pack-objects
 helper functions
Message-ID: <ZcFk4yvj6TM2WzXn@nand.local>
References: <cover.1705431816.git.me@ttaylorr.com>
 <94dd41e1afdd6d926a106ab387295cf5fce624cf.1705431816.git.me@ttaylorr.com>
 <ZaeCeY-9AIR-zt7u@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZaeCeY-9AIR-zt7u@tanuki>

On Wed, Jan 17, 2024 at 08:32:09AM +0100, Patrick Steinhardt wrote:
> > @@ -104,12 +110,7 @@ test_expect_success 'reuse objects from first pack with middle gap' '
> >  	^$(git rev-parse D)
> >  	EOF
> >
> > -	: >trace2.txt &&
> > -	GIT_TRACE2_EVENT="$PWD/trace2.txt" \
> > -		git pack-objects --stdout --delta-base-offset --revs <in >/dev/null &&
> > -
> > -	test_pack_reused 3 <trace2.txt &&
> > -	test_packs_reused 1 <trace2.txt
> > +	test_pack_objects_reused 3 1 <in
>
> This conversion causes us to drop the `--delta-base-offset` flag. It
> would be great to have an explanation in the commit message why it is
> fine to drop it.

Oops, that was unintentional. I'll resend a new round that fixes this
issue shortly.

> Other than that this looks like a nice simplification to me.

Thanks for the review!

Thanks,
Taylor
