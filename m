Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6BE202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 01:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbdJQBtw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 21:49:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58857 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752290AbdJQBtv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 21:49:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7463CAFA6B;
        Mon, 16 Oct 2017 21:49:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U7jNAP5ZmKJepFIoyBCnr2E+pAE=; b=wtKfT6
        8UfS6Dze2ieYLFuCs+BXMbJd7Iyx9DpzrQU1OJn5pDaC3+IqUKGyqRLZBHxhJNUv
        MxE4ACpJz4PainPrF+VYXWQSG1mSNAAKxQLNkc2Bj0uOcUKyVvpCZLecYgw1Otzu
        vW2VPVhe3dTb8AGkleET4MUbUq5XLyh3BajBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O/qWPJJS4UIcsrE9q9FJcii9MPuKLE2y
        iRDcreCk4rwFY7SicwcralLw9hkDTmNaAeHdnr+zjP8RtWKcxzvFrEFot2JlxFrW
        UyFpupVHqrDHAcs2An4LJMwjt1y6/C9/eV7M/IvYcyCk6Dbd/6vOJDswp94efoii
        ObJyYe78TfM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69720AFA6A;
        Mon, 16 Oct 2017 21:49:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFA5AAFA69;
        Mon, 16 Oct 2017 21:49:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     sbeller@google.com, jrnieder@gmail.com, Jens.Lehmann@web.de,
        bmwill@google.com, git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] implement fetching of moved submodules
References: <20171016135623.GA12756@book.hvoigt.net>
Date:   Tue, 17 Oct 2017 10:49:48 +0900
In-Reply-To: <20171016135623.GA12756@book.hvoigt.net> (Heiko Voigt's message
        of "Mon, 16 Oct 2017 15:56:23 +0200")
Message-ID: <xmqq7evur1ab.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 763C8B16-B2DD-11E7-A589-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> The previous RFC iteration can be found here:
>
> https://public-inbox.org/git/20171006222544.GA26642@sandbox/
>
> This should now be in a state ready for review for inclusion.
>
> The main difference from last iteration is that we now also support
> unconfigured gitlinks for push and fetch for backwards compatibility.
>
> To implement this compatibility we construct a default name for gitlinks
> if there is a repository found at their location in the worktree.

I do not remember the details of the patch in the previous round
that corresponds to PATCH 2/3 here, so I cannot comment on the
incremental improvement between the two, but the fallback in 2/3
looks like a sensible thing to do.

Let's see what others, especially those who are interested in the
"--recurse-submodules" area, say.

Thanks.
