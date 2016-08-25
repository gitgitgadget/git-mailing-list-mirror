Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 546011F859
	for <e@80x24.org>; Thu, 25 Aug 2016 22:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757331AbcHYWQ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 18:16:29 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35820 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757243AbcHYWQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 18:16:27 -0400
Received: by mail-yw0-f180.google.com with SMTP id j12so38344464ywb.2
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 15:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B7zazbYsZpG7fk0/5IBXgU1ZszWoFu2VkZRX/fkqD1c=;
        b=sx7d2PfzGBe4JtwC9TEygOuLuym5gLGR/3YujdjrIMehfKzwSjdpuCZN7kNsuUQGiV
         MOd4P5kfuVAMLTSONUq/sdTvph5cm/UC8kraZE7NU7lpghap6kPiLa7F7waP+bo6dPQt
         zeXY93+pNi21vpVRY5eK4FajjZeN21qYLg6B0g0FA6zTEUSkfE+DM7efPMAtuag//pvO
         1tkHzHXXjzPHMbRdFLo1RXEfXyAb3b9uruW+unrtrb+Hmy50tmOsbf5lyMePxFzyXCfA
         AjszoTxLmvzVZKwk0GI14hXJq0T120Hb4/W3y31xAPYGTNyhiPqxJkN7Mn+uSS78snD8
         rZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B7zazbYsZpG7fk0/5IBXgU1ZszWoFu2VkZRX/fkqD1c=;
        b=NFDro95/ZpURbSDHj7L9SKgTDr0sgoKy+hNSLzTFh/Njyhj5cyXrNZEbwbRuksjJ1m
         LE9wWadcHIX0eqIbdyt+5hIU2mzh3w8tTgch2LQZ3MPg4kCk1ZB8EQCkvXv73J57ACE5
         IIOoSq07cRpgQOLDE+Wy69DVYSPI5MjNWLuGAgyE7jRQMHL3qjxP0twZicLqKvCxt59g
         Lin4EtqOgEInV8SZqcwIymLNwLxMuMvj7PfQPIKgW6Z25Eg51p9lk8rmdrDslsvTkRjA
         5bOJqtps3V0DcWCGxRMIa8AVJ/U3yHRArHbUerDknl/jmWZw7Ur3P7m/irim1FzLMIzb
         9zbA==
X-Gm-Message-State: AEkoouvCFFrpS0ceTuH+VYAObjY4xewnI8zZ0Tye9mbzLHxwPmogPz4lDSj3qB5FGBVsq5OFNFTBKo+L7McnAw==
X-Received: by 10.129.46.136 with SMTP id u130mr9625403ywu.234.1472163386651;
 Thu, 25 Aug 2016 15:16:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Thu, 25 Aug 2016 15:16:06 -0700 (PDT)
In-Reply-To: <CAGZ79kb3tRU5vLDMWzEC=bx9Givd8pqFsAzTBy0unxXfKpNnUw@mail.gmail.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
 <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
 <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com> <CAGZ79kbsq52Qh0Jtn5hpPPfHu_9r2CUHvAHOTh6Cgz8ODkzreg@mail.gmail.com>
 <CA+P7+xrQy33gt8bnsagLVPAHhZPZx-3s0E_Aj7tOwXnHjOoCBg@mail.gmail.com> <CAGZ79kb3tRU5vLDMWzEC=bx9Givd8pqFsAzTBy0unxXfKpNnUw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 25 Aug 2016 15:16:06 -0700
Message-ID: <CA+P7+xqDUzuX2c4y3vpPEenBRbQ_mttDhDOviV1=k7H-LQVXmQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 1:46 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Aug 25, 2016 at 1:39 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Aug 23, 2016 at 10:47 AM, Stefan Beller <sbeller@google.com> wrote:
>>> On Tue, Aug 23, 2016 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> I am not so sure about that.  If there is an existing place that is
>>>> buggy, shouldn't we fix that, instead of spreading the same bug
>>>> (assuming that it is a bug in the first place, which I do not have a
>>>> strong opinion on, at least not yet)?
>>>>
>>>> Can there be .git/modules/<foo>/ repository that is pointed at an
>>>> in-tree .git file when there is no "name" defined?
>>>
>>> If you're holding it wrong we can come into that state.
>>> * Checkout the submodule,
>>> * then remove .gitmodules as well as relevant config in .git/config.
>>> Result: Then we have a only a gitlink recorded as well as connected
>>> working tree to a gitdir inside a superprojects .git/modules/.
>>>
>>
>> Yea, but I think you're right that we shouldn't support that state.
>> What I'm worried about is the case where we can get this state doing
>> something sane/acceptable but I don't think we can.
>>
>> So we should support the gitlink to a repository stored at <path>
>> without stuff inside the .git/modules, and we should support submodule
>> gitlinks with a proper .gitmodules setup. I don't think we should
>> die() but we should error properly so I will introduce a _gently()
>> variant of these functions, and die properly in the regular flow.
>
> ok, thanks!


Ok so a die() doesn't really work. If you use submodule_from_path here
on a newly checked out repository that has sub modules but you haven't
yet initialized the repository, then the result is that
submodule_from_path will fail.. Is that expected?

That causes us to die every time on a newly checked out repository.

If we go with this behavior, then I have to refactor the whole set of
path() functions to have a _gently() variant which handles this
gracefully, and the regular revision code would still end up die()ing
as well......

Thanks,
Jake
