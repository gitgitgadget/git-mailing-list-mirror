Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B105F2023F
	for <e@80x24.org>; Thu,  3 May 2018 18:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeECSpf (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 14:45:35 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41093 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeECSpe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 14:45:34 -0400
Received: by mail-wr0-f193.google.com with SMTP id g21-v6so18629882wrb.8
        for <git@vger.kernel.org>; Thu, 03 May 2018 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Rq/S5bcLinTgwXWCwY6rnEXOOAWljy5MrRVOeqElL9g=;
        b=k9IbUGoOj9yrwErpPNx+h+CidAHosMJ2Crt1WG5Dq0QfVn6olv1KYlVVDWqAYac1S8
         PX8kBPUxNV5SyVn2tz29dpK7ENZUXNnF26TLDUC3TkYB2CFenf3nECO0ZgHT3SDPlpGh
         tYEl0zrAxcA/Y4P4smOaA8pwmxqrW8jS985xIfDwjpFJLuLykM5EuHoPyLNLxGCSDFtX
         N70ktBCNy8Ck/UWT53klHzbHjIJLLPWpHmnrFmW8mvNeFX1vXC1KQCohybfEbHHYtHSd
         Tft6zGAi54Rvw5JQVlPpM+nLxcxH0ECSP332vWcBSOSiuTZKNAD+2MDt3+zP4BNdmsmz
         YsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=Rq/S5bcLinTgwXWCwY6rnEXOOAWljy5MrRVOeqElL9g=;
        b=FIxS0dZCtWpM2FaMigTG0G68t9RqpNFXabZ/RHh2dH+56NP8xRGMfXFuS+it6s1nme
         X8qiPE+vq9r+C3xq3epMIajDr3747og0b+wh7COOpEL2Y7mvJ6nCbjK8eMQgXw6E59bw
         8oixANCiLH2rieHgrxWn4PrG46cKGYJVG5DrzHPisV1WcVf7/iP2BevHeaoL5qleJvZP
         vTJAoYwl+YIecH23WDksT+W4/qRBiWM/w6kAUhN4QsZlF4AeGMjol0eB92lIpSV5mJTd
         R/gkShnWtcxaAg+VMH0sXlHut4QkOQLAUhHnFoTGafMjH9aqhE1KBTVc4/sXgevqwr9h
         QEvg==
X-Gm-Message-State: ALQs6tDL4HoESYwMAhvdO/c1dklycF/14GQQY0VcCl5dVXjf7QfbX3OR
        ZzGbCnHTrSLzhq7mKe2+zzA=
X-Google-Smtp-Source: AB8JxZr6u+J6DWuRS9hHFjau4dBstXo093jyCmJIW6ilZrdG4jo+PFVpJxfsVtjsgJCW7kxjydJCbA==
X-Received: by 2002:adf:83a2:: with SMTP id 31-v6mr19079664wre.19.1525373132988;
        Thu, 03 May 2018 11:45:32 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (egn45.neoplus.adsl.tpnet.pl. [83.21.77.45])
        by smtp.gmail.com with ESMTPSA id t203-v6sm171157wmt.33.2018.05.03.11.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 May 2018 11:45:31 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v5 09/11] commit: use generation number in remove_redundant()
References: <20180425143735.240183-1-dstolee@microsoft.com>
        <20180501124652.155781-1-dstolee@microsoft.com>
        <20180501124652.155781-10-dstolee@microsoft.com>
Date:   Thu, 03 May 2018 20:45:27 +0200
In-Reply-To: <20180501124652.155781-10-dstolee@microsoft.com> (Derrick
        Stolee's message of "Tue, 1 May 2018 12:47:21 +0000")
Message-ID: <867eokzigo.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> The static remove_redundant() method is used to filter a list
> of commits by removing those that are reachable from another
> commit in the list. This is used to remove all possible merge-
> bases except a maximal, mutually independent set.
>
> To determine these commits are independent, we use a number of
> paint_down_to_common() walks and use the PARENT1, PARENT2 flags
> to determine reachability. Since we only care about reachability
> and not the full set of merge-bases between 'one' and 'twos', we
> can use the 'min_generation' parameter to short-circuit the walk.
>
> When no commit-graph exists, there is no change in behavior.
>
> For a copy of the Linux repository, we measured the following
> performance improvements:
>
> git merge-base v3.3 v4.5
>
> Before: 234 ms
>  After: 208 ms
>  Rel %: -11%
>
> git merge-base v4.3 v4.5
>
> Before: 102 ms
>  After:  83 ms
>  Rel %: -19%
>
> The experiments above were chosen to demonstrate that we are
> improving the filtering of the merge-base set. In the first
> example, more time is spent walking the history to find the
> set of merge bases before the remove_redundant() call. The
> starting commits are closer together in the second example,
> therefore more time is spent in remove_redundant(). The relative
> change in performance differs as expected.
>
> Reported-by: Jakub Narebski <jnareb@gmail.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Good description.

> ---
>  commit.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>

Let me extend context a bit to make it easier to review.

> diff --git a/commit.c b/commit.c
> index 9875feec01..5064db4e61 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -949,6 +949,7 @@ static int remove_redundant(struct commit **array, in=
t cnt)
>  		parse_commit(array[i]);
>  	for (i =3D 0; i < cnt; i++) {
>  		struct commit_list *common;
> +		uint32_t min_generation =3D GENERATION_NUMBER_INFINITY;

As you have noticed, and how it is already fixed in 'pu' it should be

  +		uint32_t min_generation =3D array[i]->generation;

>=20=20
>  		if (redundant[i])
>  			continue;
> @@ -957,8 +958,12 @@ static int remove_redundant(struct commit **array, i=
nt cnt)
>  				continue;
>  			filled_index[filled] =3D j;
>  			work[filled++] =3D array[j];
> +
> +			if (array[j]->generation < min_generation)
> +				min_generation =3D array[j]->generation;

remove_redundant() checks if i-th commit is reachable from commits
i+1..cnt, and vice versa - via checking PARENT1 and PARENT2 flag,
respectively.

As you have noticed this means that the min_generation cutoff should be
minimum of array[i]->generation, and all of array[j]->generation for
j=3Di+1..cnt.  There is no reason going further down if we are interested
only in reachability, and not actually in merge bases.

>  		}
> -		common =3D paint_down_to_common(array[i], filled, work, 0);
> +		common =3D paint_down_to_common(array[i], filled, work,
> +					      min_generation);
>  		if (array[i]->object.flags & PARENT2)
>  			redundant[i] =3D 1;
>  		for (j =3D 0; j < filled; j++)
   			if (work[j]->object.flags & PARENT1)
   				redundant[filled_index[j]] =3D 1;

Beside this issue, nice and simple speedup.  Good.

Best,
--=20
Jakub Nar=C4=99bski
