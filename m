Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CE9EB64DD
	for <git@archiver.kernel.org>; Thu,  3 Aug 2023 18:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjHCSx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Aug 2023 14:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHCSxy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2023 14:53:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C221734
        for <git@vger.kernel.org>; Thu,  3 Aug 2023 11:53:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81AFB32669;
        Thu,  3 Aug 2023 14:50:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sCs+eV7UDSHi
        kHwazxQW3j7RMd6O2i/VbRInsWGAxiQ=; b=QOlL3c1Y7df1ZMl2KTmhkErmzcLL
        SiIQZ4stNRBcNB4Q+YrYp3zEB/lxv8y9yH08NcVH3JWWwcDZkZ/Ppfrwj6xlAPh7
        nAiB9L8v9m5as6UpIe+fsMAEWULvZuc9CCimMMb8XuHipPw3G5Mamoc6XPMg9e6A
        rsTmBxxXfgiQ/4A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 796AB32668;
        Thu,  3 Aug 2023 14:50:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B25E532667;
        Thu,  3 Aug 2023 14:50:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Louis Strous <Louis.Strous@intellimagic.com>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH 0/3] git bisect visualize: find gitk on Windows again
References: <pull.1560.git.1691058498.gitgitgadget@gmail.com>
        <xmqqo7jo5d5a.fsf@gitster.g>
Date:   Thu, 03 Aug 2023 11:50:08 -0700
In-Reply-To: <xmqqo7jo5d5a.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        03 Aug 2023 09:00:49 -0700")
Message-ID: <xmqqy1is3qqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 922E92D4-322E-11EE-9D56-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Matthias A=C3=9Fhauer via GitGitGadget"  <gitgitgadget@gmail.com>
> writes:
>
>> Louis Strous reported a regression in git bisect visualize on Windows[=
1]
>> that caused git bisect visualize to use git log instead of gitk unless
>> explicitly called as git bisect visualize gitk.
>>
>> This patch series fixes that regression.
>
> Wonderful.  It would be nice to describe where in the release
> sequence the "regression" happened, if we know it.  Perhaps you've
> written about it in one of the patches?  We'll find out.
>
> Thanks again.

And the answer was in [2/3], if I am reading the proposed log
messages correctly.  When the "bisect visualize" was ported to C, we
broke it.

Thanks.  Will try to queue based on 'maint'.
