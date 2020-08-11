Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ABDC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4236206DA
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 19:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KLzFixHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgHKTBG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:01:06 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65018 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKTBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 15:01:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CDC78F282E;
        Tue, 11 Aug 2020 15:01:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yJuV47BJE277
        52IZGr4AGZasOzs=; b=KLzFixHFiQBCyGq8ovnmey0eXoSwO3dJyG1BWy9l3TBd
        CWMqwuUbXa1Gw8GuH0ygYM3XSGFI7m/v/Vf+xyg8FggZ7hixdVvL30JKZVrLP/mI
        noH4bqI+jV8abIZvhu2+MFA3IJ4fshMss5pAyQtgTKeOCCeuqLOFwfdrvjioctc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=e4Dv0V
        9zFOx4UqFT2Qc588DcPRcFUbrwfAz54uxmUwRq7dlBAj3WrsK8zaULCVK9Jo0bH1
        sKW263QE8wnSplDiD52LawKAaN9evtYSoXxV9q2w5U69WX8QzKib5NeXYmV4PHT5
        N4n+b+OBNrl8hE/cq/08CnlcGaTnT/Fx48f7w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C69AFF282D;
        Tue, 11 Aug 2020 15:01:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DEAEF282B;
        Tue, 11 Aug 2020 15:01:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/11] renaming argv_array
References: <20200728202124.GA1021264@coredump.intra.peff.net>
        <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de>
Date:   Tue, 11 Aug 2020 12:00:59 -0700
In-Reply-To: <82991f30-fe37-d6d2-ffd5-8b0878f46c83@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 11 Aug 2020 18:08:22 +0200")
Message-ID: <xmqqk0y59fdg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FF609C0E-DC04-11EA-B700-843F439F7C89-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> 7.31.13 goes on: "Function names that begin with str, mem, or wcs and a
> lowercase letter may be added to the declarations in the <string.h>
> header."  So the names of the strvec functions are reserved.

Ugh, strbuf functions are reserved, too?
