Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC7B1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 21:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFNVA7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 17:00:59 -0400
Received: from e2i236.smtp2go.com ([103.2.140.236]:52665 "EHLO
        e2i236.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNVA7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 17:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=m1fbw0.a1-4.dyn; x=1560546958; h=Feedback-ID:
        X-Smtpcorp-Track:Date:Message-ID:From:To:Subject:Reply-To:Sender:
        List-Unsubscribe; bh=wnJ594kWNyMySW755fnLtorz6Wemz+NwEAbjnzj6ttI=; b=DKOZmwM7
        U7RlN2Sn1prQJaZPRFpgwt91F+op4Q60Pn1CMCG3AK+gG1O+irf5IkwiCcdwe3CGJf7rxV7+XVR1j
        /SMPz7V8OAUVo7v/jS/06QVpgq7+I7OJH30TJbKW6Ja+AkAYESo9WyzoCj5RZIskDCODveYv0EDuY
        WRr5DKxu6vqArhPCILw+Kmw3fXIVi8E6eH7IXwi6H9kxatgOuNYiI6mxVxYbfnI2uVZOekx+G6Nwt
        VpdYUJl8J9aWgMIeOBeiAxqydprJM0PMIFwvpzv5BD3JWlvHfFp1Jsgbpprtk8BAxe7Ep7nVGjYXZ
        kmJjmvKfW9lCAKTyP86NhR8j+A==;
Received: from [10.176.58.103] (helo=SmtpCorp)
        by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92-S2G)
        (envelope-from <philipoakley@iee.org>)
        id 1hbtJf-cp4UQt-CN; Fri, 14 Jun 2019 21:00:55 +0000
Received: from [10.90.199.94] (helo=[10.192.168.0])
        by smtpcorp.com with esmtp (Exim 4.92-S2G)
        (envelope-from <philipoakley@iee.org>)
        id 1hbtJf-9EFQBQ-08; Fri, 14 Jun 2019 21:00:55 +0000
Subject: Re: [RFC/PATCH v2] doc branch: provide examples for listing remote
 tracking branches
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Cc:     GitList <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <2ea35ad4-4b33-0ece-4de4-b2e92a100d9a@iee.org>
 <20190528231605.10108-1-philipoakley@iee.org>
 <xmqqtvcxmig3.fsf@gitster-ct.c.googlers.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <024373d9-e032-1af8-ba26-439ad5620bf5@iee.org>
Date:   Fri, 14 Jun 2019 22:00:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqtvcxmig3.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Smtpcorp-Track: 1hPtJf9EFQUQ08.ULsEBfVFQ
Feedback-ID: 66524m:66524aMf6O2Y:66524sDMpfAVPy_
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 10/06/2019 18:57, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.org> writes:
>
>> The availability of these pattern selections is not obvious from
>> the man pages, as per mail thread <87lfz3vcbt.fsf@evledraar.gmail.com>.
>>
>> Provide examples.
>>
>> Re-order the `git branch` synopsis to emphasise the `--list <pattern>`
>> pairing. Also expand and reposition the `all/remotes` options.
>>
>> Split the over-long description into three parts so that the <pattern>
>> description can be seen.
>>
>> Clarify that the `all/remotes` options require the --list if patterns
>> are to be used.
>>
>> Add examples of listing remote tracking branches that match a pattern,
>> including `git for-each-ref` which has more options.
>>
>> Improve the -a/-r warning message. The message confused this author
>> as the combined -a and -r options had not been given, though a pattern
>> had. Specifically guide the user that maybe they needed the --list
>> option to enable a remote branch pattern selection.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>>
>> in response to
>> <2ea35ad4-4b33-0ece-4de4-b2e92a100d9a@iee.org>
>> thread: https://public-inbox.org/git/?q=%3CCACsJy8CwY8gzeWa9kNRX3ecez1JGiQiaOknbAoU7S%2BhiXBoUGQ%40mail.gmail.com%3E
>>
>> to: Git Mailing List <git@vger.kernel.org>
>> cc: Duy Nguyen <pclouds@gmail.com>
>> cc: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> cc: Junio C Hamano <gitster@pobox.com>
> This looks reasonable to me---is it ready to go even with its RFC prefix?

Yes; the RFC was only in regard of the die() message change as it 
touches real code;-)


Following the post, Stolee's coverage report, it was noted that the 
die() wasn't actually tested, so I sent a quick follow-up of a potential 
test 
https://public-inbox.org/git/f28dd5b1-fda8-cf51-5582-067a7d2c2472@iee.org/ 
which is a proper RFC...


I did not attempt to see if any other dies()'s were untested, just 
copied one that was..

Philip

(currently travelling)

