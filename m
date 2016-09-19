Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9C2A2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 17:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752040AbcISRpd (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 13:45:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50507 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751443AbcISRpd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 13:45:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98DF73F391;
        Mon, 19 Sep 2016 13:45:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lxUJbt+J9GZ4D6HRYAn8ohqXLRI=; b=jNhmmN
        j/91AOeI+SsxzG8OFelTLuZvRaofJ8ufDbeOjI/SDtKmobYdwSsyj6+1oAODg2/e
        7YXtoGiBR4+FwQWgw1gllYXb8xdZnU4QbRbQ4FpdNtyq9pN0q66xib7jMXiXltw5
        5ibINO9/fuxf3J0rtO5+4k9n1k6ELQ4+tO6AE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N1hVSPZ+uq4/R8smkVpQYkPotpqSmzcZ
        kqVa/SqUTxUy6uLDakDW4HRtCBGufQmVeFDYwSZvMzi7LLVOjEQPT4q4i9FpPXc+
        0gVUyeVzg/9QH7a3Y8QPQ2gE271XM34S39sIjIljkLpjqNGfUR5QjFQovUlQescW
        5EnVPFpokxs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 912F83F390;
        Mon, 19 Sep 2016 13:45:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0AA813F38E;
        Mon, 19 Sep 2016 13:45:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Cuillery <nicolas.cuillery@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [Bug] Custom git-dir directory shouldn't be listed as
 =?utf-8?B?4oCcdW50cmFja2Vk4oCd?=
References: <CACmQg1hE=ytaatDfUJLkhL0p5c43wZZvgt+8pc5zoo0YFdQw6A@mail.gmail.com>
Date:   Mon, 19 Sep 2016 10:45:29 -0700
In-Reply-To: <CACmQg1hE=ytaatDfUJLkhL0p5c43wZZvgt+8pc5zoo0YFdQw6A@mail.gmail.com>
        (Nicolas Cuillery's message of "Mon, 19 Sep 2016 16:26:42 +0200")
Message-ID: <xmqqeg4fg4w6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBDE851E-7E90-11E6-8C85-5D827B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Cuillery <nicolas.cuillery@gmail.com> writes:

> When using the default directory ".git", it logically doesn't appear
> in the "git status" command's output. Don't you think it should be the
> same when using a custom dir name ?

Not really.

GIT_DIR=<there> mechanism was never meant to be used to name a
directory that sitsinside your working tree (an exception is if it
is actually ".git" at the top).
