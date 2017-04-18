Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E557B207B9
	for <e@80x24.org>; Tue, 18 Apr 2017 21:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbdDRVHJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 17:07:09 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:37280 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbdDRVHI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 17:07:08 -0400
Received: by mail-it0-f52.google.com with SMTP id a140so2436434ita.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 14:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7tizb/dwb314giHxXC+vKoRyWSNTaB+DoqjbOLCNcLE=;
        b=RNzsGOzhAWS7txoruh/ECCxuw7TGHdbcnKmNVBQPoFcBa87ioWYtMdDOcunC+FpI3Y
         CY/xWSoyJt5UtdeZPa533gevTkMfHJvrQ1G8kPHqjulCQ5qk6HfeK+K+V13sTO0W8Mvr
         KV/FahczfrTXyZb0EbBiWpTmgRXO8O3PbxyhO58mN3qRmAE4ZAi6JA2bPctZF4rywwL5
         3zI9eGfeo8Cp7NYCbD1icuWcqSQ350T2FVV8tc7TOLHHJR8ibXSkSBza+X13NBvLApsG
         A/tzfwSnrDYyGTxOLPe9XEcIDUOoccr8PSsqiVEs8INODy7VL/S0ZIXU3kBR/Pm03YhN
         RT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7tizb/dwb314giHxXC+vKoRyWSNTaB+DoqjbOLCNcLE=;
        b=qgP7WHeDcZCGnHIfWmQYWIoMZFQIyLYtn0rEcnBZ3dNK/K8Pm5Y/T/mSn2+dVkyK1k
         J/6k+7Fil3o7zy6mivpX6lG5VM42ub+qcZxsfSoeAKP4vj1PVGlOYClpR8xQL3m9gqLk
         sykn/YM1H8ItgPE4K7XWAY9L2dRMTHndREeojxPEwN5YrOyPoWok3TFilYd6QqhE1+wG
         Vf25aRqBrLm7FCAx51F8B3ui6xOLckGEo+pVyphQPaxE6uoLXwV8MNnV0LmHtyxy6VNn
         dz8Hj+GlEAeozLnT56eVk4yF0xlCzShbBYulQxBPCVHL+NmRn2pMkQvxuLMOldRmVzR2
         KTRg==
X-Gm-Message-State: AN3rC/7YPOB5DmV+5qp1NuTo1T6Xz9MxFuWGimpVlKNK8ZHUxoXgDVOx
        zIDiKxpVD5NYTrgycNmHvpCMMWa9sQ==
X-Received: by 10.36.103.86 with SMTP id u83mr5244289itc.91.1492549627984;
 Tue, 18 Apr 2017 14:07:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 18 Apr 2017 14:06:47 -0700 (PDT)
In-Reply-To: <20170418191553.15464-1-avarab@gmail.com>
References: <CACBZZX584QwjphGfEgTn2V9P0yVkYSxfE1_Gp96bno8186SDyA@mail.gmail.com>
 <20170418191553.15464-1-avarab@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 18 Apr 2017 23:06:47 +0200
Message-ID: <CACBZZX4CD52j=fz_DPmVpsMLa-Dxu-iJ=GB8YQ6QFKOh1RWQ_g@mail.gmail.com>
Subject: Re: [PATCH] clone: add a --no-tags option to clone without tags
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2017 at 9:15 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

>                     N_("clone only one branch, HEAD or --branch")),
> +       OPT_BOOL_NONEG(0, "no-tags", &option_no_tags,
> +                      N_("don't clone any tags, and set remote.<name>.ta=
gOpt=3D--no-tags")),
>         OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,

I forgot to note that this is on top of my earlier patch which adds
OPT_BOOL_NONEG, see <20170418170914.9701-1-avarab@gmail.com>, but
otherwise applies on top of master, and will work just fine by
amending that to say OPT_BOOL (although --no-no-tags will then exist,
as noted in the other patch).
