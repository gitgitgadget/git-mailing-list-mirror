Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1DF1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 17:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfFTRi1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 13:38:27 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:38645 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfFTRi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 13:38:27 -0400
Received: by mail-pl1-f202.google.com with SMTP id s22so2017659plp.5
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 10:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fAz5+lF1C0tfqgoAnkQxSHnqmRoflpkqUEh04aT6vww=;
        b=Hplws0MDHzLRuoz2cnLT/kSGTnJ3UgDFpmkkFW29GXNWl6TvP0bG6p7f/pPKAtp6sQ
         /H2Wg7uYYOWuFppeRPSQBpxn6r0P6EVSXr4OembqYn7OGZ/CTHrMKlZdk5M275B7FKHH
         KyDlf6BxqxuuLiaeSB4dYucjpHCUBbCrWnfLb2uoWPkggY9vL/6e/Ztv0NE2Zc5UC4qR
         RUbyN9Py5YNRsTwSfhVU+MtLW+HLZTe/o3urgn9uZU74hCWvyNk333GrecdlZEDuW4Kv
         Ibsn78BiZKVceg+JA6UTA8iUQveoVo9VSD5476Rf7+9sr3Whae0nvwpeyzUktcNVvBrg
         /MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fAz5+lF1C0tfqgoAnkQxSHnqmRoflpkqUEh04aT6vww=;
        b=RIRiwMGGGuqFR4D94R1b0zzydWXBj+LJcoEkUcNameOhRk+DD5tLCO+FRcHemB0MaX
         19G8IBgBadTgeEq37lZlphSfzrLkIOnHf9RZPF1aBskI83SvG1Xjc2BcblIslBG0+tQZ
         lB+Xpi1+MzaXJPzWZd2BD52+m+eCc0Dr273KWS03+AQGheCWSkgVYa3cBwCWKpWuGrHu
         BIOV4dzL8XP2h/xzpaGjLklHEyka9gyym9bxMjov39HtXGkAhMYgxc1CVBBXzQdDraux
         Rg+6zeOoVi7mnGxUoJuajSfFr5LrxTTBP0EIScHkpZdx6q0nfRuT0yfZEiaMTTP9V6Ib
         oZIQ==
X-Gm-Message-State: APjAAAVx/uRp6jJQPa5JrmJagaSvB4wxba7rPPvRY6cXvOxo67ldtMer
        deA71Lywqs/KlUHxtWgizwAGGHCIapk3y+i/EgPA
X-Google-Smtp-Source: APXvYqx2ydvcHc7P4HexFFZZnqXNrFhASRspzl2KQGJ0wIYGPvsPs3lKEJGVZwiPPpp+NO6oPajCDjWJmTaZDKUeK5Dn
X-Received: by 2002:a63:231c:: with SMTP id j28mr13692497pgj.430.1561052306692;
 Thu, 20 Jun 2019 10:38:26 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:38:23 -0700
In-Reply-To: <20190620074131.GL3713@sigill.intra.peff.net>
Message-Id: <20190620173823.23374-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190620074131.GL3713@sigill.intra.peff.net>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: Re: [PATCH 12/17] delta-islands: convert island_marks khash to use oids
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -105,7 +105,7 @@ int in_same_island(const struct object_id *trg_oid, const struct object_id *src_
>  	 * If we don't have a bitmap for the target, we can delta it
>  	 * against anything -- it's not an important object
>  	 */
> -	trg_pos = kh_get_sha1(island_marks, trg_oid->hash);
> +	trg_pos = kh_get_oid_map(island_marks, *trg_oid);

[snip]

> @@ -154,7 +154,7 @@ static struct island_bitmap *create_or_get_island_marks(struct object *obj)
>  	khiter_t pos;
>  	int hash_ret;
>  
> -	pos = kh_put_sha1(island_marks, obj->oid.hash, &hash_ret);
> +	pos = kh_put_oid_map(island_marks, obj->oid, &hash_ret);

Thanks for doing this cleanup. The entire series (17 patches) look good
to me. The only remotely surprising thing to me was that OIDs are passed
by value on the stack, both for kh_get_oid_map() and kh_put_oid_map(),
but I see that this is how things currently work (and anyway, changing
this is beyond the scope of this patch set).
