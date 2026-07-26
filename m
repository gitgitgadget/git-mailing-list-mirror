Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A670371867
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785096158; cv=none; b=WZl1UveTumgd55IMolKTmq0/86IBJiSxf35T5Q1zg7eK88O3Enp9eY+9T+7Q2+kL6Y9Or6eE0O+8JIcnwCShVixabyW7z0Er3V1mkQQKKTa0k50nKQMFEGip84flUDMfMf9Z8hikiYcjziMvUjfC4zDVdhxy05ZveopcZ2VuDPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785096158; c=relaxed/simple;
	bh=UmNSSrmFtoiDZpdVH6bkWLgL3f3p7F22sQwqg1gIPXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bexzX8EZuO6jszHRXlycUvg5L4IGK0niKODyddryPpXO+bUheQdzSe2t+cud4JrphlxH15iuuhfOI7bEXVTT4MvioQo9518JZd6wrbwHSvfUDl722Sx1mUR79j/Tt/UYn5IHWf9dx+A3kPtw0NEvGgeQlPeFQ851yXlumkVSW3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gatskyOM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDDTH5e6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gatskyOM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDDTH5e6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ACD3914004A3;
	Sun, 26 Jul 2026 16:02:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 26 Jul 2026 16:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785096154; x=1785182554; bh=JyB25d4l5j
	UqrGvGJxGHT2Aff81rcD4UdJotZyIgOnQ=; b=gatskyOMlynYFizAbNrJGF7Q1S
	6xSRMhu9j76klWIe/cc0AY3hQ8FRnRALU3HxAZX/ZfWkw0rdQor+10WdzoHZtuow
	Os0YtV7L0W6PGd+11mS83683dTUDsvfSDWourUfm5uR4QG6o9Wz4pa5JmdrwZ+mq
	C6Fnuy8c82qrWxw5EWPkGSsbT2BO/3klMktpIG4LBt+ZYeleQSC5qYsbRKhD+HfU
	+u93NU1sZWEEEOpHrK1YUpnR5HF3Iv/oMc5ryazYQ3lZIMD1wQgbduD0EuCF2uiL
	UZ56CuWWubDDEnmEpDs1FmifigMWG1xSkUtIuh+HGFp6nsLsthD1unkGSmxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785096154; x=1785182554; bh=JyB25d4l5jUqrGvGJxGHT2Aff81rcD4UdJo
	tZyIgOnQ=; b=XDDTH5e6kRC1xDdM8SI8HMcDPeiTJ9eWCQkQacU/ZCuQc+sCMcR
	Bhy5DXr4oI/uan8Fe+73vhShu6o3ES7lU+Z9PnSTVmda2g3Mbvuvy9Nfb1ocs5yq
	E5e25lPhWDsGP+YA5jttZojyDqf2Ez1NBHObUwDyrE4ZBZKE4qEt59jloezQpaMh
	lJXEPG86oF/0fm06HZEOZtJWOQSy7btxvjv/uHNorsACeAI8Vm5Xh8LInJFyHn8d
	8VuS4TjUgtyy2lhxvoH8wDnSTWB0Dedwsx0tzH+nmK3BBXgFJfY/oOE4LvJq7AVO
	59Czx8DCaoGewXNSg2dGOKDBWn82Pa6Gf+A==
X-ME-Sender: <xms:2mdmaiBLXXXdkpR-bP4mt7ZM1Z3s1JxNa3K8WhkIi9LyM1GHLKj0eg>
    <xme:2mdmaj-0iX2ZOwk0R96V-ih66jzm7wB3tNdz2bfzub2aUnEfdqWmEcB6643KSdvUJ
    hOBJmSsebTEGZJT-CZLAr4Z0BdLrtOKUJGhw6DOUwYbxcc2kSg>
