Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B493A7D9E
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244701; cv=none; b=gVua4wpwCtu4yB+W6W2mZbqJl3iGSYvTNwVQPC8vvU9qDbPasJ9qqKvfHLHZrkAlvQQDJd0UsgDNVZr7EDOdXxFLT2SMvLH1zeWPcd+rVNZLfmpJ6DmN6Dy0mTOR8guuY8AkFAJFFicXmlbxujDDL9mMjyTLJGXSpU7JJB3YCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244701; c=relaxed/simple;
	bh=GHRAmofFcZnK2z0wJylq/q7oME4Cq5CpDg0qCt+hBL4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mRKRy+8Wi2Gne1E86yS3JwNt6K7IzMsYN70eLOFkvppySC2hC5k9OK6L8G1gkcJ72bY/XnqcrK9lHUYyUsbZQSRRzVzg+sWxxlihxvG1YhenBEROnDnxkfPLWu8wq2Y1TcAPQoQLtXwmX35D889m2IXGfW7xQM6Ip2xG8qUrZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=CN5KCTRJ; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="CN5KCTRJ"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 18B3460273;
	Fri, 12 Jun 2026 06:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781244699; bh=GHRAmofFcZnK2z0wJylq/q7oME4Cq5CpDg0qCt+hBL4=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=CN5KCTRJcY0EK655zMGuGaOSyExppQkbI/B6iyRL3Wy4b2ypyn9pjWmjQY0Kywnm5
	 TWDdQAbyzkgZatWIt61tTkQhUXihqELCxzqDD5hQTz00Kjgdv5SJxLoANOmHx2vQ0P
	 B6r3NTGKg+NGhQKETb3w55EtAlwfNjtrqddVR0m0=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 02:11:38 -0400
Message-Id: <DJ6UJPXWOHVB.343AQQB4XEKNM@lfurio.us>
Subject: Re: followRemoteHEAD management question
Cc: <git@vger.kernel.org>
To: "Bence Ferdinandy" <bence@ferdinandy.com>, "Jeff King" <peff@peff.net>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
 <20260608234946.GB358144@coredump.intra.peff.net>
 <DJ5XE9HC5YNY.33U8AG1GX6ZP0@lfurio.us>
 <20260611060123.GA2187173@coredump.intra.peff.net>
 <DJ6IBPYNOTTY.3QKEZQ28P713V@ferdinandy.com>
In-Reply-To: <DJ6IBPYNOTTY.3QKEZQ28P713V@ferdinandy.com>

On Thu Jun 11, 2026 at 4:36 PM EDT, Bence Ferdinandy wrote:
> On Thu Jun 11, 2026 at 08:01, Jeff King <peff@peff.net> wrote:
>>
>> My initial thought is that it might affect clone as well as fetch. But I
>> guess this feature does not kick in for clone, as it has its own logic
>> for handling the remote-tracking HEAD. Though arguably it should be
>> possible to configure it not to create one in the first place.
>
> If memory serves well clone has set the remote/HEAD well before this and
> I think it indeed uses a different mechanism/logic.

I'm a little interested to try to look into the clone case as well, but
I think I'll save it for a later patch series and keep the scope of this
one as it is.

> Bit late to the party, but happy to review/test patches if they come.

Greatly appreciated!
>
> Best,
> Bence

The first version of my patches went out.  You two are Cc'd on the cover
letter, but that didn't propagate to the patches themselves, oops.
