Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E7BB1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeGHSfz (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:35:55 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34297 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932365AbeGHSfy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 14:35:54 -0400
Received: by mail-wm0-f52.google.com with SMTP id s13-v6so8265115wmc.1
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gmdqwabNuLu7MGAJfm/if8aHeNvPPDTWrYt6W3XnCZ4=;
        b=LMsqkbAuxgd6jjFqLhaFp8sUiSWE7r7GsH5SVVeYZTLF1DnbY1l5i4T5KzeRiTpRLW
         GJfoFPkQs7Mk/7ogjb12WSB5reVHfCqf/r9BzFyMZUmQNOXKwvlCxu0CICQ1xfDigG/B
         o5Nv8eWfKd89XkWEy1Z30BnTMMC4nR4gxuF1LJ3/RCyVoMsuTunlBxrSGq9XLp885Xpn
         6I4D0au4zvXhis2u+9RqcHRxYkCJ67ec4EwCOsP4S3rt0efAkxj+HQSr8cqL7C6I1mFa
         JyBjlmos73U875OjSe5z/cIECgHvD2Y8AFzyZGCwZL2oOLRuQ9TN0iYBRocUleP2/gdS
         FftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gmdqwabNuLu7MGAJfm/if8aHeNvPPDTWrYt6W3XnCZ4=;
        b=QitgjRN5XK2460eO9dYjyy42/JIUMBHiZK8IQdWo8srzuSVuNggt1ZQ+xA9gSBiAGg
         RDjRRK2k6hi6S66DVS7nvfvKaY4vCv2IN50gVw7Mk8746PUHK2HUoFBYk77AkSIDJ5Me
         EnwYw71qSvtQ9Gzuvzn2Oe1dVbf9pvt/6NAt6TPHSA/P0CiqPu7TxtI1h9QxF4SO7RjM
         QKuMcT2rNEWb+tPdcV4axr+uagf6Vdnr90v2tMg4nKoDjbi8I1oj01OO18JgER1+DAeL
         uCWugF3r974SODa6988I08jRP+wjPsr++ddoX8XR+BJGWjNdUBrxVyaTejp221Yt92Bt
         OqkQ==
X-Gm-Message-State: APt69E15TZ+xHqU04PcJBhofuzW8VSjAxlvu9KMAW0d75gSCIdFWtiJh
        uAYkiokWSrDe8ZW+JDQcKtBkVbWd
X-Google-Smtp-Source: AAOMgpeB0awBZSwRNm33fIhJan6gzAcqeiVPnFm7M3+MB/dIprIbcH5y9epfyReuMI8GoMYBQ94XQQ==
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr11054829wma.143.1531074953122;
        Sun, 08 Jul 2018 11:35:53 -0700 (PDT)
Received: from larsbook.fritz.box (p5DDB5D90.dip0.t-ipconnect.de. [93.219.93.144])
        by smtp.gmail.com with ESMTPSA id f18-v6sm6367343wrt.64.2018.07.08.11.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 11:35:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v1 1/2] convert: refactor conversion driver config parsing
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180708183036.29459-2-larsxschneider@gmail.com>
Date:   Sun, 8 Jul 2018 20:35:50 +0200
Cc:     Jeff King <peff@peff.net>, Johannes.Schindelin@gmx.de,
        jehan@orb.com, whee@smaertness.net, me@ttaylorr.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D87BD79-983C-45D8-A284-1CFC65FBDDB8@gmail.com>
References: <20180708183036.29459-1-larsxschneider@gmail.com>
 <20180708183036.29459-2-larsxschneider@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jul 8, 2018, at 8:30 PM, larsxschneider@gmail.com wrote:
>=20
> From: Lars Schneider <larsxschneider@gmail.com>
>=20
> Refactor conversion driver config parsing to ease the parsing of new
> configs in a subsequent patch.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> convert.c | 64 +++++++++++++++++++++++++++----------------------------
> 1 file changed, 32 insertions(+), 32 deletions(-)
>=20
> diff --git a/convert.c b/convert.c
> index 64d0d30e08..949bc783e4 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -1003,43 +1003,43 @@ static int read_convert_config(const char =
*var, const char *value, void *cb)
> 	int namelen;
> 	struct convert_driver *drv;
>=20
> ...
>=20
> -	/*
> -	 * filter.<name>.smudge and filter.<name>.clean specifies
> -	 * the command line:
> -	 *
> -	 *	command-line
> -	 *
> -	 * The command-line will not be interpolated in any way.
> -	 */
> +		/*
> +		 * filter.<name>.smudge and filter.<name>.clean =
specifies
> +		 * the command line:
> +		 *
> +		 *	command-line
> +		 *
> +		 * The command-line will not be interpolated in any way.
> +		 */

I stumbled over this comment introduced in aa4ed402c9=20
("Add 'filter' attribute and external filter driver definition.", =
2007-04-21).

Is the middle "command-line" intentional?

- Lars=
