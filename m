Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5FD41F404
	for <e@80x24.org>; Fri, 19 Jan 2018 18:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755981AbeASSfB (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 13:35:01 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65534 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755830AbeASSfA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 13:35:00 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B7E1BCE4F;
        Fri, 19 Jan 2018 13:34:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ojlL8wjJyqzyQTypNAkYcjm9CiE=; b=NmGwhy
        bvo101VwGHvXg5SToLCHwXcOEZQsbjkoT2axNbQDiqeeiWpBaE6faiC8oZE5lNMr
        4TqkCYIWpOz6+9btdlbyq/QN6GQnZHhPf8O/MGPf0ZFETecDkcP2xljJ3NJPo7x6
        +Qz8h+D8q19heO2nG1XrKQzSMn4crMYdQ7SGE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QMcjv2o2lvfgxPwd/sP3DRgoDEDmtWyq
        Q6z6r6xXZpvENwv1v033dZFOn6ndqx6zCt7EbbIzRk1jVVjF15SO89WEl2bnB0Sv
        T4gq4pbr3lf5ithrQkM+GZ5HKnwRTJqRry6wkET7DDMFgJmzKs1mwJ+n9sUOEVtr
        9qrTAW7pMn4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52EEBBCE4E;
        Fri, 19 Jan 2018 13:34:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9627BCE4D;
        Fri, 19 Jan 2018 13:34:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 0/3] fixes for split index mode
References: <20171217225122.28941-1-t.gummerer@gmail.com>
        <20180107223015.17720-1-t.gummerer@gmail.com>
        <20180118215331.GN2641@hank>
Date:   Fri, 19 Jan 2018 10:34:57 -0800
In-Reply-To: <20180118215331.GN2641@hank> (Thomas Gummerer's message of "Thu,
        18 Jan 2018 21:53:31 +0000")
Message-ID: <xmqqbmhpr92m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73F9D91C-FD47-11E7-A927-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Friendly ping on this series now that 2.16 is out :) Is there anything
> in this series (up to 3/3, 4/3 can be dropped now that Duy fixed it in
> a nicer way) that still needs updating?  It fixes a few bugs in split
> index mode with submodules/worktrees, so it would be nice to get this
> reviewed/merged.

I was wondering about the same thing.  Especially it wasn't very
clear to me what Duy's replacement was meant to replace and how well
it was supposed to work with the rest of your series.

Let's drop 4/3 and queue 1-3/3 for now.
