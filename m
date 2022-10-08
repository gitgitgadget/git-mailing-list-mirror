Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FF4C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 06:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJHGw7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 02:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJHGw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 02:52:56 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F56D3DF38
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 23:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665211922; bh=gCABowqY/49srWsQ+dFNWrbVqKoF59AJEvJ2WpyY5i4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=daHbQvh6FWQ8IkIbD1wOUfriCH/Uz0Wdzcdrr7JRX/zfJiwFeqZfGmGiPgIRGrExB
         bQIlhXZr82oNGkAYMQ9tGlY96wRJd+Dm+qbA5TEvuzGhxRl58JK7eXWQfbAJxS2ljc
         +cz/1/Qtrf8E7id2aabXLS9o9yjX5kYC0SlGE8GCRQ9CY0mwsw8ZRe7EZAuzqfUOa3
         cg+NxK29APj7ic/35re+mBfxbP+yMxyWXrb8I/JprncKTd6S+8P/KPRWmXT73XfOsN
         BHCWZ2FighhjdFFJogcUUOaPg4uZjEEcWHC6CtH7X3eBhnI48FFsbtufVqBMU3MlMZ
         11IrLKVUx6REg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N5lj7-1pEXur1Rdb-0170cL; Sat, 08
 Oct 2022 08:52:02 +0200
