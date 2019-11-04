Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 352501F454
	for <e@80x24.org>; Mon,  4 Nov 2019 03:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfKDDV4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 22:21:56 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63700 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbfKDDV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 22:21:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DA94B3781E;
        Sun,  3 Nov 2019 22:21:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EbIeK9oosGaaHzvkkgVB4jG/mVo=; b=eRNYxh
        Qf0EEzE2ddaZze6+yHEAbImH9xY+HRhYlBdPAiZ6dHlttU4Y2JO38grmYFNMr5NJ
        k3qvP/6lQ75mxOWffRp0NO2jZTX9aSaIO6SbLF7WCrXvLtKqroQswuE5YL/kw0DY
        aeQUcdJRjN4ArfGQEzfbJ4syDZwUevGv5cvpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GG031ZgwsvyGbMv9GDRrvI/5kOw/WPNz
        TpPxm2fn+/w9D9WkVjfrXsj1+KmeQ/8QHLNkhNOpKTfN6VuVT93J5TI8c8UCkPeN
        xjJ/ODpVCXoN43Ra9d22mE3v0zfc0D0gxB6Mn7hsE+g68FpLTcdJs/FFuiN2twGm
        aoc1KDSeLRs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D0DCE3781D;
        Sun,  3 Nov 2019 22:21:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D6DB3781B;
        Sun,  3 Nov 2019 22:21:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git branch --edit-description a custom file
References: <20191030183950.GA21277@generichostname>
        <20191030202835.GB29013@sigill.intra.peff.net>
        <20191030224328.GB44961@generichostname>
        <20191031061832.GA20830@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1910311119080.46@tvgsbejvaqbjf.bet>
        <8b9021fa-f60c-a2e0-1174-a2fc1f11c476@gmail.com>
        <nycvar.QRO.7.76.6.1910311229150.46@tvgsbejvaqbjf.bet>
        <9aa1cefc-daeb-e702-95ba-1e83f8f7dcfe@iee.email>
        <20191031154217.GA30187@sigill.intra.peff.net>
Date:   Mon, 04 Nov 2019 12:21:52 +0900
In-Reply-To: <20191031154217.GA30187@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 31 Oct 2019 11:42:17 -0400")
Message-ID: <xmqqd0e81g33.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3F64D080-FEB2-11E9-93EB-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Do either of you use remote.pushDefault, branch.*.pushRemote, or
> @{push}?
>
> My triangular config for git.git looks like:
>
>   [remote "origin"]
> 	url = https://github.com/gitster/git.git
>   [remote "github"]
> 	url = https://github.com/peff/git.git
>   [remote]
> 	pushDefault = github
>   [branch "jk/foo"]
> 	remote = origin
> 	merge = refs/heads/master
>
> Then upstream comparisons, "git rebase" etc without arguments, do what I
> want: compare against master. And "git push" without arguments does what
> I want: push this branch to my fork. And if I need to refer to the
> pushed version for some reason (e.g., comparing what I just changed to
> what I last sent out, "git range-diff @{u} @{push} HEAD" does the right
> thing.

Yeah, I do recall we had quite a lot of design discussions around
"triangular" workflow when we introduced these facilities, and if I
am not mistaken, the above is the way they are designed to be used.

Thanks for an example.
