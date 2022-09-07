Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069CAC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 11:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIGLUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 07:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIGLUD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 07:20:03 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C8B4B0D3
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 04:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1662549594;
        bh=WF7n9uCF8u35C2PgdseZnmcUwgAa7ojJyR2cC5AK1rs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=fg2giBwcSRAykMGVMgf+LlppRHnKy7OoB8nkztPBQUcY6Kgl47g01Mjb1thZVedXH
         LJF5wF+363gygDwT2qFI+RFdS8adFZ38IRDVmteVo5C7Iex1QwMA+nqlOAHZn9w0md
         YUsignAjW3cT60i4gIx58cYe06KNJy7RCVT45m1I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.158.123]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk4e-1ouWQa3LsQ-00TM6C; Wed, 07
 Sep 2022 13:19:54 +0200
Message-ID: <90d7af20-0563-3e09-f7dc-f69f8d473928@web.de>
Date:   Wed, 7 Sep 2022 13:19:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH 2/2] diff-no-index: release prefixed filenames
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
 <181c029b-8b36-4b04-30f9-97a3f252bfbc@web.de> <xmqq8rmx1saz.fsf@gitster.g>
 <df5f8305-79d5-2c12-bdf0-961428c0bdd1@web.de>
 <n575rrn9-5p4o-r40o-snsq-197p242q10p5@tzk.qr>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <n575rrn9-5p4o-r40o-snsq-197p242q10p5@tzk.qr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LvKSOSZuNMjWT9DBB47TPM4G4zhedsUMvVKeWzu1hCkJFqh7ttz
 6k3ko0gBQd+DoUIAErBh5gskHsXJXQDNhs7n0NigfRbf/qEaFj+F9/bjdzLh+UTuBRaWmnp
 pqQ+Kv4wwszfNdApA88yC4S4NRRkyYUK4oMyghXpusnOYtiW4gHqfM+foJDUaD74ArrJjtr
 4dxZmTcXVgNPvlaqLC2ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dZEgivvp7nc=:6KZZNCUdLlYeybx84C4uG/
 wGqq2aygBkYU//1ByeZ/lF/xivwmcUg1uH/G2KL3HQ9o6HLqIJ7g5i04O9sgWTBKTGE9ZdRzm
 JFJph2eMeshTfzTkG1NqeUyC5izmUJxQOnvroDvZxa33i5E74WJa+zdzpm56UV6uBp7KRwzPQ
 qDqqLTAE95wIElWaUUEdCLjcNkHk5sU70xdqXcFb3o3La0z7/p00WNgimpSA4fr4YfKhb1gkZ
 X2iS7kUg5Rct3jSvNIr/6vLGTtmyE1m3Dy9FTmNlfasbJTMSsDgTg0LNSS0OdoxpRJ8EogUrG
 v5zfZsuHulzAftK7wqnr/4G4Wtq/+vN0g8ZF6s3rR3DfQpI5bCMaSjTHlEEunmO3JAyComO7Y
 Ry/STppOUmx0YaR/SGn78QszV64AST7HDdt1bT5DhmQevt0tJr84PtEVNa9tiAkC2G+KqCmmi
 cJIjpeLbfHfBSKTpFg7Z2IwvI0xwFM8xzR9E6JLPDc/046sP8r4/hv/4oBFw5GbZNwkjtpM80
 /zFQFG/LFRM3nXCzM7wPHlyNBlBCEAfS9H4cBVQCamnzM+vGKuUFFCRAYOLJvRzHDqAaK5sMF
 mldzvFCtRFT/OReLKZCOyLUGc6h7TzF28l+GDkZD4slmOcDkGWtbhYrsw2qxDoBVDsl05V8uN
 nmZZ6mHVCCGiXhy6v8kFLlIXCZoQfLTJTqrZwBjYgJjUHSqvvWG+C1+fYsu27ZTXG52FyAYR8
 qtGvWdyfeYg8jJl1olHcEF3aUIkA+cZjOqVMkB8DzWxY1sCEJV3ghl905rSLmBjuDNj8kOSLZ
 5WYkhlgdqmTKTVN4gRTWvZnFI6HYpJJ8hUW+/WjaeDzQ96tlh3gh3Lp2YOggvZot1WG71U4re
 uKPRfUqUIUBceIlU5OyDBQeTe8iifHHjnUIoWCKk3BKaoOVuePTjUhCKH/NI2zTljdnXIcVQN
 r/vEFfuZcZOOfIL65Qv7jHBn0NRWtoCsb4pMbGcrkz0dITH1tpni8OUxxv/58Gpunuh96VTt0
 xp6/kVM6YjderTI5BdEXBURdNO5tCz90GizxmmqQ5hITrvNnTeIKrOM4YZDGnBS3jPxPcov7X
 Wz+kr8PEtc/uKJPRa2SJ3fENG4wACQqsN90IjHT9Kq/eqYEX5L81u8+cfsU4KK9+1I9Y/G3gF
 18byU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.09.22 um 12:03 schrieb Johannes Schindelin:
> Hi Ren=C3=A9,
>
> On Tue, 6 Sep 2022, Ren=C3=A9 Scharfe wrote:
>
>> diff --git a/diff-no-index.c b/diff-no-index.c
>> index a3683d8a04..35809f26d7 100644
>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -245,6 +245,7 @@ int diff_no_index(struct rev_info *revs,
>>  	int i, no_index;
>>  	int ret =3D 1;
>>  	const char *paths[2];
>> +	char *to_free[2] =3D { 0 };
>>  	struct strbuf replacement =3D STRBUF_INIT;
>>  	const char *prefix =3D revs->prefix;
>>  	struct option no_index_options[] =3D {
>> @@ -274,7 +275,7 @@ int diff_no_index(struct rev_info *revs,
>>  			 */
>>  			p =3D file_from_standard_input;
>>  		else if (prefix)
>> -			p =3D prefix_filename(prefix, p);
>> +			p =3D to_free[i] =3D prefix_filename(prefix, p);
>>  		paths[i] =3D p;
>>  	}
>>
>> @@ -308,6 +309,8 @@ int diff_no_index(struct rev_info *revs,
>>  	ret =3D diff_result_code(&revs->diffopt, 0);
>>
>>  out:
>> +	for (i =3D 0; i < 2; i++)
>> +		free(to_free[i]);
>
> Heh. That's long-hand for
>
> 	free(to_free[0]);
> 	free(to_free[1]);

Had that before, but it's repetitive and more importantly this loop
matches the first one.

> If you do want to have that loop, please replace the hard-coded 2 by
> `ARRAY_SIZE(to_free)`.

The two is hard-coded in other places explicitly as well and implied in
fixup_paths().  The root cause is not any array size but the design
decision to require exactly two things to compare.  A reader would need
to know that.  We could sure use ARRAY_SIZE(paths) in the declaration
of to_free and ARRAY_SIZE(to_free) in the loop to at least not add more
instances of that magic number and make the code understandable without
seeing the bigger picture.

> Otherwise, both patches look fine to me.
>
> Thanks!
> Dscho
>
>>  	strbuf_release(&replacement);
>>  	return ret;
>>  }
>> --
>> 2.37.2
>>
