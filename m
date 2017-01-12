Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 760E61FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 23:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751015AbdALXma (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 18:42:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60012 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750796AbdALXm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 18:42:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B16AD60BB9;
        Thu, 12 Jan 2017 18:42:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iR6l0XbsvUgTK7ByBQqXHq9CwPE=; b=mRXl4b
        4JII/GQS9g08nZcjihNhxGyopBHrBfx9jv0O/XP6yaIHXjbTWLuy2C6BQmC0idhj
        G1AJxkH1be17zxboe8pspM66bdBOA8DY6Xi3aef7ew3ZN+MBSt+7huPtnQ97Ij6V
        oYA3P6TIC+Wt0T4miw5mwxv1PHYkPYn7EAVZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g/GYsj2NC+tsVtJ4Wwk3Dw53xTT8v24C
        PNTVS+yeFUPnJJVSCm0DB8sDCgq0/vH8s77r8cR5n0p5pTixhbbKJQwwf9hTuvOo
        0p/AZmPNSTSHLKe8ThC54uAQ8EG4JIqCY2IxG2mQ/iKf24Awo0uUaEZq2cv1cR2t
        Q20E6pSGDvc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A89C560BB7;
        Thu, 12 Jan 2017 18:42:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 132D760BA4;
        Thu, 12 Jan 2017 18:42:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Manuel Ullmann <ullman.alias@posteo.de>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: Bug report: Documentation error in git-bisect man description
References: <87r347swz1.fsf@sonnengebleicht.fritz.box>
        <xmqqd1frj1lt.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 12 Jan 2017 15:42:16 -0800
In-Reply-To: <xmqqd1frj1lt.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 12 Jan 2017 15:32:46 -0800")
Message-ID: <xmqq8tqfj15z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0F65CD2-D920-11E6-83D5-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Manuel Ullmann <ullman.alias@posteo.de> writes:
>
> Hmmm, I tend to agree, modulo a minor fix.
>
> If the description were in a context inside a paragraph like this:
>
> 	When you want to tell 'git bisect' that a <rev> belongs to
> 	the newer half of the history, you say
>
> 		git bisect (bad|new) [<rev>]
>
> 	On the other hand, when you want to tell 'git bisect' that a
> 	<rev> belongs to the older half of the history, you can say
>
> 		git bisect (good|old) [<rev>]
>
> then the pairing we see in the current text makes quite a lot of
> sense.

Actually, the above is _exactly_ what was intended.  I misread the
current documentation when I made the comment, and I think that the
current one _IS_ correct.  The latter half of the above is not about
a single rev.  You can paint multiple commits with the "older half"
color, i.e.

	On the other hand, when you want to tell 'git bisect' that
	one or more <rev>s  belong to the older half of the history,
	you can say

		git bisect (good|old) [<rev>...]

In contrast, you can mark only one <rev> as newer (or "already
bad").  So pairing (bad|good) and (new|old) like you suggested
breaks the correctness of the command line description.

If (bad|new) and (good|old) bothers you because they may mislead the
readers to think bad is an opposite of new (and good is an opposite
of old), the only solution I can think of to that problem is to
expand these two lines into four and list them like this:

        git bisect bad [<rev>]
        git bisect good [<rev>...]
        git bisect new [<rev>]
        git bisect old [<rev>...]

