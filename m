Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21EE01FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 14:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934642AbdDFOT1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 10:19:27 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34569 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934375AbdDFOT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 10:19:26 -0400
Received: by mail-wr0-f193.google.com with SMTP id u18so3825045wrc.1
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 07:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=60T0BBVxhj/2qFvhVeLdwFbOE/xZmQaQFBAXwDfgyFs=;
        b=YpDlBqBuQPoTaoviMAmu5UdF2EMi6F0HJITWhEjeAm0O7zxWKC844EEpBI3aS+rqH6
         dPkBNRZEla+mIoyusPWE2CdxX5l/VTpY54CN6GVH7BO7b2f/hJBt0ai+Q5yOlM2Zzjxi
         QoIsI8+s0Jo6t7OQ8oIAsgLR6IcUKvRTyfgVRBtr7WrahJIvY4YOtRqiPR0s4t0JF+Nv
         gJU6be9LKeQ3VHvVpHpJW0Jvsa8h0wke1FzcEHTEOIZruy+r5xJDFQQSOp3pd9QCxACI
         Hor4lxQdyFP9rppJqyLR9mI/Mro1wK/4Ue7JDObAkJ2Y2DQFDd+OZv/GVl4W7XC0idWD
         gpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=60T0BBVxhj/2qFvhVeLdwFbOE/xZmQaQFBAXwDfgyFs=;
        b=fY5LgOYCdnwzADtiAj3vapyYJRrE7cYar16DMtcxPOrjFrgjIaWdAlGx5SgkujgpXH
         v7Nw3Dh7YOprUkGMAxqLzr2ke82hAoRoEbsPSRG+reDbuH2MKqYNLrvfwVQulQmeeI6p
         //wGpqiEDlVLEizrK/6xw1ykwpzus8ou738ODBckcEQzl6hGz+fMtWfIuOlqf/wNyE1C
         ELmX5X7+8wazwxsCtKnVH76Sj9bTk0d4g09soHAnJbbHBv6U4OEtMGZeDHk6tGFFyYvN
         oA/N+neoCl8jCmfr8kzKUaS7KkgoWMxB992mZx17f4rWUNRdDtGoiW3wLkYwuk4dF/Hy
         efyA==
X-Gm-Message-State: AFeK/H1wlhhDBiuGPm4ykzW1fKxRgRWZhXdts6hj3mITQEJB+PazTtfH
        bXv4WM8ikYvTt9rC
X-Received: by 10.28.86.130 with SMTP id k124mr24025095wmb.58.1491488364708;
        Thu, 06 Apr 2017 07:19:24 -0700 (PDT)
Received: from localhost.localdomain (x590e1a8d.dyn.telefonica.de. [89.14.26.141])
        by smtp.gmail.com with ESMTPSA id c7sm2335112wrc.20.2017.04.06.07.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Apr 2017 07:19:24 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@jeffhostetler.com
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 2/4] read-cache: add strcmp_offset function
Date:   Thu,  6 Apr 2017 16:19:12 +0200
Message-Id: <20170406141912.14536-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
In-Reply-To: <20170405173809.3098-3-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Add strcmp_offset() function to also return the offset of the
> first change.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  cache.h      |  1 +
>  read-cache.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/cache.h b/cache.h
> index 80b6372..4d82490 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -574,6 +574,7 @@ extern int write_locked_index(struct index_state *, struct lock_file *lock, unsi
>  extern int discard_index(struct index_state *);
>  extern int unmerged_index(const struct index_state *);
>  extern int verify_path(const char *path);
> +extern int strcmp_offset(const char *s1_in, const char *s2_in, int *first_change);
>  extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
>  extern void adjust_dirname_case(struct index_state *istate, char *name);
>  extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
> diff --git a/read-cache.c b/read-cache.c
> index 9054369..b3fc77d 100644
> --- a/read-cache.c
> +++ b/read-cache.c

read-cache.c is probably not the best place for such a general string
utility function, though I'm not sure where its most apropriate place
would be.

> @@ -887,6 +887,35 @@ static int has_file_name(struct index_state *istate,
>  	return retval;
>  }
>  
> +
> +/*
> + * Like strcmp(), but also return the offset of the first change.

This comment doesn't tell us what will happen with the offset
parameter if it is NULL or if the two strings are equal.  I don't
really care about the safety check for NULL: a callsite not interested
in the offset should just call strcmp() instead.  I'm fine either way.
However, setting it to 0 when the strings are equal doesn't seem quite
right, does it.

> + */
> +int strcmp_offset(const char *s1_in, const char *s2_in, int *first_change)
> +{
> +	const unsigned char *s1 = (const unsigned char *)s1_in;
> +	const unsigned char *s2 = (const unsigned char *)s2_in;
> +	int diff = 0;
> +	int k;
> +
> +	*first_change = 0;
> +	for (k=0; s1[k]; k++)
> +		if ((diff = (s1[k] - s2[k])))
> +			goto found_it;
> +	if (!s2[k])
> +		return 0;
> +	diff = -1;
> +
> +found_it:
> +	*first_change = k;
> +	if (diff > 0)
> +		return 1;
> +	else if (diff < 0)
> +		return -1;
> +	else
> +		return 0;
> +}

The implementation seems to me a bit long-winded, with more
conditional statements than necessary.  How about something like this
instead?  Much shorter, no goto and only half the number of
conditionals to reason about, leaves *first_change untouched when the
two strings are equal, and deals with it being NULL.

int strcmp_offset(const char *s1, const char *s2, int *first_change)
{
	int k;

	for (k = 0; s1[k] == s2[k]; k++)
		if (s1[k] == '\0')
			return 0;

	if (first_change)
		*first_change = k;
	return ((unsigned char *)s1)[k] - ((unsigned char *)s2)[k];
}

