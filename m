Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C782C20954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750967AbdLGVu6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:50:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54118 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750847AbdLGVu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:50:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DD364C4DDE;
        Thu,  7 Dec 2017 16:50:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9NY85kgBKS+kCQjryQzSsoH90JE=; b=JWBRF+
        E6O9rXSECH/BkfPGIPs17hgSLTDvTrg+YPg65Hym2D4gbs/M1DnwmZV24GNyyELl
        a3TE6bv6iK0kfm7HWtBZMF4JGvPJjFVUw/5ouG7ZQMbgF/BT6LZXlicna7TVb/Sx
        RZkBooDI/HvNF63LCRabrwZZGYtiU8CuPKE50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=swzJLZXUqc7Pu+RKrkzwUwk2qKX2pf9t
        jSDiY3VAi5kGtNBnQLwZgAxMLDpNNC5csLuJxvy2bunB+gcctCeVF1MKda7Cv2lY
        EFBGKCHvjSneCflKkrcyofbqK99n09IJEEdumIZ7FU1Gffr6R0H7Om1gtAoRZEtZ
        dLF5Pru+TdU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D46D3C4DDD;
        Thu,  7 Dec 2017 16:50:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5399BC4DDC;
        Thu,  7 Dec 2017 16:50:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] diff: add tests for --relative without optional prefix value
References: <20171207190135.28660-1-jacob.e.keller@intel.com>
        <20171207211258.GB12850@sigill.intra.peff.net>
Date:   Thu, 07 Dec 2017 13:50:55 -0800
In-Reply-To: <20171207211258.GB12850@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 7 Dec 2017 16:12:58 -0500")
Message-ID: <xmqqtvx2b41s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B43E60C2-DB98-11E7-A285-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 07, 2017 at 11:01:35AM -0800, Jacob Keller wrote:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>> 
>> We already have tests for --relative, but they currently only test when
>> a prefix has been provided. This fails to test the case where --relative
>> by itself should use the current directory as the prefix.
>> 
>> Teach the check_$type functions to take a directory argument to indicate
>> which subdirectory to run the git commands in. Add a new test which uses
>> this to test --relative without a prefix value.
>
> This looks good to me (and I slightly prefer it over Junio's for the
> simplicity).
>
> I agree on the ordering suggestion Junio made.

I also prefer this one over the other one, provided if it is ported
on top of the preliminary clean-up I did in the other one.

Thanks.

