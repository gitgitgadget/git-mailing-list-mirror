Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AD211FADF
	for <e@80x24.org>; Mon,  8 Jan 2018 14:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933085AbeAHOi4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jan 2018 09:38:56 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:37637 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932575AbeAHOiz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jan 2018 09:38:55 -0500
Received: by mail-wr0-f178.google.com with SMTP id f8so10973712wre.4
        for <git@vger.kernel.org>; Mon, 08 Jan 2018 06:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wr34EkR/8VGd95wazMPbeHmSDj6wPJfILwjMFQ0YqqM=;
        b=XNhmr1tX9VKrhjZKjakhwoqQuwTlWXC72zdBezQh4clDl2NKH741KSXTyML7jhrGr1
         6loAkJD7e7CL0m54sk2STZElVSKVEKvGoE/1p1lVxMIx4ggNsZEYj1D8nCX13xR47QIJ
         od6bLTo9sDWHU3+uAgTCRYjw1fwNGtQ3wzOsJN+6FSGa+XnTfP6KYYMizPPLquLWBoQm
         sy562YPO/bgulw4K+xS+MNKFKXzBLV1kBiXwvs0tGO81J5fSLPgzxjrotvDtQj8smu7p
         xU6ImLLGBYstaaZO+wDDhsjw2KjRh1WOdRyGhzupNNyLbJk6wlv3KqrgDSqZWowIgHii
         DQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wr34EkR/8VGd95wazMPbeHmSDj6wPJfILwjMFQ0YqqM=;
        b=e4XsqsPWl9PxAdaWh9albl3uuLJ7d6Casid+ziotYrLa00vDLnzMHQJV2/CuF4SZMo
         eCQDsoK+DwZSzqTF+0LvtPUJJAnlH2uDXfcboWPxWq/XrW1IFT8xCS2mGmLuUgzIcLz+
         g1Jj3H2fos1AGslUldPl6gMXmInSUIurGidOIxQdr0M9cJ5yUBdUwVeSgtrNqTdAT0dL
         aLNFgKhrXHfdudpaiO7zSRJV5JB/hfKwgDzQn6dAXQDaKR0wuY/AQkctfmDGTiT7ct6u
         vxZES1XB6eyXUUZkXRI3HzsFaqhZD9r/w2m97iEmUuSomDYybkrIpMQxF1CBtiINs3WE
         4A+g==
X-Gm-Message-State: AKGB3mIsht7KnQNFx6lfRpHiz2OQje6Y7Wz9hWIoCnFKl+xMUmDmGHAr
        K8E1OPS6yqeLt6YunsxXly0=
X-Google-Smtp-Source: ACJfBotWwGgV1cxNE0o4LP5BmPWFtG/KUwEVnfXBp3FFbUh/Vuvq2Ml1Mx3wKUlFamY0NgHU3eMl9w==
X-Received: by 10.223.192.134 with SMTP id d6mr6408827wrf.206.1515422334275;
        Mon, 08 Jan 2018 06:38:54 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 201sm13483898wmm.38.2018.01.08.06.38.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Jan 2018 06:38:53 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 0/7] convert: add support for different encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180107093815.GA7442@tor.lan>
Date:   Mon, 8 Jan 2018 15:38:48 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de,
        =?utf-8?Q?Patrick_L=C3=BChne?= <patrick@luehne.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B51940E6-95AB-424A-AF62-0018E9934279@gmail.com>
References: <20180106004808.77513-1-lars.schneider@autodesk.com> <20180107093815.GA7442@tor.lan>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Jan 2018, at 10:38, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On Sat, Jan 06, 2018 at 01:48:01AM +0100, lars.schneider@autodesk.com =
wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Hi,
>>=20
>> Patches 1-5 and 6 are helper functions and preparation.
>> Patch 6 is the actual change.
>>=20
>> I am still torn between "checkout-encoding" and =
"working-tree-encoding"
>> as attribute name. I am happy to hear arguments for/against one or =
the
>> other.
>=20
> checkout-encoding is probably misleading, as it is even the =
checkin-encoding.

