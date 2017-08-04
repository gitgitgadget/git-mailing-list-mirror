Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1087B2047F
	for <e@80x24.org>; Fri,  4 Aug 2017 16:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752544AbdHDQAz (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 12:00:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55111 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752160AbdHDQAy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 12:00:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC3F9981D8;
        Fri,  4 Aug 2017 12:00:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JZuYFSk4naEJ
        BL4vh3cC2+5dtVo=; b=OqVzfZgGZouLxmi/18HfdNZJAAO18CWnYg8S3Pj334UZ
        Pm0NgdWT2LCUeSvaYbi7l/KyVmzDz718m33kXeWkj9djYtRngi789fX86m/6Ix//
        RTs5UajdhP0EWyViuTw5VDSrahuJAQvl7jRo+y6quIlJD4b22j92xdIlIKh56u4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KB3sEs
        PsOD0ZWTMcG7Qe9ueeW53RUckOJL2wm0q6LtNCm2sUvC/2+GYKxxez+mRsuk2/o6
        iO3Xk7cmU+dvVc2VGnzAUVdWTBYTMEztwcHYI08AgAxbNFSxf5oCfHcWonrEhsI8
        VC5t8vPVrniY84g7cHkQCm/TxV/J+X3+tp8qU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C59DA981D7;
        Fri,  4 Aug 2017 12:00:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38E88981D6;
        Fri,  4 Aug 2017 12:00:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/7] builtin.h: take over documentation from api-builtin.txt
References: <cover.1500321657.git.martin.agren@gmail.com>
        <cover.1501701128.git.martin.agren@gmail.com>
        <e660a9cdaff6d114305a475f9a12876b56b473d1.1501701128.git.martin.agren@gmail.com>
        <xmqqpoccpmux.fsf@gitster.mtv.corp.google.com>
        <CAN0heSrP=HeUcpfwXS9DyzCYCnCCocyV4iCHyAxrYPmW=LgZ+g@mail.gmail.com>
Date:   Fri, 04 Aug 2017 09:00:46 -0700
In-Reply-To: <CAN0heSrP=HeUcpfwXS9DyzCYCnCCocyV4iCHyAxrYPmW=LgZ+g@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 4 Aug 2017 06:18:59
 +0200")
Message-ID: <xmqqzibfuxu9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 14CC382E-792E-11E7-B16C-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> Since this is my first code contribution to Git, I'll ask about this pa=
rt of
> SubmittingPatches:
>
> "After the list reached a consensus that it is a good idea to apply the
> patch, re-send it with "To:" set to the maintainer [*1*] and "cc:" the
> list [*2*] for inclusion."
>
> I will boldly assume that I should not be doing this. It seems to me th=
is
> doesn't happen very often or not at all -- possibly because you tend to
> be involved in virtually all threads anyway, before the list reaches a
> consensus.

Yeah, that is in the "ideal patch flow" section, isn't it?  We
rarely achieve the "ideal" and often instead go for a more expedited
option, it appears---perhaps I should try to be less involved in
individual patch reviews and place more review burden on other
reviewers ;-)

In any case, it was a pleasure to cheer-lead on the progress of this
series.  Thanks.
