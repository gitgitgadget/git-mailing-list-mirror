Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D5AF20372
	for <e@80x24.org>; Mon,  9 Oct 2017 23:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755507AbdJIXNI (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Oct 2017 19:13:08 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:47742 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754347AbdJIXNH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2017 19:13:07 -0400
Received: by mail-pf0-f179.google.com with SMTP id z11so5317885pfk.4
        for <git@vger.kernel.org>; Mon, 09 Oct 2017 16:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QFyFm38vHO0pym2fTJ/62f0QzshBH+WCkoST9mQ0enU=;
        b=kkcutkDaSUp9vxyvTHETJ8lYLLBCA4BmHBHHeKj76JEjjrc7Sqwn8iunmCJu00LddI
         DOQD5lw/uYD0YAiPjV7ZpFJZdyQmlyxHqe4RpXEONSW7T65c0c9tdwlROBUhRFKnY0/K
         wPJiZfkr+ySs1QoRf+fcAbvvo9wGRCOaRVSWvJl9RKWt5iFGh1DhzroADbgR7FK0cuzO
         mQTtzIAB9XkkD94dX88RybGKbkuNS3smmRzEo4CQ6huwNk0Y1PlMOljmDQz7Z85KDt07
         AQhOn+uEqHdqYFQ/m4WclNWVE/SODy/7eGKfLkABBe1Le+4sBS0v5qs4PNzmtn6yoPhf
         mE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QFyFm38vHO0pym2fTJ/62f0QzshBH+WCkoST9mQ0enU=;
        b=Z+RqvsrgnDodN+gyUdyCc9d1YimrAydV1zXcT8jFWNgKycKjSP6cIvTyIlguC9LWT4
         IOdaL5U1bqEHDuQYxu3FOzGfiHo3bAlJpiMNH4AUBR96tKO1e6PzrSwErUBRUuOS6KXt
         npkGCLTmZ/t8s8U24ocJnOsf/iO26H9GrVOA+X3mSNvKtgaKlTO77BUJMSSTKvgtaZwR
         1Bb/PStWWTk2lp1yWDpaiF2HLmNLpPUaxqnTwxUaW2jojQTVPjr1r5IayzWlL0M9/V9C
         jrNQM2/DcryTe1R79xS9pTYCTgUdej5NyAv/XQNLqf/jDt1z5hYVE13xamzruqUpLDpQ
         r4tw==
X-Gm-Message-State: AMCzsaWKgrVsPp5YkJBS6JTUWiLSJlBUUmYojrf0NuIajsHiuif28Ehc
        FhLtyWZxtVZHU5oHf3omeFw=
X-Google-Smtp-Source: AOwi7QCTRZGXK2vDFf+iFl3k5NBDlmA0NxlYDZKZSTI4FdSFFyOKZnpSS1Eu4Wc7KHSwjRm2b1eV/A==
X-Received: by 10.84.131.66 with SMTP id 60mr10379066pld.341.1507590787182;
        Mon, 09 Oct 2017 16:13:07 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:c9c7:66a0:181:dab2])
        by smtp.gmail.com with ESMTPSA id h9sm17747359pfh.98.2017.10.09.16.13.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 09 Oct 2017 16:13:06 -0700 (PDT)
Date:   Mon, 9 Oct 2017 16:13:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 05/24] refs: update ref transactions to use struct
 object_id
Message-ID: <20171009231304.GI19555@aiede.mtv.corp.google.com>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
 <20171009011132.675341-6-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171009011132.675341-6-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

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

Makes sense.

[...]
> +++ b/refs.c
[...]
>  int ref_transaction_create(struct ref_transaction *transaction,
>  			   const char *refname,
> -			   const unsigned char *new_sha1,
> +			   const struct object_id *new_oid,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err)
>  {
> -	if (!new_sha1 || is_null_sha1(new_sha1))
> +	if (!new_oid || is_null_oid(new_oid))
>  		die("BUG: create called without valid new_sha1");

The error message still refers to new_sha1.

[...]
>  int ref_transaction_delete(struct ref_transaction *transaction,
>  			   const char *refname,
> -			   const unsigned char *old_sha1,
> +			   const struct object_id *old_oid,
>  			   unsigned int flags, const char *msg,
>  			   struct strbuf *err)
>  {
> -	if (old_sha1 && is_null_sha1(old_sha1))
> +	if (old_oid && is_null_oid(old_oid))
>  		die("BUG: delete called with old_sha1 set to zeros");

Likewise.

[...]
>  int ref_transaction_verify(struct ref_transaction *transaction,
>  			   const char *refname,
> -			   const unsigned char *old_sha1,
> +			   const struct object_id *old_oid,
>  			   unsigned int flags,
>  			   struct strbuf *err)
>  {
> -	if (!old_sha1)
> +	if (!old_oid)
>  		die("BUG: verify called with old_sha1 set to NULL");

Likewise.

[...]
> +++ b/refs.h
> @@ -519,15 +519,15 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
[...]
>  /*
> - * Add a reference creation to transaction. new_sha1 is the value that
> + * Add a reference creation to transaction. new_oid is the value that
>   * the reference should have after the update; it must not be
> - * null_sha1. It is verified that the reference does not exist
> + * null_oid. It is verified that the reference does not exist
>   * already.
>   *
>   * See the above comment "Reference transaction updates" for more
> @@ -535,35 +535,35 @@ int ref_transaction_update(struct ref_transaction *transaction,
>   */

(Possible diff generation bug: there's exactly one line represented in
that @@ field.  I would have expected the diff generator to combine
the hunks.)

I think this is fine to go in without the error messages being fixed.
A grep for 'sha1' will find them later so that they can be addressed
in a separate patch.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
