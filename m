Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A6701F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932436AbeGHSjM (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:39:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51421 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754282AbeGHSjL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 14:39:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so19039628wmc.1
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 11:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9jYpx4Yx0FkUZ8XWf6dgJXF4TwFg206U1wRguimd9cQ=;
        b=QnlTR856LysKXP2tk4Sr++ZCKyuNefaTYx2TIt4+zSB36yjisIHRPIqOM1plxS1bpM
         7VFS+yMisxgX1ThoxpujOyBroXMihhdMrk0iJ8Ey4u/DLPXk/iYyIgE/ySXA4Kl8dAg3
         17z+nOJTGeaDU+RDw8SZWbiFISayuUfONsDBHNCCygnZDx+UJaXWL3YPp0vxnurwqF0g
         LS9rDHAkIhCBghbnaLKiye2133w6fxUbUkNt1wA9oxT3gz3iOd9v0B+g1JIetRSCgxf+
         iTwY8wmUZtlgIegJmDV0c54a9jeXDMkdeTPX9FfIipeG7cSczh4zVQv2+Mi+f/mm4IAP
         IyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9jYpx4Yx0FkUZ8XWf6dgJXF4TwFg206U1wRguimd9cQ=;
        b=paFp3fsFGeaOU+jzu1U2b+uOY/B+StSqKQwFnPapVwMvigU16n2eqPKzLZ3RdbDtjj
         979K78hGu0boQ8TtDgHfgcLa0mdyYPxzz1Mc4gzuxQq8T3TlFSR/4G16Huwlv69nPhSt
         /T0VqEalxTRuYoZ9MpLv5n6Yg5EpJM9DyqfDAA0/eALSZxyJ2t3aWPLTgZ/2sdzQLglR
         JH6YU9UdY7GgI5tR23J2GAAEyQmiOk3axk7AcxhuHk8nT8R+YpYPjP4zPxM3F6MjMkQ8
         39OhmK9Ok9Z3e+PXnkKFoFUHNQLc+D/+r1/RR7zFkIwpHKDGDplihqrarXbEbKAbIK4d
         7CqA==
X-Gm-Message-State: APt69E3w1n5RagZeyewc2kxRR4KqSBapyVhNIaViSH6ST6gguifiTaQg
        l/7QViUzAJsUkjqDzlHL7tCSzzAM
X-Google-Smtp-Source: AAOMgpdHF8qa4+XT+O16zbtKEZNL6rVgINfeFZK5DNlRGEUGP3aVfWSpg7crjR+0m6gX8Ubn+Zrdiw==
X-Received: by 2002:a1c:ea9b:: with SMTP id g27-v6mr10012149wmi.152.1531075149695;
        Sun, 08 Jul 2018 11:39:09 -0700 (PDT)
Received: from larsbook.fritz.box (p5DDB5D90.dip0.t-ipconnect.de. [93.219.93.144])
        by smtp.gmail.com with ESMTPSA id s124-v6sm17149349wmf.47.2018.07.08.11.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 11:39:09 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v1 2/2] convert: add alias support for
 'working-tree-encoding' attributes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180708183036.29459-3-larsxschneider@gmail.com>
Date:   Sun, 8 Jul 2018 20:39:07 +0200
Cc:     gitster@pobox.com, Jeff King <peff@peff.net>,
        Johannes.Schindelin@gmx.de, jehan@orb.com, whee@smaertness.net,
        me@ttaylorr.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <9DAA19D0-AE1A-493B-B6F5-2FA38E876928@gmail.com>
References: <20180708183036.29459-1-larsxschneider@gmail.com>
 <20180708183036.29459-3-larsxschneider@gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.8.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Jul 8, 2018, at 8:30 PM, larsxschneider@gmail.com wrote:
>=20
> From: Lars Schneider <larsxschneider@gmail.com>
>=20
> In 107642fe26 ("convert: add 'working-tree-encoding' attribute",
> 2018-04-15) we added an attribute which defines the working tree
> encoding of a file.
>=20
> Some platforms might spell the name of a certain encoding differently =
or
> some users might want to use different encodings on different =
platforms.
> Add the Git config "encoding.<iconv-name>.insteadOf =3D <alias-name>" =
to
> support these use-cases with a user specific mapping. If the alias
> matches an existing encoding name, then the alias will take =
precedence.
> The alias is case insensitive.
>=20
> Example:
>=20
> 	(in .gitattributes)
> 	*.c	working-tree-encoding=3Dfoo
>=20
> 	(in config)
> 	[encoding "UTF-16"]
> 		insteadOf =3D foo
>=20
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> Documentation/gitattributes.txt  | 19 ++++++++++++
> convert.c                        | 50 ++++++++++++++++++++++++++++++++
> t/t0028-working-tree-encoding.sh | 28 ++++++++++++++++++
> 3 files changed, 97 insertions(+)
>=20
> diff --git a/Documentation/gitattributes.txt =
b/Documentation/gitattributes.txt
> index 92010b062e..3628f0e5cf 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -366,6 +366,25 @@ command to guess the encoding:
> file foo.ps1
> ------------------------
>=20
> ...
>=20
> 	return 0;
> @@ -1225,6 +1264,17 @@ static const char =
*git_path_check_encoding(struct attr_check_item *check)
> 		die(_("true/false are no valid =
working-tree-encodings"));
> 	}
>=20
> +	/* Check if an alias was defined for the encoding in the Git =
config */
> +	if (encoding_aliases_initialized) {
> +		struct alias2enc hashkey;
> +		struct alias2enc *entry;
> +		hashmap_entry_init(&hashkey, strihash(value));
> +		hashkey.alias =3D value;
> +		entry =3D hashmap_get(&encoding_map, &hashkey, NULL);
> +		if (entry)
> +			value =3D entry->encoding;

Here I reuse the char* pointer from the hashmap.
The hashmap is static and no entry is ever removed.
Is this OK or should I rather create a copy of the string?

Thanks,
Lars

