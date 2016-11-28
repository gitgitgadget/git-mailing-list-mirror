Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E75EE1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 19:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753379AbcK1T2A (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 14:28:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52931 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752340AbcK1T17 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 14:27:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CA9853921;
        Mon, 28 Nov 2016 14:27:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y8GN+UOvhpx535nl+9LUYXwWYp0=; b=doMXHF
        gJAbcuTF2F3Xzhi0geGnjdmQ5GgvhT8nFx5MVVL+G1YPDM6ntdOJLyyJCNY2d82L
        JD+uF/NjCG/R3Ua+Bo19rV8zcTajk6A99r9iyzP65sZQCPfClwVLJGz4NUKp92bK
        /42ILypyO8qbeTPIqrqiqPnIesz4NvriqEbes=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dQ3Mo1gkq90ma6ZqJvTUl30A7HcbemOz
        OEdFsG9QjL+I+P/z4p5iH0q9EzOYhmsQy8hq5Uz1fYDbSf7WBQaLT44ko8q2zrms
        WBaOMzVr+gir52tV+9aVBnnQu7Es7fErcF9t8uSoJrRhgF5f3R5sO6idNNnBJ2w9
        WplnijLrAJs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54E3653920;
        Mon, 28 Nov 2016 14:27:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D18065391E;
        Mon, 28 Nov 2016 14:27:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
References: <20161124210841.c4yi2nv57tjfejgj@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611242211450.117539@virtualbox>
        <20161125031809.mueurvjijlnzy2s5@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611251201580.117539@virtualbox>
        <20161125171940.rizbqyhsygdsoujr@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611251841030.117539@virtualbox>
        <20161125174721.f35mzc276kdwakzm@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611261320050.117539@virtualbox>
        <20161126161907.xol62zytn2jb45gh@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611261400300.117539@virtualbox>
        <20161127165058.uxujjehyjq7httro@sigill.intra.peff.net>
        <xmqqa8cjlekl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611281830040.117539@virtualbox>
Date:   Mon, 28 Nov 2016 11:27:56 -0800
In-Reply-To: <alpine.DEB.2.20.1611281830040.117539@virtualbox> (Johannes
        Schindelin's message of "Mon, 28 Nov 2016 18:34:17 +0100 (CET)")
Message-ID: <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C492BB40-B5A0-11E6-9AAD-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, I have been bitten time and again by problems that occurred only
> in production, our test suite (despite taking already waaaaaay too long to
> be truly useful in my daily development) was simply not good enough.
>
> So my plan was different: to let end users opt-in to test this new beast
> thoroughly, more thoroughly than any review would.

I agree with that 100%.  

We need to ensure "fallback to known working code" escape hatch is
robust for that plan to work well, and that is why (1) I have been
more focused on getting 1/2 right, and (2) I do not think it should
be Windows-only like in your early plan, and (3) I do not think it
would be "this will merely be there for only a month or so", like
you said earlier.

> And for that, environment variables are just not an option. I need
> something that can be configured in a portable application, so that the
> main Git for Windows installation is unaffected.

I am not sure I follow here.  

Are you saying that the users who are opting into the experiment
will keep two installations, one for daily use that avoids getting
hit by the experimental code and the other that is used for testing?
How are they switching between the two?  By using different %PATH%?
I am not sure how it is different from setting an environment
$GIT_TEST_BUILTIN_DIFFTOOL.

In any case, I do not have strong preference between environment and
configuration.  If you can make 1/2 robust with configuration, that
is just as well.  My message you are responding to was merely to
suggest another possibility.

The latter two points in my four-bullet list are hopefully still
viable if you go with the configuration; it may go something like:

 - The bulk of the tests is moved into a common dot-sourced file,
   with (1) PERL prerequite stripped and (2) "git difftool" replaced
   with $git_difftool

 - Two test files do one of

    git_difftool="git difftool"
    git_difftool="git -c difftool.useBuiltin=true difftool"

   and include the dot-sourced file.  The one that does the former
   needs to give up early depending on PERL prerequisite.

perhaps.

> My original "create a file in libexec/git-core/" was simple, did the job
> reliably, and worked also for testing.

It may have been OK for quick-and-dirty hack during development, but
I do not think it was good in anything released.
