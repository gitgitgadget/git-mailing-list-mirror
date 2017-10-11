Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F255B20372
	for <e@80x24.org>; Wed, 11 Oct 2017 08:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932658AbdJKIgq (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 04:36:46 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:54288 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932304AbdJKIgn (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Oct 2017 04:36:43 -0400
X-AuditID: 12074411-f95ff70000007f0a-d8-59ddd81a4e27
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id B1.1B.32522.A18DDD95; Wed, 11 Oct 2017 04:36:42 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCD9E.dip0.t-ipconnect.de [87.188.205.158])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9B8aetv007004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 11 Oct 2017 04:36:41 -0400
Subject: Re: [PATCH v2 24/24] refs/files-backend: convert static functions to
 object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-25-sandals@crustytoothpaste.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <d6e20486-af67-412f-4140-6ac38b8be7c6@alum.mit.edu>
Date:   Wed, 11 Oct 2017 10:36:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171009011132.675341-25-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqCt1426kwf8eWYvn60+wW3Rd6Way
        +NHSw2zRNvMHk8Xmze0sDqwey2/+ZfJYsKnU41nvHkaPz5vkAliiuGxSUnMyy1KL9O0SuDIa
        Z79jL7jNXnH3XSt7A+NGti5GTg4JAROJazO6WboYuTiEBHYwSVzb84kNwrnAJPHkUQcLSJWw
        QKTE3z2zwDpEBLwk5j+awQpiMwsUSDxvv8MIYgsJ1Ei83/OcHcRmE9CVWNTTzARi8wrYSzT0
        nwPrZRFQlXixbi5QDQeHqECExIaN/BAlghInZz4BW8Up4CKxauliqPHqEn/mXWKGsMUlbj2Z
        zwRhy0tsfzuHeQKjwCwk7bOQtMxC0jILScsCRpZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbqm
        ermZJXqpKaWbGCHhLriDccZJuUOMAhyMSjy8AtfvRAqxJpYVV+YeYpTkYFIS5VWYczdSiC8p
        P6UyI7E4I76oNCe1+BCjBAezkghv8EWgHG9KYmVValE+TEqag0VJnJdvibqfkEB6Yklqdmpq
        QWoRTFaGg0NJgjfpOlCjYFFqempFWmZOCUKaiYMTZDgP0PC/10CGFxck5hZnpkPkTzHqctx4
        eP0PkxBLXn5eqpQ4bzjIIAGQoozSPLg5sDT1ilEc6C1h3skgVTzAFAc36RXQEiagJaJpd0CW
        lCQipKQaGMs9f71b/rbqefv7kiWm/F94XjS+97vDIceRkzhDKHJPsqZfQ3iUkBHbLs7ou4ki
        jvbSMQ95L/QdPlFQdW5nXsF1IaXas1OEOJzqgnhaFXYvjTjO/YDTyD9mqaxlo6rqpvteb8t3
        //DftKSYd8XyyJOCx1dKqC99zCRyhncJU+8/swWlyXfmKLEUZyQaajEXFScCAHpxJ5wuAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2017 03:11 AM, brian m. carlson wrote:
> Convert several static functions to take pointers to struct object_id.
> Change the relevant parameters to write_packed_entry to be const, as we
> don't modify them.  Rename lock_ref_sha1_basic to lock_ref_oid_basic to
> reflect its new argument.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  refs/files-backend.c | 48 ++++++++++++++++++++++++------------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 7281f27f62..84d8e3da99 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -811,7 +811,7 @@ static struct ref_iterator *files_ref_iterator_begin(
>   * return a negative value.
>   */

The docstring for this function needs adjusting. It would also be worth
mentioning that `old_oid` is allowed to be NULL (which was true before
but wasn't mentioned).

> [...]

Michael

