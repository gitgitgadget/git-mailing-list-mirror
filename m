Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C8921847
	for <e@80x24.org>; Wed,  2 May 2018 17:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751025AbeEBR0v (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 13:26:51 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:41243 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbeEBR0u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 13:26:50 -0400
Received: by mail-yw0-f180.google.com with SMTP id q125-v6so707584ywc.8
        for <git@vger.kernel.org>; Wed, 02 May 2018 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uh9Snd+wi03PrxPBuHwhBI/fsdWFSW7aBcQ6VRL3xKs=;
        b=YtZDg/1dxHQmxpmGgqh5DGYNw1iHqc3yUp7B7Ct76ECc9Wj1gk8EMUlEzKE/1R5Cyj
         83d+JyOm5iRs48DwzOQNrEhEOieFH4rremD0ypVF2sHBExw1FT59He7b0bk2eMd2faIK
         qvITl/vlqKlCarr6DJ+5379sMA0h1hwHJzhLXOx9x5CYkyJsHC7gQt+am1bPiIZNk7qp
         Fcia6dG74BdnA1StJfJWBY94S5eKsCArgdWKXi9RA+z0bfTnvQuGFfPTysXyMY0/3F2q
         1KYzRMmFODAXyel+0RixNXNFp4+sQYkQ6Vfx9ntNDDySFFTJob7XQAmdwdrpX7FioRMZ
         G+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uh9Snd+wi03PrxPBuHwhBI/fsdWFSW7aBcQ6VRL3xKs=;
        b=k00McDoJ2TQyq7GkaG6HBmVkpAicXDEBML0m7ryfwU0PRQDKYltsPQZpAJEhhbO1V1
         Yr4FP027sA9ohWVR0QlO/3hZp+IbOO3KzzURStyZiqB/NZK/4dx1udEm93v2KqqD57+z
         Unp0ujTwf050d91p1CVZVkrqgSimmR5jcEjwk925/kBx859234K8AAk852PMv67/Ngrk
         DPyJkltkffmiFyEyw72Z0WxOHbCFh6o8pAT+qsqzvBPrTnW+U/Vx0K7ST9ZTno+iGaK2
         r/5Rhw8JOh72DoBu5y0T0fv3oPMqLUVcZVZ8oMyQtAFZbw341YJPe36cd2Z+rCT46pva
         +a+g==
X-Gm-Message-State: ALQs6tAPesUYCYn6Z9g+5+Uvi0qYqriHk9RSxsI0tSxgc6aJFT2lbuoQ
        6VV65yxVKEhmTR029EFKWvDjk9ZzYGzziI2U75qX8A==
X-Google-Smtp-Source: AB8JxZq/rI55ViggHe3Frwz5LaqcrTNRtnfMVlv/aecFQB+UeDybEoMGUY4a4p5Er9ZeJONDc6Sr96oJtaj96frNjvg=
X-Received: by 2002:a81:37ce:: with SMTP id e197-v6mr11849075ywa.340.1525282009140;
 Wed, 02 May 2018 10:26:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Wed, 2 May 2018 10:26:48 -0700 (PDT)
In-Reply-To: <CACsJy8CgX6BME=EhiDBfMRzBOYDBNHE6Ouxv4fZC-GW7Rsi81Q@mail.gmail.com>
References: <20180501213403.14643-1-sbeller@google.com> <20180501213403.14643-2-sbeller@google.com>
 <CACsJy8CgX6BME=EhiDBfMRzBOYDBNHE6Ouxv4fZC-GW7Rsi81Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 2 May 2018 10:26:48 -0700
Message-ID: <CAGZ79ka6p33W8msji9kFMaWGOuDzSyx=y0AFPaQSX_08AZSgag@mail.gmail.com>
Subject: Re: [PATCH 01/13] repository: introduce object parser field
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jameson Miller <jamill@microsoft.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 10:17 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, May 1, 2018 at 11:33 PM, Stefan Beller <sbeller@google.com> wrote:
>>         /*
>> -        * Holds any information related to accessing the raw object content.
>> +        * Holds any information needed to retrieve the raw content
>> +        * of objects. The object_parser uses this to get object
>> +        * content which it then parses.
>>          */
>>         struct raw_object_store *objects;
>>
>> +       /*
>> +        * State for the object parser. This owns all parsed objects
>> +        * (struct object) so callers do not have to manage their
>> +        * lifetime.
>> +        */
>> +       struct object_parser *parsed_objects;
>
> I like this name 'parsed_objects'. Should we rename the struct after
> it (e.g. parsed_object_store as opposed to raw_object_store above)?

I can rename it to parsed_object_store for consistency.

> Another suggestion is object_pool, if we keep 'struct object' instead
> of 'struct parsed_object' and also want to keep current allocation
> behavior: no individual deallocation. If you free, you free the whole
> pool (e.g. you could run rev-list --all --objects in a separate pool,
> once you're done, you delete the whole pool).

That is what the following patches will be about, you can
only free the whole set of parsed objects.

So if you want to do a separate rev walk, you may need to
instantiate a new repository for it (ideally you'd only need a
separate parsed object store).

I'd want to have the ability to have separate pools for submodules,
such that they can be free'd on a per-repo basis.

> --
> Duy
