Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B40C7EE29
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 19:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbjFBTgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjFBTg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 15:36:27 -0400
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DC5198
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1685734586;
        bh=9DUk1W7QBq+Rqp9RpTb27AWW7Hkk7YkGeufRTPztR9Q=;
        h=From:Content-Type:Mime-Version:Subject:Date:To:Message-Id;
        b=vqIcslgWLDnrqHiwGEc2/eOAOuAI8jZsPaeUQIM+gcFkUINIfSMVuv9UL7TO3HyES
         c0JynyRfXqctWzqnrUQ46HWt2oXHWZL3xVqejwMTny5FSYINZBj87fjzHyGaGX1vj4
         bcoAB+/Y4xuMQnEezOAhnVHnzlhVQ8Vyp97+Glbp9KX2iDO1apC7ihGoGMSN9sNeuI
         92XH6xYj1CS4nP1+jYrZNKZlr0p+LEh2DdxtWpIcFlADL5osFOMbQhIW0uE+wALQ7f
         dvQol/QR15GKaFEuLhL2lg5tAQV5FYxz9PoQNtEkwB6VZJOvcj5LIUeV8cydKa/R2w
         73ytPCN38mNGQ==
Received: from smtpclient.apple (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 411672C0168
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 19:36:23 +0000 (UTC)
From:   Emir SARI <emir_sari@icloud.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH] i18n: Enable percentage l10n for more strings
Date:   Fri, 2 Jun 2023 22:36:08 +0300
References: <20230516101911.93809-1-emir_sari@icloud.com>
To:     git@vger.kernel.org
In-Reply-To: <20230516101911.93809-1-emir_sari@icloud.com>
Message-Id: <9C76C476-0E54-4980-8138-EB9077E00523@icloud.com>
X-Mailer: Apple Mail (2.3731.600.7)
X-Proofpoint-GUID: i0juqRGfj2zYhmAEJ5iVUOJ_LZyNVpjE
X-Proofpoint-ORIG-GUID: i0juqRGfj2zYhmAEJ5iVUOJ_LZyNVpjE
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 clxscore=1015 phishscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2306020150
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Ping, in case this got buried down the list.

> Emir SARI <emir_sari@icloud.com> =C5=9Funlar=C4=B1 yazd=C4=B1 (16 May =
2023 13:19):
>=20
> This enables percentage localization in more progress views, and
> provides a more cohesive l10n environment among the translated =
messages.
> ---
> apply.c    |  8 ++++----
> progress.c | 18 ++++++++++++++++--
> 2 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/apply.c b/apply.c
> index 6212ab3..3e1d08d 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4247,11 +4247,11 @@ static void show_rename_copy(struct patch *p)
> * new_name through the end of names are renames
> */
> if (old_name !=3D p->old_name)
> - printf(" %s %.*s{%s =3D> %s} (%d%%)\n", renamecopy,
> + printf(_(" %s %.*s{%s =3D> %s} (%d%%)\n"), renamecopy,
>       (int)(old_name - p->old_name), p->old_name,
>       old_name, new_name, p->score);
> else
> - printf(" %s %s =3D> %s (%d%%)\n", renamecopy,
> + printf(_(" %s %s =3D> %s (%d%%)\n"), renamecopy,
>       p->old_name, p->new_name, p->score);
> show_mode_change(p, 0);
> }
> @@ -4270,8 +4270,8 @@ static void summary_patch_list(struct patch =
*patch)
> show_rename_copy(p);
> else {
> if (p->score) {
> - printf(" rewrite %s (%d%%)\n",
> -       p->new_name, p->score);
> + printf(" rewrite %s ", p->new_name);
> + printf(_("(%d%%)\n"), p->score);
> show_mode_change(p, 0);
> }
> else
> diff --git a/progress.c b/progress.c
> index f695798..1f8d372 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -124,10 +124,24 @@ static void display(struct progress *progress, =
uint64_t n, const char *done)
> progress->last_percent =3D percent;
>=20
> strbuf_reset(counters_sb);
> - strbuf_addf(counters_sb,
> -    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
> +
> + struct strbuf progress_sb =3D STRBUF_INIT;
> + strbuf_addf(&progress_sb,
> + _("%u%% (%"PRIuMAX"/%"PRIuMAX")%s"), percent,
>    (uintmax_t)n, (uintmax_t)progress->total,
>    tp);
> + struct strbuf progress_str =3D STRBUF_INIT;
> + strbuf_addstr(&progress_str, progress_sb.buf);
> + strbuf_release(&progress_sb);
> +
> + if (percent < 10)
> +    strbuf_insert(&progress_str, 0, "  ", 2);
> + else if (percent < 100)
> +    strbuf_insert(&progress_str, 0, " ", 1);
> +
> + strbuf_addf(counters_sb, "%s", progress_str.buf);
> + strbuf_release(&progress_str);
> +
> show_update =3D 1;
> }
> } else if (progress_update) {
> --=20
> 2.40.1
>=20

Best regards,
Emir (=F0=90=B0=BD=F0=90=B0=BA=F0=90=B0=8D)

** E-mail needs to stay simple
** Use plain text e-mail

