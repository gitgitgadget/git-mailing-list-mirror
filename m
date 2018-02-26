Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63021F576
	for <e@80x24.org>; Mon, 26 Feb 2018 11:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752534AbeBZLQS (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 06:16:18 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:41994 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752024AbeBZLQR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 06:16:17 -0500
Received: by mail-ot0-f169.google.com with SMTP id l5so5744824otf.9
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 03:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=krNoO5vQ1EwxiZi3hqbU7CoS5Y+OJRGqQjXNZkDhn1A=;
        b=mfn8cJFIdj52E84tUibNN5W/xvKlHYmmn7NXVEQdaq7lkg9aqoRR7YuV7FiLHAWgMn
         rPl+H71gZS+CXEX9DugNOHtritcxNEITN1nwBCrdsRc8/9ZLlSQaQUPLTiPHCqUs1eAs
         ZzTCV2LuSceJZJWtmcpG8U+Sv1pubK4ALCKDczHNwI4LYpeqhDZAS8VkwnDV9jdLkwal
         +ykkfas6PB+pfsnF9Vz9Acwv+hCUcPXrf0bxb3Ki/2Paf0iUXoDC790ZaH2XZi+ZoGuM
         LzUTqjqp7Hiw3WBKjWWcTFv2uMnBGxYxM6Ngh6yhHX5rbIlscDdlMiJibtsAPHlTDy9L
         /mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=krNoO5vQ1EwxiZi3hqbU7CoS5Y+OJRGqQjXNZkDhn1A=;
        b=GZiOP5Y3GyL7kVNga77spHzj5tQjhLnbdlDKCisNqGvASxn05hfcVl1cZuA8pZRuHT
         o2VS46ku/hNIRY56NhuYlhLpa+fUN6ahNywrp6XFiHjAOZPT8JLBHs1w6YziN7gOq+N8
         q0DOZTiMdUU10NcUdAMqRFlOR3VZRezGlUXXvVv+om2TcxmPxqEPD7YhenI9pr7+U+ZZ
         iyYVAdYJo0f/TO7XGqF0uhZB3XF3xqtEbA9CaoeY/oY77h+GbYOFV7/kWBErS6UrWj+n
         U6ZXJL3fzAFW/yC4TUZX3nbYQvFUB5sTiPLAHuX+bQX4FdwUdeSohih+cjWKYx+woAoH
         gT2A==
X-Gm-Message-State: APf1xPCYDC7uNsEy8N5iuQ56BDANkt8jPdB8qgknMbS5ImpJEfMwKXAJ
        fJG6lmVm0G4V0ORv50YKvo7vYl8K6C9fWgvWhBezjg==
X-Google-Smtp-Source: AG47ELuFywxNlwP4iRFMhWNF0oo/0kUAC1Mk6scRRXSyvuOuZXWjOrmIHiZJyQTOIM5x4KlLsrDczVT5k4uw7A1ZvW0=
X-Received: by 10.157.54.204 with SMTP id s12mr7719843otd.304.1519643777260;
 Mon, 26 Feb 2018 03:16:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 26 Feb 2018 03:15:46 -0800 (PST)
In-Reply-To: <20180225211212.477570-5-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net> <20180225211212.477570-5-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Feb 2018 18:15:46 +0700
Message-ID: <CACsJy8BxrsrGf7vo39ycwAAgbmXKEz_Sx3Ksb3prL2pZwW07ag@mail.gmail.com>
Subject: Re: [PATCH v2 04/36] cache-tree: convert remnants to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 4:11 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> @@ -465,7 +465,7 @@ static void write_one(struct strbuf *buffer, struct cache_tree *it,
>  #endif
>
>         if (0 <= it->entry_count) {
> -               strbuf_add(buffer, it->oid.hash, 20);
> +               strbuf_add(buffer, it->oid.hash, the_hash_algo->rawsz);
>         }
>         for (i = 0; i < it->subtree_nr; i++) {
>                 struct cache_tree_sub *down = it->down[i];
> @@ -520,11 +520,11 @@ static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
>                 goto free_return;
>         buf++; size--;
>         if (0 <= it->entry_count) {
> -               if (size < 20)
> +               if (size < the_hash_algo->rawsz)
>                         goto free_return;
>                 hashcpy(it->oid.hash, (const unsigned char*)buf);
> -               buf += 20;
> -               size -= 20;
> +               buf += the_hash_algo->rawsz;
> +               size -= the_hash_algo->rawsz;
>         }

This looks a bit strange that everything else is now with hash
abstraction, except that it->oid is still copied with hashcpy(). But I
guess we don't have an equivalent for that function yet..

But since it->oid.hash is copied to buffer with strbuf_add() in the
top chunk, maybe we can do memcpy() here with the_hash_algo ->rawsz
too?
-- 
Duy
