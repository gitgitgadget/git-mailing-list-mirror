Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B061F667
	for <e@80x24.org>; Sun, 13 Aug 2017 17:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbdHMRd0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 13:33:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52932 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751025AbdHMRdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 13:33:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4FD5A9A5B;
        Sun, 13 Aug 2017 13:33:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iL+FP905Oxw+1JMjlZLcXvg1PS8=; b=WDeYAo
        ATASLvQjdYMMHJYBlZvhtufGY1P1aNX73ffotCOslAAXYPmG5aez9CCrtdV9tcHk
        kbSjHF97eSMaZNcSSXh1/WVzG0U5z9vHCaI8oduOWb/+iiHEmdRFblCWUHLaYb4q
        imbtXkTvm1nlgOJMaczEpmAFokzIxb+68eoc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uTQJrOGXMzdO9PfjIxoDMTktPq3XoYQ4
        DY6Tf3IrJvZra59jBCcJ3pzwC5J2TIULv9+2RKztGWGqftL6lV/VrRrZD9gkvbci
        28+8AMKR8SyZZtHYr5hs01f0QQcZ6h/uaeuJLkCn00Ood4qPTfGf9IW9Yj2vhpGM
        FDdpdfQ3gCg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABA80A9A5A;
        Sun, 13 Aug 2017 13:33:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F84FA9A59;
        Sun, 13 Aug 2017 13:33:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
References: <20170808012554.186051-1-bmwill@google.com>
        <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
        <87y3qsg7ni.fsf@gmail.com>
        <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
        <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
        <20170811175237.GC59325@google.com>
        <20170811211845.tpgmafenhahus77o@sigill.intra.peff.net>
        <xmqq378xxuvk.fsf@gitster.mtv.corp.google.com>
        <20170813044145.xz4o47oog3z5eycg@sigill.intra.peff.net>
        <26bebb5b-857f-1501-5139-a5513d9875ec@ramsayjones.plus.com>
Date:   Sun, 13 Aug 2017 10:33:13 -0700
In-Reply-To: <26bebb5b-857f-1501-5139-a5513d9875ec@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 13 Aug 2017 17:14:55 +0100")
Message-ID: <xmqqy3qnwexy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CAF1EB8-804D-11E7-BBC8-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> As a start, how about something like this:
>
> -- >8 --
> $ git diff
> diff --git a/Makefile b/Makefile
> index 461c845d3..7555def45 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2440,6 +2440,18 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>  
> +ST_C = $(patsubst %.o,%.stc,$(C_OBJ))
> +ST_H = $(patsubst %.h,%.sth,$(LIB_H))
> +
> +$(ST_C): %.stc: %.c FORCE
> +       checkpatch.pl --no-tree --show-types --ignore=NEW_TYPEDEFS,INLINE -f $<
> +
> +$(ST_H): %.sth: %.h FORCE
> +       checkpatch.pl --no-tree --show-types --ignore=NEW_TYPEDEFS,INLINE -f $<
> +
> +.PHONY: style $(ST_C) $(ST_H)
> +style: $(ST_C) $(ST_H)
> +
>  check: common-cmds.h
>         @if sparse; \
>         then \
> $ 
> -- >8 --
> ...
> Hmm, on reflection, it may be a bit too crude! :-D

As you already saw in the output from this, I think this is a good
illustration that shows why we want an incremental tool that works
on the changes, not on full file contents.  Contributors who want
their changes accepted and want to help the review process by
avoiding trivial coding style violations in their patches should not
have to find _their_ piece from an output about the whole file
contents, most of which is likely to have been inherited from the
original.  They are not working on Git to produce unnecessary code
churn whose only purpose is to make existing and otherwise dormant
code conform to the style tool's liking.  That's not their focus.

IOW I was expecting something that works on the output from "git
diff HEAD" or "git format-patch --stdout @{u}.."

Unless you were somehow envisioning that having a baseline line
this, and then take another full dump after their patch and
comparing the two, would make a good foundation for that incremental
checker, that is.  I am not sure if that would be a workable
approach myself, though.

Thanks.
