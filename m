Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2D972036D
	for <e@80x24.org>; Sat, 25 Nov 2017 03:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbdKYDCc (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 22:02:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51202 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751413AbdKYDCb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 22:02:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8495FC3462;
        Fri, 24 Nov 2017 22:02:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wmdey9m30kYiy+rBWl9q0ZJGQME=; b=HEpebu
        FuJdVTZK7bWYP3jSo9MGsGdmMwxcb2uNC14DsCS/bLA/p5uatuaXqndws1ooRzMP
        lUXPCHBeUCK2i99orNB5QpSSSCNnKmx2n+WUJgZ91KlvTOn8NoUlQ+WaQ5cxTVDy
        3u97B+/Q1NIHl01RxMZjHnWQtGp7MkeI0Sx90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=p7Q2P2PFkBclt9En4AHXCEQ/tPFvmHk0
        TdvZDG3jX6+wHXyaL8hNGWefYjFvFd4r5QKwrg1AFy0jjpL30kx+4sRAhrz+p/Ny
        InZJCZ4+tBhbc+NigI1h1W4sHhFbV1pFIW/jNAqXF+teGf0eCdRT2gXow7YWvekz
        M3UYsIi6U0o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CDC6C3461;
        Fri, 24 Nov 2017 22:02:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F41ADC3460;
        Fri, 24 Nov 2017 22:02:29 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kevin Daudt <me@ikke.info>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
        <20171121214552.GB16418@alpha.vpn.ikke.info>
        <20171123000346.GA8718@sigill>
        <alpine.LFD.2.21.1711230241260.11944@localhost.localdomain>
        <20171123135155.GA8231@sigill>
        <20171123205503.GE16418@alpha.vpn.ikke.info>
        <20171124181254.GC29190@sigill>
Date:   Sat, 25 Nov 2017 12:02:28 +0900
In-Reply-To: <20171124181254.GC29190@sigill> (Jeff King's message of "Fri, 24
        Nov 2017 13:12:54 -0500")
Message-ID: <xmqqpo87kqm3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13297F56-D18D-11E7-9440-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There is an open question of how carefully we want to document it, but I
> think the strategy so far has been:
>
>  - if you want to be careful, use "--"
>
>  - if you don't, git will use black magic to guess, but that magic is
>    subject to change, so don't rely on it
>
> I don't mind documenting the current magic as long as the "don't rely on
> it" part is made clear.

Yes, taken with "git log master" example where if we want to say
"this truly cannot be ambiguous" and end up digging "git log HEAD --"
to ensure there is no path that match 'master' ever existed, I would
prefer not to say a lot more about "black magic" and yet still going
into the precise details.

On the other hand, of course we do not want to cast in stone the
precise details of the current "black magic" implementation that is
subject to change.

A description of "black magic" that is without details, i.e. the one
that focuses on the spirit and not the exact design, would be...

    Without "--", Git tries to find a point between two arguments on
    (or at the beginning or the end of) the command line, where
    every argument before it are likely to be a revision (and
    unlikely to be a path) and every argument after it are likely to
    be a path (and unlikely to be a revision) with "black magic".
    If there is no such point, you'd be asked to disambiguate.

    The "black magic" would use 4 combinations that results from
    two tests.  

    A. Is it likely to be a revision (yes/no)?
    B. Is it likely to be a path (yes/no)?

    If both are true, it is am ambigous command line.  If neither is
    true, it is likely a typo (e.g. "git log naster" when the user
    meant 'master', or "git log Nakefile" when the user meant
    'Makefile').  If only one is true, Git thinks that the command
    line is unambigous and goes ahead with its decision.

    Git will not spend excess amount of cycles to make these two
    tests, so there can be misidentification.  Two easy to
    understand examples are:

    - If you have a file 'naster' in your working tree and said "git
      log naster", test A _could_ notice that there is a slightly
      different name 'master' that could be a revision that you
      meant, and ask you to disambiguate in case you made a typo.
      Because test A (deliberately) is not overly thorough, Git does
      not flag it as a possible ambiguity.

    - If you had a file whose name is "Nakefile" in HEAD but you
      just removed it, "git log Nakefile" may actually be a valid
      and unambigous request to use Nakefile as a path, but in order
      to notice that possibility, Git has to not just check if the
      working tree has such a path, but also in the index and HEAD
      (and if the removal was older, then it has to do an internal
      "git log" to see what paths ever existed in the past, which is
      ridiculous).  Because test B (deliberately) is not overly
      thorough, Git would refuse to use it as either a revision or a
      path without disambiguation.

