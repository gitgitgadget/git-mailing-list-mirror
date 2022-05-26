Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4164C433F5
	for <git@archiver.kernel.org>; Thu, 26 May 2022 23:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbiEZXYB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 19:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiEZXYA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 19:24:00 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B61E52A9
        for <git@vger.kernel.org>; Thu, 26 May 2022 16:23:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AF36C194861;
        Thu, 26 May 2022 19:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=C6bqbN8+GpSO
        8Y68eexIQ8O/aHNag6GKp3eDy/iRsCo=; b=mW1IKN3XHzU2sfwgk8MEwNAAhJEE
        kwpsbfezCdR5FtGpA+Jl8DmUMhHxd6B5rTD1hntDaIlqa7GGPZckai0kYMsPCg9E
        9baopUF0vtp7ujDNHMgxXg10Es8VYNMJuAsyO40F29VsF0y4gUpct+M0qDlM+I55
        nIFlHTfjVLSoQKI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 998AD194860;
        Thu, 26 May 2022 19:23:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3EF9519485F;
        Thu, 26 May 2022 19:23:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 1/3] rebase.c: state preserve-merges has been removed
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
        <0a4c81d8cafdc048fa89c24fcfa4e2715a17d176.1653556865.git.gitgitgadget@gmail.com>
        <220526.86bkvk7hoo.gmgdl@evledraar.gmail.com>
        <19baf95d-67d4-d7ed-72a6-96d098171d3a@web.de>
        <xmqq5ylsxccw.fsf@gitster.g>
        <32e5088b-35a1-4e8c-098e-18c465a0a0bb@web.de>
Date:   Thu, 26 May 2022 16:23:51 -0700
In-Reply-To: <32e5088b-35a1-4e8c-098e-18c465a0a0bb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 26 May 2022 23:27:01 +0200")
Message-ID: <xmqqmtf3x4hk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E77DC988-DD4A-11EC-9B76-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 26.05.22 um 22:33 schrieb Junio C Hamano:
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>>>>  		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
>>>>> -			      N_("(DEPRECATED) try to recreate merges instead of "
>>>>> +			      N_("(REMOVED) try to recreate merges instead of "
>>>>>  				 "ignoring them"),
>>>>>  			      1, PARSE_OPT_HIDDEN),
>>>>>  		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
> ...
> Perhaps a better option help text would be something like "no longer
> supported, consider using --rebase-merges instead"?

Yeah, that would read very well.

Thanks.
