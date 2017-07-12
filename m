Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A24A202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 23:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750969AbdGLXmo (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 19:42:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36088 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750755AbdGLXmn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 19:42:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id 77so7825783wrb.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yNsPGTGcu9QMX4lUjHtC7dQ13Upq8fOO+weakMs3mKI=;
        b=qEJeS6dGbzRcID33N/wRXXA5xXvOQ6vos2jIOasbr1x8ArJ4IEGw5DAfFG6qDsF0n0
         yzcCJvkbIbYErqthcYSBlFy2g3J0IUBErrgA7x76z8iXF57eNXh47aWzU2d9g08U9hFq
         R4CgrWlzHvx5drafW1PTlloMg0CPmfq+f3Oxm96uWQnKm3LXY4AISDcOsQdZ1kiQ86oZ
         k8Uw7JDa1/+rGy4FHtwwBf1XiJpD/rOInlV91Q1uQeZAtYDZ4HeWsSXXLw8aUKvIVbYQ
         71pbBDUOGvQzdvWryHRtt/2ORoJkGQD6C3dS/yPCliJTTsDmgMM5S6wRMzbWO7SJEQpd
         LQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yNsPGTGcu9QMX4lUjHtC7dQ13Upq8fOO+weakMs3mKI=;
        b=QEmy78CxwIEtacbgA0tv8XTwlsNVqS+h2GAhHxNK14oXqol9DOzZb66ByRL/0DVord
         noA2VcEAK99gvddJDPjZ+39zdeskBRLjB3GvvB7VBWlJOuWoQ18CGr/aR1d1h4ig2XJB
         qoJdZNZA1QoKpuZSc5t9ePg9SdV600/0ARv0uRVZhMxu4XGPs8dcXgr0ge/7q9d72Jv3
         zk0c+da/KkuaoijB2Apnp5DjwDuVZwaIQb01cL572G3exyXEeh63pCNwawoHgJX9vyb5
         x/UlgVUZrBhr3HBkDXBqTA8eNjXVgLiLPu2Zf+yL6Fey53LXse1vL5WDMk8bmWZOnoYR
         fWRg==
X-Gm-Message-State: AIVw111fJm1teBRpRFUK/LW70QxHSlctGH8yJgX7vIopl0vn42gtTAB0
        FpXD6+xpgugWZg==
X-Received: by 10.223.179.65 with SMTP id k1mr501270wrd.5.1499902962353;
        Wed, 12 Jul 2017 16:42:42 -0700 (PDT)
Received: from [192.168.10.150] (94-39-191-51.adsl-ull.clienti.tiscali.it. [94.39.191.51])
        by smtp.googlemail.com with ESMTPSA id d1sm4301913wra.43.2017.07.12.16.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jul 2017 16:42:40 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] interpret-trailers: add --where, --if-exists,
 --if-missing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20170712222116.7095-1-bonzini@gnu.org>
 <xmqqmv89z2be.fsf@gitster.mtv.corp.google.com>
From:   Paolo Bonzini <bonzini@gnu.org>
Message-ID: <d5e439c3-ba17-8efa-647d-eb64128064c8@gnu.org>
Date:   Thu, 13 Jul 2017 01:42:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqmv89z2be.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/2017 01:02, Junio C Hamano wrote:
> Paolo Bonzini <bonzini@gnu.org> writes:
> 
>> From: Paolo Bonzini <pbonzini@redhat.com>
>>
>> These options are useful to experiment with "git interpret-trailers"
>> without having to tinker with .gitconfig.  It can also be useful in the
>> oddball case where you want a different placement for the trailer.
>>
>> Compared to "git -c", they are more easily discoverable, and also have
>> slightly different behavior because they override all trailer.*
>> configuration keys.
> 
> I think this is a very good idea (we shouldn't have started the
> command only with the configurations; we rather should have done
> this first and then added configuration after that).

Actually we can do better: we can have --where only refer to
*subsequent* --trailer options.  This will require more refactoring
(probably making a new struct that can be passed to process_trailers),
but the first two patches should be the same.

I'll have time for this only after vacation (so at the end of July), and
it's backwards-incompatible with this series.  Reviews are welcome
anyway. :)

Thanks for encouraging me.  It's always a pleasure when I can scratch my
git itches!

Paolo

> Looking forward to reviewing them, but I am cutting a maint release
> now, so it may have to wait a bit.
> 
> Thanks.
> 
>>
>> Paolo
>>
>> v1->v2: support --no-* options, minor code fixes
>>
>> Paolo Bonzini (3):
>>   trailers: create struct trailer_opts
>>   trailers: export action enums and corresponding lookup functions
>>   interpret-trailers: add options for actions
>>
>>  Documentation/git-interpret-trailers.txt |  16 +++++
>>  builtin/interpret-trailers.c             |  44 ++++++++++---
>>  t/t7513-interpret-trailers.sh            |  66 ++++++++++++++++++++
>>  trailer.c                                | 102 ++++++++++++++++++++-----------
>>  trailer.h                                |  35 ++++++++++-
>>  5 files changed, 218 insertions(+), 45 deletions(-)
> 

