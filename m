Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96F63112BA
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 05:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774417573; cv=none; b=GqWdBNWeXhDOHvk7zqJOqRy/LREaK42icb/VIf/sA0icmVIAGghsmnCOU0tt4NsOp4uRVuEaYmcy7VQOGaHb4o7ZnIO3OModAhW05iIQgqTHniqJVuIQ+FdT5ed0VgFKr3DP6HE22H+5vYuXEnDTbfuEq9kxPb2RVEjvhV70HrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774417573; c=relaxed/simple;
	bh=v62ydE+DyvNYRr233VDWLWC9iMuoO3eI0riRDiBrjYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcsnK1j4mQjQC8ufPQS3RwO7tUfW0Aqp388k+Z2VbKjGgbUxSHYjcSUmiY74xuKw2ZDpKm9bjAox0v4RGzauFibtnqKNrIfAf8O15BZ+ReuigGR6odhCYY0Xudw1aGsIBl8bpZlZRE6FrEXjThrEjrCULE3byf6s/6x1q9+mpIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JtIwNqQI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JtIwNqQI"
Received: (qmail 135215 invoked by uid 106); 25 Mar 2026 05:46:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=v62ydE+DyvNYRr233VDWLWC9iMuoO3eI0riRDiBrjYk=; b=JtIwNqQIH7k1UK28d8+3Sgg5hM9zQp7u5pcvQuW+MCVV6dGXCWw/Rqa2NE33wqFb5QCEQMoPOrlSDG37b1NggpGVeObZPSiuwZg9jE/tBY75ZFgYsHZWLeHIeT1WhY8Ph8E9cX9CPGfC8teLnepVJwahiQREJW35xHM0AVxxJ5roT/q/06CN0fTCwRiMenwUKVSSDdMRjMar0+VeiGewwJw4eLa3yGqf9OP420pYkC5SkghUPfLhsJQ/BAmlPMaNkVFSJVhvmVyjQaMOcLifCULiGW/ikI/RG2C/p6aiOLu27iq08chkCKmq05z621fVkJ3KpAd0FajDSB+S5h9nGQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Mar 2026 05:46:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 181375 invoked by uid 111); 25 Mar 2026 05:46:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Mar 2026 01:46:02 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 25 Mar 2026 01:46:01 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] test-lib: catch misspelt 'test_expect_successo'
Message-ID: <20260325054601.GA3701549@coredump.intra.peff.net>
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
 <acKqvI0EhaORjoD7@exploit>
 <xmqq5x6l2q5y.fsf@gitster.g>
 <acKx6yBi-BWUVJcv@exploit>
 <xmqqo6kd18sr.fsf@gitster.g>
 <xmqqcy0t178a.fsf_-_@gitster.g>
 <xmqqmrzxyu2h.fsf_-_@gitster.g>
 <20260324193514.GA1870130@coredump.intra.peff.net>
 <xmqqy0jhxb3r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0jhxb3r.fsf@gitster.g>

On Tue, Mar 24, 2026 at 12:48:24PM -0700, Junio C Hamano wrote:

> > Using "-e" makes me very nervous, given all of its quirks. Granted, most
> > of them are related to it _not_ kicking in when you'd want it to, but I
> > worry it will create false positive/negative headaches.
> 
> After looking at a few scripts, I am not suffering from such
> headaches yet; it does not look too bad.  I'll stop this effort for
> now, but with a handful of patches I already sent, more than 80-90%
> of the entire test scripts that I run are now "set -e" clean, I
> think.  Note that I do not run svn, cvs, or p4 tests ;-)

Clean in the sense that you don't _notice_ any problems. But there may
be lurking ones. For example, given this:

  set -e
  foo() {
	false
	echo foo
  }

what would you expect the output to be for:

  echo before &&
  foo &&
  echo after

versus:

  echo before &&
  foo

Whether that "false" triggers "-e" depends on where in the &&-chain the
call to the containing function is. So things that are not problems now
may suddenly become ones when far-away code is changed.

Maybe it's enough that people would notice and debug them when they
happen (if "set -e" is in test-lib.sh), and they wouldn't come up all
that much. I dunno. I just have been bitten enough by "-e" quirks that
I'm wary.

-Peff
