Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0291FC433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A952253D
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 23:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbhADXsO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:48:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61597 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbhADXsN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 18:48:13 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7143E90E95;
        Mon,  4 Jan 2021 18:47:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Xba4EEoiYSm3ayj6MNaUnmRPH
        A8=; b=vVjZNPHy/f88ICDav2tlz1pCgWmI2S/EQX+nKXUUQagSlN0CSKtVvuVnM
        h2p5YKI2Y3c7WgBEYeFtn82gXT5ka/X5ZsSvtDBlCefPbUNCrpdqexDCkZfZoPBX
        srpgv5MHjh5rtfjuYsMAHMTm88y2rgOOAQpIkHTlCM/ANUxKdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=dVTdj7p3Xdx90O+nTub
        auuo4FA5GS8VxvEJE5QXV3yaR2dOxJQQlpnmkkWTTs6iXaQ4kQmov7VAl/GktvAf
        ENVzfYIcr6NAmL4fCCnBCw5AzSy8WDA9P1MI7lN07UfBqXJFgpIR26BCoIG2kI3c
        Vq872FsTQ+UVa63+r+Tzmw1Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6962190E94;
        Mon,  4 Jan 2021 18:47:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E9EE390E93;
        Mon,  4 Jan 2021 18:47:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re* [PATCH v2 2/2] CoC: update to version 2.0 + local changes
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
        <20201228171734.30038-3-avarab@gmail.com>
        <xmqqmtxxedwd.fsf@gitster.c.googlers.com>
Date:   Mon, 04 Jan 2021 15:47:30 -0800
Message-ID: <xmqqft3g463x.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 35AABEB6-4EE7-11EB-933D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> This change intentionally preserves a warning emitted on "git diff
>> --check". It's better to make it easily diff-able with upstream than
>> to fix whitespace changes in our version while we're at it.
>
> I think there are only two lines that needs to tolerate trailing
> whitespaces, and even if we strip them, it should be still easily
> diff-able with the upstream with --ignore-space-at-eol or whatever
> appropriate option, so I am not sure if it is worth try "keeping"
> these whitespace breakage.

In the meantime, I'll insert this as step [1.5/2] while queuing.

In any case, your [2/2] lacks your sign-off, which we eventually
need to have before applying these patches.  In the meantime, we
also need to collect Acks on the move to 2.0 from folks.

Thanks.

---- >8 -------- >8 -------- >8 -------- >8 -------- >8 ----
Subject: [PATCH] CoC: explicitly take any whitespace breakage

We'll keep this document mostly in sync with the upstream; let's
help "git am" and "git show" by telling them that they may introduce
what we may consider whitespace errors.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitattributes | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitattributes b/.gitattributes
index b08a1416d8..b0044cf272 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -6,6 +6,7 @@
 *.pm eol=3Dlf diff=3Dperl
 *.py eol=3Dlf diff=3Dpython
 *.bat eol=3Dcrlf
+CODE_OF_CONDUCT.md -whitespace
 /Documentation/**/*.txt eol=3Dlf
 /command-list.txt eol=3Dlf
 /GIT-VERSION-GEN eol=3Dlf
--=20
2.30.0-170-g148fa4353e

