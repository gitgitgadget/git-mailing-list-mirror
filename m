Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B41C920899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdHNWVP (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:21:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55448 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752408AbdHNWVN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:21:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14E7690D96;
        Mon, 14 Aug 2017 18:21:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fEZjJCHN2o/30NH5nVAgBszEOtc=; b=gdHFdg
        kyx5WI+bUvc9ekAzVxFh5JhauY6iB1fwG0Ml3H7Czih0wWgYvg4uygIXYFLky2BI
        Rvwh4Y+1oL+wKpJOcHBf0RgiZoc05TzssedaxDoYowUaKFy3rZhK6Es7aCmGUaER
        OXUZlgERV4/leSmZo2hemIbov3zjyOd8m7OiI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rSdhU2+rMAiTqqegpRLy3TEjoLEmbViV
        BxOfgMM3/eMEZOTKvbLLjhrYAv0yO+IGoUrq0E0JTAPzLHLweDU18Hnr5i7ND/Kp
        ie9qIqqlR7F2nk1pNHkn5ha0EkXT52jU6qrPFHcxRG/KkdW36GDXr51qO5B4eRSp
        ttpVPpOjZ9I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D1CA90D95;
        Mon, 14 Aug 2017 18:21:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 52CEE90D94;
        Mon, 14 Aug 2017 18:21:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] doc: clarify "config --bool" behaviour with empty values
References: <20170813094816.7754-1-asheiduk@gmail.com>
        <xmqq60dqvxw1.fsf@gitster.mtv.corp.google.com>
        <914098af-00a9-fbc8-cdfe-a65918b2951b@gmail.com>
Date:   Mon, 14 Aug 2017 15:21:04 -0700
In-Reply-To: <914098af-00a9-fbc8-cdfe-a65918b2951b@gmail.com> (Andreas
        Heiduk's message of "Tue, 15 Aug 2017 00:07:26 +0200")
Message-ID: <xmqqlgmlu6y7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCFB9E62-813E-11E7-BF17-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> writes:

>> However, I think this "no value (but still with '=')" is making it
>> more confusing than necessary for two reasons.
> [...]
>  
>> I notice that in this Values section (where the boolean:: is the
>> first entry) there is no mention on how to spell a string value.
>
> I assumed this is due to the pretext of the definition list:
>
> 	Values of many variables are treated as a simple string, but there
> 	are variables that take values of specific types and there are rules
> 	as to how to spell them.

I assumed so too.  

But if you knew that "[section] var =" is a valid way to spell an
empty string, I'd thought that you wouldn't have written "no value
but still with '=')" there.

The description for "true" (i.e. "[section] var" and nothing else)
is also spelled out perfectly well in the Syntax section, but it is
duplicated in Values section.  I think that it is a good thing to
have the complete picture in a single Values section, without
assuming readers to know what is in the other Syntax section.

So if it bothers you to have a non-specific "string" description in
the Values section, I think it would be more helpful to update the
pretext so that including the description of a simple string there
does not look unnatural, IMHO.
