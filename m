Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB14720986
	for <e@80x24.org>; Tue,  4 Oct 2016 18:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbcJDSEe (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 14:04:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51392 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750700AbcJDSEe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 14:04:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E32174135F;
        Tue,  4 Oct 2016 14:04:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dVSZgRIJfA0NQD1o75EJJXUOixM=; b=uqZ7dd
        16LGUhl0jE+TxlhAYqz+K/q72yciAJmlCgcnQ5uLexlxK92u7p4QDmrnqQoTYK98
        Z35qOqCu7guJ0jjgXa3iAddTM0PuMxSkrsaEhfNvrI635oCMnFrunutmSrs4dYey
        XEVu65mG2UkXFRP97HCn7/6fHLe1GrX3/3Uh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uquvFVy8ICScgSaNsDvUOULLDVwYHJV+
        dPRLGj20hyT1hFvc9HrEB95FsG7Bz95IxUsAl5qQLZ5oa4XZER4Kt9QLwIFT/IJr
        Ca1cqPFUn58i+wX0UmQ+0RwV9Y0PQ/ucbn9XiyQxWccTYJh82Zz9alU9OgIScb/7
        UHaOHBRe5Qs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC5444135C;
        Tue,  4 Oct 2016 14:04:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 59C3E4135B;
        Tue,  4 Oct 2016 14:04:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] push: change submodule default to check
References: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
        <20161004164036.6584-1-sbeller@google.com>
        <20161004173430.eax4ptohyonc5bw2@sigill.intra.peff.net>
        <CAGZ79kaKOjqLBsNVSmudzLUCkOJf_CsFGE8OZZHsTmuXCfiVeg@mail.gmail.com>
        <20161004175449.gn5cw6wcbvloqkzj@sigill.intra.peff.net>
Date:   Tue, 04 Oct 2016 11:04:30 -0700
In-Reply-To: <20161004175449.gn5cw6wcbvloqkzj@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 4 Oct 2016 13:54:49 -0400")
Message-ID: <xmqq7f9ouh1t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0059AFF4-8A5D-11E6-8FD4-60E27A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Actually, I like that a bit better. It would not cover the case where
> you have not actually checked out any of the submodules (or at least not
> called "submodule init", I guess?). But arguably that is a sign that the
> auto-recurse behavior should not be kicking in anyway.

Yeah, the "no init, no recursion" line of thought is very sensible.
I like it.

