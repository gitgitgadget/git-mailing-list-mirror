Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617111FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 21:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbdJHVhT (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 17:37:19 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:46748 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdJHVhR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 17:37:17 -0400
Received: by mail-wm0-f54.google.com with SMTP id m72so17992401wmc.1
        for <git@vger.kernel.org>; Sun, 08 Oct 2017 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LpYa25vu/yuknXBO0bc7Ad7Hie+5M6QE9JUjdO1la90=;
        b=Xnu84+tKZB7qA28gmuISsahd8X7dasYqTZptlJq7rxHtKii/lTaElc9vA/8f4CCU37
         fKbh3qzM4nyqy5STdc1rW2ZgIQNF4lfWcXjuAHmskAh7goxnvvWAeVKtcWql34Mbhb9N
         JdJ8pYLBlN0GfyhlgpFOtloGE/zNMjaLARV4sRvtFKVa80yaylFiYgngvo+EVWhd4GL5
         7HlavkFpXCZiGJSBw9d+Gp0jvY6Ki/EGXcUihCZ2mHW52B8ASCRbMvhkoQcl5+cXX9H5
         0rZZDMaqTWgqf5XSPsS8mnykJXP37VwbOSdO8yDe9zwPuxC+e9MoIRAONEt/t5D+34yN
         4m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LpYa25vu/yuknXBO0bc7Ad7Hie+5M6QE9JUjdO1la90=;
        b=tNyHpU7IBxPKOzPC3oaGsBkSpHHJftKGwlCCyFiVfEoiyE4+kb8noBPsWVsNb5wAyn
         lntbRZ9mPEVaAtgIOsXfLX5y9uWsvuhsoOKcw6szWWg2DnhqfSsf8c8O+I7uirM4H1sK
         wE8Od0D5u8ESnC7EF39BUuImW/qVqMbz/dnzrYjisLcqhoR19X1jnONL5/efq8oK+q9l
         iTGUyfe9lU+7AD5UuatEf3zzp3Whq1gv4DYQb6A0/DJ9nE/wF9/nMLRxsHcR1mtNs21Q
         /TzZ3ZmDP2l5c1a5mOv3+/pncw5pkDOuTb7HS/DURM+Uivc4w6zKp6VLbEszPipLjg8J
         F2Wg==
X-Gm-Message-State: AMCzsaUJEYIYeOJeQxFBvhi/TfwQ7tVurT87oLgRL9960mffiLgI02E+
        RwsDG0XoBbGpUonty6h09Jw=
X-Google-Smtp-Source: AOwi7QCyy3+E+BfgTFdtcTinvynyMQdg5qHxH80cYF0urqLUSu0yMLyBO5DnZhYmuOOoMUsytTvx4g==
X-Received: by 10.223.197.13 with SMTP id q13mr8195120wrf.80.1507498636532;
        Sun, 08 Oct 2017 14:37:16 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5615.dip0.t-ipconnect.de. [93.219.86.21])
        by smtp.gmail.com with ESMTPSA id 55sm6386928wrw.60.2017.10.08.14.37.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Oct 2017 14:37:15 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 1/2] entry.c: update cache entry only for existing files
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20171006045440.2imc2c7hvu5d3hdk@sigill.intra.peff.net>
Date:   Sun, 8 Oct 2017 23:37:14 +0200
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC9D1B20-C056-4739-9FE3-692CA75FC128@gmail.com>
References: <20171005104407.65948-1-lars.schneider@autodesk.com> <20171005104407.65948-2-lars.schneider@autodesk.com> <xmqqk2097sge.fsf@gitster.mtv.corp.google.com> <20171005112658.p7hohhtkdkcapwe6@sigill.intra.peff.net> <xmqqefqh6vxf.fsf@gitster.mtv.corp.google.com> <20171006045440.2imc2c7hvu5d3hdk@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Oct 2017, at 06:54, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Oct 06, 2017 at 08:01:48AM +0900, Junio C Hamano wrote:
>=20
>>> But
>>> I think we'd want to protect the read_blob_entry() call at the top =
of
>>> the case with a check for dco->state =3D=3D CE_RETRY.
>>=20
>> Yeah, I think that makes more sense.
>>=20
>> A patch may look like this on top of these two patches, but I'd
>> prefer to see Lars's eyeballing and possibly wrapping it up in an
>> applicable patch after taking the authorship.
>=20

This looks all good to me. Thank you!
A few minor style suggestions below.