X-ME-Received: <xmr:2mdmai9hJCxLV7wqMIv4d8zaXVA0fIJknbCUWu3Fyv2sGgBWYtO_wFO7k0lbLhfcF6VprOWh0VCIWs-Y2zhHG0PiUytimYLthg>
X-ME-Proxy-Cause: dmFkZTELJtrYKMc0M9YCo64EdViszthDo2xpW2keVRllPsZHmktbC/Ty9YUBdPLifUXnKp
    CLmPAmb25vY8g6NmaYovEp+58A3PDm9CbySOEa00W/FFYFcMSW2HR0VsNXzVIUtV5T0JiX
    /vUTZI1j1qGIPe6Je1FETtkuir255YJZ4nGtQRDSYTLONdQ3/PKCKlHUuBZ3JY6/LXJjCQ
    JslHt4BghzD/ILwYD7cgDAmEowKp0f867OZIrPtrjUWEe7fcvBivMQd08/qwYSmn11Sqwk
    +H94G3a+Mi56hatHfpZCpiWmUaW0Y14HZ3JvgKGW6CWfavk9rd52rbsyL0xScpZh36xMSz
    Se453sXkEdozhbVFrbMaGg47F7yoHPYKjK6SocnJ4Hc4FeoutO99SDNLIawBWdt54xwuZX
    e/WwemZSyTB3YwdTkYkc75NuOkE4nozjQH3XApc9WY4kr3lqwBdnNLbilJySzOP+VVT3aJ
    MJAJPYdHn24JUm8947YJ7QxPm2xdwvlRpEx3h/Qdj0oyOH21Vip1txnQNa1CEX772L1zov
    aLCWz2yjcB4Kw8bTtlBF5lqRVBQD13LpCwVBH1zWG0wNJ+gZpAxZHO/tNY/DDvU0jPcuNU
    J6cFcQi32COAvcmWA7aI4fK3RbcZZ4Rt2vWOYIvKGrormDa3IPxFak8Z48Yw
X-ME-Proxy: <xmx:2mdmaqce7LzV68uy4p-35Z_oUHbVPolBn6j1x7WFD7WbDN7VCwkEGA>
    <xmx:2mdmarGSaBL-hWG9PjKb489mICh_y_1QulaFN6lGyLe0bNNz2stxWw>
    <xmx:2mdmaof8Do55yON4IOgtsTNoZl7mv-z3C2VDUiXq4vk04zMuMePKYw>
    <xmx:2mdmalHZiT-XvoZgBA5sMEVsu0-x6nE9kelQ4Ym_wj1Llajp99nOeg>
    <xmx:2mdmausY7fXI_OJo2dIInfnRnALqBeAVouj51hVQ_ZIFVkYys0Nw9XRx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 16:02:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] diff-lib relative-path cleanups
In-Reply-To: <20260726084550.GC2366012@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 26 Jul 2026 04:45:50 -0400")
References: <20260715060523.GA517940@coredump.intra.peff.net>
	<xmqqjyqwp9jh.fsf@gitster.g>
	<20260726084550.GC2366012@coredump.intra.peff.net>
Date: Sun, 26 Jul 2026 13:02:32 -0700
Message-ID: <xmqqjyqhv7s7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Wed, Jul 15, 2026 at 08:17:06AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > A diff using --relative ignores entries outside the current directory.
>> > This results in a segfault when we try to process an unmerged entry
>> > that's outside of our prefix, since we end up with a NULL diff_filepair
>> > and use it without checking that it's valid.
>> > ...
>> > +cc Junio, as you may have some wisdom on that further exploration.
>> 
>> Will take a look at the history myself, but I would probably not
>> have much wisdom on a change from 2011.  I often do not even
>> remember what I ate for breakfast yesterday ;-).
>
> I have the same problem. ;)
>
> Looks like you reviewed the patch in question already. Here's what I
> uncovered by digging into the history. I don't think it should have any
> functional difference (and even the "avoid unnecessary work" in patch 2
> is probably not very much work in practice), but it might be worth
> doing.
>
> This would go on top (even though patch 2 makes the original fix here
> unnecessary, I'd rather have both in place).
>
>   [1/2]: diff-lib: drop stale comment about advancing o->pos
>   [2/2]: diff-lib: skip paths outside prefix in oneway_diff()

Both patches look good to me.  Let's combine them with the original
fix into a three-patch series and merge them into 'next'.

Thanks.
