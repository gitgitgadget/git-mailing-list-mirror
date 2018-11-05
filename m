Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F3511F453
	for <e@80x24.org>; Mon,  5 Nov 2018 02:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeKEL2L (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 06:28:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45914 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbeKEL2L (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 06:28:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id k15-v6so4730957wre.12
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 18:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lVOD9/wnT1AQygyKH+hvGwtqd8lwHjJ0oxu1exDd0NU=;
        b=hyf5AR7/LIMhNkC5GubUsV/oF1CxuMKJq7DDNOZ2QoT/3c3ZUHD9j5MLsHQw9TmCe/
         HiULdLJUyh72WoiviI/HSwLpV5ObMFa63CJVtbj7mYV/aJztzGxs65I3IOMnTomt/uZZ
         AEWxeQ32cuVIJ2XptkDVlYTvQ2YfQolfJ0Ba2+1YJfxco+68odsk3Qd4tDjAFPrzOC+P
         EXUnzSMPIQWu1WdbsafxEIehuKAbn5OBFYh6Sv3+e8P+SKREj7Ne4WFsjfswcFrcxHWo
         S265X5g9bR4+WRdR4pwhRItWaIW/DV9i2agi+3fcvm+x7eOMmTfWFuo5WNjguTME4TYZ
         qEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lVOD9/wnT1AQygyKH+hvGwtqd8lwHjJ0oxu1exDd0NU=;
        b=sAmlXBylikFoxF6myiHwGyFAFEDjo3r/20PRaEoJ2aaQDuLQcSyXbj/jyBggbu0P6f
         2TvFNLN5OuCqaFQteRteNrCOJZo2XrsFCMmtZJINgLYeEPXNOHCddwXKmwcZJyve6S0i
         0BHCe96D1RucYZp6+0cmj0U1xXkl24B4noBni3d4I1xm3ZTpTLICL/PavF+nGV0TnhyJ
         SwnMBUKK/2UKCwbifaLoItwwrNdBcm9YxZoNwkFX1wUbQauLKnjCSMuYwH2qPpFn6ro5
         MmodZ9o4mswKJT1WGWL8vqrKVnztiBCu8jX8pvBb8cwu2kgkYti+LjSdj3vOAHYPt2Eb
         jJAQ==
X-Gm-Message-State: AGRZ1gJC6X9EGOZYbxM/yKbuITF/RQYPSBtoLlZdFjOLtlhv2Ob/f3P8
        GNFEgxRcZtkM94clAQ6Gezk=
X-Google-Smtp-Source: AJdET5c5+p+RpeUqXydAQhZTJNEuGDvrQn7uGRJQ0AZD54qXWu/do+tpBrbtew80ygj+KzVey7pr9A==
X-Received: by 2002:a5d:4306:: with SMTP id h6-v6mr18740535wrq.189.1541383854733;
        Sun, 04 Nov 2018 18:10:54 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f18-v6sm25810597wre.86.2018.11.04.18.10.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 18:10:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 5/5] pretty: add support for separator option in %(trailers)
References: <20181028125025.30952-1-anders@0x63.nu>
        <20181104152232.20671-1-anders@0x63.nu>
        <20181104152232.20671-6-anders@0x63.nu>
Date:   Mon, 05 Nov 2018 11:10:53 +0900
In-Reply-To: <20181104152232.20671-6-anders@0x63.nu> (Anders Waldenborg's
        message of "Sun, 4 Nov 2018 16:22:32 +0100")
Message-ID: <xmqqpnvkjmtu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> @@ -1352,6 +1353,17 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
>  						arg++;
>  
>  					opts.only_trailers = 1;
> +				} else if (skip_prefix(arg, "separator=", &arg)) {
> +					size_t seplen = strcspn(arg, ",)");
> +					strbuf_reset(&sepbuf);
> +					char *fmt = xstrndup(arg, seplen);
> +					strbuf_expand(&sepbuf, fmt, format_fundamental, NULL);

This somehow feels akin to using end-user supplied param to printf(3)
as its format argument e.g.

	int main(int ac, char *av) {
		printf(av[1]);
		return 0;
	}

which is not a good idea.  Is there a mechanism with which we can
ensure that the separator=<what> specification will never come from
potentially malicious sources (e.g. not used to show things on webpage
allowing random folks who access he site to supply custom format)?

