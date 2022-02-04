Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C610C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 17:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376877AbiBDR2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 12:28:09 -0500
Received: from mout.web.de ([217.72.192.78]:33815 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234250AbiBDR2I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 12:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1643995676;
        bh=KpE1hyuDXuhQE++JIJpkWLd9bryka1XgHd4IMjV5kpg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Dcb0eIOs8EAWhXsMZ54LnDHzOkBHLF+bCOMyt7fq/DfAp+kmZX2o8W4hyJtbJXoWn
         b/1ymMA727ULNoAaruvMePgfw2eskB+IKR972Yt4guvRQRoUgCMKXDFXuPDfCWi8y8
         2bgOf8Xprrme2zHOMxxwzxHUD5XYpGeSQL9/tgfY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjIb-1mkKdv2Ach-00WYBv; Fri, 04
 Feb 2022 18:27:56 +0100
Message-ID: <deaf8988-f831-b924-77d7-4973473846d8@web.de>
Date:   Fri, 4 Feb 2022 18:27:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: What's cooking in git.git (Jan 2022, #07; Mon, 24)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqq35lc53e9.fsf@gitster.g>
 <YfRu0G9aNQxT3vtl@camp.crustytoothpaste.net> <xmqqiltvpjc7.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqiltvpjc7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qd+tvhJe1YK/mMLmsgLNXqlfazNKgzpBil2ImJX0VaU5uOtNtLe
 SP2kEjW6aYT4wEw6myK4umOAHdkEKqd1HNiEnoYG3PWQ4Hc7Xs3ScdKHYfqj17Cx2wVbOFK
 7yjWG4IttIU9Cwh1lJ0A7GAJYEmi5rUn5OSXj8T0fbO+y1B5UzrUhdHoBQFULdcDntdJzT0
 V7IbR76mE2vvql1acVu/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0xXK/xrV684=:dz+9UdQQf61t8yoW4PIu8v
 b3rpiu8CtNoLjhgJbw9O5JhvInryNrUvK7WmSnxmFceRoL26zxCmpSI1vwCttXa/6xc05eAFo
 weazuWmrNQ5i78wKtlRKEej8TjERkKu+XZDKL1pk1ebl5F9bdWceaX4r1dZdxPjAzUFU1nlJt
 sHkiT4m18hhSPq7JNUmaBjwjb965nLe0Yp09rS28YmddxK/p8QaxB5NYT5P5wpMHta9e0e6U/
 Ia2pY9u1zlLW5hc35fp7LqMmkvRedz49PumiPgQmhRYn9+yxj6dsD9fobrkrWcWGj5mtqflmA
 pykKU7EpNQ/bWx9xV/JPq+7FhO15MY/CWNDLpqWYnGLd1pWqQ7IRHwHH5YlFKzcXYNrEJmUhC
 o7B3d51KCb/AX3atp9cvZSeaoC+Uk9fzmjAC+vwZxlbEzNuftFju97XuFFUi+0RPkwYqk2k6L
 uyVkqO4HsZNvaQUk7ecLI/glwpfSlfDKnoAoU61dpE4XP8US5VnOzz9YFtSIi+j7+MV9PwvWd
 pBxvcn5Ywcd/FRZSyn6u9gB1sNZNMfwZ5+rJwGYnblsnA1xL5wRKUNEQf4nx0WC15pB+c3AAH
 nCB4YTFnEftra0l+2WPOR8amYlpoSS1KZySI0LgWO75d6h8X5xDesLlr1ErY7VvAe4Q2qBJrh
 s/KQYC1ZvYf9vboASH3UxowuXAAI92Sbh5nIiPSB2yknbJzub2Dr3SHggg6RehHTi6wzpUQjl
 MayyBNDO0fErftua8CA2a3mjoDvF+HSUn1zT+X5qUnO4zSxbh5lLN1BI1khyB7H43WBAqzgRZ
 lZgxgTR+Yx1jC01nFyjv+yfnZKa7thUdBc0iW/R2M7XNBHZZZNzoyn9zG6bA8PTxdrycrsF9w
 jNyMbM5u7sx1lXY/3RtFB5dS2BonLOSAZTU4UKOPGv0vMQRQy1kn3XDbJ9IeQBjeY8eS5kfJ9
 gHonxjsVqEDsM8w6wuzYVuXmKjuqWsgscpIHtHo/sqYV4hzSN4G36msBALE4LE8fYqIqWZ125
 97kiKmI4UgHDfAut+S99sI6gLBxvzZ+sysqmraYP2AYc9SWP5C5JpxFj8diE04juWg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.02.22 um 01:27 schrieb Junio C Hamano:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>>> * bc/csprng-mktemps (2022-01-17) 2 commits
>>>  - wrapper: use a CSPRNG to generate random file names
>>>  - wrapper: add a helper to generate numbers from a CSPRNG
>>>
>>>  Pick a better random number generator and use it when we prepare
>>>  temporary filenames.
>>>
>>>  Are we solving the right problem?
>>>  cf. <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
>>>  source: <20220117215617.843190-1-sandals@crustytoothpaste.net>
>>
>> It sounds like folks would prefer we drop this series.  I'm not plannin=
g
>> to send an alternate approach here.
>
> I personally am OK with these two patches, by the way.  There was an
> interesting thought experiment to see if we can only rely on
> mkstemp() and mkdtemp() that we assume are already secure enough,
> but swapping the not-particularly-good linear conguential generator
> used in git_mkstemps_mode() with a better algorithm that is
> externally supported, making the security issue somebody else's
> problem, is a good incremental improvement, I would think.

We can use mkdtemp(3) in diff.c to get rid of the prefix currently added
to temporary filenames, but using mkstemp(3) to create files with custom
permissions with proper umask(2) handling is painful.  Replacing the RNG
in git_mkstemps_mode(), as this series does, is simpler overall.

> Unless I hear differently from others, I am planning to mark the
> topic for 'next' in my draft of the "What's cooking" report.

Great!

Ren=C3=A9
