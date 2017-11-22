Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64B032036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbdKVBOe (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:14:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57525 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751344AbdKVBOd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:14:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26372AF08F;
        Tue, 21 Nov 2017 20:14:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NsB0azN9or/5eaa1Q/sM7NewNE8=; b=UNbooW
        2LSsCGxC4s1v9NanUb/ISVsN0SCn+WT6I5WeE49W5TtWzEKFWvxDZu6O3QmFY5Ts
        Vx7EOQHCbqb1xdeE11D+e2+BTlERx3y48tViU1BWb0vsblQvCRLBF86STx4AypBh
        SQ3RHAFPfnDfRg6ShWY2hd16yP9QVgRQJ4cq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GR1cVwA2O3qxAQL/vwACr7dK9zC4ZDUV
        ZIS1mRrXr3Zsubg4fZBGvghXGC5KHT/PFPEQk3rpe/r2ZzW3cQh1VFi5ESaVhQbo
        pqJr9q4gPsAc8nHKlbXGg5/Gmn1v9jftfLSmSaecOnLIzXVszP3oMIA654I/PmSG
        ATvW0RjGgf8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D3CBAF08E;
        Tue, 21 Nov 2017 20:14:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78ECCAF08D;
        Tue, 21 Nov 2017 20:14:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Michelbach <michelbach94@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Documentation of post-receive hook
References: <1510872031.23230.7.camel@gmail.com>
        <xmqqpo8hu1fi.fsf@gitster.mtv.corp.google.com>
        <xmqq375dtwnr.fsf@gitster.mtv.corp.google.com>
        <1511112703.8109.5.camel@gmail.com>
        <xmqq1sktoiih.fsf@gitster.mtv.corp.google.com>
        <A82275FD-C9AC-4632-A5E8-ED86CE2AC67D@gmail.com>
Date:   Wed, 22 Nov 2017 10:14:31 +0900
In-Reply-To: <A82275FD-C9AC-4632-A5E8-ED86CE2AC67D@gmail.com> (Christoph
        Michelbach's message of "Wed, 22 Nov 2017 00:44:47 +0100")
Message-ID: <xmqqlgizyv0o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F07CEAC-CF22-11E7-B27D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Michelbach <michelbach94@gmail.com> writes:

> On November 20, 2017 2:17:58 AM GMT+01:00, 
>>How about this rewrite?  Would it consider all the points raised and
>>make it easier to understand?
>>
>>    This hook is invoked by 'git-receive-pack' when it reacts to
>>    'git push' and updates reference(s) in its repository.
>
> I think it's much more intelligible but a hint as to when this
> happens wouldn't hurt. E.g.: "This does not happen if the user
> receives the message 'Already up-to-date'." That is if this is
> correct, of course.

Your suggesting to mention that particular message hints at me that
you feel that the users may not necessarily understand that push did
not result in any update of references on the other side when they
see it.  If the message was clear enough to them, "when it reacts to
push and updates" ought to be clear enough description, too.

And if that indeed is the case (and I would not be surprised if it
is, but I suspect that most users are clueful enough), it is not the
documentation, but the "Already up-to-date" message, that needs to
be clarified, no?

Besides, we'd rather not cast the end-user facing message in stone
in the documentation like that (especially when the message has
known room for improvement and will change).
