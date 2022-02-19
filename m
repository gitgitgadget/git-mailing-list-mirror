Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E276CC433EF
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 15:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241710AbiBSPMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 10:12:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiBSPL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 10:11:59 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B125EB1
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 07:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1645283476;
        bh=aRVA3tHgpbKz7mCtm4brmnTJATg8MTaQRRaOAvFHOT4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=meMhhLEhVBsKblaHoDhJLcOblSVmZl4npk6ATx8NnQLX/m1R/boAXpUi/hCHeQyAF
         V1WnGI9v1CQoyldimDCW8VXexlkB/7ex7rP4pTunNkqajWZCRtF6Ca0NQEs10I4sSS
         AmVuiFjPjxiOOrThVxcy6kwAqpbFx5TYSfeG0oVo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.16.203]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MW9vU-1nkIsI0d7i-00XfuB; Sat, 19
 Feb 2022 16:11:16 +0100
Message-ID: <c052b97e-e788-f63a-15c5-b1fbb6a480e8@web.de>
Date:   Sat, 19 Feb 2022 16:11:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: master doesn't compile on xlc 21.01 anymore (old AIX compiler)
 (was: [PATCH v7 14/16] reftable: make reftable_record a tagged union)
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Neeraj Singh <nksingh85@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.1152.v6.git.git.1642691534.gitgitgadget@gmail.com>
 <pull.1152.v7.git.git.1643051624.gitgitgadget@gmail.com>
 <047bbb75fcbb67c41d307bf5fa44587a76cc0777.1643051624.git.gitgitgadget@gmail.com>
 <220124.86ilu8hqag.gmgdl@evledraar.gmail.com>
 <CAFQ2z_M7s9Y_FH5x+qJxyZO0iHq+b_mf8=-dKcmADzFEoGLJUg@mail.gmail.com>
 <220124.86a6fkhk8s.gmgdl@evledraar.gmail.com>
 <220219.86wnhrc8us.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220219.86wnhrc8us.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:boRe6yS8FtR42a3jlF3MiqMf/x7jF+qnLXtyN4wohlYGVeulmDy
 NtnIOP75fSGbh37j9I6pf7LzDclKbU5+ASpXCCTZYOTJ11uZg5LRc8kf30tPF3JcJDL2Zej
 ChaSRuZdcUh+4QAJfFOYFLiIKgamX4PXbcB9a7pPI1oQNY4fbasV3vSP16C59yFEiCQw/vJ
 03IF//QlQl3elL7y2LiXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NZcnC1Vmoac=:1+HL8Klr496U+NS6kOwqs9
 Zk+Z0dfTGNibjzaTXm+wvjqp87JjKG0orAeW5WPWk3iACbO2Kt8GaZZ1wJGSeExpz3ujG3ab1
 9ZFQKa2YsD7c7d/bsV4ptlTHzo9wm8WPYaj8s8B2fbFlR48mcpMZP1AMtHNW6/ko6BiBdAX/o
 ahsP8eX9Snp2uJAig4gVX92WMZ6dZb73w60G9z40/pB0OztJDhESN+HXNvuEvRfW4O/GtR5j4
 F7Zh3ec3X4cwRmbH4gFinG8caKYkbzQbaMnXpMbau5CL38viE5KPMqTEo8KQLESDL68utA8xQ
 H+ixRNYi2GIfSe7uDF5UF6CwryeAd+b7iRM+cB41pJq5dKx0A7VZhQNAyfE+RdS2bLQEG0BY/
 S22Q/Loz6r5iBRXPnsr2Qoy6ngU33YrSzQHmnI3e0TIIZfqp7LQ92uUYyEVLkMBDbCiMFaURL
 xwiop4Hv+8n/z5h3T+P7Xn+C0HFqflEvC9QClxUXnoihcjbKZ8VgMBDrS1PBf5S1XYH8NO9pa
 OaOJb8JVyZt/kEeuoiDf+R+z7xFb0c3cI4YehXuvqEbiFoFoCS8P0KE+wV7zba+pR/A30kjmh
 G4U37MUOWby316biekPGI5SLZUtUuV5xWU9y8F75sw0a1+rbm5LOwf5DqsZqlaKwNalF4ZChj
 P8r6ntXaEAna0Lih2uqOdPwHJ9OaWvA0UWPDJZkM43mIYLhmmA+BcvTA9NEQFvyvQE93liK9x
 4Vb7rFZppxc4kZq/1irCVnA6jV1EybVELzIr4f/Z61wmlFSggycrhG8zE3jwmTgcgw+LXgJW7
 xPDSQiN6NDRRkSfyGn49VIM0pN8H+nLTIeEP2ptkvqTn+C/wGNmTu/VgsJQP9v0yvYvPm9CRu
 jxcqgMIX1XoZysY7ljKHUjWEKaRNdQPEdPx7s8nFYev17Zn8ztMe3NNTk/mN/XUjrlZzFqfj7
 zZFViSH6jOoF43Ug/hjdawfxZAmPPHp4k9jXKhgdzJ69b9t+fBAhLjCs6ljP4HiK32KFD8s/n
 tvtx8OvrNhz2o8VaQsL1eECLQv4nSCV1skBinxBlwbliOuYCDw90wf11PCxKKuxn4g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.02.22 um 13:54 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Jan 24 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Mon, Jan 24 2022, Han-Wen Nienhuys wrote:
