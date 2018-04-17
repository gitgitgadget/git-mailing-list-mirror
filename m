Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 788CA1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 19:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeDQTN1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 15:13:27 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:33322 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeDQTN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 15:13:26 -0400
Received: by mail-it0-f51.google.com with SMTP id x144-v6so15593377itc.0
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 12:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CVI66hQyYifoBrRssqWrBR4GeBKmRK9r4O459kUJIsg=;
        b=jM8r4398ix3oz/yZ74Oz61lS+ArtCuUOjmcoARDmSCiX99DA2BWMH9PVlxFehNEzXn
         o68EWUKUeFDPMUBxweAKAXUDVBMsAF9d2OALHJo4GWTBTIFJ80eeLPPplrZ29D+ma3qw
         ntIzr0YeZOnABg58uQ64/hkO17ERqgPghG6XoGHj1tBy2Tg7fmEDzq/KhVTMm/KzPyAS
         8li1q1QHNoqcRhL0zrgR9qEKAk5/hNUaGuLAH+ZyUgD+QgSHaIIbeyMQVfR+JsqZ9lN7
         QqYbpr1cxo6xZ1XnPdTxHoTNQV2KaEpQBytqgVM+92CSJp+fOjZUYIEdR3PoqcJa7t0w
         6wkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CVI66hQyYifoBrRssqWrBR4GeBKmRK9r4O459kUJIsg=;
        b=gtTyVPlQN307wMtYJr2pXq9K6EiFSzGzWkmxLvTp6aEs6Z7Bd8QgXe5rioHUHnriLB
         MPzrkv047nCT/lRNbMaJP6G9nCxKXy9IgsG+hwTylUt9zXRUnPuM8codZLQ8LB+L1i2k
         fWoT57O40yPfEowiEVmBNuarzNoO5sArEwzjg21df4DV9+PE3VLNx8vBCDRAuHsPzLgY
         tMxvICUBQR4cgNn55lTa4etlXWCkTxMkwXW2+iGc/G9e8FzAPc83YKWmNXErGMmgkdAs
         PN7lPsSS7FksQ+i/qkrKsWyB+Ym/1lCXLr6OUDb+F/jz750sPEZn6c9xEx/q8iCiYEFH
         nu+A==
X-Gm-Message-State: ALQs6tANMjzFWOuKRK9kAsZ0/jXK/MLIqk6xUrj62fZ9aeYSOa7YEXvp
        ZodBR1nR2zLNFnboZvu7P7CRiXEcPKcme+eEYvo=
X-Google-Smtp-Source: AIpwx49j10L60BdAO/WY2KTyjeYwLrMIkKGP0S7ab79bbThQMvr9mvNGzRcYIufak4r6CMRZzFSopR/B7VvTv/dY4hc=
X-Received: by 2002:a24:5b06:: with SMTP id g6-v6mr2469909itb.43.1523992405791;
 Tue, 17 Apr 2018 12:13:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a78a:0:0:0:0:0 with HTTP; Tue, 17 Apr 2018 12:12:45
 -0700 (PDT)
In-Reply-To: <BYAPR08MB3845A66624486DD1D534050EDAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
 <cover.1523981210.git.amazo@checkvideo.com> <CAJJpmi9OQicqEonVwWMo+yimU5MBdJ9gwzbtY1GXSMB+E69AGA@mail.gmail.com>
 <BYAPR08MB384591845049E50D98A42303DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
 <CAJJpmi_Qk-Q3ndiOFiYy5fGsKsJ0mF=nKbSDkdY-NE0DRkZTEg@mail.gmail.com> <BYAPR08MB3845A66624486DD1D534050EDAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
From:   Thandesha VK <thanvk@gmail.com>
Date:   Tue, 17 Apr 2018 12:12:45 -0700
Message-ID: <CAJJpmi-Uq8vfSOYaH+quMA87=P=66+JMGGvuLByAKQUy-fpDxg@mail.gmail.com>
Subject: Re: [BUG] git p4 clone fails when p4 sizes does not return 'fileSize' key
To:     "Mazo, Andrey" <amazo@checkvideo.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have few cases where even p4 -G sizes (or p4 sizes) is not returning
the size value even with latest version of p4 (17.2). In that case, we
have to regenerate the digest for file save it - It mean something is
wrong with the file in perforce.
Regarding, sys.stdout.write v/s print, I see script using both of them
without a common pattern. I can change it to whatever is more
appropriate.

