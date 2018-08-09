Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94231F405
	for <e@80x24.org>; Thu,  9 Aug 2018 21:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeHJALH (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 20:11:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40659 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbeHJALH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 20:11:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so6424502wrs.7
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=E/DXg6eEPloEt0mPsa3y20wkVgAEM88vP7M63Pivn/g=;
        b=P3ohJMs5GWu4mqa1rWW76BVcazftuRMXdN/8Flo5h98uggJmyBg1xWq9Ok99mZu/DQ
         3hWjLizrNWLJMnOhgR9mayXuAJhmeayCYCcsXkAZeoAPTsCCZv4pyTtdPv0reC/OI2m7
         8bt5+Cf339L4cOGbWGkgcaSs7zOd75l7+RplGNR3vFGuOWBWTN239N7UQi49kXDpQ38k
         xIiMxjUEZQUGwx+/8iPiIIs2zCra2Rve5d6wvyQE2OBvcPU4W7vq/nGaUjzZybbiMENp
         byEDWkgMSlDbma6WWb5a+1EHPlOZCPFs84/KG3HQsTN8HzTnPqokhl9oSySc5254izUx
         udww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=E/DXg6eEPloEt0mPsa3y20wkVgAEM88vP7M63Pivn/g=;
        b=iJYjuyUikgE5iDjhi0A2jcbaSlN0CVK2wRaXLYjbSW6LYu3ToS/ppDkaRolnZMSeSX
         1rKxZdA06mTKn0HSnchuxXsHh0Fzx8oVKKLdUw4brjwLiHW0RzcJ/Nep3g4Z1iGYQxEl
         wt2a+OQT3AF0p4T57zt31Q15gUkARUS1eWEl2b3vubBz8nbcQUDh4mQdGv1o6cbkn4kq
         ew/sjZo6UL3L8i44eAdaRbnvmPzIki+ZwnsiUneJbsJ/OKKR4bCC9BnOl9qnKsfEM3j5
         nTSoOU3omOaEcJk5NIhdM//8+THdRUlEe/PM+kbtmqfLxISe9sYF89YJZbhNgmi+NkOB
         GM4g==
X-Gm-Message-State: AOUpUlEexBbtzKoNJOqdofGsVwfdDgYw7+OdwOpZCmAJCjFeZCXCkYEV
        O25Do55y48x8RpFdBaUBccg=
X-Google-Smtp-Source: AA+uWPwwfy1ZzJOanX6EKi+HhvmFpvfXk0Cm+xgpJosX04P0ewbUvkXp33Sqy2gYiKMVLGjRLd9aUA==
X-Received: by 2002:a5d:5385:: with SMTP id d5-v6mr2427127wrv.151.1533851061379;
        Thu, 09 Aug 2018 14:44:21 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 200-v6sm15928092wmv.6.2018.08.09.14.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 14:44:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, hvoigt@hvoigt.net
Subject: Re: [PATCH 03/10] sha1-array: provide oid_array_remove_if
References: <20180808221752.195419-1-sbeller@google.com>
        <20180808221752.195419-4-sbeller@google.com>
Date:   Thu, 09 Aug 2018 14:44:20 -0700
In-Reply-To: <20180808221752.195419-4-sbeller@google.com> (Stefan Beller's
        message of "Wed, 8 Aug 2018 15:17:45 -0700")
Message-ID: <xmqqsh3n9pvv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  sha1-array.c | 39 +++++++++++++++++++++++++++++++++++++++
>  sha1-array.h |  3 +++
>  2 files changed, 42 insertions(+)
>
> diff --git a/sha1-array.c b/sha1-array.c
> index 265941fbf40..10eb08b425e 100644
> --- a/sha1-array.c
> +++ b/sha1-array.c
> @@ -77,3 +77,42 @@ int oid_array_for_each_unique(struct oid_array *array,
>  	}
>  	return 0;
>  }
> +
> +int oid_array_remove_if(struct oid_array *array,
> +			for_each_oid_fn fn,
> +			void *data)
> +{
> +	int i, j;
> +	char *to_remove = xcalloc(array->nr, sizeof(char));
> +
> +	/* No oid_array_sort() here! See the api-oid-array.txt docs! */
> +
> +	for (i = 0; i < array->nr; i++) {
> +		int ret = fn(array->oid + i, data);
> +		if (ret)
> +			to_remove[i] = 1;
> +	}

Doing the same without this secondary array and loop, i.e.

	for (src = dst = 0; src < array->nr; src++) {
		if (!fn(&array->oid[src], cbdata)) {
			if (dst < src)
				oidcpy(&array->oid[dst], &array->oid[src]);
			dst++;
		}
	}
        array->nr = dst;

would be no less efficient.  The only reason why you might want to
measure move-span by a secondary array and preliminary counting loop
like your version does is that moving contiguous area of memory may
be more efficient than moving only by a single oid sized chunks, but
as far as I can tell you are not doing that "optimization", either.

I doubt that remove_if() is particularly a good name.  A version of
this function, for which polarity of fn() is reversed, can be called
"grep", or "filter", I think, and would be more understandable.

