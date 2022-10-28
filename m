Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EEEC38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 17:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiJ1RQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 13:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJ1RQr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 13:16:47 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41B71DCCFD
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 10:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1666977394; bh=v3ajgm3Kh3RtgWbCg3dh3LRsCbiKpcV38abTRgWNoRs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=dxl1NiNxGEQZzVuF3Hm6xp+R8PFzqVLbbUkCLJW1yGi0tACjbJv8oIO2oqEIBvSNU
         1Xsnxr272h2yUutt9naTFUm777BRZR4S1x7x5fefzGf11nuANz2MBV+DslCvc9doT1
         WxTR8mRn2iCnuWgoJUbL2EatzQ5PnE5PokXnlbDfX98AdnXTx/SxkrDDgtU9h+6cUh
         jnNGusCSm5xdWoef8PACNitf9m/8j03fLtThiolHdRMSkdSupN+oKQ6QG/+CG22O9O
         gnyz/9nVf5/LG0wywivQHCKDXVcasFXgB0lJycFy0HZDm1iPFo3Qj6360ZlEyWKvCJ
         i6fFLVcDLEDpQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.191]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNfUF-1oRAWP0LfP-00P62q; Fri, 28
 Oct 2022 19:16:34 +0200
Message-ID: <b200477c-f856-f107-b897-63721c805093@web.de>
Date:   Fri, 28 Oct 2022 19:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 0/8] run-command: remove run_command_v_*()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <221028.86edusan0k.gmgdl@evledraar.gmail.com>
 <749f6adc-928a-0978-e3a1-2ede9f07def0@web.de>
 <221028.8635b87wo6.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221028.8635b87wo6.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1IarajdgD5Nev3q6mr89zXLN9OEWmaJGg7Q4BvAvFKd5iBWlMjt
 HLUYR5DlhKpqBFn/O6RcpKFdUpnbabatohjZtBsKrKcnaUanedjM1/cy6MqTQz84UA6ZYTS
 kIR4IY/n33dRBmkqmKrLL2bKX2/4mZaCMFg4EGwbf3EKSWboCWMhNFR9nn30LLCoj8Bg6LS
 +/EVyd8V5+59sIVcard+g==
UI-OutboundReport: notjunk:1;M01:P0:OzNluu3wrU4=;gocFdXH3xbo8OI31CcXI1iPbCty
 ef8hwAO0a7VcNm0kp/Mc+coUb5BH5WLuwtJRyeQVr/tv+FpthZNH9dF8w0pB77s8U1Yz09kAj
 IaIV1ZyA6I7yDCT0ffge5cEnnMX/4k9PJ2ylBDTW8cXWON1LGYx+5TvR16rrn2AXbOl+rgwie
 rAIvsFvu1gh57MgzPdcwGsuf9NO/AXMojsKXcDYrTCrTCr1U67dedVjLJnmyuOmqXqHBcZvCj
 1iCWxEE0GzopsF+idHfJb4cyAxjW19pRSxfR31VVACXFlo9+9bM0hCuaGb31XjAWqbwCFfQYl
 iqoL33oaS1yejTIRP/JvTBJhXf6RBG51nwou8of/LBH/Fbp5Z+4iuvUb1rtHTudc5RV8jxoA6
 vNU1u8Gak7jyYl4QGxUrlO/henPnfD8ABYXPdD33wsVqeSeCzJC+TdrQ1egjWuqv8ZX/qAqAb
 lZud50UObddp6prr0/5wBuLiNdSoC5WvQsorFGZVRDvtMQbFWfx85Kued+OQ1jspfvhfMUTCo
 hCMZWPJKUzYJ7sg5VUVl0t8O9Xd0/AHSf388Xvt64EkFT8Z7Tz4MjjKQmvReLnzq9qDXJeN2l
 wxBAMB3JxDXg/Bwly/SM7Kis+fVF146PH/E1H5XLIuuuCMKjKgDcm3wVKOifEx9HyV3fFArha
 LAtPJaC5sbXYoGNe1eSQHpe0y8Ybmx93++hIZ6kdiogwulMCkqA412sLX+fOQKQ2IPpHNd3Pq
 sKiP9hr9CakWueg3TD6SiFl3dXdRE9vQ/3gCIHbBx36RiF7h0A75u9WZ5fuauVUjPvgcQTdoF
 cEPMtLozyegQBj95wS5spu4sGVX8zYdU0LOQMW6gP++Gk1TsFLETxPStbN7gKzHOynFAJxzVr
 V7fi4PDl5phJU8oH4tAbwjV5DjgRV6+lbsFj0+fQ23DcD7r7k0RaWp0Rubh72h+bdQ4bC19kL
 3Y+aADmzuNtvq0flObVxLfWEHZw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.10.22 um 18:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Fri, Oct 28 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 27.10.22 um 23:46 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> - I wish C had a nicer syntax for not just declaring but squashing
