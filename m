Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16BF120A40
	for <e@80x24.org>; Sun,  3 Dec 2017 00:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbdLCApt (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 19:45:49 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43143 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdLCAps (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 19:45:48 -0500
Received: by mail-qt0-f196.google.com with SMTP id w10so17342265qtb.10
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 16:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8FWpKL/tCLktE7FqQXvaAxn0OReFP5vg9W0rAs+Q1AM=;
        b=VyZnvP1xVpKmvbh7ritudVFkmMmIlg8jqaE3/xFdc9e5qK460wo3CXpzw5rUwzeCas
         /qzMYiDo58cl77Wm/vBCVZnFgNLQ+/Zh02G/ZY4OVO0F1h6TxL8OSnmlfGRFf0cleZM1
         ydLWGyv5s4jqShjo+/fA1KZQ0zfULh25rUe2ocRP/ROQDxlNHQV0YwrwbX+hrnujxdsT
         2nrTO00+e2t1b592HfIxqAku+P/utnMl/lUB6wIpjBXgbqfOlWFtaBgZ0jPTvgxI4+Nd
         YM3NKWpZqikc7pYLFRQ71IYuwfRwRNJePdB6s59Py3LtkDz7DYr0wv72RPAkm2OG5Y5g
         gG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8FWpKL/tCLktE7FqQXvaAxn0OReFP5vg9W0rAs+Q1AM=;
        b=ofdjYz13Mgk2HKUqoIA6joX2ZYsFaG3xPxwo9VfrIwAEMWt27w8NJA9VUu3GYIuIDG
         FVB9keUcwm2GmL1kWIomGvBdAFZymfG/DKWMJnldvV3QPXJjnbpr2Azwe6+cDujnZrQg
         KtabLC+2AYIdaapaHuv8IxqeGNwOtowQi5r3pAez4OCd3bryfKmzM/9jC2j/Ksea4Rqz
         2HdQ+D+6NuLFaB0ZwJopkI5PeSWqO1yNXw+URojXdoDRySpZZha1ZxT1HAVIMVXYCV7L
         8KipCj8Gzd5LzFuGMuiQrYX6NfIYtxMXQ3xqZel/IHqxZyPoH8YSJSS+gh2P72SrvLbO
         dD2Q==
X-Gm-Message-State: AKGB3mIT/TCtv1WGbsiKZdl598cmEBdarDNMfeZEWEjX/YtGvXWZ4S3I
        ldPAVhGnWQroXgheZIXOo+XmtAquj1o=
X-Google-Smtp-Source: AGs4zMYrUhmx2+nKvr4ww6hD1uO2rt+MRBIZyv2V6/j5aT7/8vH5+VV2qfjaon1htP0yr8Mkele7Rg==
X-Received: by 10.237.57.36 with SMTP id l33mr15325151qte.324.1512261947127;
        Sat, 02 Dec 2017 16:45:47 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id u3sm6953580qka.39.2017.12.02.16.45.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 02 Dec 2017 16:45:46 -0800 (PST)
Date:   Sat, 2 Dec 2017 19:45:43 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Shikher Verma <root@shikherverma.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, santiago@nyu.edu,
        sbeller@google.com
Subject: Re: [PATCH] Add a sample hook which saves push certs as notes
Message-ID: <20171203004543.GO3693@zaya.teonanacatl.net>
References: <xmqqtvzzqt5u.fsf@gitster.mtv.corp.google.com>
 <20171202091248.6037-1-root@shikherverma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171202091248.6037-1-root@shikherverma.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shikher,

I'm not familiar with push certs, but I did notice some general issues
in the sample hook.  I hope they're helpful.

Shikher Verma wrote:
> index 000000000..b4366e43f
> --- /dev/null
> +++ b/templates/hooks--post-receive.sample
> +#!/bin/sh
...
> +if test -z GIT_PUSH_CERT ; then
> +    exit 0
> +fi

The $ is missing from GIT_PUSH_CERT.  test -z GIT_PUSH_CERT will
always be false. :)

The variable should also be quoted.  Not all sh implementations accept
a missing argument to test -z, as bash does.

More minor, Documentation/CodingGuidelines suggests placing 'then' on
a new line:

    if test -z "$GIT_PUSH_CERT"
    then
        exit 0
    fi

(There is plenty of code that doesn't follow that, so I don't know how
strong that preference is.)

This could also be written as:

    test -z "$GIT_PUSH_CERT" && exit 0

I don't know if there's any general preference to shorten it in git's
code or not.

> +push_cert=$(git cat-file -p  $GIT_PUSH_CERT)

Very minor: there's an extra space before the variable here.

(I also noticed the tests which use $GIT_PUSH_CERT, like t5534, use
'cat-file blob ...' rather than 'cat-file -p ...'.  I don't know if
that's much safer/better than letting cat-file guess the object type
in the hook.  I have no idea if there's a chance that "$GIT_PUSH_CERT"
has some unexpected, non-blob object type.)

> +while read oval nval ref
> +do
> +	# Verify that the ref update matches that in push certificate.
> +	if [[ $push_cert == *$oval" "$nval" "$ref* ]]; then

[[ isn't portable across all the sh implementations git strives to
support, as far as I know.

The minor point about 'then' on new line is applicable here too.  It
would also better match the outer 'while' loop.

> +		# add the push cert as note (namespaced pushcerts) to nval.
> +		git notes --ref=pushcerts add -m "$push_cert" $nval -f
> +	fi
> +done

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Learn from the mistakes of others--you can never live long enough to
make them all yourself.
    -- John Luther

