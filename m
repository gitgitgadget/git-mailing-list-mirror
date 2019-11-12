Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5F1E1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 04:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKLEql (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 23:46:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52870 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLEqk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 23:46:40 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9DB8C8F4D3;
        Mon, 11 Nov 2019 23:46:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JEaWw9How0KbNbzUmnVOfzdeKDI=; b=p0Yfv+
        ExGSNRigEohjJnRGEYiWD8g6rThUaU3jxFNNgUfC+uvByfaTUBSCcoM1CXkg+ViS
        8Yzx/nFIeWlVMB9zod1q1LN9o6flmy5a25Gfe8q1myKoCYwc/4uKWU40ZogiC70o
        G0pRwSDqW1TBXuNqqZic39WXrtx6gwwu5cUN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jA4rrFyg62HfevsFaJy8iUUqrBll8rrz
        grhZygFuo4amthRVVyAb3QSHuoB/Ujs4X1NpIkC/4R+ZhvQpfT7jg8nqnxIim88o
        yg+aWryiCYrXyhkQhYkCzaraGpM+hrHCARQJfSqJ7PkvJqdep6zvFOKq3oGdFIlo
        YRyzTrAnQrA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 97E2D8F4D2;
        Mon, 11 Nov 2019 23:46:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C76528F4CE;
        Mon, 11 Nov 2019 23:46:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Paul Jolly <paul@myitcv.io>
Subject: Re: [PATCH] completion: learn to complete `git rebase --onto=`
References: <CACoUkn6D0cUmN1RbcpfERcOJsbGLdwj6oDeF2oRADV+rX2artQ@mail.gmail.com>
        <22e92546ee49d4502fd5a441741a380d62c834c7.1573507362.git.liu.denton@gmail.com>
Date:   Tue, 12 Nov 2019 13:46:33 +0900
In-Reply-To: <22e92546ee49d4502fd5a441741a380d62c834c7.1573507362.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 11 Nov 2019 13:25:20 -0800")
Message-ID: <xmqqpnhxg0ra.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6823F450-0507-11EA-A0CC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Before, when there was a space, we'd start a new word and, as a result,
> fallback to __git_complete_refs() and `--onto` would be completed this
> way. However, now we match the `--*` case which does not know how to
> offer completions for refs.

Very well explained.  Thanks, will queue.
