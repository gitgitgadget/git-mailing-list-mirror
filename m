Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38BC207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 21:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754723AbdFWVrP (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 17:47:15 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34328 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754600AbdFWVrO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 17:47:14 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so7585080pge.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 14:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ckD7BJ5kZDn5HfzHBvVF8gH6CA2yBWES7EuAKfEhlCA=;
        b=JELgI5YJy5bcg1WQAvsQLLKMK4g7j4iR+8ZmP/pCJpzRG7A+N8ANEQhDfPgU4Ih7hM
         nuFaYf+g5nOgM3pbRBgbtxSmwnu3P01EJgNuIyHBzvMrr5+i/az3zUlrcnO+nL9XePJf
         htsftZuhcIh/vf09vk7TdOmiUsJgdO4BLBbg+jonu6or1sZSvu3hsSeGJj+FvcFSUTv+
         9NnFBRybT3RHfhwy5bNa+3N3uzHizTknyALxsRaudxEK3sA/HkdY2TJtdQq1qDc5p4h7
         cwuhLJ0kZefAKyA5rFs73NdpaI0Aoqo64fGp0Qk4iFQU56tpf7xH55J/WItwXq2Oy/BT
         tCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ckD7BJ5kZDn5HfzHBvVF8gH6CA2yBWES7EuAKfEhlCA=;
        b=h8nSvHbR5aqwY7dr5vgIANuRfzdBAQn/qbCpdrWgK4HOSmHHGWd8sB2DwebrelXxzV
         6hspSpy2bvJtJWAVVyrZ6g7gJBOZUDWQffcIwCps5RzOsf2NcO2O6jGlf/KjMKEcpK5X
         eiyCNUUh+kHwW2gSHHz/qJSnCWNHh8aIPMiu4vKg3y6ioN7vE7A35HxMjRQ+hbSE/mX8
         IdEghKEs6gA0PU9CuXIianWzKG1nt2LS/gknv2UDy/6GSeViECNq7cySj+PLXOrdCapO
         ATBOyR0G+yjk3g3bszRdo/OBX0wlDJ6AejUeuA7UgNJyGVO5KDnhMw//xvGCUvmuu2Gj
         0wCQ==
X-Gm-Message-State: AKS2vOzudEUq63vE6TwnPD0rDLkDF/B4n43zpsL7YpgeE2Z5y/b3jtvw
        Zo66F+PTRAf9EA==
X-Received: by 10.84.218.198 with SMTP id g6mr11121997plm.132.1498254428357;
        Fri, 23 Jun 2017 14:47:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id x3sm13101463pgx.29.2017.06.23.14.47.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 14:47:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 00/29] Create a reference backend for packed refs
References: <cover.1498200513.git.mhagger@alum.mit.edu>
        <20170623190159.5ct2mgjcm6vuulz6@sigill.intra.peff.net>
        <20170623200024.amgced62hue2iffj@sigill.intra.peff.net>
Date:   Fri, 23 Jun 2017 14:47:01 -0700
In-Reply-To: <20170623200024.amgced62hue2iffj@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 23 Jun 2017 16:00:24 -0400")
Message-ID: <xmqqefuacr6y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jun 23, 2017 at 03:01:59PM -0400, Jeff King wrote:
>
>> On Fri, Jun 23, 2017 at 09:01:18AM +0200, Michael Haggerty wrote:
>> 
>> > * Change patch 17 "packed_ref_store: support iteration" to always
>> >   iterate over the packed refs using `DO_FOR_EACH_INCLUDE_BROKEN`.
>> >   This switches off the check in the packed-ref iterator of whether a
>> >   reference is broken. This is now checked only in
>> >   `files_ref_iterator_advance()`, after the packed and loose
>> >   references have been merged together. It also saves some work.
>> 
>> I'm curious why you prefer this solution to just removing the code
>> entirely. Wouldn't it be an error to call the packed ref iterator
>> without INCLUDE_BROKEN? The "entries may not be valid" thing is a
>> property of the packed-refs concept itself, not a particular caller's
>> view of it.
>
> Speculating on my own question. I guess it would prepare us for a day
> when a possible ref store is to use a packed-refs _without_ loose refs.
> IOW, the property is defined on packed-refs today, but a possible future
> direction would be to use it by itself. But maybe I'm just making things
> up.

OK.  In other words, it's not a packed-refs's characteristics that
cruft are allowed.  It's that a ref storage that is implemented as
an overlay of one storage (which happens to be the loose one) on top
of another (which happens to be the packed refs file) allows the
latter one to have cruft if (and only if) that broken one is covered
by the former one.

> At any rate, I've read through the whole series and dropped a few
> comments in there. Overall it looks good. If I had one complaint, it's
> that the individual commits all look obviously correct but it is hard to
> judge whether the bigger steps they are taking are the right thing. I
> mostly have faith in you, as I know that your end goal is a good one,
> and that you're very familiar with this code.  But just something I
> noticed while reviewing.

Thanks.
