Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F30001FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 23:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933696AbdBPX1Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 18:27:25 -0500
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34753 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933590AbdBPX1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 18:27:25 -0500
Received: by mail-lf0-f46.google.com with SMTP id o140so1326560lff.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 15:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ixJvypcH0oi2+1KKNBlQAq16uuEy4Vhubkb2vNHj+L8=;
        b=JL5L07XEpoRZe/AC8c50GsxNYD7LQlwmJxDZd7oHcIU63WhsvZaWXth0oaTldIT1Jm
         /4Fb00827X9odkhy3AcFclIBQlZoVNJjOqDDZ3Oda4hh6unXIujcXQ7gVtFGbHHQwkwt
         a+eHLnU+NxjsW5MvVxAUMzuCdqO69T2AaUFaPBdgL8g63tJl/RAQ6/KlNlm1hvsXIGXK
         yoL1lGHjbt0nSneayN2n52yjU5u7DHrj6uYogSTnpnAy2VfMnk/aebqbNBF03m/B9MI1
         bG5BS1l/VBwvem3xYMqEifZFmouHw8IPDHJ/dQlT9kqAIDMgO9rjYFehdnhKLeo3Q24A
         xCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ixJvypcH0oi2+1KKNBlQAq16uuEy4Vhubkb2vNHj+L8=;
        b=rgGbL9ZN2BvIBapwp+bV3OAAV1mueefExHunXjYOXU1fadd/d0siyqAl5ZEGU2/8y4
         i/ZWfT8aPSbsVgIOeay/qfQU1MrOv9jDdVM1aKRrbCwIC3IrHz+Lv0ySXb9JQWw1ED1A
         2g4fwzf9wEoUCwG4l9yAEwh6nwZAgSuboA8p46BiOB9fUcI3fQ3+5Hq1hiHAvOeOSb6i
         Y99Y9FOqDgp1K2FcnxeYcXqIbV50oO+PXw/qODOQoS7HMkAaPlOOU6CvTdAupBljDqx/
         wCQofToc5wcnQZH8XuQvFRVhLdL8zsSpTa3sL9WoQ32y7NWqDr3tJ8ulqAM6p7F0JFmv
         Fu+g==
X-Gm-Message-State: AMke39njMA2cqqUzJ3A4fcPB7WFv5qkCLZYdxZIzCdDgwm6wV2QMgDn6F6eTl/H76ftBZTZA0UnZb5HqxIDDXQ==
X-Received: by 10.46.20.93 with SMTP id 29mr1228133lju.10.1487287643119; Thu,
 16 Feb 2017 15:27:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 16 Feb 2017 15:27:02 -0800 (PST)
In-Reply-To: <CAGZ79kYQf2SL-RVETv8=6NaZHhub2kQmKevK32X_xfFkr_0yyA@mail.gmail.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <xmqqlgt5vlse.fsf@gitster.mtv.corp.google.com> <CA+P7+xpWqiWeMOMauYgtVaiUngd73_dUqRxyWcp0QPHvgOe+vg@mail.gmail.com>
 <CAGZ79kYQf2SL-RVETv8=6NaZHhub2kQmKevK32X_xfFkr_0yyA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Feb 2017 15:27:02 -0800
Message-ID: <CA+P7+xp-XbYRp-uxDgSHz9y+OrSQ-pd0t-UsQyT843-t4ArPeA@mail.gmail.com>
Subject: Re: [RFCv4 PATCH 00/14] Checkout aware of Submodules!
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 2:56 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Feb 16, 2017 at 2:54 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Thu, Feb 16, 2017 at 2:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> Integrate updating the submodules into git checkout,...
>>>
>>> It was more or less a pleasant read, once I decided to pretend that
>>> I were a machine who uses identifiers only to identify locations in
>>> the program ;-) IOW, for human consumption, the new names introduced
>>> were sometimes quite confusing and went against helping understanding.
>>>
>>
>> Based on my cursory reading, I agree. I had trouble understanding how
>> the process worked because the names were somewhat confusing. They
>> started to make some sense as I read more. I think v4 had better names
>> than v3, but they were still somewhat confusing to me.
>>
>
> Now if only you could tell me what names were better to understand. ;)
> I'll reply to the individual patch remarks and hopefully there we find
> good names for these functions.
>
> Thanks,
> Stefan

I'll try to read it again and see if I think of anything.

Thanks,
Jake
