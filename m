Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48072EB5C4
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119425; cv=none; b=iBeTWnkXenQpFNdOp86C8YT21OyF4kX60SmLAa+zgLhC9NgSta99OnfBb4mKApW6qqwa0ngv07JRjVrqzAaPhmqqm0szKnfyFcQVfx7DYxQY5TO0RrXcKYeezwItQegh9YhNYdmDDEYIu51XNeoLabVBsXzSP672n1vG+Tth6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119425; c=relaxed/simple;
	bh=4dQI173DCVWUIcx4xyserPhSqqSO1jOGmlaODG7I9uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+LiCaVrx9SlZq5Rnk96A6Efv0BWGTfKetmKRUZhRw2ux98MBL0NrIw0s+dZC2+louiDdC7DLK2Y+4vCFFYws8af3TiXU++yOVlTVxbbhrH2kzsidqTWfFt58DEjPKko55QYmH+JfdzvuCo5pntpse04lb+lKEM/HxXy88q9fGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilbE25tT; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilbE25tT"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61bf9ef4cc0so4524595eaf.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 07:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758119423; x=1758724223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZmF603WBcft1kvmgdi8cWB07f68iinYmvj2J72RFFA=;
        b=ilbE25tTrkmiCz18xX+G3s7Ac4tuXec/WxSI85tMuKv4xcsjwMCbA7J2j2AuscQwtQ
         gQrd5xMm5hnrf5vXIZO5aX9hlE1bJXE7TU+CRzSL+MQVH0ca7vhR2CIrpx8lTlREhW+2
         G6xpTQHaOG/zL3rLTvfQvIEtkHbCbPngxuXQABBqpMpev+EomqL4Xx7ElfmrupPgCjUj
         6kkWSlapPmo13En1rmF0u3Fq8rBA25MAVC2R3OdmP3Vqo4oLapIyyd1ra4E4otIgrfnX
         XSG5KIS01XMg1o6huIL5P8ndbINw6mXwqQqeO5rBokKJbRZTpu4CGKki9fE8SLv67TER
         HETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119423; x=1758724223;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZmF603WBcft1kvmgdi8cWB07f68iinYmvj2J72RFFA=;
        b=n+EDidB4T70Tm4qX0vqOnO0ZAeNvaW/j4fWFXbC3J1EHPdKRAvpgxBcFOXFf1ppJ3d
         Q25xdirjC7eDu0J4T8/kfvUC3KCxgEkpMuCAA4rJfFwksPBztTNiwKMsrt+UUYR/97p0
         cnqGdjYP+u+/eSycdNfREiaaKv1HCP6bn5N0k8Gn231sGYHhZ9skVCg/4VeTO0rfQBA/
         QyZ2+Cw70IrWaCZWjEgoc/oMcocjtGCt/UGok5rWYsJX7DQDvC7ZfQa8wrIY8fEuH8qQ
         log7NFSo4NlO0zO23NucxeSeZtRtb6OwZvTVLndA/TBhI2XZoGCDXl7iWj1Ilfsa9hZs
         o/nQ==
X-Gm-Message-State: AOJu0Yzn7FUkY5rPEk8ZSZ0BwYjEdpFUd5XxorV+89UqickVfM+f+o7r
	ba7VpNFUUVdHmNvEuemOMhOK9OXKOmhWgj0LUjRQxy+W4eJ/yvzfLIwk/pg6KA==
X-Gm-Gg: ASbGncvFYbdRqe6X+ceyOAaUoM+XvHn5mJmBsGEWZE/lfOgnid1QxTlb+kXm2oJrrPY
	CJQRNVriAI1oTyABBIVF5T3ozxS2SM7EgNeS0MJSRS1ecJ1G/qKkMF2mD+AE/B9z6+Rs0L9E84R
	nSOoCls4wEb+zCJA/ddDdlBSCRFaF5Lz01MgYZygyJicz/2VzmDnNb3JGTJ7MJDTLiqqjBHzCyK
	11RNuXhXDPEv6Jdl3t2Gas6INDo9rpYzOAdo2ixbXP7nY3WzinRKAGgnOGvLEbmU5Pxrn9Vtwim
	7nNWcn0cK1Nx2mD1G2YHuO5anjf6MdAu2rnHh2oyoiKzwiuSyXmUIs73f8qRSWxtvCXLS7PCtZn
	pU9kTbLAnTKbvK0t0
