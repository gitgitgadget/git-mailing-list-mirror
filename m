Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EED210EC
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644819; cv=none; b=HWItO1covLYiAXk+NgxDjtZEeKmPeb+gNpLcN2orQ2Yc6jtSyrnYRUiFDEoGJktbhQ60zCzb43ZxzButRdRtyfV26/N+WImF0Lv7RYte5KIuXip7aT1e1MsWEbX5Awn8Xo/kxxlB3PRcqTjQ1BDXZCOn52wbqCCKeBE1TejAZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644819; c=relaxed/simple;
	bh=JTNqPSQYu31OhIADk9TtOvNlb4wssZXe2pe/bJycxss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JtYRxNsbRlEMaE6QB7TAeo39tpoaofHHTduw6VOLTVlslePjWz6v6aHmDz9vQaB2JZFpZ5tRKDqBk+UKmxhfhO2GVzhwyKa5KDOW62K/kGVYamIefdDej1Kq751DjAKMf3B3/v30M0btXlNfIwi6h/P2zlytWwF+RBTtkP1IoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=beOnAnnv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="beOnAnnv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 579231EB728;
	Thu, 28 Mar 2024 12:53:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JTNqPSQYu31OhIADk9TtOvNlb4wssZXe2pe/bJ
	ycxss=; b=beOnAnnvfz4EZbfaUYWDKDLZSTwapFy+5uC+6o5lG+W7SoTqB9KUb8
	CzWZdDb0p5xk/F0gNa+HilpINk2RdgceMUkLuUw0OXI4YCGZx3wzAttKpf9Ay0VT
	Jr/TG3RqAOWCHjbiZTl5IJK/qG/treKDuYbXP/AFNQASOCZ5WfKJ8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F92C1EB727;
	Thu, 28 Mar 2024 12:53:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B83FD1EB726;
	Thu, 28 Mar 2024 12:53:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Han Young <hanyang.tony@bytedance.com>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/1] quote: quote space
In-Reply-To: <20240328163028.GB1403492@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 28 Mar 2024 12:30:28 -0400")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g>
	<xmqqsf0bz5oj.fsf@gitster.g>
	<20240328103254.GA898963@coredump.intra.peff.net>
	<xmqq34sawcqr.fsf@gitster.g>
	<20240328163028.GB1403492@coredump.intra.peff.net>
Date: Thu, 28 Mar 2024 09:53:35 -0700
Message-ID: <xmqqjzlmuwkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B85C166A-ED23-11EE-8B9A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Thu, Mar 28, 2024 at 09:19:08AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> >> With the following band-aid, we can skip the test and the output
>> >> from "sh t4126-*.sh -i -v -x" might give us a clue that explains how
>> >> such a failure happens.  Unfortunately GitHub CI's win test does not
>> >> give us insight into a test that did not fail, so I did not get
>> >> anything useful from the "ls -l" down there (I already knew that
>> >> sample patches are empty files).
>> >
>> > We package up the failed test output and trash directories for each run.
>> > You can find the one for this case here:
>> >
>> >   https://github.com/git/git/actions/runs/8458842054/artifacts/1364695605
>> 
>> What I meant was that with the band-aid that (1) sets prerequisite
>> so that Windows would not fail and (2) has some diagnostic in the
>> code that sets prerequisite, because the overall test does not fail,
>> we do not package up that diagnostic output.
>
> Right, I meant that we could look at the run without the band-aid (which
> is what the link points to). But I guess maybe you realized already that
> it would not be helpful because of the "reset --hard" that the test
> does.

Actually, looking at the trash directory of the failed test was how
"I already knew that sample patches are empty files", and my hope
was that with the band-aid patch I could gather more information ;-)
