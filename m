Received: from grace.univie.ac.at (grace.univie.ac.at [131.130.3.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A365E3E5A32
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.130.3.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674843; cv=none; b=ndGRBMzT5d2iO2SpN8gDUBSrh+vpSMy36lVofRMNeBFrmnYLI0252VmiV0s19GfKsr00pog0rbtsn6axaXWidh3GUo9uJmsim058ZY4IMrQ3ul6bqEf9AgVpgVlLftca6H6XtZW/WnbrFulKBq87AhnXPPK/23vKmaQH9CQ/HSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674843; c=relaxed/simple;
	bh=DSLJdtywJ/uzdfXoSkO/HDpwjKWWltSRVWiF834BXuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7mJBVXLlQk1Z/Z085FnAw9+3IE27Be7Dy41Jo/Tst3VE2a8qRPZL53CPDxkeHw/S+eSUfgJLeAxtK56ALYsIT42i3a2rN+80MAi4tZ6ZFBPZBVQLn7ujqMZeQcGvBTMveNuXOXy4w5sOgYjW3ja4chGpXeiGo5BgAjol7MQVHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at; spf=pass smtp.mailfrom=univie.ac.at; dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b=Q1KJFU9c; arc=none smtp.client-ip=131.130.3.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=univie.ac.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=univie.ac.at header.i=@univie.ac.at header.b="Q1KJFU9c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=univie.ac.at; s=rev4; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=DSLJdtywJ/uzdfXoSkO/HDpwjKWWltSRVWiF834BXuc=; b=Q1KJFU9c7hCGBv31NLo1qVrDLC
	TSxwik2diLD7828s8avHZeeqMlewzWtsdBVYbcXcPEoTVIg9xzA9NZw9f7KGg3rdsz+DXOKyQWp4/
	JuCPxg4Pvf2ODrq2MHzvYHsPaaINdYShrT6di/r6SHQYkx1rw9xar9zTcYjXGuc7Gab3yEF8Zge7g
	SxG72KaIyVsoAc9DFiFoQdFdVuwtaMTvhYMRTTxMCueoDj/yNKmwIsFaBpQrIVaUtcO+4dXXRYjJD
	tQplbzpHHC5GTjUu6ciSznrEh4mRockGXnpJJ4wNSw6rqenvz3DPJD33gfRqMJv7Hv4tPIpiBEOZc
	o//AiHKA==;
Received: from joan.univie.ac.at ([131.130.3.110] helo=joan.univie.ac.at)
	by grace.univie.ac.at with esmtps (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wVWrr-000000083jp-0ECF;
	Fri, 05 Jun 2026 17:53:55 +0200
Received: from 84-115-215-81.cable.dynamic.surfer.at ([84.115.215.81] helo=four.local)
	by joan.univie.ac.at with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	(Exim 4.99.4)
	(envelope-from <dominik.loidolt@univie.ac.at>)
	id 1wVWrq-00000009dAs-3ogq;
	Fri, 05 Jun 2026 17:53:55 +0200
Date: Fri, 5 Jun 2026 17:53:45 +0200
From: Dominik Loidolt <dominik.loidolt@univie.ac.at>
To: Patrick Steinhardt <ps@pks.im>
Cc: gitster@pobox.com, git@vger.kernel.org, asedeno@mit.edu,
	asedeno@google.com, avarab@gmail.com
Subject: Re: [PATCH v2] compat/posix.h: enable UNUSED warning messages for
 Clang
Message-ID: <aiLxCWp8Bv-KQoLf@four.local>
References: <20260503151210.36036-1-dominik.loidolt@univie.ac.at>
 <20260605094647.94805-1-dominik.loidolt@univie.ac.at>
 <aiKnqlI7WdcskDAs@pks.im>
 <aiK4BR86cuq5bmCe@four.local>
 <aiLNqQgiQPlviB5X@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiLNqQgiQPlviB5X@pks.im>
X-Univie-Virus-Scan: scanned by ClamAV on joan.univie.ac.at

On Fri, Jun 05, 2026 at 03:22:49PM +0200, Patrick Steinhardt wrote:
> I was wondering about that, too. The question that I have is whether
> there's any particular reason why the check was written that way. So in
> the best case we'd do some digging into the history to figure out why
> this looks the way it looks like.

I think the current bit-shift style introduced by 89c855ed3c (git-compat-util.h:
implement a different ARRAY_SIZE macro for for safely deriving the size of
array, 2015-04-30) was inherited from glibc [0].

I found that NetBSD [1] has long used the more explicit comparison form instead
of the bit-shift style, and other BSDs seem to do the same. So there is at
least established precedent for writing the version check that way. :-)

I see no obvious reason to prefer the bit-shift style today.

 Dominik

[0] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=4360eafdd20769fa9d42c075853271debd06f7d1
[1] https://github.com/NetBSD/src/commit/2fffc76da21e012509677f5310464f62797bd1bf
