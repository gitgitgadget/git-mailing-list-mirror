Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415AE202A2
	for <e@80x24.org>; Sat, 21 Oct 2017 01:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbdJUBd0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 21:33:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57474 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753065AbdJUBdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 21:33:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D99CB288D;
        Fri, 20 Oct 2017 21:33:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YHgK/sVP3rANKW6nU+u+GAyReDE=; b=Ecr0//
        MvnEaUsbd4PCry3Vq9qlv0JeJNFWVhYaGAkMcdyz1uUUJaIyjhkfRogzea4KHrzn
        XBscoeAgpbX8QFLF5fSETeVwMHY7SapqdiN45FsZrX0pLwsN0p4X6yVK6Wub31Ho
        /YO5dgqlVZUzQ8FPDxFke42xux8s+lnIjhsag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kTg7Sq9Yk5IHbMXRF1ls6nF6F7Bhutjh
        PMYaRNgmZX8jmc3amdnMMPicBgQ0+EfR6FOU33vi6lRqR7yx2rDBMtPWDKmVGDvs
        n/Z0cX3vBIJDlV2ecWP9DxKKx+YdGhZTThvEOT8wgzgnQLSsaoGl5OY+jVsF8p3v
        TR6UfV+bYLY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 891B5B288C;
        Fri, 20 Oct 2017 21:33:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD57CB288B;
        Fri, 20 Oct 2017 21:33:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marius Paliga <marius.paliga@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Thais Diniz <thais.dinizbraz@gmail.com>
Subject: Re: [PATCH] builtin/push.c: add push.pushOption config
References: <xmqqmv4pl117.fsf@gitster.mtv.corp.google.com>
        <20171019174715.6577-1-marius.paliga@gmail.com>
        <CAGZ79kaSU+w0=zb61=5pEzhtd4U5Hzae4C2bUgpchNHAL_mzMA@mail.gmail.com>
        <xmqqbml2imrj.fsf@gitster.mtv.corp.google.com>
        <xmqq376eibrw.fsf@gitster.mtv.corp.google.com>
        <xmqqy3o6gx4z.fsf@gitster.mtv.corp.google.com>
        <CAK7vU=0m6qyFrPb9E7HY79v0Vxwn+So3gyhxJZBPVD1t7vX35A@mail.gmail.com>
Date:   Sat, 21 Oct 2017 10:33:22 +0900
In-Reply-To: <CAK7vU=0m6qyFrPb9E7HY79v0Vxwn+So3gyhxJZBPVD1t7vX35A@mail.gmail.com>
        (Marius Paliga's message of "Fri, 20 Oct 2017 10:52:25 +0200")
Message-ID: <xmqqlgk5gu8t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4385CF2-B5FF-11E7-8B6E-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marius Paliga <marius.paliga@gmail.com> writes:

> Should we also mention that this option can take multiple values from
> the command line?
>
> -o <option>::
> --push-option=<option>::
>         Transmit the given string to the server, which passes them to
>         the pre-receive as well as the post-receive hook. The given string
>         must not contain a NUL or LF character.
> +       Multiple `--push-option=<option>` are allowed on the command line.
>        When no `--push-option=<option>` is given from the command
>         line, the values of configuration variable `push.pushOption`
>         are used instead.

My first reaction was "Do we do that for other options that can be
given multiple times?  If not, perhaps this is not needed."

Then my second reaction was "Do we have that many options that can
be given multiple times in the first place?  If not, perhaps a
change like this to highlight these oddball options may not be a bad
idea."

And my third reaction was "Well, even if we have many such options,
and even if most of them are not explicitly marked as usable
multiple times in the current documentation, that's not a reason to
keep it that way---the readers ought to be able to find out which
ones can be used multiple times and how these multiple instances
interact with each other, because the usual rule for single-instance
options is 'the last one wins' (e.g. 'git status -uall -uno' should
be the same as 'git status -uno') but to these multi-value options
that rule does not hold".

So, yes, I think it is a good idea.

But it opens a tangent #leftoverbits.  Among the most commonly used
commands listed in "git --help", there indeed are some commands that
take multiple options of the same kind (even if we do not count an
obvious exception "--verbose", which everybody understands as the
number of times it is given indicates the verbosity level).
Somebody needs to go over their documentation and add "this can be
given multiple times from the command line, and here is what happens
to them".

In your suggestion for "push -o <value1> -o <value2>", "here is what
happens" is missing.  Perhaps

	When multiple `--push-option=<option>` are given, they are
	all sent to the other side in the order listed on the
	command line.

or something like that.

Thanks.
