Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C40673503
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430410; cv=none; b=rAtKKhw277HaUM1amXkURBcGkbNVzGNir3iKRnIW+GwzW1oEU9c2pYHmgLa9e6WEUQuHOfPUfAXRDcCsHJHufqmaVdqWeRq5TsDnNSE/sugxDUCxpTJJjjEqK8kw6ZTehl5ccz1yKx4YiUQptmLF0UeXbIO+HQS2/Sx4lQ2bGuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430410; c=relaxed/simple;
	bh=qeMKbVa63AahETW9HlRweHzVJWTeOhFjWXUqNBDlfqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MtpRt1IQW30eKGuOUGKNRiOqPIiGiH/dv6W07qd2gWiqt2oelP5Mw1VkBcr2lzTaDxO/FCEVeewy5D/56AnngMqjmNJSpoxVCQLqCImjd0eCgbt+AJOukfoeJTkfLBqdiMMrxd9euQfDoFrcJPhGklgpIrl4PE5ESxLvoH35L0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uZ8omd+F; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uZ8omd+F"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 189371DE992;
	Thu, 14 Mar 2024 11:33:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qeMKbVa63AahETW9HlRweHzVJWTeOhFjWXUqNB
	DlfqE=; b=uZ8omd+FURVVUjJWdyDFnteW0Y9inbJeJzAXkl72vWHw6HBuHrGqsd
	jqI6biE/q5KH3kXJY47mq4tiH6N5mrbvmvI2eewAXPwohq+lSsj674mpFKUl0m6u
	ie87cgSDeCta6eABbJ48vR8cNLA4Ov7DOQ+TrKAXSzJV5IWCe7BZ4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EEF91DE991;
	Thu, 14 Mar 2024 11:33:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CBA41DE990;
	Thu, 14 Mar 2024 11:33:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  "Eric W. Biederman"
 <ebiederm@gmail.com>
Subject: Re: [PATCH 2/2] doc/gitremote-helpers: match object-format option
 docs to code
In-Reply-To: <ZfIWkJieqcPv5jA8@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 13 Mar 2024 21:11:44 +0000")
References: <20240307084735.GA2072130@coredump.intra.peff.net>
	<20240307085632.GB2072294@coredump.intra.peff.net>
	<Zeo9oAkL6kxZRugN@tapette.crustytoothpaste.net>
	<20240312074513.GA47852@coredump.intra.peff.net>
	<ZfIWkJieqcPv5jA8@tapette.crustytoothpaste.net>
Date: Thu, 14 Mar 2024 08:33:24 -0700
Message-ID: <xmqqv85ozv3v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 33680CCC-E218-11EE-BE4A-25B3960A682E-77302942!pb-smtp2.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> The answer is that I'm not planning on doing the SHA-1/SHA-256 interop
> work except as part of my employment, since I'm kinda out of energy in
> that area and it's a lot of work, and I don't believe that my employer
> is planning to have me do that anytime soon.

It is sad to hear that it is depriotised, even though it is one of
the larger areas with high importance for the longer term.  Thank
you very much for the progress in this area so far..

> Thus, if nobody else is
> planning on doing it in short order, it probably won't be getting done.
>
> I know Eric was working on some of the interop work, so perhaps he can
> speak to whether he's planning on working in this area soonish.

