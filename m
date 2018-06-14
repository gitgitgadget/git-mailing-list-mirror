Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2744D1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 01:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935854AbeFNBRq (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 21:17:46 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46272 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935675AbeFNBRp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 21:17:45 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so4306730qtm.13
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dQc19Ot1kkRu2MDtYXi3rPjfKU0crPt3/jVDLtkPZgM=;
        b=u/pQU6iaje7i2hqqSauxWRp0pzgrJlF0hf1QNsXjV82XMGmMd7rvdN60E71+CvTvFc
         o4z6vpTseTbCjb90ffpuVLVKpS3GNli4dywe+JfJJj45R2zIbssEIYq4WiZNNokXoQq8
         NGE2xpvFD6F2dDoplpVz3oyErECiiH7htYINtlzJ/RYGbnisFmxI+zfxsrAIW10/MjNl
         sJbr6AhdfWOoUZjWOx2OSHS2ctIF+ba8xNhIzfHK6I0Y3BoIdHYuTSXRzdBH1Mz43f7J
         ME6GeZlR7FK4pzOxQSXPxnQKhqcnhCftUXCMTg8+8u2m8CeqKqF11b06Dbr/K7/fwISz
         k0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dQc19Ot1kkRu2MDtYXi3rPjfKU0crPt3/jVDLtkPZgM=;
        b=uTDGTmSrpfQWHJq4x1ISuGLQTOIhtoaaIJzwNPWB4ZadFBjlCBtc1dGLtzAHge9woe
         p/2tSumFZU/0/zOYLjVR4bhDA0ny7r2gPBkY+B47j3Tk98psFbLzJvKv7dKOpM4t6VoA
         c3bTDZny7TknotGR9fSjqxgif1n8Pqbnh6Kk33ixAXHI6kXifD8UsiBDJy9vgR3AkKGM
         aIPuAaMKoeDlP+s6pvJq72Rdod50gUewVtC7QLqCKlitTP9KacFLsLicmbyxWqRnwfpQ
         MCgrgP1GAHn1W4alcMcRBowabzJbkYag9E1BuCsfJtcomK9fUaXxR4K1ec/yZX8baJca
         9SGw==
X-Gm-Message-State: APt69E0yTVpD5bTnEwlAmdotXFDZyl3D36Sq1k1QCbUOOiUoihJ8gFzx
        05FVE+T3MbPdq46qjHAYJ1Y=
X-Google-Smtp-Source: ADUXVKKyGRKpHo09++saYAIEXroHD41mS8Hz8+u2FXENjtIyPPYr/3Ym5yCYBVcZt6lPP4DmhVgOxQ==
X-Received: by 2002:ac8:51d2:: with SMTP id d18-v6mr463589qtn.80.1528939064712;
        Wed, 13 Jun 2018 18:17:44 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id c19-v6sm2522311qtp.22.2018.06.13.18.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 18:17:44 -0700 (PDT)
Subject: Re: [PATCH 03/35] object: add repository argument to
 lookup_unknown_object
To:     Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
References: <20180530004810.30076-1-sbeller@google.com>
 <20180530004810.30076-4-sbeller@google.com>
 <CACsJy8C=YNRmawuR3SZDMpmkKHMp=kPJsDjffCrcONe+CDpJ_g@mail.gmail.com>
 <CAGZ79kY97np6ZJv1_CBx_ZqPF-AQJh2U8uW8sFxJZMAHnhPrpg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fbb5b88e-dbd3-1088-ef32-21f1ef9b0589@gmail.com>
Date:   Wed, 13 Jun 2018 21:17:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kY97np6ZJv1_CBx_ZqPF-AQJh2U8uW8sFxJZMAHnhPrpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2018 3:30 PM, Stefan Beller wrote:
> On Wed, Jun 6, 2018 at 12:38 PM Duy Nguyen <pclouds@gmail.com> wrote:
>> On Wed, May 30, 2018 at 2:47 AM, Stefan Beller <sbeller@google.com> wrote:
>>> diff --git a/object.c b/object.c
>>> index 4de4fa58d59..def3c71cac2 100644
>>> --- a/object.c
>>> +++ b/object.c
>>> @@ -177,7 +177,7 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
>>>          }
>>>   }
>>>
>>> -struct object *lookup_unknown_object(const unsigned char *sha1)
>>> +struct object *lookup_unknown_object_the_repository(const unsigned char *sha1)
>> I'm looking at your branch and this function (with the _the_repository
>> suffix) is still there. Did you forget to send a patch to convert this
>> function?
> This and parse_commit and parse_commit_gently have not been converted.
>
> I stopped with this series as soon as I hit the commit-graph code, which needs
> to be updated, too. I'll start redoing this series soon and will fix
> those conversions.

Yes, we are colliding a bit at the moment.

  I'm planning to delay rerolling my patches until your last few series 
get merged.

Thanks,

-Stolee

