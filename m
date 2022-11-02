Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D250AC4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 14:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiKBOiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKBOiV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 10:38:21 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EA41D3
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 07:38:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z1so5970320qkl.9
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQwku36JXSVocXp2lkYqR7v5XY3N4zqpQ+hUTnl8hTo=;
        b=bkqDmTNYZdvtw0zvpyVMuxuSI4fNdlLx2je2M2XYNnFX2jtZncsu06z/mpcSLUV+pO
         RbgSck3rJi8+NiW2TFsw13aquBcQVGnGGPIiuY4zgR6n6gWI8zAPEFKrAn0Bud5TELvf
         Mk3gXv47wSONRII4GJdOkC+IKxn+Clh9wgy3V8EHfItCaPjt8Rzp6TflaGtOPO46wQic
         3yGUbQAvbOIAeuf8erkQVnRScVlvBWxhMeXgF7kiaLibB69izehxQNYwDuPcBqhIKECD
         2f+JMa7OUZWN8iEGjC2JeX6D42Uyiynoek0eHm25+zqPzd/mascXiJ0qo1w5XFX/M3E9
         HXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQwku36JXSVocXp2lkYqR7v5XY3N4zqpQ+hUTnl8hTo=;
        b=r3e63cTOhSBTJv4BkUGahd34pww+AOZJQ//JUBcHuWw2idHLy8rHE9zM0D6vGEYrkX
         iJfoYO+Bca+/aS80ELfO5KfJVssoQm2+wllwP8wQxa2EjyEvKBIcZ7nC95H8FFoekLEh
         bRCcQiT3l0QvbtfxkV0j+5Cj9lpEc2uahHu0/Ktuf+GxQGrjUHcE8xcmHPFG0WXyVZMG
         dY9VRCHfyNopgLnNahgQF35B4sAHfHh+aL6wp2dUmOSF+pWZu2ZCWe4EI3wR15QtkPV6
         F03oSmI4JYEIjN+2dTjIQ7wAOjlyAgi51eB247QNGTmWJ6y89/hyAnGV/3Ne/8W8Xzph
         dOKA==
X-Gm-Message-State: ACrzQf2KJaa4rxdYQh2Sb4nxMVXgCwlA0DAlQoRXJJuTmzL9+xE4DMWo
        ftmuHsjqZ7VQIn4vkuP4ehgG
X-Google-Smtp-Source: AMsMyM5z3KpZaQ15KAn/++FuOXgy/BoCeOwEidt0vqlyuJSck0ZBn6xBQCK+oYfgGSWltUMerD6f3w==
X-Received: by 2002:a05:620a:350:b0:6fa:3012:bcea with SMTP id t16-20020a05620a035000b006fa3012bceamr11478581qkm.419.1667399899388;
        Wed, 02 Nov 2022 07:38:19 -0700 (PDT)
Received: from [172.25.176.169] ([50.59.241.28])
        by smtp.gmail.com with ESMTPSA id q68-20020a378e47000000b006b929a56a2bsm8497985qkd.3.2022.11.02.07.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 07:38:18 -0700 (PDT)
Message-ID: <5666c8cc-158b-dfc7-a35f-d39d8f53ea54@github.com>
Date:   Wed, 2 Nov 2022 10:38:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH v2 6/6] t5556-http-auth: add test for HTTP auth hdr logic
To:     Matthew John Cheetham <mjcheetham@outlook.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <f3f13ed8c8238f396163dd0e6a3d6c948c2b879b.1666372083.git.gitgitgadget@gmail.com>
 <8593dd49-4d95-ed4f-b414-8170efc138d4@github.com>
 <d61d8881-ce58-de02-2c3b-e3cc812e316a@jeffhostetler.com>
 <AS2PR03MB981549CCF945BF26DD212BDBC0369@AS2PR03MB9815.eurprd03.prod.outlook.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <AS2PR03MB981549CCF945BF26DD212BDBC0369@AS2PR03MB9815.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/1/22 7:14 PM, Matthew John Cheetham wrote:
> On 2022-10-28 12:14, Jeff Hostetler wrote:
>> On 10/28/22 11:08 AM, Derrick Stolee wrote:

>>>> +static void kill_some_child(void)
>>>
>>>> +static void check_dead_children(void)
>>>
>>> These technically sound methods have unfortunate names.
>>> Using something like "connection" over "child" might
>>> alleviate some of the horror. (I initially wanted to
>>> suggest "subprocess" but you compare live_children to
>>> max_connections in the next method, so connection seemed
>>> appropriate.)
>>
>> These names were inherited from `daemon.c` IIRC. I wouldn't change
>> them since it'll just introduce noise when diffing.  Especially,
>> if we do the copy commit first.
> 
> Indeed. These functions are untouched from daemon.c. I do plan to split
> this mega-patch up however in to a single 'add the boilerplate' based on
> git-daemon patch, then add the extra pieces like HTTP request parsing and
> the auth pieces in a v3.

If these are copied from daemon.c, it may be worth trying
to lib-ify these data structures and code so they can be
shared across the two places. That can also come up as a
cleanup later, too.

For now, don't bother changing the names since they exist
somewhere else.
 
>> [...]
>>>> +static struct strvec cld_argv = STRVEC_INIT;
>>>> +static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>>>> +{
>>>> +    struct child_process cld = CHILD_PROCESS_INIT;
>>>> +
>>>> +    if (max_connections && live_children >= max_connections) {
>>>> +        kill_some_child();
>>>> +        sleep(1);  /* give it some time to die */
>>>> +        check_dead_children();
>>>> +        if (live_children >= max_connections) {
>>>> +            close(incoming);
>>>> +            logerror("Too many children, dropping connection");
>>>> +            return;
>>>> +        }
>>>> +    }
>>>
>>> Do we anticipate exercising concurrent requests in our
>>> tests? Perhaps it's not worth putting a cap on the
>>> connection count so we can keep the test helpers simple.
>>
>> again, this code was inherited from `daemon.c`, so we could leave it.

I wonder how much could be extracted from daemon.c using a
copy into a 'daemon-lib.c' with methods defined in 'daemon-lib.h'
then consumed from this file instead. Not sure it's worth the
churn to daemon.c, though.

Thanks,
-Stolee
