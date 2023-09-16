Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B070EC2BA16
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 17:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbjIPRpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 13:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjIPRpj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 13:45:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851D5E6
        for <git@vger.kernel.org>; Sat, 16 Sep 2023 10:45:34 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4228034B7F;
        Sat, 16 Sep 2023 13:45:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=3gv5YtC8xX52d7w+qpFEMLilHQscdmt6R6jbyU
        vq96g=; b=RdYQkTYb4XQNpBiiGf+iuSCcAA9JtNwCC6V87TPqU8zdP+KTGzlUeq
        HRJeTg3u4S7IE1fEfKNWc7zW95eCArGxfzvsQGsLyEzfbbcTjx+l53kJ296AZ4ac
        lEtjanV0d3a5VIrdVAvl/g6fnCcRRATEJSHnco8fR7UEEfB8I6xA8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3114634B7E;
        Sat, 16 Sep 2023 13:45:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A51DF34B7D;
        Sat, 16 Sep 2023 13:45:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] parse-options: use and require int pointer for
 OPT_CMDMODE
In-Reply-To: <20230912084029.GD1630538@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 12 Sep 2023 04:40:29 -0400")
References: <2d6f3d74-687a-2d40-5c0c-abc396aef80f@web.de>
        <e6d8a291-03de-cfd3-3813-747fc2cad145@web.de> <ZP2X9roiaeEjzf24@ugly>
        <15530a5f-8d06-24c9-bc2d-e313c895f477@web.de>
        <20230912084029.GD1630538@coredump.intra.peff.net>
Date:   Sat, 16 Sep 2023 10:45:29 -0700
Message-ID: <xmqqa5tmau6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D442ABFE-54B8-11EE-A35F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> True.  Though I don't fully understand these warnings (why not then
>> also warn about if without else?), but taking them away is a bit rude
>> to those who care.
>
> I think losing warnings is unfortunate, but it's just one example.
> We're losing the type information completely from the values.
> ...
>> Or to use an int to point to and then copy into a companion enum
>> variable to after parsing, which would be my choice.
>
> Yeah, I had the same thought. I'm just not sure how to do that in a way
> that isn't a pain for the callers.

The discussion seems to have petered out around this point.
What (if anything) do we want to do with this topic?
