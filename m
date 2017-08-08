Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA1520899
	for <e@80x24.org>; Tue,  8 Aug 2017 16:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdHHQpo (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 12:45:44 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36398 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbdHHQpn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 12:45:43 -0400
Received: by mail-qt0-f193.google.com with SMTP id c15so3650014qta.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZEjhdz/kzlYplLR2+/NKNhfeODFSSG0reQHk3LrURnk=;
        b=PKCesuminaAc6LTOkOSHE4LT0nrqO7a6cdKTinH9mfq1mc7RLDJkRql2OcOeD/v0Ns
         sPHfv6BiFuaSdyE59oeGdukdzJR86MIV+7gidUnvDGriwyIFj/++/Rs32rOqosdX84Qf
         dPkX+hek1INTDVQYfPzFsAH8fAgCD2pNvgme9LT4Y5NEvF22U7+lHcZw2pWQxpauU99K
         QAiX9kUwYnD7E1+/6oSx0Jku2pU7698FL9AZmJ+8jn+GHezP/cbyLvUUVoD0wZl3cgXA
         1/2NuitJlIlvwF7oVcg9pbsBxrPMpaDgLLhtuayHbFPD1JoWhdCR8Ivem6E/FHl2HnGa
         J7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZEjhdz/kzlYplLR2+/NKNhfeODFSSG0reQHk3LrURnk=;
        b=ZwjicvEmW+fJVFClxDaH8Qm8NgN8DB12Tz4lKoXDrPBGzOUBIuR0mypbL2MfN0WgwC
         mEv4yD4OZV5Lh4Gtxy0vtNM5xAOnEXo0NIaxqeJ99L+ZMRqpgkOq6lccRprLMcHrGMZ+
         /8ENTUABtgSXpMfW8m8IANGVFes4WEcw0VskGn95ikq7H9xn4PaAZDGiRtaZiTnQ9DVF
         0n7SkpGzkhgdRihsdoY1mq/qTzOBt9RCODv6MfNG15FU8HoWNVFPFyTu9rYqMsdnksW9
         PEZlcwUrESmbZXIfIu3H/xZIMjCUnGbtHNvfjOmBE/qCcGdtLm2gXmt/OFSoyPKsglcx
         0fFw==
X-Gm-Message-State: AHYfb5jQFDLnBvvVvhDgQvsLeR+1oYq6WGHiFWxD10C24ddENqcwD/TL
        mGjfBxXT9z1l6g==
X-Received: by 10.200.52.115 with SMTP id v48mr6826585qtb.225.1502210742663;
        Tue, 08 Aug 2017 09:45:42 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id q1sm820323qti.46.2017.08.08.09.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2017 09:45:42 -0700 (PDT)
Subject: Re: Partial clone design (with connectivity check for locally-created
 objects)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        christian.couder@gmail.com
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
 <xmqqtw1nrlpf.fsf@gitster.mtv.corp.google.com>
 <20170804172137.42f27653@twelve2.svl.corp.google.com>
 <0633771f-ce19-6211-fabe-3f7f676e53ab@gmail.com>
 <xmqqwp6fp3mk.fsf@gitster.mtv.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <693596b8-7a84-bcc8-7eef-2d534293e14b@gmail.com>
Date:   Tue, 8 Aug 2017 12:45:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqwp6fp3mk.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/7/2017 3:41 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> My concern with this proposal is the combination of 1) writing a new
>> pack file for every git command that ends up bringing down a missing
>> object and 2) gc not compressing those pack files into a single pack
>> file.
> 
> Your noticing these is a sign that you read the outline of the
> design correctly, I think.
> 
> The basic idea is that the local fsck should tolerate missing
> objects when they are known to be obtainable from that external
> service, but should still be able to diagnose missing objects that
> we do not know if the external service has, especially the ones that
> have been newly created locally and not yet made available to them
> by pushing them back.
> 

This helps me a lot as now I think I understand the primary requirement 
we're trying to solve for.  Let me rephrase it and see if this makes sense:

We need to be able to identify whether an object was created locally 
(and should pass more strict fsck/connectivity tests) or whether it came 
from a remote (and so any missing objects could presumably be fetched 
from the server).

I agree it would be nice to solve this (and not just punt fsck - even if 
it is an opt-in behavior).

We've discussed a couple of different possible solutions, each of which 
have different tradeoffs.  Let me try to summarize here and perhaps 
suggest some other possibilities:


Promised list
-------------
This provides an external data structure that allowed us to flag objects 
that came from a remote server (vs created locally).

The biggest drawback is that this data structure can get very large and 
become difficult/expensive to generate/transfer/maintain.

It also (at least in one proposal) required protocol and server side 
changes to support it.


Annotated via filename
----------------------
This idea is to annotate the file names of objects that came from a 
remote server (pack files and loose objects) with a unique file 
extension (.remote) that indicates whether they are locally created or not.

To make this work, git must understand about both types of loose objects 
and pack files and search in both locations when looking for objects.

Another drawback of this is that commands (repack, gc) that optimize 
loose objects and pack files must now be aware of the different 
extensions and handle both while not merging remote and non-remote objects.

In short, we're creating separate object stores - one for locally 
created objects and one for everything else.


Now a couple of different ideas:

Annotated via flags
===================
The fundamental idea here is that we add the ability to flag locally 
created objects on the object itself.

Given that at the core, "Git is a simple key-value data store" can we 
take advantage of that fact and include a "locally created" bit as a 
property on every object?

I could not think of a good way to accomplish this as it is ultimately 
changing the object format which creates rapidly expanding ripples of 
change.

For example, The object header currently includes the type a space, the 
length and a null. Even if we could add a "local" property (either by 
adding a 5th item, taking over the space, creating new object types, 
etc), the fact that the header is included in the sha1 means that push 
would become problematic as flipping the bit would change the sha and 
the trees and commits that reference it.


Local list
----------
Given the number of locally created objects is usually very small in 
comparison to the total number of objects (even just due to history), it 
makes more sense to track locally created objects instead of 
promised/remote objects.

The biggest advantage of this over the "promised list" is that the 
"local list" being maintained is _significantly_ smaller (often orders 
of magnitude smaller).

Another advantage over the "promised list" solution is that it doesn't 
require any server side or protocol changes.

On the client when objects are created (write_loose_object?) the new 
objects are added to the "local list" and in the connectivity check 
(fsck) if the object is not in the "local list," the connectivity check 
can be skipped as any missing object can presumably be retrieved from 
the server.

A simple file format could be used (header + list of SHA1 values) and 
write_loose_object could do a trivial append. In fsck, the file could be 
loaded into a hashmap to make for fast existence checks.

Entries could be removed from the "local list" for objects later fetched 
from a server (though I had a hard time contriving a scenario where this 
would happen so I consider this optional).

On the surface, this seems like the simplest solution that meets the 
stated requirements.


Object DB
---------
This is a different way of providing separate object stores than the 
"Annotated via filename" proposal. It should be a cleaner/more elegant 
solution that enables several other capabilities but it is also more 
work to implement (isn't that always the case?).

We create an object store abstraction layer that enables multiple object 
store providers to exist. The order that they are called should be 
configurable based on the command (esp have/read vs create/write). This 
enables features like tiered storage: in memory, pack, loose, alternate, 
large, remote.

The connectivity check in fsck would then only traverse and validate 
objects that existed via the local object store providers.

While I like the flexibility of this design and hope we can obtain it in 
the long term for it's other benefits, it's a bit overkill for this 
specific problem. The big drawback of this model is the cost to design 
and implement it.