On Tue, Apr 17, 2018 at 11:47 AM, Mazo, Andrey <amazo@checkvideo.com> wrote:
> Does a missing "fileSize" actually mean that there is something wrong with the file?
> Because, for me, `p4 -G print` doesn't print "fileSize" for _any_ file.
> (which I attribute to our rather ancient (2007.2) Perforce server)
> I'm not an expert in Perforce, so don't know for sure.
>
> However, `p4 -G sizes` works fine even with our p4 server.
> Should we then go one step further and use `p4 -G sizes` to obtain the "fileSize" when it's not returned by `p4 -G print`?
> Or is it an overkill for a simple verbose print out?
>
> Also, please, find one comment inline below.
>
> Thank you,
> Andrey
>
> From: Thandesha VK <thanvk@gmail.com>
>> Sounds good. How about an enhanced version of fix from both of us.
>> This will let us know that something is not right with the file but
>> will not bark
>>
>> $ git diff
>> diff --git a/git-p4.py b/git-p4.py
>> index 7bb9cadc6..df901976f 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2566,7 +2566,12 @@ class P4Sync(Command, P4UserMap):
>>          relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
>>          relPath = self.encodeWithUTF8(relPath)
>>          if verbose:
>> -            size = int(self.stream_file['fileSize'])
>> +            if 'fileSize' not in self.stream_file:
>> +               print "WARN: File size from perforce unknown. Please verify by p4 sizes %s" %(file['depotFile'])
> For whatever reason, the code below uses sys.stdout.write() instead of print().
> Should it be used here for consistency as well?
>
>> +               size = "-1"
>> +            else:
>> +               size = self.stream_file['fileSize']
>> +            size = int(size)
>>              sys.stdout.write('\r%s --> %s (%i MB)\n' %
>> (file['depotFile'], relPath, size/1024/1024))
>>              sys.stdout.flush()
>>
>>
>> On Tue, Apr 17, 2018 at 10:33 AM, Mazo, Andrey <amazo@checkvideo.com> wrote:
>>> Sure, I totally agree.
>>> Sorry, I just wasn't clear enough in my previous email.
>>> I meant that your patch suppresses "%s --> %s (%i MB)" line in case "fileSize" is not available,
>>> while my patch suppresses just "(%i MB)" portion if the "fileSize" is not known.
>>> In other words,
>>>  * if "fileSize" is known:
>>>  ** both yours and mine patches don't change existing behavior;
>>>  * if "fileSize" is not known:
>>>  ** your patch makes streamOneP4File() not print anything;
>>>  ** my patch makes streamOneP4File() print "%s --> %s".
>>>
>>> Hope, I'm clearer this time.
>>>
>>> Thank you,
>>> Andrey
>>>
>>> From: Thandesha VK <thanvk@gmail.com>
>>>> *I* think keeping the filesize info is better with --verbose option as
>>>> that gives some clue about the file we are working on. What do you
>>>> think?
>>>> Script has similar checks of key existence at other places where it is
>>>> looking for fileSize.
>>>>
>>>> On Tue, Apr 17, 2018 at 9:22 AM, Andrey Mazo <amazo@checkvideo.com> wrote:
>>>>> Huh, I actually have a slightly different fix for the same issue.
>>>>> It doesn't suppress the corresponding verbose output completely, but just removes the size information from it.
>>>>>
>>>>> Also, I'd mention that the workaround is trivial -- simply omit the "--verbose" option.
>>>>>
>>>>> Andrey Mazo (1):
>>>>>   git-p4: fix `sync --verbose` traceback due to 'fileSize'
>>>>>
>>>>>  git-p4.py | 8 ++++++--
>>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>
>>>>>
>>>>> base-commit: 468165c1d8a442994a825f3684528361727cd8c0
>>>>> --
>>>>> 2.16.1
>>>>>
>>>>
>>>> --
>>>> Thanks & Regards
>>>> Thandesha VK | Cellphone +1 (703) 459-5386
>>
>>
>>
>> --
>> Thanks & Regards
>> Thandesha VK | Cellphone +1 (703) 459-5386



-- 
Thanks & Regards
Thandesha VK | Cellphone +1 (703) 459-5386
