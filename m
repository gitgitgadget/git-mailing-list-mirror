Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E18C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 20:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350481AbiHSUor (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiHSUoq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 16:44:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD39BD29C
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 13:44:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CDB413AAF3;
        Fri, 19 Aug 2022 16:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QpWvOdO+67z/
        lR674lBtlBa5BHXuaPKSw5w8NwduMgg=; b=KcRxQkKu8+MZPE+rUU/FtZKEmV5Z
        nJah2zly46whMIj/qNRm12UqKVjPSKQs+cnrecY59GpgAtulwqAyCFG5RH67SYYl
        NxAKi/G5HXDJreItZARO4u0IBENuqgUwml0YoFSRI7MDPw5xTZ1Th4BXS/xM2rza
        zbrfL2pd5fs1tzo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3421613AAF2;
        Fri, 19 Aug 2022 16:44:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A209E13AAF1;
        Fri, 19 Aug 2022 16:44:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] sequencer: do not translate reflog messages
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
        <cover.1660828108.git.git@grubix.eu>
        <ea6c65c254bb08b20ea6c4d81200b847755b555c.1660828108.git.git@grubix.eu>
        <220818.86zgg18umf.gmgdl@evledraar.gmail.com>
        <6oqr69o7-qsps-sr86-o4r9-16r7no9n5424@tzk.qr>
        <220819.86o7wg6zci.gmgdl@evledraar.gmail.com>
Date:   Fri, 19 Aug 2022 13:44:40 -0700
In-Reply-To: <220819.86o7wg6zci.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 19 Aug 2022 17:12:43 +0200")
Message-ID: <xmqq8rnkklon.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C001699E-1FFF-11ED-9455-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Doesn't that also mean that the relevant functionality is now also (and
> still?) broken on any repository where these translations ended up
> on-disk?

It may, but the first response to that problem is not to make the
breakage in repositires worse by keep adding unparseable data to
them.