> ...
>=20
> The "structured" way, of course, would be to put everything under
> write_out_file into a helper function and just call it from both =
places
> rather than relying on a spaghetti of gotos and switch-breaks.
>=20
> I'm OK with whatever structure we end up with, as long as it fixes the
> leak (and ideally the pessimization).
>=20
> Anyway, here's the real patch in case anybody wants to apply it and =
play
> with it further.
>=20
> -- >8 --
> diff --git a/entry.c b/entry.c
> index 1c7e3c11d5..d28b42d82d 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -261,6 +261,7 @@ static int write_entry(struct cache_entry *ce,
> 	size_t newsize =3D 0;
> 	struct stat st;
> 	const struct submodule *sub;
> +	struct delayed_checkout *dco =3D state->delayed_checkout;
>=20
> 	if (ce_mode_s_ifmt =3D=3D S_IFREG) {
> 		struct stream_filter *filter =3D =
get_stream_filter(ce->name,
> @@ -273,55 +274,61 @@ static int write_entry(struct cache_entry *ce,
> 	}
>=20
> 	switch (ce_mode_s_ifmt) {
> -	case S_IFREG:
> 	case S_IFLNK:
> 		new =3D read_blob_entry(ce, &size);
> 		if (!new)
> 			return error("unable to read sha1 file of %s =
(%s)",
> 				path, oid_to_hex(&ce->oid));
>=20
> -		if (ce_mode_s_ifmt =3D=3D S_IFLNK && has_symlinks && =
!to_tempfile) {
> -			ret =3D symlink(new, path);
> -			free(new);
> -			if (ret)
> -				return error_errno("unable to create =
symlink %s",
> -						   path);

Nit: This could go into one line now.


> -			break;
> -		}
> +		/* fallback to handling it like a regular file if we =
must */
> +		if (!has_symlinks || to_tempfile)
> +			goto write_out_file;
>=20
> +		ret =3D symlink(new, path);
> +		free(new);
> +		if (ret)
> +			return error_errno("unable to create symlink =
%s",
> +					   path);
> +		break;
> +
> +	case S_IFREG:
> 		/*
> 		 * Convert from git internal format to working tree =
format
> 		 */
> -		if (ce_mode_s_ifmt =3D=3D S_IFREG) {
> -			struct delayed_checkout *dco =3D =
state->delayed_checkout;
> -			if (dco && dco->state !=3D CE_NO_DELAY) {
> -				/* Do not send the blob in case of a =
retry. */
> -				if (dco->state =3D=3D CE_RETRY) {

Maybe we could add here something like:
            /* The filer process got the blob already in case of a =
retry. Unnecessary to send it, again! */

> -					new =3D NULL;
> -					size =3D 0;
> -				}
> -				ret =3D async_convert_to_working_tree(
> -					ce->name, new, size, &buf, dco);

Nit: This could go into one line now.


> -				if (ret && =
string_list_has_string(&dco->paths, ce->name)) {
> -					free(new);
> -					goto finish;
> -				}
> -			} else
> -				ret =3D convert_to_working_tree(
> -					ce->name, new, size, &buf);

Nit: This could go into one line now.


>=20
> -			if (ret) {
> +		if (dco && dco->state =3D=3D CE_RETRY) {
> +			new =3D NULL;
> +			size =3D 0;
> +		} else {
> +			new =3D read_blob_entry(ce, &size);
> +			if (!new)
> +				return error ("unable to read sha1 file =
of %s (%s)",
> +					      path, =
oid_to_hex(&ce->oid));
> +		}
> +
> +		if (dco && dco->state !=3D CE_NO_DELAY) {
> +			ret =3D async_convert_to_working_tree(
> +							    ce->name, =
new, size, &buf, dco);
> +			if (ret && string_list_has_string(&dco->paths, =
ce->name)) {
> 				free(new);
> -				new =3D strbuf_detach(&buf, &newsize);
> -				size =3D newsize;
> +				goto finish;
> 			}
> -			/*
> -			 * No "else" here as errors from convert are OK =
at this
> -			 * point. If the error would have been fatal =
(e.g.
> -			 * filter is required), then we would have died =
already.
> -			 */
> +		} else
> +			ret =3D convert_to_working_tree(
> +						      ce->name, new, =
size, &buf);
> +
> +		if (ret) {
> +			free(new);
> +			new =3D strbuf_detach(&buf, &newsize);
> +			size =3D newsize;
> 		}
> +		/*
> +		 * No "else" here as errors from convert are OK at this
> +		 * point. If the error would have been fatal (e.g.
> +		 * filter is required), then we would have died already.
> +		 */
>=20
> +write_out_file:
> 		fd =3D open_output_fd(path, ce, to_tempfile);
> 		if (fd < 0) {
> 			free(new);

...

>		break;
>	case S_IFGITLINK:

Maybe add a newline above "S_IFGITLINK" and "default" for readability.=20=

Above "case S_IFREG:" we have a newline, too.=20


- Lars






