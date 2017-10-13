Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF1720437
	for <e@80x24.org>; Fri, 13 Oct 2017 12:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753434AbdJMMEH (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 08:04:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54379 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753258AbdJMMEG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 08:04:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3158B7AE1;
        Fri, 13 Oct 2017 08:04:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kKk9iNqAUBnyF1f6aFcRiJtiqog=; b=vi6SG/
        FwFSnKAKgld6MdN24PymgA44wyzaMilHKIVBod2GdisYLpZ/KJrr4ielDaNdUnm5
        rBm/BVEv6rAX9okrqbOvU+t2PHiB1tIZq5NVBBfEvBzwk9ePWbYzvL9FAhDIHMjQ
        dVhRUG6muWRW3WdnBHZYlRhUVcnonc3L3iZMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=m9PadOyXcTT2Cr7ZhdHMzi9klXNY2DiE
        aomk1ZZNszNbO1P+Qb2dctXg5fqcpUtLGYpQaOjTjBSr7a55f/P7pfbrB6ZoXHOj
        ijDipzky8kIn11ma1EAp1Dhlio9DRGYAQMpIsLUQeKsvWV+djsEQW6cCqC5Z3Q5R
        oR94xPh3k8s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BA02EB7AE0;
        Fri, 13 Oct 2017 08:04:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12A69B7ADF;
        Fri, 13 Oct 2017 08:04:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Moy Matthieu <Matthieu.Moy@univ-lyon1.fr>
Cc:     second.payre@gmail.com, git@vger.kernel.org,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>,
        Daniel Bensoussan <daniel.bensoussan--bohm@etu.univ-lyon1.fr>,
        Timothee Albertin <timothee.albertin@etu.univ-lyon1.fr>
Subject: Re: [PATCH v2] Documentation/git-config.txt: reword missleading sentence
References: <xmqqtvz7pewn.fsf@gitster.mtv.corp.google.com>
        <20171012091727.30759-1-second.payre@gmail.com>
        <xmqqa80vyjyf.fsf@gitster.mtv.corp.google.com>
        <q7h9infjmos9.fsf@orange.lip.ens-lyon.fr>
Date:   Fri, 13 Oct 2017 21:04:03 +0900
In-Reply-To: <q7h9infjmos9.fsf@orange.lip.ens-lyon.fr> (Moy Matthieu's message
        of "Fri, 13 Oct 2017 10:32:06 +0200")
Message-ID: <xmqqvajjuudo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C03A07C-B00E-11E7-B245-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Moy Matthieu <Matthieu.Moy@univ-lyon1.fr> writes:

>>>  --path::
>>> -	'git-config' will expand leading '{tilde}' to the value of
>>> +	'git config' will expand leading '{tilde}' to the value of
>>>  	'$HOME', and '{tilde}user' to the home directory for the
>
> Didn't notice yesterday, but you still have forward quotes here and
> backquotes right below. If you are to fix this paragraph, better fix all
> issues at once.

When we say ~user in this sentence, unlike $HOME, it is not
something the user would type literally; 'user' in that is a
placeholder to be replaced with a value appropriate in the real
life, e.g. ~moy.  So '{tilde}user' may actually be OK, even though I
agree that `$HOME` may be more correct.

>>>  	specified user.  This option has no effect when setting the
>>> -	value (but you can use 'git config bla {tilde}/' from the
>>> -	command line to let your shell do the expansion).
>>> +	value (but you can use `git config section.variable {tilde}/`
>>
>> Does this reference to {tilde} get expanded inside the `literal`
>> mark-up?  ...
>
> If I read correctly, the potential issue with ~ is that it's used for
> subscript text (i.e. foo~bar~ in asciidoc is LaTeX's $foo_{bar}$). But ~
> within a literal string should be safe, and at least we use it in many
> places in our doc.

My comment was not about "safety" but about correctness.  At least
for me, `{tilde}user` does not expand to ~user, but instead spell
out open-brace, tee, eye, ..., close-brace, followed by "user",
which is not what we want.
