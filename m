Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5247C1F404
	for <e@80x24.org>; Wed, 18 Apr 2018 14:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeDRO74 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 10:59:56 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:45075 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDRO7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 10:59:54 -0400
Received: by mail-io0-f178.google.com with SMTP id a7-v6so2764119ioc.12
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bIUZOYNkmGf92tt+PtcG2vaIRYhPsy3PHj++THe1P0c=;
        b=SQ0IT/NhZieJ1/kFcJBIDxCz2av9eDgsd641sC0umFl38CIF4ZY0a+jfmMHxVwOUZu
         1Z+aYDMOnM1+i/n2nQaKlNmO61cbtbYhKspDq29l533y9PJPXTEEwNFGQPG6CisHy4+f
         U7/23u6Qw23QN1SP6DZFwLWsL9qlkC42ObjLO3Q2EkddAdQCuazxYUCmF87Ajv4QpFeV
         2SEQhp4j4Lk2pp9HKnKST+PsvTtPlfCeF3pLBzA9Y5OITYg7MNSauphG3uWmT8IrkKco
         oEoLRoP1mkE6WDu2vUmo3HaP+VI0gRRuHSsZFdXnODM1oabZKDoQzwP8QbEXnI4NLujT
         M9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bIUZOYNkmGf92tt+PtcG2vaIRYhPsy3PHj++THe1P0c=;
        b=fA2POctyTeWWyk6NVrtKWfgXDQ5JdT5pPzcflI2X6MlnoudPrihQrXpIDxlwfgymg2
         Cn+paUdZ6OmEj6MbUGVlP57CceUTSCvyZ6hy1ZNgZAoltoI53zqYkAc2KueT3e9WzoyO
         qsNqZb3fkJPaYhju/dlekYn8jTu+P5bG+t+CMnX3R7yQOfUVskyG9/yS3A43kXr+OQ+X
         GAP5YdnnSy6bg3JCiW6gV404e0OXXNoQcowmbeCvhnBR8BivHzlNRAcbYCD1VLf/l9O3
         mGPWJglEhRCQEau5f+WkeGQgJbwSMVhViFicR3MQWdUWxLA9SEn/+UMXqPTkWYa2Ixjy
         JpHg==
X-Gm-Message-State: ALQs6tB3IWkoVY3U0ycEF5K+QMGfEgRNSf/4V0x060i4o94PLdTA139m
        0o4QpgPNvCAiLoPR133YZtf+kB3wKyyV53+etRQ=
X-Google-Smtp-Source: AIpwx48g4ediT5HG5hHAX6aZsKddUM3IcXRHErJuc59/4QA0z7RUA5cw2Q5ZolJvmGi3GoobKLOyMMB7GMcWsftPtqs=
X-Received: by 2002:a6b:b354:: with SMTP id c81-v6mr2146631iof.99.1524063593960;
 Wed, 18 Apr 2018 07:59:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a78a:0:0:0:0:0 with HTTP; Wed, 18 Apr 2018 07:59:13
 -0700 (PDT)
In-Reply-To: <CAE5ih79Psc_dVOW54nszxFb+ma4k2bxnnUXJGiCx_qfSrwQitQ@mail.gmail.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
 <cover.1523981210.git.amazo@checkvideo.com> <CAJJpmi9OQicqEonVwWMo+yimU5MBdJ9gwzbtY1GXSMB+E69AGA@mail.gmail.com>
 <BYAPR08MB384591845049E50D98A42303DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
 <CAJJpmi_Qk-Q3ndiOFiYy5fGsKsJ0mF=nKbSDkdY-NE0DRkZTEg@mail.gmail.com>
 <BYAPR08MB3845A66624486DD1D534050EDAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
 <CAJJpmi-Uq8vfSOYaH+quMA87=P=66+JMGGvuLByAKQUy-fpDxg@mail.gmail.com> <CAE5ih79Psc_dVOW54nszxFb+ma4k2bxnnUXJGiCx_qfSrwQitQ@mail.gmail.com>
From:   Thandesha VK <thanvk@gmail.com>
Date:   Wed, 18 Apr 2018 07:59:13 -0700
Message-ID: <CAJJpmi8rxJ506HaxWFYmeJ8g2Z+Lvyuei0i6O1pv1fQ7_wC8Rg@mail.gmail.com>
Subject: Re: [BUG] git p4 clone fails when p4 sizes does not return 'fileSize' key
To:     Luke Diamand <luke@diamand.org>
Cc:     "Mazo, Andrey" <amazo@checkvideo.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just to be clear - git-p4 does not use the p4 "sizes" command anywhere AFAIK.

We are just talking about the output from "p4 print" and the
"fileSize" key, right?
--> Correct.

Does that happen with the 17.2 version of p4?
-->Correct.

print() probably makes more sense; can we try to use the function form
so that we don't deliberately make the path to python3 harder (albeit
in a very tiny way)
-->Sure.

If your server isn't reporting "fileSize" then there are a few other
places where I would expect git-p4 to also fail.
-->Most of other places are already doing key check in the hash. Looks
like this line was missed out.

