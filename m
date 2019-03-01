Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CAF720248
	for <e@80x24.org>; Fri,  1 Mar 2019 15:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbfCAPAV (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 10:00:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35851 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCAPAV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 10:00:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id o17so26227701wrw.3
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 07:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OvhxzXTPMi1nn52y3mf2PIVg5mTfD2mSw8goKBb9zcc=;
        b=I1EIJNJjBypOMYOBX/I3uYbcVyLFTy2bUDusOGmnzKfXq1felHhiEERQMyaxtwCEFN
         6MeLYxD2ZdqhBp9Op3l/d60jNfkJx2hkFWXYXLNHmFlxDm8I49wuU+WKfA83Z4QfgVGz
         kSumtLRaNrMnTuQg3dsXnGKHFHr37MUaR0VuufCRExOi+ONJBzPeEJn2Jw6pv6WDmdFI
         S7kKCR+7+jqJQqs8fNfOHCY4ItmtCHekN2/6MHE2YXrWowbBEtppC5d/+DcOdh33aJvg
         0mtfT4zLUSq6m5B8f1cMQLXu29DMB1hKqZWwIHjbTrQuJaLuZfvdPpPkkVhjPANawe5e
         XkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OvhxzXTPMi1nn52y3mf2PIVg5mTfD2mSw8goKBb9zcc=;
        b=E0McLtoUWCYWp7KvhNpjYsMEs9mRqJZKT1EBWPpia8jfgsRm20LvPHBbLUZCO7qL9e
         4Fb3gTXICdxH1TBJuz5T7AfWIWiLWSPHYAS59yEV2lbJS3jJ79Ug9DUN5jqe4p+SekVO
         8wlZfVNk/D8m0KuJHzzzhKHvKqPLm99lksKHZp864EYQNeQCUCOH9ueCIWJEGHJyJh5a
         T5zEimGd0OqgtKhHtbliTXrMCRDh+PMiWsN5b/WytAAajqoxW4Q0ijDjb5tS/ZE9oUkP
         Afe2dwmV/+vkMiRhGgUgH/+P4hkhGcc6BYeNCp1m22Pu3vkJXIWZI7atESXR+YuBG46P
         6yAg==
X-Gm-Message-State: APjAAAU0teDqrU3oe+xPWdtTQk9bXCcBS39+4FyQOMEKur0zjbXw1jvU
        VDdKtEBUvA2u0v/GkPmTbxY=
X-Google-Smtp-Source: APXvYqx4D4zPPEyuOnH0U18GcnEIgOnJiI5wCWTWvtG25S7vV5jKw66Sr66DgFFnxBft+f6evUtCwg==
X-Received: by 2002:adf:f103:: with SMTP id r3mr4090842wro.50.1551452419265;
        Fri, 01 Mar 2019 07:00:19 -0800 (PST)
Received: from [192.168.2.240] (host-92-28-129-241.as13285.net. [92.28.129.241])
        by smtp.gmail.com with ESMTPSA id 93sm66154069wrh.15.2019.03.01.07.00.18
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 07:00:18 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] built-in rebase: no need to check out `onto` twice
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nazri Ramliy <ayiehere@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.153.git.gitgitgadget@gmail.com>
 <2d99429387ba63526efe233bbefe851c5d556fdc.1551367664.git.gitgitgadget@gmail.com>
 <7b1282bf-4b94-5725-00df-2dc63eaa93f0@gmail.com>
 <nycvar.QRO.7.76.6.1903011415220.41@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <22878dbe-d9f0-4737-3a49-ece695c2d0c2@gmail.com>
Date:   Fri, 1 Mar 2019 15:00:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1903011415220.41@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 01/03/2019 13:19, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Thu, 28 Feb 2019, Phillip Wood wrote:
> 
>> On 28/02/2019 15:27, Johannes Schindelin via GitGitGadget wrote:
>>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>>
>>> In the case that the rebase boils down to a fast-forward, the built-in
>>> rebase reset the working tree twice: once to start the rebase at `onto`,
>>> then realizing that the original HEAD was an ancestor, `reset_head()`
>>> was called to update the original ref and to point HEAD back to it.
>>>
>>> That second `reset_head()` call does not need to touch the working tree,
>>> though, as it does not change the actual tip commit. So let's avoid that
>>> unnecessary work.
>>
>> I'm confused by this I think I must be missing something. If we've checked out
>> onto then why does the working copy not need updating when we fast forward.
>> (also why to we checkout onto before seeing if we can fast-forward but that's
>> not related to this patch series)
> 
> Sorry, I really try to learn how to express things clearly. Still learning
> a lot.
> 
> So what happens is this: we detect the situation where the pre-rebase
> `HEAD` is an ancestor of `onto`. We do this *after* checking out `onto`.
> So we now know that we essentially fast-forwarded to the post-rebase
> state.

Ah that makes sense, for some reason I misread the commit message and 
thought that we were dealing with the case where onto was an ancestor of 
the original HEAD and we were fast-forwarding from onto back to the 
original HEAD.

> What we still need to do is to update the original ref (unless we were on
> a detached HEAD when the rebase was started).
> 
> The original shell code updates the original ref to the current HEAD, and
> the updates HEAD to point to that symbolic ref instead of being detached.
> 
> In the C code, we abused `reset_head()` to do the same. But `reset_head()`
> does more: it does a two-way merge (in this instance, because
> `RESET_HEAD_HARD` was not part of the flags). Which is unnecessary.
> 
> That's all this commit is about.

Thanks for explaining, it all makes sense to me now

Best Wishes

Phillip

> Ciao,
> Dscho
> 
>>
>> Best Wishes
>>
>> Phillip
>>
>>>
>>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>>> ---
>>>    builtin/rebase.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>>> index 08ec4d52c7..813ec284ca 100644
>>> --- a/builtin/rebase.c
>>> +++ b/builtin/rebase.c
>>> @@ -1740,8 +1740,8 @@ int cmd_rebase(int argc, const char **argv, const char
>>> *prefix)
>>>      strbuf_addf(&msg, "rebase finished: %s onto %s",
>>>       options.head_name ? options.head_name : "detached HEAD",
>>>       oid_to_hex(&options.onto->object.oid));
>>> -		reset_head(NULL, "Fast-forwarded", options.head_name, 0,
>>> -			   "HEAD", msg.buf);
>>> +		reset_head(NULL, "Fast-forwarded", options.head_name,
>>> +			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf);
>>>      strbuf_release(&msg);
>>>      ret = !!finish_rebase(&options);
>>>      goto cleanup;
>>>
>>
