Received: from beetle.maple.relay.mailchannels.net (beetle.maple.relay.mailchannels.net [23.83.214.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD31E261F
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745364616; cv=pass; b=KW1Zf83tfjopoXL1fQpjWWDE2EkWjABXNjUTE722e7uTiJWAhDBLS5ABfZb5hON6sXIP9QlxLRkkPMn+E7dQVTyYUnIdNnXBXUEpRY67moF6l22U1FzLtpC5EP6YYkcOKdj0JmrSlRMMJWwRilAG/Gfpli/gESCqMuzZRR1Fut8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745364616; c=relaxed/simple;
	bh=zuOYhHJZx8zkMsIvcr89E4xtYsfdOQW5lvUEhg+0Q50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1nL34/PHZCNArkf5oYvlxD4PsBwNcvZX5MtdU9pj+skxSrGgr2AMaI5iNLn0FwkD3X0+nOtHsrpvObaOQHKVlDB7Lc2PlV6SpHg5zveQauoFZE4RBJE31jmUBMhLdixMSDB95VsW9/V06atGUypkoyoIIs9mEvL6ldsnn94NMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com; spf=pass smtp.mailfrom=cryptonector.com; dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b=ZmRpig05; arc=pass smtp.client-ip=23.83.214.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryptonector.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cryptonector.com header.i=@cryptonector.com header.b="ZmRpig05"
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id E2A808A40F6;
	Tue, 22 Apr 2025 22:51:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (trex-9.trex.outbound.svc.cluster.local [100.113.64.21])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7B3BC8A4B5C;
	Tue, 22 Apr 2025 22:51:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1745362285; a=rsa-sha256;
	cv=none;
	b=l/6eyYk8Ig5e8v5MjMYRO4zowTLl59coZlm1+aNA9PHtbYg9W8DJU39efzsDdRB3nhmrQq
	VT8VZaIrPK0sHo+4pYkpfgXocSwZSEgfca1c/uhP5EvDzVRMXr5Hm6AnTdvbHVUn6Ieb5h
	T8zLk8GGC4CwgXrGnkdJUtHQnMrn8hbLjw4gjMSVi8WybxQKANQ6gAf1Zct/CJTN3bKd9P
	tZyPXBe/QYvhbI/I3ThVfPz8D0dbomQ/LAI2G8Y6EGagYTRiVOWO4Nny7bUlF0lbRo43Ut
	LsgmhsCY/nwGCBmlrT8C5FkKHRaTyusl3kReL33383H1uzRW1TZKZ3c9VU9a4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1745362285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mBxnWzlbf+jSNdEdZZIvbAQXyMgQP/zWHv8ABg/czZ4=;
	b=rGZOSwzsF0w8JqEHGQvtdPZDdBV1Ckp75t2rhtoKNhk2Sva+sLJxKqObjGuHR7Lq029lCz
	YKM8Gj9yS8t3lZA3C9L7hSwu9QqlUQ7DrMkDoj1qLONuTHvJIpIF4LH5yL7LUmEFypkfPT
	O7r9KToOJz12QV6FmRY7/4jOX5FjEB+Hejba1ebZ1BEA5U8U2IbFj9C0iftAwmX2SHsw4m
	1mo4a0GnIhRlyy5fqUay1cbwJdHAHSySF60aXXi4/vOr2/ZpRNMRpywi2jGt8Da3t/pode
	N4sTFByeF4d6bRi5SZoiCfZ7LS0XeKQZRjShymU6WEG0eZ+sRsDZ5gRr7QWa4Q==
ARC-Authentication-Results: i=1;
	rspamd-5cfcf5665-98trl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=nico@cryptonector.com
X-Sender-Id: dreamhost|x-authsender|nico@cryptonector.com
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|nico@cryptonector.com
X-MailChannels-Auth-Id: dreamhost
X-Befitting-Lyrical: 3cb0347c6624e819_1745362285769_819239400
X-MC-Loop-Signature: 1745362285768:3881313896
X-MC-Ingress-Time: 1745362285768
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.64.21 (trex/7.0.3);
	Tue, 22 Apr 2025 22:51:25 +0000
Received: from ubby (syn-075-081-095-064.res.spectrum.com [75.81.95.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nico@cryptonector.com)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4ZhyCJ2gNpz6s;
	Tue, 22 Apr 2025 15:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptonector.com;
	s=dreamhost; t=1745362285;
	bh=mBxnWzlbf+jSNdEdZZIvbAQXyMgQP/zWHv8ABg/czZ4=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=ZmRpig05HbmwYcpSsnOB3T1XqmfSXjfa3/FCBMx4oMD9p1dZOcsqteLHwqN3z7HzD
	 CbMK3UqfQYdgF/RaQajMJvECoe95Wo7WQDUocXgs4EyIi7HWvgcINYS2tbojyw707N
	 Dt2/UEtnlzx1WhX9XWTqPY/It7P90J56qYTRy/VxHa5riG4dvxuRaRqKmIRqUIYxCL
	 5g6jLqj4GGWZwLSRzdhdAhKuwvV7Ow+yhUi+fKF8G7F1M97I1I+I19Z2CLCNO5s6qQ
	 /TMRbFTt5ojJTBbTOG6IQgk7DJMxjspH189FPPYXSge5jFswON29JjpGSCY84P6sfq
	 QWSoQMM36RfJw==
Date: Tue, 22 Apr 2025 17:51:22 -0500
From: Nico Williams <nico@cryptonector.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Remo Senekowitsch <remo@buenzli.dev>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Martin von Zweigbergk <martinvonz@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Edwin Kempin <ekempin@google.com>,
	Scott Chacon <scott@gitbutler.com>,
	"philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
Message-ID: <aAgdauFt/mdCY+GZ@ubby>
References: <Z/RFQY433muaCW44@ubby>
 <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby>
 <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev>
 <xmqq8qnr3jji.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qnr3jji.fsf@gitster.g>

On Tue, Apr 22, 2025 at 03:42:25PM -0700, Junio C Hamano wrote:
> "Remo Senekowitsch" <remo@buenzli.dev> writes:
> > Btw. since the thread was started, the implementation in Jujutsu has
> > been completed and I've been pushing commits with the change-id header
> > to various remotes for a while now. It works well. Forges can start
> > taking advantage of it. (I hope I find time to help work on that.)
> 
> It should work well, until somebody finds your random is not random
> enough, right?  Unlike our object name that depends on the contents
> (hence a duplicate unless the cryptographic hash function collides
> means they are truly the same commit), there is no grabally unique

Eh, if the hash function is weak then collisions might not be so rare,
especially when intentional.

In a content addressed storage system hash collisions are (can be) bad,
but typically the hash functions used are good enough that collisions
are tolerable, and one just assumes that if the hash matches then the
data is right, and there is no way to verify that that does not require
trusting the hash function.

> ID assigner involved in your implementation, right?  [...]

Change IDs for this purpose need not be unique, IMO.  If they get
duplicated either you can notice the problem before pushing, or you can
accept the dups and use context to resolve them correctly as needed.

One could make every commit have the same change ID, as a joke or spam,
but presumably most upstreams wouldn't do that.

Using ticket IDs as change IDs implies a globally unique ID assigner,
and should work well enough where things like bugzilla are used.

Nico
-- 
