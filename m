Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407461F667
	for <e@80x24.org>; Wed, 16 Aug 2017 16:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbdHPQlw (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 12:41:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59299 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752245AbdHPQlt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 12:41:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 754FEACC36;
        Wed, 16 Aug 2017 12:41:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DZI3Y7IDyfUBVpTnHE4xS/8uOY0=; b=QJoadt
        qfM6iUpDXYgkAerM4GYy8Uyajl/AVQ/smdeE0CYDaJ8M7B/lbEkzHv0/3rXxdf+F
        5JB4nfgZP43JUDICNgQrbk6hECjkJ2Ro+2w5mQ5HHXj16iUMXgz0PAbl32TBi5B7
        vNsHIYSHfaUE6AzJBNYhLbKPdZUu+CYI5bWN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HuFgO1kIfQAdREV7bF5LMnyNNqxHKWiv
        IaNYYag3iumGL0PzUdPJeIxvOpLeCVbvSBFYIDXSCINLx53MHRpZPJdLvpZaJKYd
        3YFut/dRJEtzJkDaXk+SRhNgmbrDE51mImqahvaTFQs2k5PGzyfg0OWkFnDAcopH
        DYgHER5vqZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C27DACC35;
        Wed, 16 Aug 2017 12:41:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98FEFACC33;
        Wed, 16 Aug 2017 12:41:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] sub-process: print the cmd when a capability is unsupported
References: <20170816124036.25236-1-chriscool@tuxfamily.org>
        <758d36a7-8066-7e1a-30d0-62baf2796520@gmail.com>
Date:   Wed, 16 Aug 2017 09:41:46 -0700
In-Reply-To: <758d36a7-8066-7e1a-30d0-62baf2796520@gmail.com> (Ben Peart's
        message of "Wed, 16 Aug 2017 10:06:18 -0400")
Message-ID: <xmqq4lt7pir9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBB68946-82A1-11E7-8F01-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>> -			warning("external filter requested unsupported filter capability '%s'",
>> -				p);
>> +			warning("subprocess '%s' requested unsupported capability '%s'",
>> +				process->argv[0], p);
>>   		}
>>   	}
>>   
>>
>
> This one is even cleaner.  Thanks Lars for pointing out the fact we
> already had the cmd name.  Looks good.

Thanks, all.  Will queue.