>>
>>> On Mon, Jan 24, 2022 at 8:44 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>>> <avarab@gmail.com> wrote:
>>>
>>>> I didn't test the v6 on xlc on AIX 7.1, but found that it refuses to
>>>> compile this code (but the one on AIX 7.2 is OK with it):
>>>>
>>>>     "reftable/generic.c", line 135.26: 1506-196 (S) Initialization be=
tween types "char*" and "struct reftable_ref_record" is not allowed.
>>>>     "reftable/generic.c", line 147.26: 1506-196 (S) Initialization be=
tween types "char*" and "struct reftable_log_record" is not allowed.
>>>>     "reftable/writer.c", line 261.26: 1506-196 (S) Initialization bet=
ween types "char*" and "struct reftable_ref_record" is not allowed.
>>>>     "reftable/writer.c", line 312.26: 1506-196 (S) Initialization bet=
ween types "char*" and "struct reftable_log_record" is not allowed.
>>>>     "reftable/writer.c", line 406.45: 1506-196 (S) Initialization bet=
ween types "unsigned long long" and "struct reftable_index_record" is not =
allowed.
>>>>
>>>
>>>> I.e. you're dereferencing a struct type here to get at its first memb=
er,
>>>
>>> No, that's not what I'm doing.
>>>
>>>>> +   struct reftable_record rec =3D {
>>>>> +             .type =3D BLOCK_TYPE_REF,
>>>>> +             .u.ref =3D *ref,
>>>>> +     };
>>>
>>> reftable_record is tagged union, and u.ref is a reftable_ref_record. I
>>> intend to shallow-copying the parameter (a reftable_record called
>>> 'ref') into 'rec.u.ref' , precisely as it is written.
>>>
>>> Does this patch pass the unittests?
>>
>> No, sorry about that. It fails. I didn't have time to run them earlier
>> (and it takes a while on that platform).
>>
>> I don't know how to work around it then...
>
> Just a reminder that now with this landed on master we've hard broken
> compilation on that version of xlc:
>
>     avar@gcc111:[/home/avar]xlc -qversion
>     IBM XL C/C++ for AIX, V12.1 (5765-J02, 5725-C72)
>     Version: 12.01.0000.0000
>
> The error is:
>
>     "reftable/generic.c", line 133.26: 1506-196 (S) Initialization betwe=
en types "char*" and "struct reftable_ref_record" is not allowed.
>     "reftable/generic.c", line 145.26: 1506-196 (S) Initialization betwe=
en types "char*" and "struct reftable_log_record" is not allowed.
>
> Is there really no workaround we can think of for this?

The code is hard to read for me in general due to its many types and
function dispatch tables, but this compiler seems to have an even harder
time.  Where does it even get that char pointer type from?

Can it compile this?

	struct reftable_record rec =3D {
		.type =3D BLOCK_TYPE_REF,
		.u =3D {
			.ref =3D *ref
		},
	};

If it can't, what about this?

	struct reftable_record rec =3D {
		.type =3D BLOCK_TYPE_REF,
	};
	rec.u.ref =3D *ref;

Ren=C3=A9
