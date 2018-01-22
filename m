Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D67311F424
	for <e@80x24.org>; Mon, 22 Jan 2018 11:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751092AbeAVL4t (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 06:56:49 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46627 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeAVL4s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 06:56:48 -0500
Received: by mail-pf0-f194.google.com with SMTP id y5so6894923pff.13
        for <git@vger.kernel.org>; Mon, 22 Jan 2018 03:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l4FcT40K7BbjdWXc5vBj11k41v4HlT/UiCchj5FSb2I=;
        b=mshcKTSgRXo8od6i45ja/E6ZAYqwRyjw6RPlf/13byTpS9yTVKTtcL88JaYtnwONCj
         a6Zp5yOhzI3sp+ztWUCDF+y8hK7xKJWjfPPDhOU0Mzooyr73YRZSx4r/pJZ40XL2Yizi
         0ufE010EqQJq72nyjuG9XsDM8JHrcZ6Cg/edW7rNlOrBHTHtPaRW9xcXXlowK/ltFsQN
         TXjbsA2OCKyuKFmdOzx2AnfrXdDSiEPXRShsK6MY6vvn2MXMlY0TOXbwlcoGzerQBJ4/
         8kgXOrExh49ZiyuuFVHB2a53aMh8JQZx7K/juLrUdhyHxjYsscPH9+gCOmrvR1wsuTul
         rRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l4FcT40K7BbjdWXc5vBj11k41v4HlT/UiCchj5FSb2I=;
        b=GP3j/z2BC+ZB1LBlVuf1hub1YgDDaLh8HLAqJe+oiB1LNF+4QoKlSfsQoBb5DHHHzr
         zB8wU/A2Y+P8eSXEbAkZwyzlHAxWELE31dl+0pLrRqKhNymZIZXTiEIvbK0I3+IFR3KL
         FQ9yH3RDwVjogYvcnSVLzgvPdLDltX06qyqrykIDpGPSHRE/A1uoh4Lvm41gAzKdfRIk
         dIN07hsQr8IYFdGe/MQs3uXcE6EwS7PCZgquH81LR/OejoojQ0KV29RPq9Uri3QcS4bg
         KOAoWg2DsTA1UyEt4aLx2Jerg/+ZWMjFymEvZ/gs7asm1ehwpiLDHK0XC5hrZJ6TZrpG
         DtwA==
X-Gm-Message-State: AKwxytdnEKt6BndmOUOVaYrnd541057zZ6wJh/W75GS0FQnfTnR3BAAt
        VaotGNF3nFuFj1VJdmnq7Ng=
X-Google-Smtp-Source: AH8x226tgNQRwSoQQ3l/zJK2oB06iw+e9ujwD8BKDfS+kS4IEufQf8It9+ab4zXDI9pWGGqT4z03AQ==
X-Received: by 10.101.97.12 with SMTP id z12mr6799373pgu.92.1516622207903;
        Mon, 22 Jan 2018 03:56:47 -0800 (PST)
Received: from ash ([171.233.110.59])
        by smtp.gmail.com with ESMTPSA id r30sm536142pff.16.2018.01.22.03.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 03:56:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 22 Jan 2018 18:56:42 +0700
Date:   Mon, 22 Jan 2018 18:56:42 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sandals@crustytoothpaste.ath.cx,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 07/14] match-trees: convert splice_tree to object_id
Message-ID: <20180122115642.GB5980@ash>
References: <cover.1516617960.git.patryk.obara@gmail.com>
 <b5782b135fb68b645ffea711028bd6024176005a.1516617960.git.patryk.obara@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5782b135fb68b645ffea711028bd6024176005a.1516617960.git.patryk.obara@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 12:04:30PM +0100, Patryk Obara wrote:
> Convert the definition of static recursive splice_tree function to use
> struct object_id and adjust single caller.
> 
> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
> ---
>  match-trees.c | 42 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/match-trees.c b/match-trees.c
> index 396b7338df..0f899a7212 100644
> --- a/match-trees.c
> +++ b/match-trees.c
> @@ -161,19 +161,17 @@ static void match_trees(const struct object_id *hash1,
>   * A tree "hash1" has a subdirectory at "prefix".  Come up with a
>   * tree object by replacing it with another tree "hash2".
>   */
> -static int splice_tree(const unsigned char *hash1,
> -		       const char *prefix,
> -		       const unsigned char *hash2,
> -		       unsigned char *result)
> +static int splice_tree(const struct object_id *hash1, const char *prefix,
> +		       const struct object_id *hash2, struct object_id *result)

Maybe change the names to oid1 and oid2 too. I had a "what?" moment
when I read hash1->hash below.

> @@ -197,26 +195,26 @@ static int splice_tree(const unsigned char *hash1,
>  		if (strlen(name) == toplen &&
>  		    !memcmp(name, prefix, toplen)) {
>  			if (!S_ISDIR(mode))
> -				die("entry %s in tree %s is not a tree",
> -				    name, sha1_to_hex(hash1));
> -			rewrite_here = (unsigned char *) oid->hash;
> +				die("entry %s in tree %s is not a tree", name,
> +				    oid_to_hex(hash1));
> +			rewrite_here = (struct object_id *)oid;

You don't need the typecast here anymore, do you?

--
Duy
