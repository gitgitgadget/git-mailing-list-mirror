Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD3FB20248
	for <e@80x24.org>; Thu, 21 Mar 2019 09:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfCUJ2Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 05:28:24 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:41165 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfCUJ2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 05:28:24 -0400
Received: by mail-pf1-f179.google.com with SMTP id d25so3914225pfn.8
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BK+tUR86kyUpyu0fMlDeWSEk7IN6PA3VxJX1rjXcCag=;
        b=Xh38Tjoz7BND1SWKrvpXySifSOfn6YcvidT1TyBjfAGm/BRFjvrCyq+JekvWI3olk1
         LpCivvTa7YQnSi+4Az9y10rTXpLmcTC+zeJ9/F3LPT4TfTxFFmxauPSnbXnVO76aBUfC
         wHKMpH4iOs1GleqSYD8RppCORD6cYYoiVOudyTojpModR52ngE0i+GUxjS/D+u2MlhTR
         qeiLzLjqLKzbGVDxN2jqO8P68ZNHaFd2YSVzb0cbEDeaImW1KgdD/DfW5WU94BYsLqin
         l6QsJOHrOx9NZw/UNIe8L4fHm3idroB6hBXuQ2nzY7VqMHHvYyL/epfCvhOB4qXSAOee
         uqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=BK+tUR86kyUpyu0fMlDeWSEk7IN6PA3VxJX1rjXcCag=;
        b=J6kM/XWAARY+rJLZqFpQ3IiYwl8DI88zhmnbXuw94FSDss7nnyUV4QcgEBla30i3Y2
         /0hls/Oxuz3F+MXT3VfWQCFzs1dHEMTRtRHazwDtEvuBYpf+U5Cpl9Bph8fb4dWLfvBI
         khS97hNJN/Z9EReuPZug/crUDXdaMJoA18iybRNeQlgYV506K6LS8jOpRqmXrJDdKmWj
         t4aDEDm6+UGzwKpOMu2waqt69ieqt0NRBEb09VKLRNdgp/LZ9qUNLkaq6AsR4ctBJsXE
         8/OwAqz5DbSmJkEZJvY7yYJh0Sw4CCUM8QlUPA+gNtKlSu84t6bKSIfcpwJleDs62lYR
         p1Xw==
X-Gm-Message-State: APjAAAVFPVZS1tvgCQiAtj4PgiKqTN4spId0ocPhzj3WBJ06gm95KK0v
        RYbcdQE+oG9f+NwTzzRyhgnMjCDafKY=
X-Google-Smtp-Source: APXvYqwBT/WG7T2OGIbME1HcSOeFpM87FwEJ02xiou0reALqSqv3rw4HByRftTNHsTtN1snNcrqP1A==
X-Received: by 2002:a17:902:7e49:: with SMTP id a9mr2362722pln.303.1553160502349;
        Thu, 21 Mar 2019 02:28:22 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by smtp.gmail.com with ESMTPSA id 6sm5071743pfi.53.2019.03.21.02.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 02:28:21 -0700 (PDT)
Subject: Re: Git server side "pre-receive" hook to create new repositories
To:     Dimitri Joukoff <dimitri.joukoff@griffithuni.edu.au>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <SYXPR01MB095712C6765970605923A2FDDD4E0@SYXPR01MB0957.ausprd01.prod.outlook.com>
 <20190319070629.GE31801@sigill.intra.peff.net>
 <87d0mndxop.fsf@evledraar.gmail.com>
 <SYXPR01MB09570A4CBFC30A36150C90BCDD400@SYXPR01MB0957.ausprd01.prod.outlook.com>
From:   Sitaram Chamarty <sitaramc@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=sitaramc@gmail.com; prefer-encrypt=mutual; keydata=
 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
 ZNJ7wKEHInRBmycqkB/ksby8tHy6yfE6
Message-ID: <c9211cf1-7c27-1274-0433-bc1237bbe199@gmail.com>
Date:   Thu, 21 Mar 2019 14:58:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <SYXPR01MB09570A4CBFC30A36150C90BCDD400@SYXPR01MB0957.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 19/03/2019 17.46, Dimitri Joukoff wrote:
> Thanks for the feedback.
> 
> Whilst I understand the options that you've both proposed, the intent
> was to enable the Swift Package Manager to mirror repositories in a
> transparent way.  I'll look into whether these options can be
> implemented inside the SPM.

I don't know the Swift Package Manager, but looking at the preceding
discussion reminded that gitolite allows this.

I'm not saying that someone should install gitolite just to get this
feature, but rather that *any* script that traps the incoming request
can do this.  Almost trivial if the request is coming in via ssh,
actually.  Just set the shell to a script that looks at and parses
SSH_ORIGINAL_COMMAND and do whatever is needed before passing control to
git proper.

sitaram

> 
> Cheers,
> Dimitri.
> 
> 
> On 19/3/19 7:24 pm, Ævar Arnfjörð Bjarmason wrote:
>> On Tue, Mar 19 2019, Jeff King wrote:
>>
>>> On Sat, Mar 09, 2019 at 10:46:09AM +0000, Dimitri Joukoff wrote:
>>>
>>>> Thus, this feature request is asking that the 'pre-receive' hook
>>>> triggers when someone tries to push to a repository regardless of
>>>> whether the repository exists.  This would allow automatic creation of
>>>> new repositories and smooth the work-flow described above.  If the
>>>> semantics of the existing 'pre-receive' hook are such that it would not
>>>> be suitable for such a purpose, then an alternative way of providing the
>>>> call-back ability would be implemented.
>>> The pre-receive hook is a bit too late for this. It runs after the
>>> server has told the client what it has in the repo, the client decides
>>> what to push, and the server has received the pack. So receive-pack
>>> would have to know about this and fake having an empty repository. And
>>> then figure out where to store the incoming packfile, since we have no
>>> repo.
>>>
>>> So I think it would have to be another hook that runs before the rest of
>>> receive-pack. I.e., a system-level config option that says "if you are
>>> asked to accept a push for a repo and it doesn't exist, run this instead
>>> and then run as usual".
>>>
>>> It does feel a little error-prone, though, if the client does not
>>> positively say "I want you to create this if it doesn't exist".
>>> Otherwise if I do "git push server:my-misspelled-repo.git", the result
>>> is going to be rather confusing. And retro-fitting that into the
>>> receive-pack protocol is going to be tricky.
>>>
>>> It would be much easier to have a separate endpoint for the client to
>>> say "please make this repo if it doesn't exist". And then just run that
>>> before doing the push.
>>>
>>> For an unrestricted client connecting over ssh, we already have that:
>>> you can just run "ssh $host git init /path/to/repo". There isn't a
>>> similar thing that can be done over HTTP, though.
>> Sounds simpler to just change the user's login shell to a wrapper that
>> checks if the repo exists, and if not create it before proceeding.
>>
>> The same with http(s). I.e. in whatever webserver that's now pointing to
>> git-http-backend as a script point to the same wrapper script.
>>
>>
> 
> 
> 

-- 
sitaram
