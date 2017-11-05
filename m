Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7A920450
	for <e@80x24.org>; Sun,  5 Nov 2017 07:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdKEHTl (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 02:19:41 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47653 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750910AbdKEHTk (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2017 02:19:40 -0500
X-AuditID: 12074411-f95ff70000007f0a-33-59febb8be721
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id E6.EF.32522.B8BBEF95; Sun,  5 Nov 2017 02:19:39 -0500 (EST)
Received: from [192.168.69.190] (p4FC6E019.dip0.t-ipconnect.de [79.198.224.25])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id vA57Jbk6015262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 5 Nov 2017 02:19:38 -0500
Subject: Re: [PATCH 5/7] refs: tidy up and adjust visibility of the
 `ref_update` flags
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <da4974c47a7fd72e41513218e0c824d4d6377b8c.1509183413.git.mhagger@alum.mit.edu>
 <20171101081808.5962-1-martin.agren@gmail.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <6a0407b8-a612-5adb-6152-2e43bb2b05f0@alum.mit.edu>
Date:   Sun, 5 Nov 2017 08:19:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171101081808.5962-1-martin.agren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCKsWRmVeSWpSXmKPExsUixO6iqNu9+1+kwaGD+hZdV7qZLBp6rzBb
        /H3TxWhx5k0jowOLx85Zd9k9Ll5S9lj8wMvj8ya5AJYoLpuU1JzMstQifbsEroy/H4MK5vBW
        nOz/ztzA2MXVxcjJISFgInH8yRTGLkYuDiGBHUwSH55fZYVwzjFJLPuyjK2LkYNDWCBC4sNP
        aZAGEQEriWeTOphBbGaBXInTy6ezQNR3M0ocar3LBpJgE9CVWNTTzARi8wrYSxz5P4kVxGYR
        UJFouXWHEcQWBZr5vPk9K0SNoMTJmU9YQHZxClhL9J7WhpivLvFn3iWoXeISt57MZ4Kw5SWa
        t85mnsAoMAtJ9ywkLbOQtMxC0rKAkWUVo1xiTmmubm5iZk5xarJucXJiXl5qka6pXm5miV5q
        SukmRkiAC+5gnHFS7hCjAAejEg/vCY9/kUKsiWXFlbmHGCU5mJREea+8/BMpxJeUn1KZkVic
        EV9UmpNafIhRgoNZSYQ3aDFQOW9KYmVValE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaG
        g0NJgrd7F1CjYFFqempFWmZOCUKaiYMTZDgP0PAFIDW8xQWJucWZ6RD5U4y6HM9mvm5gFmLJ
        y89LlRLnVQEpEgApyijNg5sDS0yvGMWB3hLm3Q9SxQNManCTXgEtYQJaMpvjD8iSkkSElFQD
        4yy7OcEdnWc/71v8ucRw3/3Df58Yd8p9k9zca5gq5dec331jdZbYux95CjvWdTGy3gz/wWH/
        84CAa+zLx2H8/+afUb9ZL/aoRddyySTLtX+zP6dNtLpT+8B6c9d2N6NpFzaLFNcaReZIlq8N
        T1xgwsj5Z0GifMdcpya5qqv/E6fnfrPkVn6epMRSnJFoqMVcVJwIANe8vhsnAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/01/2017 09:18 AM, Martin Ågren wrote:
> On 28 October 2017 at 11:49, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> The constants used for `ref_update::flags` were rather disorganized:
> 
>> * The documentation wasn't very consistent and partly still referred
>>   to sha1s rather than oids.
> 
>> @@ -478,22 +462,23 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>>   *
>>   *     refname -- the name of the reference to be affected.
>>   *
>> - *     new_sha1 -- the SHA-1 that should be set to be the new value of
>> + *     new_oid -- the SHA-1 that should be set to be the new value of
>>   *         the reference. Some functions allow this parameter to be
>>   *         NULL, meaning that the reference is not changed, or
>> - *         null_sha1, meaning that the reference should be deleted. A
>> + *         null_oid, meaning that the reference should be deleted. A
>>   *         copy of this value is made in the transaction.
>>   *
>> - *     old_sha1 -- the SHA-1 value that the reference must have before
>> + *     old_oid -- the SHA-1 value that the reference must have before
> 
> You still refer to "SHA-1" twice in this hunk. Maybe squash this in, at
> least partially? This addresses all remaining "sha"/"SHA" in refs.h.
> [...]

Thanks for this.

I'll squash the changes that have to do with these flags into this
commit, and change the other docstrings as part of a separate commit
that also fixes up similar problems in other refs-related comments.

I also realized that `write_packed_entry()` still takes `unsigned char
*` arguments. I'll fix that, too, in yet another commit.

Thanks,
Michael