Yeah, I start to think the same.


> What is wrong with working-tree-encoding ?
> I think the 2 "-".
>=20
> What was wrong with workingtree-encoding ?

Yeah, the two dashes are a minor annoyance.

However, consider this:

$ git grep 'working tree' -- '*.txt' | wc -l
     570

$ git grep 'working-tree' -- '*.txt' | wc -l
       6

$ git grep 'workingtree' -- '*.txt' | wc -l
       0


$ git grep 'working tree' -- po | wc -l
     704

$ git grep 'working-tree' -- po | wc -l
       0

$ git grep 'workingtree' -- po | wc -l
       0

I think "working tree" is a pretty established term that
endusers might be able to understand. Therefore, I would
like to go with "working-tree-encoding" as it was written
that way at least 6 times in the Git tree before.

Would that work for you?


> Or
> workdir-encoding ?

Although I like the shortness, the term "workdir" might already=20
be occupied [1]. Could that cause confusion?

[1] 4f01748d51 (contrib/workdir: add a simple script to create a working =
directory, 2007-03-27)


>>=20
>> * Removed unnecessary NUL assignment in xstrdup_tolower() (Torsten)
>>=20
>> * Set "git config core.eol lf" to made the test run on Windows =
(Dscho)
>>=20
>> * Made BOM arrays static (Ramsay)
>=20
>=20
> Some comments:
>=20
> I would like to have the CRLF conversion a little bit more strict -
> many users tend to set core.autocrlf=3Dtrue or write "* text=3Dauto"
> in the .gitattributes.
> Reading all the effort about BOM markers and UTF-16LE, I think there
> should ne some effort to make the line endings round trip.
> Therefore I changed convert.c to demand that the "text" attribute
> is set to enable CRLF conversions.
> (If I had submitted the patch, I would have demanded
> "text eol=3Dlf" or "text eol=3Dcrlf", but the test case t0028 =
indicates
> that there is a demand to produce line endings as configured in =
core.eol)

But wouldn't that be inconvenient for the users? E.g. if I add a UTF-16
file on Windows with CRLF then it would be nice if Git would =
automatically
convert the line endings to LF on Linux, no?

IOW: Why should we handle text files that have a defined =
checkout-encoding
differently compared to UTF-8 encoded text files? Wouldn't that be =
unexpected
to the user?

Thanks,
Lars



>=20
> Anyway, I rebased it onto git.git/master, changed the docu, and pushed =
it to
> =
https://github.com/tboegi/git/tree/180107-0935-For-lars-schneider-encode-V=
3B
>=20
> Here is a inter-diff against your version:
>=20
> diff --git a/Documentation/gitattributes.txt =
b/Documentation/gitattributes.txt
> index 1bc03e69c..b8d9f91c8 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -281,7 +281,7 @@ interpreted as binary and consequently built-in =
Git text processing
>  tools (e.g. 'git diff') as well as most Git web front ends do not
>  visualize the content.
>=20
> -In these cases you can teach Git the encoding of a file in the =
working
> +In these cases you can tell Git the encoding of a file in the working

Oops. I meant to change that already. Thanks!

