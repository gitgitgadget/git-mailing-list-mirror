Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2772095B
	for <e@80x24.org>; Mon, 20 Mar 2017 13:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755189AbdCTNH6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 09:07:58 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:35603 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755057AbdCTNH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 09:07:56 -0400
Received: by mail-ot0-f182.google.com with SMTP id x37so131804312ota.2
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/viLuua6xlU5CPFPnvoVROrzOjMVr9QHblBvswBdOag=;
        b=fzYc3SePGgrSTi/xd4U4auSqAFOfcx4RzX58N58+Zl0q1sRUqU6yZHfRQ9KCEU4suO
         QEfC9tojoaS07c2aPqYLTpxeNb6Rb9KDZz4mWTX03AtZvmTnuxjg5oG8NL9EhL6bJtoF
         K53YEwv54Elz0VTWq5Kfdjd8HaUzfulVjFQrhACTpzb8pMY6ETPgPteqlC5ig075pogt
         C4Y8MYb3maPnGTiw0vZkMwke/y41/5O14A2a7nBH4SEMHfZxSJ76y/hgUIzD3flfejwT
         OC6eG8vN7bAhM3Y1hkQg5j6oMV7EU34++ledYoDks/ZYxbjDdoOD4GJ8SUx9IdJd95U1
         +jHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/viLuua6xlU5CPFPnvoVROrzOjMVr9QHblBvswBdOag=;
        b=EM1JNrdPpngtKCVqSQ2HphEusdC53gkNDyK9qFqA7UsQ84JarISl+FfyUwZPKr18Rs
         PODniLAAJhjiWArgmrpebsp+izdHtRnxiXT6Tu7Tj35DDB/j9zVkccgv0sUG4mGS+HH4
         B0+Pp9cXvZ3RrUjOTVxJFdKzIIBzQVzAKglrLMc9UF/zUhq0lOfSFP6T21CjZbQW0s9i
         ipswZfqK83A6+S7xGH3QazvAh6lhmQjM3t7F1bOpNWbbKx7ixnHqdW3mgrxt90U3MwaO
         1J1HYmtMsWCsWscXycg/1JMMg92z2alZ8L6Lwd/yZ2m/AJhaWvKIAcmLHHCTLtFmlCRy
         I4pA==
X-Gm-Message-State: AFeK/H0YjsWfoy5M8mBlM+JYzoGKyAUqBGeuHVW/PGWk3GvIsWM5HMk3a2V09hwV+BAE4xkaD/31MRlp1b5hBA==
X-Received: by 10.157.46.26 with SMTP id q26mr16918841otb.28.1490015260212;
 Mon, 20 Mar 2017 06:07:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Mar 2017 06:07:09 -0700 (PDT)
In-Reply-To: <20170318211954.564030-11-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net> <20170318211954.564030-11-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Mar 2017 20:07:09 +0700
Message-ID: <CACsJy8ACRgcE0SV2qa4bU+QdT7=WMcBRkV=cr4SR-bcXxTMj9Q@mail.gmail.com>
Subject: Re: [PATCH 10/20] sha1_name: convert struct disambiguate_state to object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 4:19 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> @@ -332,7 +332,7 @@ static int init_object_disambiguation(const char *name, int len,
>                 ds->hex_pfx[i] = c;
>                 if (!(i & 1))
>                         val <<= 4;
> -               ds->bin_pfx[i >> 1] |= val;
> +               ds->bin_pfx.hash[i >> 1] |= val;

The indexing makes me a bit nervous, especially since diff context
here is too narrow to see. It would be nice if this code (at the
beginning of init_object_disambiguation) is converted here too

        if (len < MINIMUM_ABBREV || len > GIT_SHA1_HEXSZ)
                return -1;
-- 
Duy
