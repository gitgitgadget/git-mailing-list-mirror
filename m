Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301001F404
	for <e@80x24.org>; Mon,  9 Apr 2018 03:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeDIDcg (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 23:32:36 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:40645 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752392AbeDIDcd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 23:32:33 -0400
Received: by mail-qt0-f193.google.com with SMTP id g5so7708251qth.7
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=HVzrdKuD48Igvu6KW4dr7z1/kDnJO1lG8cIKS4Jx5Rg=;
        b=cELNb/Je+z6Os5/bzqfbF6xr08M388uJLRexJzrEPZrFDH49Fc5jAJCG8Q3Gm1DHjO
         lkLzBJgilUB4d0NOW0mEHFrIbq0vKhjovGZtWlBNthX0rMgUCzk37XMe4rwUDiDfi9D1
         eXBWoUPrPMks3yaryJ21o02koL8Ln0ppwIzgzqQ9m+1/0ZOief9B1KSfY4zqHSAYOpNI
         7lK/j0oP5P67fiA7K6G7x82RfbFttg4m3ZkkLvDQ+k0mJ9Sdm7pjTqdxDkTLlif+Dzs3
         bZacKaJWVEmNF9dhDDECVFMRohp955v9fguwHDVAKFsdQ1RysNVJuiYaUPsEFVZUpyrd
         iz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=HVzrdKuD48Igvu6KW4dr7z1/kDnJO1lG8cIKS4Jx5Rg=;
        b=JdSBvBsZCEj5ibKuIFd4kZ6QI6cTT0Ps6lWKuUvx++IHh6jjpBWXMAOzaNtfbIHvPH
         TxvgrLOgzQs3Ypj75o6zBEy4E8cZQmgSNWhYy/2x/6m6uP64Vt3cZdYQer+Ume4VxGva
         s6zS5abiDiDR9XUwXuSFVv6aqpIBOq0hNwgRqzVDYA8R4bEo5g8L3nnUEjhhjIUkxpV8
         VSeTlRRZV2DhCJlpeP0CfqByftjmYRT/vQJRVV8JvSDqtarQf5o0FgsOegPwUnE4pCEG
         p+mt49dHywcmgLvOU8R8pXF4pnrnK46K/dYmAg11fH9qK6Fb5WYTIHQR2PFCt8z6hFe+
         naAw==
X-Gm-Message-State: ALQs6tD5LOZRuAKHDMGz5FPBug8sbCl18s++U+aXk+Kq3+61CtPxr9zx
        PPCtPE8IqrF0nAP/S7jsELYNeGOxXuXnuN5J72w=
X-Google-Smtp-Source: AIpwx49g6zn7kSFDubO3HqHLh/VHDxzjxEU6wPpH01I5PqHsfq35hZr6OR3iA3LoYN18dkWGGkVXfpZ410WTkXdq9Vo=
X-Received: by 10.200.69.131 with SMTP id l3mr7949644qtn.50.1523244752241;
 Sun, 08 Apr 2018 20:32:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 20:32:31 -0700 (PDT)
In-Reply-To: <20180326165520.802-3-pclouds@gmail.com>
References: <20180326165520.802-1-pclouds@gmail.com> <20180326165520.802-3-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Apr 2018 23:32:31 -0400
X-Google-Sender-Auth: OF4kT99uRb9U0sQMuymxZA_2KgA
Message-ID: <CAPig+cTZsxazyzsm9HGm4upP4RLcyVWG2XH+jFAVoa=N4_093w@mail.gmail.com>
Subject: Re: [PATCH/RFC 2/5] git.c: implement --list-cmds=all and use it in git-completion.bash
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 12:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/help.c b/help.c
> @@ -228,6 +228,21 @@ void list_common_cmds_help(void)
> +void list_all_cmds(void)
> +{
> +       struct cmdnames main_cmds, other_cmds;
> +       int i;
> +
> +       memset(&main_cmds, 0, sizeof(main_cmds));
> +       memset(&other_cmds, 0, sizeof(other_cmds));
> +       load_command_list("git-", &main_cmds, &other_cmds);
> +
> +       for (i =3D 0; i < main_cmds.cnt; i++)
> +               puts(main_cmds.names[i]->name);
> +       for (i =3D 0; i < other_cmds.cnt; i++)
> +               puts(other_cmds.names[i]->name);

clean_cmdnames(&main_cmds);
clean_cmdnames(&other_cmds);

> +}
