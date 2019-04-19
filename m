Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4917820305
	for <e@80x24.org>; Fri, 19 Apr 2019 18:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfDSSh2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Apr 2019 14:37:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46752 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfDSSh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Apr 2019 14:37:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so7833474wrw.13
        for <git@vger.kernel.org>; Fri, 19 Apr 2019 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4BW0xrMEt3mgPi4sVO4bRykGtYVQEI2JQhkNs3WYUlM=;
        b=gRDy/X6SveVLO5aTB2UV0mpeum7eg/Kw8v9oNMfFCvuxSyWoimLNJ51HfxNzSKmn20
         VwMFpcjqfa9jIkDKW+GIA+BE33WLvPrBGb7PFxo97U+iXbMFN7NoYhe/P+TbbTcgyfZp
         K2iBc3uoFktUrN79ipqT2jOR+abwliNhdTjP0QfDP2tii8eWnxv91yXskhcRy1/iuIAy
         MfNZ23fpdMZjEGX3J/KunA4x34z5A5iaTKelRvzD0o/4Y8Rfdj1K14SLS2p2rYEXxYis
         pYMdE+caY0ydTHxoILx/d9R8YbGBauQNsjFO2l+mmlzcrAlSHA9S/kOQFeevsbn0rGw/
         EnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4BW0xrMEt3mgPi4sVO4bRykGtYVQEI2JQhkNs3WYUlM=;
        b=oOUO8sb4JmEI0RSs3s4SoV+PtGHXA8eSOv4YDLsO41M9Mm4Z1dSSEPVlviSZlCXsXV
         bF1SY9zGbOtHu6SLhE7pujfRBshm24QChcWOYwyq061icvS15+/xictscxjtw1oqrV5w
         Lz4lxKH+G76/j3pMPBe4+OacAgrmmlgCIJZDxSo0om5N+U5TFzdLAlkqO4XW64wnOEkk
         6oeg9gPzpMuFt1t+bYt6iDNZ3vv66H+dXejs7wlA9fyrwS5ioJYV1A53k1Ihh4wRdnAZ
         u9/xhoP/Z3g3olggYaMO0O1Nw/VGX0SL7vzxAv3wVcA31Cvzse4Axy4H4V7P7EWmjzkM
         aPGQ==
X-Gm-Message-State: APjAAAUwAd0BlbaNtMXPe63qcqJK1J1GbappSgn0oQmASWKiKLALSEiW
        Bo0hbwL+QCjGczVJFjNReo8kSPLZdfM=
X-Google-Smtp-Source: APXvYqyES0iOUtf04krECHu+V8dbxR+31RbDh1Q8Q4HJrNGYM8ngeln4poMEdp8J0RLFRg2J6ibV4A==
X-Received: by 2002:adf:fc8f:: with SMTP id g15mr103473wrr.113.1555650071062;
        Thu, 18 Apr 2019 22:01:11 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id v16sm3872984wru.76.2019.04.18.22.01.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 22:01:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "CHIGOT\, CLEMENT" <clement.chigot@atos.net>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: use fileno macro work around on AIX
References: <AM6PR02MB4950A1A625EEA54D4423C1BCEA260@AM6PR02MB4950.eurprd02.prod.outlook.com>
Date:   Fri, 19 Apr 2019 14:01:10 +0900
In-Reply-To: <AM6PR02MB4950A1A625EEA54D4423C1BCEA260@AM6PR02MB4950.eurprd02.prod.outlook.com>
        (CLEMENT CHIGOT's message of "Thu, 18 Apr 2019 08:55:09 +0000")
Message-ID: <xmqqimvaegh5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"CHIGOT, CLEMENT" <clement.chigot@atos.net> writes:

> Declare FILENO_IS_A_MACRO on AIX
>
> On AIX, fileno(fp) is a macro and need to use the work around already made for BSD's. 
>
> Signed-off-by: Clément Chigot <clement.chigot@atos.net>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)

I do not have an AIX box, so I'll take this as-is.

Thanks.


>
> diff --git a/config.mak.uname b/config.mak.uname
> index 41e85fab1c..86cbe47627 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -269,6 +269,7 @@ ifeq ($(uname_S),AIX)
>  	INTERNAL_QSORT = UnfortunatelyYes
>  	NEEDS_LIBICONV = YesPlease
>  	BASIC_CFLAGS += -D_LARGE_FILES
> +	FILENO_IS_A_MACRO = UnfortunatelyYes
>  	ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
>  		NO_PTHREADS = YesPlease
>  	else
