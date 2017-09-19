Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9B9C20281
	for <e@80x24.org>; Tue, 19 Sep 2017 03:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbdISDL2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 23:11:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57007 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750789AbdISDL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 23:11:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 46500AA70A;
        Mon, 18 Sep 2017 23:11:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mSKdty7BsXZcPAqQZIAR0DJYzgw=; b=a4qiGB
        CCYDKmM8eIRnRNvD6uBnbwUfP99Tw1Q/hVhJSqoshxzowWU8BmWVftmDhY/yIaXW
        OAqR45/qX6wErc6qOB6/mJMJMwOaWpeJPpv/Q9IN71NhzC8T5XfCSlSfB2j5vxUu
        nNZLCsMAch4pNyJ80I4vgJe8V5Xqq3Kg8PDhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=S3f7LVnhVmpj5ivEeKpbLchR9AQiOxXH
        5c8Itas4u5PvPT1TjsHamGNKIrmXdHsAYKg8wfJO2WVcZ5HFP62BpsYLMHAnRZ8g
        c0YS5oLVv17auWgQSH52epnYaBFY3rqxCGiRZAJ3FCEKBRHktpdEvYDvldAHPs96
        7+mtD3aBCIY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C767AA709;
        Mon, 18 Sep 2017 23:11:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75ED4AA707;
        Mon, 18 Sep 2017 23:11:26 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Shikher Verma <root@shikherverma.com>,
        Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] Add named reference to latest push cert
References: <20170906093913.21485-1-root@shikherverma.com>
        <CAGZ79kbxDh11KxrKCk_VjmN06kzp7x4iVO6XTV=a-qBmm39K5A@mail.gmail.com>
        <20170907091133.zygswf3f6z2bedfo@weakknees.security.iitk.ac.in>
        <CAGZ79kZO_u21JeAsNq7p7X88i0wmP6kJcg=JbKp62Bxdm4d4Uw@mail.gmail.com>
        <20170916072106.yxpwmndzif3lr2dp@weakknees.security.iitk.ac.in>
        <xmqqa81uumq6.fsf@gitster.mtv.corp.google.com>
        <20170918142205.r5kwkq7ouy5zxisz@LykOS.localdomain>
        <xmqqk20vsdmm.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 19 Sep 2017 12:11:25 +0900
In-Reply-To: <xmqqk20vsdmm.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 19 Sep 2017 10:04:01 +0900")
Message-ID: <xmqqtvzzqt5u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 394081B4-9CE8-11E7-9FAC-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> But the point is that we do not want such an overhead in core, as
> all of that is a useless waste of the cycle for a site that wants to
> store the push certificate away outside of the repository itself.

By this I do not mean that cert blobs shouldn't become part of the
in-repository record in _all_ installations that receive signed push
certificates.  An easy to reuse example shipped together with our
source would be a good thing, and an easy to enable sample hook may
even be better.  It's just that I do not want to have any "solution"
in the core part that everybody that wants to accept push certs must
run, if the "solution" is not something we can endorse as the best
current practice.  And I do not yet see how anything along the lines
of the patch that started this thread, or its extention by wrapping
them with commit chain, would become that "best current practice".

A sample hook, on the other hand, is simpler for people to experiment
and we might even come up with an unversally useful best current
prctice out of such an experiment, though.