>>>   together compile_time bracketed lists (think set operations). But th=
e
>>>   below "CHILD_PROCESS_INIT_LIST" is a pretty good poor man's version.
>>>
>>>   I see gcc/clang nicely give us safety rails for that with
>>>   "-Woverride-init", for this sort of "opts struct with internal stuff=
,
>>>   but also user options" I think it works out very nicely.
>>>
>>
>> That's a nice and simple macro.  I played with a gross variant =C3=A0 l=
a
>>
>>   #define CHILD_PROCESS_INIT_EX(...) { .args =3D STRVEC_INIT, __VA_ARGS=
__ }
>>
>> which would allow e.g.
>>
>>   struct child_process cmd =3D CHILD_PROCESS_INIT_EX(.git_cmd =3D 1);
>>
>> Yours is better,
>
> I actually think yours is better, anyway...
>
>> but they share the downside of not actually saving any lines of code..
>
> To me it's not about saving code, but that it's immediately obvious when
> reading the code that this set of options can be determined and set at
> function or scope entry.
>
> We tend to otherwise have creep where the decl and option init drifts
> apart over time, and with complex init's you might stare at it for 30s,
> before realizing that between the decl and fully init ing it often 50
> lines later nothing actually changed vis-a-vis the state, we could have
> just done it earlier.

Hmm, we could do that by collecting the flag setting parts at the top,
without the need for a new macro.  Or at the bottom, before the
run_command() call.

> I think that's worth it in general, whether it's worth the churn in this
> case...
>
>>> - We have quite a few callers that want "on error, die", so maybe we
>>>   should have something like that "on_error" sooner than later.
>>
>> We could add a die_on_error bit for that, or start_command_or_die() and
>> run_command_or_die() variants (there I go again, multiplying APIs..).
>> They could report the failed command, which a caller can't do because
>> the internal strvec is already cleared once it learns of the failure.
>
> *nod*

Wait a second: Does it even make sense to mention the command in a die()
message after start_command() failed?  Unless .silent_exec_failure is
set, start_command() already reports it.  E.g. archive-tar.c has:

	if (start_command(&filter) < 0)
		die_errno(_("unable to start '%s' filter"), cmd.buf);

... and the result looks like this upon failure:

   $ git -c tar.tgz.command=3Dnonsense archive --format=3Dtgz HEAD
   error: cannot run nonsense: No such file or directory
   fatal: unable to start 'nonsense' filter: No such file or directory

The second message is mostly redundant, but it mentions that the failed
command was a filter.  Probably .silent_exec_failure should be set here,
then the die() message is no longer redundant.  This requires args[0] to
be stored outside of struct child_process, though, which is already done
here, but may be a bit tedious in other cases.

So for start_command(), would it be a generally useful to support a
scenario where upon failure

- the program terminates,
- but before that prints a single message,
- which includes the command that could not be started
- and some kind of hint why we tried to start it?

For run_command() we'd need to distinguish between not being able to
run the command and getting an error code from it after a successful
start.

Ren=C3=A9
