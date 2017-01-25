Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F411F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 18:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbdAYSKS (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:10:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63263 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751589AbdAYSKR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:10:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E81DB6130A;
        Wed, 25 Jan 2017 13:10:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=irUY+9tsx8uEsAutUlrke4i3jz0=; b=ltrnmu
        Ndvx4q78mPhH+uB5AmftImSQQKbZc4ez3geyyYYM8nVsWR6lKtyqUOTCB+vAGEb/
        JUSWU23wgAcc8r8sYXag6ZzrEoJYlKqYc8ZqVqTJ4HL9QlTGmYWZ9jhgWEmBXcFy
        JtoapxUcrSHKWJQjXachGe3laDoPcyB4HpA6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IrAa6AWnmiAhVyo4yS3y9jhs70mN9m/S
        MRa4sV/8w0UJWuxipQA85b11eBnOLv76NxERa6KkoqB6yXpUoAuS6IYyyjb9Wl6U
        RpH1LxJXsnZ2Gp3qE+9p0GBa5ZZQOcIpBNeKE+7erHsfBVpaqzxuY3oZavdeeIVB
        SbH4Q/7CzcQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF1D661309;
        Wed, 25 Jan 2017 13:10:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C6E461308;
        Wed, 25 Jan 2017 13:10:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     cornelius.weig@tngtech.com, git@vger.kernel.org,
        novalis@novalis.org, pclouds@gmail.com
Subject: Re: [PATCH] tag: add tag.createReflog option
References: <20170125001906.13916-1-cornelius.weig@tngtech.com>
        <20170125180054.7mioop2o6uvqloyt@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 10:10:13 -0800
In-Reply-To: <20170125180054.7mioop2o6uvqloyt@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 25 Jan 2017 13:00:54 -0500")
Message-ID: <xmqq8tpzc8oq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 855D44FC-E329-11E6-B8E2-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I made a lot of suppositions about your desires there, so maybe you
> really do want just tag.createReflog. But "core.logallrefupdates =
> always" sounds a lot more useful to me.

Thanks for saving me from typing exactly the same thing ;-)
