Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 830C41F463
	for <e@80x24.org>; Sat, 28 Sep 2019 03:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfI1D4e (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 23:56:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54206 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfI1D4e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 23:56:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7FA232D9B;
        Fri, 27 Sep 2019 23:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GqnHcOCwAzN/wiRxP6znuPOt8b4=; b=RHchr0
        14d+bm4sj3N5EHgSkJfmBKfopI3OIhrwn9tvR7/7N3Fwq3yseIcmp5s/07qhdxLX
        KXiGRFxib6sdx47rpUk3YzQlgNQ3LBNbXx2gd5yeRZgNQ/FlyBIWdyGXjhf2dr+5
        X+MJI+TB26wnYZbOpSRJ819x0rH9btjHjjeTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=At1Ku1MXN1BCMsLWuhtP+4L6BcYAIi1F
        0yWr8LfMpYwaGz/0Y7qQYs7i/VU4X25UkY9bNb24pMeOUAPkgCP5vNasmmy+OTFN
        NnhReIhWvV34pz1cHwepLGvusuKQnBCOfyxlaCYeLm+ALoS4csevNOIhVfJwqNUv
        RBxfyrQugnc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CDAAA32D9A;
        Fri, 27 Sep 2019 23:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E1BC32D98;
        Fri, 27 Sep 2019 23:56:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
References: <20190827051756.GA12795@sigill.intra.peff.net>
        <20190913200317.68440-1-jonathantanmy@google.com>
        <20190913205148.GA8799@sigill.intra.peff.net>
        <20190916184208.GB17913@google.com>
        <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
        <20190923180751.GA21344@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1909241624300.15067@tvgsbejvaqbjf.bet>
        <20190924153316.GA1801@sigill.intra.peff.net>
Date:   Sat, 28 Sep 2019 12:56:29 +0900
In-Reply-To: <20190924153316.GA1801@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 24 Sep 2019 11:33:17 -0400")
Message-ID: <xmqqblv5kr9u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F4A8509C-E1A3-11E9-81E4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 24, 2019 at 04:25:45PM +0200, Johannes Schindelin wrote:
>
>> > I think it could make sense for merge-index to be able to directly run
>> > the merge-one-file code[1]. But I think we'd want to keep its ability to
>> > run an arbitrary script, and for people to call merge-one-file
>> > separately, since right now you can do:
>> >
>> >   git merge-index my-script
>> >
>> > and have "my-script" do some processing of its own, then hand off more
>> > work to merge-one-file.
>> 
>> Oh, sorry, I did not mean to say that we should do away with this at
>> all! Rather, I meant to say that `merge-index` could detect when it was
>> asked to run `git-merge-one-file` and re-route to internal code instead
>> of spawning a process. If any other script/program was specified, it
>> should be spawned off, just like it is done today.
>
> OK, great, then we are completely on the same page. :)

I wondered briefly if we want tospecial case the string
'git-merge-one-file' (iow, teaching merge-index a new option
"--use-builtin-merge-one-file" and update our own use in
git-merge-octopus.sh, git-merge-resolve.sh, etc. would be safer).

But "git merge-index git-merge-one-file" called in the context of
scrpted Porcelain has the directory that has *OUR*
git-merge-one-file as the first element on $PATH, I think, so it may
be perfectly safe to use the "ah, the command name we are asked to
run happens to be git-merge-one-file, so let's use the internal
version instead without spawning" short-cut.

