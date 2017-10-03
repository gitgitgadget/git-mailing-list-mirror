Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FFDA20281
	for <e@80x24.org>; Tue,  3 Oct 2017 00:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbdJCApH (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 20:45:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62368 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750846AbdJCApG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 20:45:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F0E99A51F7;
        Mon,  2 Oct 2017 20:45:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ODQyDYAJfCX3ahwuQO3NBV4lwWU=; b=KRkxdR
        uajoWFfR39dKM3ClLOtF4ftJrAUWjNCdzprm0F2kSpECOwtY22Q9q1zlmtvE+pjO
        9mZ8Mwluz7CFVahV3t2ew1nRluSSk9OX37dJVUsZGeiemwRx02UNg9i8iBTCbeuf
        qAzC91dSB6hAIVlDAwGlerEO3fo833jUhPxnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=assjn+dB54pDkGoY3bpkNZfPZ00BusXm
        kqUO1wC772s+133BF55lWfWgIG17VUasfTZr2EWQKIcdbo1bnyBwspncYH/yjjGH
        Q72fL+c0C4I7O+Jv30gVsDyaMXilRrdQKP9FOYqG0wnNAAnZzo2rWLwgtZAnRjJj
        s7yT91wqdEI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E8C1EA51F5;
        Mon,  2 Oct 2017 20:45:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 484FDA51F4;
        Mon,  2 Oct 2017 20:45:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.org>,
        Pavel Kretov <firegurafiku@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [idea] File history tracking hints
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
        <E8C827ED458648F78F263F2F2712493B@PhilipOakley>
        <alpine.DEB.2.21.1.1709131322470.4132@virtualbox>
        <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley>
        <alpine.DEB.2.21.1.1709300110350.40514@virtualbox>
        <5fb263a8-d83b-64a7-812f-fd8e3748feb6@jeffhostetler.com>
        <xmqqtvzjv987.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbghnWmvQweup=Z79HnVQQCMM65CKgEO3oqDoRp-Bj=2Q@mail.gmail.com>
Date:   Tue, 03 Oct 2017 09:45:03 +0900
In-Reply-To: <CAGZ79kbghnWmvQweup=Z79HnVQQCMM65CKgEO3oqDoRp-Bj=2Q@mail.gmail.com>
        (Stefan Beller's message of "Mon, 2 Oct 2017 10:41:41 -0700")
Message-ID: <xmqq3771m54g.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19151E1C-A7D4-11E7-96B9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I have rethought about the idea of GUIDs as proposed by Jeff and wanted
> to give a reply. After rereading this message, I think my thoughts are
> already included via:
>
>   - you're doing the work at the wrong point for _another_ reason. You're
>      freezing your (crappy) algorithm at tree creation time, and basically
>      making it pointless to ever create something better later, because even
>      if hardware and software improves, you've codified that "we have to
>      have crappy information".
>
> --
> My design proposal for these "rename hints" would be a special trailer,
> roughly:
>
>     Rename: LICENSE -> legal.txt
>     Rename: t/* -> tests/*
>
> or more generally:
>
>     Rename: <pathspec> <delim> <pathspec>

Yes, it is a non starter to have that baked in the log message of a
commit object.  The principle Linus lays out in the message does not
reject such hints stored outside baked-in data structure, which
allows mistakes to be corrected without affecting the real history,
though.

Another thing that makes what you wrote above of dubious value is
that it attaches such hints to "a commit" (whether baked inside the
log message, or as some form of "notes" that can be associated with
a specific commit); it adds hints at a wrong place.

Given identical pair of trees <X,Y> that are wrapped in two pairs of
commits <A> and <B> where A^{tree}=B^{tree} and A^^{tree}=B^^{tree},
we do not want to have to give duplicated hints for A and B, to help
"git show A" and "git show B" to behave the same.

Rather, if we said "these two blobs A and B are similar and we want
diffcore-rename to pair them, no matter where they appear in any two
trees", then "git diff -M X Y", where X and Y may not have any
ancestry relationship (they may not even be commits) can be told
that the blob A that is in tree X and the blob B that is in tree Y
are renames or copies, no matter where in these trees the pair of
blobs appear, and no matter how X and Y are related (or unrelated)
in the history.

That is a bigger reason why annotating a commit may be a bad way to
go.
