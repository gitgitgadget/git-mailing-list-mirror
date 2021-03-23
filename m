Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258C7C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE156619C2
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 17:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhCWRLZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 13:11:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59274 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhCWRLL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 13:11:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D41AB120B3C;
        Tue, 23 Mar 2021 13:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O9AFoGlI9zvotF5AfuxkWMwdX2w=; b=t9qZPb
        jYRObEI0oTOb4nEuwpN1PBscZdoEYeINCFm4y5Xg5s2ZPIMR+zAys6y/Qk1XJDgW
        uER7K+pgt7AqG635CYxpJ41tjZdGcoMXWgxVtr1gCwQgx9qEUCcU53HDJ7TKQlaJ
        53fsC9vZvP9Udzp9RBZER3IpEq4BjtHXj86iM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YX6AV/PYD0xsAbC/DiGlpofBd/OS2ENh
        Y1s03I4RFx0loT5PFShp8jus6/y6RkCHsQPD6ZM1r/AjILehozKWZZGYLdM/E3y5
        Ig9PsAtr6q1/XObz/uB+AyVYK2+sL1390ZgBwjwQDWUjDiz8LTz8aV4FC2VZc1wa
        F9+NVe9ZH0I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC8F0120B3B;
        Tue, 23 Mar 2021 13:11:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 07BBD120B38;
        Tue, 23 Mar 2021 13:11:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
        <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com>
        <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
        <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
        <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com>
        <xmqqv99i4ck2.fsf@gitster.g>
        <CAP8UFD0s4Gm3PgDPpsXC-8Gyrnn1JTMUBu60XGV7i8nRDCCJ2Q@mail.gmail.com>
Date:   Tue, 23 Mar 2021 10:11:05 -0700
In-Reply-To: <CAP8UFD0s4Gm3PgDPpsXC-8Gyrnn1JTMUBu60XGV7i8nRDCCJ2Q@mail.gmail.com>
        (Christian Couder's message of "Tue, 23 Mar 2021 08:57:25 +0100")
Message-ID: <xmqqeeg54wye.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C191AF16-8BFA-11EB-8140-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Tue, Mar 23, 2021 at 7:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > If you want nothing to happen when $ARG isn't set, you can change the
>> > config option to something like:
>> >
>> > $ git config trailer.sign.command "NAME='\$ARG'; test -n \"\$NAME\" &&
>> > git log --author=\"\$NAME\" -1 --format='format:%aN <%aE>' || true"
>> >
>> > (This is because it looks like $ARG is replaced only once with the
>> > actual value, which is perhaps a bug. Otherwise something like the
>> > following might work:
>>
>> I do not know the origin of that code in trailers.c but it feels
>> quite confused and error prone to use textual replacement with
>> strbuf_replace().  Why doesn't the code, which knows it will use
>> shell to execute the command line given by the end user in the
>> configuration, to just export ARG as an environment variable and
>> be done with it?  It would also avoid quoting problem etc.
>
> Yeah, I agree that would be better.

It probably would have been better to do so before the feature got
unleased to the public, but doing such a change retroactively would
introduce regression for those who were using ARG that happens to be
safe from shell quoting rules.

For example, if the trailer.*.command were

	echo '$ARG'

and the argument 'h e l l o' were to be given to it, then the
current code would have textually expanded $ARG with the argument
and caused

	echo 'h e l l o'

to run, which would have been "fine" [*1*].

But exporting the environment ARG would "break" such a setting that
has been "working perfectly well" for the user.  Because of the
single-quotes around $ARG, the command now will give literal four
letter string $ARG and not 'h e l l o'.

We should think such potential ramifications of changing it (and
also not changing it) through before deciding what to do about it.

Although I have a feeling that not many people would miss '$ARG'
inside a pair of single-quotes to be replaced textually and it would
be OK to make a backward incompatible bugfix, the safer and better
way is not all that difficult, so I am inclined to suggest going the
usual "deprecate and replace and then later remove" dance.

The normal sequence of replacing a "sort of works but not
recommended" feature with a "better and safer, but can break a
setting that has been 'working'" feature is:

 - Announce deprecation of trailer.x.command and add and advertise a
   similar traier.x.cmd that (1) exports environment variable ARG,
   or (2) passes the argument as a positional parameter [*], as a
   replacement.  Explain the reason for deprecation (i.e. unsafe
   substitution that works only once).  When .cmd exists, .command
   is ignored for the corresponding trailer.x

 - Wait for a few releases and then remove trailer.x.command.

and that is the safest way to fix this "bug".


[Footnotes]

*1* If the argument were 

	';rm -rf .;'

    then it wouldn't have been fine, though, and that is how the
    current code solicited "Huh?"  reaction out of me.


*2* If we passed the argument as a positional parameter, the example
    you gave in the quoted part of the message would become
    something like this:

      [trailer "sign"]
        cmd = test -n "$1" && git log --author="$1" -1 --format='%aN <%aE>'
