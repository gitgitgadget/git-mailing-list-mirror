Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50856C433F5
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 10:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1B061A05
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 10:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhJCKRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 06:17:17 -0400
Received: from mout.web.de ([212.227.15.4]:36111 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhJCKRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 06:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633256122;
        bh=PE3zQ0SQlna5OHcWQFA3MNPKn42PxqlVrFLJYqXY/tc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HOivS0jgDCNWVvGxxfpeirIbDegCkFlzbTPXXa8CX7Hr+fG2ztY/FjGMtUy4/Rh4D
         h6bpb/7mJQ3jOnVVbqkTHQgiuwQ0ytSDJfGuxmJimWvI7/SAbRNEozdRAgM+cy1W93
         6r7CGSMcIH0dO5afBUgRJSBd/hYatuvQFCmiFFWI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MV4tp-1mIXGJ1a3x-00YROY; Sun, 03 Oct 2021 12:15:22 +0200
Subject: Re: [PATCH 3/9] test-mergesort: add test subcommand
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de> <xmqq7dew7aqd.fsf@gitster.g>
 <87o887q0s9.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <850aa059-61d9-0eba-5809-e0c27a19dfb4@web.de>
Date:   Sun, 3 Oct 2021 12:15:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87o887q0s9.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CzRhAElFhr0/VoDV3qztXzGio/W3JDbNmb1Qd3aGmDct7OaZzP5
 sh4kNPvcXeQsnXui1T6JEV0Q17/Tu9to2Uafm0F9q97hPQLmt5Brnx7I9NE8IydicmGxNmn
 TpGQfGJbNRZfD0thzNX1B/3oBl3bndtZB1ur/eXcEvC64WHOouHe4RMiDCQRRaunaOCXlvz
 XhcdPuLVE+creVVU1txFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wZly8/E+sSQ=:YeDe101mrJEZeWgtox/IZT
 RTDa9YoXj+qt0Q+4dte3uafp4C/vTSpscR0e0gg3VcJ7vS7Ts8eRpbyoTvMOXGEI6sTtuEd0h
 pYn2y+zX13D2nfruM0L4WUqI4/KQMqIkS7O0bzBJ+/JuU8EpmSTMcRqTghwAKsyWIueEcsGSJ
 AE8ewmFEfOlQlW9LU3oqHs1qrKIry9YUjda47kxKPjYv5HT/IbuR1IQE5MkK4r6U3oVLe9Eip
 NtWyS4RqHV2KlcAiGaSY90BkyFhbpluh/N4y35IWmsDfRb+X+uNxlNXdkC3jUQrX/4KcAtO5e
 dg8R5/Ab2p3LizQ36gwicNZ4nWvkC+0Enz2ou9/0l9duD79Wuu7t8WPMoVKiKXQbo7y/ljURs
 jcmMRqVnIjAUkuMzsuDzEDDH9p2Luq0xLLAfvPN5vTELLChUAVd0ZtpUlIjIr2xMMZQicq+6g
 nCrE1ZIsf7GurypTiCXFhjJAUuRfhykXjq7T5eQo8dw0oW+ZtACzwjF6CHCzVX6od47CNRqjq
 tTyRyKhpdt5w8spnEPG44Qa19FtupsipvJgLQs2As3IPdVp9fazcxblnW4o+5zdN1ezBOBIbs
 P8yz8CMfV+gMR0CZSfsSLVsFQ7EsPijXqTHhs34gmmJr93X/sIa+c5Ib1lTMod33eJ8lYAPo9
 KzX6J+F3EYHGsJ7oyjh0GUouKp4BC5AqMJ+DHsAS7k2FuchIjSJHL+qG0tdONdueoziPu2OkG
 EaG6hcHP8HwRSnkgk/+lRXP39sfFK1ECVtuu/7GVa6SCqMs9G+HChjWhWDE5TBKLxWXFZH7NI
 4zrh+dapU8h9Minq0T+sX6YdHUqRGOu6YbnceugI2rJoDZykVPRhYtxqB1eZVCnC63Poi9i4E
 DbvDEQFDcvuBp2PpoCHmLqvF7pix5Skfc+nN9YMXgaDroKI/YmqmbA30gEVhgzCxFTuJy9r6i
 VE9lExLig7JxU9QSHTVRBUPHelxEiObySzZ2VQKJYzNOz6uPXnw1F7eiK89WtubVCOqnSLxZ5
 GCgcS2799TKwOL0zSxUOXAs7QZnnQwWk4UpQTnNU6fpuwlpEY9pqwSkp2WCwj/QM1jrZNSRs/
 tm5wYYvx2VxUz0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.10.21 um 10:35 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Fri, Oct 01 2021, Junio C Hamano wrote:
>
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>> +static void dist_rand(int *arr, int n, int m)
>>> +{
>>> +	int i;
>>> +	for (i =3D 0; i < n; i++)
>>> +		arr[i] =3D rand() % m;
>>> +}
>>> ...
>>> +static void dist_shuffle(int *arr, int n, int m)
>>> +{
>>> +	int i, j, k;
>>> +	for (i =3D j =3D 0, k =3D 1; i < n; i++)
>>> +		arr[i] =3D (rand() % m) ? (j +=3D 2) : (k +=3D 2);
>>> +}
>>
>> I briefly wondered if we want to seed the rand() in some way to make
>> the tests reproducible, but we'd need to ship our own rand() if we
>> wanted to go that route, which would probably be too much.
>
> Wouldn't calling srand() with some constant value suffice on most
> platforms? I'm aware of it being a NOOP and rand() always being randomly
> seeded on (IIRC) OpenBSD, but that should work on e.g. glibc.

Right, so we'd need to ship our own random number generator.

Repeatable tests are not essential (the original paper didn't mention
seeding), but shouldn't be much trouble to implement and would simplify
comparisons across versions, systems and among testers.

The only downside I can think of is that it may perhaps also simplify
over-fitting, i.e. I might find micro-tweaks that only work for our
specific rand() sequence and then misinterpret them as general
improvements..

Ren=C3=A9
