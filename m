Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D2F20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbdAWS73 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:59:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56782 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751152AbdAWS72 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:59:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D44961D0A;
        Mon, 23 Jan 2017 13:59:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JdeWLO7ga/7vRD1xL8031mrRyAQ=; b=KlRxtn
        L+NS7WOemK4klptPyNIVutoaKDUHtbbCMfaHc4/0h8i1747E4FxYfSYNRyVzgt89
        tdVjuW2aNkiKbvhjFoxhoANpuMjgHI3WQMowsgMAuOEGqB23iFj+fFn9+uh6K+IC
        uQLTkbJyViT01ujmn/xkggQzzvZHvoGP05HT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AqgYClTsr4lLKc1rlUFWKqVYWda19UKt
        jhPBllxJVWnTpHE9z1ywRLdmajGSumaN48oz8f+4KZn6RzeiWsOOKS6SjxnDLQvo
        W+a6X45oIsww9F+sTYhumWz0xS2Tdvq8o0esgwgb3DK807syZbC/GYEjbD6SSXvW
        G8oWHkZgEMA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8444361D09;
        Mon, 23 Jan 2017 13:59:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B457B61D08;
        Mon, 23 Jan 2017 13:59:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/7] Macros for Asciidoctor support
References: <20170122024156.284180-1-sandals@crustytoothpaste.net>
Date:   Mon, 23 Jan 2017 10:59:25 -0800
In-Reply-To: <20170122024156.284180-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Sun, 22 Jan 2017 02:41:49 +0000")
Message-ID: <xmqqa8ahsiuq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FCCC8E8-E19E-11E6-97F4-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> There are two major processors of AsciiDoc: AsciiDoc itself, and Asciidoctor.
> Both have advantages and disadvantages, but traditionally the documentation has
> been built with AsciiDoc, leading to some surprising breakage when building with
> Asciidoctor.  Partially, this is due to the need to specify a significant number
> of macros on the command line when building with Asciidoctor.
>
> This series cleans up some issues building the documentation with Asciidoctor
> and provides two knobs, USE_ASCIIDOCTOR, which controls building with
> Asciidoctor, and ASCIIDOCTOR_EXTENSIONS_LAB, which controls the location of the
> Asciidoctor Extensions Lab, which is necessary to expand the linkgit macro.
>
> The need for the extensions could be replaced with a small amount of Ruby code,
> if that's considered desirable.  Previous opinions on doing so were negative,
> however.
>
> In the process, I found several issues with cat-texi.perl, which have been
> fixed.  It has also been modernized to use strict, warnings, and lexical file
> handles.  I also made an attempt to produce more diffable texi files; I may
> follow up with additional series along this line to make the documentation build
> reproducibly.

Thanks.  We'd probably want INSTALL to talk about Asciidoctor once
this matures, as it is very simple requirement for the builder to
have to just set USE_ASCIIDOCTOR, but the version requirement and
stuff might be still confusing.
