Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DD7F1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeAXVp3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:45:29 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33111 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932474AbeAXVp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:45:28 -0500
Received: by mail-pg0-f66.google.com with SMTP id u1so3652974pgr.0
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 13:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9vjlcVU9cV0s6m76B4QFAvFb/u7X0Wj56JG3PpXsUwg=;
        b=X6ZPJknKeo94nGL3dM26dZp8BlzYCu73h+j8XsyGvFTTjAUxsk/+mED12fl+Bi3jph
         DpQ4ZWziO919HqynZcG/6L9fMkZqK0owq0CqfXfL6jdQFBK6niv4X74ldkFZiN3q07Lb
         A6h71TE1SODYUrVOEDH2yX4SXV+Co447c79Rrd17kly/tP3eNq66LSX0O30HnE3ZbIjY
         /aXGdOzBi/OeijY03T7dGgugf5kAGjBkJrhf7ggxXwGfKpMTkMk57m9jlycvNaHMBFFu
         rUxa7lSuABiBEkax5jeodtkv6vkIk9KDSiE5XGGv1tNn2Srk+v3+poENdJ/QK95fSjtH
         ieSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9vjlcVU9cV0s6m76B4QFAvFb/u7X0Wj56JG3PpXsUwg=;
        b=XdaKUKT+URBNs5KlqLQdryqqJHl+6QpywDDsXe6h8BZBpgCbzpzcOl7KUk6uZrUeog
         D3+nVv6tZp9fzk0gEmymwO6DOg0aM2zBqtgihZdscq0QDhayak9e70uJGhUcCUe4KJ+X
         ZsEnDRBWbyW8a3nLJF18Ckuh+zMZyUuhFK3fRshMlBvikglBacWPj9VrQqXI0rk1wY5r
         XoUwFNpFBlaedXUojK9NOTSGRWb1bbv7rdvMFXM8tiNU7vvjQIi5HsIuXdYjkU1Bi5XO
         q7vjVKVqSuXAyk0egj/I3Nz/OPOWR3SPyQMD6FoJnMj0do/1njj75cnzSBaV6LpWuYD8
         OjWg==
X-Gm-Message-State: AKwxytc/DX0XxQj9rPBd6GifrCtf57oQY5x/m7+c3Mq5P+cpFBFC0jVx
        U0iwAAXwJ1yn0zsbUK9OOMA=
X-Google-Smtp-Source: AH8x225XG5yTkQIkmbtudwCv+jTXaghxBjgjtANBGDY+I3tGLL65wco6ecHUsxumiM/SD5leRYt2uw==
X-Received: by 2002:a17:902:7283:: with SMTP id d3-v6mr7499341pll.163.1516830327887;
        Wed, 24 Jan 2018 13:45:27 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id p1sm1862054pgr.44.2018.01.24.13.45.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 13:45:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <randall.s.becker@rogers.com>, <git@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] Bring NonStop platform definitions up to date in git-compat-util.h
References: <20180121234203.13764-1-randall.s.becker@rogers.com>
        <20180121234203.13764-4-randall.s.becker@rogers.com>
        <xmqq1sifdmf3.fsf@gitster.mtv.corp.google.com>
        <001601d39554$e19d24c0$a4d76e40$@nexbridge.com>
        <xmqqzi53arda.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 24 Jan 2018 13:45:25 -0800
In-Reply-To: <xmqqzi53arda.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 24 Jan 2018 13:17:37 -0800")
Message-ID: <xmqqefmfaq2y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
>
>>> > +#ifdef __TANDEM
>>> > +#if !defined(_THREAD_SUPPORT_FUNCTIONS) &&
>>> !defined(_PUT_MODEL_)
>>> > +/* #include <floss.h(floss_read,floss_write,floss_fsync,floss_fork)>
>>> > +*/
>>> > +/* #include <floss.h(floss_fork)> */
>>> > +#endif
>>> 
>>> The above adds a conditional no-op?  That's confusing...
>>
>> We are trying to make PUT work with git on NonStop. I can't tell you how
>> much of a pain it is. This is a placeholder for others (outside our group)
>> to know where to muck. I can remove it if you don't want it there.
>
> It is OK as long as it was done on purpose.  I was just making sure
> that this was an unfinished WIP sent by mistake before proofreading.

Obviously, I was trying to make sure it was *NOT* an incomplete
state you did not intend to send ;-)

