Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C216C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 07:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiANHrQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 02:47:16 -0500
Received: from mout.web.de ([212.227.15.4]:34131 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbiANHrP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 02:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642146426;
        bh=HWDHzw915wFy5m223ThlbU960mjU31m/4/F/OrMq8C0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=pXgEDWwFum8akY5iGg1F28Ql/MV/pPr/00VhN2serQL1iwr7WUYTvChi87mlTQNZg
         XKEra8xGHGyIwPeVMDDSVUNHfCmi78eLdVDHMC7pWbLMcpjN8LYPNEbaDpYAn8T2Yy
         FTc2RfOf5/wR6QDAotm5CEno9sbfeI1FTSopGkzM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDMzC-1n161U16wA-00AwG8; Fri, 14
 Jan 2022 08:47:06 +0100
Message-ID: <88899d16-5e3e-2bb2-07e9-59f7607c91a8@web.de>
Date:   Fri, 14 Jan 2022 08:47:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: git bisect bad @
Content-Language: en-US
To:     Ramkumar Ramachandra <r@artagnon.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        "Miriam R." <mirucam@gmail.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <xmqq4k6b34h8.fsf@gitster.g>
 <bafa9564-fa48-413d-bbef-3f068c03dd31@www.fastmail.com>
 <3dade45b-494f-663b-264b-06a51ea1cf56@web.de> <xmqq35lsyhbf.fsf@gitster.g>
 <13e323e9-eb0c-71c3-215f-b77c91fcc4c8@web.de>
 <5be4cdad-6769-68e8-0984-5fe89668d007@web.de>
 <421215c1-f6ae-4ec2-b666-2a481056ef79@www.fastmail.com>
 <CAP8UFD3tyBhrOQzg9j4qDAT0Tb8TCTK0=J6ORsiLVuMWn+W9wg@mail.gmail.com>
 <8bc73981-589e-20e5-247b-2f74e166ae1a@web.de>
 <925ef53d-c8b2-4ef4-acee-490900e8a3b7@www.fastmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <925ef53d-c8b2-4ef4-acee-490900e8a3b7@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FRK/pfcQ+WqKVeN0m0JaEprW8CKWMFv33W7m+FBhpeXw1Hmt+8S
 DSVt5F4S7ZxFYebt2vEbYW5oRXK8e0LRXZWfaqCaf7arW6WC5WHMT9ZGS+By6hCfM9HSzMA
 3kYdkYy5lj1I4Q/xbqlRnobtGPVnTGPKjl6Bxt29GeV7Z+SMXbwARDqTRJB+0IperKjFG2b
 r+tdpr2H8yQt8M81Goiyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rp3EejazrAY=:gNIULqoVLsjoQkeJWTK7Yk
 QsSc3IUqXEBLS3iSEeba3DA5JJ0szk8sdiJCvPV0Zsvy43rIHcjTFJOdfhDT6RphVO1jIGEz6
 sRMfJ2VUNSeKV1koiA8ZKXrvL2SekoJLjHQu/97v4c/F/KY1vulhUBN9Pui7PXDP5F7Oxl8Fz
 G5/nHiSxPDhVSU2UlbdSyxr4rFf39u+KGqCzPw9WKE1lXZ05jwrbGEaw+tSphh9+skQT4XMPU
 zHpSOEFfj3yRkZZn9zr8BX0NgYz10W/TMjFNKdWEEaTL6YvJY5aQ+nyjnnIW87OsYcX2228ll
 uO8c9t3GqaOlIcJ1oFvkUuz1TgvrWHHM+qXxGwO11KNSSlna1PxDxY/wE8V/ZlZVG9y7hZPjn
 UQEL9miYI3ryNSsu6ajmUSMQkT5A4LFxsVQoKdp5sOo3L1KpfLunM2AiKeKDovyeNTLCPxhmQ
 x1y5o6kjfftJI2g/Sak0KW5qcqTIM1UCcCMy9ZjkOQsRfx3Uydo+1DcRQgvRwwLYQuoiwVlAr
 pqps2D3DqiY5Vy1DOkpJKEPeyU4rI/yRG7lkap1eYjNXxUwOo3S5Li0O4RRZll/aygNldoNXz
 uwoXa+c9dDXMYuxK0PFyeThkmd4Lp1QhANrPy5+oWeKlUGIo5ljhMlDTSkx3ajpaqzdx+d8oA
 GflfqXEoC9/sXgEIasxtebAJmFcN2ZHPTlYyzLBTAPUXGhE6eg9yo/LOfaPa461u9DVjjPD1T
 yw1L7hd9DYJnm2iJo9POrBG9L9hG8AF6t1DF5ocN+pqpvz0zl6+xIlaAFnGKwpTzPtoWPibdc
 qsKzRFecoO0Q7YYcqVMXn76N3XhTztztNZ0BnfTMIYJUzH8yVp3HdVz2qYg7BWPRGFshZM1sS
 SS1Ku7+op5C7Bo+Bf9SLZnziRfZV5iXF3Q+91At4NArLMD/4Wg1vWe+sVqxZ+0ds+3lmDf4u+
 ilE/P5Sr8t4L1mZ+nsay2dUDAJ7gAadWvOmKQ4bh4hSqh0jAO3E4IYJo9M+1fAHYh1LGLh5Qt
 AYoD5YyKAimWT7G3qd1SmkjGgIAyxnfBgB0x4FRpIh3PBJ31+8TIZeb53PZw15ESS7nkUnhIN
 R/MbslozBibLaI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.01.22 um 16:16 schrieb Ramkumar Ramachandra:
> Ren=C3=A9 Scharfe wrote:
>> The implementation language of git bisect is not immediately relevant
>> here, but that the shell is used to call the user-supplied bisect run
>> script is.  If we'd run it directly (without RUN_USING_SHELL) we could
>> distinguish error code 126/127 from execution errors.  I assume the
>> option is used to stay compatible with the old shell version of bisect.
>
> Sorry, my misunderstanding. I thought the external command was being
> called from git-bisect.sh. I don't think I understand the purpose of
> RUN_USING_SHELL (it just seems to put an "sh -c" in the beginning):
>
> 	static const char **prepare_shell_cmd(struct strvec *out, const char **=
argv)
> 	{
>         ...
> 			strvec_push(out, "sh");
> 			strvec_push(out, "-c");
>
> 			if (!argv[1])
> 				strvec_push(out, argv[0]);
> 			else
> 				strvec_pushf(out, "%s \"$@\"", argv[0]);
>        ...
> 	}

Using the shell allows the bisect run command to be any shell command,
not just some script.  E.g. you could bisect a build failure with just
"git bisect run make".  Quite useful.

Ren=C3=A9
