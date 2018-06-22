Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494931F516
	for <e@80x24.org>; Fri, 22 Jun 2018 21:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754506AbeFVVMl (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 17:12:41 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42707 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754265AbeFVVMk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 17:12:40 -0400
Received: by mail-pg0-f67.google.com with SMTP id c10-v6so3477595pgu.9
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 14:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l46geY8DFYFQCDl594DLiTKgab0MER8VAgxcvJCm29k=;
        b=PzfLfYER7egmSFvcoVToIQnb0Pp+sC9JiQlVza4uabP4RV3PCjqXjLH2KZ7vpXtP8X
         ogm8jav/moMFDn7w1U8a5wsq2XTgyYEnGVHnwo0kkWF20RK+VLHBOsOscE3W+/r+1SG8
         0ZGwGNeATtLc3S4AqvRRPxqiPllaI6af7HXSWbeNWWEC4fC3gP7hXNlAPKh2lQhHpGSb
         ZI7ObXmt0Gcwd9UxkzrfGGKEA1M2szxWOSNtLcdGIsLKDaGOlTxYsyWTNa7ryaqFMn9I
         FGS0a19bMXXTyIFgKroX4vNjmkFaaivF09quVbsu6ZVSQICn3kqB68S3BPHHkVrczPDk
         2H3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l46geY8DFYFQCDl594DLiTKgab0MER8VAgxcvJCm29k=;
        b=uT0UEfcf48OSfkoWF0aR1J7i69rU+A1eulb/bWW+PXujP0SiS+JmObyB9PITwbx+9m
         ByY7PuYflOZM396g57VUuQXraagcqj9lDWwRF7+lGUGSS30c6wjRSZdrZfEkAFhlYmKx
         AFFvHAoQsCo7B/G5LCeXg7uyTcIUUbWq600ZcoiQcP4JlvwM+srKKWrdYb4n82HLZr7p
         9sJ+s6Br/CKUTeubeWU6cinqauh0A4wLnTcspkYUROZMPALZSLEaHmNL52hZWnUjhd6g
         GHsbi46PhIVPKYGLSpC5I2FGQlUwfh/yPC4q1S6mGRPujxjt3U1IEB0UJ4xavxJAHgyq
         5bdQ==
X-Gm-Message-State: APt69E2JpgfX5MzaArQ7gsqVFmYHwoNgP0Q1BtHirkD/Du2qlQ2iuMmt
        tp7u69uVLd1m+1zBb12jVOk=
X-Google-Smtp-Source: ADUXVKLgJatMS+QlD5NsWSTaGDT3IXSsatmixo0DmX/nzv+H+uBuaWgaXC4VQ1K9rzfhuhJKwQtYRA==
X-Received: by 2002:a63:a84f:: with SMTP id i15-v6mr2839774pgp.422.1529701959174;
        Fri, 22 Jun 2018 14:12:39 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id z82-v6sm18436909pfk.30.2018.06.22.14.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 14:12:38 -0700 (PDT)
Date:   Fri, 22 Jun 2018 14:12:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com
Subject: Re: [PATCH v3 1/8] test-pkt-line: add unpack-sideband subcommand
Message-ID: <20180622211236.GH12013@aiede.svl.corp.google.com>
References: <20180613213925.10560-1-bmwill@google.com>
 <20180620213235.10952-1-bmwill@google.com>
 <20180620213235.10952-2-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620213235.10952-2-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Add an 'unpack-sideband' subcommand to the test-pkt-line helper to
> enable unpacking packet line data sent multiplexed using a sideband.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  t/helper/test-pkt-line.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Neat.  It appears that this writes sideband channel 1 (packfile data)
to stdout, sideband channel 2 (progress) to stderr, and sideband
channel 3 (errors) cause the helper to fail.  It would have been nice
if a comment or the commit message said that, but it's no reason to
reroll --- the code is clear enough.

> --- a/t/helper/test-pkt-line.c
> +++ b/t/helper/test-pkt-line.c
> @@ -1,3 +1,4 @@
> +#include "cache.h"
>  #include "pkt-line.h"

I think this is for write_or_die.  Makes sense (well, in the same way
as any of the other functions that ended up in cache.h instead of a
more thought-through place do).

The old #includes were problematic, since the caller cannot count on
git-compat-util.h to be the first include of pkt-line.h.  See
Documentation/CodingGuidelines "The first #include" for more on this
subject.

[...]
> +static void unpack_sideband(void)
> +{
> +	struct packet_reader reader;
> +	packet_reader_init(&reader, 0, NULL, 0,
> +			   PACKET_READ_GENTLE_ON_EOF |
> +			   PACKET_READ_CHOMP_NEWLINE);
> +
> +	while (packet_reader_read(&reader) != PACKET_READ_EOF) {
> +		int band;
> +		int fd;
> +
> +		switch (reader.status) {
> +		case PACKET_READ_EOF:
> +			break;
> +		case PACKET_READ_NORMAL:
> +			band = reader.line[0] & 0xff;

reader.line[0] is a char. This promotes it to an 'int' and then ANDs
against 0xff, which would ensure it is a positive value.  In other
words, this does the same thing as

	band = (int) (unsigned char) reader.line[0];

but more concisely.

More importantly, it matches what recv_sideband does.  Good.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
