Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B05321F453
	for <e@80x24.org>; Tue, 16 Oct 2018 01:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJPJmY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 05:42:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38779 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJPJmX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 05:42:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id 193-v6so21434764wme.3
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 18:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dMnfEyusVpADSUPNy1umpfV076sw/ZIlUcOuWEwdmK0=;
        b=PoMYteeXqZJlEin/n0i2LND1lYjD9AaLcW3HOzC5mzwAKU3XiCm1LJi/OWl0/me8h9
         oKlwKazFtPAr9oDmVnIdRk/XSp0MVjEd8yLWxsRbm+TDzze6ogx1EPgtbickXSJrBUjo
         K0GsodWzmE+cQKQUu4fPzf9rEiG9LUzsaNACRVlmkE31AcRb3KoMA2mbsNMRGbG6aPFY
         3VuylRXB0rd+F9W4m/J77A/0hDRAW/+CrAqd/ZPjg9nTrtvDw4QobtxAP7PdbXIV1Ncj
         e0Qk9866XfLwXF2nHJY+fsdMGYhTdLsm4TCu4zZZlzJP/S84CXaD8hPEdXj7aNDr2BiR
         pfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dMnfEyusVpADSUPNy1umpfV076sw/ZIlUcOuWEwdmK0=;
        b=nb1P/Lo4/uSC5E/XH1t62ZlnqniQ/H4Fu+jGfswlWU7JPN9q3Cx111nBp+m3Y5Tgbd
         oTtoXnfWQPwOeT8koIrvaanm+mAptv0ptsoBEkXk+Z022WcRisSM4k1ylL4ciLPUcOLm
         HcmjKnpnQTRPwxkMF+78owPUTk6HVRgx0qJuSonaGh9Aw/M2yFjPgKB2nXTV9mJbHxyd
         pIfAXtpWiHEJ9nYVbF68hV+Mtb5PMrgM17MrEtSiOf0eYjNQlImNBON3nKP1cAlsgWOh
         l17vCb/CCoeCpW3uTFe36yCICPcyDQoDpRxaIipL2vSm6YdU9SIy+pQ1sLUrfbEj4wJN
         q5vQ==
X-Gm-Message-State: ABuFfog7+WB3riz8nk3KZtbs/UjUm2Nwqcawkgg68rHJ2tvDriNj0coi
        Cn9fVA9c9ztQsOirFP/2pVc=
X-Google-Smtp-Source: ACcGV60Ze4To+kXga9lT8vOT7rsIeGevVOOS1CXQIBSjlMDR708qXpn6ymvUz0H7jCryI5pxb6IR4g==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184-v6mr15488876wmf.143.1539654865374;
        Mon, 15 Oct 2018 18:54:25 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u10-v6sm9272759wrt.59.2018.10.15.18.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 18:54:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 03/13] hex: introduce functions to print arbitrary hashes
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
        <20181015021900.1030041-4-sandals@crustytoothpaste.net>
Date:   Tue, 16 Oct 2018 10:54:23 +0900
In-Reply-To: <20181015021900.1030041-4-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 15 Oct 2018 02:18:50 +0000")
Message-ID: <xmqqo9bu4pww.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> diff --git a/cache.h b/cache.h
> index d508f3d4f8..a13d14ce0a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1361,9 +1361,9 @@ extern int get_oid_hex(const char *hex, struct object_id *sha1);
>  extern int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
>  
>  /*
> - * Convert a binary sha1 to its hex equivalent. The `_r` variant is reentrant,
> + * Convert a binary hash to its hex equivalent. The `_r` variant is reentrant,
>   * and writes the NUL-terminated output to the buffer `out`, which must be at
> - * least `GIT_SHA1_HEXSZ + 1` bytes, and returns a pointer to out for
> + * least `GIT_MAX_HEXSZ + 1` bytes, and returns a pointer to out for
>   * convenience.
>   *
>   * The non-`_r` variant returns a static buffer, but uses a ring of 4
> @@ -1371,10 +1371,13 @@ extern int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
>   *
>   *   printf("%s -> %s", sha1_to_hex(one), sha1_to_hex(two));
>   */
> -extern char *sha1_to_hex_r(char *out, const unsigned char *sha1);
> -extern char *oid_to_hex_r(char *out, const struct object_id *oid);
> -extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
> -extern char *oid_to_hex(const struct object_id *oid);	/* same static buffer as sha1_to_hex */
> +char *hash_to_hex_algo_r(char *buffer, const unsigned char *hash, int algo);
> +char *sha1_to_hex_r(char *out, const unsigned char *sha1);
> +char *oid_to_hex_r(char *out, const struct object_id *oid);
> +char *hash_to_hex_algo(const unsigned char *hash, int algo);	/* static buffer result! */
> +char *sha1_to_hex(const unsigned char *sha1);			/* same static buffer */
> +char *hash_to_hex(const unsigned char *hash);			/* same static buffer */
> +char *oid_to_hex(const struct object_id *oid);			/* same static buffer */

Even though in hex.c I see mixture of *_algo and *_algop helper
functions, I see only "algo" variants above.  Is it our official
stance to use primarily the integer index into the algo array when
specifying the hash, and when a caller into 'multi-hash' API happens
to have other things, it should use functions in 2/13 to convert it
to the canonical "int algo" beforehand?

I am not saying it is bad or good to choose the index into the algo
array as the primary way to specify the algorithm.  I think it is a
good idea to pick one and stick to it, and I wanted to make sure
that the choice we made here is clearly communicated to any future
developer who read this code.

> +char *sha1_to_hex(const unsigned char *sha1)
> +{
> +	return hash_to_hex_algo(sha1, GIT_HASH_SHA1);
> +}
> +
> +char *hash_to_hex(const unsigned char *hash)
> +{
> +	return hash_to_hex_algo(hash, hash_algo_by_ptr(the_hash_algo));
>  }
>  
>  char *oid_to_hex(const struct object_id *oid)
>  {
> -	return sha1_to_hex(oid->hash);
> +	return hash_to_hex_algo(oid->hash, hash_algo_by_ptr(the_hash_algo));
>  }

Having said the above, seeing the use of hash_algo_by_ptr() here
makes me suspect if it makes more sense to use the algop as the
primary way to specify which algorithm the caller wants to use.
IOW, making the set of helpers in 02/13 to allow quering by name,
format-id, or the integer index and have them all return a pointer
to "const struct git_hash_algo".  Two immediate downsides I can see
is that it exposes the actual structure to the callers (but is it
really a problem?  Outside callers learn hash sizes etc. by accessing
its fields anyway without treating the algo struct as opaque.), and
passing an 8-byte pointer may be more costly than passing a small
integer index that ranges between 0 and 1 at most (assuming that
we'd only use SHA-1 and "the current NewHash" in the code).


