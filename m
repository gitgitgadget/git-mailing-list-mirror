Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734D3C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D75322B47
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iN/bAkkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgH0Ecs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:32:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64161 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgH0Ecq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 00:32:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFE3E6DE22;
        Thu, 27 Aug 2020 00:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bwr7vb4Nefbv1j2p11SUc4GmEJY=; b=iN/bAk
        kFC3PVFfGrL3sQKc8hLjavG/UvEAeGZYRysbfypaQ+o2FGZVN5LHnMAEP74KAFIB
        J+XfPPWJ9iELcTKVSkL0jEQd5CGIXACxX9Mame7HvScA6sLcG89SYTeaBVeZ55gc
        SDTW6BRKfw4cCyotXiYexvyhhej+0Q6NmKd90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NTqabGcOpV/49BqwXsQysqRUHzR2st+P
        cNh8tQ841/s+azBcg+ez9s1n6BuahAsK2CuhfN99rXmG5CqlVrOInm+4FWoTYvmr
        gF2wpilkuUOR1u2XQv5B5C4I36B2Ob2IRNohu8G+n/NSdmFQmvx2HStAFJO6j9Z/
        +AwYSgWkqgg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D912D6DE21;
        Thu, 27 Aug 2020 00:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67FE56DE20;
        Thu, 27 Aug 2020 00:32:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Sergey Organov <sorganov@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] pretty-options.txt: fix --no-abbrev-commit description
References: <20200826144923.16806-1-sorganov@gmail.com>
        <xmqqv9h5uw7u.fsf@gitster.c.googlers.com> <87pn7d9inu.fsf@osv.gnss.ru>
        <xmqqr1rtt613.fsf@gitster.c.googlers.com>
        <20200827042530.GE3346457@coredump.intra.peff.net>
Date:   Wed, 26 Aug 2020 21:32:43 -0700
In-Reply-To: <20200827042530.GE3346457@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 27 Aug 2020 00:25:30 -0400")
Message-ID: <xmqqd03cso7o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59F9ADC0-E81E-11EA-BAFD-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 26, 2020 at 03:07:52PM -0700, Junio C Hamano wrote:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>> 
>> >> Keeping the original sentence structure, e.g.
>> >>
>> >>     ... and those options which imply abbreviating commit object names
>> >>     such as ...
>> >>
>> >> would have been what I wrote, instead of "either explicit or implied
>> >> by", though.
>> >
>> > Sorry, but it'd then read:
>> >
>> >   This negates `--abbrev-commit` and those options which imply
>> >   abbreviating commit object names such as "--oneline".
>> >
>> > that again essentially reduces to:
>> >
>> >   This negates "--oneline"
>> 
>> "--oneline" means a lot more than "do not use full object name", and
>> I think we are on the same page with our shared goal of not negating
>> everything "--oneline" means.  We just want to say the option
>> negates only the "do not use full object name" aspect.
>> 
>> "and the effect of abbreviating commit objects implied by other
>> options, such as '--oneline'" may be a more verbose way to say the
>> same thing, I would think, but that would be overkill.  I would have
>> expected that with common sense readers would think it would be
>> crazy for --no-abbrev to override everything --oneline means, but if
>> you found that the original risks such an interpretation, perhaps we
>> would need to be more verbose and explicit.  I dunno.
>
> FWIW, as a third-party observer (because you wanted more opinions,
> right?), I found the result of Sergey's original patch easy to read and
> understand.
>
> I also think it's unlikely for people to misinterpret the current text,
> but it does not hurt to be more precise just in case.

Yup, I think I said the same already ;-)
