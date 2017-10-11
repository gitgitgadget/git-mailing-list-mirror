Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFC5920372
	for <e@80x24.org>; Wed, 11 Oct 2017 08:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756638AbdJKIBX (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 04:01:23 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48199 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756600AbdJKIA6 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Oct 2017 04:00:58 -0400
X-AuditID: 1207440e-be1ff70000007085-24-59ddcfb9d44b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 88.B3.28805.9BFCDD95; Wed, 11 Oct 2017 04:00:58 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCD9E.dip0.t-ipconnect.de [87.188.205.158])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v9B80tnu005385
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 11 Oct 2017 04:00:56 -0400
Subject: Re: [PATCH v2 14/24] refs: convert peel_ref to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-15-sandals@crustytoothpaste.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <fd5d26cc-94fb-5530-6344-25a1ed88ba92@alum.mit.edu>
Date:   Wed, 11 Oct 2017 10:00:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171009011132.675341-15-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1N11/m6kwdo3rBbP159gt+i60s1k
        8aOlh9mibeYPJovNm9tZHFg9lt/8y+SxYFOpx7PePYwenzfJBbBEcdmkpOZklqUW6dslcGXc
        n3GQqeA4T8W1o6ENjGs4uxg5OSQETCQeb1jG3MXIxSEksINJ4sHt61DOBSaJY/N/sXYxcnAI
        C3hItP0IAmkQEfCSmP9oBiuIzSxQIPG8/Q4jiC0kUCPxZMUuFhCbTUBXYlFPMxOIzStgL/H3
        /F9mEJtFQFVi/fsv7CAjRQUiJDZs5IcoEZQ4OfMJWCungItE44TVTBDj1SX+zLvEDGGLS9x6
        Mh8qLi+x/e0c5gmMArOQtM9C0jILScssJC0LGFlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka
        6+VmluilppRuYoSEOt8Oxvb1MocYBTgYlXh4Ba7fiRRiTSwrrsw9xCjJwaQkyqsw526kEF9S
        fkplRmJxRnxRaU5q8SFGCQ5mJRHeLaeAcrwpiZVVqUX5MClpDhYlcV61Jep+QgLpiSWp2amp
        BalFMFkZDg4lCd6354AaBYtS01Mr0jJzShDSTBycIMN5gIZbngcZXlyQmFucmQ6RP8WoKCXO
        2wbSLACSyCjNg+uFpaJXjOJArwjz/gep4gGmMbjuV0CDmYAGi6bdARlckoiQkmpg1NoacSrt
        tWfu7ojNe0p5Ft+5tshwKs8sfxPu/ul5PC/PiTwMWLL6E9vWurt9LLOMPCpeTElU/Tor8H70
        NA2hhhkx/1SL2uJ+SV5f69Bu7pv3uYrx6ObDXxX7l08RiHO9fmaf3oPi1gXrvul/OtTvPE3C
        7cQFddun4TYPLTRquxKUQ88WRb89r8RSnJFoqMVcVJwIAIl5y9ogAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/09/2017 03:11 AM, brian m. carlson wrote:
> Convert peel_ref (and its corresponding backend) to struct object_id.
> 
> This transformation was done with an update to the declaration,
> definition, and test helper and the following semantic patch:
> 
> @@
> expression E1, E2;
> @@
> - peel_ref(E1, E2.hash)
> + peel_ref(E1, &E2)
> 
> @@
> expression E1, E2;
> @@
> - peel_ref(E1, E2->hash)
> + peel_ref(E1, E2)
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/describe.c        | 2 +-
>  builtin/pack-objects.c    | 4 ++--
>  builtin/show-ref.c        | 2 +-
>  refs.c                    | 8 ++++----
>  refs.h                    | 4 ++--
>  refs/files-backend.c      | 8 ++++----
>  refs/packed-backend.c     | 4 ++--
>  refs/refs-internal.h      | 2 +-
>  t/helper/test-ref-store.c | 6 +++---
>  upload-pack.c             | 2 +-
>  10 files changed, 21 insertions(+), 21 deletions(-)
> 
> [...]
> diff --git a/refs.h b/refs.h
> index 8159b7b067..832ade2b13 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -120,8 +120,8 @@ extern int refs_init_db(struct strbuf *err);
>   * ultimately resolve to a peelable tag.
>   */

The comment just above needs to be adjusted.

>  int refs_peel_ref(struct ref_store *refs, const char *refname,
> -		  unsigned char *sha1);
> -int peel_ref(const char *refname, unsigned char *sha1);
> +		  struct object_id *oid);
> +int peel_ref(const char *refname, struct object_id *oid);
>  
>  /**
>   * Resolve refname in the nested "gitlink" repository in the specified
> [...]

Michael

