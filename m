Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21BBC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 19:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376631AbhLBTJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 14:09:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65340 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348377AbhLBTJA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 14:09:00 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E415A101C2C;
        Thu,  2 Dec 2021 14:05:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BZmCC9JkTDBWFS0f6z7BHxvTIm5oeOHeCtuisW
        +BNGw=; b=OVRGSlyKHvKlqS4VT9RDeKGJHFA72kwkIM4QzlF9Us1Tmv1Fc/re64
        gyo1kFw2mLU8tF+jwIkmLgE1fijVJtHthxbxTBouYx5N+flBCZ8KFB4SAH4/2C4g
        QmoOEq68aE7kn3UDK1+wsVmGXnzSsovtAs4c6v1NfT3NvCl+lBFwg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAEBC101C2B;
        Thu,  2 Dec 2021 14:05:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08983101C23;
        Thu,  2 Dec 2021 14:05:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Jeff King <peff@peff.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 4/6] refs: add REF_SKIP_REFNAME_VERIFICATION flag
References: <pull.1147.git.git.1637855761.gitgitgadget@gmail.com>
        <pull.1147.v2.git.git.1638211786.gitgitgadget@gmail.com>
        <0a297f0c3e884c2d4cfb24a6d3b9f1973fc83125.1638211786.git.gitgitgadget@gmail.com>
        <xmqqbl224k09.fsf@gitster.g>
        <CAFQ2z_M35tbF6+C2MkMRm7hO8CNdUSrGTcx+8Os348+rHu4ojg@mail.gmail.com>
        <xmqqh7bs177v.fsf@gitster.g>
        <YafMS6qI+6t6SOtg@coredump.intra.peff.net>
        <CAFQ2z_NvHK17w3Rd958uwNziT2w5wXhiAJTSkCgBi32smgQuOg@mail.gmail.com>
Date:   Thu, 02 Dec 2021 11:05:35 -0800
In-Reply-To: <CAFQ2z_NvHK17w3Rd958uwNziT2w5wXhiAJTSkCgBi32smgQuOg@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 2 Dec 2021 17:40:41 +0100")
Message-ID: <xmqqtufqu8sg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D555B66C-53A2-11EC-B3E3-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Wed, Dec 1, 2021 at 8:26 PM Jeff King <peff@peff.net> wrote:
>>
>> On Wed, Dec 01, 2021 at 11:00:04AM -0800, Junio C Hamano wrote:
>>
>> > > The test helper takes the flag as an argument, in decimal. If you look
>> > > for 2048, you should find it.
>> >
>> > Awful---when the symbolic constants change in the code, the test
>> > will silently break?
>>
>> Agreed, this is quite nasty.
>
> I've added parsing symbolic constants in v3.

Thanks for going an extra mile.
