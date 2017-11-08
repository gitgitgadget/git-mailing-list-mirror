Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD85E1F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 00:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933458AbdKHAVV (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 19:21:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54354 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933222AbdKHAVT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Nov 2017 19:21:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2536CAF338;
        Tue,  7 Nov 2017 19:21:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HBKTW/WOfqsH8uvp4zPT22uOzik=; b=vYAtVa
        WIbGRhhl3Rv3UAx47yUUPUjU7NDxCxQs2paPLkrf5b8S4kwZMONT7bN+hujHsylg
        /BYFKsIJoKO55Cp3zdRI9X7E3i5aUacrTEwW3DowBSmY8ffMwsoX9eiXXUVtrvzT
        e19EBtMtvGm10FUTVeQvS521Cd42A/t0/T3oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H7h4cTXwSV++hHWO9exX+Cs1bc3cpFVF
        1+vqqxaa119oX/d45DVx4Zkqb9XzHWRLgOPdOI1FuOFrhyAlYRqxIGze20JWYhlq
        GEMOTzg/DKKLQdnGuKZg2Mb6GlCbsO9ZHxbOWzWFkw7HlzZjChrjI5K+LMuKlj5j
        Js/h//DOMW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B067AF337;
        Tue,  7 Nov 2017 19:21:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B443AF333;
        Tue,  7 Nov 2017 19:21:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: sb/submodule-recursive-checkout-detach-head
References: <xmqq7evhc7nw.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYUZv0g+3OEMrbT26A7mSLJzeS-yf5Knr-CnARHqVB=aQ@mail.gmail.com>
        <xmqq4lq6hmp2.fsf_-_@gitster.mtv.corp.google.com>
        <CAGZ79kY=WWTzwyz8t21RghEWAgPphhvUO5ut0O+rL0YhbqeGxQ@mail.gmail.com>
Date:   Wed, 08 Nov 2017 09:21:17 +0900
In-Reply-To: <CAGZ79kY=WWTzwyz8t21RghEWAgPphhvUO5ut0O+rL0YhbqeGxQ@mail.gmail.com>
        (Stefan Beller's message of "Tue, 7 Nov 2017 09:05:51 -0800")
Message-ID: <xmqq375ppqma.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD7A54EC-C41A-11E7-91EC-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> Detaching the submodule HEAD is in line with the current thinking
>>> of submodules, though I am about to send out a plan later
>>> asking if we want to keep it that way long term.
>>
>> Did this "send out a plan" ever happen?
>
> No. (Not yet?)
>
>>  I am about to rewind 'next'
>> and rebuild on top of v2.15, and wondering if I should keep the
>> topic or kick it back to 'pu' so that a better justification can be
>> given.
>
> Feel free to kick back to 'pu'.

OK.

I am puzzled by the question mark after "Not yet", which I could
interpret as "it is even questionable to Stefan that it may or may
not happen", but I'd assume that kicking back to 'pu' and allowing
it to be reroll will be taken as an opportunity to skip such a
separate "plan" and instead to clearify the plan and design in an
updated log message--that is fine by me, too.

Thanks.

