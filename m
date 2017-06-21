Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A8620401
	for <e@80x24.org>; Wed, 21 Jun 2017 17:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbdFURdN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 13:33:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34673 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbdFURdL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 13:33:11 -0400
Received: by mail-pf0-f193.google.com with SMTP id d5so31990190pfe.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sSO1X8E/L0NH2gVKALtnUY0sJBMZaH3BZrTGV+Wrkr4=;
        b=TdCE+kWtmvOWG9XHaPaYk2b8TeU1XeI1jdB2AT7L3SWqDoY3sLfpdGGRD6KIYiEU8v
         lW2NUx7agXAzfj2u5F8xxO0keWE/M2bVJlkObe20FKPx+1O4Z4TsXbvIVSwYZ73Z/7Jt
         djLTNf9bB0+/YEoNvgPFkGY20bKnEoeMF7aMjxi1CF9zqmbW9r3w++NZDsDoovMjAuMs
         s08C22CMD+Yl2KpBQsmHH2OAJ73z6gvqkeFzoRM6rmSYCVPALB6aL6Eu55L+QAEBT24s
         56oLIltiByvJXujymq5XpJjGtAI1aQvOWiq/q6Fwa1TwNhr8R7Mo+j3Figj6uvITf9QV
         Ivog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sSO1X8E/L0NH2gVKALtnUY0sJBMZaH3BZrTGV+Wrkr4=;
        b=S9yTG2GE9Up4MviMqN0FHXtf5054E+ERxg1tWfVwXJjwFt9cFIyLkvCIv/GzAeY3tW
         Xm8PcdK8mY+Z3mzNv71nbY2IuzikL4EGn8dz/8MjZaRqbx00dVtiBMk7uCWaiAfIN/Wz
         mbsdcyQdvDJMT6yYKrmgl2jM0NQMa/rDPU494j0nvcs90PGFeXkZflwtchnSYqWDdqf1
         sJ8DId5w2AreF2yflipdg/L94uFDKZLwTJ7MS2493IniAvKmCtRAo+v5BcQKYUqAX81x
         w0ykumgTDYUvZrh2pWCPXsPg9GjMN3I7H6JkE34fbAZqSnfOhMTdrqjEzrtIOdp/nFsj
         o4GA==
X-Gm-Message-State: AKS2vOyHq2mzo0V0bQSWsz4f6SiI1aq701lkYv1aHIIskyHxEAPc4xII
        zo42z7hbv2L7AA==
X-Received: by 10.99.56.82 with SMTP id h18mr32575026pgn.52.1498066390795;
        Wed, 21 Jun 2017 10:33:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id z69sm37228999pff.0.2017.06.21.10.33.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 10:33:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 3/8] sha1_file: rename LOOKUP_REPLACE_OBJECT
References: <cover.1497920092.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497920092.git.jonathantanmy@google.com>
        <6f6e8237db12ec2cd8fb4c8e2951bfc867a656a2.1497920092.git.jonathantanmy@google.com>
Date:   Wed, 21 Jun 2017 10:33:09 -0700
In-Reply-To: <6f6e8237db12ec2cd8fb4c8e2951bfc867a656a2.1497920092.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 19 Jun 2017 18:03:10 -0700")
Message-ID: <xmqqinjpqm96.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The LOOKUP_REPLACE_OBJECT flag controls whether the
> lookup_replace_object() function is invoked by
> sha1_object_info_extended(), read_sha1_file_extended(), and
> lookup_replace_object_extended(), but it is not immediately clear which
> functions accept that flag.
>
> Therefore restrict this flag to only sha1_object_info_extended(),
> renaming it appropriately to OBJECT_INFO_LOOKUP_REPLACE and adding some
> documentation. Update read_sha1_file_extended() to have a boolean
> parameter instead, and delete lookup_replace_object_extended().
>
> parse_sha1_header() also passes this flag to
> parse_sha1_header_extended() since commit 46f0344 ("sha1_file: support
> reading from a loose object of unknown type", 2015-05-03), but that has
> had no effect since that commit. Therefore this patch also removes this
> flag from that invocation.

Yay, code reduction ;-).

> -/* object replacement */
> -#define LOOKUP_REPLACE_OBJECT 1
> -extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
> +extern void *read_sha1_file_extended(const unsigned char *sha1,
> +				     enum object_type *type,
> +				     unsigned long *size, int lookup_replace);

In general, I'd hesitate to regress the API from "unsigned flag"
(that is easier to extend) to "int is_foo" (that will either have to
be reverted back to "unsigned flag", or an overlong parameter list
"int is_foo, int is_bar, int is_baz, ...").  

But let's take this as-is and see how it evolves.

> @@ -3025,7 +3027,7 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
>  
>  	oi.typep = &type;
>  	oi.sizep = sizep;
> -	if (sha1_object_info_extended(sha1, &oi, LOOKUP_REPLACE_OBJECT) < 0)
> +	if (sha1_object_info_extended(sha1, &oi, OBJECT_INFO_LOOKUP_REPLACE))
>  		return -1;
>  	return type;
>  }

This changes the error behaviour slightly, doesn't it?  Is it
guaranteed that sha1_object_info_extended() will never return
positive non-zero?  Right now it appears that is the case, so
this probably is a justifiable simplification of a caller, but
given the real consumer of the _extended() API in cat-file.c
treats only negative as an error, we should be consistent.  

I'd prefer to see this change _not_ made as part of this patch.
It may be OK to change this place and two callers in cat-file in a
follow-up patch though.

> @@ -3107,13 +3109,14 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
>  void *read_sha1_file_extended(const unsigned char *sha1,
>  			      enum object_type *type,
>  			      unsigned long *size,
> -			      unsigned flag)
> +			      int lookup_replace)
>  {
>  	void *data;
>  	const struct packed_git *p;
>  	const char *path;
>  	struct stat st;
> -	const unsigned char *repl = lookup_replace_object_extended(sha1, flag);
> +	const unsigned char *repl = lookup_replace ? lookup_replace_object(sha1)
> +						   : sha1;
>  
>  	errno = 0;
>  	data = read_object(repl, type, size);
