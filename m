Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F94D207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 23:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935015AbcI2XNn (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 19:13:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51203 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934570AbcI2XNm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 19:13:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A030341A6F;
        Thu, 29 Sep 2016 19:13:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OkICI17hzogVqeK2lqNuR2tGK9E=; b=mGKyp1
        5RaW2gOaTKfYbXn3oFbyanLlyFOa1gd0Assz5fyuemL60uCxTp71k6gbeSEZFEyB
        0gp7AuprZUjQzuqi1vbRz4HQNFi2w8fkwVSMY8Ndkna7tA3SAE8yeVu0FlGRp4eP
        ConD/aQeJsVMqK+eqBs2g+iI/zly46tgybDmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xzaSJB+F80hwqkcCNEuGCKWbhEjk0EYF
        4BfV05LkbRKT/vP3uVQ9GIK5Mkgeo0a+9BiTqpIRkB49PsuH75vSPltX8jJtDeKe
        PBQ4J/g2rAxLqt/Ir2kFv8zH+JwrOek78qTKRysh1x0h4/j+Ft4LjcliotzAhhwV
        kPm60dM+UXA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96ABC41A6D;
        Thu, 29 Sep 2016 19:13:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D22B41A6C;
        Thu, 29 Sep 2016 19:13:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
        <20160928233047.14313-1-gitster@pobox.com>
        <20160928233047.14313-5-gitster@pobox.com>
        <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org>
        <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
        <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
        <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
        <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
        <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
Date:   Thu, 29 Sep 2016 16:13:38 -0700
In-Reply-To: <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 29 Sep 2016 14:53:41 -0700")
Message-ID: <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B9A1A3C-869A-11E6-91C9-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Somebody should really double-check my heuristics, to see that I did
> the pack counting etc right.  It doesn't do alternate loose file
> counting at all, and maybe it could matter.  The advantage of the
> previous patch was that it got the object counting right almost
> automatically, this actually has its own new object counting code and
> maybe I screwed it up.

One thing that worries me is if we are ready to start accessing the
object store in all codepaths when we ask for DEFAULT_ABBREV.  The
worries are twofold:

 (1) Do we do the right thing if object store is not available to
     us?  Some commands can be run outside repository, and if our
     call to prepare_packed_git() or loose object iteration barfed
     in some way, that would introduce a regression.

 (2) Is calling prepare_packed_git() too early interfere with how
     the commands expect its own prepare_packed_git() work?  That
     is, if a command has this sequence, "ask DEFAULT_ABBREV,
     arrange things, and then call prepare_packed_git()", and the
     existing "arrange things" step had something that causes a new
     pack to become eligible to be read by prepare_packed_git(),
     like adding to the list of alternate object stores, its own
     prepare_packed_git() will now become a no-op.

I browsed through "tig grep DEFAULT_ABBREV \*.c" and it seems that
in majority of the hits, we not just are ready to start accessing,
but already have an object or two, which must have come from an
already open object store, so they are OK.  Especially the ones that
use it as the last argument to find_unique_abbrev() are OK as we are
about to open the object store to do the computation.

There are very early ones in the program startup sequence in the
following functions, but I do not think of a reason why our new and
early call to prepare_packed_git() might be problematic, given that
all of them require us to have an access to the repository (i.e.
this change cannot introduce a regression where a command used to
work outside a repository but barf when prepare_packed_git() is
called early):

 - builtin/describe.c
 - builtin/rev-list.c
 - builtin/rev-parse.c

I thought that the one in diff.c might be problematic when the "git
diff" command is run outside a repository with the "--no-index"
option, but it appears that init_default_abbrev() seems to be OK
when run outside a repository.

There is one in parse-options-cb.c that is used to parse the --abbrev
command line option.  This might cause a cosmetic problem but when
the user is asking for an abbreviation, it is expected that we will
have an access to the object store anyway, so it may be OK.

I am sorry that none of the above is about your math ;-)  I suck at
math so I won't comment.

