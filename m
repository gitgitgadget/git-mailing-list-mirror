Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39CB91F424
	for <e@80x24.org>; Wed, 18 Apr 2018 11:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeDRLIW (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 07:08:22 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:46696 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeDRLIV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 07:08:21 -0400
Received: by mail-qk0-f171.google.com with SMTP id s70so1258832qks.13
        for <git@vger.kernel.org>; Wed, 18 Apr 2018 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sNhbq2hi8opskgB9HAz7zDnwjPP+MI3GloRcAHlyo6U=;
        b=G5zRwarp3YA8KsNehZUDhrHTE3qwP4vC3DSpmYLN5I+5XbTOe5T5/n65aZ1L6y2+kL
         u0maQiIDX4CozRuunTf9oGJ9XybygWH+i5khHpvJmoHNgStljnMAs/HpqxU8uSLDEjV7
         8cxWvbLrVgCptuPuqM3ioyL2rye6mtC4C85mE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sNhbq2hi8opskgB9HAz7zDnwjPP+MI3GloRcAHlyo6U=;
        b=KndGY2VA9FaOHDK/t92NWZYIhRrsk8Esody0xb2iZk3leSmhr5JwSVqiwoH10W4Ad3
         IcYoI+7gKUBeL4t1xBuk4fQnWgo7CFp33sf+B/Xsc5/8+WZw5lR5N8U/z1IfnVrsTQR/
         Dv1vPJIPa4lrngUngl5pU3pBgyA0hrPcmP5G5V/uJhtz6BXszUB7VkEQWmIbexwwSfFD
         MSseRwejJ8KZQp33Lwkcr84CdmTucwShijidLMgpSfZyR/+PujyO7yZzVG9pg7lh5GL2
         o5zuA9DyUe8wGqFd5naLFu4oA93TQV7gT9Q2zjA7S/hFkxw5nNzcdLscclb17RaffJOw
         MMMg==
X-Gm-Message-State: ALQs6tB3fWaXITmJzDZSSsrBBeUOJ1qsXcLGWrBOlbiwTk8RMii9N1Fc
        2pjmh2JiYapnq99s4/o2K6ZObr9P+XZtb4RuiApoMQ==
X-Google-Smtp-Source: AB8JxZrQNuoh7cK4WwsY2x74I6r1+4ywOAHSzllKnPrSvqqyJqms5whjQUET7E+tbe8OBZdqduqUUW48I24CUF1uXHU=
X-Received: by 10.55.176.193 with SMTP id z184mr1473690qke.120.1524049699875;
 Wed, 18 Apr 2018 04:08:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.37.108 with HTTP; Wed, 18 Apr 2018 04:08:19 -0700 (PDT)
In-Reply-To: <CAJJpmi-Uq8vfSOYaH+quMA87=P=66+JMGGvuLByAKQUy-fpDxg@mail.gmail.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
 <cover.1523981210.git.amazo@checkvideo.com> <CAJJpmi9OQicqEonVwWMo+yimU5MBdJ9gwzbtY1GXSMB+E69AGA@mail.gmail.com>
 <BYAPR08MB384591845049E50D98A42303DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
 <CAJJpmi_Qk-Q3ndiOFiYy5fGsKsJ0mF=nKbSDkdY-NE0DRkZTEg@mail.gmail.com>
 <BYAPR08MB3845A66624486DD1D534050EDAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
 <CAJJpmi-Uq8vfSOYaH+quMA87=P=66+JMGGvuLByAKQUy-fpDxg@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Wed, 18 Apr 2018 12:08:19 +0100
Message-ID: <CAE5ih79Psc_dVOW54nszxFb+ma4k2bxnnUXJGiCx_qfSrwQitQ@mail.gmail.com>
Subject: Re: [BUG] git p4 clone fails when p4 sizes does not return 'fileSize' key
To:     Thandesha VK <thanvk@gmail.com>
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

On 17 April 2018 at 20:12, Thandesha VK <thanvk@gmail.com> wrote:
> I have few cases where even p4 -G sizes (or p4 sizes) is not returning
> the size value even with latest version of p4 (17.2). In that case, we
> have to regenerate the digest for file save it - It mean something is
> wrong with the file in perforce.

Just to be clear - git-p4 does not use the p4 "sizes" command anywhere AFAIK.

We are just talking about the output from "p4 print" and the
"fileSize" key, right?

Does that happen with the 17.2 version of p4?

> Regarding, sys.stdout.write v/s print, I see script using both of them
> without a common pattern. I can change it to whatever is more
> appropriate.

print() probably makes more sense; can we try to use the function form
so that we don't deliberately make the path to python3 harder (albeit
in a very tiny way).

