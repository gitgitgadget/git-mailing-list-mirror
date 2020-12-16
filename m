Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EAAC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F250F22D02
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbgLPTSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 14:18:02 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54661 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387849AbgLPTSC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 14:18:02 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4BA1A5A7D;
        Wed, 16 Dec 2020 14:17:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+LHWUGNn9atq
        /CL3INLart7WAPo=; b=n5AXDQa/lQJ+bC772Ru/+rbBw3w3psTDM1cg4HnNGlU9
        p8hfo3lE3yVsp6lcpmIoXn5HBb0ch5sDnz7GQTAxb1ahZTAjLnV5QZSJnCySbODK
        NkUMz9izsQfiaW720lYlNShRsZUuqRp6jL55LAaCSFGOUbbXUYYYYN3VfzUU79c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=uTSWIp
        VWKZ5Mr+epYgIDgjlINhkRGrwD+KAOYew7JS1UZxpoYqY+daR67F7o0jvlQmpnUg
        Wyu3/Gl/dI0qs4IzTzZqG5OHDVuIr1Uy67Td48JB+V36rV2xXOiLBNQvdMtLGOup
        WUxFvOCubKuMGwWkkGBzE4sYVDUCquChgqpWQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8E30A5A7C;
        Wed, 16 Dec 2020 14:17:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 362E4A5A7B;
        Wed, 16 Dec 2020 14:17:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Fwd: Bug in `git add -N xyz ; git stash` command
References: <CAHMHMxW-LwjLWF9PPuSJmbAafw37d_18j+HmOd4+8MKbajb_8A@mail.gmail.com>
        <CAHMHMxW_zwq_xK3Mh5QjC4dM1muVotESZdGQkRAx8xeKYmHzbw@mail.gmail.com>
Date:   Wed, 16 Dec 2020 11:17:18 -0800
In-Reply-To: <CAHMHMxW_zwq_xK3Mh5QjC4dM1muVotESZdGQkRAx8xeKYmHzbw@mail.gmail.com>
        (=?utf-8?B?Is6jz4TOsc+Nz4HOv8+CIM6dz4TOrc69z4TOv8+CIidz?= message of "Wed,
 16 Dec 2020 12:48:04
        +0200")
Message-ID: <xmqq1rfp4l35.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 50DFE1F2-3FD3-11EB-9D75-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 =CE=9D=CF=84=CE=AD=CE=BD=CF=84=
=CE=BF=CF=82  <stdedos@gmail.com> writes:

> I think I have found a bug with the following series of commands:
>
> $ git add -N xyz ; git stash
> error: Entry 'xyz' not uptodate. Cannot merge.
> Cannot save the current worktree state
>
> It has bothered me that `git add -N xyz` "is not obvious that it is
> done", unless you know that you did it - and now it seems that there
> is some buggy behavior about that.

Hmph, is this the same issue as what we discussed in

https://lore.kernel.org/git/CA+dzEBmh4LdN-XFS9y9YKrDMzV_7+QpDzBA2uv9Xi80P=
gR5NTQ@mail.gmail.com/

I wonder.
