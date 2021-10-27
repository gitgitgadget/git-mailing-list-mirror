Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7D3C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFE460FC0
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbhJ0UGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:06:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54901 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234274AbhJ0UGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 16:06:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B056715A318;
        Wed, 27 Oct 2021 16:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p4WnsIalBO+C8pMXvReoAPsXUxS8C8Vyx98wwH
        +X9L8=; b=S6HdYG3UKhw9c+HYFamVXZTZJF4xYXKYvFUKxnE3Xu7ljx9KWNly1V
        KplSIkC2Yb66oNIrGv6rceOPAkbueapGeKz0FLjcog29P76+WYyWXN6bH3GKLMq8
        mSkvseI3yjGOGdOApnooPFEX0KUDBoAoSpVu6Ux+j+ibEQBM9b08I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A8CA015A317;
        Wed, 27 Oct 2021 16:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1300615A315;
        Wed, 27 Oct 2021 16:03:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
References: <kl6lbl3c7lsa.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqfssozk8r.fsf@gitster.g> <xmqqbl3czik5.fsf@gitster.g>
        <kl6l7ddz7m54.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqq8ryfxkuj.fsf@gitster.g>
        <kl6l35om9wn9.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 27 Oct 2021 13:03:39 -0700
In-Reply-To: <kl6l35om9wn9.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 27 Oct 2021 10:59:22 -0700")
Message-ID: <xmqqcznqw7z8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB1BAD1A-3760-11EC-B677-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> I might not want to take action on these ideas though, e.g.
> branch_get("HEAD") or remote_for_branch(NULL) are very convenient
> for callers even though they behave slightly inconsisently. I'll
> propose a longer term direction when I have a better grasp of the
> system and the tradeoffs.

Yup, that sounds like a good plan.
