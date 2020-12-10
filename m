Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42C5C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 18:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A152823DE3
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 18:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393110AbgLJSef (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 13:34:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60934 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393076AbgLJSe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 13:34:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8CD54117F22;
        Thu, 10 Dec 2020 13:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NwJGpjCrn1n5JSbsXafiF1+Uf2s=; b=Vvwhol
        PawWBRP500njKe3SA6pJL0nF6cuGFijpUXZyI+bdnN2obR/y+1DWeLL6F0HtkcjK
        wgGmO0mAZY7Yxjo2Njm1+YVOlowGVsnJ2uDAt7m5LfHcQ0l/7VifqZ/qcHyClT47
        VMBP1VgbBJUindkH4EjMxKo4yFFbHBd+DVP3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mwM/uw6Y5Zfh9y/hUsge4pu3EQhZYtjS
        sOV+wjfbsulWd/EQZUf1sqdSiEtSI/4SggcLZkyhutfTpIv1p8He5F+eMnMxVpw7
        DloWO8W4cUwcRm2wERQSmoZ+johQ7MHqtZgqK0MLlynMIA3Ti2kC+GRjPFwTJ0Mh
        z/lckJoorBM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 85157117F21;
        Thu, 10 Dec 2020 13:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 56F81117F20;
        Thu, 10 Dec 2020 13:33:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/init-defaultbranch-advice, was Re: What's cooking in git.git
 (Dec 2020, #01; Tue, 8)
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012091510280.25979@tvgsbejvaqbjf.bet>
        <xmqqft4e1w2j.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012100540220.25979@tvgsbejvaqbjf.bet>
Date:   Thu, 10 Dec 2020 10:33:38 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2012100540220.25979@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Thu, 10 Dec 2020 05:54:09 +0100
        (CET)")
Message-ID: <xmqqeejxwlx9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 396D4E2C-3B16-11EB-8830-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 9 Dec 2020, Junio C Hamano wrote:
>
>> Anyway, I do not think those users who said "I'm fine with it" would be
>> fine when the switchover happens outside their control.
>
> As of September 29th, Git for Windows' installer asks users to specify
> their preferences:
>
> 	Adjusting the name of the initial branch in new repositories
>
> 	What would you like Git to name the initial branch after
> 	"git init"?
>
> 	[ ] Let Git decide
>
> 	    Let Git use its default branch name (currently: "master")
> 	    for the initial branch in newly created repositories.
> 	    The Git project intends to change this default to a more
> 	    inclusive name in the near future.
>
> 	[ ] Override the default branch name for new repositories
>
> 	    NEW! Many teams already renamed their default branches;
> 	    common choices are "main", "trunk" and "development".
> 	    Specify the name "git init" should use for the initial
> 	    branch:
>
> 	    __________________________
>
> Obviously, I have no idea how many users chose the first option because we
> do not collect any usage data in the Git for Windows project. However,
> anecdotal data suggests that most users go with the first one, not caring
> one iota and simply going with what Git decides for them.

Even if you knew the numbers, it would not give us much useful
information (besides, I do not think you give these checkboxes
randomized to suppress bias), I am afraid.  The users haven't
experienced the real impact of letting Git decide yet, and do not
have enough information to assess their future grief before making
the choice between the two.

But I do not strongly care---I certainly care about this even less
than I care about keeping the differences between Git and its
Windows port smaller.

