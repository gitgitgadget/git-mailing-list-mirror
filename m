Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E2771F404
	for <e@80x24.org>; Mon, 17 Sep 2018 19:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeIRBYM (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 21:24:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45755 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeIRBYL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 21:24:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so18504268wrb.12
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 12:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5EKIuV4fIUXOhtbcj5HNULlPhD2V5QYAyGGEXRP+7fc=;
        b=mVwws3cDqoKIjQKD49nZvpOds2ZYyaqv99pGezStezEF6PuwHb6RtHH4RIsDfYuc8g
         2BgV3OW/wB1LRDQdWFnPp/S3Ack+RzdgI7AL9l/EfIRO+hDLBUkQTkdcuRARBq+Fs+LS
         8zWC+u42XShw6PMd/iVli96b/RUXlQKmvs808VoIgElBZiDJa2CTQDIT9Qo9PPzkPLV3
         farAuVD3zufx1daSVXWJI4mw/M06GMV1Z92AQgreoWeZlaUceIEkxm1MaLez0shyZH7O
         iARKFsEDPzeQP1g0igJGrTq9ITQjuE4diytgihVDkEcnmc59sNKNnCfKef5DVABOi93p
         1EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5EKIuV4fIUXOhtbcj5HNULlPhD2V5QYAyGGEXRP+7fc=;
        b=Iqcul4tgBoyZ78X0UDPc2cOcf6g/B31+vqQA/58Wh0u9uZzsId2fSDgb4fBDo3pWyt
         Yy+jvLsv8yzJy22TVZlgNawAs8JaIQhPQ7+UkEQD+3TnJGz1Ce6O5BW7YJkvlzWlAzUu
         OFmJqVtRhc+4GXdUplKxGfhfiPEenKY6SSb+PKCVwM6/MRYERrpgU6GyMw5iG4W2BuJ1
         c/lrZtRZM9u+vzxcTpBA1JYeG0UDU5p7e2DM38fNHpwDnWtJdcUOB6qEaULthUUiGsLu
         lfmWsiLRzF1CBD9XjUwyT35zf+ICEXNcvtWJGLe+PJ/RLj3ZBzoEgpJJuQS/4BrYudev
         jwCQ==
X-Gm-Message-State: APzg51BqboSwN9RJvjLFT+wLvnSjT/W2UaKp3xj73Euw7cnfZTlt5tVs
        1UwiUUvL855er1ro+Vm5dlzz9tnD
X-Google-Smtp-Source: ANB0VdbessyKGdLOW9zr34FwtekuQ3jYND3FJ3YBxXUC/0Ml0h96WG87pP6GfIFIiO4j9SF1WTqSGA==
X-Received: by 2002:adf:c751:: with SMTP id b17-v6mr20887241wrh.134.1537214122162;
        Mon, 17 Sep 2018 12:55:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d12-v6sm16142805wru.36.2018.09.17.12.55.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:55:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] t5551: compare sorted cookies files
References: <20180917191806.19958-1-t.gummerer@gmail.com>
Date:   Mon, 17 Sep 2018 12:55:21 -0700
In-Reply-To: <20180917191806.19958-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Mon, 17 Sep 2018 20:18:06 +0100")
Message-ID: <xmqqtvmn6gra.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> In t5551 we check that we save cookies correctly to a file when
> http.cookiefile and http.savecookies are set.  To do so we create an
> expect file that expects the cookies in a certain order.
>
> However after e2ef8d6fa ("cookies: support creation-time attribute for
> cookies", 2018-08-28) in curl.git (released in curl 7.61.1) that order
> changed.
>
> We document the file format as "Netscape/Mozilla cookie file
> format (see curl(1))", so any format produced by libcurl should be
> fine here.  Sort the files, to be agnostic to the order of the
> cookies, and make the test pass with both curl versions > 7.61.1 and
> earlier curl versions.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---

Thanks.  f5b2c9c9 ("t5551-http-fetch-smart.sh: sort cookies before
comparing", 2018-09-07) that came from

    https://public-inbox.org/git/20180907232205.31328-1-tmz@pobox.com

has almost the identical patch text, and this (presumably an
independent effort) confirms that the patch is needed.  The other
effort implicitly depends on the expected output is kept sorted, but
this one is more explicit---I tend to prefer this approach as tools
and automation is easier to maintain than having to remember that
the source must be sorted.

Thanks.

>  t/t5551-http-fetch-smart.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 771f36f9ff..d13b993201 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -206,7 +206,7 @@ test_expect_success 'dumb clone via http-backend respects namespace' '
>  cat >cookies.txt <<EOF
>  127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
>  EOF
> -cat >expect_cookies.txt <<EOF
> +cat <<EOF | sort >expect_cookies.txt
>  
>  127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
>  127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
> @@ -215,7 +215,7 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
>  	git config http.cookiefile cookies.txt &&
>  	git config http.savecookies true &&
>  	git ls-remote $HTTPD_URL/smart_cookies/repo.git master &&
> -	tail -3 cookies.txt >cookies_tail.txt &&
> +	tail -3 cookies.txt | sort >cookies_tail.txt &&
>  	test_cmp expect_cookies.txt cookies_tail.txt
>  '
