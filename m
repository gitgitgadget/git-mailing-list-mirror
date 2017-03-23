Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21BB120958
	for <e@80x24.org>; Thu, 23 Mar 2017 21:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932136AbdCWVb4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 17:31:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51900 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751496AbdCWVbz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 17:31:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DE3E8692CD;
        Thu, 23 Mar 2017 17:31:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KfIpNQcvkamR
        tmHE+QV8XTfqBHo=; b=rM+TaR02ZRaCJVqetTRGS0lRtFpI193n5yqKkMSZ+gSx
        ndQe/SCM4ZTXs8jSkckSEPmdXv7yp8ZEPj7gCqzvDRkmagUigRfvFQ8SgOHmRJpk
        09oWNJ3Ki44kblA3/Sgj5BYNXetkjSXqbMRJE8rLppqAOsK/17rDgF2TNnO5GaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=V4lQFB
        FoAspCIPxQJpacE+FzsCzjR+bGq8MIHP8Ol4c6It/6HEvUHcf52/zkBKti2y3Eep
        Ja9ErRZoauyz3t9RyH/Kg1hBik/AMbF80v8xCpfaHOc68twJVw1IF3e6nDk7PTPn
        2mqeCi6WEWFgYrjJqx5mrAjPvuijpPKVsrqcg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D4555692CB;
        Thu, 23 Mar 2017 17:31:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4C552692C9;
        Thu, 23 Mar 2017 17:31:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] branch doc: Change `git branch <pattern>` to use `<branchname>`
References: <20170323120326.19051-1-avarab@gmail.com>
        <xmqq1stoexmb.fsf@gitster.mtv.corp.google.com>
        <CACBZZX7vW0TkbrBvLvKWnY=UpHNHzzQ7wuwhEhNOjCCjzPVMjA@mail.gmail.com>
Date:   Thu, 23 Mar 2017 14:31:52 -0700
In-Reply-To: <CACBZZX7vW0TkbrBvLvKWnY=UpHNHzzQ7wuwhEhNOjCCjzPVMjA@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 23 Mar
 2017 22:07:55
        +0100")
Message-ID: <xmqq37e3brxz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 21F3EB0A-1010-11E7-B4F7-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>>  --list::
>>> -     Activate the list mode. `git branch <pattern>` would try to cre=
ate a branch,
>>> +     Activate the list mode. `git branch <branchname>` would try to =
create a branch,
>>>       use `git branch --list <pattern>` to list matching branches.
>>
>> This makes the description more correct.
>>
>> I am not sure if it makes that much sense to have that sentence here
>> in the first place (after all, it is describing a behaviour of a
>> mode that is *not* the list mode), but I guess that it may be a
>> common mistake to forget to specify "-l" while asking for branches
>> that match the pattern?  If we were writing this today from scratch,
>> I would perhaps write something entirely different, e.g.
>
> I'm just doing s/pattern/branchname/ on the existing documentation. If
> you'd like to entirely reword this to make that unnecessary that
> sounds good, but makes sense that you then submit that patch & just
> drop this one, rather than me copy/pasting your proposal, sending that
> as my own patch etc...

That is sensible.  I've already queued yours as-is a few hours ago,
and the remainder of this message is in preparation for a follow-up
patch that is a separate topic.

>>         --list::
>>                 List branches.  With optional <pattern>... at the
>>                 end of the command line, list only the branches that
>>                 match any of the given patterns.  Do not forget '-l'
>>                 and say "git branch <pattern>", as it will instead
>>                 try to create a new branch whose name is <pattern>,
>>                 which is a common mistake.
>
> I like the old one better. It has 3 actual command examples you can
> readily see.

Having the _wrong_ example `git branch <branchname>` that is readily
available for cutting and pasting is the worst of the three reasons
why I think the current text is bad (the other two being "it does
not even help in explaining the `--list` option" and "The argument
to the other mode is not <pattern> but is <branchname>").

I can go without "Do not forget ..." and everything that follows,
though, and if we are going to do so, then

	--list::
		List branches.  With optional <pattern>...,
		e.g. `git branch --list 'maint-*`, list only the
		branches that match the pattern(s).

would be fine.  I am not opposed to having an visually distinctive
example--I just do not want to have one that is wrong without
clearly marking it as such.
