Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1CBC4332F
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D327F60F13
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345966AbhIXUzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:55:36 -0400
Received: from mout.web.de ([212.227.17.11]:56747 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346002AbhIXUzf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
        s=dbaedf251592; t=1632516837;
        bh=pxLMeYwmW+uN6422bMpypdEUhkhoC5kcYjZ3Md0BrlM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=gB5gXJigCi3XOaTxjOqu8qgFy0tfXNFgsv45RtR+tvNAbrGCieLLp5Lt3w48gqoeX
         UzkdFW5NGT49RG4zM/tkAj2W2UHBRi36Sjp9lJNOXoZGFjDw+1X4zwsp95USwmGk69
         qS66a78UyH4c/sscaifTPSxuNWBlFfXfstwaIOHM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MIvbh-1mRwOi0XZB-002VMd; Fri, 24 Sep 2021 22:53:57 +0200
Subject: Re: [PATCH 1/3] show-ref: remove unused custom handling of -h
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
References: <20210924141920.ezfpyf4uutob2h5z@zenon.in.qult.net>
 <cover-0.3-00000000000-20210924T164820Z-avarab@gmail.com>
 <patch-1.3-c79a3907a27-20210924T164820Z-avarab@gmail.com>
 <xmqq8rzlu697.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b0b1c64d-9b53-a64f-73db-b8552c7b66a2@web.de>
Date:   Fri, 24 Sep 2021 22:53:56 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq8rzlu697.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4CEV7z8EzkYn3i2djxNXCMpVk0QnryaJ3uSacJpNl5WgrTu5WiD
 c0N3EsATV2EV9O+3ADwqdv3uXRhlwS77n+zvZDDLgwAaDY8rnG3syFrRl8q3uVJeARk8vYe
 iZvm6duzzsoAwI14jsH7MHtYAEYrmUpE4Fwm7bPWgKINd0CXgxwduuaDKDv9lpU37xDY1zJ
 d22hjSONrhJpyrgayldYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uFInjiMWFGY=:jFvPjl2tzTGMTHny+dxSUP
 DWyuVcX9i9aYg+MbA1Mm5hs7Vhbp6pDLarX0iNsrnckrkxY5GBPQQpTRRJarvsMzGMCqyFZmC
 kRQ9Zpt6JBcxNj+2DR19+1j1tc6vj2Yl3WvUm0Ny56fY4lweOyjeIKhaK0QjiIk1d02ebj9RO
 r773MM+dsqLaV/+Sqe9H/iBKHB/n46/2q/zXKhVGKUzI0wOhJ+9ewnbh7HJFQxpXXZmW00q7F
 eRpnwh0WfncY8Q+d46CwTKTQkfhG/6AUolsMxbP0NuE2gPieOl82pz6pBdr+ohHP53PLbKBBp
 Z2VjBJPBP/MAVc1+ehtrPeE0eXroHRLnmnAg4IpG6rPTJNyRyZJ8JeBWhk2sTazQt5BgBURzU
 hOmi67H8Cq3389s8R2GZ0Jy4DXMzYM7xoDXo2AfipjMON5lxqjoYTxzMy3mf7lpOvjG1ZhFW8
 TRngX5NFvPnhfAvOnMjE1h/UGWFvwPjgobUwmSpo+kPG17lNx4zj5Duvh1qgPs+Of5Jm8pzva
 qJ9LXTzjvKZhM0sbTdyF0FBe8tgX7vGjuXLm9So5gdhs4svgKP2MYcu6QJm76qAR9IEuIKNr+
 fBwYhfKkyR7C4PWPrJPVhPyEK/7Ojw1UX8SMYRwIL0BqUhK39ENWJLluPJXk89r2Br+A1b4t/
 KExqwLK1qLuQcn3b3O3jqTDPrg0UQTDYVw5QXJhdyBN4mTMlqm6B5vbXWMqSmqEX6jvarPUyB
 /z927BpguDGbQ8ZcuaC1UHDCuWgRFv0Ajm4AIwubSOLXE0kjbaTSwSNAwTnTTErHD+sRARYJX
 JsrRnegTr9PT9zXKlbeOYldCRsURomCIunAfxxJL0XlV15BYgjGE4hJprY2cTNYJY8y5zlwPM
 51u2fmK4m8+9DdYr+4HIkTI7tYKNaIpEZ8hqae+MGysSZO2yfO8H5jgOwvdji4ws9waHdlIuf
 hnRFVxbyBMDoXB7dwlQA+Ki0KM/mJdLZAteAj+InHi1abFTbRZ3S0SBha29yi0XRvvoTVe/D5
 sE5Cp804puu67ZYoeHHwcggMf6xpVBvB+rVZbKJGmcC/o4ocMaVXx86Q+yfM5Kj9JDqyrlzXZ
 szi/M+RGrEryRY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.09.21 um 21:24 schrieb Junio C Hamano:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Since b92891f9783 (parseopt: add PARSE_OPT_NO_INTERNAL_HELP,
>> 2009-03-08) parse_options() has handled "-h" unless told not to, so
>> when show-ref was migrated to parse_options() in
>> 69932bc6117 (show-ref: migrate to parse-options, 2009-06-20) the
>> custom "-h" handling that was retained did nothing.
>>
>> The option was then hidden in e62b3935056 (Show usage string for 'git
>> show-ref -h', 2009-11-09), but that OPT_BOOLEAN didn't do
>> anything. Let's just remove this dead code.
>>
>> Reported-by: Ignacy Gawedzki <ignacy.gawedzki@green-communications.fr>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
>> ---
>>  builtin/show-ref.c | 2 --
>>  1 file changed, 2 deletions(-)
>
> While this is a fine no-op, I am not sure this "fixes" complaint
> in Ignacy's report.  "git show-ref -h" would (and should) show the
> short-help, no?
>

It would, but -h is not a no-op without this patch.  The option is
equivalent to --heads as long as it's not the only argument.  E.g. it
has an effect in "git show-ref -h HEA." or "git show-ref -hh".

Ren=C3=A9
