Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5406206A4
	for <e@80x24.org>; Thu,  3 Nov 2016 02:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750764AbcKCCo5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 22:44:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60920 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750729AbcKCCo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 22:44:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E1624AF8E;
        Wed,  2 Nov 2016 22:44:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pZS9X4+4aDWe1gxUcJg83FhXylg=; b=auD2uq
        X8ZnYRJ9xw94bsXGFrcgNn6SVZ0VL6jIxXq/q+zMCG3+4fyfYgklPfkagF8Lj+O3
        xYI5wEt0ERcb776Yl5kfjs/yFj5x27YyzVwatHkx5kbysn9xXa6y4xkpEqN7RSUD
        OhwxuW+iKVwN1agmX3cB35KpVN0Cc25Cra6uA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QgHtpsnh2P7E0CmqnA9YTfLRNgvC3Kwt
        iHvbOPLTwllQndbhPYU1zrOf5V6Jv6TuUMnEiLfixX64202YV3MVcdT4kEJqF4wz
        j/Tvg8zJtsH9rdwSprXxibbVMWLMozUFvoTnlqVECrEIaIOM66E8x/6vIucEbMj+
        QaGn/MAA+0Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 040D84AF8D;
        Wed,  2 Nov 2016 22:44:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 752F94AF8A;
        Wed,  2 Nov 2016 22:44:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Blake Burkhart <bburky@bburky.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
        <20161103002225.GA13369@google.com>
Date:   Wed, 02 Nov 2016 19:44:53 -0700
In-Reply-To: <20161103002225.GA13369@google.com> (Jonathan Nieder's message of
        "Wed, 2 Nov 2016 17:22:25 -0700")
Message-ID: <xmqqtwbpe0yi.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80288A42-A16F-11E6-A881-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> That is, would it be possible to use something like
>
> 	[protocol "sso"]
> 		allow = always
>
> instead of
>
> 	[core]
> 		allowProtocol = file:git:http:https:....:sso
>
> ?

That sounds like quite a large usability improvement to me.

