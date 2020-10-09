Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA871C433E7
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C2F22280
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VwzManX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbgJISNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:13:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65375 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgJISNr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 14:13:47 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A52047195F;
        Fri,  9 Oct 2020 14:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/Cgi73TTA3tW2pwahOGJYbydp7o=; b=VwzMan
        X2/N0MwJbk9arnbZUx2azzKPoKk7c1BoRC99Spvt01fQ+C4QALnlARjxPcNukl9+
        iFuo2hsuFtLV9jV0oyXkWO5WoGGxFXSd34GFAAWeWkzky8mjGHo8AU86znvE60gh
        UjhS/eeleMCqEueFT3dRYQUBPxjojFGNZSN80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fEx/1/gezRXOEPyF8X25bupFN3deAm2/
        L421VsuD182gxo4D+hfZSNFuaVusSEReDOdW/Z7W3Z7GR/wV793KnB1cejSUi/3h
        Z8nZU+F1UxmO+1kQOoJWSp6st0cgvqsrmW/N9MBha4zSkTEbpGIiOlFCLhwW0piH
        60dU6KS5AIA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D9517195E;
        Fri,  9 Oct 2020 14:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 245E27195A;
        Fri,  9 Oct 2020 14:13:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Webster <chris@webstech.net>,
        "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
        <20200922170745.GA541915@coredump.intra.peff.net>
        <xmqq1ritlmrk.fsf@gitster.c.googlers.com>
        <CAGT1KpU4Kjv2PEAA7-bNbGp2DFvfsKqABuUK68128xkLjdcEhA@mail.gmail.com>
        <CAGT1KpXz4nFBu2xkVSaoW4DgXc_5oB69MQRQW=365gfgd_R-mQ@mail.gmail.com>
        <nycvar.QRO.7.76.6.2010091519460.50@tvgsbejvaqbjf.bet>
        <xmqqtuv3tlkv.fsf@gitster.c.googlers.com>
        <20201009175917.GA963340@coredump.intra.peff.net>
Date:   Fri, 09 Oct 2020 11:13:43 -0700
In-Reply-To: <20201009175917.GA963340@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 9 Oct 2020 13:59:17 -0400")
Message-ID: <xmqqeem7tgh4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2AD221EE-0A5B-11EB-9670-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 09, 2020 at 09:23:28AM -0700, Junio C Hamano wrote:
>
>> I think this is exactly the use case that
>> 
>>     After the list reached a consensus that it is a good idea to apply the
>>     patch, re-send it with "To:" set to the maintainer{current-maintainer}
>>     and "cc:" the list{git-ml} for inclusion.
>> 
>> in Documentation/SubmittingPatches was written to address.
>> 
>> I usually pay attention to majority of topics and have them on my
>> radar by getting involved in _some_ way in the discussion thread, so
>> I often know when the patch(es) matured enough to be picked up
>> without such a "this is the version after our discussion and it is
>> as close to perfect as we can possibly make" resend.
>> 
>> But for some topics, I have no strong opinion on the exact shape of
>> the final patch(es), and/or I have no expertise to offer to help the
>> discussion to reach the final product.  In such a case, I'd be just
>> waiting, without getting involved in the discussion, for trusted
>> others to bring the posted patch to a completed form.  I think this
>> is such a case.
>
> As the other person in the discussion, I'm sufficiently convinced that
> doing this just for PRs is a good step for now. I.e., I think the
> "completed form" is just what was posted already (though I agree it is
> often convenient to the maintainer to re-post the patch as part of the
> ping).

Yes, and CC'ing those who were involved in the review would give
them the last chance to say "oh, no, that extra change you added
for this final submission was not something I meant to suggest!",
etc.

So, is <pull.709.git.1600759684548.gitgitgadget@gmail.com> as-is the
one we should take?

Thanks.

