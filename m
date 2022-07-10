Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F118C43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 16:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiGJQfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 12:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGJQfu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 12:35:50 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20151BF68
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 09:35:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A56BF19D49D;
        Sun, 10 Jul 2022 12:35:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XsrqUxC+9GxH
        dDCuvX1RGanQLI925wwPlHR6Enu38Bk=; b=pZZqcEFEkUb3n+sDIMIk0Hv9RYwG
        9lm2kqpYVSPoKA9ehJ5R+i2gC7kOxBws253vy0BkdHY60FE5I0HoOXMTXj9qk4K3
        gdRiDf7x+wGErkY4mzQeIvN+IRQ3cE3CNHoN/aiVUyezozTKVlAeNlxm12Uv0c+L
        jdMKKLnox9rbhyc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9D20F19D49C;
        Sun, 10 Jul 2022 12:35:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 37DA319D49A;
        Sun, 10 Jul 2022 12:35:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonas Aschenbrenner <jonas.aschenbrenner@gmail.com>,
        git@vger.kernel.org
Subject: Re: Suggestion to rename "blame" of the "git blame" command to
 something more neutral
References: <CADS2hGpnkiPzivVDyN-PnGsQCTafqx68PxigXvBK1bv4O=p4kg@mail.gmail.com>
        <220710.86r12t82ea.gmgdl@evledraar.gmail.com>
        <20220710145502.GT17705@kitsune.suse.cz>
Date:   Sun, 10 Jul 2022 09:35:43 -0700
In-Reply-To: <20220710145502.GT17705@kitsune.suse.cz> ("Michal =?utf-8?Q?S?=
 =?utf-8?Q?uch=C3=A1nek=22's?=
        message of "Sun, 10 Jul 2022 16:55:02 +0200")
Message-ID: <xmqq1qutrkm8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5813B7D4-006E-11ED-888F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

>> What do you think about this old patch of mine to add a 'git praise'?:
>> https://lore.kernel.org/git/20190401101246.21418-1-avarab@gmail.com/
>
> Since you are asking .. I think it completely misses the point.
>
> I would consider it effective if users of git-praise(1) needed no
> knowledge of existence of git-blame(1).

I think you are the one who completely misses the point of him
sending the URL (hint: what is the date of the patch?)

"blame" is perfectly fine.  It is the tool we use to find a commit
or a series of commits to be blamed for whichever blocks of code in
the current codebase we are interested in.  Even if it is to find
the source of the buggy or ugly code in the current codebase
(i.e. "verb with negative connotation"), we are trying to put our
fingers on the commit to be blamed.

And it is not personal---you may find who the "author" was as a side
effect of finding that offending commit, but authors write both good
and bad commits, and what we are trying to find is in which commit
lies the origin of the current badness.  There is no need to be
overly politically correct by bending the verb we use.

Please do not waste our limited engineering resource on a nonsense
like this.  A solution for whoever do not want to type b l a m e has
already been provided upthread and the discussion should end right
there.

Thanks.


