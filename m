Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990341F463
	for <e@80x24.org>; Fri, 20 Sep 2019 16:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfITQhp (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 12:37:45 -0400
Received: from mout.web.de ([212.227.15.14]:34291 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfITQhp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 12:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568997462;
        bh=+SQ3rNfF1RAsY+QwQGcpvvUGbs9NKYMT/4NWiE6yZ8g=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=D+br0DdzXXP0xhox80yH/Je/5BOUEiO0qIFrE3Gq5oaWb1VSJ2/TgwvSOxpgLr/K9
         2xNu7T5ec7N8JFWMcpngh9glvsTC7thGKDguHmfAkVS90EV4k2Dzl7beoRSMqdsQ2K
         LGLfhqJOqEQF0zzdmyuh7y7B0d9lFsDlRswXk/WA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTPjb-1ib2JN0L0J-00SKuZ; Fri, 20
 Sep 2019 18:37:42 +0200
Subject: Re: [PATCH 04/15] name-rev: avoid unnecessary cast in name_ref()
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-5-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <2347ccf4-9843-5773-aa0a-9aee4a499194@web.de>
Date:   Fri, 20 Sep 2019 18:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-5-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HNjNIqXOvwpdn9t19Mee6N63u4g0AAyolMWJQUmDGlmu2CqFABl
 eHcACiWDPUI93b6O+OdFbDnBd9mi2NW8BFE+2+FOr61G/NHPtPb3IJUxAuA3wHg+NGR3lA1
 EV93uop9ZhUQqFdXgiFjEoiWaBWgjR/bNZtjtUbycqsZXcqZocC0GzB+kJrWaHiK5e3WXsL
 KoRT0EHEeG6rr27GsyH1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NVS74qM2uBk=:e5g7RPH9+rvErLb7mKXutb
 n+RihCtIuJ3NhoAygb1nWvwkjtiHGTkwn4ff3NIKVe2gbzC9hoLVHNprtf/XlCxpq+Q1meFpv
 LnRmKMydG/XJNwmvffY1PvyUMelj3um8qFYvbvZRd/IkDRcrxOpRKgw9gmj+Px+ehjp9J+qnZ
 CaCa/yBgN/3pHoLpBz7RQ/ZazDsDB3mO2pmSZWeebQc76arFl4QrvDCW8y+M5nMHK65illrjL
 eubzhU7HzLopfTqT/yabh6WoXI+Uz1Hsga+VOm3PXFUv5eQiwp9FaTB16RyZBlXUfkSDdRaP9
 vS6qZ0dpVu8e2PD2nmvZf0VSFzvw9q0VrWny5Kyw0+VDoEO02Sx8VOYymw49lLqoK78NsQBme
 WwrnmMSoSWhMrvBEisMtoULH6qd2L1gp0jsPNAmGPfagzHtdIIfiHT2AyaCkZvgJ0bKm649Es
 5jAqldn1AMAyr3o16turZw7Z2ZiZX6Ig9yUVM4gzXjVmDWUGLnfI8WT7XhHT3Wywc2wWvrdTT
 C6iwqQ9tgK/ArVEd4j/GlXzA12rck80wM3tNYtMdbz8g45lZNWlIw66HaHKodtZdIIu7ydeu4
 P+/GFejeJB3W3BUkBzvtGDMOuhEKaTf9maNiPvkvWTbePjj6TsOYHykNtFiE8GevDoUK6W+3m
 YMC+prTBLgvm6oWbYIGYK+YurtpJOjOqVC8zEn7iBJngjQ6LQ80g8c8A6tLILFVx/tTrQGQvL
 K8jpYFhF+2IOATa/zIfWe+Z1oISFSbC9F3WNEPYR7uozJaseyj760dFuwMuoWq+dnAHau7FfQ
 An8o17IGw6fuYc4/QtvFi2fFDsk8KAk7yCGMz3x1USuGeS0rrP5jH6V00ArZY8ZMeI0mZK4gk
 7xuGyqzglOIhcgM/lOtnxc/DL1dl6mRTowkJcIifxD1epwwgqEGs/EA9EM42iu3qFVljcWbQl
 ICpB9p2S8AQ8bonOoO3nziaaGkkUlh0Mt/GKcmkKRnQ3jSs0IVU7G5d0+mRg59Ys+0jbAq1zK
 K33eWUcqMpG3a2zoS7DmMpDHYkUU2UluAApeddq8caitVmEZQNZLjdPd3OY6WvemiL4e5vpgb
 HAzvRhBj3vab32z41L9p0MOadsvuSY0ZbE/Ytn1sfG8Ttl9588rhLAO1JvKLXIlSbAOFPu+Od
 F+Jcn4dPIBfLFHfOO9XdNw+cK87ks9uiiB/tDOf3ZUIcK9GdGxvsi2sFfzQVpRLi6QFW7IOC3
 7fpXsm6cFvDc5T04NMR8N1FloEnIGRpXNoAcQuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.09.19 um 23:46 schrieb SZEDER G=C3=A1bor:
> Casting a 'struct object' to 'struct commit' is unnecessary there,
> because it's already available in the local 'commit' variable.

That's true, but you can't see that only by reading your email.

>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/name-rev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index d345456656..e406ff8e17 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -268,7 +268,7 @@ static int name_ref(const char *path, const struct o=
bject_id *oid, int flags, vo

Here's the pertinent context line; --function-context would have been too
much, I think, but -U4 would have shown it:

		struct commit *commit =3D (struct commit *)o;
>  		int from_tag =3D starts_with(path, "refs/tags/");
>
>  		if (taggerdate =3D=3D TIME_MAX)
> -			taggerdate =3D ((struct commit *)o)->date;
> +			taggerdate =3D commit->date;
>  		path =3D name_ref_abbrev(path, can_abbreviate_output);
>  		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
>  			 from_tag, deref);
>
