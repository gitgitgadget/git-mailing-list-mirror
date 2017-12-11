Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454001F404
	for <e@80x24.org>; Mon, 11 Dec 2017 23:07:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751234AbdLKXHn (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 18:07:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61340 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750759AbdLKXHm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 18:07:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07D30BB35B;
        Mon, 11 Dec 2017 18:07:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=wcCD9VEmy8TY
        btPEtr8CW+ZSF8U=; b=gyuOtg+r5jmZtir5MMhsskzByhtVCf7gNBypoJNRPXLe
        L4v8DLwmEmZGR2VnrPbNDnaEQHXSJBNszI5lPfeKOQtx7fU/L3P9XbefObMHZ/B2
        ASlmv9xAWFlqTANsshcVMptCXSlIYKG/NQmnbnECTTOrqKgzv/dKQQ68nVMlfkk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=e5cVD5
        WRg39akR5cwR8klH7I2iYm6gossDIdTyN3zK5SXAM+B8Q+gNfATeELsEOGE7PZAA
        4oPD1NHrupfCHkSvvCv03vksZiOtvZKLEUw+Zp8Z1+T8R+9OskH3Sv/zHBbTEBc6
        qDXdPBP8hEp67jCD9iPbeDLOdTDtL11Q3/wXs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F219FBB35A;
        Mon, 11 Dec 2017 18:07:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71CDBBB359;
        Mon, 11 Dec 2017 18:07:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 1/1] check-non-portable-shell.pl: Quoted `wc -l` is not portable
References: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com>
        <20171210105013.3984-1-tboegi@web.de>
Date:   Mon, 11 Dec 2017 15:07:35 -0800
In-Reply-To: <20171210105013.3984-1-tboegi@web.de> (tboegi@web.de's message of
        "Sun, 10 Dec 2017 11:50:13 +0100")
Message-ID: <xmqqvahc50eg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 13C835C2-DEC8-11E7-ABF1-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> wc -l is used to count the number if lines in test scripts.

Hmmmm, "is used" -> "should not be used", probably.

Just say "Use test_line_count instead" and leave the explanation why
it is a better thing to use to fb3340a6 ("test-lib: introduce
test_line_count to measure files", 2010-10-31), perhaps?
