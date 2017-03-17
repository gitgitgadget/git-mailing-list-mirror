Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A497220955
	for <e@80x24.org>; Fri, 17 Mar 2017 05:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdCQF0Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 01:26:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50197 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750892AbdCQF0X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 01:26:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF75A6D7A5;
        Fri, 17 Mar 2017 01:25:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lSfB55ea1LI+3tEW3e+OeFMZ52M=; b=hvKsWb
        rZ2RPToEDG+zMfvG01eQnR81B44ACUF11R0G4lUf2zy26Py/yBHHnlAnocoUVbmB
        xq7M6UI1u51W3qPfuG+Bml4cB+XpZ7Q0bripmKrvrKEIZGkzB2IKtndG7Sdcxiae
        FUJuOxhYiSOCvuAvyi4rvD/m4Tm5bOTEyEZXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=M1lXReKWt+W5M7y+vUXUTLexq9NqXP/M
        gHP/iudBfgsZL5v1B6V5YurFdOdS8F6LM3RO+WfsJcbIeAwyxYeM3KGxg7CyM3Rf
        PXTumeEW3O6CtcmUR+VGHlAsEbvaRDDn95d64X3hSxyOx1B+ZoZq/hPUQpsXwMPN
        hneb8zN7ZWw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B92C26D7A4;
        Fri, 17 Mar 2017 01:25:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 23E7D6D7A3;
        Fri, 17 Mar 2017 01:25:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] wt-status.c: improve readability for wt_shortstatus_print
References: <20170316213619.30678-1-sbeller@google.com>
        <20170316225108.GB9135@aiede.mtv.corp.google.com>
Date:   Thu, 16 Mar 2017 22:25:25 -0700
In-Reply-To: <20170316225108.GB9135@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Thu, 16 Mar 2017 15:51:08 -0700")
Message-ID: <xmqqd1dga30a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 210990E8-0AD2-11E7-A892-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>
>> Subject: wt-status.c: improve readability for wt_shortstatus_print
>
> Maybe:
>
> 	wt-status: simplify by using for_each_string_list_item
>
> 	Improve readability by using the for_each_string_list_item helper
> 	instead of manually iterating with an integer counter.

Much better.  That matches what I read from the patch when I skimmed
it, but it did leave me wondering if I missed something else.

>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  wt-status.c | 20 +++++---------------
>>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> I like the diffstat. :)

Me too ;-)

>
> With or without a clarified commit message,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
