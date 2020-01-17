Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2748BC33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 10:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95A82072B
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 10:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SV7gJEjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgAQKyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:54:41 -0500
Received: from mout.gmx.net ([212.227.17.22]:58513 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgAQKyl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 05:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579258471;
        bh=NQql8lr+hyMuw4B79hZ1RUuvoxTczGsy5hVWfTEzO3s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SV7gJEjfmxAqQrO9i3e14hoNhyTzxYPs9FTJOqn7mVQMCM0G6XDktyqxBLvAxT3e9
         T2t479XnuPy8BMrFkse4CV15Q5k18+KfhCrUFj1HWJSjSH/nLENxI2VqXQGSKNx3aT
         mNAPdE9q6KYhNadgNda/1D2IkrlXr+dC08KIvwXA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1jNunS2MYn-00o1UG; Fri, 17
 Jan 2020 11:54:31 +0100
Date:   Fri, 17 Jan 2020 11:54:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] fetch: emphasize failure during submodule fetch
In-Reply-To: <20200116222012.162642-1-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.2001171152410.46@tvgsbejvaqbjf.bet>
References: <20200116222012.162642-1-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:QwF5/kGMEvkSopOs0KAJr0M0dcaQ8tuXovsG8zTxgvEZpcP2rkA
 Up7ycOnobYfPIIwkxbtyYDjQkcwy/Qf6r4tNIjkkuZhDMXdY9MYHZ2ZO0ZDbEtUG0VLATqz
 NAx/h49lDt/wvmvk9dO2OTK9gnlBa4h9xSgKLU9DiXvOSJTpTXMxxnOpzzpgE85KY03F7yd
 peCEMFf7JnszpX8n/w4Ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eNJJMGF3HaI=:zR0VkcHoz+SH2iSmCRdX/C
 YW397hrRwZk/Zl3N8xNyxPTsOkHYujSK7mdz8Qnhu9FWJccjYmQWoXMoy6jWYgOHhAJy2Ovdf
 TkUBiMG/B/bcGbtWKpjyHWXTG+kiflGo59F7++Z9OOHkDmMWC9DTb3EocDSV0k98+9OLSGrMs
 bO5x4EJxXzKYAkAQr+8pny1Es3N3fgpHiCoaBX1maH0xDK3guQGrm8ocvl+FgYk7jXK5ylbl/
 c769eA/ybw2hNyAbur9ExAaQ6rpLUVIWEOFrRwT6mirQp6pAH4A1kk7QUAzEWHz0xyzBFSI9r
 B6rfQ0InB41DgztnIo7jYGJ7wrpQ+DzLmV2UKei77IK73xnDVyC8ucC9EbU+HKDIbfuBqqs7r
 sElpJGMeTaDVYcK/2nqvCf3wNuOLNWDBXZWInpo8JO5dZlHSng/kKO35o0F8mBmDL1D/Yskne
 tizrlCwm+0QwuNxIRS+gwuxjOsI/uUEtHvHJywALg1CoJ9QBdQYrQnffVZbc2HGKxqROLpUN6
 AqR6bS6U5yM8t5ivvcIRqAFY3t0ec3UTCWR+AQrs9aCgtP39ZuatNNmskZGSTtMOMBeOgaTZe
 he01NYi5HMXQC+A63VxPEQw+8jGQcq2Ta5JOl9Gth0nvLJFiKU1bWeGi8QF9qA8hPudz5dv9D
 tG656wpNPAT3Pk4Ow7bEcORNMJpn2FI3npnl+2bD96tRaYWpNCwimWxbRai61naaKRkGQ1HFH
 F30i8E50Mqk38SSfdEZfQVy/zIA0SJ9G3TBCPtrflZBQkXf6pR7SOqnaxsgKvkzfWRYQSaLLC
 qcakbtO5z+MbcvAw0GXE1yJbSrQqjvBaXEwLFxEHiT/kfuNTT/EaHZSTGjQK33sBUTnJk6yB1
 8pbF+YCCJ4WH02jrn2FrZ/oyYyvlbFn2H8HyrjY1geqTIp2R5YDDas+kdEkTG14SCRH1+BclV
 9cmOv4G7+Psxqj+BGlgTE9sbSKgCGu6s1dN9WpCkBgsYHVpJtrcoUPeGJ5Sgne8x4NN8QrVHp
 CIT+qNSIRFARxS4GuOzdOBQ3TjFGuAra+G604RessDsvA77tWpILt5sXuEQd+86ynqfWI2utf
 LFSDIIaTdEqkuaH8gf8NXDkkSmGtn2tKCpJt7Jx0uw5mLx6M/hKBcfySEyvPEaL8lPAVrSohY
 K6iGMdjiFajkbnixUujeVxHN9vijXriMFrN8yMr4/5UylRMPdEQTvaNRSY5nQCtx0ofSR9KEC
 Hqa4+P1fMGqIvsqfMaA++L5kmYjVAFr95GeDStbPpjBz6LJZPGzupRh+DhwA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 16 Jan 2020, Emily Shaffer wrote:

