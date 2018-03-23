Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A63C11F404
	for <e@80x24.org>; Fri, 23 Mar 2018 20:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeCWULs (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 16:11:48 -0400
Received: from mout.web.de ([212.227.15.3]:56533 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751827AbeCWULq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 16:11:46 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Md4V8-1fHXqf2gqI-00IEAT; Fri, 23
 Mar 2018 21:11:27 +0100
Subject: Re: [PATCH v2] json_writer: new routines to create data in JSON
 format
To:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180321192827.44330-1-git@jeffhostetler.com>
 <20180321192827.44330-2-git@jeffhostetler.com>
 <524c47a6-7c9f-5519-250a-4722081a0f32@web.de>
 <14bbf223-a4d1-3c11-cd2e-dff044e01fef@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <306104ac-37ac-8198-1988-03efa818cde3@web.de>
Date:   Fri, 23 Mar 2018 21:11:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <14bbf223-a4d1-3c11-cd2e-dff044e01fef@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:SxFEAesdm6RzQ4UtV+pa8fDugfTOGludD6TgAoswE8KalOvhN5U
 DXBeco7VBf5KoZlDbieE6p7yOUQx7AHg5mGp6tUQcrLo0RaYkQFT7HiB9P+7M2UK6QZoPvO
 uRt3BReM/Dli3bYbOiFf4ECBKmniMt60b3p1G2HBc8ybuJ2Xo+TPDyuOjwe21+Qe4b/ObAS
 iyqaYibl7Pkl+TQlgJQmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QSDWMtTNN2g=:KTMD8GUd09VVGziHz7Gijq
 h2dc+zM2UkX9RaE9a47y1H7p8EvZS2ZDIyKDpuS0Ij7PJrOwkjpYEWPqHKs12tUKYu4N6YhVk
 oQEhGHrN6K079rfCEFap4fu+8edC+g1gqe75DK/mX6yT43xouLP9cqGQmILX01Qe4/M/vf/bB
 FV+uqHNpBp/SqwsoxiOg77uvOEnAn3aA7Xq6zqK+ivs3ssqKL5NG5WeUatj7B3jhDXCk2vnzF
 BzQ0+kJ7py2FrtGYI/JU3Nbsd6jUQgvzG8hCzDsDArx36ga33qgXiOZB8ijKBgouAkqxABbG1
 3g9HsoPHVh1OzmT/TzSp8Cqs2JMccLZsZLxlu0SIiM6v4jMopOdGAjqLZ0Mv6ZcWkYxYx3Q/j
 mnr9uXJmjvctHgqc7VRxKH+VhXTsNruiTGh5S1ivxIKmx1E+ujM5S+HlA95NoPdozwdcbOWz+
 vjKZs9nVUkfo8CqTC9Ta1rzZFudvkOjNPF0yZrublC13ckFTDXexzpPQr5y22wB1IYpjjSFhY
 anu30mnvN0n6RXucRWPKFDhrq2lEgnqhFpUmcwc5WVS7Z5VPA+5Gi2k5r5tOq93HoH4JxeM0+
 oedHz7DGHm3fMUZgPorNe5KBmMKU3dzMjGMDJk0SEi14XF8O5POa5Du2k1A/K+XfAEwu6Jsin
 JVoESlSs6VvJPMok9UBOjqvYFl8Q1cr3hPyEk6AxMccAN2KKh25HpMcJBS7qFg9IM6No86eND
 yOlLO25FZ9PIUjFnB9nL3vTrj+pvR7mNAXqwW7HTbpIVKEpocXA4iSXuJeFfQSCv7fdjr/jmL
 euL/6DUnvJIAkVzlIHIMt8ucYJn778bpn7y6oHAtST4OT0yvZ8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 23.03.2018 um 20:55 schrieb Jeff Hostetler:
>>> +struct json_writer_level
>>> +{
>>> +    unsigned level_is_array : 1;
>>> +    unsigned level_is_empty : 1;
>>> +};
>>> +
>>> +struct json_writer
>>> +{
>>> +    struct json_writer_level *levels;
>>> +    int nr, alloc;
>>> +    struct strbuf json;
>>> +};
>>
>> A simpler and probably more compact representation of is_array would
>> be a strbuf with one char per level, e.g. '[' for an array and '{'
>> for an object (or ']' and '}').
>>
>> I don't understand the need to track emptiness per level.  Only the
>> top level array/object can ever be empty, can it?
> 
> My expectation was that any sub-object or sub-array could be empty.
> That is, this should be valid (and the JSON parser in Python allows):
> 
>      {"a":{}, "b":[], "c":[[]], "d":[{}]}

Sure, but the emptiness of finished arrays and objects doesn't matter
for the purposes of error checking, comma setting or closing.  At most
one of them is empty *and* unclosed while writing the overall JSON
object -- the last one opened:

	{
	{"a":{
	{"a":{}, "b":[
	{"a":{}, "b":[], "c":[
	{"a":{}, "b":[], "c":[[
	{"a":{}, "b":[], "c":[[]], "d":[
	{"a":{}, "b":[], "c":[[]], "d":[{

Any of the earlier written arrays/objects are either closed or contain
at least a half-done sub-array/object, which makes them non-empty.

René
