Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ABB01FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 19:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbdFPTn5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 15:43:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36572 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbdFPTn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 15:43:56 -0400
Received: by mail-pf0-f196.google.com with SMTP id y7so7909674pfd.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kgp4+kECaB8ajeY73GQcrCj1O5AgVmJUqLFcvxlhcoU=;
        b=qgASVh3QQveqhpU9l4Tm3fIuoN33BWTFIO1v7dxSlmcGxKj6sI5g3M2GcAciusXr0c
         XF7RYLi9icTfmqIRqMG1dKJclF50rOv62zXc1PH27OkbUSY0IKxMK180Dn+sdDVQTK0x
         zPv0MDSzfH/mf+DdpShIz8Svt7OUmQ6z47BUg0I60gSjWNL3WVjIVvfeXKxov1DTrTis
         JjH3UMT9LxJbXzAvqAo6h1ouZRieDdbcPnfphV04y5IFYNeODFz5zg8ThyB5Jr4JgddT
         nM/3agTIh9QqHktz3Ue3BTRftYYNiLSs2mcI7fF6g3WX0wogr2DHxAnRDl2DH1Kzqr3c
         5jKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=kgp4+kECaB8ajeY73GQcrCj1O5AgVmJUqLFcvxlhcoU=;
        b=M3Y1sxQAkmeCJLsdZ2mmX+UleJ5MYiv2JASvBt6bt4OPHXpqyC2GNm9yb5vBYJkNjB
         fEQCQcmG0Xcvs6IvgH2stfJcCTDRKTMmVpZ+MnZTPKENslMzRE6pFm4v3Yh1PZcf6Fz+
         0XUwllqo1jjLg4QsyS7M0x56fqAH/KQrvrRAvH5VvDmtGYsq0MPhk0VH3dIk7snc7I95
         ln5HEtnC7wrs7Owmiv03a79dY1J6eTUFnufVtRF1a5cVbS3OQmkbxLOD4PuSV/cBPNJQ
         272obzgdlcdQqhZxaTvabEMh5MMy09aMSC20O7pXa7/A2F2qxRao36Jy5iFlHQkrnU8X
         odFA==
X-Gm-Message-State: AKS2vOzrpqLQdpnuWsvjAqu1bHMqCu7DxuDvXn9D/r8Qc///ThjjQk5e
        JhVT4mx7U8gCPw==
X-Received: by 10.99.39.194 with SMTP id n185mr13180294pgn.94.1497642235417;
        Fri, 16 Jun 2017 12:43:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3047:3460:ee36:a98a])
        by smtp.gmail.com with ESMTPSA id b86sm6527481pfc.27.2017.06.16.12.43.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 12:43:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 4/6] coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
References: <20170615231549.20085-1-avarab@gmail.com>
        <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
        <20170615231549.20085-5-avarab@gmail.com>
Date:   Fri, 16 Jun 2017 12:43:53 -0700
In-Reply-To: <20170615231549.20085-5-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 15 Jun 2017 23:15:47 +0000")
Message-ID: <xmqq7f0byayu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> A follow-up to the existing "type" rule added in an earlier
> change. This catches some occurrences that are missed by the previous
> rule.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---

Hmph, I wonder if the "type" thing is really needed.  Over there,
"ptr" is an expression and we can find "free(ptr); ptr = NULL" with
the rule in this patch already, no?

In any case, I'll queue these patches as-is.  Thanks for working on
this.


>  contrib/coccinelle/free.cocci | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/contrib/coccinelle/free.cocci b/contrib/coccinelle/free.cocci
> index 35fb992621..f2d97e755b 100644
> --- a/contrib/coccinelle/free.cocci
> +++ b/contrib/coccinelle/free.cocci
> @@ -17,3 +17,10 @@ T *ptr;
>  - free(ptr);
>  - ptr = NULL;
>  + FREE_AND_NULL(ptr);
> +
> +@@
> +expression E;
> +@@
> +- free(E);
> +- E = NULL;
> ++ FREE_AND_NULL(E);
