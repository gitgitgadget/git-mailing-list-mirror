Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6682420248
	for <e@80x24.org>; Tue, 16 Apr 2019 14:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfDPOYm (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 10:24:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33479 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPOYm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 10:24:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id k189so12255095qkc.0
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 07:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WuBI0AcNQ6Z0Y+mI2gLsoqwxUvxrm930bSobfArSMeY=;
        b=hDZc3WffTxJ5rAzXObWM4GFmt/MPsrbluOhtQrum22Lnl9XVvTdndBioSPFe68erKZ
         T4zKzG9+lqB+lRZlDEIJQTWu10F4HSWRuQezhJZs8fKIebRaA1vyyNdpe+3HYEN3PdeA
         v/KsZ8A2uQVuobcdrBG79g/fCDA/2+g5YYO0TXqkm6w5tZw9V7SM0R5Jg57i0sBG+lCE
         sErP0UAlKh7q3C41Q40t8E8bF389oTV5SgAReOAVclC2oRxx+xmzAfLqOwKBFb2vlxjz
         Af2KzpkTedujcZIqdJtZcusfk3wUooqkOwGrY3JStzzUTI5B5UWIuM0K+yEckaV0ly52
         QHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WuBI0AcNQ6Z0Y+mI2gLsoqwxUvxrm930bSobfArSMeY=;
        b=MlsooC+mheQGV+HQ0uLRhq9UlqHDdBMmxvmNkGwYj1yvBJrmpPva80kn7xZeNZYbPy
         kmTQgr1XH8FKeUCEXzMRTBmOU31St4xJDtkjsxZ3h8kIw4JwTbEW9cM+bdW1HuL03M7m
         deG7Grwmmq1N7THsza4vVXioDTSQ/1RbdXzLUKSEqu6SfMRVGgdTQsUh1d9zP83prKrh
         8jhEek6fvu9ALI1fI/HUSVAhpXkzkxurxnQDwtmKlvGrHem2O+xQ2TNHcbjNeJijrSmT
         vfRDORuvwHBSQZkhYNDTZmKKdJpPx74BKhdwlxFGSFh20V36P4GXS5+6qikrJT7oyG0q
         //ZA==
X-Gm-Message-State: APjAAAWq2lDUYVF0wlCyHC4WiAB4gB+WV4her0XZ2U8aKTwyFAO4FGFS
        zttBSVJEPmWmWBLP6cDo+40=
X-Google-Smtp-Source: APXvYqzkx/nNLTWV/RgDlYdKvGQDB6xQSexn/h3WP59V9zuPyhjJ0uJppuN1gJrbQnebukKnpwlHpw==
X-Received: by 2002:ae9:dc01:: with SMTP id q1mr59418724qkf.98.1555424680855;
        Tue, 16 Apr 2019 07:24:40 -0700 (PDT)
Received: from [10.0.1.4] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id f47sm40886249qta.80.2019.04.16.07.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 07:24:39 -0700 (PDT)
Subject: Re: [PATCH 07/14] parse-options: allow ll_callback with
 OPTION_CALLBACK
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20190127003535.28341-1-pclouds@gmail.com>
 <20190127003535.28341-8-pclouds@gmail.com>
 <02d2a828-b191-9d9a-7422-d76cdca69ef1@gmail.com>
 <CACsJy8DDKuK5VYhh0GNYSJK1_y3MZgK5Vcq99N4jYcusVFnvQQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6b731f57-eada-8c1c-8e5d-de386b0c414e@gmail.com>
Date:   Tue, 16 Apr 2019 10:24:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DDKuK5VYhh0GNYSJK1_y3MZgK5Vcq99N4jYcusVFnvQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/16/2019 4:52 AM, Duy Nguyen wrote:
> On Mon, Apr 15, 2019 at 9:06 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 1/26/2019 7:35 PM, Nguyễn Thái Ngọc Duy wrote:
>>> @@ -238,7 +249,10 @@ static enum parse_opt_result parse_short_opt(struct parse_opt_ctx_t *p,
>>>                       len++;
>>>               arg = xmemdupz(p->opt, len);
>>>               p->opt = p->opt[len] ? p->opt + len : NULL;
>>> -             rc = (*numopt->callback)(numopt, arg, 0) ? (-1) : 0;
>>> +             if (numopt->callback)
>>> +                     rc = (*numopt->callback)(numopt, arg, 0) ? (-1) : 0;
>>> +             else
>>> +                     rc = (*numopt->ll_callback)(p, numopt, arg, 0);
>>>               free(arg);
>>>               return rc;
>>>       }
>>
>> Hi Duy,
>>
>> This "else" condition is unreachable. This block is only hit when we have a "-<n>"
>> option, using OPT_NUMBER_CALLBACK, which is implemented by filling "callback", never
>> "ll_callback".
> 
> It does not mean ll_callback cannot be used in the future though.

That's not a very good reason to add it now. YAGNI.

> We
> have three options
> 
> 1. drop the else clause
> 2. replace with "else BUG();"
> 3. implement proper else clause
> 
> Option #1 to me sounds wrong. If you don't support something, yell up.
> Silently ignoring it only makes it harder to track down to this
> unsupported location when it becomes reachable, however unlikely that
> is.
> 
> Which leaves options #2 and #3. If you think this one line is risky
> enough, I'll send a patch to replace it with BUG().

It's not about risk, but the fact that it is pointless. The only way to get to
this block is to create a 'struct option' with type OPTION_NUMBER manually
(ignoring the OPT_NUMBER_CALLBACK macro), which _should_ be unsupported. If
someone goes to the pain of adding a way to instantiate with a low-level callback,
then they should add this 'if' statement.

If you are going to add protection from an incorrect instantiation of 'callback'
in a use of OPT_NUMBER_CALLBACK, then the proper place to do that is probably in
parse_options_check(), where you were already doing callback-vs-ll_callback checks
in the case of OPTION_CALLBACK and OPTION_LOWLEVEL_CALLBACK.

However, the only places where the OPT_NUMBER_CALLBACK option appears are
builtin/grep.c and t/helper/test-parse-options.c. I don't imagine a need to
add low-level callbacks any time soon.

>> I recommend reverting this diff segment, but please let me know if I'm missing something.

I still think this is the easiest way to remove the dead code.

I'll try to submit a patch later. I'm still not in full work mode, so I may be slow.

Thanks,
-Stolee

