Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFCBC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 19:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiCQTnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 15:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiCQTna (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 15:43:30 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198C5238D15
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 12:42:12 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id kc20so1180322qvb.3
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 12:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DNFW4d8Ih1UTpu7YSu0eTfVisusMd3+Ljj1zSiS8dg=;
        b=YfR4XgWRhikdlbqYXvZoK/5wxHjR7ea+EVABDj8jQLP9qvI+UE9OwI8Fkp0fLoevU5
         BrwD/Eqyq2ftlvM/+lXvxxH8L2jmADIQVKLMfhELEjhkNnckV1dOQx0PG0+Qno5YvOMr
         0gONaCoFc8TsL0BqSShNimBIuTQImK+ZGYkalpgGhOTmWIlI42e31Wpux48jMBYJZEiQ
         LAVQrSmukMtecenjJBN1vxtjoI5BESnbl+fb5She+FtlstPU0UeEZSWpbglvb3WMIkKT
         e3MhrhD5oZEHzc0L5JrKYpSolge2t7hfvZ+aMBvw67y2hql4WXArGtP9+ycttPtLa1Kv
         zTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DNFW4d8Ih1UTpu7YSu0eTfVisusMd3+Ljj1zSiS8dg=;
        b=TYo2tB6wry8pa8KjJMyhPt54bUONU+l4CX3EA9EyoILC5l2rhJNK58NGmFK49asLLF
         OZ12qV1PTBlf3UGjSEKp2M7DBHIMhDrm3yY6crwpFKinWwksTdD4GfFk6jpv7P/pOEjR
         DlAuqVORd7k8mn2btnyBMSd76OEir2OxWWRGRQEMzqzMuT1+mOpu6fZu7GEtvLY4bCJ7
         XZb2N7wFQuVOpiodTP2FFbeiqSgSsWZZaGu7FDZpqYItABoJuE6fz3EXXqNmUsfTx+wr
         HgdKcku0m7ftF06tfPicdqEgJWV8tIEZ8F2ahCvk8QSTuWyTQKYwyiGwLZiTJHJ6Lfhr
         4myA==
X-Gm-Message-State: AOAM531tarx2GUt6RgxgfqPY8TULn1uhI3igRAGFnFn0+lAqpBa2udIJ
        pKZGocjEDY79qEZ6AVQwPdmuqbgkun4=
X-Google-Smtp-Source: ABdhPJxQW0Mki+D4cYYDt2icdpdKw0/ENbkJjoZVvrj74CmCNeEryMpVQhMpv7FT6QzCcfoR7GbK6w==
X-Received: by 2002:a05:6214:12b0:b0:440:e023:d2a4 with SMTP id w16-20020a05621412b000b00440e023d2a4mr4891490qvu.75.1647546131923;
        Thu, 17 Mar 2022 12:42:11 -0700 (PDT)
Received: from [10.37.129.2] (ool-457faac5.dyn.optonline.net. [69.127.170.197])
        by smtp.gmail.com with ESMTPSA id p64-20020a37a643000000b0067d9afad07asm2944069qke.76.2022.03.17.12.42.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2022 12:42:11 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] reflog.c: indent argument lists
Date:   Thu, 17 Mar 2022 15:42:10 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <99CF36A8-B9FD-4E05-A2DA-B4662C530738@gmail.com>
In-Reply-To: <patch-1.8-5069b3fd0ff-20220317T180439Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
 <patch-1.8-5069b3fd0ff-20220317T180439Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var

On 17 Mar 2022, at 14:08, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> When reflog.c was lib-ified in 7d3d226e700 (reflog: libify delete
> reflog function and helpers, 2022-03-02) these previously "static"
> functions were made non-"static", but the argument lists were not
> correspondingly indented according to our usual coding style. Let's do
> that.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  reflog.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/reflog.c b/reflog.c
> index 333fd8708fe..82e5a935117 100644
> --- a/reflog.c
> +++ b/reflog.c
> @@ -240,8 +240,8 @@ static int unreachable(struct expire_reflog_policy_=
cb *cb, struct commit *commit
>   * Return true iff the specified reflog entry should be expired.
>   */
>  int should_expire_reflog_ent(struct object_id *ooid, struct object_id =
*noid,
> -				    const char *email, timestamp_t timestamp, int tz,
> -				    const char *message, void *cb_data)
> +			     const char *email, timestamp_t timestamp, int tz,
> +			     const char *message, void *cb_data)
>  {
>  	struct expire_reflog_policy_cb *cb =3D cb_data;
>  	struct commit *old_commit, *new_commit;
> @@ -273,10 +273,10 @@ int should_expire_reflog_ent(struct object_id *oo=
id, struct object_id *noid,
>  }
>
>  int should_expire_reflog_ent_verbose(struct object_id *ooid,
> -					    struct object_id *noid,
> -					    const char *email,
> -					    timestamp_t timestamp, int tz,
> -					    const char *message, void *cb_data)
> +				     struct object_id *noid,
> +				     const char *email,
> +				     timestamp_t timestamp, int tz,
> +				     const char *message, void *cb_data)
>  {
>  	struct expire_reflog_policy_cb *cb =3D cb_data;
>  	int expire;
> @@ -323,8 +323,8 @@ static int is_head(const char *refname)
>  }
>
>  void reflog_expiry_prepare(const char *refname,
> -				  const struct object_id *oid,
> -				  void *cb_data)
> +			   const struct object_id *oid,
> +			   void *cb_data)
>  {
>  	struct expire_reflog_policy_cb *cb =3D cb_data;
>  	struct commit_list *elem;
> @@ -377,8 +377,8 @@ void reflog_expiry_cleanup(void *cb_data)
>  }
>
>  int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
> -		const char *email, timestamp_t timestamp, int tz,
> -		const char *message, void *cb_data)
> +		     const char *email, timestamp_t timestamp, int tz,
> +		     const char *message, void *cb_data)
>  {
>  	struct cmd_reflog_expire_cb *cb =3D cb_data;
>  	if (!cb->expire_total || timestamp < cb->expire_total)

Just wanted to say thanks for fixing these :)

> -- =

> 2.35.1.1384.g7d2906948a1
