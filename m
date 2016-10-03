Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D3F1207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752072AbcJCU7A (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:59:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58826 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751500AbcJCU67 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:58:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 066FB43DDF;
        Mon,  3 Oct 2016 16:58:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uuuf8gFBLR5uVWznY2BRJH/gbJA=; b=js5Wkw
        rMv18Hck5T5XW0L99ofoRUM0mVu1Uzk7MDAqzYv4CpOsphr0WtFRNphMwdxVFp6v
        EuP+T9akV+FhW8TcrsMR2XvouoMNTgkk1jBgNpykEHqutQ6bhSKH8wsCruY0ipxt
        0uMCLrV46Fo/xsraIJuLyfHOrHRGOZ348RZU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oqXz1OmTctrpSjjMByL0AXLn7cJzgsA5
        txEvo2UMVNIZLQOaJNCgtMDVelZMe+64HT+HBsJNj5mQAhg+Ebp26Ah3LPKCoecY
        B0Z66O9GTbhjbENE4qw+uNBMtxOy3Sjfy97V54iOUyb+9PmkYW7KTrN8eGuKGU7A
        va3P53iikBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F053843DDE;
        Mon,  3 Oct 2016 16:58:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 703FC43DDD;
        Mon,  3 Oct 2016 16:58:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH v3 0/5] Add --format to tag verification
References: <20160930221806.3398-1-santiago@nyu.edu>
        <xmqqlgy97ys0.fsf@gitster.mtv.corp.google.com>
        <20161003144901.4yainza537g5bujz@LykOS.localdomain>
Date:   Mon, 03 Oct 2016 13:58:55 -0700
In-Reply-To: <20161003144901.4yainza537g5bujz@LykOS.localdomain> (Santiago
        Torres's message of "Mon, 3 Oct 2016 10:49:03 -0400")
Message-ID: <xmqqshsd5euo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33A771A4-89AC-11E6-A7D4-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Santiago Torres <santiago@nyu.edu> writes:

> Hi, Junio. 
>> I however notice that there is no new tests to protect these two new
>> features from future breakages.  Perhaps you want to add some in
>> [6/5]?
>
> I'll be working on this. I spent some time looking around for example
> tests for format. Are there any that I should pay special attention to?
> (I'm looking at t7004 mostly right now).

By the way, running t7030 seems to reveal a segfault introduced by
this 5-patch series.
