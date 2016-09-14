Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715581FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 22:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933422AbcINWa7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 18:30:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63436 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933367AbcINWa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 18:30:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 176453E318;
        Wed, 14 Sep 2016 18:30:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZVKewXpf10TnKeB1AhNqTJTICGc=; b=AxaTqc
        KtvDOEAZXt3n4ImVxv6yYbkNv/ushx4tkN+1cdExLFd+XvX/lpYplVQRo7cu4b+U
        txL3Wm9pj74AU5Ew89aU3f1qyNZ78WwZ4aV+qkSnKrkcPwvtzXU0DrkR4UNuTiuT
        e8/ZJywKk3t76FlzwwB4BIyvrwsz38OK8GcLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yEzjR07NkQ6OV1lhMzV6QQ3HTs2DWfF3
        kHTzIG7ahiRydsUrJxSToXwSqfmhe6uY9UjKgN1OVliny+PmZjE7+hAlS3eE3b/g
        yaL5j+PuR+OUAmwHRKxldSSADXuRJCJ9VkKZbW49D1ode4k0CYMRja/ppEXXAXx7
        9Nr3WXv8IXE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F68D3E317;
        Wed, 14 Sep 2016 18:30:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B85D3E316;
        Wed, 14 Sep 2016 18:30:56 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 1/2] serialize collection of changed submodules
References: <20160824173017.24782-1-sbeller@google.com>
        <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
        <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
        <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
        <20160914173124.GA7613@sandbox>
Date:   Wed, 14 Sep 2016 15:30:53 -0700
In-Reply-To: <20160914173124.GA7613@sandbox> (Heiko Voigt's message of "Wed,
        14 Sep 2016 19:31:24 +0200")
Message-ID: <xmqqwpiep10i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E750757A-7ACA-11E6-A23E-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Sorry about the late reply. I was not able to process emails until now.
> Here are two patches that should help to improve the situation and batch
> up some processing. This one is for repositories with submodules, so
> that they do not iterate over the same submodule twice with the same
> hash.
>
> The second one will be the one people without submodules are interested
> in.

Thanks.  Will take a look at later as I'm already deep in today's
integration cycle.  Very much appreciated.
