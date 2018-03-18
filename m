Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 009FB1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 02:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeCRCLJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 22:11:09 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:39403 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbeCRCLI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 22:11:08 -0400
Received: by mail-qk0-f170.google.com with SMTP id j73so7582767qke.6
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 19:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=34eQUBI12kqNnKWlVt+kk2ld3zboiYZjqZ0uKMtSKlM=;
        b=pjbMYO2eAJOcFXLbzuXReTzGTLtON21IVPPEjS4rcAOMHB5Ssu4pJjOztDUkf+pbnP
         377v53ivUs+DbZbt/1JWdME3tekZVxhZCLH49nJXXZxwh0g/A3JAkSK/K84AUt7zIWR6
         ozweoVdXVu1eBHqhNiy8b4hqQJeFy/DMZC4/4nZqt3QUCc9pZWeSJ0r4zEKk8syzTzny
         +bnRFp7do2sEoXdoR1/0u44JS9hUn/ooFJDtTU4SXM9oI2RBp4rYeK+UUTh/82YGpOwj
         /AkdW0RDhcFMN+vhl1ZLIeM3YmlvTem9Adoy9T8Hoz2PbZS8FiqfbvNO2YIs4XYCZ930
         zUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=34eQUBI12kqNnKWlVt+kk2ld3zboiYZjqZ0uKMtSKlM=;
        b=lerApqYBXHeI18Ze+5r1McLmXwwnyRxMH0qakslwmC/rsxyaMmO7xqzoRZ5J7ZxWKQ
         hyokd8ip5Ju6Pm+B021hXwPUwvKsQORza+ob4eVsi0Y3ekqVSgJhEQCszQj6ff62PyOV
         mDV2gVi5Bg8IQdC+FNPg1FOTUA3QslaLXN5fwPdrTBVJkDPd6OMLzflnjJmB+dSRrd1J
         9KgKSdpw33f51YJaz5uireqt7F0TPFxbj2OPrSauZc5ePjtrgzH4ywxoPnJ6Rb/STnff
         kDtLEFJSLsoK8Tk4SMgk+2CcoFfoydOiydVRampHAE5f7biTkhbbfI+3svixtyo5/w0M
         m64Q==
X-Gm-Message-State: AElRT7HLMHzFXhPsjvkA8/ZtXMWFxW/cZQ1dQebSFWa3GNZEIidU3Tk7
        tOCaaZC5RvzqVI3P+K+c9HuTT6ojdcoRPTh+xhQ=
X-Google-Smtp-Source: AG47ELtATBeyZjAip1ZCyHkIXzuRIPECLB6xSlJRX0EKQU8d3RRLjkSI+4O60Vnk4+r2C2KOHv7GX1b+hKZa2mL+EtU=
X-Received: by 10.55.120.66 with SMTP id t63mr10820465qkc.42.1521339067758;
 Sat, 17 Mar 2018 19:11:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Sat, 17 Mar 2018 19:11:07 -0700 (PDT)
In-Reply-To: <20180317075421.22032-5-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com> <20180317075421.22032-5-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 17 Mar 2018 22:11:07 -0400
X-Google-Sender-Auth: rqbAjZ-ICmsml8vdGF5Lkvbx80I
Message-ID: <CAPig+cTSqxLTDoq3xGAmf1xCyCX0jvwyoSL5GApgaNg5PVPGGg@mail.gmail.com>
Subject: Re: [PATCH 04/36] t/helper: merge test-lazy-init-name-hash into test-tool
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 17, 2018 at 3:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> diff --git a/cache.h b/cache.h
> @@ -333,7 +333,7 @@ struct index_state {
> -extern int test_lazy_init_name_hash(struct index_state *istate, int try_=
threaded);
> +extern int lazy_init_name_hash_for_testing(struct index_state *istate, i=
nt try_threaded);

I get why you renamed this since the "main" function in the test
program wants to be called 'test_lazy_init_name_hash'...

> diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-ini=
t-name-hash.c
> @@ -9,6 +10,9 @@ static int perf;
> +static int (*init_name_hash)(struct index_state *istate, int try_threade=
d) =3D
> +       lazy_init_name_hash_for_testing;
> +
> @@ -33,9 +37,9 @@ static void dump_run(void)
>         if (single) {
> -               test_lazy_init_name_hash(&the_index, 0);
> +               init_name_hash(&the_index, 0);

... but I'm having trouble understanding why this indirection through
'init_name_hash' is used rather than just calling
lazy_init_name_hash_for_testing() directly. Am I missing something
obvious or is 'init_name_hash' just an unneeded artifact of an earlier
iteration before the rename in cache.{c,h}?
