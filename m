Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527A31F404
	for <e@80x24.org>; Wed, 28 Mar 2018 18:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeC1S5p (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 14:57:45 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36139 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753135AbeC1S5o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 14:57:44 -0400
Received: by mail-qt0-f175.google.com with SMTP id f16so3709918qth.3
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jQtrop/i0AewQM8nxlgsdPl2H3+AKr6DHxxQFhw7WXA=;
        b=Mk2eMoEWePYaXZnp3QKfQd0/9ZWqP3jlo7K3tSklKqTA2POpW5TCmCZKHxF8eHloBn
         FQirkXosCGBg9O2mpAc/b/WLzdyJGcfZkGwjrCt69ji/I8Stq+eH7ljmaERh6RPpun5c
         f5OP/DvagEWnOtO1SAJzSnbOb5JxDNJyjdeV01XMZXASWlCrzwFCyfGaFKbT4WEBeq79
         34IuLPb7gpcWqqEryH6nNDtKArAU6lSQrDiw2oAhGgP6sX+Hkf+SYJhr/7LDnNRDJVYd
         cxJpxgx3cIvdu42XG2sR6EbgapYkSgo7gZWn7QPgdsCdPBVolCpkcoUt5JoCis5bjnhv
         UALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jQtrop/i0AewQM8nxlgsdPl2H3+AKr6DHxxQFhw7WXA=;
        b=YrK41Jxw1q0L+P7RF+fQO7I/9s7E9B+4eHs+b+vNXVHeQqFhIuLl3+T4bMsuUNSD/a
         uwP5UcADek3bVw3f2kWWUnH9ozge3Xlh+Rwz/LQRj5WzGW26vhWfXI/lN/dh1EfzsUpF
         pMZLWbxUCbTRvZm3xTi5cVGdjVNbq3cV+sdmA/PwEaa8G3HQ94tAw3wCX0+1su++u8BI
         7sIREIW9TLVB6chS7Ynn6VIQa3tShQSgULnPpzIpy6Qjcm103d4uCs3O88NlLXoMgrKg
         seQBk3kzSyLZloD38nGk7bYelRDXydVNVKAr5UcOCwMZDpkEqfxiGhjbXryaGPLrlWt0
         O1eg==
X-Gm-Message-State: ALQs6tDMIrBD5ZDP8YjBfDEKB1U/DJQpbbrup7nvL/Rr3PDaALS3JZ7h
        bYh65nJzQeNUr2gnX1zrEOFsUlC+lJbEAv3PVLA=
X-Google-Smtp-Source: AIpwx4+sZkkmw0W5l51JnfDKtwQYH07i/rGM7Yc8n8JYvqdFfrUCYtRo/cyEwmZwBhHIyX+BGoJG6bCRqM8OrH4X7zc=
X-Received: by 10.237.57.166 with SMTP id m35mr6602229qte.220.1522263463787;
 Wed, 28 Mar 2018 11:57:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 28 Mar 2018 11:57:42 -0700 (PDT)
In-Reply-To: <20180328183832.243036-1-sbeller@google.com>
References: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de> <20180328183832.243036-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Mar 2018 14:57:42 -0400
X-Google-Sender-Auth: MR6xSHjDw23WU_aGLqTuzYpS0zM
Message-ID: <CAPig+cT1Yp8J8E0VDKdxvPdVD-UBsyDfQS+a83zOAW11ayfhnA@mail.gmail.com>
Subject: Re: [PATCH] submodule: check for NULL return of get_submodule_ref_store()
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, jeremy@feusi.co,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 2:38 PM, Stefan Beller <sbeller@google.com> wrote:
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> @@ -821,6 +821,18 @@ test_expect_success 'moving the superproject does not break submodules' '
> +test_expect_success 'moving the submodule does not break the superproject' '
> +       (
> +               cd addtest2 &&
> +
> +               mv repo repo.bak &&
> +               git submodule status >actual &&
> +               grep -e "^-" -e repo actual &&
> +
> +               mv repo.bak repo

Should this "move back" be encapsulated in a test_when_finished?

> +       )
> +'