> In cases when a submodule fetch fails when there are many submodules, th=
e error
> from the lone failing submodule fetch is buried under activity on the ot=
her
> submodules if more than one fetch fell back on fetch-by-oid. Call out a =
failure
> late so the user is aware that something went wrong, and where.
>
> Because fetch_finish() is only called synchronously by
> run_processes_parallel, mutexing is not required around
> submodules_with_errors.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> Since v2, removed mutexing as run_processes_parallel() creates
> subprocesses, not threads, and is in fact synchronous. Also added
> translation marker for the error message.

Excellent. For Git for Windows' ever-green branch based on `pu`, I had to
introduce this:

=2D- snip --
Subject: [PATCH] fixup??? fetch: emphasize failure during submodule fetch

This would be the first user of `PTHREAD_MUTEX_INITIALIZER`, but as we
have a hard time to emulate this with critical sections in Windows,
let's not do that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 submodule.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index a65db54cece..ec54f4db2cd 100644
=2D-- a/submodule.c
+++ b/submodule.c
@@ -1286,7 +1286,7 @@ struct submodule_parallel_fetch {
 };
 #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
 		  STRING_LIST_INIT_DUP, \
-		  NULL, 0, 0, STRBUF_INIT, PTHREAD_MUTEX_INITIALIZER}
+		  NULL, 0, 0, STRBUF_INIT}

 static int get_fetch_recurse_config(const struct submodule *submodule,
 				    struct submodule_parallel_fetch *spf)
@@ -1614,6 +1614,7 @@ int fetch_populated_submodules(struct repository *r,
 	spf.default_option =3D default_option;
 	spf.quiet =3D quiet;
 	spf.prefix =3D prefix;
+	pthread_mutex_init(&spf.submodule_errors_mutex, NULL);

 	if (!r->worktree)
 		goto out;
=2D- snap --

I look forward to v3 hitting `pu` and making this change obsolete.

Thanks,
Dscho

>
>  - Emily
>
>  submodule.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 9da7181321..ee74acee27 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1280,10 +1280,12 @@ struct submodule_parallel_fetch {
>  	/* Pending fetches by OIDs */
>  	struct fetch_task **oid_fetch_tasks;
>  	int oid_fetch_tasks_nr, oid_fetch_tasks_alloc;
> +
> +	struct strbuf submodules_with_errors;
>  };
>  #define SPF_INIT {0, ARGV_ARRAY_INIT, NULL, NULL, 0, 0, 0, 0, \
>  		  STRING_LIST_INIT_DUP, \
> -		  NULL, 0, 0}
> +		  NULL, 0, 0, STRBUF_INIT}
>
>  static int get_fetch_recurse_config(const struct submodule *submodule,
>  				    struct submodule_parallel_fetch *spf)
> @@ -1547,7 +1549,10 @@ static int fetch_finish(int retvalue, struct strb=
uf *err,
>  	struct string_list_item *it;
>  	struct oid_array *commits;
>
> -	if (retvalue)
> +	if (!task || !task->sub)
> +		BUG("callback cookie bogus");
> +
> +	if (retvalue) {
>  		/*
>  		 * NEEDSWORK: This indicates that the overall fetch
>  		 * failed, even though there may be a subsequent fetch
> @@ -1557,8 +1562,9 @@ static int fetch_finish(int retvalue, struct strbu=
f *err,
>  		 */
>  		spf->result =3D 1;
>
> -	if (!task || !task->sub)
> -		BUG("callback cookie bogus");
> +		strbuf_addf(&spf->submodules_with_errors, "\t%s\n",
> +			    task->sub->name);
> +	}
>
>  	/* Is this the second time we process this submodule? */
>  	if (task->commits)
> @@ -1627,6 +1633,11 @@ int fetch_populated_submodules(struct repository =
*r,
>  				   &spf,
>  				   "submodule", "parallel/fetch");
>
> +	if (spf.submodules_with_errors.len > 0)
> +		fprintf(stderr, _("Errors during submodule fetch:\n%s"),
> +			spf.submodules_with_errors.buf);
> +
> +
>  	argv_array_clear(&spf.args);
>  out:
>  	free_submodules_oids(&spf.changed_submodule_names);
> --
> 2.25.0.rc1.283.g88dfdc4193-goog
>
>
