Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42816C433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 11:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbiGHLyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 07:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbiGHLyD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 07:54:03 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E73620F6A
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 04:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657281235;
        bh=B4NBEPNkq4z1HhPDSZA0zTARIh1AQW03CPyhEQeG37U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iPbsnTaGrd16ZfjudY4+0wYYOVe41lnbQfqT1SxvC4EVk5LEh6UW5+hM+3Zgnz9IN
         S/709fCR+muSXPxtIjZ/px9/7NujmOD6EQ65rhksg23S/THDNo/ESHyC+F5lio9/n5
         VPjCcij9/ZeYH/X8AhYUZM3p9SRBPSylX4DBevaQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.164] ([213.196.212.225]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6v3-1nmYMS2cXr-00pafO; Fri, 08
 Jul 2022 13:53:55 +0200
Date:   Fri, 8 Jul 2022 13:53:55 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 4/4] cat-file: add mailmap support
In-Reply-To: <20220707161554.6900-5-siddharthasthana31@gmail.com>
Message-ID: <p3n4547s-6134-n4p9-97n5-so696qssr5n2@tzk.qr>
References: <20220630142444.651948-1-siddharthasthana31@gmail.com> <20220707161554.6900-1-siddharthasthana31@gmail.com> <20220707161554.6900-5-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TGGXWxF4WZtbmCoRMyRWcGl7tg7Hwhcde8VGPgyMrEJOkwpo6hu
 o69gECqBthoAUhkF07LGCeVOhqktIlDoJXcCk1NH5y2ry+X7pfKISqIIKEaO6O4ml9Fct2G
 dGhSHXPY/+LPIxew+GBHjTO25B5+0w7xcdwXfsxw7Ug4PFesJwjlRgxvxoAtSXQ8nakQJAS
 PzyfQra6sKj2Iv0ckTVOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1CX0RX5MMXU=:IfyAzr4UcttoasM4Zb35ae
 DV4nBQQN2r6JidA3lPJh5/RW6I7kDpEfD8bGOX676NR7gtxFgZ5/bnXPdohAd5nhajfpJtY++
 7m6C9lqiX+CzXD2Xxq8CN4oCX++HtkTNjs1cZYI1EhHFGMO6mw+6+VFpbRJa4c/+1XQtaYlAz
 XCp7DHfASU7PiMAJ5i753ONpByXdjTDCjMyyAL8HmV2QWdD4FTNwNxggGySM2hsazNmuGr1S4
 BQA/QJfA79crnXHP/zaPPJsyjJ6xu7wBIF9Gi+7yRj0UWqcSyd7AFQzA5OUGF9JqCK7rm8bPV
 yVDq3SdkKuvShplRqhlPZq7gJNqCR4DRgEGazLGqwlozkKhKyWrLz/D316vI/vqbSRRnYos54
 87sDpQhg9J/T8X9AsOuvcjwCZ5bIngkq9+Ql2fPt6ByxufKLK6OMXVDbrCPv7U0AP0kPSM0Vf
 BRDA3+ziE6EOm4ohS9K3FH5iHtjNbCLhGlGMBLJu+wv5XnnUVtlxkMOphEcU24RR091oxXzwK
 Qsupca9nl7nLGljC+2o8RbkS+dlL/CQwAK4n2+q4ToE0z9co86S638gLsIH1xE51lrJ116zuv
 RY+r2G8zrdvfTrZdcfgCI6sY5cbP0Cn9UB1Zdb2s/97u1hWR4h9oLJCO/Ba7ya9M7sjZDK+uc
 fLDrRlQJ/lFrqM/AI0tgG22HtAYKuDs73/C8cKB3PNM2Ta8dF4fKtzPJ3sLpAnQEdB5ThIZwu
 Bz+7FJIeoSF7ASZ8cBUUVRowEt5qCdATcoc6Ampq3mIoh0WSaYZd7Apgx3SElhpotr6O7Dclb
 bxe8LRARMyOzZ/aF6GO4L90KucSYjK6h8fvdrEBgGz6SJ+woHt0f831YkOm/R9C2jRsRrywSn
 BG0kijE5b73Qb716hugpAKfaEQrIZfxVpBBsxrwwDXmm944BvURAE1gA0ukdWE82davb9IuH4
 sEa8K2TfEkjX9l7XqFZK2bZR8c7leZAubx4AYOozUmICqRR2SaowHo9Evf948zj2kIH91wXFr
 Gk+74lWRP/ilPWswfQK863G5gYfXyWVM4bIxHztKjjI4JyE9k7layRsqIITqcmHSonaNdqMNQ
 qsoGrRpHCmoLwqyUrwfXSV3FuK16CnVXeX1lwFDsH+C+lxKwHioGZww9g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Siddarth,

