Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD09520899
	for <e@80x24.org>; Sat,  5 Aug 2017 22:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbdHEWiC (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Aug 2017 18:38:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62674 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751174AbdHEWiB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2017 18:38:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C5389F382;
        Sat,  5 Aug 2017 18:37:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lKJW3ow2dbUm
        4EEvaqQ+2CmDOlw=; b=f279uvDZhukhUIGKVQ3OLoZBMHEUPs4J1KCIuNNDDEFn
        6wHsbgCD0FiB327ERCl6Hh7c110LjDtOk42pafYS4Yr81m8HaM/1k8ynXJEDQjHV
        rATBAW1VaV8JUMPq7g5sEy6FetbHgpUsQSdr0pxPCiaX6mWS2KQ4L9If3SSR0ag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=I4pFid
        in4Tu7UAuknGrexuu6S9077BdI5E3roxdnmiCDZYjSq/a7vVbgd0hiOTKwJFhF48
        KMoj/Ru11VrJKD9Z+mThF2Ts4P5yjZG8MaXNDLWEAoACo27zjcUlWfZ93/odWZr5
        x9zBCiiDwSph55Ok9ZBEWSseOeDRa14VbmXSk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74C849F381;
        Sat,  5 Aug 2017 18:37:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D96429F380;
        Sat,  5 Aug 2017 18:37:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2017, #09; Mon, 31)
References: <xmqqfudcgryb.fsf@gitster.mtv.corp.google.com>
        <232547ab-3b87-debc-36a4-d2285ec10a06@ramsayjones.plus.com>
        <CALiud+nm9wu4rBY6zBXmenJj_0Mn7xeU_FAvSdn4fdH+q--Jag@mail.gmail.com>
        <xmqqd18cweak.fsf@gitster.mtv.corp.google.com>
        <87shh57nzs.fsf@gmail.com>
Date:   Sat, 05 Aug 2017 15:37:51 -0700
In-Reply-To: <87shh57nzs.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Sat, 05 Aug 2017 22:34:15 +0200")
Message-ID: <xmqqpoc9sksg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B7D056C6-7A2E-11E7-901B-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We've talked how this UX should look before on-list. Rather than
> re-hashing the arguments I had before I thought it was useful to presen=
t
> it as a table. Here's how the patch looks now:
>
>     |----------------------------+--------------+-------+---------+----=
-------------+-------------|
>     | cmd                        | creates new? | moves | copies? | ...=
with config? | checks out? |
>     |----------------------------+--------------+-------+---------+----=
-------------+-------------|
>     | branch <name>              | Y            | N     | N       | N  =
             | N           |
>     | checkout <name>            | Y            | N     | N       | N  =
             | Y           |
>     | checkout -b <name> <start> | Y            | N     | Y       | N  =
             | Y           |
>     | branch -m <name>           | Y            | Y     | N       | Y  =
             | Y           |
>     | NEW: branch -c <name>      | Y            | N     | Y       | Y  =
             | Y           |
>     |----------------------------+--------------+-------+---------+----=
-------------+-------------|

I actually consider "branch" to *never* invoking a checkout.  Even
when "git branch -m A B" happens to be done when your checked out
branch is A and you end up being on B.  That is not a "checkout".

Really from the end-user's point of view that is not a checkout.
The user renamed the branch A and the same conceptual entity, which
is a branch, is now called B.  If that branch was what was checked
out (IOW, if that branch was what would be grown by one commit if
the user did "git commit"), then now that branch's name is B.  It is
natural if you ask "symbolic-ref HEAD" what branch is checked out
after renaming A to B (and A happened to be what was checked out),
the answer chould be B.

It's like the city you live in changed the name of the street your
house is on.  You do not call movers, you do not do anything, but
your address changes.

> I.e. have "branch -c <name>" but just make it not checkout the new
> thing. What you're describing above sounds to me like:
>
>     |-------------------------------------------+--------------+-------=
+---------+-----------------+-------------|
>     | cmd                                       | creates new? | moves =
| copies? | ...with config? | checks out? |
>     [... stuff above this point is the same ...]
>     | branch -m <name>                          | Y            | Y     =
| N       | Y               | Y           |
>     [... so is branch -m but included for context ...]
>     | NEW: checkout --super-b -b <name> <start> | Y            | N     =
| Y       | Y               | Y           |
>     |-------------------------------------------+--------------+-------=
+---------+-----------------+-------------|

You are talking backwards.  I do not want "branch -c A B", even when
A happens to be what is checked out, to check out branch B.  You and
Sahil were who wanted to check out branch B while doing so, and I
just tried to guess why you two wanted to have such a behaviour that
did not make much sense to me.  And my guess was "perhaps they want
a way to create a new branch starting from another branch, and check
it out, and do so in a single end-user operation". =20

I am not particulary interested in such an operation; in my guess,
you two are.  And the "super-b" thing was a suggestion to you two:
If you so desperately want such an operation, then don't make
"branch --copy A B" that operation.  Such an operation better fits
in "checkout", not "branch".

If you are not interested in such an operation, then that is fine.
Do not add the "super-b" mode to "checkout".

But I won't defend a "branch --copy A B" that checks out B when
users and other people like Ramsay think that such a behaviour is
illogical, because I do think it is, too.


