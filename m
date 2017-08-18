Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D994B208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 14:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbdHROSm (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 10:18:42 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34531 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbdHROSk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 10:18:40 -0400
Received: by mail-qt0-f195.google.com with SMTP id i19so9036087qte.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uFCP8jKP3d56kywF6cRkvq+ucbEIFHddB+3m9Z+z0fg=;
        b=SUcUlAfPKum3A7dHtN8QeJqeYfDydz+CVXH8azmzE38LUm6+C4wCswpRPaoF1jL8Pa
         CZ6bgj/Di5WU2/64Ldv60rnozI1IbhIf4vRHVFQlgHlj0piXlLE+Rj8reI8nrWNsZeMW
         LD2sDqK6MyUmZvKQ/3lb1hLyq89pdIGv8xsXL7Exot9xhCtaY7gXPmWWKBVxiKRruwd+
         bF+Ag2CgvG75HTMYwOIcq/T7s6OaTe92R3IqTR2DqfQlSK3gWk0j9JdZdTrjrITYvpyg
         7KE3wbZ5ntLohAUpArt5q7//+3Deg4gua/YjSfCtsS8rKOlodf7iLRVg5Ww6eKU7theP
         AJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uFCP8jKP3d56kywF6cRkvq+ucbEIFHddB+3m9Z+z0fg=;
        b=M542HdFvDvcxwBYo+l/4m2F4aqXfp+w6VBWNSYraivoM7TlvsnOBVDg7MIKEI/iq3d
         +yrkgNEjjlgEz9E6oD1VFWUrJ9WM7QgdX3TaqzIcB89XrfaSNLXAbY593mtMX2SRbCAr
         2KLBHHaMi+m04kr6DOs9XuoSlOditVodfmkr+5MSC/Z86AhwSzxpa5t4p7QJvKwRqmu5
         hzq09/pSt6x8S1MpyscgZSKrqw1UpVUdEDiiIxdz3vPlW6wznWm7jfkPnoh1Nin1KZG0
         KZfwKgqBJdymMvhD0iGlpyL2CPndIoOigwhuCiHDaDjie7tZO3GMgOE6tk2DnRX9zIyk
         ZjHg==
X-Gm-Message-State: AHYfb5idAeFADj1m5Pk+mhZuix2S+YxbLHv60ntxbCKWToKtxr2UwGXr
        rFWVwsgtSpbwkQ==
X-Received: by 10.200.14.72 with SMTP id j8mr12637826qti.124.1503065919287;
        Fri, 18 Aug 2017 07:18:39 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id 5sm3712183qkf.12.2017.08.18.07.18.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2017 07:18:37 -0700 (PDT)
Subject: Re: [RFC PATCH] Updated "imported object" design
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jrnieder@gmail.com
References: <20170804145113.5ceafafa@twelve2.svl.corp.google.com>
 <20170816003200.19992-1-jonathantanmy@google.com>
 <xmqqa82zjlt4.fsf@gitster.mtv.corp.google.com>
 <20170816143515.0a74f959@twelve2.svl.corp.google.com>
 <c6787a0b-ba7c-106a-66bd-5c2d38752ccb@gmail.com>
 <20170817143905.2ef872e6@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <78139f5c-a044-9c00-11ff-eb91a70b6ab9@gmail.com>
Date:   Fri, 18 Aug 2017 10:18:37 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170817143905.2ef872e6@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/17/2017 5:39 PM, Jonathan Tan wrote:
> Thanks for your comments. I'll reply to both your e-mails in this one
> e-mail.
> 
>> This illustrates another place we need to resolve the
>> naming/vocabulary.  We should at least be consistent to make it easier
>> to discuss/explain.  We obviously went with "virtual" when building
>> GVFS but I'm OK with "lazy" as long as we're consistent.  Some
>> examples of how the naming can clarify or confuse:
>>
>> 'Promise-enable your repo by setting the "extensions.lazyObject" flag'
>>
>> 'Enable your repo to lazily fetch objects by setting the
>> "extensions.lazyObject"'
>>
>> 'Virtualize your repo by setting the "extensions.virtualize" flag'
>>
>> We may want to carry the same name into the filename we use to mark
>> the (virtualized/lazy/promised/imported) objects.
>>
>> (This reminds me that there are only 2 hard problems in computer
>> science...) ;)
> 
> Good point about the name. Maybe the 2nd one is the best? (Mainly
> because I would expect a "virtualized" repo to have virtual refs too.)
> 
> But if there was a good way to refer to the "anti-projection" in a
> virtualized system (that is, the "real" thing or "object" behind the
> "virtual" thing or "image"), then maybe the "virtualized" language is
> the best. (And I would gladly change - I'm having a hard time coming up
> with a name for the "anti-projection" in the "lazy" language.)
> 

