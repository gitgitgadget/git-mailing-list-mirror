Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C43061F859
	for <e@80x24.org>; Mon, 15 Aug 2016 06:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621AbcHOGw6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 02:52:58 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:36249 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbcHOGw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 02:52:56 -0400
Received: by mail-yw0-f177.google.com with SMTP id u134so22393704ywg.3
        for <git@vger.kernel.org>; Sun, 14 Aug 2016 23:52:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8/C9xiQ5RHr5zBmcuEi8ligXPl2LkPBVfxMP6NCON14=;
        b=BXeBA8hQSwk6oSgVt2rWTeYo0WVzl+WueH+8T5it2cWSDinvlAllxnBvpRiwLtF3aI
         meVM96JwUFx6ZKeQnwFCA6OKXDMngfaEctjYpAlvUbkK8nWeiEpEXBNyh5eVWdmwTErY
         KmaOzcji+slT4eAnicWlDI+WE/2Gc8PjSPUrQaFcpS6D4nhh0NYfY91FKTsJH1GiJLn5
         kGKjtZt9xQwEuSeaiCGIgPpUobVWjz9BAnQyV07DN9AyWU0LbV5CnIKqRd8s7vCln8A2
         aHWxa2iNshc8/T19OhN+T52nnSXEnGvi3XGOTGSGqhLAaKh1J3maFMyJ64FDqzjliXer
         LITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8/C9xiQ5RHr5zBmcuEi8ligXPl2LkPBVfxMP6NCON14=;
        b=FjsqlOkEKbNeTBSCHmHOrf+f6Q8vrfIyV/tzqytuPD5LlkjQRJLr/pNoxIflae+ADd
         bGCSnTUp1rKZN4UBmzdTca++xaG6kj027IdZiPPtihiHH+4W+nKxhSIwx+k1jYD5FEeV
         z/MTjM7FPQtQxQMzVBKp0SIY/rQ2dPpiI5rI5eJxbhQfSSMWZsAn+qAQkRNuTPGHzHGL
         edhSBunJOXITyzXMmkJtreYvPsVAMD96oJfJuiBNtSE+45ieo95S5C3oCdbfFRj4x3gh
         nxrtPdwG8T/evCyTeGWp/qo43alL5uL8QphRX2Plxxj16Wh1KZg1ZPXwX3Sm2O+d60Pu
         NRIg==
X-Gm-Message-State: AEkooutiyERtQIWkWgqd+5gkMp4ARQwtsZzhO45bbIZLn/WdJ/EuuJbsQ6XwbrjFjrZtvd+hXHM1OtwjXPe/Sg==
X-Received: by 10.129.168.9 with SMTP id f9mr5069942ywh.258.1471243976037;
 Sun, 14 Aug 2016 23:52:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Sun, 14 Aug 2016 23:52:35 -0700 (PDT)
In-Reply-To: <CAGZ79kZG2H8P13ivDJWYM7snmw3EqrGr=FaaHkXJotzhRfa00A@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com>
 <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
 <CA+P7+xpgzRGiNtWrzjebP4EJr1kCed4w5JX412FhSHoZZrkNRA@mail.gmail.com> <CAGZ79kZG2H8P13ivDJWYM7snmw3EqrGr=FaaHkXJotzhRfa00A@mail.gmail.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Sun, 14 Aug 2016 23:52:35 -0700
Message-ID: <CA+P7+xrSPW_=S6P=wGZB=3F_jRxatZoCP4F+GButeoBEMHjpRA@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Stefan Beller <sbeller@google.com>
Cc:	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 14, 2016 at 11:49 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Aug 14, 2016 at 11:38 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Sun, Aug 14, 2016 at 11:28 PM, Stefan Beller <sbeller@google.com> wrote:
>>> I would imagine this is similar to the pull requests on the linux
>>> mailing list, i.e.
>>> how it is with merges. Back in the time we did not open the editor for you to
>>> talk about the merge you just did, and then we started doing that.
>>>
>>> So what to do when the description already exists?
>>>
>>> We could amend the description separated by a
>>>
>>>      # comment, below was added:
>>>
>>> line or such and then open the editor asked for user input.
>>>
>>> Thanks,
>>> Stefan
>>>
>>
>> This is why my gut feeling is that we should instead have a separate
>> way to store a cover letter, as it doesn't necessarily have to apply
>> to a branch
>
> Well in our workflow each series has at least one merge commit.
> (You *could* have different descriptions for the different branches,
> e.g. for maint: "fixes a segfault so let's get this in, but it needs to be
> redone properly" and for pu: "TODO: revert this partially
> when branch $proper-fix is merged")
>
>> or a merge commit, but could just be annotation against a
>> series of commits (maybe stored as base + tip, since most series would
>> be linear in nature?)
>
> We could suggest to use a merge always strategy for this, i.e. as soon as
> you send a cover-letter, we'll make a merge for you whose parents are the
> old HEAD and the new series?
>
> If the user strictly wants to have a linear history, then we could try some
> empty commit magic before or after the series, but I doubt this is proper.
>
> If users insist on linear history, they deny the benefits of a DAG that
> represents how the source code evolved. (Also see the eternal rebase
> vs merge discussion ;)
>

I think you're right this can go into a merge commit and if a user
insists on linear history it's their fault.

>>
>> However, opening an editor and amending seems quite reasonable to me
>> if we're just editing branch description, and then storing that as
>> part of merge commit would be reasonable?
>>
>> I really think we want some alternative way to store it for other use
>> cases besides the description, though.
>
> "besides the description"?

I think my brain shut down. I'm not really sure what I meant but I
think I meant "we want some other way to make the cover letter
permanent because the branch description isn't shared".... So... no I
have no real idea what I was trying to say here.

Thanks,
Jake

>
> What do you mean by that?
>
> Thanks,
> Stefan
>
>>
>> Regards,
>> Jake
