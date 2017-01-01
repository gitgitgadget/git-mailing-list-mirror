Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB5E20441
	for <e@80x24.org>; Sun,  1 Jan 2017 02:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932080AbdAACH2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 21:07:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59774 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932071AbdAACH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 21:07:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DB1E5CCC6;
        Sat, 31 Dec 2016 21:07:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K68M90PR+zoO6ZypdmFMqrikfEA=; b=e+vPIU
        qaASLKXLDOGrQMJ51Lp/RxCbEPIAYy3pNGaJBfvKwkTcDCTQNAlj13ccp8Zbd4Sm
        1+C9IDOFW2VoRNFog7T/Hb3dVyqMDqPxuKftVfzuMZ4ktg46NXg/SWo+ZavyBevr
        JQ7NjN3dQ+Y41UrT4wCnBMQ3N9FFW9Zhr/3Qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=muOy8AvSCPuZwo3f1dsvOf+niBcEvoG5
        F8mMvn1vm3eJUMrw3bVoELA4zGW1Nv+FGblJTvXKXlr5D4Qmhy040OIm4RXxvo3n
        FVHG+lJVbTuxmaZPzHbWCupjc0jrIxahhJp1Br9+jKyz0H4G1Inx5W9RKR9GWvG+
        wppQzZg78ms=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 768365CCC5;
        Sat, 31 Dec 2016 21:07:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F18135CCC4;
        Sat, 31 Dec 2016 21:07:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 05/23] raceproof_create_file(): new function
References: <cover.1483153436.git.mhagger@alum.mit.edu>
        <f933f9d3c4c53b42ecc75b7a743ed4bfd390b4c5.1483153436.git.mhagger@alum.mit.edu>
        <20161231061146.gxlbma6w7odho4c7@sigill.intra.peff.net>
        <241de54c-63ee-d13c-c9fe-8b420871ac51@alum.mit.edu>
Date:   Sat, 31 Dec 2016 18:07:25 -0800
In-Reply-To: <241de54c-63ee-d13c-c9fe-8b420871ac51@alum.mit.edu> (Michael
        Haggerty's message of "Sat, 31 Dec 2016 08:42:23 +0100")
Message-ID: <xmqq4m1j5y8y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A5324EA-CFC7-11E6-BAB6-E17F7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> But presumably you mean that we delete "foo/bar/baz/xyzzy", etc, up to
>> "foo/bar/baz", provided they are all empty directories. I think your
>> comment is probably OK and I was just being thick, but maybe stating it
>> like:
>> 
>>   ...removes the directory if it is empty (and recursively any empty
>>   directories it contains) and calls the function again.
>> 
>> would be more clear. That is still leaving the definition of "empty"
>> implied, but it's hopefully obvious from the context.
>
> Yes, that's clearer. I'll change it. Thanks!

Thanks. Will tweak it in while queuing.
