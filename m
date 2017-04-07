Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05C9D20966
	for <e@80x24.org>; Fri,  7 Apr 2017 11:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933373AbdDGLcz (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 07:32:55 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36567 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932528AbdDGLcx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 07:32:53 -0400
Received: by mail-oi0-f45.google.com with SMTP id r203so82414130oib.3
        for <git@vger.kernel.org>; Fri, 07 Apr 2017 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aU2oeIXxLFL4Vw+k/lz45I4Z4robHExiOw/TokbnDkI=;
        b=SrmYF2dC3xaFfRCqJozetsCi/u6yEzFuLdDxyheu7jy2v6RdOfSvj/rQvy7o7vhWKF
         KFT3X0s+oKx6eRAOAg4x8NnjHfP2kpJd0aEVAWD+vJCAx6gf9xOo443r1DpLiStRiNvK
         emyQkEC0IDkcbiD2w+8gAnVK6/X3Sh7m845Xzb0oTaLfJHmkvh/MPWZCwgUA6q2RTR/p
         bQt9tGcBk482TiWVhe1ITc3fJsHTYg07LD0aBbUO0Rs/Ct6McUUTFdsGR5MJwtZgIfVx
         d+rKXGK7fSOAAeTwSsLdGPGgdmLAUHh/3aR6OmQfRfkPsYIQKEAfPDy6TAuZe4rJqm5Y
         yB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aU2oeIXxLFL4Vw+k/lz45I4Z4robHExiOw/TokbnDkI=;
        b=OXEArhrf6R+WIwd6rACK0JADSsGXFg5LKd+1qlYDuvu0rif12LCX9tmbMAxfm9BQk+
         zodtDZfLIVUTeWHL2L2Gp4pXMhOr6rdpD9SreBKKIDhQtgSSWPIGxkr9wd4bTeQv/BWm
         +iFvHx8M7Z7XoZB+GzLdb5F/tJ0UHT74RiqpgRHVbeilNMZvnNgXbA5sFFUF0DguNNKo
         /w3sPPmZ9d5N0jTq9q2+JqNMaeqDHe81gEyoiyXtzMEtICBRRRLpvljsmfpom1dEBS+f
         pCqmScjWqW6JrIzib0y3zF9ZFcpPa2ZFTCmbJWmPCVLBcGWMXqZrLWSQkuSTaQ7i1Pzc
         Odyw==
X-Gm-Message-State: AN3rC/5NZDWMBKHtiTcc15YtH8zRzRuR+HSDkH6d2pYWQtqhGfXBsBmjbnRUBFnSQUwJQrJ0cpwr/ObmpQOziA==
X-Received: by 10.157.5.102 with SMTP id 93mr3604479otw.10.1491564772908; Fri,
 07 Apr 2017 04:32:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 7 Apr 2017 04:32:22 -0700 (PDT)
In-Reply-To: <e90f9afd20cbfc07f8844ba4f81e7369b4b9bb00.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu> <e90f9afd20cbfc07f8844ba4f81e7369b4b9bb00.1490966385.git.mhagger@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 7 Apr 2017 18:32:22 +0700
Message-ID: <CACsJy8Careik7fCtXo_Luu40G8YPXAgZomFKDkCOuuOfEYm7nA@mail.gmail.com>
Subject: Re: [PATCH v2 10/20] ref-cache: introduce a new type, ref_cache
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 31, 2017 at 9:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> +void free_ref_cache(struct ref_cache *cache)
> +{
> +       free_ref_entry(cache->root);
> +       free(cache);
> +}

free(NULL) is no-op (and safe). Maybe we should follow the same
pattern for free_ref_cache(). It's really up to you.
-- 
Duy