On Wed, Apr 18, 2018 at 4:08 AM, Luke Diamand <luke@diamand.org> wrote:
> On 17 April 2018 at 20:12, Thandesha VK <thanvk@gmail.com> wrote:
>> I have few cases where even p4 -G sizes (or p4 sizes) is not returning
>> the size value even with latest version of p4 (17.2). In that case, we
>> have to regenerate the digest for file save it - It mean something is
>> wrong with the file in perforce.
>
> Just to be clear - git-p4 does not use the p4 "sizes" command anywhere AFAIK.
>
> We are just talking about the output from "p4 print" and the
> "fileSize" key, right?
>
> Does that happen with the 17.2 version of p4?
>
>> Regarding, sys.stdout.write v/s print, I see script using both of them
>> without a common pattern. I can change it to whatever is more
>> appropriate.
>
> print() probably makes more sense; can we try to use the function form
> so that we don't deliberately make the path to python3 harder (albeit
> in a very tiny way).
>
>>
>> On Tue, Apr 17, 2018 at 11:47 AM, Mazo, Andrey <amazo@checkvideo.com> wrote:
>>> Does a missing "fileSize" actually mean that there is something wrong with the file?
>>> Because, for me, `p4 -G print` doesn't print "fileSize" for _any_ file.
>>> (which I attribute to our rather ancient (2007.2) Perforce server)
>>> I'm not an expert in Perforce, so don't know for sure.
>
> My 2015 version of p4d reports a fileSize.
>
>>>
>>> However, `p4 -G sizes` works fine even with our p4 server.
>>> Should we then go one step further and use `p4 -G sizes` to obtain the "fileSize" when it's not returned by `p4 -G print`?
>>> Or is it an overkill for a simple verbose print out?
>
> If your server isn't reporting "fileSize" then there are a few other
> places where I would expect git-p4 to also fail.
>
> If we're going to support this very ancient version of p4d, then
> gracefully handling a missing fileSize will be useful.
>
>>>
>>> Also, please, find one comment inline below.
>>>
>>> Thank you,
>>> Andrey
>>>
>>> From: Thandesha VK <thanvk@gmail.com>
>>>> Sounds good. How about an enhanced version of fix from both of us.
>>>> This will let us know that something is not right with the file but
>>>> will not bark
>>>>
>>>> $ git diff
>>>> diff --git a/git-p4.py b/git-p4.py
>>>> index 7bb9cadc6..df901976f 100755
>>>> --- a/git-p4.py
>>>> +++ b/git-p4.py
>>>> @@ -2566,7 +2566,12 @@ class P4Sync(Command, P4UserMap):
>>>>          relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
>>>>          relPath = self.encodeWithUTF8(relPath)
>>>>          if verbose:
>>>> -            size = int(self.stream_file['fileSize'])
>>>> +            if 'fileSize' not in self.stream_file:
>>>> +               print "WARN: File size from perforce unknown. Please verify by p4 sizes %s" %(file['depotFile'])
>>> For whatever reason, the code below uses sys.stdout.write() instead of print().
>>> Should it be used here for consistency as well?
>>>
>>>> +               size = "-1"
>>>> +            else:
>>>> +               size = self.stream_file['fileSize']
>>>> +            size = int(size)
>>>>              sys.stdout.write('\r%s --> %s (%i MB)\n' %
>>>> (file['depotFile'], relPath, size/1024/1024))
>>>>              sys.stdout.flush()
>>>>
>>>>
>>>> On Tue, Apr 17, 2018 at 10:33 AM, Mazo, Andrey <amazo@checkvideo.com> wrote:
>>>>> Sure, I totally agree.
>>>>> Sorry, I just wasn't clear enough in my previous email.
>>>>> I meant that your patch suppresses "%s --> %s (%i MB)" line in case "fileSize" is not available,
>>>>> while my patch suppresses just "(%i MB)" portion if the "fileSize" is not known.
>>>>> In other words,
>>>>>  * if "fileSize" is known:
>>>>>  ** both yours and mine patches don't change existing behavior;
>>>>>  * if "fileSize" is not known:
>>>>>  ** your patch makes streamOneP4File() not print anything;
>>>>>  ** my patch makes streamOneP4File() print "%s --> %s".
>>>>>
>>>>> Hope, I'm clearer this time.
>>>>>
>>>>> Thank you,
>>>>> Andrey
>>>>>
>>>>> From: Thandesha VK <thanvk@gmail.com>
>>>>>> *I* think keeping the filesize info is better with --verbose option as
>>>>>> that gives some clue about the file we are working on. What do you
>>>>>> think?
>>>>>> Script has similar checks of key existence at other places where it is
>>>>>> looking for fileSize.
>>>>>>
>>>>>> On Tue, Apr 17, 2018 at 9:22 AM, Andrey Mazo <amazo@checkvideo.com> wrote:
>>>>>>> Huh, I actually have a slightly different fix for the same issue.
>>>>>>> It doesn't suppress the corresponding verbose output completely, but just removes the size information from it.
>>>>>>>
>>>>>>> Also, I'd mention that the workaround is trivial -- simply omit the "--verbose" option.
>>>>>>>
>>>>>>> Andrey Mazo (1):
>>>>>>>   git-p4: fix `sync --verbose` traceback due to 'fileSize'
>>>>>>>
>>>>>>>  git-p4.py | 8 ++++++--
>>>>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>>
>
> Thanks
> Luke



-- 
Thanks & Regards
Thandesha VK | Cellphone +1 (703) 459-5386
