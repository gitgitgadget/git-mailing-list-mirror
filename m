Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA446C2BA2B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 22:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6A220771
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 22:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HtvYIWDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgDPWS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:18:56 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56617 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbgDPWS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 18:18:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 10613B57BE;
        Thu, 16 Apr 2020 18:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FeWOCfkMhVR4UmZZVa1f6xg5/fM=; b=HtvYIW
        DV5idYajAenTVPNDsWcfEusV1TpBfYhO1IBcE8cFM5uf+XmlLfBuVxTZUOcMNtJ7
        AkMPfnKMxuR0Pakfgd3GkJbIJaX0gCTDtgLfte/UwrXmCfO/qXc/miqSWrSJRdOY
        B/XKCREQRCPwibJWLHyx27drPt0X3qSjYLTh0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aqDTzY728SaR6hkzOMy5pMxWv1YSzCrT
        wAkYUVRNqPCG1aA2/F459Orya9s9ansIa8X9a1AuecusXnpuyjC/y0RXhtjCXyG9
        KoKtx2L4cq5KsJwxb82hHg032le8ttQ/rpj6gzyxizlDUR568uyg3oZsxGCehCd/
        V773Vi+CvWI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 071EFB57BD;
        Thu, 16 Apr 2020 18:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 51A1EB57BC;
        Thu, 16 Apr 2020 18:18:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
        <20200416211208.xqnnrkvcl2jw3ejr@doriath>
        <20200416213009.GA1721147@coredump.intra.peff.net>
Date:   Thu, 16 Apr 2020 15:18:47 -0700
In-Reply-To: <20200416213009.GA1721147@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 16 Apr 2020 17:30:09 -0400")
Message-ID: <xmqqh7xjxeew.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F16BC4C-8030-11EA-8385-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Apr 16, 2020 at 11:12:08PM +0200, Damien Robert wrote:
>
>> From Junio C Hamano, Wed 15 Apr 2020 at 16:01:52 (-0700):
>> > * dr/push-remoteref-fix (2020-04-06) 2 commits
>> >   (merged to 'next' on 2020-04-15 at ecf60dc488)
>> >  + remote.c: fix handling of %(push:remoteref)
>> >  + remote.c: fix %(push) for triangular workflows
>> 
>> Hi Junio,
>> 
>> I just sent a new version of this series, which drop the second patch for
>> now. As outlined in my cover letter in
>> https://public-inbox.org/git/20200406175648.25737-1-damien.olivier.robert+git@gmail.com/
>> the triangular workflow patch still leaves some corner cases (and for now
>> is missing reviews).
>> 
>> I'd prefer to fix all of them at once, rather than have an almost working
>> patch. Jeff seems to be of the same opinion in
>> https://public-inbox.org/git/20200406214607.GA1251506@coredump.intra.peff.net/
>
> Yeah, I'm sorry I haven't looked at the latest revision of the series.
> The security fix and some other stuff has been keeping me busy. If
> somebody else has time to review, please don't wait one me. But
> otherwise, it is on my list and I'll get to it eventually.

Thanks.  In any case, they already are in 'next', so please update
incrementally.  In an early part of the development cycle of a
topic, we tend to avoid building a topic from a horribly broken
state and fix things up with pile of "oops, that was wrong, and here
is a band-aid" patches, but once the patches become reviewable shape,
the remaining "issues" tend to be the ones that are not found without
careful reviewing and thinking things through, and it often is easier
for later history inspection if the fixes are separate.

Thanks.