>  directory with the `checkout-encoding` attribute. If a file with this
>  attributes is added to Git, then Git reencodes the content from the
>  specified encoding to UTF-8 and stores the result in its internal =
data
> @@ -308,17 +308,20 @@ Use the `checkout-encoding` attribute only if =
you cannot store a file in
>  UTF-8 encoding and if you want Git to be able to process the content =
as
>  text.
>=20
> +Note that when `checkout-encoding` is defined, by default the line
> +endings are not converted. `text=3Dauto` and core.autocrlf are =
ignored.
> +Set the `text` attribute to enable CRLF conversions.
> +
>  Use the following attributes if your '*.txt' files are UTF-16 encoded
> -with byte order mark (BOM) and you want Git to perform automatic line
> -ending conversion based on your platform.
> +with byte order mark (BOM).
>=20
>  ------------------------
> -*.txt		text checkout-encoding=3DUTF-16
> +*.txt		checkout-encoding=3DUTF-16
>  ------------------------
>=20
>  Use the following attributes if your '*.txt' files are UTF-16 little
> -endian encoded without BOM and you want Git to use Windows line =
endings
> -in the working directory.
> +endian encoded without BOM and you want Git to use LF in the repo and
> +CRLF in the working directory.
>=20
>  ------------------------
>  *.txt 		checkout-encoding=3DUTF-16LE text eol=3DCRLF
> diff --git a/convert.c b/convert.c
> index 13f766d2a..1e29f515e 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -221,18 +221,27 @@ static void check_global_conv_flags_eol(const =
char *path, enum crlf_action crlf_
>  	}
>  }
>=20
>=20
>  static int will_convert_lf_to_crlf(size_t len, struct text_stat =
*stats,
> @@ -432,7 +441,7 @@ static int crlf_to_git(const struct index_state =
*istate,
>  		 * cherry-pick.
>  		 */
>  		if ((!(conv_flags & CONV_EOL_RENORMALIZE)) &&
> -		    has_cr_in_index(istate, path))
> +		    has_crlf_in_index(istate, path))
>  			convert_crlf_into_lf =3D 0;
>  	}
>  	if (((conv_flags & CONV_EOL_RNDTRP_WARN) ||
> @@ -1214,9 +1223,28 @@ static void convert_attrs(struct conv_attrs =
*ca, const char *path)
>  			ca->crlf_action =3D git_path_check_crlf(ccheck + =
0);
>  		ca->ident =3D git_path_check_ident(ccheck + 1);
>  		ca->drv =3D git_path_check_convert(ccheck + 2);
> +		ca->checkout_encoding =3D git_path_check_encoding(ccheck =
+ 5);
>  		if (ca->crlf_action !=3D CRLF_BINARY) {
>  			enum eol eol_attr =3D git_path_check_eol(ccheck =
+ 3);
> -			if (ca->crlf_action =3D=3D CRLF_AUTO && eol_attr =
=3D=3D EOL_LF)
> +			if (ca->checkout_encoding) {
> +				enum crlf_action crlf_action =3D =
CRLF_BINARY;
> +				/*
> +				 * encoded files don't use auto.
> +				 * 'text' must be specified to
> +				 * do crlf conversions
> +				 */
> +				if (ca->crlf_action =3D=3D CRLF_TEXT) {
> +					if (eol_attr =3D=3D EOL_LF)
> +						crlf_action =3D =
CRLF_TEXT_INPUT;
> +					else if (eol_attr =3D=3D =
EOL_CRLF)
> +						crlf_action =3D =
CRLF_TEXT_CRLF;
> +					else if (text_eol_is_crlf())
> +						crlf_action =3D =
CRLF_TEXT_CRLF;
> +					else
> +						crlf_action =3D =
CRLF_TEXT_INPUT;
> +				}
> +				ca->crlf_action =3D crlf_action;
> +			} else if (ca->crlf_action =3D=3D CRLF_AUTO && =
eol_attr =3D=3D EOL_LF)
>  				ca->crlf_action =3D CRLF_AUTO_INPUT;
>  			else if (ca->crlf_action =3D=3D CRLF_AUTO && =
eol_attr =3D=3D EOL_CRLF)
>  				ca->crlf_action =3D CRLF_AUTO_CRLF;
> @@ -1225,11 +1253,11 @@ static void convert_attrs(struct conv_attrs =
*ca, const char *path)
>  			else if (eol_attr =3D=3D EOL_CRLF)
>  				ca->crlf_action =3D CRLF_TEXT_CRLF;
>  		}
> -		ca->checkout_encoding =3D git_path_check_encoding(ccheck =
+ 5);
>  	} else {
>  		ca->drv =3D NULL;
>  		ca->crlf_action =3D CRLF_UNDEFINED;
>  		ca->ident =3D 0;
> +		ca->checkout_encoding =3D NULL;
>  	}
>=20
>  	/* Save attr and make a decision for action */
>=20
>=20

