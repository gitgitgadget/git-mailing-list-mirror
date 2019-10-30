Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44AE21F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 02:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfJ3CIc (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 22:08:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55160 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfJ3CIc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 22:08:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 471071CE7E;
        Tue, 29 Oct 2019 22:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9cH9ceF4V38k2Uj2Rs1HV94fq7k=; b=d5QcmE
        nwC23lBcUKK1XWrtLfXE3N78vywZSk8O/hnLdC3myW2COhWYSJnjxDAmqRDQUbZp
        lbfqUWZiUZhGoMXcaL7Zo3Krq639ihwgZnr9UGeS55CJhL/gf0EPZ2vwewo23QvQ
        klgLjq7MlYnhRGhVQoPyCMS7umU+7G4rJS4qc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aNdu42gZdYsvmjbc3UFYs13lBtRXukag
        iBa6YeaeDcIxbiMdOc3ktbDZdlRDMATgq0gfRyh4jXqOhqQDsRe0d0rcNXALsWSi
        GzUDZkmSWbn/ZguXe4iVbiVfYyPfe75ricngE5biJuv4N+bgoHoPyZ2IUgKMBum3
        vTBHNDtQduA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EA771CE7D;
        Tue, 29 Oct 2019 22:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A66301CE7C;
        Tue, 29 Oct 2019 22:08:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-diff.txt: document return code of `--no-index`
References: <3f6d132663cacde01df68bfe88c6ef108cf6cf74.1572337045.git.liu.denton@gmail.com>
        <nycvar.QRO.7.76.6.1910291405090.46@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Oct 2019 11:08:28 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1910291405090.46@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 29 Oct 2019 14:06:38 +0100 (CET)")
Message-ID: <xmqqftjb3rz7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2A97EF1C-FABA-11E9-8719-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> @@ -36,7 +36,10 @@ two blob objects, or changes between two files on disk.
>>  	running the command in a working tree controlled by Git and
>>  	at least one of the paths points outside the working tree,
>>  	or when running the command outside a working tree
>> -	controlled by Git.
>> +	controlled by Git. With `--no-index`,
>> +	the program exits with codes similar to diff(1). That is, it
>> +	exits with 1 if there were differences and 0 means no
>> +	differences.
>
> ... a shorter alternative would be to state: This implies `--exit-code`.

Yup, that is great.  Short and to the point.
