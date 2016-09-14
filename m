Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0FB1FCA9
	for <e@80x24.org>; Wed, 14 Sep 2016 15:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764214AbcINPsd (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 11:48:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55250 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1764107AbcINPsc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 11:48:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A9B343C8DA;
        Wed, 14 Sep 2016 11:48:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QhYrkImgJ99+Gkxj9Qzb0QTD5tw=; b=La2ZN3
        piXGIk+M3rVCHWNaHm63q9085ogdgBoDEkxEt97TWpUlcFBKcrM0+cu7LnwhuoDM
        7UOK1DIxfqOMqgvHSFhEjK8VrEKlwrT8IAM9zlhdjl29+UUy5uE6L8PxjLfJanOG
        zCE6kMcbvmHTzjrPz0z8XJaP6lBMLdK8gTCm4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rvtjFBy5h5FqdMAr/738APSZrZYc3EWQ
        WUo4EjAdEignVy4Y8O9WZfg+hV/m8escBAn17oY0tPREVRJEXp3AZNzv7H1d5o0v
        vkhjfzOvRrVhbYf/9fDIPVov2NtsNYtpR904z8+E7KmovlJajxsDmXGJ6ldN8shz
        6ycsftqk0Ek=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1E9F3C8D9;
        Wed, 14 Sep 2016 11:48:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 281333C8D8;
        Wed, 14 Sep 2016 11:48:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oleg Taranenko <olegtaranenko@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, git <git@vger.kernel.org>,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
References: <20160913142628.15440-1-benpeart@microsoft.com>
        <xmqq7fafv376.fsf@gitster.mtv.corp.google.com>
        <CABEd3j_FrWhOe_jXcc+VJWiyy80SG1JfbZC9woRU2cqdzjkGyA@mail.gmail.com>
Date:   Wed, 14 Sep 2016 08:48:28 -0700
In-Reply-To: <CABEd3j_FrWhOe_jXcc+VJWiyy80SG1JfbZC9woRU2cqdzjkGyA@mail.gmail.com>
        (Oleg Taranenko's message of "Wed, 14 Sep 2016 08:30:49 +0200")
Message-ID: <xmqqintyscs3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF12CB5A-7A92-11E6-ACCB-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oleg Taranenko <olegtaranenko@gmail.com> writes:

> Sorry for bothering, why not introduce a brand new option like git
> checkout -b foo --skip-worktree-merge for such rare optimization use
> case?

I am not sure what problem such a new option solves.  How would you
describe and explain what "--skip-worktree-merge" option to the end
user?
