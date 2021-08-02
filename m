Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E691C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB7C61107
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhHBRSF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:18:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54182 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbhHBRSE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 13:18:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C2C5B13D8B2;
        Mon,  2 Aug 2021 13:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sWqVYUxP0CJ1
        mfYX/Q7mSTN/lxQTb1MTnHIfE8LzuII=; b=sff3SY/BOlMs/YJnNqEU19VY/oAK
        jRYK/qe8125O+V2Ik4NMJpjFvMAjYhkyHJ7udK28LZ4RFyyB1SjlueEk6KKf/9Vg
        8/s4rC//wNoeD06Uil2WOcIYtwIuBewwMlRBeIOGkNAgvPiuebx+L0F2Jd3VEMuF
        8aisEfoR32JLaRU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB01613D8B1;
        Mon,  2 Aug 2021 13:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 152BD13D8B0;
        Mon,  2 Aug 2021 13:17:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 02/12] refs/files: remove unused REF_DELETING in
 lock_ref_oid_basic()
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
        <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
        <patch-02.12-dfb9e34076e-20210720T102051Z-avarab@gmail.com>
Date:   Mon, 02 Aug 2021 10:17:50 -0700
In-Reply-To: <patch-02.12-dfb9e34076e-20210720T102051Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Jul
 2021 12:24:07
        +0200")
Message-ID: <xmqqim0nwytd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 918546FC-F3B5-11EB-A8DC-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The lock_ref_oid_basic() function has gradually been by most callers
> no longer performing a low-level "acquire lock, update and release",

Something is missing after "has gradually been", isn't it?
"replaced", perhaps?
