Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC6FC433EF
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 10:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251C861A05
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 10:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhJCKRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 06:17:17 -0400
Received: from mout.web.de ([212.227.15.3]:58579 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhJCKRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 06:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633256124;
        bh=t2xil8TavYWIL8r4mljB4LFtrYgKdJl5nN5m00Lf/uI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=IZGIGhJLJxvG64e7Qr5rbO7DPTI4tUeQ4t2SuP+0FIx8QmA9bH7761qjhxpdulv2l
         Na2sZqA1DUfowdv3BFtzVmaRF0gCQkxA9F7LAV+YL8GIBk8CrzawzybDqRmndic3gO
         pqBv3oMFHYMHS4249bi/O4rHTLoshVT9Xc+V8gJs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MMZck-1mS3N42zoU-008Ffk; Sun, 03 Oct 2021 12:15:24 +0200
Subject: Re: [PATCH 3/9] test-mergesort: add test subcommand
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de> <xmqq7dew7aqd.fsf@gitster.g>
 <87o887q0s9.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d03313db-1c1d-0e27-cdf3-06a389dcd3ae@web.de>
Date:   Sun, 3 Oct 2021 12:15:24 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <87o887q0s9.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o1l3TNnjkKvEL8nRWTEq9Xqqfg6vxXtm3kT9JFoUGSkn/JXDKHo
 L6vI0qvvTKSGOdoZ/hQzGpF8AcLGPf55pE5awhJpw1NgPUCy8OeV7GMDeB6uIAHHqjFPZAn
 jLl/I7oWTQUzTIsq52Bp8QsgQzdBCgwHsnp6N/BdRg32++3FmdYNi1Qk/+menmAWJNZAl5f
 9TdbDEdtLQtL7o7jxN78A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tu1IDZ8FGBs=:wkHufEeq1YYLRqLRuvcVzg
 /14MgiWsVEZrfaBqAhjaZYoNj2j3kfa7YG0/E7rncbWbh9xOJi+JvrXCNJMRAVLgZhZ+eiVJB
 +Kmto84PSAHVQdeP58A86j3XZ6yg7/kKlBhgOca7wu2+imz/g6AYiJCpzU604v5taYi6S2NM7
 lXkqeJBV6ad7SfA5BhqDaXY/8NNvo+oViL+SNc1HQFmmL3d/z+FnUib4nsN+XuxKSruJOJ7I4
 /6MmxnvEcqeLq5/KHL6UTD11T7ZABBiNupCIUlPLWJngka4wmvvyBhkB10aho45qar9xD55TW
 AJzZLKvaViQaUuBkpWlxbNp1/Pz+fRBOiHZMYjuUQ7S0H5WkdcgzjjP55twCCfzD6BQQ3U+df
 +o/1W4BH8biO5JLYekHv4PO6fvrvswv7rg3IP8uSG5Ly+QzwpnMG8UomqB5zEMq7Ci3FUlNI3
 aSaq+JVLDJhgNJEfPlyvCyJWGJz4BDHK07z63MVFK0I7QxEkOWH/Yg6xFJ/BmBaM2eFLkZn1V
 Vh4UJuYY0r0eprwuGZs7sqgcVtSgcMMEw32toLhWd7dHAyYWthID9lHiXU4DMhzmbU4dVdLfU
 0r3J6OaL/sEICpw8TwNUlAg7yZfwsYHZEMJH69tNJX4NMKhsk9a/ff8Igx18Dgt/zduamrbQ1
 lxEQKtnL7nGepDYDJ2efLKdsnjG0/idgzrQicbHpXoFzXQxVT0ItfKqMQ62aiCB/rI+VbDlpD
 QFR/tOLnwPRY0TPD0b/rfpu5aigLh2k0zISma9327uu83z7J4LIU6OWFsTwP9yRDenqglc+3V
 8Bce5i4/e+jbdzHTmSQv1yB9iQcSA74jNVa1KdH5cNuGuZaZIQyuBFjtxOCjJo/oCgOLd/v4t
 hnrVEYUuZp8BwP31ViIR30B0ubgjtnu1FcUXpi0xEQU6SMyhcgkfq2OxpMqtH31D+oOXRSFnY
 4gAI/ruRJprd1gyazag9w5SD0x575PTuvj6nf866kUkq/wy/izBZoKJUZzult2FOnKXCO91Ch
 jRxQkECxwM+Lw55i0cRFPxYcAdWCOPXg6k8Xcu/TYshmuJL9cdEVMqhcol5Qf5dvDv+ZLL27m
 atdzYlQoWURrR0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.10.21 um 10:35 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Fri, Oct 01 2021, Junio C Hamano wrote:
>
>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>
>>>  int cmd__mergesort(int argc, const char **argv)
>>>  {
>>>  	if (argc =3D=3D 2 && !strcmp(argv[1], "sort"))
>>>  		return sort_stdin();
>>> -	usage("test-tool mergesort sort");
>>> +	if (argc > 1 && !strcmp(argv[1], "test"))
>>> +		return run_tests(argc - 2, argv + 2);
>>> +	fprintf(stderr, "usage: test-tool mergesort sort\n");
>>> +	fprintf(stderr, "   or: test-tool mergesort test [<n>...]\n");
>>> +	return 129;
>>
>> If you can live with OPT_CMDMODE to implement sort/test subcommands,
>> you'd get to have parse_options() to do the usage for you, I think.
>> I am not sure if it is worth it, as t/helper/ is not end-user
>> facing.
>
> Yeah I think the one thing that could improve here is this custom
> getopts handling, in particular the manual formatting of "usage" and
> "or" is a bit ugly, considering that you'll get it for free with the
> parse_options() "usage" array.

I don't see how using parseopt would help here.  Maintaining the "usage"
and "or" strings manually is trivial.  The meaty part of the usage
string (e.g. "test [<n>...]") would not be generated, neither would the
repeated part ("test-tool mergesort").  OPT_CMDMODE would require
double dashes for no good reason.

PowerShell's param array allows specifying value types, positions and
group parameters into sets.  I think it's expressive enough to allow
declaring all three subcommands and their parameters, and then can
parse command lines and generate help text automatically.

Until parseopt gains similar capabilities I'd like to avoid that
dependency.

Ren=C3=A9