The most common "anti-virtual" language I'm familiar with is "physical." 
  Virtual machine <-> physical machine. Virtual world <-> physical 
world. Virtual repo, commit, tree, blob - physical repo, commit, tree, 
blob. I'm not thrilled but I think it works...

> Also, I should probably standardize on "lazily fetch" instead of "lazily
> load". I didn't want to overlap with the existing fetching, but after
> some thought, it's probably better to do that. The explanation would
> thus be that you can either use the built-in Git fetcher (to be built,
> although I have an old version here [1]) or supply a custom fetcher.
> 
> [1] https://github.com/jonathantanmy/git/commits/partialclone
> 
>> I think this all works and would meet the requirements we've been
>> discussing.  The big trade off here vs what we first discussed with
>> promises is that we are generating the list of promises on the fly
>> when they are needed rather than downloading and maintaining a list
>> locally.
>>
>> My biggest concern with this model is the cost of opening and parsing
>> every imported object (loose and pack for local and alternates) to
>> build the oidset of promises.
>>
>> In fsck this probably won't be an issue as it already focuses on
>> correctness at the expense of speed.  I'm more worried about when we
>> add the same/similar logic into check_connected.  That impacts fetch,
>> clone, and receive_pack.
>>
>> I guess the only way we can know for sure it to do a perf test and
>> measure the impact.
> 
> As for fetching from the main repo, the connectivity check does not need
> to be performed at all because all objects are "imported", so the
> performance of the connectivity check does not matter. Same for cloning.
> 

Very good point! I got stuck on connectivity check in general forgetting 
that we really only need to prevent sharing a corrupt repo.

> This is not true if you're fetching from another repo 

This isn't a case we've explicitly dealt with (multiple remotes into a 
virtualized repo).  Our behavior today would be that once you set the 
"virtual repo" flag on the repo (this happens at clone for us), all 
remotes are treated as virtual as well (ie we don't differentiate 
behavior based on which remote was used).  Our "custom fetcher" always 
uses "origin" and some custom settings for a cache-server saved in the 
.git/config file when asked to fetch missing objects.

This is probably a good model to stick with at least initially as trying 
to solve multiple possible "virtual" remotes as well as mingling 
virtualized and non-virtualized remotes and all the mixed cases that can 
come up makes my head hurt.  We should probably address that in a 
different thread. :)

> or if you're using
> receive-pack, but (1) I think these are not used as much in such a
> situation, and (2) if you do use them, the slowness only "kicks in" if
> you do not have the objects referred to (whether non-"imported" or
> "imported") and thus have to check the references in all "imported"
> objects.
> 

Is there any case where receive-pack is used on the client side?  I'm 
only aware of it being used on the server side to receive packs pushed 
from the client.  If it is not used in a virtualized client, then we 
would not need to do anything different for receive-pack.

>> I think this topic should continue to move forward so that we can
>> provide reasonable connectivity tests for fsck and check_connected in
>> the face of partial clones.  I'm not sure the prototype implementation
>> of reading/parsing all imported objects to build the promised oidset is
>> the most performant model but we can continue to investigate the best
>> options.
> 
> Agreed - I think the most important thing here is settling on the API
> (name of extension and the nature of the object mark).
> 
>> Given all we need is an existance check for a given oid,
> 
> This is true...
> 
>> I wonder if it
>> would be faster overall to do a binary search through the list of
>> imported idx files + an existence test for an imported loose object.
> 
> ...but what we're checking is the existence of a reference, not the
> existence of an object. For a concrete example, consider what happens if
> we both have an "imported" tree and a non-"imported" tree that
> references a blob that we do not have. When checking the non-"imported"
> tree for connectivity, we have to iterate through all "imported" trees
> to see if any can vouch for the existence of such a blob. We cannot
> merely binary-search the .idx file.
> 

That is another good point.  Given the discussion above about not 
needing to do the connectivity test for fetch/clone - the potential perf 
hit of loading/parsing all the various objects to build up the oidset is 
much less of an issue.

