Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7CF1F461
	for <e@80x24.org>; Wed, 17 Jul 2019 16:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfGQQDk (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 12:03:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60336 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGQQDk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 12:03:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F54D75A62;
        Wed, 17 Jul 2019 12:03:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JveLrjn8j6F53xvGArY4SP8B1Ns=; b=CepkcC
        N4XCw59JPe61ltmfQTy5MBdE8GGXJWEAsVnF9P81YI8rFQZWDaIqz/rKh74uKMIz
        eYtLK+omAMMlom3sxPNH2jxMrKy2xN2LILvzlRyqhSl64+AnfcPOKQJO+OveTmsc
        3zXmfsp7ctSCLdsdjDuXISBLViJ/EgkFSg0Cg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YQQjfj1BlyLgX9QbZsXUxR5sOdZAMeS4
        c7EJk7/Abn7qRTqcXiItjdhzzK3GnBHqknyKVfenGd/VjgjeEfDLQpfQFeymaO32
        AOR0hlHyCM2YdBADoJ+G+153/gy+UOJcjSEryPto89ZK5hyyFN3/Yoj3LlRzrmWD
        pTYBA1ageDY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47A0875A61;
        Wed, 17 Jul 2019 12:03:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6652675A5E;
        Wed, 17 Jul 2019 12:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC/PATCH] CodingGuidelines: spell out post-C89 rules
References: <20190702005340.66615-1-emilyshaffer@google.com>
        <20190709211043.48597-1-emilyshaffer@google.com>
        <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
        <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
        <xmqq4l3l520f.fsf_-_@gitster-ct.c.googlers.com>
        <20190717005537.GB93801@google.com>
Date:   Wed, 17 Jul 2019 09:03:32 -0700
In-Reply-To: <20190717005537.GB93801@google.com> (Jonathan Nieder's message of
        "Tue, 16 Jul 2019 17:55:37 -0700")
Message-ID: <xmqqv9w01wdn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E912D10-A8AC-11E9-8711-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Even though we have been sticking to C89, there are a few handy
>> features we borrow from more recent C language in our codebase after
>> trying them in weather balloons and saw that nobody screamed.
>>
>> Spell them out.
>
> Thanks for this.  It gives a place to advertise future weather balloons,
> too.
>
> [...]
>> --- a/Documentation/CodingGuidelines
>> +++ b/Documentation/CodingGuidelines
>> @@ -195,10 +195,24 @@ For C programs:
>>     by e.g. "echo DEVELOPER=1 >>config.mak".
>>  
>>   - We try to support a wide range of C compilers to compile Git with,
>> -   including old ones. That means that you should not use C99
>> -   initializers, even if a lot of compilers grok it.
>> +   including old ones. That means that you should not use certain C99
>> +   features, even if your compiler groks it.  There are a few

s/it/them/ I think.

>> +   exceptions:
>> +
>> +   . since early 2012 with e1327023ea, we have been using an enum
>> +     definition whose last element is followed by a comma.
>
> ...  Should we be even
> more prescriptive and say that the last element should always be
> followed by a comma, for ease of later patching?

That is an interesting tangent.  We have been taking advantage of
the trailing comma for array initializers (e.g. options[] fed to
parse_options() API)---we would gain similar convenience with it.

>> +
>> +   . since mid 2017 with cbc0f81d and 512f41cf, we have been using
>> +     designated initializers for struct and array.
>
> Can this include an example for the benefit of readers that don't know
> what a designated initializer is?

I thought about it, but decided against it, because those who really
want to are already given the commit object names to learn from, and
in larger context.

But if we are to split this into two bullet points (one for struct,
one for array), I am OK to add an example to it while at it.  Let me
see how it looks like.

>> +
>> +   These used to be forbidden, but we have not heard breakage report,
>> +   so they are assumed to be safe.
>
> nit: missing article "any" before "breakage reports".

Thanks.

-- >8 --
    
Even though we have been sticking to C89, there are a few handy
features we borrow from more recent C language in our codebase after
trying them in weather balloons and saw that nobody screamed.

Spell them out.

While at it, extend the existing variable declaration rule a bit to
read better with the newly spelled out rule for the for loop.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/CodingGuidelines | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

 Documentation/CodingGuidelines | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 32210a4386..bd4b7905d0 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -195,10 +195,30 @@ For C programs:
    by e.g. "echo DEVELOPER=1 >>config.mak".
 
  - We try to support a wide range of C compilers to compile Git with,
-   including old ones. That means that you should not use C99
-   initializers, even if a lot of compilers grok it.
+   including old ones.  You should not use features from newer C
+   standard, even if your compiler groks them.  
 
- - Variables have to be declared at the beginning of the block.
+   There are a few exceptions to this guideline:
+
+   . since early 2012 with e1327023ea, we have been using an enum
+     definition whose last element is followed by a comma.  This, like
+     an array initializer that ends with a trailing comma, can be used
+     to reduce the patch noise when adding a new identifer at the end.
+
+   . since mid 2017 with cbc0f81d, we have been using designated
+     initializers for struct (e.g. "struct t v = { .val = 'a' };").
+
+   . since mid 2017 with 512f41cf, we have been using designated
+     initializers for array (e.g. "int array[10] = { [5] = 2 }").
+
+   These used to be forbidden, but we have not heard any breakage
+   report, and they are assumed to be safe.
+
+ - Variables have to be declared at the beginning of the block, before
+   the first statement (i.e. -Wdeclaration-after-statement).
+
+ - Declaring a variable in the for loop "for (int i = 0; i < 10; i++)"
+   is still not allowed in this codebase.
 
  - NULL pointers shall be written as NULL, not as 0.
 
