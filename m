Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED651FB5
	for <git@vger.kernel.org>; Sat, 27 Jul 2024 22:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722117701; cv=none; b=otYYYEnfGgZ5MRc7LfZ9laHME58oNMWK+6NBKjGpbV5B9lr+EBeQaJtZdC8d6H57xlqvcVjiqmL5vFF+iLxPK+NHhjRrRipWPNhNgH0S83OaZ2iqaL0Uog7eTrnyp8Yvpf47/3Dyzr7S7IxUa7dQSH1Sm4IFoURHstNT39EsHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722117701; c=relaxed/simple;
	bh=3Hlxq4on0YCC6rNDyrh3kY5mUjdMQCtZs6Tu6vVNo9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmKfoOMOHPN4UFArDK6CaBOd2PzXFcdLCqWak8FHv4D2ksJuYIztZH+1RhlQg3rYJMSjEkSEMEm4MZX4N/DGV9c9pI0gA49s7cfIlS/in6sdApXTZIP5pZJ4kOB0NVKCZ7dVC/k37fbUb4LdscAH/7MXg6G8IhYWhlrtfLhXWPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3937 invoked by uid 109); 27 Jul 2024 22:01:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Jul 2024 22:01:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18030 invoked by uid 111); 27 Jul 2024 22:01:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Jul 2024 18:01:40 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 27 Jul 2024 18:01:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: Bug with bash and OpenSSL usage on Windows
Message-ID: <20240727220137.GB1263246@coredump.intra.peff.net>
References: <CAD+08a87xxVRxO1eiWiam-7xvq=AyKUB-MzqG-r=rM_SYbquBQ@mail.gmail.com>
 <ZqUF0ANz9qX-wWEN@tapette.crustytoothpaste.net>
 <xmqqttgasufx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqttgasufx.fsf@gitster.g>

On Sat, Jul 27, 2024 at 08:53:06AM -0700, Junio C Hamano wrote:

> I've been wondering if we can somehow reduce the occurrence of such
> an issue in the first place.  Elaborating a bit more in the
> "Reporting bugs" section of the documentation landing page is
> probably the 0-th step, and if people agree that it is going in the
> right direction, perhaps we would extend it to include something
> similar to the top of the "git bugreport" template, by futzing with
> the implementation of builtin/bugreport.c:get_bug_template(), and we
> can even encourage customizing it by distribution.

People might also get here from:

  https://git-scm.com/community

That page does mention the Git for Windows tracker, but it could perhaps
be more explicit that "bundled" components are specific to Git for
Windows. I don't really touch that site anymore, but I'm sure a pull
request at:

  https://github.com/git/git-scm.com

would be welcome.

-Peff
