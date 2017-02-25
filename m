Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5342201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 21:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbdBYVkA (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 16:40:00 -0500
Received: from mout.web.de ([212.227.15.4]:61677 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752013AbdBYVj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 16:39:59 -0500
Received: from [192.168.178.36] ([79.237.49.102]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8iei-1ccChE48wW-00CDp7; Sat, 25
 Feb 2017 22:39:33 +0100
Subject: Re: [PATCH 2/2] commit: don't check for space twice when looking for
 header
To:     Jeff King <peff@peff.net>
References: <23989e76-24ba-90a4-91a9-9f66bfccb7c9@web.de>
 <b1d5c882-38b8-dd2d-2e5f-aafb8dfada81@web.de>
 <20170225201522.uan52fwey6zjosym@sigill.intra.peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6462e74c-1ee7-7ed0-0695-9889df803943@web.de>
Date:   Sat, 25 Feb 2017 22:39:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170225201522.uan52fwey6zjosym@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:YmLvPwWyXckueEdR7skmdFtBMZTMLtFPO68cb373N7pdr/wRcA5
 ncTzTOTJdDqit64QJ05TzR5DedLP4PyiyLXu/i4QS9XL5Rpyr4XTJ+iEniYKXp+vp078ggg
 w1kyZu9YX+GjhAevgURP3+G9fVTygfTtIDlpHYN3G72flLP49N8v4X+TSy8u8AnLntXfQ3h
 AeV6Omy/L4BZ5keCLQgtA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fRiY0fSuIfk=:tFwXxvQhHIAxShRAnLvvaa
 xz+qe1c1ixwLZoAmVITpjzcASK9SC9y36MAgpCSrcD5GHGBEfSJ0DxuY8Uj3cjuUgOgz1n7mc
 Prli70qkTOZg2Rdhtq8Amhk+MZV6smAWPkoCPG1S2b1eRUdMijMmAlekNcgImRjUlmja7Q9nm
 4bTKxnho8bN5mV1BxNKNDxIDZMsabVWCjqeF5OkHG1KmgA+ds4h4uH+SmkLxJoBYGwrkCadl7
 2Hjix5XUhOUG3gyq54Mzb5wZA5B3nhAfNCeaRcuydJjwcNibuXTln4E3Sd2bowwueNACQ9HNU
 yfh0jf8ckByQ3nouOnAPQez6YTl0tPzXB/rKTlwszSsyT4y2iyC5A4SKUR3jWy23ScmEpAkM1
 k25rhE544+9KAqHeXoBk6YuCoy2oyT7TpOdnGTjVaJlemcGTnirLBoiYVIp8nArzhtmee95Ai
 S9FpIozqmbEpAYtHvbroj3S1/qmdCWuGn/QbXsEed2iiU6qyYuhI3iw8/PtgC+yc9UI7Ye3jg
 8b6f9IAVhXV+D37kXqkrSYmn6PgFx5afs4k4A331DRGTXIWi+erV7RXr8hDr9AZ2LNRyQi0ab
 FYFuDwCGJuT/z/tEn48LlLv7Uk2hIDeDo6SDfS5isg2jEawG4E92pcEgosv4lfqoMMnQmxvKA
 9dK9umgggf+LwS2jXSepEvP9qqiRcFZYGTuSxr9CwpHzgH+/VYihnB/NL47/oQVcgtatooSfx
 EwvrawmI6G8Lokk3gAincVvoLouWo3z03qh3ttKTxUGkZjNSZQcc4wYB3Lev2mXt7789rUoNM
 UPcqOxC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.02.2017 um 21:15 schrieb Jeff King:
> On Sat, Feb 25, 2017 at 08:27:40PM +0100, René Scharfe wrote:
>
>> Both standard_header_field() and excluded_header_field() check if
>> there's a space after the buffer that's handed to them.  We already
>> check in the caller if that space is present.  Don't bother calling
>> the functions if it's missing, as they are guaranteed to return 0 in
>> that case, and remove the now redundant checks from them.
>
> Makes sense, and I couldn't spot any errors in your logic or in the
> code.

Thanks for checking!

>>  static inline int standard_header_field(const char *field, size_t len)
>>  {
>> -	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
>> -		(len == 6 && !memcmp(field, "parent ", 7)) ||
>> -		(len == 6 && !memcmp(field, "author ", 7)) ||
>> -		(len == 9 && !memcmp(field, "committer ", 10)) ||
>> -		(len == 8 && !memcmp(field, "encoding ", 9)));
>> +	return ((len == 4 && !memcmp(field, "tree", 4)) ||
>> +		(len == 6 && !memcmp(field, "parent", 6)) ||
>> +		(len == 6 && !memcmp(field, "author", 6)) ||
>> +		(len == 9 && !memcmp(field, "committer", 9)) ||
>> +		(len == 8 && !memcmp(field, "encoding", 8)));
>
> Unrelated, but this could probably be spelled with a macro and strlen()
> to avoid the magic numbers. It would probably be measurably slower for a
> compiler which doesn't pre-compute strlen() on a string literal, though.

sizeof(string_constant) - 1 might be a better choice here than strlen().

René
