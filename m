Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46C8F1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 16:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755163AbcHSQjY (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 12:39:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61847 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755347AbcHSQjW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 12:39:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDDA535558;
        Fri, 19 Aug 2016 12:39:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SPO1PnnL6w2B
        QD5YtX/5YTy22rU=; b=lCze22t+b73J4dPbNjAdj2q5etFhSNDaLF8Vtj2ffgav
        SS+bID7Vz5mvdz7JCi61pmlE7vlC9jgkWuVYEMoyDZyf4t7B02HUVaExtZcjl3t/
        +cenXKxpVmM5j7otVJS8m1q1ovJosVpj9HmbSw/zM+FEoX9vMVSGPGy6r5/54hc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Z1RsH1
        phY+hKMOkMCTndHi9wyiR/fai9dTbKT78tJ3aeZI/n8Tc4K9bPmRsi1NeuCa0php
        31quRs6Dt9tksI7JJcEohmFZsYwVwetRYtK6ojEs1Xo8NqiJ0vJCki+pmaFWLci8
        ZinZ7yqnz3bVGsisX8kApUNA0+XWuaQUQbmj0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E67EB35557;
        Fri, 19 Aug 2016 12:39:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6BE3A35556;
        Fri, 19 Aug 2016 12:39:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 0/1] Rename NotNormalized (NNO) into CRLF in index
References: <20160809114938.pcrvirrzrh6ldmnr@sigill.intra.peff.net>
        <20160819094127.21101-1-tboegi@web.de>
Date:   Fri, 19 Aug 2016 09:39:18 -0700
In-Reply-To: <20160819094127.21101-1-tboegi@web.de> (tboegi@web.de's message
        of "Fri, 19 Aug 2016 11:41:27 +0200")
Message-ID: <xmqqlgzs3e89.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7A669CE0-662B-11E6-B72C-FCB17B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Here comes the promised cleanup of t0027:
> - The wording NNO is removed and replaced by CRI
> - No code changes
> - Needs to go on top of next or pu or tb/t0027-raciness-fix
> Torsten B=C3=B6gershausen (1):
>   t0027: Rename NotNormalized (NNO) into CRLF in index
>
>  t/t0027-auto-crlf.sh | 122 +++++++++++++++++++++++++------------------=
--------
>  1 file changed, 61 insertions(+), 61 deletions(-)

Until these acronyms are shown expanded upfront in the file (not in
the log message), this patch does not help the readers at all.  They
used to say "What the heck is NNO?"  Now they will be left wondering
"What the heck is CRI?".

Have a comment before the first use of the acronym, perhaps?

@@ -102,7 +84,7 @@ commit_check_warn () {
 	check_warning "$crlfnul" ${pfx}_CRLF_nul.err
 }
=20
-commit_chk_wrnNNO () {
+CRI_add_chk_wrn () {
 	attr=3D$1 ; shift
 	aeol=3D$1 ; shift
 	crlf=3D$1 ; shift


Incidentally it is a good place to describe what this humongous
helper function is meant to do.

# Having CR in the indexed contents (CRI in short) poses such and
# such tricky cases; this helper tests combinations of xyzzy, frotz
# and nitfol exhaustively by running xyzzy through (a, b, c),
# flipping frotz between (x, y), and ...

or something like that (of course the blanks need to be filled),
perhaps?
