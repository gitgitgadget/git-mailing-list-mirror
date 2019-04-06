Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B37BA20248
	for <e@80x24.org>; Sat,  6 Apr 2019 11:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfDFLbR (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Apr 2019 07:31:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33222 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfDFLbR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Apr 2019 07:31:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so4503816pgh.0
        for <git@vger.kernel.org>; Sat, 06 Apr 2019 04:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b6RU2sBCDzbM53xe1y7JrSdeeAnEG9NX0Tr3IyYyh5E=;
        b=YAzbF1fOueFsWpwhtN36we1B5/pmhDN96je2QMOCQNLUZGgwqaZOw5hr6DMifK5TpU
         8m3A4JRR2hcIkfxu+XdnJwJGeGfDOyFVA+nv3Ps18HQgvH+9TUgep6AvdMGfOrdhfHoe
         lhckgQ3GY0Ne3A38Q0jh2YOjvtcdDd0lFWzhEuGowX4AqyF8oQexNbcXU1AyWanNaNvf
         A1bPTnfr2ESRIsTHn4yQRl/pwoXjuwDs6qz9upnhoF8CXeqMjc7NJv8gKXS+T0slEt8X
         Z4p/rEb/6EeAM2s2t8i50rgAmYN0acH2BciAkiGKNcCIC9CdQM7r1qu2IgvMkamL6VZS
         1Pzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b6RU2sBCDzbM53xe1y7JrSdeeAnEG9NX0Tr3IyYyh5E=;
        b=lT8PR0SomttJ3xp3pIXu6eIXaZsIB374bUJ2QJqCb8ui0K5ikXBZ14MklqUS3g8kya
         r1YTRB84m0TxBuSUWdq7zqFVE4qM5cpWAixzlmL/CC6tqnX7oLQ1cpc758ICoRIwvlR2
         26FSoSrjuJ/JOItU5ByFG5XQfUs6iAfKyYyO1nIkdoUt/2MedhH4Xq04eTj0zJ2wFtHw
         2bWaBCbJxa71ntcpkXjv2LR6l9RHdj7dYdzK2UnQzi+aI1ECDm22DOkgAGjomRUWEEnh
         MlMGqaEJWgpfZyPd+wRb5tZIgR8GSL4lDOhSMBSivSYMfYHKal9tKcjoDy2rxAOXQSGD
         mU+A==
X-Gm-Message-State: APjAAAWtDiUdWDJ8bqjogiZni03DS8adxgcvs62K52d7tQUg5UpOnG0K
        rw/iBHkP4T5Xn/fGgkpk1dw=
X-Google-Smtp-Source: APXvYqw0bXULOnhKLhZrs3PluTt5/5MuOkdfq/P53/rxAidipgJeQGd2JXEUVugKI1VqchVDAR3xeA==
X-Received: by 2002:a63:2045:: with SMTP id r5mr2545609pgm.394.1554550276327;
        Sat, 06 Apr 2019 04:31:16 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id r11sm53026508pga.87.2019.04.06.04.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Apr 2019 04:31:15 -0700 (PDT)
Date:   Sat, 6 Apr 2019 04:31:13 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v2] t5551: mark half-auth no-op fetch test as v0-only
Message-ID: <20190406113113.GA219876@google.com>
References: <20190321174719.151877-1-jonathantanmy@google.com>
 <20190322190139.151189-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322190139.151189-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> When using protocol v0, upload-pack over HTTP permits a "half-auth"
> configuration in which, at the web server layer, the info/refs path is
> not protected by authentication but the git-upload-pack path is, so that
> a user can perform fetches that do not download any objects without
> authentication, but still needs authentication to download objects.
>
> But protocol v2 does not support this, because both ref and pack are
> obtained from the git-upload-pack path.
>
> Mark the test verifying this behavior as protocol v0-only, with a
> description of what needs to be done to make v2 support this.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

Thanks for the analysis.  Makes sense.

> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -164,7 +164,17 @@ test_expect_success 'clone from auth-only-for-objects repository' '
>  
>  test_expect_success 'no-op half-auth fetch does not require a password' '
>  	set_askpass wrong &&
> -	git --git-dir=half-auth fetch &&
> +
> +	# NEEDSWORK: When using HTTP(S), protocol v0 supports a "half-auth"
> +	# configuration with authentication required only when downloading
> +	# objects and not refs, by having the HTTP server only require
> +	# authentication for the "git-upload-pack" path and not "info/refs".
> +	# This is not possible with protocol v2, since both objects and refs
> +	# are obtained from the "git-upload-pack" path. A solution to this is
> +	# to teach the server and client to be able to inline ls-refs requests
> +	# as an Extra Parameter (see pack-protocol.txt), so that "info/refs"
> +	# can serve refs, just like it does in protocol v0.
> +	GIT_TEST_PROTOCOL_VERSION=0 git --git-dir=half-auth fetch &&
>  	expect_askpass none

I suspect it's fine if protocol v2 never supports this.  Can we change
the NEEDSWORK comment to say that the protocol v2 spec should document
the lack of support for half-auth?

With or without such a change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
