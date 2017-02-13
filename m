Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B4A1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751374AbdBMXWB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:22:01 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:33500 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdBMXWA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:22:00 -0500
Received: by mail-it0-f66.google.com with SMTP id e137so1183183itc.0
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 15:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oImF+2z0vEBXva8PZpqbc5ZBIWNll4UkFrfOEnnStbI=;
        b=p6KEECtl8wee/jgeBMuwYYSl+Rvk1SWw6ZVvibC5uT0MZjQa/0Me/8SikD7JZ7W+Mn
         Z1kWrpRnln40ZPjQWhNVPZiwpyDA7EqJMBwhYy7hu3fvTQdOjBHTRrt3zQ9IuNQoir6o
         QgmjnPsv+jTynhcQ/iujVdEvMYatk0BTC/xmhVy8LuN/qGw2k62Y8/5hw7RDVg3hPFB/
         q78AfQ6o5XuD8eX+TFHNmd16C1UTOc4a4O4wJErX/MxkwuG19ryUDpxYKYqYAEsc8DML
         s5l9ZaAB2aNZiDH+0oFVRc0IjrnxIi8ATsevg1Sgv1hVe6ASNqVNLv/Xt6qLj9wThxPM
         FsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oImF+2z0vEBXva8PZpqbc5ZBIWNll4UkFrfOEnnStbI=;
        b=XKz8/BtNT3I4AhuZjSR9D2aD4ZXTSmKMl0QJY54DCBQBl/MBAq3HJMmrhfFnVq2jAb
         K2Nd786Dd1elmFMLJWbQTmnl3TCox4cDcZodpi3pBGdX5fRrapsldcy6+5cxdqPnbk/S
         3TkASAw1i7tIvZQnwy+lpBe/OMvJDbVawm6YYpgpNjdBhkHoX3cOml8DbSbMcSRjJ+7/
         p+kECKPMwGH2n/gG3XnXAT74OGOzQGxopf8KViecMJQ5aQDlFP+mQC068xO1mjBd4+BL
         dbvHplEQLMS6aSLEUm3HnE3Maa76rR8ZFXW6DXOOwpcgeV6bpajE6PUjRXUNhpUcdE1I
         RaIw==
X-Gm-Message-State: AMke39kfo3Yp7YmWYPL7tT7TwcEDRjfCVexk9OZ6rao56mjhz2lobEO8SIFKvsLacG8o5w==
X-Received: by 10.98.204.216 with SMTP id j85mr28560604pfk.130.1487028119337;
        Mon, 13 Feb 2017 15:21:59 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id f3sm22875536pfd.10.2017.02.13.15.21.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 15:21:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, peff@peff.net, pclouds@gmail.com
Subject: Re: [PATCH v6] gc: ignore old gc.log files
References: <20170210212822.14988-1-dturner@twosigma.com>
Date:   Mon, 13 Feb 2017 15:21:57 -0800
In-Reply-To: <20170210212822.14988-1-dturner@twosigma.com> (David Turner's
        message of "Fri, 10 Feb 2017 16:28:22 -0500")
Message-ID: <xmqqd1elbrsa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> +static unsigned long gc_log_expire_time;
> +static const char *gc_log_expire = "1.day.ago";

OK.

> @@ -113,6 +133,8 @@ static void gc_config(void)
>  	git_config_get_bool("gc.autodetach", &detach_auto);
>  	git_config_date_string("gc.pruneexpire", &prune_expire);
>  	git_config_date_string("gc.worktreepruneexpire", &prune_worktrees_expire);
> +	git_config_date_string("gc.logexpiry", &gc_log_expire);
> +

OK.

I think I had a stale one queued; will replace.

Thanks.
