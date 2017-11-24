Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFCB2036D
	for <e@80x24.org>; Fri, 24 Nov 2017 13:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbdKXN1X (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 08:27:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52908 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753476AbdKXN1W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 08:27:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FD6FB19FD;
        Fri, 24 Nov 2017 08:27:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+X67p3mcRQfRBU6PZkLY4RIuMqw=; b=sW1MGg
        XkIwDqWpOpgEC7NCHWswFl/dHeVXaCDrU6TUEIaypnrsjLXgkx0tdRdwW0g+76a7
        Xi6PEITCM/NdZBNj+XO9YuKLyXF6cIhN6qQFOMrCqU6S8o8um5rruwU8w/g+2pqD
        3Q7byb4uJ3oM+4Wh3HF+4gWxlY9iRpzNXoqPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZBb5GB6MwtY9ZvYQ2mx+B7K7kAy3zgxK
        jWoAJnc79nqsxh8LkzvMYokklshpP0FOgEEhqj+paCah8c6I2lduYg2pIis8U0s+
        piJdqqAAWYopfKLIs+GptD/Qhw4mVKi+Ra1cDhROQQ3eN92YwQpzZ8PlSSZwihJp
        bsRP/re9eEI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45A9DB19FC;
        Fri, 24 Nov 2017 08:27:21 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB611B19FA;
        Fri, 24 Nov 2017 08:27:20 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] doc: clarify that "git bisect" accepts one or more good commits
References: <alpine.LFD.2.21.1711220729230.13545@DESKTOP-1GPMCEJ>
        <xmqqh8tkp9nn.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.21.1711240351170.30318@localhost.localdomain>
Date:   Fri, 24 Nov 2017 22:27:19 +0900
In-Reply-To: <alpine.LFD.2.21.1711240351170.30318@localhost.localdomain>
        (Robert P. J. Day's message of "Fri, 24 Nov 2017 04:11:06 -0500
        (EST)")
Message-ID: <xmqqh8tjn6x4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32F2A276-D11B-11E7-8A7A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   in this sense, i don't think "indicate" and "identify" are
> completely interchangeable. in my mind, the word "identify" does
> nothing more than, you know, point at something and say, "that one,
> that's the one i'm talking about;" it goes no further than that.
>
>   on the other hand, the word "indicate" (in my mind) implies that
> you're about to provide some *property* or *quality* of something, and
> you do exactly that in the earlier quote:

I do not think the two words have different connotations, so we are
in agreement.  You do not necessarily need a property in mind when
you "identify" a commit.  You could just "identify" this and that
commits to yourself, to keep them in mind.  You _also_ can have a
property in mind and "identify" this commit as a good one, and that
commit as a bad one.

But identifying a commit as bad (or another one as good) alone to
yourself does not get anything started.  In order to advance the
bisection process, you need to tell the "git bisect" machinery that
"this commit is good", "that commit is bad", etc.  I would think
"indicate" is a verb with better connotation than "identify" for
describing that action.  You indicate something *to* *somebody, and
in this case you indicate that this commit is good and that commit
is bad to git.

