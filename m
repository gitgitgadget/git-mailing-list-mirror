Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C648C43461
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273B520838
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 21:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bSkXFyYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIFVwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:52:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61351 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgIFVwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 17:52:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1ED06F38C;
        Sun,  6 Sep 2020 17:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=qRfTB1IG+gS0ZlQ0aU/S+dRm5no=; b=bSkXFyYA5KloST+J+GcA
        0Hs9z6HysggFmGclT3FxJhc++JZlkO2dsIhWGLgU1MuDw3ay49R1suh+4ygAKZ6k
        wGVemmVsVDnBESf9BrIeGtBisHMuhwasJ8IsoSkk4AJKxlB6PwosGrNT9nN4MjuS
        YybSsIWpaQ0Bj34cQZJ1Nbw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=n9vBdHEq90DUP+GGphIy42+ThiWGvndO2NiRJ+Gf12w7N2
        Ll/GQiwZZPO8O0ZwHgb+hFl3qq8yppLy2cDbZzYB5nOHB2g+vDu60Am3JxCv2tPo
        e5aCcBhbGZKz5ezSKtjO2/khJkujSX6hEtiCNtljm8mBVbAjeOnwvlPWTIThE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D93826F38B;
        Sun,  6 Sep 2020 17:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 62F716F38A;
        Sun,  6 Sep 2020 17:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasyl Vavrychuk <vvavrychuk@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Documentation/git-send-email.txt: Mention less secure app access might need to enable.
References: <CAPig+cT8Kmh6LcoKqkcJX6imXaase07o8C_-7k7RkyhEyW02rQ@mail.gmail.com>
        <20200829153920.17155-1-vvavrychuk@gmail.com>
        <xmqqwo1hi9nv.fsf@gitster.c.googlers.com>
        <xmqqft85i72s.fsf@gitster.c.googlers.com>
Date:   Sun, 06 Sep 2020 14:52:21 -0700
Message-ID: <xmqqmu224lpm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E47B82C-F08B-11EA-BFA6-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Vasyl Vavrychuk <vvavrychuk@gmail.com> writes:
>
> Another thing I forgot to say.
>
> Subject: [PATCH] Documentation/git-send-email.txt: Mention less secure app access might need to enable.
>
> Especially with grammofix s/to enable/to be enabled/ applied, the
> above is way too long as a title and would stand out like a sore
> thumb in "git shortlog --no-merges v2.28.0..v2.29.0" output.
> Something like
>
> Subject: [PATCH] send-email doc: mention less secure app access with GMail
>
> perhaps.
>
> Thanks.

Anything new on this topic?  No rush, but I'd hate to see a
basically good topic to be left in the stalled state too long.
