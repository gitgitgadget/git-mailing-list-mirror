Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CCB91F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 06:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeK1RcN (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 12:32:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60308 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeK1RcN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 12:32:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BB6E01239D0;
        Wed, 28 Nov 2018 01:31:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xiOxxCh0BVOp
        ota0HhNjJOlOyeM=; b=Uyhfur+0EzzJCf5D+YNocz2qztJ69Y+CJ8fd6Pn2eQdr
        IhCqBScPJIWE5Llk4AMomg/HuLkWiIgdwcWpILJ1rIINFSFYJPuBJOA1w3X+7bcT
        uwrfIeJUV7igUZEHBCsjHL4bIkYzMHaYkUluhpSYsr82GEzDrxGmelo3Tfhe4nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mXCQTE
        KFyarIJ/3sMdNh3pairdrt4Rfy4GH6TRXLEkC7VwpxN85TmYCyIsTdT9lDYV6p0h
        4+WqRVN+55ZevcBhY6mRufVAt+QAkf/BXyxYQjyg20/Uhm0yQshCAxNjs5/uYGTQ
        uNq8x07/KpDPeLRXNS/Ie9aMxIhZRxCCJBHwE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B01FA1239CF;
        Wed, 28 Nov 2018 01:31:39 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 114941239CE;
        Wed, 28 Nov 2018 01:31:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Will <william.duclot@gmail.com>
Cc:     "Git List" <git@vger.kernel.org>
Subject: Re: Git pull confusing output
References: <758FA299-0842-4462-8CF6-D7210D26A6C7@gmail.com>
Date:   Wed, 28 Nov 2018 15:31:38 +0900
In-Reply-To: <758FA299-0842-4462-8CF6-D7210D26A6C7@gmail.com> (Will's message
        of "Tue, 27 Nov 2018 16:52:09 +0000")
Message-ID: <xmqq36rlsofp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 430175F0-F2D7-11E8-8AAF-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will <william.duclot@gmail.com> writes:

> I=E2=80=99m far from being a guru, but I consider myself a competent Gi=
t
> user. Yet, here=E2=80=99s my understanding of the output of one the mos=
t-used
> commands, `git push`:
>> Counting objects: 6, done.
> No idea what an =E2=80=9Cobject=E2=80=9D is. Apparently there=E2=80=99s=
 6 of them
> here. What does =E2=80=9Ccounting=E2=80=9D them means? Should I care?

You vaguely recall that the last time you pushed you saw ~400
objects counted there, so you get the feeling how active you were
since then.

It is up to you if you are interested in such a feel of the level of
activity.  "git fetch" (hence "git pull") would also give you a
similar "feel", e.g. "the last fetch was ~1200 objects and today's
is mere ~200, so it seems it is a relatively slow day".

As to "what is an object?", there are plenty of Git tutorials and
books to learn the basics from.  Again, it is up to you if you care.

>> Delta compression using up to 4 threads.
> No idea what is =E2=80=9Cdelta compression=E2=80=9D, I suppose somethin=
g is being
> compressed. It=E2=80=99s using anything between 1 and 4 threads, which =
is not
> a very precise or useful information. Should I care?

Likewise.

>> Compressing objects: 100% (6/6), done.
> I still don=E2=80=99t know what objects are, but I appreciate having fe=
edback
> on progress

Exactly.

>> Writing objects: 100% (6/6), 656 bytes | 656.00 KiB/s, done.
> Writing what, where? Should I care? Still good to have feedback

You are pushing the data in commits you wrote, modifications you
made to files, etc., to the other side, so that is what is written
to the other side.  Is there any other thing you might suspect that
is written in this context, to make you think a clarification is
needed in the above message?

>> Total 6 (delta 4), reused 0 (delta 0)
> No idea what any of those numbers mean. Should I care?

It is up to you to get interested in these details and learn what
they mean.  In this case, among these 6 objects transferred, Git
managed to find that 4 are similar to other objects the other side
already has or being sent by this push and can be transferred very
efficiently by sending only the difference, which is what "delta"
means.

>> remote: Resolving deltas: 100% (4/4), completed with 4 local objects.
> I do know what=E2=80=99s a remote, but I don=E2=80=99t know what =E2=80=
=9Cresolving
> deltas=E2=80=9D means. There=E2=80=99s local objects now? I don=E2=80=99=
t understand what
> happened to those local objects, are they the byproduct of the delta
> resolving or the input or something else? Should I care?

The "remote:" prefix is "the other side said the following".  IOW,
you are seeing the message from the receiving end.  As you sent 4
objects as mere "difference" (not the whole data needed to know
every byte of the file or directory), the receiving side needed to
find the object the "difference" was relative to, and reassemble
what you would have sent if there weren't delta compression.  These
4 local objects were local from the point of view of the other side,
i.e. the repository that received your push.

The information density of this one is much lower than the previous
progress output lines.  This one is primarily to give you the feeling=20
of relative speed (you've seen how fast the "writing" phase which is
constrained mostly by over-the-wire speed already, and now you are
observing how many more seconds are spent to post-process the data
sent over the wire) and avoiding to get you bored.

I think we have "--quiet" option for those who do not care.
