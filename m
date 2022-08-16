Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E28C2BB41
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 09:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiHPJuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 05:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbiHPJtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 05:49:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54E3391
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 01:59:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l4so11770538wrm.13
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 01:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=zfnuYsTjxOUBZKc+3wtbha+R1t+v8/398pUnDvw22bQ=;
        b=PqfXl9Jun3oLyxupKb1OWhL5iW0/cMibzN3wwuc8Y7KRW4F03tSEX8NIlnO7UGWrPz
         Xq1Giy2pvo8xyeY2U9/18FiVzUzGRkKUzOnMxfNixWWblKRZDe7G3i4Y7xykSCBWhQ3Z
         tFB4Mm4CsDh1e2algSmvEgynheYQ3TedGnPQmYEQQemEc1IY+ziqcwjSkKPUnWQqZ5Pk
         j2y0XyWuOBbldPTjhKgVC9U5v5k8vdqskQkCfcssDqrbXSPkUEyFrqS+oOIfVVmd/1PA
         sQIXnZpVbjrWrueqmapSI4ynZlEVXpohqqpg8qaVk4YEkN81K7EtrLrMHIWesyFEa/7u
         qarw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=zfnuYsTjxOUBZKc+3wtbha+R1t+v8/398pUnDvw22bQ=;
        b=DM3jCO9Kj52CdE8pWGoR6ocHShYnMcEjczqyDp4nkN/rll2gkM5M1vfNvz4AjEUy8Q
         5ZszEaYdSjEtP8Sv7N1Y+q0gAFk78pQFTPH++BCIoRqmTeWWTQcYAidqiSlWkC7xr5Yf
         oZTcNb5zkPCCCcVL3rjPUT/FYU/ZmXI0eiEfv2BTUQqfb7A4vIBBsQktGkoukKpcfThT
         f9LVH2NxTbEn6OzrsKNTI4NS4pT9AbkzP+xt2AwPgaZ22W9jV8iIQnIs0v+3u0+wievI
         8ATtsKY+SeYjPxZux8dUAOJEdGMH8anv2PmvYmdnxSSx/+8EszmefY9ZL91hq+FGYlR9
         5f9A==
X-Gm-Message-State: ACgBeo1Om91nfyt+Q47YnP4vgbl0dM+Crg9HcjYSEQeLlnq/kqaw6c7b
        gaE8gXrZl9OWypIaWoNWaZmpy8Sofog=
X-Google-Smtp-Source: AA6agR4QbVJUeYjc9V3tUd8NpZlphp7MqUQHen+WJJ+404Lgy12OBJY/kRoaKCiPd0vRTtd0SEeDUg==
X-Received: by 2002:a5d:5a92:0:b0:223:7af9:be0e with SMTP id bp18-20020a5d5a92000000b002237af9be0emr11188754wrb.259.1660640376335;
        Tue, 16 Aug 2022 01:59:36 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5306000000b0021e519eba9bsm9245809wrv.42.2022.08.16.01.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 01:59:36 -0700 (PDT)
Message-ID: <870072d5-d220-09e7-684b-f9d7d8d59c93@gmail.com>
Date:   Tue, 16 Aug 2022 09:59:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC/PATCH] sequencer: do not translate reflog messages
Content-Language: en-GB-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
References: <b8ab40b2b0e3e5d762b414329ad2f4552f935d28.1660318162.git.git@grubix.eu>
 <333bbaa9-d484-7c20-90d6-e64edf8a8248@gmail.com> <xmqqy1vt9ora.fsf@gitster.g>
 <92sr80s2-6311-p065-755s-61s28s543q6n@tzk.qr>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <92sr80s2-6311-p065-755s-61s28s543q6n@tzk.qr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 15/08/2022 21:20, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Fri, 12 Aug 2022, Junio C Hamano wrote:
> 
>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>
>>> Removing the N_() stops these strings from being extracted for
>>> translation, but there are several callers left that are still using
>>> _() to get the (now non-existent) translated string. I only had a
>>> quick look but I think we should remove the _() from all the callers
>>> of action_name().
>>
>> Thanks, that's all correct.
> 
> I am afraid that it is not.
> 
> In https://github.com/git/git/blob/v2.37.2/sequencer.c#L502-L503, for
> example, we use the value returned by `action_name()` in a translated
> message:
> 
> 	error(_("your local changes would be overwritten by %s."),
> 		_(action_name(opts)));

Isn't this message using action_name() to get the name of the command 
that the user ran? As that name is not localized when the user runs the 
command I don't see that we should be translating it (and playing 
sentence lego with the result) in this message. I think the same applies 
to the message at line 689 that you mention below.

Best Wishes

Phillip

> Michael, I am afraid that we need more nuance here.
> 
> I do see that https://github.com/git/git/blob/v2.37.2/sequencer.c#L4316
> calls `action_name()` without wrapping it in `_(...)`:
> 
> 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
> 
> This suggests to me that the proper solution will be to carefully vet
> which `_(action_name())` calls should drop the `_(...)` and which ones
> should not, and to leave the `N_(...)` parts alone.
> 
> The affected calls seem to fall into these categories:
> 
> - reflog (do _not_ translate the action name)
> 
> - parameter of `error_resolve_conflict()` (do _not_ translate the
>    parameter)
> 
> - error messages talking about `git <command>` (do _not_ translate the
>    action name)
> 
> - error messages talking about the operation (_do_ translate the action
>    name)
> 
> My take on which lines need to be patched:
> 
> - https://github.com/git/git/blob/v2.37.2/sequencer.c#L500
> - https://github.com/git/git/blob/v2.37.2/sequencer.c#L538
> - https://github.com/git/git/blob/v2.37.2/sequencer.c#L2384
> - https://github.com/git/git/blob/v2.37.2/sequencer.c#L2392
> - https://github.com/git/git/blob/v2.37.2/sequencer.c#L3715
> 
> but not
> 
> - https://github.com/git/git/blob/v2.37.2/sequencer.c#L503
> - https://github.com/git/git/blob/v2.37.2/sequencer.c#L689
> 
> Ciao,
> Dscho
