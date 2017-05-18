Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FF2201A7
	for <e@80x24.org>; Thu, 18 May 2017 04:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753652AbdEREuT (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 00:50:19 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:62335 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751398AbdEREuS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 May 2017 00:50:18 -0400
X-AuditID: 12074413-0c9ff70000001dc3-83-591d280655e2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 79.9F.07619.6082D195; Thu, 18 May 2017 00:50:15 -0400 (EDT)
Received: from [192.168.69.190] (p5B104B7F.dip0.t-ipconnect.de [91.16.75.127])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4I4oATO021944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 18 May 2017 00:50:12 -0400
Subject: Re: [PATCH 04/23] prefix_ref_iterator: don't trim too much
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <eecc015af8d7ed71223b591b13847fdb56ee69f0.1495014840.git.mhagger@alum.mit.edu>
 <xmqq1srmvlt8.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <e9f987c6-3a02-4121-bd21-e7b78f28f7db@alum.mit.edu>
Date:   Thu, 18 May 2017 06:50:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq1srmvlt8.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42IRYndR1OXQkI00mD+byWLtsztMFl1Xupks
        GnqvMFssefia2aJ7yltGix8tPcwWmze3sziwe+ycdZfdY8GmUo+u9iNsHs969zB6XLyk7PF5
        k1wAWxSXTUpqTmZZapG+XQJXxoLN1xkL7vJWtExqYWpgbOTuYuTkkBAwkVj4rYUdxBYS2MEk
        Me2ndxcjF5B9jkni3N1JrF2MHBzCAs4Sk5ebgdSICKhJTGw7xAJRv5NR4myvF0g9s8ACJokd
        G5awgiTYBHQlFvU0M4HYvAL2ElPajjGBzGERUJWYO8UOJCwqECHxsHMXO0SJoMTJmU9YQEo4
        Bawlvi0RAQkzC+hJ7Lj+ixXClpfY/nYO8wRG/llIOmYhKZuFpGwBI/MqRrnEnNJc3dzEzJzi
        1GTd4uTEvLzUIl1zvdzMEr3UlNJNjJAAF97BuOuk3CFGAQ5GJR7eiACZSCHWxLLiytxDjJIc
        TEqivK7/gEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeK1kZCOFeFMSK6tSi/JhUtIcLErivGpL
        1P2EBNITS1KzU1MLUotgsjIcHEoSvFrqQI2CRanpqRVpmTklCGkmDk6Q4TxAwxeqgQwvLkjM
        Lc5Mh8ifYlSUEucVA0kIgCQySvPgemEJ6BWjONArwryXQap4gMkLrvsV0GAmoMHND6RBBpck
        IqSkGhg7WNzfWklPX522icX/9BkHr2VfVXrZnuqpCliJvVxSvHPSr6wPPU8S+P4uT8lj8xdf
        fU7auFr04zmd5+pq13y6dN9tZziy8Z5A/gqdu3q+TO9TQxaq628MWxCTMWvZr58H/jRe+fyo
        5d1s86mGth/Mpk/XLtrSVLuDz2PG7xXSt/p+zPDmsuFRYinOSDTUYi4qTgQATH0+GhsDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/18/2017 06:19 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> The `trim` parameter can be set independently of `prefix`. So if some
>> caller were to set `trim` to be greater than `strlen(prefix)`, we
>> could end up pointing the `refname` field of the iterator past the NUL
>> of the actual reference name string.
>>
>> That can't happen currently, because `trim` is always set either to
>> zero or to `strlen(prefix)`. But even the latter could lead to
>> confusion, if a refname is exactly equal to the prefix, because then
>> we would set the outgoing `refname` to the empty string.
>>
>> And we're about to decouple the `prefix` and `trim` arguments even
>> more, so let's be cautious here. Skip over any references whose names
>> are not longer than `trim`.
> 
> Should we be silently continuing, or should we use die("BUG") here
> instead, if the motivation is to be cautions?  Personally, I do not
> find this memchr() implementation too bad, especially when our
> objective is to play cautious, but strlen() based one is fine, too.

True; it would not make much sense to trim off more characters than a
prefix that you have selected for. This also implies that callers should
only check-and-trim a prefix that ends with an explicit "/". Otherwise,
say for example if a caller tries to check-and-trim the prefix
"refs/bisect" and the user has a reference named "refs/bisect", the
result could be the empty string.

I'll change this to die("BUG") and document the above.

> It's not like refname field would point at a run of non-NUL bytes at
> the end of the last-mapped page and taking strlen() would segfault,
> right?

No, refname should be a legit string.

Michael

