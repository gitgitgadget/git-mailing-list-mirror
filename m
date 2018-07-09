Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64BCA1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 13:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754444AbeGINOw (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 09:14:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:46885 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750996AbeGINOv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 09:14:51 -0400
Received: from MININT-6BKU6QN ([89.204.153.232]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlVZv-1gC7Km3wNb-00bIgH; Mon, 09
 Jul 2018 15:14:44 +0200
Date:   Mon, 9 Jul 2018 15:14:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Beat Bolli <dev+git@drbeat.li>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH 6/6] utf8.c: avoid char overflow
In-Reply-To: <20180708144342.11922-7-dev+git@drbeat.li>
Message-ID: <nycvar.QRO.7.76.6.1807091513130.75@tvgsbejvaqbjf.bet>
References: <20180708144342.11922-1-dev+git@drbeat.li> <20180708144342.11922-7-dev+git@drbeat.li>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jqa/Va40dbk4JPZVcIHhL+w0LqE6MtTj6EjqoD4kYmD7N/QLNdg
 mDB81t26J0eoELhhziLKXc9UVdi5UYZJNhH9vz6/bd+bCM1tHJLa4Qy5m3LAgcDJt3fS7O+
 cIgQu4lEadkXcIO7v7ST4vcNq2U/v+TaN1HOd7eroo7HFRwe9xsJ8qL/+Adveg58XqEiDxJ
 VLEZnZIDbvR97fecboyAg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gVDx5JkMxi8=:KXD7IbVKUcEiRK93WNwPYh
 iFVZT5xv4N1RbE8d7hPuvjJ+fcl/Ty69az9YQoYytMgIDA5avIpy6trhFAq/b2fnWo9elmSOW
 UXt/R2yNImonBwe74WnzcvSge1rxWagVd2hW9DUr0QJHbP9xAJ/b8erLu0yEWPXu5SfEn7YRW
 QnVMMS51aVe9jlOINBb1bdxRaxwsJIIL7rSCVmPLcTrHMGE0ju04Q9Zen/jgsCMAoxwL+fU7W
 2qCoqWHay/Pt3frHdWuSf1JQLrCDDVKLyA2ccvqHutomPeK4oq0OuaMWS3xSIanVJzWm1HzeK
 BOK/KeyftIJBEkUqSm4Fb+p/U3eWhea4jQyRIy//OZeLMQ2tM03H0ZRxMKCU8RHvKJuqU1DTz
 YA1qpGemD0cdYonyQCh2T0JCMrWZOedygQW5pqSv5Gd3PR7QTbU8n8B8pS1is8kAqJT3ezXxN
 yzGu0K9dpSRxVYyYZIExYykdqgNGJo1+I0j/+dOBnUpgxpp+BbDiO/ztHYMfF+JL+iuF3BAMx
 /siEaX9I5Akf4/cMadd5cUi34m14vILAxnoTEvNJpssAVB65DmywyPl1d0H5tXSoQ/deBSA1u
 mFpbtE+k/02RTyGJLLOH3TxBnnW3uPLdMfygpAFk1Txx97mT5tqm1KlYmCiJ39vvL9sNVsCV7
 aopEUmJSHmj1xSXpO3CB3FNuN9/ayvbkOpzY3x/lX7ZG1tH7wqx9Ot9GFncYbLl6W8//ohthF
 2H2uZMq4v4O5lzmA3D1mSBBPGHOIbv7IQ0dhpcmuKZDQ3TVrs8GIMW/W4FHdMOrxia2/kvJFH
 f/R+ZKc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Beat,

On Sun, 8 Jul 2018, Beat Bolli wrote:

> In ISO C, char constants must be in the range -128..127. Change the BOM
> constants to unsigned char to avoid overflow.
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>  utf8.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/utf8.c b/utf8.c
> index d55e20c641..833ce00617 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -561,15 +561,15 @@ char *reencode_string_len(const char *in, int insz,
>  #endif
>  
>  static int has_bom_prefix(const char *data, size_t len,
> -			  const char *bom, size_t bom_len)
> +			  const unsigned char *bom, size_t bom_len)
>  {
>  	return data && bom && (len >= bom_len) && !memcmp(data, bom, bom_len);
>  }
>  
> -static const char utf16_be_bom[] = {0xFE, 0xFF};
> -static const char utf16_le_bom[] = {0xFF, 0xFE};
> -static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
> -static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
> +static const unsigned char utf16_be_bom[] = {0xFE, 0xFF};
> +static const unsigned char utf16_le_bom[] = {0xFF, 0xFE};
> +static const unsigned char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
> +static const unsigned char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};

An alternative approach that might be easier to read (and avoids the
confusion arising from our use of (signed) chars for strings pretty much
everywhere):

#define FE ((char)0xfe)
#define FF ((char)0xff)

...

Ciao,
Dscho
