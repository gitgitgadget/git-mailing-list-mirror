Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BD10211B4
	for <e@80x24.org>; Mon,  7 Jan 2019 19:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfAGTl4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 14:41:56 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:40346 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfAGTlz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 14:41:55 -0500
Received: by mail-yw1-f74.google.com with SMTP id l69so697895ywb.7
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2xIcD27xrcejDppqGDEjvRIv1LV7Xj0PZdiPyQWg2Jw=;
        b=KtVNQ5isH8A+rb2Xx4zOsGJCqYGAoG4NTenmba6GNUb7N/vADlxROIMu7YSk5sWQX4
         PfHO/jEMU+vXeZ56ciolfnCfmuDoibOCeps9X1jQNaThRCvBW5ftwIWQy7f0OChK4Clm
         nrl/o3jm/Mps9npgFHm214QbRYcT0Sx1PA9kN1IX76y6f6kRA6OHhtuYTgt+l/LjllZH
         OfTARnzTYm2Czk7gUUn0aAIdRYU76GfZPq9eBPbHHy7ZxRfY6oyTt00DJdbfZ6ZJgy7E
         +9eehU+MK1bTISw7ExJp0rtYm/DBF71aYgZne+ILEuEkV2ZrmM40/HHp3iEjpDKsU9hr
         odcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2xIcD27xrcejDppqGDEjvRIv1LV7Xj0PZdiPyQWg2Jw=;
        b=J9tz3+tlh5mg9v+x/BUTgGnKqri4YPQvg/ZqBZfSS9Xnf7sC1sUffyZi4pV2rjUeUQ
         jhIF+CJzKRpvSbz6ciV4Gj4Vay704Gok05LmgwhaXpf60URDG1Tb4P4jlDmroG8wrnCg
         v3VvqS6K/0NKBDsPToHQ4F5aCt0S6+MPDAEQot+qcp9/E+drkbNeFIaHDuvfpk0H2Rnc
         yGCTAe7L4yoUnxH316+0+pK7m458kJY5cT6h1G7K4++J37DkH6P+Z0wBdXeYKH9a27u8
         rh6soLgheYZ+ks3UbtLZIICbzLV/2LwoyV7MWiKZfVWfIvXlZReUPSSW+1eQNHArkMv5
         JCIw==
X-Gm-Message-State: AA+aEWZ1mnnxX5VPimtz+SBRkkvlcYEhHsqj5ZckpHYbKQ5RKOMpM0Mu
        CzKPOX6hQ5yLZnw8OnvQzFIBEng82nqcrkZpmG7f
X-Google-Smtp-Source: AFSGD/WOClL8A+1af1aQKIGwC38guMi4ZfgRW+Ep+kupGdRHen/fo1VStahDYQXNeySOWn6OofzRmcE+KbXeSvDqoHa5
X-Received: by 2002:a25:44d4:: with SMTP id r203mr35457925yba.68.1546890114544;
 Mon, 07 Jan 2019 11:41:54 -0800 (PST)
Date:   Mon,  7 Jan 2019 11:41:50 -0800
In-Reply-To: <20181229211915.161686-3-masayasuzuki@google.com>
Message-Id: <20190107194150.58700-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181229211915.161686-3-masayasuzuki@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v2 2/2] pack-protocol.txt: accept error packets in any context
From:   Jonathan Tan <jonathantanmy@google.com>
To:     masayasuzuki@google.com
Cc:     git@vger.kernel.org, peff@peff.net, steadmon@google.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

First of all, there was some discussion [1] about its relation with
js/smart-http-detect-remote-error. I noticed that
js/smart-http-detect-remote-error has all tests passing even if I remove
Masaya's patch, so I'm reviewing these patches independently, directly on
master.

[1] https://public-inbox.org/git/CAJB1erU0utjKGtv3LBFT6SEEKCfFRuxGvDtpkKeS3GSC1S89JA@mail.gmail.com/

> In the Git pack protocol definition, an error packet may appear only in
> a certain context. However, servers can face a runtime error (e.g. I/O
> error) at an arbitrary timing. This patch changes the protocol to allow
> an error packet to be sent instead of any packet.
> 
> Without this protocol spec change, when a server cannot process a
> request, there's no way to tell that to a client. Since the server
> cannot produce a valid response, it would be forced to cut a connection
> without telling why. With this protocol spec change, the server can be
> more gentle in this situation. An old client may see these error packets
> as an unexpected packet, but this is not worse than having an unexpected
> EOF.

The other thing that happens is that servers send "ERR" anyway, even
though it is not allowed by the protocol.

This overall looks like a good direction - this makes explicit something
that is already being done.

My remaining concern is if "ERR " could be a non-error packet mistaken
for an error one. I glanced through pack-protocol.txt and as far as I
can tell, I don't see anything non-error sent by the server that could
be prefixed with "ERR". (There are push-option and gpg-signature-lines,
but those are sent by the client.) Packfiles can contain anything, of
course, but as far as I can tell, they are either sent un-PKT-ed or
preceded by a sideband (\1), so they are fine.

> diff --git a/serve.c b/serve.c
> index bda085f09..317256c1a 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -167,7 +167,8 @@ static int process_request(void)
>  
>  	packet_reader_init(&reader, 0, NULL, 0,
>  			   PACKET_READ_CHOMP_NEWLINE |
> -			   PACKET_READ_GENTLE_ON_EOF);
> +			   PACKET_READ_GENTLE_ON_EOF |
> +			   PACKET_READ_DIE_ON_ERR_PACKET);
>  
>  	/*
>  	 * Check to see if the client closed their end before sending another
> @@ -175,7 +176,7 @@ static int process_request(void)
>  	 */
>  	if (packet_reader_peek(&reader) == PACKET_READ_EOF)
>  		return 1;
> -	reader.options = PACKET_READ_CHOMP_NEWLINE;
> +	reader.options &= ~PACKET_READ_GENTLE_ON_EOF;

Here, the old line is meant to remove PACKET_READ_GENTLE_ON_EOF - the
new line is both necessary and clearer.

> diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
> index 3f58f05cb..d2a9d0c12 100755
> --- a/t/t5703-upload-pack-ref-in-want.sh
> +++ b/t/t5703-upload-pack-ref-in-want.sh
> @@ -208,7 +208,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
>  	cp -r "$LOCAL_PRISTINE" local &&
>  	inconsistency master 1234567890123456789012345678901234567890 &&
>  	test_must_fail git -C local fetch 2>err &&
> -	grep "ERR upload-pack: not our ref" err
> +	grep "fatal: remote error: upload-pack: not our ref" err
>  '
>  
>  test_expect_success 'server is initially ahead - ref in want' '
> @@ -254,7 +254,7 @@ test_expect_success 'server loses a ref - ref in want' '
>  	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-sed" &&
>  	test_must_fail git -C local fetch 2>err &&
>  
> -	grep "ERR unknown ref refs/heads/raster" err
> +	grep "fatal: remote error: unknown ref refs/heads/raster" err
>  '

And this shows that we have tests that exercise the new code.

The rest of the diff is just the addition of the new
PACKET_READ_DIE_ON_ERR_PACKET, and looks correct.
