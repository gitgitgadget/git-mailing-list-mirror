Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B47E8211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 04:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeK2QCt (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 11:02:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59805 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbeK2QCt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 11:02:49 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7A40C2A3B4;
        Wed, 28 Nov 2018 23:58:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TAl3fS+9I6Nk
        w2dCLuZxtaa+aco=; b=WLQGiODECluKsV3NHodDDw9VjLKrzAyyoBOdM8AHIq1Q
        urYK9612maiItvVFOez2MWQjtjnWhBygSxsDR4d2mw6FK9GOO0o4p1B/LGAFL6i/
        ukuvpybvk4n2auHuYZxUcK4ILmHUyDwvF60nxTVXsckNiTdnmiNN4haqf8CPhJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KSerIu
        WEqqf/iosr0vE4kCFXMrtoHPiNoeVBkhnlSw73AowF1Yag3zBhP9ONmnVsAR2eER
        UGOyBHwT5idsiLrZYGR35Sc6Pr8MvkYZf1q+qsP+g4EzGKFoYHBLe/dN8YfPSTNI
        Lkqc17atGvq4RIfv10gfLCE22lZJa1CM2ajOU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 72CB82A3B3;
        Wed, 28 Nov 2018 23:58:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8DC762A3B2;
        Wed, 28 Nov 2018 23:58:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Ian Jackson <ijackson@chiark.greenend.org.uk>
Subject: Re: [PATCH] rebase: mark the C reimplementation as an experimental opt-in feature (was Re: [ANNOUNCE] Git v2.20.0-rc1)
References: <xmqqmuq25ufc.fsf@gitster-ct.c.googlers.com>
        <87y39w1wc2.fsf@evledraar.gmail.com>
        <877eh219ih.fsf@evledraar.gmail.com>
        <xmqq36rq2cp0.fsf@gitster-ct.c.googlers.com>
        <xmqq36roz7ve.fsf_-_@gitster-ct.c.googlers.com>
        <20181128043154.GA34163@google.com>
        <nycvar.QRO.7.76.6.1811281015360.41@tvgsbejvaqbjf.bet>
        <87bm69z939.fsf@evledraar.gmail.com>
Date:   Thu, 29 Nov 2018 13:58:41 +0900
In-Reply-To: <87bm69z939.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 28 Nov 2018 13:21:14 +0100")
Message-ID: <xmqq4lc0qy2m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 722AF920-F393-11E8-89E6-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Since I raised this 'should we hold off?' I thought I'd chime in and sa=
y
> that I'm fine with going along with what you suggest and having the
> builtin as the default in the final. IOW not merge
> jc/postpone-rebase-in-c down.

OK.
