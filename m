Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D75208D0
	for <e@80x24.org>; Thu, 17 Aug 2017 20:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbdHQUui (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 16:50:38 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38903 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752820AbdHQUuh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 16:50:37 -0400
Received: by mail-qk0-f196.google.com with SMTP id m84so7106035qki.5
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7HeXdAv4tZfWrHHT+e3CByv9UnMCd34bQ7pCGAFKen8=;
        b=TR9oqYoLPpBte56eZrdFKslDYaSck7g0r44+ERGxLa/jLBADC3PfErJLSqn7rJW4NK
         SSD5EzVCWVOfJ5tUPezT+5O9JB5j+O2Zpl63MRSL4fN3sOkpJo/oyfqXpfuzp0wZnXOO
         K5+KiJFeCGS5Y7ZfPbpn5Kn0Lw1IJ0IoLi3jrdKttdwovjsE/IATpDB/Op34rpbyZn1J
         dgA3KOMfpkgOaGkkvvE5KPFjceFW3rnOVOGePDKTPyPCU6RBzyv3L/1H0pD2jqgH4IGV
         lrjt3GCYI2t1xaFr13+f1Q7jFO09w1nfad84kBjC6Iv2IRRafMBeo1yT7cnCSxUxq5jd
         0rtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7HeXdAv4tZfWrHHT+e3CByv9UnMCd34bQ7pCGAFKen8=;
        b=gQKncCXcQBkR/zJwLeC8H5ScoXMl+K3q5/ExY3o8cbbFB8PXDAY9PIWmWStgB8hU5q
         qdz8Zav8nTbnKejBZD8LSm8GfJo8eF+mnfUGeyEuWBilR/32En+YsdltgcAsFHcGtDiA
         yXZ3h63+Ab99RaCXmoZyjF4eQVAgHKArNAEjLUaTvjqsJ9NbMt4iiCP/hquy/RpW5Yrf
         iyJCt6TTqsXJv57g2jlfJycfSr4FL0ihRILffo61cE/SaAmXAG+D6N9zMx4eysKr1YpV
         KIr0UmhY25+QI0U1MyzaROX+en+WT5YLWmrgAJwD63QXZTQicE48wyrhYHED2oV7N/qd
         W16g==
X-Gm-Message-State: AHYfb5j7ApipaIIXTFG4OIf2l6lUDQVPVQv/Q5M0PSAsXYllUAoi83l0
        fiOx39F52NgFNw==
X-Received: by 10.55.43.78 with SMTP id r75mr9661905qkh.244.1503003036149;
        Thu, 17 Aug 2017 13:50:36 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id f4sm2796198qtg.39.2017.08.17.13.50.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2017 13:50:35 -0700 (PDT)
Subject: Re: [RFC PATCH] Updated "imported object" design
To:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
 <20170816003200.19992-1-jonathantanmy@google.com>
 <xmqqa82zjlt4.fsf@gitster.mtv.corp.google.com>
 <20170816143515.0a74f959@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c6787a0b-ba7c-106a-66bd-5c2d38752ccb@gmail.com>
Date:   Thu, 17 Aug 2017 16:50:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170816143515.0a74f959@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/16/2017 5:35 PM, Jonathan Tan wrote:
> On Wed, 16 Aug 2017 13:32:23 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Jonathan Tan <jonathantanmy@google.com> writes:
>>
>>> Also, let me know if there's a better way to send out these patches for
>>> review. Some of the code here has been reviewed before, for example.
>>>
>>> [1] https://public-inbox.org/git/cover.1502241234.git.jonathantanmy@google.com/
>>>
>>> [2] https://public-inbox.org/git/ffb734d277132802bcc25baa13e8ede3490af62a.1501532294.git.jonathantanmy@google.com/
>>>
>>> [3] https://public-inbox.org/git/20170807161031.7c4eae50@twelve2.svl.corp.google.com/
>>
>> ... and some of the code exists only in the list archive, so we
>> don't know which other topic if any we may want to eject tentatively
>> if we wanted to give precedence to move this topic forward over
>> others.  I'll worry about it later but help from others is also
>> appreciated.
> 
> Thanks - I can help take a look when it is time to move the code in.
> 

I agree that having this depend on patches elsewhere in the list archive 
makes it more difficult to review.  I know I like to see things in 
context to get a better picture.

> I think the issue here is whether we want to move this topic forward or
> not, that is, if this (special ".imported" objects) is the best way to
> solve (at least partially) the connectivity check part of tolerating
> missing objects. I hope that we can continue to talk about it.
> 

I think this topic should continue to move forward so that we can 
provide reasonable connectivity tests for fsck and check_connected in 
the face of partial clones.  I'm not sure the prototype implementation 
of reading/parsing all imported objects to build the promised oidset is 
the most performant model but we can continue to investigate the best 
options.

>> This collects names of the objects that are _directly_ referred to
>> by imported objects.  An imported pack may have a commit, whose
>> top-level tree may or may not appear in the same pack, or the tree
>> may exist locally but not in the same pack.  Or the tree may not be
>> locally available at all.  In any of these four cases, the top-level
>> tree is listed in the "promises" set.  Same for trees and tags.
>>
>> I wonder if all of the calls to oidset_insert() in this function
>> want to be guarded by "mark it as promised only when the referrent
>> is *not* locally available" to keep the promises set minimally
>> populated.  The only change needed to fsck in order to make it
>> refrain from treating a missing but promised object as an error
>> would be:
>>
>>          -       if (object is missing)
>>          +       if (object is missing && object is not promised)
>>                          error("that object must be there but missing");
>>
>> so there is no point in throwing something that we know we locally
>> have in this oidset, right?
>>
>> On the other hand, cost of such additional checks in this function
>> may outweigh the savings of both memory pressure and look-up cost,
>> so I do not know how the tradeoff would turn out.
> 
> I also don't know how the tradeoff would turn out, so I leaned towards
> the slightly simpler solution of not doing the check. In the future,
> maybe a t/perf test can be done to decide between the two.
> 
>>> +static int is_promise(const struct object_id *oid)
>>> +{
>>> +	if (!promises_prepared) {
>>> +		if (repository_format_lazy_object)
>>> +			for_each_packed_object(add_promise, NULL,
>>> +					       FOR_EACH_OBJECT_IMPORTED_ONLY);
>>> +		promises_prepared = 1;
>>> +	}
>>> +	return oidset_contains(&promises, oid);
>>> +}
>>
>> Somehow I'm tempted to call this function "is_promised()" but that
>> is a minor naming issue.
> 

Given all we need is an existance check for a given oid, I wonder if it 
would be faster overall to do a binary search through the list of 
imported idx files + an existence test for an imported loose object.

Especially in the check_connected case which isn't verifying every 
object, that should be a lot less IO than loading all the imported 
commits, trees and blobs and pre-computing an oidset of all possible 
objects.  The lookup for each object would be slower than a simple call 
to oidset_contains but we avoid the up front cost.

With some caching of idx files and threading, I suspect this could be 
made pretty fast.

> I was trying to be consistent in using the name "promise" instead of
> "promised object/tag/commit/tree/blob" everywhere, but we can switch if
> need be (for example, if we don't want to limit the generic name
> "promise" to merely objects).
> 
>>>   static const char *describe_object(struct object *obj)
>>>   {
>>>   	static struct strbuf buf = STRBUF_INIT;
>>> @@ -410,7 +472,7 @@ static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
>>>   					xstrfmt("%s@{%"PRItime"}", refname, timestamp));
>>>   			obj->used = 1;
>>>   			mark_object_reachable(obj);
>>> -		} else {
>>> +		} else if (!is_promise(oid)) {
>>>   			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
>>>   			errors_found |= ERROR_REACHABLE;
>>>   		}
>>
>> This is about certainly is one place we want to check if the missing
>> object is OK, but I'm a bit surprised if this were the only place.
>>
>> Don't we need "while trying to follow all the outgoing links from
>> this tree object, and we found this object is not available locally;
>> normally we would mark it as an error but it turns out that the
>> missing one is in the promised set of objects, so it is OK" for the
>> normal connectivity traversal codepaths, for example?
> 
> That's right. The places to make this change are the same as those in
> some earlier patches I sent (patches 2-4 in [1]).
> 
> [1] https://public-inbox.org/git/cover.1501532294.git.jonathantanmy@google.com/
> 