>
> On Tue, Apr 17, 2018 at 11:47 AM, Mazo, Andrey <amazo@checkvideo.com> wrote:
>> Does a missing "fileSize" actually mean that there is something wrong with the file?
>> Because, for me, `p4 -G print` doesn't print "fileSize" for _any_ file.
>> (which I attribute to our rather ancient (2007.2) Perforce server)
>> I'm not an expert in Perforce, so don't know for sure.

My 2015 version of p4d reports a fileSize.

>>
>> However, `p4 -G sizes` works fine even with our p4 server.
>> Should we then go one step further and use `p4 -G sizes` to obtain the "fileSize" when it's not returned by `p4 -G print`?
>> Or is it an overkill for a simple verbose print out?

If your server isn't reporting "fileSize" then there are a few other
places where I would expect git-p4 to also fail.

If we're going to support this very ancient version of p4d, then
gracefully handling a missing fileSize will be useful.

>>
>> Also, please, find one comment inline below.
>>
>> Thank you,
>> Andrey
>>
>> From: Thandesha VK <thanvk@gmail.com>
>>> Sounds good. How about an enhanced version of fix from both of us.
>>> This will let us know that something is not right with the file but
>>> will not bark
>>>
>>> $ git diff
>>> diff --git a/git-p4.py b/git-p4.py
>>> index 7bb9cadc6..df901976f 100755
>>> --- a/git-p4.py
>>> +++ b/git-p4.py
>>> @@ -2566,7 +2566,12 @@ class P4Sync(Command, P4UserMap):
>>>          relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
>>>          relPath = self.encodeWithUTF8(relPath)
>>>          if verbose:
>>> -            size = int(self.stream_file['fileSize'])
>>> +            if 'fileSize' not in self.stream_file:
>>> +               print "WARN: File size from perforce unknown. Please verify by p4 sizes %s" %(file['depotFile'])
>> For whatever reason, the code below uses sys.stdout.write() instead of print().
>> Should it be used here for consistency as well?
>>
>>> +               size = "-1"
>>> +            else:
>>> +               size = self.stream_file['fileSize']
>>> +            size = int(size)
>>>              sys.stdout.write('\r%s --> %s (%i MB)\n' %
>>> (file['depotFile'], relPath, size/1024/1024))
>>>              sys.stdout.flush()
>>>
>>>
>>> On Tue, Apr 17, 2018 at 10:33 AM, Mazo, Andrey <amazo@checkvideo.com> wrote:
>>>> Sure, I totally agree.
>>>> Sorry, I just wasn't clear enough in my previous email.
>>>> I meant that your patch suppresses "%s --> %s (%i MB)" line in case "fileSize" is not available,
>>>> while my patch suppresses just "(%i MB)" portion if the "fileSize" is not known.
>>>> In other words,
>>>>  * if "fileSize" is known:
>>>>  ** both yours and mine patches don't change existing behavior;
>>>>  * if "fileSize" is not known:
>>>>  ** your patch makes streamOneP4File() not print anything;
>>>>  ** my patch makes streamOneP4File() print "%s --> %s".
>>>>
>>>> Hope, I'm clearer this time.
>>>>
>>>> Thank you,
>>>> Andrey
>>>>
>>>> From: Thandesha VK <thanvk@gmail.com>
>>>>> *I* think keeping the filesize info is better with --verbose option as
>>>>> that gives some clue about the file we are working on. What do you
>>>>> think?
>>>>> Script has similar checks of key existence at other places where it is
>>>>> looking for fileSize.
>>>>>
>>>>> On Tue, Apr 17, 2018 at 9:22 AM, Andrey Mazo <amazo@checkvideo.com> wrote:
>>>>>> Huh, I actually have a slightly different fix for the same issue.
>>>>>> It doesn't suppress the corresponding verbose output completely, but just removes the size information from it.
>>>>>>
>>>>>> Also, I'd mention that the workaround is trivial -- simply omit the "--verbose" option.
>>>>>>
>>>>>> Andrey Mazo (1):
>>>>>>   git-p4: fix `sync --verbose` traceback due to 'fileSize'
>>>>>>
>>>>>>  git-p4.py | 8 ++++++--
>>>>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>>>>

Thanks
Luke
