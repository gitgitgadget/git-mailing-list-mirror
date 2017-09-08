Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0745A20286
	for <e@80x24.org>; Fri,  8 Sep 2017 01:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbdIHBS2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Sep 2017 21:18:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56591 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750966AbdIHBS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2017 21:18:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DEA5AE7DF;
        Thu,  7 Sep 2017 21:18:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BsgE8Y8PIcVZCt/sfZ1QZZwFi/g=; b=c7zksE
        Km+yVhoam2gf+gky+IXwu1GGOxLgKTtwTxehJX4bgVn89KvqmH4hxmkghtBcmEBd
        LcSr1fYpBNKBgCozNAeyTX57CwEx3e+owAwNc0EGEINILQGgLgKw3wkqCONPGLHx
        OEdNKiUC1jXGVCF/ZS0NmxsOHOJ83GmKv+T4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rfO/UdQumJsISNhHCN3swuwKB/ME2NBq
        Qb7ubCmTmgIT4LwQfI/n5Z+W6JEAhwA2SzAu1zJtTkgRe14b5T4ygRpydLrDVzzE
        +a8t7rnvs/1La06GMDH+xBtxuAeATKaYDFJeD+LK6uh2RlNqDwLOKyUbSnZtBHGp
        uTHPKggCs88=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 543B2AE7DE;
        Thu,  7 Sep 2017 21:18:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AF2EFAE7DD;
        Thu,  7 Sep 2017 21:18:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrew Ardill <andrew.ardill@gmail.com>
Cc:     =?utf-8?B?5aSP5aSn6Zuo?= <xia.jason23@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Branch name support & character
References: <CA+zMtjmhrE54=ke6vVDGOcrbHkdPuE-Gf5cwQEp8LL2h+xen0g@mail.gmail.com>
        <CAH5451m9asxzaOEzQ2Jjk9Ly97GVnb7DV0uZS=96B=yHCYLWCw@mail.gmail.com>
Date:   Fri, 08 Sep 2017 10:18:25 +0900
In-Reply-To: <CAH5451m9asxzaOEzQ2Jjk9Ly97GVnb7DV0uZS=96B=yHCYLWCw@mail.gmail.com>
        (Andrew Ardill's message of "Thu, 7 Sep 2017 15:31:33 +1000")
Message-ID: <xmqqk21a0yzi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9DA759B0-9433-11E7-9FC3-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrew Ardill <andrew.ardill@gmail.com> writes:

> Using git checkout -b 'my&branch' works for me (single quotes around
> the branch name).
>
> Pushing to a local remote also works: git push --set-upstream
> ../git-test-2 'my&branch'

Thanks for sanity-checking.  I was wondering if we have codepaths
that botch quoting (we shouldn't, and if there is, we should fix
it).

>
> That being said, I would advise not using & in branch names,
> specifically because it is a special character in shells.

Good advice.

