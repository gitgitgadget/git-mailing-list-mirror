Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD53630BB
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367322; cv=none; b=cVRbx0in8mRLdkkrTkoqkyaE/oC0QybAOYY15wGdFGBQVxn5UCfsbHegdKkBEu/BJHMGmpg2U1ssjq9LuGmber/dcVEalUUeSI+uPZTwV+Gjj/Ab3QdGVnrHbDWZlfPcDQqpiptnso/IHa0OSvG9vyGkEMvTxfi7Q/5hznRwMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367322; c=relaxed/simple;
	bh=AkxHQ2Zah6sQnJ5hl3leHpmYa+/AaqJhT18pW3EUWBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHCbkTNwDxxMCBIceKUJ8+u+Jm0F2u3AT9u+s0ywk9+okrWggQ1+pKwQD3QiKQ8WjvZGpFe5Eyq/vCRERl26EuAC68BkFbdGCxl1Z9s5yHADaiamdGomIEwzeIeeP+fmx+dvYNDwGUZV9uR1VlH0D4MFAglaH90Km3TDZGUXrJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=VYcQ0zG0; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="VYcQ0zG0"
Date: Tue, 24 Mar 2026 16:48:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1774367316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AkxHQ2Zah6sQnJ5hl3leHpmYa+/AaqJhT18pW3EUWBg=;
	b=VYcQ0zG0yPxcqGUswXYN3gNSN7VvoTM2Rn2f/+IOZAKD1uL1QnRPpeJ+IWJTLlq+l58+8i
	mXG4+LVaLRj+SPbL6IwKDmiB8TOhuhjfriJIL0SP95ZphrUWTma5LxdSgWusNzl2uF0bIO
	AO18Vm1d7+mV12RI5PV3OSseotxeuqbycL3tQvAizS7RMkE6A5SJbqsXytZJqDkLm1awGw
	CQ4+DlRJn+NOHfUKxj/bVfgSs+MBC2EUIlyKtfxEkN1yXzm2TWElU5XnMWKHTrMlJOdlCz
	mabUMezkiXm5QvbAuV+DRZ+mA2JxnSEPt8i1/mN+Uwk6NXFi2TwNJcqwHfkSPQ==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] t4014: fix call to `test_expect_success ()`
Message-ID: <acKx6yBi-BWUVJcv@exploit>
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
 <acKqvI0EhaORjoD7@exploit>
 <xmqq5x6l2q5y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5x6l2q5y.fsf@gitster.g>
X-Spamd-Bar: --

On Tue, Mar 24, 2026 at 08:38:49AM -0700, Junio C Hamano wrote:
> Could either of you remind us why "make test" did not catch this?

My bad. At the time when I ran it I simply saw no failing tests and
assumed everything worked fine. Next time I'll check that the actual
name of the test is present in the output.
