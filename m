Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180F220282
	for <e@80x24.org>; Fri, 23 Jun 2017 16:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754489AbdFWQXW (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 12:23:22 -0400
Received: from mout.web.de ([212.227.15.3]:53306 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754463AbdFWQXV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 12:23:21 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkhQi-1dwgFh3bng-00aRwp; Fri, 23
 Jun 2017 18:23:13 +0200
Subject: Re: [PATCH] strbuf: change an always NULL/"" strbuf_addftime() param
 to bool
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20170623144603.11774-1-avarab@gmail.com>
 <20170623145102.h7rt6zaqajfzuhsk@sigill.intra.peff.net>
 <8760fmka8t.fsf@gmail.com>
 <20170623152344.gdk4haizpziwryrd@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2e0773c3-b742-a211-d9cb-64da58cf9e0d@web.de>
Date:   Fri, 23 Jun 2017 18:23:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20170623152344.gdk4haizpziwryrd@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:BOK3s7PzThhIKRJWi/zW15W5s9TAMazvt9xLCOZ9rB4ZiwEo59I
 pJMSF+s9M50rbFEuRQBZ//yHVi+AGmmmqijuD1cvWIR74RQ5UOf5V+b+7OHkJ1gnRn/Tw1S
 IhmNbGvE+da9sNnSIsid8SbWrBEqLZo6AIqAeQT3cWJ4YSDvFb6CwTYWcSbJJBhdSb3ewfz
 339hNiklFEJvRj1FblUzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZSN5LpMYons=:u9KiOcINhyxJiRxUNN++BK
 DO2a4AbJodrvQr2iBKttFQjZVIhZyHqDGoWeHEYHgfRYPQNu3FyvBYcALbTecEE8mwVLzAexn
 jDXrJmrkEQTPJhZ4sS41dFDE08Kgpau7+eH7ia8DRmG9O5ZimIruFPxkTm24sdcUKjm+htNgZ
 D0RKsGF7Dsysc8vDU8KZhMAvOd2HftWH9RYmsZDkwINjUzcdNSbDM5ojtotnYqSpAvZcqdziO
 WWJRRI2rAfUt8q0CePYD5VXAdUvJ7uGlYnubOe+fRpCGcGCCcuHv1xR7IP9lk41wXoLKo3RQh
 UYoTKT3U3pDc1RGasM54p+boqDQlQVTLcrUXDUK4ZghA1sVnKkTP4k6W/MZE2EtmZQfhujcOd
 g9K59XRdrqTy8sBxvVSP3XIaIuX9zvAHWcY5F+99mHFgEJjU2tr3oJagaqL253V36WjHpqHyv
 3FlqfRpuJ1YblTHqgpBSNJLoxdq3Jt0F+6GlLUkIFwT/zsoQSofK7/74ELx96mnNOksvjotFA
 HsuUBN4fmU7j6rSERXN/BZ8CNj7Sa3MAGhPl2YJ8BS9Z78/oVzGPew82dbKwhtIeax1OR0RfW
 6j4ItOtOVczVRJcJQdP9Wr0KxC4cmgG39crqOdU6S2KuPo1G7RPqoCqtgsBMoLcqEecFUeCrL
 uK3g9c/xJAlNAO+WZ/6X7xrv1T2M8OVp2Zoc+iq7WfsHkHDIgXnYGm95Ys2XOmQXwi4njPoB+
 ArIBiMieug/yBbkU+ydPNPmKDLJRCEEl0pd0PY3pZDy4LLut/K8XHCwbOwl0f0wKEUUdCqD5b
 e5Eipna
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.06.2017 um 17:23 schrieb Jeff King:
> On Fri, Jun 23, 2017 at 05:13:38PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>>> The idea was that eventually the caller might be able to come up with a
>>> TZ that is not blank, but is also not what strftime("%Z") would produce.
>>> Conceivably that could be done if Git commits carried the "%Z"
>>> information (not likely), or if we used a reverse-lookup table (also not
>>> likely).
>>>
>>> This closes the door on that.  Since we don't have immediate plans to go
>>> that route, I'm OK with this patch. It would be easy enough to re-open
>>> the door if we change our minds later.
>>
>> Closes the door on doing that via passing the char * of the prepared
>> custom tz_name to strbuf_addftime().
>>
>> I have a WIP patch (which may not make it on-list, depending) playing
>> with the idea I proposed in
>> CACBZZX5OQc45fUyDVayE89rkT=+8m5S4efSXCAbCy7Upme5zLA@mail.gmail.com which
>> just inserts the custom TZ name based on the offset inside that `if
>> (omit_strftime_tz_name)` branch.
> 
> OK. I'd assumed that would all happen outside of strbuf_addftime(). But
> if it happens inside, then I agree a flag is better.

Oh, so the interface that was meant to allow better time zone names
without having to make strbuf_addftime() even bigger than it already is
turns out to be too ugly for its purpose?  I'm sorry. :(

René
