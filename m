Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC47E1F461
	for <e@80x24.org>; Sun, 23 Jun 2019 16:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFWQBY (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 12:01:24 -0400
Received: from mout.web.de ([212.227.15.4]:39269 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfFWQBY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 12:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561305661;
        bh=e7mdgaCGAwBFWx6dtIPZmT8QLRkrM1g8Vn14Lr/TWeI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WQ9AOmXZI5i81hFiC+CvHQXlWJjtpLQeooxxqWyH8p/D2kpjrGlwbf+ehTqZNLcKA
         53ZPo3OgkNbxGeP4d+Vb1HiB1yFMfoNca63mwcCVdc/BqQLkSslou7ooL3iapgz5Id
         F3Co8LGxnVY+S6imB63cA9/4Jq0y2TxQxOEPIcvA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqDHE-1iIYXN2qO0-00dl6G; Sun, 23
 Jun 2019 18:01:01 +0200
Subject: Re: [PATCH 15/17] khash: rename oid helper functions
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20190620073952.GA1539@sigill.intra.peff.net>
 <20190620074141.GO3713@sigill.intra.peff.net>
 <xmqqwohgnocu.fsf@gitster-ct.c.googlers.com>
 <20190620182743.GC18704@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0e4ca2e6-5c75-20c3-def5-b2d3e31f9f08@web.de>
Date:   Sun, 23 Jun 2019 18:00:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190620182743.GC18704@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WMUjxoqPqro8mGaak69THj+sNMFbtUazAB9u05wda5O+SZI04Dq
 RFnH7ympqTi5xAO5evOSbtRYVVJxbOI/pPlrJElWZTkYsFjWcxLsGDZE8Dcq7iLPSFiqwh4
 2Zm4u+P+N1NjCu+n6WMXYCNomMkAkH+5Qz4zvcJNSkYKslOUd7RyBqc60TkOlNmz7zVhXoS
 fVJyTNLYT1bf7m1qq/nuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R2qIhcEwAfU=:uPf7E+zf5yKoYtdcipJXxL
 8A2SvJP9fJ4VqI2ioLIrC0K7Fqs/9nlczMg7uj2kGVMuuu049kkUiLIJ07xgsONvhRA4GgzHp
 LiucRCtwWkvQeCUVd3zr5pLbADOqFUCOPJdmmvCh1q5RGOSyK+GTc07i2BZmU0BCXhGyeNZqZ
 G0U5xradX7WAAr0XP5Rea4LVIVScwTWP/DSJAqU51QJ9CH3onXb7wGl64uqPCyzZ4kz2vVHGC
 htT9AGUN1dS0Os77Y4hQ9e16dkL+2EB1IMjWzBmAilIGjpaSu6sprXgd/kTSMQTHhL9kSsq+s
 5KtE5RbXc8OBkDDcWOZ2S+XNahtAIqRqCp18zOymbWr0eAaCzE8l1tpWtsax2gva9rKRrY4zV
 109YSsmWSltQFU7+EBjryg/1HZgjbCjw8uZMEznXqsVfmvyhPRHaQ2XbwemJvj9eqWTIENTVY
 VYXwQ/F2azlBqyh1kqq/63Zd6xDzLqE+MDshkyPN1+eiAb45ikeAybiNVsofMwOrIQln4Csd/
 tEl1i/wpcljotOfUSc4EhLGjLa7UdTpHEnZeLEmLoVytoQJnR8rvR7v0JJOk7GJ05svT3XZ/X
 bffN/jz/SNoarudD2kdRVucrGh6GbFknGykdzoI4I/SnF52oo67GPNIbgajPr4408xq6/8dpK
 O9l89up2Ry2f//6F/NJbmaR7YOA+CUuBn8W3mTD6PnkWIGDyQd+4LvPkLhosuUj+JeujWMOlW
 Ge1csxsbV7/K5jUwvcsSej1pgG0OUOCrco8DaCKHNt0zEfMvne0Fgn158DgXz6rtZj6c/Zoxh
 ySzTTTzaZcC7LJ4NcJiJv2q+o53V3gsnDJhMzEVSINOF4iSYk6nQYdY/FroPaq0z9XuN6tNY7
 QFqX+wFybFnggb00u1Fn3+Qv5M+Lr8mvtrrlWME8yXsPYBjy0D1ndzHPjE74zAny9j/x1GFjb
 hu2VfEfq9iVoULWL3fCs2GcXXpW60FYM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.06.19 um 20:27 schrieb Jeff King:
> On Thu, Jun 20, 2019 at 10:44:17AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> For use in object_id hash tables, we have oid_hash() and oid_equal().
>>> But these are confusingly similar to the existing oideq() and the
>>> oidhash() we plan to add to replace sha1hash().
>>>
>>> The big difference from those functions is that rather than accepting =
a
>>> const pointer to the "struct object_id", we take the arguments by valu=
e
>>> (which is a khash internal convention). So let's make that obvious by
>>> calling them oidhash_by_value() and oideq_by_value().
>>>
>>> Those names are fairly horrendous to type, but we rarely need to do so=
;
>>> they are passed to the khash implementation macro and then only used
>>> internally. Callers get to use the nice kh_put_oid_map(), etc.
>>
>> The pass-by-value interface feels a bit unforunate but hopefully
>> "static inline" would help us avoid actually copying the struct left
>> and right as we make calls to them X-<.
>
> Yeah, exactly. I think it should end up quite fast, though if anybody
> (Ren=C3=A9?) wants to try tweaking khash and timing it, be my guest.
>
> I do think if it took the more usual pass-by-const-pointer we'd probably
> still end up with the exact same code from an optimizing compiler, since
> all of the references and dereferences would cancel out once it was
> inlined.

I suspect it depends on the compiler and the exact details.  Here's a
simple experiment: https://godbolt.org/z/kuv4NE.  It has a comparison
function for call by value and one for call by reference as well as a
wrapper for each with the opposite interface.

An enlightened compiler would emit the same code for functions with the
same interface, but none of the current ones do in all cases.  Clang
and MSVC do emit the same code for the two call by value functions, so
there's hope.  And moving to call by reference might make matters worse.
GCC adds some 128-bit moves to both wrappers for some reason.

Perhaps it doesn't matter much anyway e.g. due to caching, especially
for the branch-free variants.  A definite answer would require
measurements.  Your cleanup would make the necessary surgery on khash.h
a bit easier by reducing the number of functions and definitions.

Ren=C3=A9
