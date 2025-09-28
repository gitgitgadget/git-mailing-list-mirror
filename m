Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ABB1FB3
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097167; cv=none; b=YJN33oKFu2w+sVpc+JFaKMOWmFSGZt/r5ysVnYie5UzfQqdK1tkgrYMToK8IEnlvBvjWjVK9XOwMy/qtD8RI72zJnqKW4dZIYi+FhGg+ysRTlgocMnYuztY2ntwr+VAOIg8T1uZP3Ep7cZi6uTQXYfiHY8MOzam4Nn16lfQirqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097167; c=relaxed/simple;
	bh=uDxxDRFac1/Oqt2GazzSIxWieght78hQYDAUhs6ctHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnq/Ynw3X14/PcXDAELM7OVjlpM+4t2Mmnzb+zTNnvKZS/9g2/SqjW1KYjxok43a5ZN52bLqKpYnvCq4kUwgJD6j/LKXd5uFP3JeanOENw7CV+nRrS+CtyLg6VuxlTfcwLCMpu7U1JD05LD7ZC8D7LvPoMxdem3KYH3opS9uZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=kNQf1Cdm; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="kNQf1Cdm"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-71d603acc23so37827787b3.1
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097163; x=1759701963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ret643yBLdwaaSh4tmGzwOI/24g2/8vnNlViJp/iQ3o=;
        b=kNQf1CdmhpxDvKBYtYyZzPyoEPa3b5DBjm7HPlxSFDLLl4ciEfM6rtqhyrlh9AUVlm
         RZk/qYDSUHVFFfKjaW0h3bFYh9KiFWziWojoo9mfLb0nzBqyrMD8Mm2nfBaC0Di/68lQ
         l0oxt9c4Md7QizadpO2xKRzZFqvl9sC+RvbSA6Ns9bCYR8T9JeCW0lxfZJTstULxGSfA
         1OX9r15sVix/lij8ikdTTi42rxyCw00Z+ilTi9zyqfZNUIMEhrBvnqU6VIVe7ozl0keL
         dgEPDb3pfzP3pOi0oWZJcOZ2nuyw+LyjnxeNjzZwx9xKA4IrKVG8w/wGRbcDQasOSkaL
         7pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097163; x=1759701963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ret643yBLdwaaSh4tmGzwOI/24g2/8vnNlViJp/iQ3o=;
        b=ORb47pjAiFTHL3yOH7lq1p0SK7IfJdQxmkvdLdazZkE/vo61FnO0yyq1pjlBrN5wDS
         nCLqq0/JxmDr4IrRqVvsS6skcHePWSjA7nqkZLNV+1Az699D6kV1e0tQOEf1FedkXzaf
         GIBzPjfbVTIPC4RR41IgvIrSUNUPq8Pc0vQfePizc0FhaexL5R+1Z5zBxENXyUlc2Jnh
         mWJBh2EhUtbNhCssmjqhNs4rJ64G1syNNcxAMRrRcf2gXy0AntRXYPi4hIyM5ojYh4m5
         63jdOsG3rbJGhXFdsRnvyOKM/Jq2AF7hywE/ySYMGgWl0ocztYfrG5gyWZszTbir8toJ
         +Smg==
X-Forwarded-Encrypted: i=1; AJvYcCVf2QaKDydJJoCo1Wux6XXf8BwP3/MxfvrAv5n52PZDxnqTpAlkTw5O11vTcwC/Di2mJDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjmvgC5ace3gtmCvkhZaayZl1DxfIUG4LhXkNC0Rhgf5Angge
	Mp1xTttWL3cjOXeUNG3Ip4pnoXZILdcM06F20zMMu9LclXD5I9byQWv5URM4CaK6eWs=
X-Gm-Gg: ASbGncuz4NEhX++j6betTR3XIhvdvRbP4VIxVNmomKs9g1QTVSm+Sy+paM6SMVSH9yv
	sn7znfLZFEOrgakYNPUMzOGiyWTE2qJDtT1q4fvYgpm2lbU7VSh2fiAG/kxuKJAb0nxcX7AMdSW
	s3qk/H2XxJJV1DsbIihW7NTxH1sxwQcGmO6JBvGEah3T4MxXnxf4lm+cuXRNyqg857g1AuDc5Tm
	2wfMcfU5rNJoxPb2MK1jcBCWpYHQRHbNry5WMdlch/03UND0BWHX18DNcm1PohqXXQmXj34Fk2q
	lhWsk64s7TFYcHlK2PMH9dsUAK1ZYawxulLEGu7eOoZ9nWkCKBirMv6F6z01djcOm/bdclORYJv
	fgy/LcyHVTN7+4HuauK3WF4MyzjuxlKlaA8ukWW3gaL6SR2pn6p1PvsKDPQ4Y/cpENs88FV1biI
	nc2fwGh9COLsEOjCp6+mmcVzH6KN02fn4uUHAj
X-Google-Smtp-Source: AGHT+IHbs5vaLEL1eI6TXfazJn3ZMjnCaBy9MVlvG7b7CT8cY3HjdF+wYNTKzO27RgvF7Sd50vP2tQ==
X-Received: by 2002:a05:690c:4444:b0:746:85b9:14d7 with SMTP id 00721157ae682-764034235c5mr169153697b3.37.1759097163265;
        Sun, 28 Sep 2025 15:06:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-76b726bdd46sm17804717b3.22.2025.09.28.15.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:06:02 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:05:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v6 00/15] packfile: carve out a new packfile store
Message-ID: <aNmxQqV3+1Ad12qC@nand.local>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
 <20250923-b4-pks-packfiles-store-v6-0-b48f2a882759@pks.im>
 <xmqqwm5mh5vw.fsf@gitster.g>
 <aNYj9oijx4dhJBOk@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNYj9oijx4dhJBOk@pks.im>

On Fri, Sep 26, 2025 at 07:26:14AM +0200, Patrick Steinhardt wrote:
> On Thu, Sep 25, 2025 at 09:08:19AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> > > information about a object database's packfiles is currently distributed
> > > across two different structures:
> > >
> > >   - `struct packed_git` contains the `next` pointer as well as the
> > >     `mru_head`, both of which serve to store the list of packfiles.
> > >
> > >   - `struct object_database` contains several fields that relate to the
> > >     packfiles.
> > > ...
> > > Changes in v6:
> > >   - Fix a grammar issue in a commit message.
> > >   - Update a comment to reflect that we access `struct packfile_store`
> > >     in "midx.c" directly, as well.
> > >   - Link to v5: https://lore.kernel.org/r/20250915-b4-pks-packfiles-store-v5-0-d6340350934f@pks.im
> >
> > It seems that we are basically done with the topic and strayed into
> > nitpicking territory?   Shall we declare victory and mark the topic
> > for 'next'?
>
> >From my point of view it should be ready to go, yeah. Thanks!

Yeah, this version looks good to me. I apologize for the delay in
reading v5, but looking at the range-diffs between v4 and v6, the result
looks good to me.

  Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
