Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013217E
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741845774; cv=none; b=AvmBM/DBx3mxO4vZ5COXIb23JzTFhs8nYqyYSyO3DWOjZG3XYP9Y1E6Lbg03scbDon/6ClMoZrxOVWzfrNs4Y32XPjzLRHZC5F3YVeKvtkIBsto2+kt+eu7q7THWauMjLjU1rU0KW/HApg+M3QTxM7+edTq/lqU88NEdlshvitY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741845774; c=relaxed/simple;
	bh=lg9K2A/qyzZkKTcjivIBMMqIqJegh3d3DXmDTTlfvQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbv6e58kCh4uVVVM6S+lHGw61kmS1phJHUegxA1VQiNOwj7I6Yq1P7G2x11Sw+JD59V+RXA8TX+POUuAaVNBbdcaLySUxFMTlA740hIBsFHnzlRJ1kNfBtgfsLrQmmW6TTMQWe+NtYHNypgaWmwcS9KfSrUCJK+hdL5y7apQgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ixyj2gEN; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ixyj2gEN"
Received: (qmail 21130 invoked by uid 109); 13 Mar 2025 06:02:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lg9K2A/qyzZkKTcjivIBMMqIqJegh3d3DXmDTTlfvQg=; b=Ixyj2gENNK9axxI/g4qz8mfgszzYMdvn5ATFFUMc3DOggeOlnqi742D3fkfKR662/U0clMS0co8WmpYdlSFtTEdn5mVUaZHj6DP4VPrGrgLlQCSFE+BHwEi+xdI07w6d6YtL8A/dtohAGyFEFmcZg+sLw/OP4ByZdCVaKMOJymSI61RUsuIlqTiZq/OPm3kJpv4EcZHj5rj27UkujVbGkxQKdmw7GR+uiiUIOMPzQPQeKrBioZwjOhRxwnMRiH8SOC9LpkAYf189DkmAY44MQwfAkp0MOspbv8uGWrrm1TaFFVjV7jKZF47qrVap/PldbnNF0mMFEUAsmkWSd2P0gA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Mar 2025 06:02:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11939 invoked by uid 111); 13 Mar 2025 06:02:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Mar 2025 02:02:50 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Mar 2025 02:02:50 -0400
From: Jeff King <peff@peff.net>
To: Peijian Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com,
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com,
	jltobler@gmail.com
Subject: Re: [PATCH v11 8/8] cat-file: add remote-object-info to batch-command
Message-ID: <20250313060250.GH94015@coredump.intra.peff.net>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250221190451.12536-1-eric.peijian@gmail.com>
 <20250221190451.12536-9-eric.peijian@gmail.com>
 <20250224234720.GC729825@coredump.intra.peff.net>
 <CAN2LT1CsjA7V_y-OqDNREkpERHEBcx627JhCrzg9GHfWS=b0NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN2LT1CsjA7V_y-OqDNREkpERHEBcx627JhCrzg9GHfWS=b0NA@mail.gmail.com>

On Tue, Mar 11, 2025 at 10:19:55PM -0400, Peijian Ju wrote:

> > BTW, this strstr() isn't quite sufficient to prevent problems, as it
> > would not find placeholders which _do_ exist but which aren't handled.
> > One of the first things I tried was:
> >
> >   git cat-file --batch-command='%(objecttype) %(objectsize)'
> >
> > and feeding it "remote-object-info /path/to/repo some-oid". And it
> > segfaulted.
> >
> > -Peff
> 
> Thank you, Peff. Yes, you are right. It is a bug. I am adding a new
> logic in v12:
> 1. Iterating on the `opt->format` to see if there are any unsupported
> placeholders. If there is,  error with unspported placeholders.
> 2. Adding more test cases to cover different formats, e.g., just
> `%(objectsize)`, just `%(objectname)`, mixed usage of supported and
> unsupported placeholders.

Yes, though it would be nice for step 1 to avoid re-parsing the string.
I think you could either:

  1. After the mark_query pass in batch_objects(), check for unsupported
     pointers in expand_data. The downside here is that you'd have to
     match each one that you _don't_ allow (so if somebody adds a new
     one and forgets to update your list, it wouldn't be caught).

  2. In expand_atom() or expand_format(), check an allow-list using
     is_atom(), when remote-mode is in use. The downside here is that I
     think we'd eventually want to move that parsing and formatting to
     the shared ref-filter API. But maybe that API could provide some
     kind of "check that this atom is allowed" function pointer.

I do wonder if there might be a way to also just notice that we don't
have the requested information and handle it gracefully. I didn't
reproduce it again just now, but I'd guess the segfault is due to
feeding garbage to type_name() in expand_atom().

So maybe if we initialized expand_data fully (so that data->type is
always OBJ_BAD or something) and then checked for a NULL return from
type_name(), we could do something sensible in expand_atom(), like
insert a blank string or similar. And then it is not an error to ask for
%(objecttype), but you will just not get useful data for those entries.
From the description of the protocol, it sounds like you could actually
intermix remote and local object requests?

-Peff