On Thu, 7 Jul 2022, Siddharth Asthana wrote:

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 50cf38999d..6dc750a367 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -36,6 +37,19 @@ struct batch_options {
>
>  static const char *force_path;
>
> +static struct string_list mailmap =3D STRING_LIST_INIT_NODUP;
> +static int use_mailmap;
> +
> +char *replace_idents_using_mailmap(char *object_buf, size_t *size)

Here, we declare the `size` parameter as a pointer to a `size_t`.

> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	strbuf_attach(&sb, object_buf, *size, *size + 1);
> +	const char *headers[] =3D { "author ", "committer ", "tagger ", NULL }=
;
> +	apply_mailmap_to_header(&sb, headers, &mailmap);
> +	*size =3D sb.len;
> +	return strbuf_detach(&sb, NULL);
> +}
> +
>  static int filter_object(const char *path, unsigned mode,
>  			 const struct object_id *oid,
>  			 char **buf, unsigned long *size)
> @@ -152,6 +166,9 @@ static int cat_one_file(int opt, const char *exp_typ=
e, const char *obj_name,
>  		if (!buf)
>  			die("Cannot read object %s", obj_name);
>
> +		if (use_mailmap)
> +			buf =3D replace_idents_using_mailmap(buf, &size);

But here, we are once more bitten by Git's usage of last century's data
types: the `size` variable is of type `unsigned long`.

Now, you are probably developing this patch on 64-bit Linux or macOS,
where it just so happens that `size_t` is idempotent to `unsigned long`.

But that is not the case on 32-bit Linux nor on Windows, and therefore the
build fails with this patch. I need this to get the build to pass:

=2D- snipsnap --
=46rom 237c783705b30ed4bcce81aeb860dc7e152fc8bf Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 8 Jul 2022 13:47:52 +0200
Subject: [PATCH] fixup??? cat-file: add mailmap support

This is needed whenever `unsigned long` is different from `size_t`, e.g.
on 32-bit Linux and on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 builtin/cat-file.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ac852087a74..baa6aca53ce 100644
=2D-- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -185,8 +185,13 @@ static int cat_one_file(int opt, const char *exp_type=
, const char *obj_name,
 		if (!buf)
 			die("Cannot read object %s", obj_name);

-		if (use_mailmap)
-			buf =3D replace_idents_using_mailmap(buf, &size);
+		if (use_mailmap) {
+			size_t s;
+
+			buf =3D replace_idents_using_mailmap(buf, &s);
+
+			size =3D cast_size_t_to_ulong(s);
+		}

 		/* otherwise just spit out the data */
 		break;
@@ -222,8 +227,13 @@ static int cat_one_file(int opt, const char *exp_type=
, const char *obj_name,
 		buf =3D read_object_with_reference(the_repository, &oid,
 						 exp_type_id, &size, NULL);

-		if (use_mailmap)
-			buf =3D replace_idents_using_mailmap(buf, &size);
+		if (use_mailmap) {
+			size_t s;
+
+			buf =3D replace_idents_using_mailmap(buf, &s);
+
+			size =3D cast_size_t_to_ulong(s);
+		}
 		break;
 	}
 	default:
@@ -392,8 +402,13 @@ static void print_object_or_die(struct batch_options =
*opt, struct expand_data *d

 		contents =3D read_object_file(oid, &type, &size);

-		if (use_mailmap)
-			contents =3D replace_idents_using_mailmap(contents, &size);
+		if (use_mailmap) {
+			size_t s;
+
+			contents =3D replace_idents_using_mailmap(contents, &s);
+
+			size =3D cast_size_t_to_ulong(s);
+		}

 		if (!contents)
 			die("object %s disappeared", oid_to_hex(oid));
=2D-
2.37.0.windows.1

