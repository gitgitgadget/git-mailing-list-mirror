Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A977CC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1F222251
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="avEiClu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391911AbgJTTVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:21:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63872 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391061AbgJTTVe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 15:21:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2DCE73A5C;
        Tue, 20 Oct 2020 15:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tW3F4BZoXM0cosC/jOv4dnDS3J4=; b=avEiCl
        u1mLx6RcQFhQw6U0OzWjILeoEa24QZ/MTQeJndO0/YgIvW7AdpTdxWycX1SPgteB
        bRH2fhob4uRH95u+fn3TbUVM5kRLcH1ZOtf4KocJZIpnhTeJ+pilP9hXONwVvCYe
        axUekGFIKhTYQrX0MTm3va1ROBm36w44vs3lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RNWNs8hBWmNcrHVeZZQPJGhaglC2bMw3
        scpiJtqCeTNhlkvTfhiW4AJKnCqQ7VYCr3oIKK3bcf7GeWKnNV9GpTJpTEDBTGjD
        ssP0/M437z1C85SBeWt1hhv1ZXr/x/Q6SyGndu4KREGhoKyyNoZQ3NyQOQdfDB1N
        z/EfaIHj7M0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB79873A5B;
        Tue, 20 Oct 2020 15:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4877373A5A;
        Tue, 20 Oct 2020 15:21:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     fuyao <fuyao@allwinnertech.com>, git@vger.kernel.org,
        =?utf-8?B?6buE?= =?utf-8?B?6Ie754Kc?= 
        <huangzhenwei@allwinnertech.com>
Subject: Re: Is cover letter can save changes?
References: <20201020070547.GI9517@g8Exdroid64>
        <873629fb6c.fsf@yadavpratyush.com>
Date:   Tue, 20 Oct 2020 12:21:30 -0700
In-Reply-To: <873629fb6c.fsf@yadavpratyush.com> (Pratyush Yadav's message of
        "Tue, 20 Oct 2020 15:53:39 +0530")
Message-ID: <xmqqmu0gbt51.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 762BC864-1309-11EB-A0F3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> On Tue, Oct 20 2020, fuyao wrote:
>
>> Hi:
>>    i have question about format-patch.
>>
>>    when use git format-patch with --cover-letter, we add information
>>    in the cover letter. and then, i must send patch with -v2, the
>>    information in the cover letter is lost in the v2 patch.
> ...
> You can try using `git branch --edit-description <branch_name>` and
> write the contents of the cover letter there. Then you can use the
> option `--cover-from-description` to use the branch description when
> generating the cover letter.

Another thing people are encouraged to do is to use the -o option to
store iterations of your series on disk, perhaps in the same
directory.  When you edit v2-0000-cover-letter.txt file, you can
then reference the previous one you've already sent easily that way.
