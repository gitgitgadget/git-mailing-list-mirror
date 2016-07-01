Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0AA420FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 10:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbcGAJ7w (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 05:59:52 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37278 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbcGAJ7t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 05:59:49 -0400
Received: by mail-wm0-f46.google.com with SMTP id a66so21901563wme.0
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 02:59:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=j+G8BZYZlZbckaa+Lrq0+cTWJUDLAKQU180b1Bxtdlw=;
        b=Mpcm6MCUk9CAge6XjYznLk8mSYLMA37ZkakrjKYlTXrttrWU2jajksfr2m62K8PRIQ
         sOhLWkt2ba9upWL0/1uZP7k6BeqeBlOxlBpLVPOQmAyiZX1VRNz7ouPiX+ClMRlmhJ+6
         nMzc80bqvrNKWXBZUL9fMvs+Smbe+qdVMQxRQA2pKA9r5zc9H1NXO10B7088AvuSczg5
         LO2fD6sEcK6VK1M58Itmk4TULWcMyjWvevd0THUnuokYnhvIYL/gwgcsrF/156l21xYG
         bIfcx1bkQb/jiR20MMkxrYgPTg9tLoyXTvGmOIBaz6izNd9gxe6kKN7y1Tr2vBG57TVh
         VNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=j+G8BZYZlZbckaa+Lrq0+cTWJUDLAKQU180b1Bxtdlw=;
        b=EZb3P3mWxrNf1dzHh1Rp3YUh8ucpEo7jGQElLY8FNEQom6GXA80mjkXVRlQ+A+KGOU
         VIg+v3wmEvJ9wueijBAL+ESl0yv4wMQIB2/PbZ66ieClVkeAD9xn9T+/0YczNVER8sJs
         YMvlReXIIE/+CVq+G20PpFUX3laA7wj7KxatbjxBYcxsVwuvbtFKqtnR6aHV0aBjLWOx
         8T8eycXJKmzGgiwMynZ84mo0ahN4oEKwRM9LM4H2Wjql3S9cKKjb4Lb3tjbtNRY4JEnL
         /Sq0TQ5LCCRdlOcU0h02SzjNu5xukx/fq0g0Qr1WVw9zWy/yGeL3GptELZ3uJwDFWDYj
         sJvw==
X-Gm-Message-State: ALyK8tJM0l0WKhEiU5IKMMupQHkL0mfnqCsOagp9cfejAnpjycjK0EpqE5H+cJbHy3m/1Q==
X-Received: by 10.28.197.132 with SMTP id v126mr18250032wmf.8.1467367187660;
        Fri, 01 Jul 2016 02:59:47 -0700 (PDT)
Received: from [192.168.1.34] (enw201.neoplus.adsl.tpnet.pl. [83.20.12.201])
        by smtp.googlemail.com with ESMTPSA id b84sm3437762wmb.6.2016.07.01.02.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jul 2016 02:59:46 -0700 (PDT)
Subject: Re: topological index field for commit objects
To:	Jeff King <peff@peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net> <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net> <5774F4C7.805@gmail.com>
 <20160701065452.GE5358@sigill.intra.peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <57763F00.4070409@gmail.com>
Date:	Fri, 1 Jul 2016 11:59:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20160701065452.GE5358@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-01 o 08:54, Jeff King pisze:
> On Thu, Jun 30, 2016 at 12:30:31PM +0200, Jakub Narębski wrote:
> 
>>> This is one of the open questions. My older patches turned them off when
>>> replacements and grafts are in effect.
>>
>> Well, if you store the cache of generation numbers in the packfile, or in
>> the index of the packfile, or in the bitmap file, or in separate bitmap-like
>> file, generating them on repack, then of course any grafts or replacements
>> invalidate them... though for low level commands (like object counting)
>> replacements are transparent -- or rather they are (and can be) treated as
>> any other ref for reachability analysis.
>>
>> Well, if there are no grafts, you could still use them for doing
>> "git --no-replace-objects log ...", isn't it?
> 
> Yes, replace refs don't invalidate the concept of a cache. It just
> means that you invalidate the invariants of the cache for a specific
> view, so you need a cache which matches that view.
> 
> It has been several years, but I remember at one point having patches
> that summarized the graft/replace state as a single hash, and only used
> the cache if it matched that state. So you could actually keep a cache
> for some set of replace-refs that you have, as well as a cache for the
> case that you've turned them off, etc.
> 
> I don't think that level of complexity is really worth it, though.

Well, you could always update the reachability-helpers cache when running
`git replace` command, and when fetching into 'refs/replace' namespace...

...but this wouldn't take into account the fact that you can change
replace refs "by hand", and that grafts file^{1} is only editable by hand.
So at query time Git would need to check (e.g. via hash of graft file,
hash of packed-refs refs/replace namespace, concatenated) that said
cache is still valid for replace-respecting view. And perhaps update
said cache.

Though if we limit ourself to the replacements mechanism, we could
have a configuration variable saying "I will manipulate replacements
only using git-replace, and I want faster reachability", isn't it?


1.) Can we deprecate and remove grafts mechanism now that we have superior
solution and migration mechanism? 
 
>>>>> I have patches that generate and store the numbers at pack time, similar
>>>>> to the way we do the reachability bitmaps.
>>
>> Ah, so those cached generation numbers are generated and stored at pack
>> time. Where you store them: is it a separate file? Bitmap file? Packfile?
> 
> There were a few iterations of the concept over the years, but the
> pack-time one uses a separate file with the same name prefix as a pack
> (similar to the way bitmaps are stored). The big advantage there is that
> we can piggy-back on the pack .idx to avoid having to write each sha1
> again (20 bytes per commit, whereas the actual data we're caching is
> only 4 bytes).

Does it use any lightweight compression mechanism, or is it not needed?
How does the format of this file looks like?
 
>>> At GitHub we are using them for --contains analysis, along with mass
>>> ahead/behind (e.g., as in https://github.com/gitster/git/branches). My
>>> plan is to send patches upstream, but they need some cleanup first.
>>
>> That would be nice to have, please.
>>
>> Er, is mass ahead/behind something that can be plugged into Git
>> (e.g. for "git branch -v -v"), or is it something GitHub-specific?
> 
> We have a custom command, "git ahead-behind", where you can specify
> arbitrary pairs of commits on stdin. But it's all backed by a function
> which, yes, could be plugged into "branch -v -v". It caches any bitmaps
> it needs, so if you are doing 100 ahead/behind comparisons against
> "master", for example, it only has to find the bitmap for "master" once
> (remember that we sometimes have to traverse to complete a bitmap when
> a branch has been updated since the last repack).

That would be nice to have (perhaps invoked only if number of branches
is high enough; that excludes using it for ahead-behind information that
`git checkout` prints).

-- 
Jakub Narębski

