Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805E1202F2
	for <e@80x24.org>; Fri, 24 Nov 2017 01:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbdKXBBo (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 20:01:44 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56534 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751356AbdKXBBo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 20:01:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D301A8D31;
        Thu, 23 Nov 2017 20:01:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mWAKZt4oXDC75OgJsypGZQwyj+M=; b=CC7Co7
        hGb3agfMimXjAWKLN7rMH4zAp/37ft4ZLCxMx38xIiAdWY1Y2UmTZK6fnjUeYzSu
        r87bfoijVhom00U10fVUfNnQ4BsQNFP3MZmwYOmw/eSR/TwInZJTnNn/HqUE7KxA
        3jXmtm0+StZ7Wg/GsPQP1XaXHHYQnPi8/PfpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rwq5+R3MyN7f7diz5VB3bKVghOGH1QTg
        E1SErbNeiqyD+1mDNuaaH/hPKNT9BoUD0PAiIe7W6PNeQGbFFhiO3PAgsp9Yy3Q6
        G8ehDM/lOy0bPdiNdikVAdVDQ5JTLRDTLVh5T9kbA6cmXVMzswn+RMJp75BmEyl4
        plkrREsc5OM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72EDBA8D2F;
        Thu, 23 Nov 2017 20:01:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E82ACA8D2E;
        Thu, 23 Nov 2017 20:01:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Jeff King <peff@peff.net>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v2] gitcli: tweak "man gitcli" for clarity
References: <alpine.LFD.2.21.1711211626460.26166@localhost.localdomain>
        <20171121214552.GB16418@alpha.vpn.ikke.info>
        <20171123000346.GA8718@sigill>
        <alpine.LFD.2.21.1711230241260.11944@localhost.localdomain>
        <20171123135155.GA8231@sigill>
        <20171123205503.GE16418@alpha.vpn.ikke.info>
Date:   Fri, 24 Nov 2017 10:01:41 +0900
In-Reply-To: <20171123205503.GE16418@alpha.vpn.ikke.info> (Kevin Daudt's
        message of "Thu, 23 Nov 2017 21:55:03 +0100")
Message-ID: <xmqq7eugqykq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 092B7B56-D0B3-11E7-B6C2-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> Just for completeness, as it is somewhat covered by point 1 already, but
> there are cases where there is no real ambiguity but you are required to
> add '--' to tell git that it should not look for the file in the working
> tree:
>
>   $ git show abc123 deleted_file.txt
>   fatal: ambiguous argument 'deleted_file.txt':
>   unknown revision or path not in the working tree.
>   Use '--' to separate paths from revisions, like this:
>   'git <command> [<revision>...] -- [<file>...]'
>
> There might be good reasons why this is, but I don't consider this to be
> actually ambiguous: there is no branch called 'deleted_file.txt' and git
> could know that the files exists in the mentioned commit, so it should
> be pretty clear what is meant.

I know you understand all of this, but your "git could" needs to be
examined carefully.

The same can be said for "git log master deleted_file.txt" whose
intention is to refer to a file that the user _thinks_ existed once
in the past but may never have been there.

Surely, "git could" know if it runs "git log master" to the root of
the history to see if it ever existed.  Also, against "git log
master next deleted_file.txt", "git could" do the same traversal from
two tips of the history to check that.  But it requires us to do the
same work twice to materialize that "git could".

Actually the second example is a lot worse (and that is why I am
bringing it up).  If git does spend cycles to realize that "git
could", for consistency, it must also check if "next" is unambiguous
between a path or a rev, i.e. it must dig history from "master" and
see if "next" appears as a path ever in the history, and if so, die
with "ambiguous argument".

The message "unknown revision or path not in the working tree."
clearly shows why we decided to ask.  Even if deleted_file.txt could
have been a valid path somewhere in the history, "not in the working
tree" is the condition we check to see if it is unambiguous.  And we
stop and ask when it cannot be proven cheaply that it is not.

"git stops and asks when ambiguous" is a white lie to explain the
safety feature in a way that is easier to understand.  If somebody
wants to make the documentation more "technically correct", the
condition is not "when ambiguous", but "when git cannot prove it is
not unambiguous with inexpensive tests".

IIRC, I think Peff mentioned in this or nearby thread that we do not
want to spell out the implementation details and leave the exact
conditions vague on purpose, and that principle probably would apply
here, too.  We might later discover that checking not just the working
tree but also for the index to see if user meant by deleted_file.txt
a path and not a revision is not overly expensive, for example, and
at that point, we are still trying to prove that it is unambiguously
a path and not a rev with inexpensive tests.
