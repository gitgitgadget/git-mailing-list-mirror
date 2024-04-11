Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE4F524C
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 21:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871051; cv=none; b=ggq9fXHzEAtUJWmBc5fYf0UizFVP27NWvuUfMqZKkF1c8nNcGflRDUxFtbwnClyWT/l0fYi2vHcNgjdP0O7zJb6FBcS0G8o4utpUEDC7ijzgZv4BDCk3/NpUoEMOJBABugSb7VfR/vWN1q8Hz36KndV7wDbnXgoHDdNSqn+J/jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871051; c=relaxed/simple;
	bh=I04/qXfbMY7+2OfxVRQjvUnGAC+GXva+R8AXM9MaglY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=du+hO4ZjDCxlot9XoC3P9pPsZd19Lq1egQHQ12vsB7sBRVxLWZLqwWV32Ygh0+Jkro2fLB9x4Ufo1UnoNfOUh5bC0AUi8Br6AuJ1BFgIVD0mZ+kD1NHYhNTf2Qs+9lArxHmusAV6YNy0Qf74UE2cBnQohairDvbuu4u09lrL3W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q/FQg5C+; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q/FQg5C+"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1133A3A577;
	Thu, 11 Apr 2024 17:30:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=I04/qXfbMY7+2OfxVRQjvUnGAC+GXva+R8AXM9
	MaglY=; b=Q/FQg5C+BE2j6kTF3iYlKlJFQwCaYDg27gK3FWwFz5q3qhR4ERSXSm
	K1QANqBI4TEzrB1SEBObn32XiO4Zc4ixPjCmRVftW57BTUU7lX1R/a7JbDLjNFjY
	J+A36QtYq9hVy+pXphDJRoNCzXs1eBk/eSqWhLLKWxt9fPUDoa/0U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0AE123A576;
	Thu, 11 Apr 2024 17:30:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7BF643A575;
	Thu, 11 Apr 2024 17:30:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Kipras Melnikovas'" <kipras@kipras.org>,  <wyattscarpenter@gmail.com>,
  <git@vger.kernel.org>
Subject: Re: Short form of --force-with-lease
In-Reply-To: <01e101da8c45$66d33240$347996c0$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Thu, 11 Apr 2024 15:21:00
	-0400")
References: <CADwVmK293eQ5VFkn-J68tXQ=64u3H79ScMW7H_ukSmtwLwA4wA@mail.gmail.com>
	<20240411173639.81152-2-kipras@kipras.org>
	<01e101da8c45$66d33240$347996c0$@nexbridge.com>
Date: Thu, 11 Apr 2024 14:30:44 -0700
Message-ID: <xmqq7ch3r3i3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C23EDF14-F84A-11EE-A7A8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

<rsbecker@nexbridge.com> writes:

> If this is mostly about saving typing, you could get a similar effect adding
> an alias. Something like
>
> git config --global alias.pushfl 'push --force-with-lease'

The use of --force-with-lease without specifying which commit you
took lease on is not all that safe [*], so I am not sure how useful
such an alias will be.

Configuring how "--force" behaves and changing it to an unadorned
"--force-with-lease" is to promote a not-so-safe feature as if it is
safe with false sense of safety, which is not something we would
want to do.


[Footnote]

 * This of course highly depends on your workflow and third-party
   companion tools.  If you (or your IDE in the background) fetch
   from the remote after you started working on the commit to be
   force-pushed, it would update the tip of the remote-tracking
   branch, making --force-with-lease base its decision on a wrong
   commit that your work is not based on.
