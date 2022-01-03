Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0821C433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 21:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiACVv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 16:51:27 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59166 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiACVv0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 16:51:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 14D4317068A;
        Mon,  3 Jan 2022 16:51:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pAcXbs0dfOPy
        vcOXceRlsD/yDu+NNfl7IlrqSO9EprI=; b=hFJA/8WrI10GidP1yoFDwLyJ7lps
        zmav28GC84x9OVmcWqnWHc7ylFFEJPlI8tEluNm6NNO2RAzcspQO3dkt+tikyyhg
        ndB57lbUQdZeTiT/Ke8jw2+vEpx79jv1/+2tUBqFo5csCF1TaqezHS9uo7LdHfBB
        uBqenNcTnQdW0kM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BEB7170689;
        Mon,  3 Jan 2022 16:51:22 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 52E3A170687;
        Mon,  3 Jan 2022 16:51:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 11/11] i18n: turn even more messages into "cannot be
 used together" ones
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <12c5da8108752cd70b5b0147fd58c7280ebb3099.1640804108.git.gitgitgadget@gmail.com>
        <xmqqy241oh36.fsf@gitster.g> <1726995.HyZKkVmFqF@cayenne>
Date:   Mon, 03 Jan 2022 13:51:16 -0800
In-Reply-To: <1726995.HyZKkVmFqF@cayenne> (=?utf-8?Q?=22Jean-No=C3=ABl?=
 AVILA"'s message of
        "Fri, 31 Dec 2021 18:16:13 +0100")
Message-ID: <xmqqilv0lc8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 48071B4C-6CDF-11EC-89FB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

>> Don't we want the literal `--pathspec-from-file` outside the format
>> string to prevent it from l10n?  Or have all the changes in this
>> series to turn _("use '--concrete-option-name' in message") into
>> _("use '%s' in message") with '--concrete-option-name' as an
>> argument done only to reduce the number of distinct format strings?
>
> The idea was to apply the '%s' shifting only to strings that can be=20
> factorized,
> in order to curb the number of translatable strings.

OK, that's fine.

> Anyway, swiching from=20
>
>     die(_("use '--concrete-option-name' in message"))=20
>
> into
>
>     die(_("use option '%s' in message"), "--concrete-option-name")
>
> in a more generic way fits perfectly in the spirit I had for this serie=
s.

Yes, but I do not mind leaving it outside the scope of this
immediate series and see a separate topic to clean them up once the
dust from this series settles.

> On the other hand, the patch list is already quite large and this logic=
 won't=20
> be extended to every other candidate strings that are not already chang=
ed=20
> here. That may be the object of another series.

Yup.

Thanks.
