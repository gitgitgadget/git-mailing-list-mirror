Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BNcV96tY"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14772171E
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 13:09:49 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A76D1C8B15;
	Fri,  8 Dec 2023 16:09:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ptZHRc3PHRzLcqA3bpnl71qtnOIYdMl4uqqnXR
	e4X1A=; b=BNcV96tYCBIMd1MGm2xvgZ1N/NCxm8H1seqOTj4OSN/9KNOg2XN/RX
	IX46wVgXfE6OnMsgQhMjT9DboPFIheZ1WGqbIFVk1Tah2BXGpKmq48FCdMdB5Zqd
	MfrFf2nAW9xigCPbD04qzjDGW9TljaLJ5Ls71Ow26YnIxJ5hKPhnU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FA2C1C8B14;
	Fri,  8 Dec 2023 16:09:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1DA11C8B13;
	Fri,  8 Dec 2023 16:09:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Vito Caputo <vcaputo@pengaru.com>,  git@vger.kernel.org
Subject: Re: Minor UX annoyance w/`git add --patch untracked/file`
In-Reply-To: <20231206195407.GD103708@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 6 Dec 2023 14:54:07 -0500")
References: <20231130192637.wqpmidfv2roqmxdx@shells.gnugeneration.com>
	<20231206195407.GD103708@coredump.intra.peff.net>
Date: Sat, 09 Dec 2023 06:09:46 +0900
Message-ID: <xmqqmsuk1jvp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E51F434-960E-11EE-8505-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> They _could_, but keep in mind that the argument is not strictly a path.
> It is a pathspec that may match multiple paths. So:
>
>   git add -p path/to/
>
> for example will pick up the tracked files in path/to/, but not your
> untracked one.

The corresponding command w/o "-p", i.e., "git add path/to/", will
pick up both tracked and untracked ones from the named directory,
while honoring the ignore settings.  So I suspect it might feel more
natural if "-p" followed suit.

Not that I feel strongly either way.  The command has only worked
with already tracked files since its inception and nobody complained
in the past 15 years or so, probably because nobody cared that much
for relatively rare event of creating a new file and adding it.

Thanks.
