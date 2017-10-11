Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F6F20372
	for <e@80x24.org>; Wed, 11 Oct 2017 06:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932583AbdJKG6n (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 02:58:43 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53670 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932552AbdJKG6m (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Oct 2017 02:58:42 -0400
X-AuditID: 12074411-f7dff70000007f0a-cf-59ddc117a2c5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 47.F9.32522.711CDD95; Wed, 11 Oct 2017 02:58:31 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCD9E.dip0.t-ipconnect.de [87.188.205.158])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9B6wSO9002379
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 11 Oct 2017 02:58:30 -0400
Subject: Re: [PATCH v2 05/24] refs: update ref transactions to use struct
 object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-6-sandals@crustytoothpaste.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <102fb417-fd98-0ba6-5002-f14f8fc6cb95@alum.mit.edu>
Date:   Wed, 11 Oct 2017 08:58:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171009011132.675341-6-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1BU/eDfS4NZ6HYvn60+wW3Rd6Way
        +NHSw2zRNvMHk8Xmze0sDqwey2/+ZfJYsKnU41nvHkaPz5vkAliiuGxSUnMyy1KL9O0SuDJW
        bFzLUrCct6JhfSNjA+NJzi5GTg4JAROJudfPsHQxcnEICexgkui/sZMNwrnAJHH00Q52kCph
        gVCJiYf/M4HYIgJeEvMfzWAFsZkFCiSet99hBLGFBKolJk87ygxiswnoSizqaQar5xWwl7j2
        rAfMZhFQlehd1Au0jYNDVCBCYsNGfogSQYmTM5+AhTkFnCXW3Q6BmK4u8WfeJWYIW1zi1pP5
        TBC2vMT2t3OYJzAKzELSPQtJyywkLbOQtCxgZFnFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuq
        l5tZopeaUrqJERLsgjsYZ5yUO8QowMGoxMMrcP1OpBBrYllxZe4hRkkOJiVRXoU5dyOF+JLy
        UyozEosz4otKc1KLDzFKcDArifBWrwPK8aYkVlalFuXDpKQ5WJTEefmWqPsJCaQnlqRmp6YW
        pBbBZGU4OJQkeNUPADUKFqWmp1akZeaUIKSZODhBhvMADa/cDzK8uCAxtzgzHSJ/ilFRSpz3
        CEhCACSRUZoH1wtLRq8YxYFeEeZdB1LFA0xkcN2vgAYzAQ0WTbsDMrgkESEl1cA48yurdvVr
        06T+Zw89/VbtVXe6rhNd0Hmp9ATzzibNzfscHrxS8m0TPdX9UcWBya78dkQXj86kGPFF2aJL
        80Ka5i8u3qXJvHFn9IstHcvXnm0586qm8akWU87dzTyuXTW5N0XeTpde9lXY5VK73A3m0j8C
        tm+b3OZ8FjK+arCTe4Xex8ZPDXZKLMUZiYZazEXFiQAD+4ZvIQMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2017 03:11 AM, brian m. carlson wrote:
> Update the ref transaction code to use struct object_id.  Remove one
> NULL pointer check which was previously inserted around a dereference;
> since we now pass a pointer to struct object_id directly through, the
> code we're calling handles this for us.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  branch.c               |  2 +-
>  builtin/clone.c        |  2 +-
>  builtin/commit.c       |  4 ++--
>  builtin/fetch.c        |  4 ++--
>  builtin/receive-pack.c |  4 ++--
>  builtin/replace.c      |  2 +-
>  builtin/tag.c          |  2 +-
>  builtin/update-ref.c   |  8 ++++----
>  fast-import.c          |  4 ++--
>  refs.c                 | 44 +++++++++++++++++++++-----------------------
>  refs.h                 | 24 ++++++++++++------------
>  refs/files-backend.c   | 12 ++++++------
>  refs/refs-internal.h   |  4 ++--
>  sequencer.c            |  2 +-
>  walker.c               |  2 +-
>  15 files changed, 59 insertions(+), 61 deletions(-)
> 
> [...]
> diff --git a/refs.h b/refs.h
> index 369614d392..543dcc5956 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -519,15 +519,15 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>   */
>  int ref_transaction_update(struct ref_transaction *transaction,

The docstring for this function needs to be updated.

>  			   const char *refname,
> -			   const unsigned char *new_sha1,
> -			   const unsigned char *old_sha1,
> +			   const struct object_id *new_oid,
> +			   const struct object_id *old_oid,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err);
>  
> [...]

Michael
