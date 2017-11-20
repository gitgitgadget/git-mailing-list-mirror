Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587FF202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 19:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbdKTTzh (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 14:55:37 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:37457 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752148AbdKTTzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 14:55:36 -0500
Received: by mail-it0-f65.google.com with SMTP id m191so13195777itg.2
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 11:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YLgObSeFXb1nrGjJ8vTg9fPmNY9+M/sMouGz0zwOy1A=;
        b=Cii4mCoxouydM7K3gP7xqHc42ROL4lIQjywk++NZBE3nW+P1viJuZ2YVQv1790rtLL
         O7ZRPcVbQm7Mmmv5Uv50Hm0PHAPi06wPflP0C3XwVGYkL2M3Bv4W2uS+nfLuQRN26wil
         XopWc5JkkK35xTcxhDcPgjeUEdxA32I5P37XtLycuaLmb2u5qM3z3ZVBNYW7FaOOzV93
         WPJ6YhnKFYK6idkKcKIfnnlIbxvi0f37wFkbyphXpGA8eVoCzy8i1+BUkxjGFlaYsJUt
         uEqM2Yy2s8ouhxgfXSSDcmktL2rz9tExgi/F7iN9CHf0qsf3Vq+mhsqXwpD7j3s86U7k
         OhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YLgObSeFXb1nrGjJ8vTg9fPmNY9+M/sMouGz0zwOy1A=;
        b=lDtrlGtEcOS1pLSsz8dPXpNbxObKKDCTcUWgzDtW7LhIZ/nyCnaqBLwGe9SDNVcdjB
         k0MdYxdu4AO3Ncmf8G+1IG+rTWBBWH8VSA5I3ZxNYZ6RSmgJqbO6YBjaqhfPni3MN5sA
         e9H31H22tm9yx9MeL+U7U79X0qZqbWkhRY7z9E+a068p/7e8tOi+kuzIQ+jronSOTbwd
         nvR3QZ495jNYcE5c9szqwOy6CS+S88P6MwjQni+b0vw7jLtPLHglWGZpW4pecSpjYGyb
         5USDHVaLoIX3z+WYdrVBiP2epqornMNj39iYckxBDolRuRV9+Ef7zFMpk7G1fH/Z5m/H
         7vuA==
X-Gm-Message-State: AJaThX7xLVuEso4z2duoCXJ74U6u07Cdg3Zo7WhewcokZVRbg+uubghP
        UEkBDdA1ImpuBeTka76/8GtonqrR
X-Google-Smtp-Source: AGs4zMZF0Voy7UZjXATNmcSvUuRDgVYYb3c0AYw9hfchi2Bzq2NiUlXl5rIOUE4GhMr2nvOiWVYp+g==
X-Received: by 10.36.162.76 with SMTP id o12mr20036529iti.76.1511207735513;
        Mon, 20 Nov 2017 11:55:35 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u140sm5303481itc.41.2017.11.20.11.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 11:55:34 -0800 (PST)
Date:   Mon, 20 Nov 2017 11:55:32 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>,
        git@vger.kernel.org
Subject: Re: [PATCH] contrib/git-jump: allow to configure the grep command
Message-ID: <20171120195532.yearckl3pbc26iae@aiede.mtv.corp.google.com>
References: <20171119230536.1628-1-dev+git@drbeat.li>
 <xmqqh8tpmypa.fsf@gitster.mtv.corp.google.com>
 <20171120191846.pco4wfsu2ptci3uv@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120191846.pco4wfsu2ptci3uv@sigill.intra.peff.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Subject: [PATCH] git-jump: give contact instructions in the README
>
> Let's make it clear how patches should flow into
> contrib/git-jump. The normal Git maintainer does not
> necessarily care about things in contrib/, and authors of
> individual components should be the ones giving the final
> review/ack for a patch. Ditto for bug reports, which are
> likely to get more attention from the area expert.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  contrib/git-jump/README | 7 +++++++
>  1 file changed, 7 insertions(+)

Thanks for making it clearer.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> diff --git a/contrib/git-jump/README b/contrib/git-jump/README
> index 225e3f0954..4257cef2e6 100644
> --- a/contrib/git-jump/README
> +++ b/contrib/git-jump/README
> @@ -92,3 +92,10 @@ how to activate it.
>  
>  The shell snippets to generate the quickfix lines will almost certainly
>  choke on filenames with exotic characters (like newlines).
> +
> +Contributing
> +------------
> +
> +Bug fixes, bug reports, and feature requests should be discussed on the
> +Git mailing list <git@vger.kernel.org>, and cc'd to the git-jump
> +maintainer, Jeff King <peff@peff.net>.
