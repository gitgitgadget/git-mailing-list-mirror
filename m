Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 168AE20958
	for <e@80x24.org>; Mon, 20 Mar 2017 18:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbdCTS6A (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 14:58:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52031 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753246AbdCTS55 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 14:57:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9AA307B8C2;
        Mon, 20 Mar 2017 14:56:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zBJO1rWXf45EzeuosowY0QdjWfY=; b=i+97Um
        woN0uIRb7CdfHXe8Hxa0s4/4D/idXRQ5ORMSulLLNPZ4YvAiIFTRMddCx/Ghcaer
        xHkomCqj+p3qXsHsjJBcyP8YlvEfpb1mm3Xd+fLOFV2LIPaSZ6PUbYvEhDybN+tt
        wpCz2WNJbqPaW6zcJHjQek3biVuzO0n4XEQTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f+xTUN7uk1aSYKQ27kai6LNcAx0SiA/S
        0fEV1D2sBteiWtdUnAXyJEB5+SoiAJUH0UQXvz5OOZb0B+2w0OmlGPuPBr7nMpR7
        lzPTptoNamdgYNp6PwXHOZ/3s6hWnp00pZLK9Ck2xnUpbK/QiQIHlYle826/5Vgy
        Rvo/G62WteU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 933EB7B8C1;
        Mon, 20 Mar 2017 14:56:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5ED77B8C0;
        Mon, 20 Mar 2017 14:56:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Add configuration options for some commonly used command-line options
References: <CACsJy8Du+WWWkx3wqRJYA=cyTdro=OOD7GWaFi29=h1_9yC+LQ@mail.gmail.com>
        <vpqa88hlghm.fsf@anie.imag.fr>
        <20170319131845.tl6o3t2nwicj2rug@genre.crustytoothpaste.net>
        <CACBZZX4FksU6NujPZ_3GZ45EQ+KdJj5G2sajtRipE1wbaA3URA@mail.gmail.com>
        <CACsJy8CQzo9K8N3xH_HJq=NjJVOUG9wawC4Mg+UuyFRZCPBpFw@mail.gmail.com>
        <20170320173237.GA188475@google.com>
Date:   Mon, 20 Mar 2017 11:56:35 -0700
In-Reply-To: <20170320173237.GA188475@google.com> (Brandon Williams's message
        of "Mon, 20 Mar 2017 10:32:37 -0700")
Message-ID: <xmqq7f3jwzdo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1C3A592-0D9E-11E7-B656-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> If in the future we did want better support for making user defaults
> (apart from aliases) for commands we could entertain creating a command
> like bash's 'command' which ignores any user defaults and executes a
> particular command in a vanilla mode.
>
> So if the user configured 'git am' to always use the -3 option then
> running `git command am` (or something akin to that) would just run the
> vanilla 'am' command with no options.  Probably not the best idea since
> tooling would need to become aware of such a paradigm change, but its
> just a thought.

I do not think "command" is a good analogy.  In practice it is used
by those who want to create a wrapper that overrides a command for
her own use, e.g. "ls () { command ls -AF "$@" }", in her .bashrc.

I suspect that it is too cumbersome for script writers to use for
the purpose of protecting their scripts from random aliases that may
change the behaviour of the commands their scripts want to rely
on---they'll be forced to sprinkle practically each and every
invocations of the basic UNIX building blocks with "command".

The saving grace for shell scripts is that the shell has good way to
tell interactive and scripted use apart, by disabling aliases and
not reading some rc files for non-interactive shells.  Unfortunately
I do not think "git" has the luxury of using that "hint" as a command 
invoked by these shells.

One thing we may want to consider is why we have to even worry about
scripts getting broken.  It is because people script around
Porcelain, and that is because we have been too eager to improve
Porcelain while neglecting plumbing for too long, to the point that
some things are only doable with Porcelain (or doing the same with
plumbing while possible are made too cumbersome).  I find it quite
disturbing that nobody brought that up as an issue that needs to be
addressed in this entire thread.

