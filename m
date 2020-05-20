Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CC5C433E1
	for <git@archiver.kernel.org>; Wed, 20 May 2020 21:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86802084C
	for <git@archiver.kernel.org>; Wed, 20 May 2020 21:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="P9gzmUV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgETVOe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 17:14:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52445 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbgETVOd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 17:14:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EC1D46615;
        Wed, 20 May 2020 17:14:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=U05BLU2hg7r1
        ITclS1lSlFx/xf4=; b=P9gzmUV73bxBJViZPcm8Z9/GQGGkQmy68DDWWKaVv5is
        unuZeKvBEbxwc/+NNWTCJaFt6tB3hT4JTe+aklHKMXSXWVrY3Yuxj+AtFL5TtnFV
        uUnOa2i0sRLrGPE+KlIZnzN2QtsrUEMVhUawQAOtL2xTl3au9oGOvQ6bQp/jAKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=i4NMv6
        xkVv9SNOQ66MFxPYQWLk6RYTwTc49YhKroWrlfyeYAazCqhXJPyBOUJ92/Dr6V5C
        Pltt+WNQpaEpl6bOY7VsMbeVg49YP9V6F7aTe3Nnq5F3HVe9IOTGoMsaODy8pnUs
        BIN7nkovYS058glChthC6h9mwt1+Kj9K1mS3g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5755146614;
        Wed, 20 May 2020 17:14:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DB53446613;
        Wed, 20 May 2020 17:14:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Christopher Warrington \(CHRISTOPHER\)" 
        <Christopher.Warrington@microsoft.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "liu.denton\@gmail.com" <liu.denton@gmail.com>,
        Garima Singh <Garima.Singh@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [EXTERNAL] Re: [PATCH 2/3] bisect: remove CR characters from revision in replay
References: <20200520034444.47932-1-carenas@gmail.com>
        <20200520034444.47932-3-carenas@gmail.com>
        <xmqqzha2wt7t.fsf@gitster.c.googlers.com>
        <20200520170843.GC20332@Carlos-MBP>
        <DM5PR00MB0439A347273E56C8697A587A9BB60@DM5PR00MB0439.namprd00.prod.outlook.com>
Date:   Wed, 20 May 2020 14:14:30 -0700
In-Reply-To: <DM5PR00MB0439A347273E56C8697A587A9BB60@DM5PR00MB0439.namprd00.prod.outlook.com>
        (Christopher Warrington's message of "Wed, 20 May 2020 20:59:30
        +0000")
Message-ID: <xmqq1rneux55.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E5545506-9ADE-11EA-BDD4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Christopher Warrington (CHRISTOPHER)"
<Christopher.Warrington@microsoft.com> writes:

> On 2020-05-20 at 10:09-07:00, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
>> IMHO it will be probably still cleaner to do `tr -d '\015'`, even if t=
he
>> patch below avoids all current issues from the testsuite.
>
> My initial attempt to handle CRLF logs was shaped like this:
>
> 	tr -d '\r' <"$file" | while read ...
>
> This introduces a subshell, so there were concerns about propagating
> variables and exits. So, Peff also suggested preprocessing to a file. A=
round
> the same time Junio tried using IFS, and that was simpler.

One thing was that extra processes and temporary files are pure
overhead when people don't use misbehaving editors, so we could just
say "don't do it then".  It may not be worth paying the cost of
being pessimistic and preparing for the worst.  The "$IFS will split
the tokens on the line for free for us" was a no-cost solution and
that was why I suggested it.

In any case, I think there are folks who are rewriting bisect piece
by piece to C, and at that point it would just be the matter of
using strbuf_getline_lf() vs strbuf_getline() to get rid of the
unwanted CR for free.


