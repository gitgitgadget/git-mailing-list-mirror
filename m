Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDCEC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391445AbiDUSnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiDUSnH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:43:07 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDB05F58
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:40:16 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 96DF419429F;
        Thu, 21 Apr 2022 14:40:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vdzkILIFm1xE+ebbu3cdnaLGSWdfTcAomBV9gN
        VvTtE=; b=Nph532GPFZyhgNHWWvOnTldkE7OPxH9QQa58tWEZaJ5Zgu2T0edJOP
        BMaNyFSlK0E8wSCbZfpFJvUAwUJ5b87E5I0W/Nm97IBFwUK1YQKytWHHKDkwOtXM
        1UHfrP2BTSn25v94dvYRQIJHyp9x8gd5sUXDYPST9VU893nsuBLU0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FC3219429E;
        Thu, 21 Apr 2022 14:40:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 31DCC19429C;
        Thu, 21 Apr 2022 14:40:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Anthony Sottile <asottile@umich.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
        <Yl9Hn0C0TwalASC0@google.com>
        <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com>
        <xmqqr15rr9k6.fsf@gitster.g>
        <CAJoAoZm7p32Hn=TLQeWUqp_nMjo_TQ2whR4F=cXk4c6PV1M5bA@mail.gmail.com>
        <xmqqilr3r7ki.fsf@gitster.g>
        <CAJoAoZnw6cNBwWpa5w-rhQ4p_zw6w6Q-NHzNeRKrrqPpDCjY2A@mail.gmail.com>
        <220421.86sfq67hlr.gmgdl@evledraar.gmail.com>
        <xmqqsfq6jqnt.fsf@gitster.g>
Date:   Thu, 21 Apr 2022 11:40:09 -0700
In-Reply-To: <xmqqsfq6jqnt.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        21 Apr 2022 10:24:22 -0700")
Message-ID: <xmqq8rryi8l2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7918EBDA-C1A2-11EC-837B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Especially the previous cycle, I was experimenting with a tweak in
> my workflow to have topics in 'next' to cook for one week and have
> them graduate to 'master' unless we saw regression in a week.

"and mechanically have them graduate" is what I meant.  Also

> Previously, I tended to keep topics on the larger side in 'next' and

"in 'next' longer, and" is what I meant.

> we did see "oops we found this after the topic hit 'next' and here
> is a fix-up" to them, which I think helped to catch bugs before it
> broke 'master'.

