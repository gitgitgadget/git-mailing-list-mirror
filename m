Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDAAC433DF
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 18:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1DD21789
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 18:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VWvF/5AF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgJHSxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 14:53:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58584 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgJHSxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 14:53:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 243C7889DB;
        Thu,  8 Oct 2020 14:53:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Usx5W2hRFbMq
        gFa98Cv5wzREUKU=; b=VWvF/5AFYm2u+9a5VnKJx758hZ4DbRT2AgOMQMpxFgtJ
        Ec9fP/pQXZahJMXjhISsm9Mpl97ZynYJ8u4pQNhfAzDJdD+04jlD+fb/hqd0ytxQ
        M+byX/r5VYYBrFjkMSn6Bk5X3TZpp6pfIvIY/XOcOknddqkylwhnjrTq2s+EdIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rLt84q
        44iaZnqYnub+3/R0XYZzEBtUwIiWaC2nk428DdooRT+hsZKTInNnLduQStg17M9b
        Lvh3mYwAYj7wB47DMpsfVDIf/J3Qg1m8jnAym5hiFak+dnA1278U2QouY+D6RFS/
        jCjLTbc/awN8x/srND9TD4gYsgB7NxOM52jpQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BFAB889DA;
        Thu,  8 Oct 2020 14:53:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98A6F889D9;
        Thu,  8 Oct 2020 14:53:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, tytso@mit.edu, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] core.fsyncObjectFiles: make the docs less flippant
References: <87sgbghdbp.fsf@evledraar.gmail.com>
        <20200917112830.26606-3-avarab@gmail.com>
        <xmqqv9gcs91k.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2010081012490.50@tvgsbejvaqbjf.bet>
        <87eem8hfrp.fsf@evledraar.gmail.com>
Date:   Thu, 08 Oct 2020 11:53:40 -0700
In-Reply-To: <87eem8hfrp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 08 Oct 2020 17:57:30 +0200")
Message-ID: <xmqqo8lcwnuz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94D1B56A-0997-11EB-8AF6-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> When I saw the subject in my mailbox, I expected to see that you
>>> would resurrect Christoph's updated text in [*1*], but you wrote a
>>> whole lot more ;-) And they are quite informative to help readers to
>>> understand what the option does.  I am not sure if the understanding
>>> directly help readers to decide if it is appropriate for their own
>>> repositories, though X-<.
>>
>> I agree that it is an improvement, and am therefore in favor of applyi=
ng
>> the patch.
>
> Just the improved docs, or flipping the default of core.fsyncObjectFile=
s
> to "true"?

I am not Dscho, but "applying THE patch" meant, at least to me, the
patch [2/2] to the docs, which was the message we are responding to.

> I've been meaning to re-roll this. I won't have time anytime soon to fi=
x
> git's fsync() use, i.e. ensure that we run up & down modified
> directories and fsync()/fdatasync() file/dir fd's as appropriate but I
> think documenting it and changing the core.fsyncObjectFiles default
> makes sense and is at least a step in the right direction.
>
> I do think it makes more sense for a v2 to split most of this out into
> some section that generally discusses data integrity in the .git
> directory. I.e. that says that currently where we use fsync() (such as
> pack/commit-graph writes) we don't fsync() the corresponding
> director{y,ies), and ref updates don't fsync() at all.

Yes, I think all of these are sensible things to do sometime in the
future.


> Where to put that though? gitrepository-layout(5)? Or a new page like
> gitrepository-integrity(5) (other suggestions welcome..).

I do not have a good suggestion at this moment on this.




