Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7881F404
	for <e@80x24.org>; Thu,  5 Apr 2018 18:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeDESXt (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 14:23:49 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35039 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeDESXr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 14:23:47 -0400
Received: by mail-wm0-f47.google.com with SMTP id r82so9891321wme.0
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 11:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vtSCoaE7dstgbGCq9iKDQwaDW0R2bPvq3DR274jf2C8=;
        b=r2+yXlzr4A5A6pnpAOuG7bHmwdzCk81zNwT7PsU9V8dgsr5XYVrZ7jhwmuDjBMdpqW
         uXItm0UiH4Fb021rRfqUKCo5qxZhDbLJMlULyMh548Q70vF8lymtcIm1ZbLMslhIKeyl
         BoNZyvc+LOiarErBK64PubOB4O+ZtDZ9/uKGGAQ6IbgEldAFTAj0u+bsZxua4m0jAE//
         vNB8LC/u70C2cVCSU/u3R2ctv3SwVGUZz/L1kxQqshd8be8kQiTh26qZAKZvRxXjc8Tz
         4Z4Y1zO2bNUCoewXoXOWkRF9JnEo/6SVPXm8gzPSKLPPeuIpT59ih8PW/p/b1miev6gm
         wqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vtSCoaE7dstgbGCq9iKDQwaDW0R2bPvq3DR274jf2C8=;
        b=ZDgDLNrLGmczJoDF9pGrAkV3OqzWrcXYBIdFo8E0qDw53tZeKleEhwPcrMYthfXTnD
         OdM0rUbR8UodFcmhq6QwW67ZZiafJtQPT2rDorfGAQlcj9m/4kMDfUukDmbTlMtRVXdQ
         gWhm661Eo7gHgAHs8YUIpNvMld91oCPORAgr5Atla6lbkwtasIhlkp00XcfNZSQG9U78
         ud7hnHS4gHVIsiTvEvotWz2/KHd0SKviF80clIHuZyOwCwZ+tpKC8tQ9liy0zkjgNzjT
         qO4+yGMlCNAFLlTB/vCoqSWjI2EulaAqURycwIIGik3yoa4q2XEbr+CQbsSiP7J32YKL
         +NhQ==
X-Gm-Message-State: AElRT7HejUGVPQPnvU8whBld+05mks04hSKy6U9EStc2qTD7k87vwXQZ
        0MbW1Vlb4h4SXUNxPbFIrDTKkA==
X-Google-Smtp-Source: AIpwx4+oieQaQjdwBAyZmiqYVyhtvQWnGknAMxXfBE8WbJfGxwJO4+ZZZjy9i6X/xWUVDz58lGJAXA==
X-Received: by 10.28.149.71 with SMTP id x68mr12589917wmd.78.1522952626020;
        Thu, 05 Apr 2018 11:23:46 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:697a:68ea:e25a:9da8? ([2001:a62:81d:ab01:697a:68ea:e25a:9da8])
        by smtp.googlemail.com with ESMTPSA id 71sm9516558wmg.11.2018.04.05.11.23.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 11:23:45 -0700 (PDT)
Subject: Re: [PATCH v3] git-svn: allow empty email-address using authors-prog
 and authors-file
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
References: <20180320220743.GA17234@whir>
 <20180324102046.8840-1-asheiduk@gmail.com>
 <20180405075113.3y6a5nadijswt7pm@untitled>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asheiduk@gmail.com; prefer-encrypt=mutual; keydata=
 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
 khKIKhAKu5lezA==
Message-ID: <e2234113-52cf-1443-5abb-70a595037f30@gmail.com>
Date:   Thu, 5 Apr 2018 20:23:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180405075113.3y6a5nadijswt7pm@untitled>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 05.04.2018 um 09:51 schrieb Eric Wong:
> Thanks for the update.  The patch itself looks good, but I
> noticed one --show-item isn't supported on SVN 1.8.10 for me.

--show-item is indeed a 1.9.0 thing:

https://subversion.apache.org/docs/release-notes/1.9.html#svn-info-item

> I've tested the following on both SVN 1.8.10 and 1.9.5:
> 
> --- a/t/t9138-git-svn-authors-prog.sh
> +++ b/t/t9138-git-svn-authors-prog.sh
> @@ -83,7 +83,8 @@ test_expect_success 'authors-prog imported user without email' '
>  test_expect_success 'imported without authors-prog and authors-file' '
>  	svn mkdir -m hh --username hh "$svnrepo"/hh &&
>  	(
> -		uuid=$(svn info --show-item=repos-uuid "$svnrepo") &&
> +		uuid=$(svn info "$svnrepo" |
> +			sed -n "s/^Repository UUID: //p") &&
>  		cd x &&
>  		git svn fetch &&
>  		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
> 
> Can you confirm it's OK for you?  Thanks.

Looks good, works for me.

Do you squash this patch with with my commit or do you need a reroll?