X-Google-Smtp-Source: AGHT+IFlPXea9dw5MLUyD1GbSOfO7BvVX9rW7M6pH4Yo31iPXb8KujXaNKL8kDlnfwySksKumst4yg==
X-Received: by 2002:a05:6820:1607:b0:621:b76e:66b9 with SMTP id 006d021491bc7-624a5698d34mr1267500eaf.3.1758119422716;
        Wed, 17 Sep 2025 07:30:22 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-621b7bf6142sm2432258eaf.9.2025.09.17.07.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:30:22 -0700 (PDT)
Date: Wed, 17 Sep 2025 09:30:21 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] bundle-uri: do not abort on invalid packet line
Message-ID: <6q43ph3zhkbdrumr3zmamv3stknuteik56uds2523dih26hrgs@7de2agm7as3a>
References: <20250912-b4-toon-bundle-uri-no-uri-v1-0-f4525a406df8@iotcl.com>
 <20250912-b4-toon-bundle-uri-no-uri-v1-2-f4525a406df8@iotcl.com>
 <yqyn5w6oq47lhrcbuziip5tajzrpylirswr5kyfyu35n3k7vgj@jn4rc7cwqwow>
 <878qido4is.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qido4is.fsf@iotcl.com>

On 25/09/17 10:40AM, Toon Claes wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > If the server is misconfigured, I wonder if it should
> > instead handle this issue by not sending the invalid bundle-uri in the
> > first place and printing a warning message on the server-side. From
> > client perspective, if it's a server-side issue there may not be much
> > they can do about the error and it could cause some confusion.
> 
> I can include a server-side fix in this series as well, but that doesn't
> hold back there might be servers out there in the field that don't have
> that fix and still serve invalid data. I think ideally we should fix it
> on both sides.

From my perspective, a server-side fix is the most important as it
addresses the root of the problem. That is, a remote Git server with
misconfigured bundle-uri is communicating with a client in an invalid
manner.

We could address this by updating the client to simply ignore the
miscommunicating server. I'm hesitant though because this feels like a
slightly different class of issue here being that, from my
understanding, the server is not correctly negotiating the capability
with the client. Maybe it is fine though for clients to ignore errors in
this process?

I think I would be more inclined to agree with a client-side fix if the
issue was more pronounced in practice. From my understanding, for this
to occur:

  1. A remote Git server must be advertising bundle-uri.
  2. The bundle-uri must be misconfigured on the server-side.
  3. The client must request the bundle-uri from the server via
  transfer.bundleURI.

A user can workaround this problem simply by disabling bundle-uri.
I suspect there are not many users in this situation though.

> >> Signed-off-by: Toon Claes <toon@iotcl.com>
> >> ---
> >>  connect.c                   |  4 ++--
> >>  t/t5558-clone-bundle-uri.sh | 25 +++++++++++++++++++++++++
> >>  2 files changed, 27 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/connect.c b/connect.c
> >> index 8352b71faf..d2e2bd8cce 100644
> >> --- a/connect.c
> >> +++ b/connect.c
> >> @@ -536,8 +536,8 @@ int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
> >>  		if (!bundle_uri_parse_line(bundles, line))
> >>  			continue;
> >>  
> >> -		return error(_("error on bundle-uri response line %d: %s"),
> >> -			     line_nr, line);
> >> +		warning(_("ignore invalid bundle-uri response line %d: %s"),
> >> +			    line_nr, line);
> >
> > If I'm understanding correctly, an error here indicates some sort of
> > issue between the client and remote Git server while figuring out the
> > bundle-uri capability.
> 
> 
> > I think it is reasonable for the client to always
> > expect the server to communicate in a way it understands and IMO should
> > probably be handled by fixing the server-side instead.
> 
> Ideally yes, but broken servers exist now. Having clients deal with it
> properly is anyway advised in my opinion.

Another benefit of addressing this on the server-side is that it should
transparently fix the issue for clients. I would like to think server
providers using the bundle-uri feature would be more inclined than
clients to update quickly and address the problem. Regardless, I still
think the issue is niche enough not to be a huge problem for clients.

IMO, I think a server-side fix should come first. If this step isn't
enough, then it may make sense to also address it on the client side.

-Justin
