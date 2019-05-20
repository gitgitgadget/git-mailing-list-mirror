Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEEBF1F462
	for <e@80x24.org>; Mon, 20 May 2019 16:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392248AbfETQge (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 12:36:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:37709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731223AbfETQgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 12:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558370189;
        bh=NtOkTb7wRv7g308DYMi+FuAZjzEIu7uuphiB+SDf/Uo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=N8RrvKmO6X0jt1izPZc+WGSS7dwjfaO0vCfSPtPLg0ztaV3dxdAiaBH94sHxOzgF5
         +SLBnBut1vo0d5KuqDfUhNnkeafUQ9VYn4IUkmn/4MVhzO7X5IyVgS3r7H4QFC0bj1
         DampGG5Amo8u2DfGWoA3CsU/cOxbAFEpLPvrlWdU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LvhC4-1gagE43zjw-017TNy; Mon, 20
 May 2019 18:36:29 +0200
Date:   Mon, 20 May 2019 18:36:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] transport_anonymize_url(): support retaining
 username
In-Reply-To: <20190519051031.GA19434@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1905201834450.46@tvgsbejvaqbjf.bet>
References: <20190519050724.GA26179@sigill.intra.peff.net> <20190519051031.GA19434@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Jd0G3aaHapF39ysPRzwmAmv5zlZRft6lh+fMwkx014rske0ntki
 h13rIRSVcrLDDu+dOn7dFkStiychbirCF+id054bwf1W9X7jDE/ppvQMGwJVcjO7lvlEF2N
 hqt4ZkamfhaNYdpsT3DsPRaXz/P6hNYKs3POrDtW/T7GDfD4CT2aOzEdeZUWKWXVynEkotA
 ISFbiez6JTNEfzXcILIcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aaiK/ZBOLqg=:+b8S+jjb/HbOX4ySPFSBGQ
 LFtF8TxRaVmPKsdDwh6y8UBRXrLiIxb3XmSd/m60ZHmBwZjYQYYbsVNJhuoRx229QjbbehKHy
 UOaBzSHIYB6J+fKlH4skG6QcYg6TAENMgK0stvScSbkg/fy1byjKEOMLfoBgOPNosY/b0+W99
 V+Ty+/MxVlHE6TLwoT35E1SRxY5wlY4SKM0UAnyZVCp8FHn9tV4UibACv7nhu+1X0USy9TICm
 zTIIR/WxoeWm175+pcxn+axzpp+KZDKSwz/M+4kphlUkTY/5bltPr79s5SHxaVICc3DUQoKl7
 0M5rDQdMgjBmKVSiQmDcOsWh5eV0ULceoBCAJrKTv1jmsVDZpSL5zDaYeFCuMwiZE4z8oczes
 QXV/MFYQZa7gVoQ5t12lnsPxyq+8ttwgqM4Yv6gwHTILxv5CrreSZtxOSz5f96m0tnyHS+iuW
 5uvc53oj9jhJ0rqzDW9kNNh6jBz8aKhjToctu78nS1BTc8/Dl9J4rdNayFeDQ/yPwLGmndHAj
 Jywftn+WrwYJ+O8zVXFUEZVyJLhwflBkCEC9iiWFIZqBSlafvdhpPOEFue5ZCjYrnSqRiBOrd
 ro5V5qYF5LoRdU0+eNiHeX2lCVvDj4g1ihDfeiTKgUkFDFtQx4CH8dIMCSBsMi90Yxtz21T+l
 m/AWW6xrWlopEJ7Slrzgp0Bn1oHXynNl3p27QXv4Zu4htIERrCJO1M2epE2GBsWJrI8iHOw3c
 bdzfxHE7/cJkCEO+FDZCB6+j9OCfhTKDFS+3ghrCuxH5Y4K1LO4NgmlfGEKQBkbNmgROLF9CW
 Q9KvCKRv/DQjGfk2Ay/GoS3ZjdBPl+23+rQJrLuTOZGco/OThl+9BH8WVNw9Yla4WdG/LNPWF
 mQHH0DcYO1VY77Wp3bhioESEodCJhEi98GAV/ToRIDEXOT0Y0gdjhGp5vrT3eVWo0o8LO5BoW
 N2NWF1tiGtuSQb5nGc6GXCMbZwg+B+kR5RThP4ZWJK9xaN4EgPwyH
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sun, 19 May 2019, Jeff King wrote:

> When we anonymize URLs to show in messages, we strip out both the
> username and password (if any). But there are also contexts where we
> should strip out the password (to avoid leaking it) but retain the
> username.
>
> Let's generalize transport_anonymize_url() to support both cases. We'll
> give it a new name since the password-only mode isn't really
> "anonymizing", but keep the old name as a synonym to avoid disrupting
> existing callers.
>
> Note that there are actually three places we parse URLs, and this
> functionality _could_ go into any of them:
>
>   - transport_anonymize_url(), which we modify here
>
>   - the urlmatch.c code parses a URL into its constituent parts, from
>     which we could easily remove the elements we want to drop and
>     re-format it as a single URL. But its parsing also normalizes
>     elements (e.g., downcasing hostnames).  This isn't wrong, but it's
>     more friendly if we can leave the rest of the URL untouched.

I have not looked into it at all, but I seem to vaguely remember that the
result of this code might be used to look up `url.<url>.insteadOf`
settings, where the middle part *is* case-sensitive.

>   - credential_form_url() parses a URL and decodes the specific
>     elements, but it's hard to convert it back into a regular URL. It
>     treats "host:port" as a single unit, meaning it needs to be
>     re-encoded specially (since a colon would otherwise end
>     percent-encoded).
>
> Since transport_anonymize_url() seemed closest to what we want here, I
> used that as the base.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I think it would be beneficial to unify these three cases under a single
> parser, but it seemed like too big a rabbit hole for this topic. Of the
> three, the urlmatch one seems the most mature. I think if we could
> simply separate the normalization from the parsing/decoding, the others
> could build on top of it. It might also require some careful thinking
> about how pseudo-urls like ssh "host:path" interact.

In light of what I mentioned above, I am not sure that we should go there
in the first place...

Thanks,
Dscho

> I won't call that a #leftoverbits, because it's more of a feast. :)
>
>  transport.c | 21 ++++++++++++++-------
>  transport.h | 11 ++++++++++-
>  2 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/transport.c b/transport.c
> index f1fcd2c4b0..ba61e57295 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1335,11 +1335,7 @@ int transport_disconnect(struct transport *transp=
ort)
>  	return ret;
>  }
>
> -/*
> - * Strip username (and password) from a URL and return
> - * it in a newly allocated string.
> - */
> -char *transport_anonymize_url(const char *url)
> +char *transport_strip_url(const char *url, int strip_user)
>  {
>  	char *scheme_prefix, *anon_part;
>  	size_t anon_len, prefix_len =3D 0;
> @@ -1348,7 +1344,10 @@ char *transport_anonymize_url(const char *url)
>  	if (url_is_local_not_ssh(url) || !anon_part)
>  		goto literal_copy;
>
> -	anon_len =3D strlen(++anon_part);
> +	anon_len =3D strlen(anon_part);
> +	if (strip_user)
> +		anon_part++;
> +
>  	scheme_prefix =3D strstr(url, "://");
>  	if (!scheme_prefix) {
>  		if (!strchr(anon_part, ':'))
> @@ -1373,7 +1372,15 @@ char *transport_anonymize_url(const char *url)
>  		cp =3D strchr(scheme_prefix + 3, '/');
>  		if (cp && cp < anon_part)
>  			goto literal_copy;
> -		prefix_len =3D scheme_prefix - url + 3;
> +
> +		if (strip_user)
> +			prefix_len =3D scheme_prefix - url + 3;
> +		else {
> +			cp =3D strchr(scheme_prefix + 3, ':');
> +			if (cp && cp > anon_part)
> +				goto literal_copy; /* username only */
> +			prefix_len =3D cp - url;
> +		}
>  	}
>  	return xstrfmt("%.*s%.*s", (int)prefix_len, url,
>  		       (int)anon_len, anon_part);
> diff --git a/transport.h b/transport.h
> index 06e06d3d89..6d8c99ac91 100644
> --- a/transport.h
> +++ b/transport.h
> @@ -243,10 +243,19 @@ const struct ref *transport_get_remote_refs(struct=
 transport *transport,
>  int transport_fetch_refs(struct transport *transport, struct ref *refs)=
;
>  void transport_unlock_pack(struct transport *transport);
>  int transport_disconnect(struct transport *transport);
> -char *transport_anonymize_url(const char *url);
>  void transport_take_over(struct transport *transport,
>  			 struct child_process *child);
>
> +/*
> + * Strip password and optionally username from a URL and return
> + * it in a newly allocated string (even if nothing was stripped).
> + */
> +char *transport_strip_url(const char *url, int strip_username);
> +static inline char *transport_anonymize_url(const char *url)
> +{
> +	return transport_strip_url(url, 1);
> +}
> +
>  int transport_connect(struct transport *transport, const char *name,
>  		      const char *exec, int fd[2]);
>
> --
> 2.22.0.rc0.583.g23d90da2b3
>
>