Message-ID: <a8b83ff1-97b6-e2d2-91c7-ace597013368@web.de>
Date:   Sat, 8 Oct 2022 08:52:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH 0/2] Fix syntax errors under clang 11.0.0 on MacOS
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1375.git.1665085395.gitgitgadget@gmail.com>
 <0f67ca77-f17f-d844-e689-ca9a9bdf7993@jeffhostetler.com>
 <xmqqpmf3frr5.fsf@gitster.g> <ec920650-4334-a6f2-6d6f-241899dd79ec@web.de>
 <58d3ef47-2196-4f59-692a-fc86dfbc1252@jeffhostetler.com>
 <xmqqtu4fco9d.fsf@gitster.g>
 <CAPig+cS=k80JdCBAHbSqcOUBc=iGDetoT3u84oRj2CKpFs7CGg@mail.gmail.com>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAPig+cS=k80JdCBAHbSqcOUBc=iGDetoT3u84oRj2CKpFs7CGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CsPgudsJpJAG0zkFwo+1+b62sWOFvE9CpegU46OsyReaxr9QM32
 A57L71s1HX0wqbRFAl/ehyPmNzZ9f31XzhXMoCF257YV//IpEHMjZzdwS+ReKqI61RDSCoy
 B/sdO53Hc1UiilXfzeU+0yGLpd9Pg/2ibOdVvHs3+2zpyhO80B/8TkgDx7xkK7p23zOjhRo
 nqpu7JhP4soHLvt5XX8iA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:chmKXZwRc+I=:Wv1SXoCCtaQVO4C8M3/Otg
 RP7s9Axmy1wWAEWylzbTHAquCvSsnt50Z98gngrk7584+4Fn/fPcrPWHvBNBseWpqZvy40ENC
 iHkXSxzA05wnzwS5zEUyPCZeQ6zpcCO7RbhvFckU5IvnCF15bOLM0VzyUR9nYt+H585GZpLHx
 UOzt2nKbTjLTwo9ZAmCpW756wWQWO8K3aqCoV+6QhkJEichxENW0CoxAlUYIjhqjyaiX/ZBOa
 VKvge/6ay3plp1l5gPL0w1+wVr/Mw1tW2t4Rq0Tf44gxE1vjhKLFYInT6ZEr0tslABHWZNsGN
 TYic6VZnTQoXrcZNQq5gB8QHqv6ERviMxVIUyRepCmFPUAWl7Qj0r+BdfdE7A85AbhdhcfBPB
 8bjKf53haJJoGSGZybCdtd791ObK7auKaVToubiTSRfE1w8vEU2FboNmkHQn0X8L6+Tvz7K69
 PMHIhfBjlw13t+XwUiitv/bIDUQuH4Tlp4E363xx3djAtkat1lZjr0bL4ba/Gjj6/h7IY90Zq
 IkvFGsJgWOBTjWbkT/7PrY6oZoqvHufqg1WdW7m25r9zm+V7r9R75ZIh9HZDlihDuM6n5R8fh
 nlNP9729ohzSnPoCL7db9rjgUgm1ik9WhL+og8WVD3ccKeyt+P9Hok/YjDzpQpHYEE0I7Y0wa
 BhccvKLUv+gE9RefBOUqMPygfKDT2wax6hWWvE+YBTQ2A6+GzTY7DTmrSBwUN2LqcJBIIQk3X
 30G+EtyEdhtHRZeSfaNBl+1HU5D3fQ/IGrPNWc56QVf4dl86NnBZU+nMyZOlrIC06iUvLFY8o
 TACgnjLvfTtNDhV/6AQfGuUfikNB9X33swO586elZmIu+xLMuUWm/H2eygq/7MwqhgRpWxMj2
 soTzhxvqNgaj2YO9W6BHmBGmf39P+y4PJ+knBJh+Wp2BWEpU68SjUQE/NlL8yX8U3KZ5EwZzy
 rG4R08joveExfj722kd4pG0WREPs64xAzh5ONlZ4sHxRg9sQ7bLN2QK3CTkfGTODlUCdBq7aG
 VWTUBUN4WL9YTYgX8eyKSqjiiXbmzazorrkl0JOLXEDaDHAGoP5S2VDwQu6mhj/ay4ylwG3dc
 7aE/0kJ6u+oJM+ay0gzJWtKRLdUSWWNfAHiFObJFPTtYXd+fur+pwY3s5dbVTtrpZpux7RphI
 DEsNwxMiIvN0zZDylidYNxHvL+idhulf5gfghVjjC/k3qSFbGMsTwkNFNW/OqskZ1C0ZvKCYg
 6gAnacByn8zf3ycXWaWynIff7kIMRa+H5dXO/8hjza5Z6JytluvqCjAbz7FasYfOPrxvg9PCp
 P4c6FvTU9O+xUT65veXsL6rZnzSSKimxWHQ1mubAbzvJd24/o8Om00qy5c8QJw0jQJNAVHXFm
 Uy1YHbDBzrEs1jxJb6rpPqy0GgJ7CU3lhM9DJJoQUfMHCazmxP2h/zog5wqTNvbphs0+H74yk
 MhV4gB91DJ0qmYMbokOaEx+K2wifiL1mcZVprc9x7R5gZ1Xve9ALyqYkZ4kUiehXKipSfqR8h
 7djHfPNzOAssz8x2OwUmDpzcztM2Ic1LPDG4SpseqMP4g
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.10.22 um 05:46 schrieb Eric Sunshine:
> On Fri, Oct 7, 2022 at 5:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>> I do agree that one is dense, but aims for the same thing, and a bit
>> more.  It might be easier to read if written in longhand, but ...
>>
>> ifeq ($(uname_s),Darwin)
>> ifeq ($(filter clang12,$(COMPILER_FEATURES)),)
>> DEVELOPER_CFLAGS +=3D -Wno-missing-braces
>> endif
>> else
>> ifeq ($(filter clang9,$(COMPILER_FEATURES)),)
>> DEVELOPER_CFLAGS +=3D -Wno-missing-braces
>> endif
>> endif
>>
>> ... we'd need to repeat ourselves, so...
>
> The repetition is a very minor downside. The big benefit of this
> version is that it's easy to understand at-a-glance, unlike the
> "dense" version with its high cognitive load.

It's certainly easier.

It triggers for any compiler that is not clang, though, which is
a bit much.  Alternative compilers may not even understand that
flag.  So the whole thing should be wrapped in

   ifneq ($(filter clang1,$(COMPILER_FEATURES)),)
   ...
   endif

or

   ifneq ($(filter clang%,$(COMPILER_FEATURES)),)
   ...
   endif

Ren=C3=A9
