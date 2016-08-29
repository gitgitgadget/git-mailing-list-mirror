Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953741F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 10:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756663AbcH2Kue (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 06:50:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:61198 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbcH2Kud (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 06:50:33 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lk7T8-1b81K91meY-00cAXQ; Mon, 29 Aug 2016 12:50:07
 +0200
Date:   Mon, 29 Aug 2016 12:50:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/20] cache: convert struct cache_entry to use struct
 object_id
In-Reply-To: <20160828232757.373278-2-sandals@crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.1608291249230.129229@virtualbox>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net> <20160828232757.373278-2-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3dy7taXGmW6em+1P/YoXSrYed8JNE/y+bIW+GdnWToxrjY9+Ezg
 +Bp45+eurHL+AGOuAqSRI/YoCYeZlWbgCnDDdhK5rHHKSlmYGEUnsSc10p4V3UoscCK9Iuk
 FlXkv7c1oyHQzBxZB7BnfcVpeEfTJbGRADj9B9ZzzM9sGihKopo0t+vvsd3pishNMeKNWw1
 gGXLJEb6WsrAYQL9M6rLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b1yU/MRetsQ=:pcvfRPpBi7QOO16smQ/wOa
 oucnSG5n0r/GOmHzs1VFJ8FNI/ONOI049INYZG2fz1WF6CxuKwKe3UNJfysJvUlieWYJkT9vh
 7CffcrP43dhTPMJV5mAy9cu7f0NG13LW0hrdLpr+MCZyj4H/YtwqE+EnzeItvkQy6O5WlXb5F
 +sR4u8f+3M6ruwd9LbhXK04G3Bp7oSYNu4Bs6xaRT1IrunKxoNsfpoZczOInQ5+J+nCjR0UTj
 /PLuCT60ic4Fj2gAS3idCYbJ4O1Se6sW+cFBURNP0/78fcDa+jxBQDs9pYedpNyu/zAYzCyE3
 rpLPrSIvWuPN+J+Bl79kyBMKfEikvs6Nl9sDJq+QgjadjlUv4Kwj3yQcJTQzJzmg7fFjhV4FU
 Hmm49T5UPBohWMa4KfvK4mbN3zsoYHnL4FOtbRkvWW4ljUP3Zn6oUl2U/ufR0sG3XflrVZwgj
 Gmi4KXLKFkriVpNUZm+THlRC0G7mqAv9jLhXHDw1FqruWrw/PU3xmsMWIm1rZBaeUE/r5+wuK
 5p/uQbRJj2x6NFLYxYAYLrDv6Dmp8ubSXMy+hK4vjgny+rLEt2yIWCFi5niZELVT0VLwJw/ua
 mL8Fm98UISHEpxmGxvbw4IzAkyfBCaOMIhp3lpSiBNL7hwJowY9PvwSXRoeCBDNw198IJQsJu
 SKDgmCEOuu2sZ5CdwCp/eE8d9xt9O4Y2HB4ewCjr3JQgfm36yWOjrxHBTOkQ0cxwxpmeL2VbJ
 2WwBc3/Cs+Hl4YYKlPotCnlt5Zx9A6pgkSfULlXbttFQ14F/Seop7uIB6GNhi/aMZPbWGHv3e
 B06YUTy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Sun, 28 Aug 2016, brian m. carlson wrote:

> Convert struct cache_entry to use struct object_id by applying the
> following semantic patch and the object_id transforms from contrib:
> 
> @@
> struct cache_entry E1;
> @@
> - E1.sha1
> + E1.oid.hash
> 
> @@
> struct cache_entry *E1;
> @@
> - E1->sha1
> + E1->oid.hash
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

Makes sense, iff you find:

> diff --git a/cache.h b/cache.h
> index b780a91a..a679484e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -173,7 +173,7 @@ struct cache_entry {
>  	unsigned int ce_flags;
>  	unsigned int ce_namelen;
>  	unsigned int index;	/* for link extension */
> -	unsigned char sha1[20];
> +	struct object_id oid;
>  	char name[FLEX_ARRAY]; /* more */
>  };

(which is unfortunately buried deep in the diff...)

Ciao,
Dscho
