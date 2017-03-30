Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF5BD20966
	for <e@80x24.org>; Thu, 30 Mar 2017 17:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934172AbdC3Rai (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 13:30:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55341 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933259AbdC3Rah (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 13:30:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79FD06C931;
        Thu, 30 Mar 2017 13:30:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BSRdV0iFtVYEFSuQEcXNHAspI5A=; b=nLLw6C
        im0xNG2mjxkc1BX+fznNZjPWIwxbi4TCyaom5H8sC8v4Cq8BYHxe6wZ8J/W2V+QM
        Ae51gS75hqQqvta77LWhrj6w8ZU/HZJPQGr2Pp6QIEPCuWxkpKHAut8OKqIHrhCi
        yVqeyM8+ZJ5/6O3uKTKDoMHfbHpncM8iaS36c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Oxa8s8rYUdPEg2zWz125nOhNbLhQOpiM
        6RT5iWwF2oztgTVFXa6IabhpyYTIlePEr6t3D+bz+X2BIfUnPTTQx6spaM6+xszL
        7ncEXfPWVcGW0kAsHY21NsvCuK25i1lnYKyjZB2jE98kXLJMFVCCtElLvZDx1iiW
        EJI9js7mpjQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 727596C930;
        Thu, 30 Mar 2017 13:30:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9CB36C92F;
        Thu, 30 Mar 2017 13:30:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v2 0/3] name-rev sanity
References: <xmqqa88j5xsx.fsf@gitster.mtv.corp.google.com>
        <cover.1490798142.git.git@grubix.eu>
        <xmqq4lycatsu.fsf@gitster.mtv.corp.google.com>
        <xmqqvaqs9dws.fsf@gitster.mtv.corp.google.com>
        <12937baf-f36d-836c-612d-72578a5929b4@grubix.eu>
Date:   Thu, 30 Mar 2017 10:30:18 -0700
In-Reply-To: <12937baf-f36d-836c-612d-72578a5929b4@grubix.eu> (Michael
        J. Gruber's message of "Thu, 30 Mar 2017 15:48:12 +0200")
Message-ID: <xmqqinmq65at.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C182510-156E-11E7-B955-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Junio C Hamano venit, vidit, dixit 29.03.2017 19:43:
> ...
>> Ah, of course, you are depending on your other topic ;-)
>> I'll wiggle these in.
>> 
>> Thanks.
>
> Yes, sorry, isn't that in next already? I should have meantioned it anyways.

No worries.  jc/name-rev was meant to be replaced.

> Also, I should split patch 3 into name-rev and describe related parts
> and update the name-rev documentation. We don't have tests for describe
> --debug, that should be ok.

OK.  I do not think these three patches are in 'next' yet, so feel
free to further replace the last one (or for that matter the first
two as necessary).  I do not think we want to cast the debugging
information in stone, but it would not hurt if you made sure that
"describe --debug [--contains]" does not dump core ;-)

Thanks.
