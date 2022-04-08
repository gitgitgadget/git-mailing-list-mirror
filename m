Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763BAC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 18:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbiDHSt5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 14:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbiDHSt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 14:49:56 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3B73F8B6
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 11:47:52 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7BF6109436;
        Fri,  8 Apr 2022 14:47:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3FyTdO5s1OHb
        cFxBaQSBXjlt0wXRNdxoNAy1SZSArdo=; b=s3HMrLCLoCr62mZ8e4PSNbM3AKyj
        16MLSaz5qnCmx52SyQYoLTBfu/V66ZsOzZB0XRbOaOHX/5pJ+uYAC+UHgDeOKXol
        6HIR54LvcMZP+5V5DyLQlTF9bhNdmKem2ht8nGzUz01eK1ZAYi6nqIv1ePUDidmn
        fp5khQ5HyhWsNHc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFDE5109435;
        Fri,  8 Apr 2022 14:47:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 305DE109434;
        Fri,  8 Apr 2022 14:47:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Kyle Meyer <kyle@kyleam.com>,
        git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>,
        joostkremers@fastmail.fm
Subject: Re: [PATCH] stash: disable literal treatment when passing top pathspec
References: <20220408031228.782547-1-kyle@kyleam.com>
        <e93e9bb1-8bd1-a70f-f671-ca322c14c7a1@gmail.com>
        <220408.868rsgc67o.gmgdl@evledraar.gmail.com>
Date:   Fri, 08 Apr 2022 11:47:50 -0700
In-Reply-To: <220408.868rsgc67o.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 08 Apr 2022 10:46:38 +0200")
Message-ID: <xmqq5ynjmmy1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6480CC28-B76C-11EC-9AC3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Apr 08 2022, Bagas Sanjaya wrote:
>
>> On 08/04/22 10.12, Kyle Meyer wrote:
>>> +test_expect_success 'stash -u works with --literal-pathspecs' '
>>> +	>untracked &&
>>> +	git --literal-pathspecs stash -u &&
>>> +	test_path_is_missing untracked
>>> +'
>>
>> Why not "touch untracked" instead?
>
> The ">" form is correct here. We use "touch" when updating the timestam=
p
> to something in particular is important, but here we're just creating a=
n
> empty file.

Maybe it is better to have it in CodingGuidelines or t/README?

Thanks.
