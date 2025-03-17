Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27EF191F6A
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233946; cv=none; b=ternvouCwU559lFu9njyOeKGSoG8alF1eK9NkdB+O6aTCKpZZSL9t81w/ln8PglQaF9C0F0L8m7fiw5Dc4pJYOAXgoV4Ed/tjV8E2R916jqcyjmzGE2e53W35Dldkqzs4Uy2WR34iHvkXWwgxnoBmoM7l1Zox3yqD4Tq+ub0jm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233946; c=relaxed/simple;
	bh=cyvpZtcS/TqnX6zAMrK5NIird49awAQ7iaruMLHwnX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8yj5KhwA6J63gw3P4ehhAktPF9nsqcEqQpyHAKIDJVMhT7mkHB6aH8U/c8uDT/BZVeZrqdFibJQUtaEmS0eaet1Ls80LzKmMFtumab22YQgosmjnpYnjHK1AyVKSbRKqq0oM/eCQeAxB5mtWGoeoRiTxK2h7w3SxiHoMdstmgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=elI6AJ1+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="elI6AJ1+"
Received: (qmail 21188 invoked by uid 109); 17 Mar 2025 17:52:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cyvpZtcS/TqnX6zAMrK5NIird49awAQ7iaruMLHwnX4=; b=elI6AJ1+ihhCM5DCfwEpFqv/mklyiQRQsjJHn3ymau1xBBAftD70MLrIl32iBwrZ1rQ5GXMNYKQCQiPSgSehKTjspAgQdImQujJN2x06xDqvZuzi9pPSNu4YqSOyySvVw3guimYYTiu+UraImu2nyQ2nYUrA0JEtEXbQekZbiX7p+2HwqNZUmVFjzclOiQiVRwUjtay/eCzKSfrMOfi7LMUFZQGwxQzxvf2i35eGF4wxD2ogFW9zvIuDCdoeGu/Ro58clTdvbX+2m2qlJuMTqDjS1nxyfj8J+HaJ21m9gAXqTzjD0zZlPga+AOnVWm6mGuNMbdKfwuV4/AYo/eRpUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Mar 2025 17:52:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27958 invoked by uid 111); 17 Mar 2025 17:52:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 13:52:23 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 13:52:23 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2] diffcore-rename: fix BUG when break detection and
 --follow used together
Message-ID: <20250317175223.GC704253@coredump.intra.peff.net>
References: <pull.1876.git.1741395615315.gitgitgadget@gmail.com>
 <pull.1876.v2.git.1742000894041.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1876.v2.git.1742000894041.gitgitgadget@gmail.com>

On Sat, Mar 15, 2025 at 01:08:13AM +0000, Elijah Newren via GitGitGadget wrote:

>     Changes since v1:
>     
>      * Added a testcase, and extended the commit message slightly

I already left a bigger response in the thread on v1, but I wanted to
add here that this version looks great to me. Thanks!

-Peff
