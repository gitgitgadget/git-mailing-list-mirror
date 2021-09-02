Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5391CC433F5
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A74F61058
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 22:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347716AbhIBWhT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 18:37:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53443 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347711AbhIBWhS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 18:37:18 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F09C3E2258;
        Thu,  2 Sep 2021 18:36:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4oY5prHIW4xH
        Cj9EGQ5sBCU4iwJxjqdCO7oCH5A2T60=; b=mr59nfPdde4wRlvy5h5Czc8e9cNk
        uEp7S6gEe6nc6FGTSV4ER8omfe06IdGcL+vZ+EUDGgU9SN8X6rDSjEWUmqpczDna
        nOEmLlf/ZLeouppFjSgdLuntvhMEfrqRxKNuyc1HGTrdD+O9Q7litBU3yckuyxzT
        NUmIce97BA0VoYU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7AE6E2257;
        Thu,  2 Sep 2021 18:36:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7728DE2256;
        Thu,  2 Sep 2021 18:36:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 0/9] remove dead shell code
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
        <xmqq5yvik8bc.fsf@gitster.g> <874kb2a9tp.fsf@evledraar.gmail.com>
Date:   Thu, 02 Sep 2021 15:36:17 -0700
In-Reply-To: <874kb2a9tp.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 03 Sep 2021 00:17:08 +0200")
Message-ID: <xmqqbl5aip0e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 30A2177E-0C3E-11EC-BE10-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> You'll know better what you meant, but I interpreted the docs you added
> for git-sh-setup in 850844e28f7 (Documentation/git-sh-setup.txt:
> programmer's docs, 2007-01-17) as a guide for in-tree porcelain scripts=
.

No, it is not for "in-tree".  Especially back then, one of the Git's
goal was to be and to stay scriptable, and git-sh-setup was for those
who are scripting, either "in-tree" or custom Porcelain people wrote
around Git as part of a larger Git ecosystem.

