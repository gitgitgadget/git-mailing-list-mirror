Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EB2C433E0
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92840208C3
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 18:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vmRhgA2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgFRSEt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:04:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53380 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgFRSEs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 14:04:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EC81D92A5;
        Thu, 18 Jun 2020 14:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wBYuJx5anOcEbxF+9htQoigZelU=; b=vmRhgA
        2f7Fg7VqZ77xnnkjU05zWSasbI/sErJf6pCQ1zrRjQTCdAQLF5HgI2OTzCA5+0NE
        XNWqQoexP3JLoIvYEvqR+yGVdEoWrP16CXiyhmxW4XnxsKWy0o6WjwwxXHrtnZI2
        Bszj1PoGErUZdbSaxC5CG/E3KS/L/ipF739eE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FnrBIy49iSovQwbRKDvZJ/N9Q8i0L03w
        3ICdcqclYTSJb24vApgpElv14MqKJXi0v7EbATeXhmGsZZ6gVqOfl/mQbyhObfXh
        +Tr1CqghRixPEUSeJPfeRtiZcyOr/sZeIYzC3eh9otutVAX7yp2T4oCcBWnPVBdW
        YIeIrwxnzrA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 150A8D92A3;
        Thu, 18 Jun 2020 14:04:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 57840D92A2;
        Thu, 18 Jun 2020 14:04:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     demerphq <demerphq@gmail.com>
Cc:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        =?utf-8?Q?S?= =?utf-8?Q?=C3=A9rgio?= Augusto Vianna 
        <sergio.a.vianna@gmail.com>, konstantin@linuxfoundation.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        Git <git@vger.kernel.org>, newren@gmail.com,
        philipoakley@iee.email,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Rename offensive terminology (master)
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
        <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com>
        <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
        <20200616074316.GA21462@kitsune.suse.cz>
        <CANgJU+XzD9Nnnu4qWExpOUBy+u1=23SRCQy-=6aAVFJAowkjYg@mail.gmail.com>
        <xmqq5zbpv53g.fsf@gitster.c.googlers.com>
        <CANgJU+Ut+ANPHud1JQw1Wo+zb37_=EWx-vgap6FGC+T=-dzn4A@mail.gmail.com>
Date:   Thu, 18 Jun 2020 11:04:40 -0700
In-Reply-To: <CANgJU+Ut+ANPHud1JQw1Wo+zb37_=EWx-vgap6FGC+T=-dzn4A@mail.gmail.com>
        (demerphq@gmail.com's message of "Thu, 18 Jun 2020 09:40:37 +0200")
Message-ID: <xmqq1rmcp7wn.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F3653E8-B18E-11EA-A366-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

demerphq <demerphq@gmail.com> writes:

>> What I am trying to get at is, after changing the name that is given
>> by default to the primary branch in a newly created repositories by
>> "git init" to 'main' (which I am OK with, and it seems that the
>> major projects and repository hosting services will be doing anyway
>> with or without getting themselves in this discussion on this list),
>> wouldn't we risk the same "master master" confusion caused by and to
>> those newer users who learn 'main' is the word given to the primary
>> thing?
>
> Yeah I think it will still cause problems. If it was my call I would
> not choose "main" either. Having said that I do think it is a bit
> better than "master" however, as it leaves the term "master"
> unambiguously about repositories, and it leaves the term "main"
> unambiguously about branches.

Well, 'main' is clearly better than 'master' as there do not seem to
be so many haters of the former than the latter.

But you cannot escape from the fact that when you need to have one
special/primary repository among different ones, and each repository
has one special/primary branch among different branches (and you are
lucky that you have to only worry about two levels in this case), it
is inevitable that you risk the "master master" problem no matter
what, unless you choose different word for 'primary' at each level.

It may be that it is the default _branch_ name people are unhappy
about the use of word 'master', but I do not see the reason why
people would not be unhappy about your reference to the 'master'
repository of a project the same way.  So basing your argument to
rename the default _branch_ to 'main' (or any word that is not
'master') because of "master master" problem does not compute well,
which was my point.  'main' is not better than 'master' because you
want to keep using 'master' to refer to your primary repository.

> So yeah, I would say that "main" is slightly better than "master" but
> is still suboptimal from a comprehension point of view, and it is
> downright unhelpful for my $workplace (but I recognize that isn't a
> problem you should be considering in this discussion.)
