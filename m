Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F519C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 22:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F96611AC
	for <git@archiver.kernel.org>; Sun, 30 May 2021 22:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhE3W2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 18:28:06 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:52307 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhE3W2F (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 18:28:05 -0400
Received: from [192.168.1.37] ([92.14.216.189])
        by smtp.talktalk.net with SMTP
        id nTt1lDOACTQcpnTt1ltmxN; Sun, 30 May 2021 23:26:24 +0100
X-Originating-IP: [92.14.216.189]
X-Spam: 0
X-OAuthority: v=2.3 cv=BpHjPrf5 c=1 sm=1 tr=0 a=To+zG77qUefWDbcJBNV7oA==:117
 a=To+zG77qUefWDbcJBNV7oA==:17 a=IkcTkHD0fZMA:10 a=MKtGQD3n3ToA:10
 a=1oJP67jkp3AA:10 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=pGLkceISAAAA:8
 a=jJrOw3FHAAAA:8 a=opnj0hg5AAAA:8 a=yMhMjlubAAAA:8 a=f1hami8VAAAA:8
 a=r6CUYczcJLOWFD4YqtIA:9 a=QEXdDO2ut3YA:10 a=zqogV2xL19AA:10
 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=lsIkP6lG2H4f0j7eDx0G:22
 a=FtKrU1ehnr4BV_omkn0c:22 a=FMFxGtP9trmfb28vA-lX:22
Subject: Re: [RFH] CMake: detect if being run via Visual Studio, independent
 of build generator?
From:   Philip Oakley <philipoakley@iee.email>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Matt Rogers <mattr94@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Danh Doan <congdanhqx@gmail.com>
References: <013f42a4-19f4-a935-7068-db3f7ff40446@iee.email>
 <CAOjrSZtWVEUNEuJFw8WGPAW0YNccN9LWyuHZ28aKecdjd6dp=A@mail.gmail.com>
 <7aadc622-ad4f-1d7e-a956-57ab74f18096@iee.email>
 <CAKiG+9U70wXm7MtTLMUpPC_aHMp58bTtJBbP=NgoAcQQmCPSuQ@mail.gmail.com>
 <7ac2c0f4-e8ed-5676-1f81-3446e33def9c@iee.email>
 <CAKiG+9UeT70S3_jNXUbx2KCM6UDUxPKMizFX_fUiioDo-zmp+Q@mail.gmail.com>
 <CAOjrSZtRH-sqh8RJm3W00dUWTbT-xcpzDWCQFt=3CNaVnOyVWQ@mail.gmail.com>
 <953d685c-3c89-7377-ed49-b79fb4e0acb5@iee.email>
 <CAOjrSZuzgBs8camWdUjEU+JOjRYwv3MVjRgnyW50pchq6rpYsQ@mail.gmail.com>
 <CAKiG+9WwRHz-5JDPe6KL763kVfRP7vX5HgtDMiX-S1Je5+oWfg@mail.gmail.com>
 <e33bd72f-2095-f32d-5f4f-6137f6a12d22@iee.email>
Message-ID: <580d858d-dcd3-9d62-ec97-2daa9d9e0f45@iee.email>
Date:   Sun, 30 May 2021 23:26:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <e33bd72f-2095-f32d-5f4f-6137f6a12d22@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfJ+KoeKeI10vPeO96cnxsiZbhFmDzeVDiDUpp8unaLdHTO4qiLUg3R+c3yls9Hl8rBjzU7HHJZDYcv4mmC8gzx0zc+Rf6/wWQWA7sxedrH42+lm41K9Q
 y2AXvWXLABMMWYSnnfCH7k0jg5vbYRiQnziDhA7Z1hM/Sq0jaRSA1NrvpRP/jF2OzkEK/+p43g+KrvrFK/635khe1dMqUemEdrzuRH9NkeEIZ1uDnNVoT//o
 j51Hcbyi4mKdpeX4I0p6RVuexDz8ZIJo0GZwLT757gmi0vjIxsLTuf68k7Rr3qo1lbg/r2oU0rDr3Dgo7K6WFQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/05/2021 16:24, Philip Oakley wrote:
> On 30/05/2021 15:29, Sibi Siddharthan wrote:
>> On Sun, May 30, 2021 at 6:52 PM Matt Rogers <mattr94@gmail.com> wrote:
>>
>>> I think the best middle of the line solution would be to just provide a manual
>>> knob for turning vcpkg support on/off here and offer configurations in
>>> CMakePresets.json for both situations.  The only downside here is that I believe
>>> a lot of IDE's are aggressive about running the cmake configuration step and may
>>> try to install vcpkg even if it is unnecessary.  But automatic
>>> generation can generally
>>> be turned off by users I guess.
>> I agree. I would suggest vcpkg should be used by default for Windows platforms.
>> This way IDE's won't complain and command line users can straight up
>> disable this behaviour.
>>
>> Thank You,
>> Sibi Siddharthan
> I think so as well.
>
> I'd started writing (draft) in reply to Matt
>
> "I'd agree that knowledgable users should be able to control the
> settings, however I'm against forcing less knowledgable users being
> required to add extra control option for knobs they don't yet
> understand, hence the desire to ensure a consistent (though possible
> old-fashioned/backward-compatible) settings 'that just work' that do not
> set in stone those choices, which would be the worst of both worlds!
>
> It maybe that in some ways we may have missed the boat as those project
> based CMakePresets.json presets (setting back to old defaults) could
> 'annoy' the (potentially) experienced users who are simply using the new
> defaults. This doesn't affect (*) truly experience users who are setting
> their desired options directly as they would/should override the presets."
>
> My other consideration is that the build process should generate enough
> of the right artefacts (e.g. a .sln etc). This is so that other typical
> tools and extensions e.g. Sourcetrail which expects the .sln, but maybe
> they'll also cope with Ninja/Cmake builds soon...
>
> I'll have a go, 

I had a look at the previous link and others (below) but I think there
is a potential Catch-22 problem as it [see cppblog] also expects the
user to do some enabling of the use of presets (If I Read Correctly). My
initial use case is 'out of the box' usage;-)

This suggests I may need to fallback on ensuing we give instructions on
bypassing the potentially failing parts (e.g. run the vcpkg install one
self, other steps, ...)

I did find a recent video on the presets which was helpful:
   An Introduction to CMakePresets.json : the simple example
https://youtu.be/NFbnm1t6Mc4?t=251

It feels like having both the presets and the fallback instructions may
be the way to go to cover the range of use cases,

> though I'll be off-line for a while from ~Tuesday.
>
> Philip
>
> (*) - affect/effect?
> https://www.londonschool.com/nordic/blogg/whats-difference-between-affect-and-effect-and-when-should-they-be-used/


> Please see
https://docs.microsoft.com/en-us/cpp/build/cmakesettings-reference?view=msvc-160

Other links:
https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html
https://devblogs.microsoft.com/cppblog/cmake-presets-integration-in-visual-studio-and-visual-studio-code/
https://docs.microsoft.com/en-us/cpp/build/cmake-presets-json-reference?view=msvc-160
