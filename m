Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99762210A
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 17:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="df5WZUzw"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B4BAB
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 10:04:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F9991BA610;
	Sun, 15 Oct 2023 13:04:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=D0UfQzWPIFafRVbZybA4KP3cZSX2A71Ht1x7gY
	Cdj6A=; b=df5WZUzw1Uwu0bZ+D8Fn/QoJ7imbG/hE7InKPMRcAhwoYMHF6Pd1G2
	i5IQMcmtFUron8YmKAjwOgnDZo0mdlpANf07ZUOZezyL7Pt0Jh0c6iSiJAGfAS5i
	AXKmqtTRCYFBzPbW5cg5V9FQJO0Lo4b3D0hdp6/1yYxeBtzHUukJg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 86A271BA60F;
	Sun, 15 Oct 2023 13:04:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE75C1BA60E;
	Sun, 15 Oct 2023 13:04:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 21/20] t5319: make corrupted large-offset test more robust
In-Reply-To: <20231015031732.GB554702@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 14 Oct 2023 23:17:32 -0400")
References: <20231009205544.GA3281950@coredump.intra.peff.net>
	<20231014004348.GA43880@coredump.intra.peff.net>
	<xmqq4jitt2ie.fsf@gitster.g>
	<20231015031732.GB554702@coredump.intra.peff.net>
Date: Sun, 15 Oct 2023 10:04:26 -0700
Message-ID: <xmqqil77stph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E6518542-6B7C-11EE-89EB-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jeff King <peff@peff.net> writes:

> Yeah, I had a similar thought process. I sort of assume anybody working
> on git.git is capable of turning to "git blame" in a situation like
> this. But maybe:
>
>   # using only %(objectsize) is important here; run "git blame"
>   # on these lines for more details
>
> would spell it out more clearly.

The comment was about "the commit" being not so clear which commit.
"see the message of the commit that added this comment" would have
been perfectly fine and they are not required to use "blame" if they
don't like it.

