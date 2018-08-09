Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020911F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeHIXnS (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 19:43:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56160 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeHIXnS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 19:43:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so1580686wmc.5
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/ew/Ac+4mRfm8OFUuqLXFGscEvx43l66ZscQvXIDCQc=;
        b=psojQBCIQVO3DeZkLheXS+4aZqCzfEESxLdE6JS47LQq2VA+z/Lx48a9kOGSUlTfFO
         jHwrkiSlxJ3jV+cF9cswkR2tRXikvQBGADmRzFSiSm43LNYNCnxRTnv1jQlZzq5Tb5Cu
         tg5uDGhGZDlaJhmSFeDxEL9QnAJoLXbf2AJAX802y9cUZnujWSEad7Jxj2cdQODYnKpz
         MbrnBdqbxBmQriadnwggMr8Bm5R9OeAjCrclAnqZ6G6+7rPiq9bgl1s7R0zcBdgrcGQc
         aaM5dLS+8meNPfAftbXL/tI4t1WlGZXU0A3kO8Sz4XjmoKFPa79aBRORhIL8jYWxOz9P
         4vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/ew/Ac+4mRfm8OFUuqLXFGscEvx43l66ZscQvXIDCQc=;
        b=RjeWBXcHX5xBNPSKnjbFZ6rRIci8/U9+/KswZSjcgrHsgLnO2j97A5rEFWksaf3lRl
         zkKHzzgsxr+Ve7C4/AmtT+tzJghhk/8t2nCeHUYErdNIY8xQXtGBFWLS29aC376tp3k/
         RD9VRmkCazYv1J7j4ZbajRwb7zh/OnI1Ah+Z9GEbPqGZEw5lMpCMin5dTAOlh1lV/MxF
         7NS810wyT6eFbFTRc1u61pmSKo0D9ne9APY8+3bAmT0VBy9Iycm6hzEsiGiazCxc51LS
         8Yveom1mzKW9MlLn3xG1RalKJcHfZrM7T7heku7ovq2m5BES5g9ldt5kxJKJBSEQyIhy
         miCA==
X-Gm-Message-State: AOUpUlEkrrchaINqS0j4sIhT2A/A1R2HL23k751OyRt8oRRDQTnXpng+
        1mUdVzmfALbl/ipCERD6YdM=
X-Google-Smtp-Source: AA+uWPwV91jvDHeBaD9QUCqOkSYzCpBlDkszsT+EZu2Nkv9sbwTMJ1IWNL3fQvRE+Bv+0GrgLiGWPg==
X-Received: by 2002:a1c:6444:: with SMTP id y65-v6mr2429588wmb.98.1533849397091;
        Thu, 09 Aug 2018 14:16:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u127-v6sm2300735wmf.48.2018.08.09.14.16.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 14:16:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net
Subject: Re: [PATCH 01/10] string_list: print_string_list to use trace_printf
References: <20180808221752.195419-1-sbeller@google.com>
        <20180808221752.195419-2-sbeller@google.com>
Date:   Thu, 09 Aug 2018 14:16:36 -0700
In-Reply-To: <20180808221752.195419-2-sbeller@google.com> (Stefan Beller's
        message of "Wed, 8 Aug 2018 15:17:43 -0700")
Message-ID: <xmqq7ekzb5qj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> It is a debugging aid, so it should print to the debugging channel.

Who says?  In-tree code may say so, and I do not think any in-flight
topic up to 'pu' uses this to produce non-debugging output, but I do
not think it is healthy attitude to assume that you can take over an
existing function and change what it does unilaterally.

As there is no in-tree or in-flight user, I think it makes sense if
the proposed change were to rename it to trace_string_list().  If
there weren't any print_string_list() and we were adding a debugging
aid to use trace_printf() to dump these, that would be the name we
would use anyway.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  string-list.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/string-list.c b/string-list.c
> index 771c4550980..9f651bb4294 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -200,9 +200,9 @@ void print_string_list(const struct string_list *p, const char *text)
>  {
>  	int i;
>  	if ( text )
> -		printf("%s\n", text);
> +		trace_printf("%s\n", text);
>  	for (i = 0; i < p->nr; i++)
> -		printf("%s:%p\n", p->items[i].string, p->items[i].util);
> +		trace_printf("%s:%p\n", p->items[i].string, p->items[i].util);
>  }
>  
>  struct string_list_item *string_list_append_nodup(struct string_list *list,
