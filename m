Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1F9B1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 23:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932272AbdDFXIL (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 19:08:11 -0400
Received: from mout.web.de ([212.227.15.14]:53533 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753035AbdDFXIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 19:08:09 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MgOUY-1chMoE26De-00NexM; Fri, 07
 Apr 2017 01:07:40 +0200
Subject: Re: [PATCH v6 1/3] read-cache: add strcmp_offset function
To:     git@jeffhostetler.com, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20170406163442.36463-1-git@jeffhostetler.com>
 <20170406163442.36463-2-git@jeffhostetler.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <97be34a6-ecdb-9820-1315-4cb5ed3b9101@web.de>
Date:   Fri, 7 Apr 2017 01:07:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <20170406163442.36463-2-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:k7VEdu7KhouIfOhZxm4Qo/C3SouZYxhi8QTNJ9cos1tRR+0OVj/
 UoTMdTobGTr3ayoN9YkkmxbpNS6/3zkvjYCZDqWeDyzRvJ6kJHxoUI1lMjA+iJe7CbVC5KI
 kVEhP4bPZ89MN5UU0yqvCB1nAvf02UQtry12fGmz249sOE7y/CM6zXDvOdY/J52xt6xXilq
 uOoF71XjIKrxK+M1yE6KQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aAkRcCixzPQ=:EaAdgvN/AqU4YVAwcWOSrX
 Ve07Q4OzE0bugThoL9UV4lCyqJoMuWZM1fkSXZ+ddfjDnz0Q308ly+0QaM+mFgA2vhRJa1yt0
 3jNvJ+r7eU0NrtSHAvWe/q1MXGHTu0AcQKUACZ8A9EYVtnj4J7VXoALtsDPRkqeaO0knWMVeO
 c4aiJ7biyWyrLbYaSI6OnamZQoi01oxBvH3ufxZoHD325HHllcJf6XBzeu4rLtW612ENBAp6+
 wmZ+W/3E0qZIKXANRHdpTv7DlRZSFGH4CE36ci4lR5RhzOJIJt/QVsncun9blPog/aofAA896
 WILhuOVmgKzP7VYmZDeCkUI1lTkycrhU9EKl4/A8VMAqTVtyDznHtoGZD0zHFWQACYKHnkGAK
 ygoZHtHoM0FHikjKyGt8DkVMom+TWUVh+HGqSZaQnpvasBGUmMomlQkoaM3YpddkoT8NeiTi2
 vA65xYlDk3sLToGeemxBIuzXNuzJIhzPHoyHVCG8hKwNIflF9ZcorRM5B/J6e9qylJaJj2HNH
 HxHvx/ibID1xz4kageOKITUNbs5j7ORIwfQCgvk6ykeoZR8GJ8qPJA81hZd7YsQTQ2Ka/pvCL
 EPvap2o8PpXxEH1WqOIxYNrDoXCitAW1t0WtQEfdQhBcxXZyK3gCsFjIHmKHo5zNqb0NE8d86
 mH5LJmZ36uYNYbgVsGLCO30kooOM7AaugxIfa8RuROGzrCs2WXmaVV7NyMWNfXBXu40fSQaez
 kPIQrvSnpNcNWXVHLzpQBanmy07DLZPZxfS0ng3ufFQi/fQNPkqFKxdzSAgmY36NG4RTkzu14
 tYLT2gH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.04.2017 um 18:34 schrieb git@jeffhostetler.com:
> diff --git a/read-cache.c b/read-cache.c
> index 9054369..e8f1900 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -887,6 +887,26 @@ static int has_file_name(struct index_state *istate,
>   	return retval;
>   }
>   
> +
> +/*
> + * Like strcmp(), but also return the offset of the first change.
> + * If strings are equal, return the length.
> + */
> +int strcmp_offset(const char *s1, const char *s2, int *first_change)
> +{
> +	int k;
> +
> +	if (!first_change)
> +		return strcmp(s1, s2);
> +
> +	for (k = 0; s1[k] == s2[k]; k++)
> +		if (s1[k] == '\0')
> +			break;
> +
> +	*first_change = k;
> +	return ((unsigned char *)s1)[k] - ((unsigned char *)s2)[k];
> +}

I like how this is shaping up to become a reusable function, but I only 
found one other possible use case (in read-cache.c::ce_write_entry), 
which somehow irritates me.  Either I didn't look hard enough (likely), 
we haven't got fitting code just yet, or this function isn't meant to be 
exported -- in the latter case its interface doesn't have to be polished 
as much.  (Just a thought, don't let me stop you.)

Assuming strcmp_offset() is a library-grade function then its 
first_change parameter should point to a size_t instead of an int, no?

Casting away the const qualifier in the return line is a bit iffy.  Why 
not cast after dereferencing, like this?

	return (unsigned char)s1[k] - (unsigned char)s2[k];

René
