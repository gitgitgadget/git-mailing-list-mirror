Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A7BC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 19:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbiGYTHP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiGYTHN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 15:07:13 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AF9BC8A
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 12:07:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 37AC9140A7C;
        Mon, 25 Jul 2022 15:07:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AFIYygEWZMpa
        oeNmlu8De/liqLDtQ0xMhLzReYeGJAU=; b=s5w432LKh9o6iw8ir9OEKC9JrD3K
        oKRfIDUQ6tK/X1mDgyCPs1RkVEaGHCqXp+glYybfSnzrb9ODhv6ynjJX9L8tIk/R
        cGqSjy3uBDXP+zfAAbWKPE7AgEHgHmgL5XsbGcYUU8bxjXzIDkhxEJqjzI9+M0Wv
        IvoXsvZm3qWY1WA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2CC61140A7B;
        Mon, 25 Jul 2022 15:07:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D353140A7A;
        Mon, 25 Jul 2022 15:07:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "tenglong.tl" <dyroneteng@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@jeffhostetler.com, git@vger.kernel.org
Subject: Re: [PATCH v1 1/2] api-trace2.txt: print config key-value pair
References: <cover.1658472474.git.dyroneteng@gmail.com>
        <32f8b9ae6bb6aff0ce55ee494c4c0d40c672752b.1658472474.git.dyroneteng@gmail.com>
        <220722.86fsits91m.gmgdl@evledraar.gmail.com>
Date:   Mon, 25 Jul 2022 12:07:09 -0700
In-Reply-To: <220722.86fsits91m.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 22 Jul 2022 12:59:12 +0200")
Message-ID: <xmqqczdt3tb6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FC293D6E-0C4C-11ED-81BC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jul 22 2022, tenglong.tl wrote:
> ...
>> +Print Configs::
>> +
>> +	  Dump "interesting" config values to trace2 log.
>> ++
>> +The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
>> +`trace2.configparams` can be used to output config values which you c=
are
>> +about(see linkgit:git-config[1). For example:
>
> I didn't notice this before, but this is an addition to a long section
> where the examples are ------- delimited, starting with "in this
> example.." usually.
>
> So this "print configs" seems like on odd continuation. Shouldn't this
> copy the template of "Thread Events::" above. I.e. something like (I
> have not tried to asciidoc render this):
> =09
> 	Config (def param) Events::
> 		We can optionally emit configuration events, see
> 		`trace2.configParams` in linkgit:git-config[1] for how to enable
> 		it.
> 	+
> 	< your example below would follow this>
>
> I.e. re my earlier mention of git-config we it explains
> GIT_TRACE2_CONFIG_PARAMS, so perhaps it suffices to just link to
> linkgit:git-config[1] for that.
>
> Also a nit: trace2.configParams, not trace2.configparams.

These may be worth fixing, regardless of the "adding scope in the
example needs to wait until 2/2" I pointed out separately.

Thanks.
