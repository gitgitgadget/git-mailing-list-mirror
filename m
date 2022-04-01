Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D25FC433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 16:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbiDAQaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 12:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351227AbiDAQ3m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 12:29:42 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E716C17869E
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 09:02:42 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F98711DB25;
        Fri,  1 Apr 2022 12:02:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pB2cxUVQoptr
        02wseQi++IoR0CA/1/VE06fNoBo9YKM=; b=MTzmzjqv3n+FdETSNX2Cllw2gp2o
        YnXY4DiGGDlJ11T7qf/H3Y0NX5k7hRZy0R4RAshrKoZCU31zVQQP8BFbj79iUHdc
        yfZ+M3vqPcDVH+nMApp1IvwdnY8x+61joVDYo5RAu2c0IiB0cSJ89VL3Mo/F1bvZ
        he3wCXyBtCLbFfI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 66B1711DB24;
        Fri,  1 Apr 2022 12:02:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBFD211DB21;
        Fri,  1 Apr 2022 12:02:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Garrit Franke <garrit@slashdev.space>, git@vger.kernel.org,
        Taylor Blau <ttaylorr@github.com>
Subject: Re: [PATCH v2] cli: add -v and -h shorthands
References: <20220330190956.21447-1-garrit@slashdev.space>
        <xmqq5ynv6rb4.fsf@gitster.g>
        <fb915b91-ead2-ac35-4431-ad35674da463@slashdev.space>
        <220331.86tubfrngz.gmgdl@evledraar.gmail.com>
        <f3935840-e2a0-953e-0e7c-ac921d414ddc@slashdev.space>
        <xmqqsfqx28dv.fsf@gitster.g>
        <220401.86y20pnofb.gmgdl@evledraar.gmail.com>
Date:   Fri, 01 Apr 2022 09:02:39 -0700
In-Reply-To: <220401.86y20pnofb.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 01 Apr 2022 11:23:39 +0200")
Message-ID: <xmqqtubcyeow.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 28895FBA-B1D5-11EC-BBA1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Do you mean you want to use "-V" for version, instead of the "-v"
>> used in the patch, so that "-v" can be left for "--verbose"?
>>
>> I am not sure consistency with whom we are aiming for anymore with
>> that mixed to the proposal X-<.
>
> Maybe you've been convinced to accept -v and -h (I don't care much
> either way, honestly), but if not I wonder if this alternate approach
> would make everyone in this thread happy (or at least mostly so):

I don't care too much about being similar to stuff made by other
people, compared to how much I care about internal consistency ;-)

I do not think one extra level of "unknown option", even with hint,
is worth the trouble.  If we want to cater to those who expect "-h"
to be more special than random "-<some single letter>", we should go
all the way and make "-h" truly supported.  If we do not, they can
read "git help git" just like those who wonder what "git -X" means.

