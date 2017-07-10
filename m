Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8C220357
	for <e@80x24.org>; Mon, 10 Jul 2017 19:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754648AbdGJTvX (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jul 2017 15:51:23 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35770 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754619AbdGJTvW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2017 15:51:22 -0400
Received: by mail-pg0-f68.google.com with SMTP id d193so13898589pgc.2
        for <git@vger.kernel.org>; Mon, 10 Jul 2017 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PDYC1Dpy2YMFwUjXTNMTvw1HK1sozwa7rjE+U7D3BDg=;
        b=FgkxAMQ4AZtv+7qBZKI6HPfuGgWOnh1MBzj7acszKWTBwX5Bk5ksMS2qosdMkJv5X0
         uAOWRDckKKn+tq1xhemVZtHpkJOh4KdodNEg6Kd33ey9z7UcWJxiF8VwCoaVayE6QRjT
         y2yeUTNrK1DSk5Fg9h+nKoGARmIeb/n634sPfy2EKzH06zco6w1K+LqDpAkFME1kY3Iv
         UJTm+tjX8bFfKdzSL4YhN/GCohmHeW19tVHjr/Q4jkahWoUL4EtMLiepASKUabS1FV2e
         R6/uMO2Ap4IjT17RLzfWbRO4j0ilxmkTaJmVMGpCq2NQXDtB6aR81kPQXp+B3anWG/TK
         7FoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PDYC1Dpy2YMFwUjXTNMTvw1HK1sozwa7rjE+U7D3BDg=;
        b=gUx2b6JXXWZdZDNfo8VzAHLje1A5yJ0zm+vMh2sl5T09ZL8QqhN7ULh2SHGOZRFK20
         OFr/KmBiJ+lhM7y+W0pXlln2EH6flK/AsdNpwMMNirjChuzLkklee+sYiSGJ6nfcXGHS
         9nQ+5w+iMXpA2d8LZ/dDZKzeiZ/oyqmb8hYhmi1MpXrdWD3aEomsk1C6rY7wO9EJg512
         2cZ+7Z8Xbkhf1B1kbSUB7CGGK3S3eO/aqaqiqsQw3arK1tDNOUwf7RjiLT2owYn+tnTV
         D//3yumtPCOYSHzbvq/lexfHwx+pZdONgib/Z0N8ZbfRZT+eV1QSM7gfGufRt5cK6sSA
         HA5g==
X-Gm-Message-State: AIVw111JcqYbwOqJqveVJZj1nJ783wMj5NnruF/CTm2ivWCqi7jEU1Sd
        YF3GJfoojxaXdw==
X-Received: by 10.99.228.69 with SMTP id i5mr16142873pgk.192.1499716281681;
        Mon, 10 Jul 2017 12:51:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:79e6:b06d:25fb:addc])
        by smtp.gmail.com with ESMTPSA id k29sm20644634pfb.119.2017.07.10.12.51.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Jul 2017 12:51:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] hook: name the positional variables
References: <xmqqinj4ayqb.fsf@gitster.mtv.corp.google.com>
        <20170710141744.8541-1-kaarticsivaraam91196@gmail.com>
        <20170710141744.8541-2-kaarticsivaraam91196@gmail.com>
Date:   Mon, 10 Jul 2017 12:51:20 -0700
In-Reply-To: <20170710141744.8541-2-kaarticsivaraam91196@gmail.com> (Kaartic
        Sivaraam's message of "Mon, 10 Jul 2017 19:47:42 +0530")
Message-ID: <xmqqk23g5avb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> It's always nice to have named variables instead of
> positional variables as they communicate their purpose
> well.
>
> Appropriately name the positional variables of the hook
> to make it easier to see what's going on.
>
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---

Makes sense.  Thanks.
