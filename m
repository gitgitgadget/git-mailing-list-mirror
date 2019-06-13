Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 955C21F462
	for <e@80x24.org>; Thu, 13 Jun 2019 21:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfFMVAG (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 17:00:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63396 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbfFMVAG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 17:00:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CCCC61E06;
        Thu, 13 Jun 2019 17:00:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=clqfBJHfd1Zy
        IeSvTmFEL+tZFHs=; b=amX597I9WFNJT+ufY81UtTre6cMi3DbR4yMIzn7g4WTw
        pHbh1N+/BSV6FkYl8fLxBTUveSS9G68j3tZGUSFoVA7OQWWrZO5R9Ycfxp8GkfS6
        a2Cpb7P7XmSA2EdctbSidT0/GpkohjeJODEgz6VZ6lH62mHONh3oGS522OnqQvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gam0ic
        qJeqgaMoR5AwjwcLR4Xzju5vZE8HukHngJErTDwnTGYIgCzD/WSEWa98VhcGcIgr
        rmzpOziTJHx/YWOmzyEeSACt6gFGQlT7MsqCzrS3pqcBBUe0PVCCpTT7C2oIOwiq
        UXAHp7DnekgjfbU+aqA8N06LxvQTsLZkEdtPU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7443861E05;
        Thu, 13 Jun 2019 17:00:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B02B261DF4;
        Thu, 13 Jun 2019 17:00:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC][PATCH v3 1/3] sequencer: add advice for revert
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
        <20190613040504.32317-1-rohit.ashiwal265@gmail.com>
        <20190613040504.32317-2-rohit.ashiwal265@gmail.com>
        <0333fe2f-d68a-4536-c736-ca2a356df34b@gmail.com>
        <CAN0heSp_XDZTviwGDpOuXhuh+8k-BA7Ld6z9gSHA9My+16BnbQ@mail.gmail.com>
Date:   Thu, 13 Jun 2019 13:59:58 -0700
In-Reply-To: <CAN0heSp_XDZTviwGDpOuXhuh+8k-BA7Ld6z9gSHA9My+16BnbQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Thu, 13 Jun 2019 21:21:27
 +0200")
Message-ID: <xmqqlfy5urox.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 35639972-8E1E-11E9-AF7A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> ...
> I agree 100% with Phillip, but I'll also note that "the control must no=
t
> reach here" doesn't tell me anything that BUG() doesn't already. That
> is,...

Thanks, all of you involved in this topic, for excellent mentorship.
