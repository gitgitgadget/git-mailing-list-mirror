Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15645C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC96661357
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 18:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbhDLS05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 14:26:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62495 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236888AbhDLS0z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 14:26:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1ABE0118127;
        Mon, 12 Apr 2021 14:26:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nnBJoCtSu03e5uXg0c1ulwJH2Is=; b=ZroFcT
        xdNBrhgrboAq4vDnx2tSTxn+ZBO/ZCVykZ9pUUOq0e4LME2BLYMJbgCCO5sUVVcr
        rQh49wwx5YEuOITqTIfOIdmkp2vXX1OPk12d4sp7oSYHoYt5kbPG1xGHastkYpm4
        +4yfPTMuQwlRA3uc+bVgiozdaY0aOyEZJV6bM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ets6UVa4P8qJp+QyHehMrJkfRxwcrQ6T
        lbIM75RoTIF0TOF9ssotaQ1mXCKscQYvhuIR0xCv0hzSaZ7IuTY6Djdq/IfKnGSa
        g7vbSvdBMNkFjdp8NopvZ9/SabF4x75+U0bWH7sDl3emM8zdvB5sNI5syjtXFkJ7
        7dmfZz4RqY4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1472D118126;
        Mon, 12 Apr 2021 14:26:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3803F118124;
        Mon, 12 Apr 2021 14:26:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jerry Zhang <jerry@skydio.com>,
        Git Mailing List <git@vger.kernel.org>, ross@skydio.com,
        Abraham Bachrach <abe@skydio.com>, brian.kubisiak@skydio.com
Subject: Re: [PATCH v5] git-apply: allow simultaneous --cached and --3way
 options
References: <20210407180349.10173-1-jerry@skydio.com>
        <20210408021344.8053-1-jerry@skydio.com> <xmqqh7kgvr3i.fsf@gitster.g>
        <CABPp-BEmZrK9ambLHL=ryjRM22zqGn6vzc+2aGoy=x-Z3mwUdQ@mail.gmail.com>
Date:   Mon, 12 Apr 2021 11:26:31 -0700
In-Reply-To: <CABPp-BEmZrK9ambLHL=ryjRM22zqGn6vzc+2aGoy=x-Z3mwUdQ@mail.gmail.com>
        (Elijah Newren's message of "Mon, 12 Apr 2021 08:45:31 -0700")
Message-ID: <xmqq5z0re4vc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BA61E8C-9BBC-11EB-B25A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Sorry for the delay; modulo two minor issues with the commit message
> it looks good to me.

Thanks.
