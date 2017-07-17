Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FF6520834
	for <e@80x24.org>; Mon, 17 Jul 2017 17:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbdGQRK3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 13:10:29 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33918 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdGQRK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 13:10:27 -0400
Received: by mail-pf0-f172.google.com with SMTP id q85so79391496pfq.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 10:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cApApxJkpMjBLOaDq2VTPFomPahH8KbAAdwR1Adj+FI=;
        b=Zv3y1FIWBpyy8KVNdlXF6bvgSSO+JyuIGAHUqt3bRM3QWrGWV9UH9mOkswZjE/WZY3
         0tBD2hQK1bTwHBJ3wgUjAhMmMhWMtX2w5xFAGGGnb8nMVFns5xbl6yRV9aGVXkp+AgIl
         aeJOmgPcyVpDIROyCjA1nQhZXDZHnv3RCZpKTBOl8SzNu3akcqWmvKkyfJYvrTKbelmT
         oVj048iZJoliHT8auW2CpQGETmiJhwtF/AZOZzpLdPPBAlVdC0oiPqLB/CVsn9DzyN5h
         jWGVutJ6yN3K9EO4a6ekisY0oMnFk321lo8jcHaY75g+bbh+izON53kxN0YclKtB4opv
         lGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cApApxJkpMjBLOaDq2VTPFomPahH8KbAAdwR1Adj+FI=;
        b=dBim60UEBgt15Ete1cQnN+JIYhXMEn5hsoOdbeYwrajcgsnJ+GErnjIshRaKDhN9nc
         YAyXexuXqIevBQ8Z++8zdFK98gG9uaITPQ6wkSWn/uIcY5s6UCcUzv4t4QRe7eKrDaQo
         eGhF6r9BKZrO9JzedUSdSb8yY8Mi6luA+GdMYyXyPc4/3p50FjnrJam0jsypqCsw6zmq
         gJIafVX1DVbhuP8sWzByx3CkxSTjsXoo2SD+mmmctMESIMqGKslMHVYnATQR5jLY6JAC
         j/ZCKAySteoBgmemrfd+IsuxARMmGYOtJTq0vTk+oof0vTEfKASQjdyN/o+QGrCyBCZg
         atcA==
X-Gm-Message-State: AIVw1118wCHl+okYMmEC3rLiKEUS1JDMI5isyEz5QpBsAt8lryKyJU71
        ioQEmM9vxp03WA==
X-Received: by 10.99.176.71 with SMTP id z7mr29153260pgo.78.1500311426365;
        Mon, 17 Jul 2017 10:10:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:480d:579b:4a3b:27f3])
        by smtp.gmail.com with ESMTPSA id c82sm38561018pfd.5.2017.07.17.10.10.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 10:10:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] PRItime: wrap PRItime for better l10n compatibility
References: <249ac6f8-af3c-4b20-5bf0-87a82866cc7a@free.fr>
        <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
Date:   Mon, 17 Jul 2017 10:10:24 -0700
In-Reply-To: <3ccfa2fb49d471f807d77d9a280e4b7cfe56faea.1500304209.git.worldhello.net@gmail.com>
        (Jiang Xin's message of "Mon, 17 Jul 2017 23:23:43 +0800")
Message-ID: <xmqq7ez7htvj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Commit cb71f8bdb5 ("PRItime: introduce a new "printf format" for
> timestamps", 2017-04-21) does not play well with i18n framework. The
> static string concatenation cannot be correctly interpreted by
> gettext utilities, such as xgettext.
>
> Wrap PRItime in format_raw_time() function, so that we can extract
> correct l10n messages into "po/git.pot".
>
> Reported-by: Jean-Noël Avila <jn.avila@free.fr>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ...
> @@ -191,6 +200,15 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
>  	return &mode;
>  }
>  
> +const char *format_raw_time(timestamp_t time)
> +{
> +	static struct strbuf time_buf = STRBUF_INIT;
> +
> +	strbuf_reset(&time_buf);
> +	strbuf_addf(&time_buf, "%"PRItime, time);
> +	return time_buf.buf;
> +}

Hmm.

Two potential issues are:

 - After this patch, there still are quite a many 

	printf("time is %"PRItime" ...\n", timestamp)

   so the burden on the programmers having to remember when it is
   required to use format_raw_time() becomes unclear, and makes the
   change/churn larger when an existing message needs to be marked
   for translation.

 - The static struct strbuf here is a cheap way to avoid leaks, but
   at the same time it is unfriendly to threaded code.  We could
   instead do:

        void append_PRItime(struct strbuf *buf, timestamp_t time);

   to fix that trivially, but the damage to the caller obviously is
   much larger going this way.

