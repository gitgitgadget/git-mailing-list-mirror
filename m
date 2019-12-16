Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16ADC43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 22:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98630207FF
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 22:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZHnS0Td0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfLPWTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:19:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63221 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfLPWTw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 17:19:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D3D83D04F;
        Mon, 16 Dec 2019 17:19:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7eVyBtT5vkRodmQzXmVY/54RfDA=; b=ZHnS0T
        d0ksXho5KQAdTOtWAEzdIRaj3ABI/8rvIKUmcIotCjWUp9Ao5yph9+y9lOlPNwJM
        Z6U/cArt8YWva8G9YmCnkg8VW+OnMbRKgrCmdEVKyK2qxMcVkAMprsiIxrnmNYnB
        JJB7nd5JTUveantPCsVOdJjUWA7m6uBxZIxcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lZaNAhfRZYIxVTa45lvUYasU9OAPGKkg
        Au8r/VFYXE+wYXDbjw/rxopiltiPWtULQGXy6WsBxTIgLW11Q3avO3kq9tQpoOf/
        NGzl+ZNt+VNdbUgsvSX2SrsDwxx2MBAXfWbftWLKk3q4McYMKN0U7gxYYqP6DUaQ
        RWfN+SVxFUM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 33D0B3D04E;
        Mon, 16 Dec 2019 17:19:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 90C573D04C;
        Mon, 16 Dec 2019 17:19:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 02/15] help: move list_config_help to builtin/help
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-3-emilyshaffer@google.com>
        <xmqqv9qkhrtd.fsf@gitster-ct.c.googlers.com>
        <20191216213625.GE135450@google.com>
Date:   Mon, 16 Dec 2019 14:19:48 -0800
In-Reply-To: <20191216213625.GE135450@google.com> (Emily Shaffer's message of
        "Mon, 16 Dec 2019 13:36:25 -0800")
Message-ID: <xmqqv9qfj4l7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C9C5C18-2052-11EA-BDD7-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> OK.  Looks like a clean-up that is very worthy even without the
>> remainder of the topic.
>> 
>> Thanks.
>
> Ok. Are you going to take it on its own?

Not really.  Unless you abandon the rest of the topic, in which case
it may be worth resurrecting this one on its own, that is.  But that
is not what you plan to do anyway, so I expect to see it as part of
an updated series ;-)
