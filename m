Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A638C20802
	for <e@80x24.org>; Thu, 22 Jun 2017 22:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753482AbdFVWPB (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 18:15:01 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33237 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbdFVWPA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 18:15:00 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so4021291pgb.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 15:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=H0yaPMccxgUdl5Ud+pNrcmexEytufiWMX4Ca8wIB39s=;
        b=dYWzzLOPji9LYw6lmqajr6mG+EaOauYXfNwVIYxQD7M8Zc0+dJnyk79sglEW5JBaSx
         WQ3PhQlpBCVw34JOKU8r65xUWa7uZzBphfE86tYwX2UlAy1YhVBK72pPmDrbZ1UGzNLh
         HGIV2Y6NP4UAT9tZnRq/qKIbpXnu8FhDQB3aUvmkCjkU4ym90B5nlo58HofT7cWWEYGC
         YlD4MOETUq9oxCxBjbM81u+Grnmg36RSaz8KearqQq0cBASU2rqYBKQ+63D7DLMTKtI6
         U+YTBV8cn45gWn1FvECrmdep11XE2qrMgc9/oxbDyU8ONh+iD2ynTIWpB8EMby+giCf8
         CanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=H0yaPMccxgUdl5Ud+pNrcmexEytufiWMX4Ca8wIB39s=;
        b=f76qfIbqA7yj1fEa6MNRe4QqFw+daLoBLjywSELXbJSE7h/1p+nz77bnITc8OEbsjI
         tYdM6F4LfLLDpr2zAIxE40/U8F5d0C061BCLa10QNKp6wy0o4euTdBienF8pGODvO6y8
         UHg5cPQEfoj0k8qR9s3Z7wWWy/b/3i4pig1Sex42VgIpo1+e9wiBISWd1apgLrTATN+s
         olNgyh3TKDTWhTiy6EjM/Bh+NkMSvc+n6W9xV8TBhAKh+X/ihpz+APW6pgiF/I8ZTMgR
         XOVTjSCvKlx8Yi+gWMoqz67Fn63N6rt5FULc0PMdCT7on4yPNVKSsASOnKCo9g0imiss
         FHkA==
X-Gm-Message-State: AKS2vOzsENmFJFMjeLvEUdMWP3D4YgUvLuDh2F9o30dSnxfwubIzMZLH
        MVzVSXLrSGIyzA==
X-Received: by 10.99.122.13 with SMTP id v13mr4930844pgc.156.1498169698759;
        Thu, 22 Jun 2017 15:14:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:20f6:6e44:6707:50bd])
        by smtp.gmail.com with ESMTPSA id p21sm5896785pgn.12.2017.06.22.15.14.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 15:14:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Patrick Lehmann <Patrick.Lehmann@plc2.de>,
        Jessie Hernandez <git@jessiehernandez.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: your mail
References: <7c277ac1cfb40b9b362d468a94dfb4fe.squirrel@mail.jessiehernandez.com>
        <20170622124803.45sduodpfbwuuq52@ruderich.org>
        <0092CDD27C5F9D418B0F3E9B5D05BE080102A3D5@SBS2011.opfingen.plc2.de>
        <20170622134708.fcc4zxakga6p255x@ruderich.org>
        <0092CDD27C5F9D418B0F3E9B5D05BE080102A423@SBS2011.opfingen.plc2.de>
        <20170622204628.eintlap4uchlncub@ruderich.org>
        <xmqq8tkjiu3d.fsf@gitster.mtv.corp.google.com>
        <878tkjk7m7.fsf@gmail.com>
Date:   Thu, 22 Jun 2017 15:14:57 -0700
In-Reply-To: <878tkjk7m7.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Thu, 22 Jun 2017 23:58:08 +0200")
Message-ID: <xmqqr2ybhdpa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Maybe something more like:

Much better.

> diff --git a/README.md b/README.md
> index f17af66a97..dc175757fa 100644
> --- a/README.md
> +++ b/README.md
> @@ -36,6 +36,12 @@ the body to majordomo@vger.kernel.org. The mailing list archives are
>  available at <https://public-inbox.org/git/>,
>  <http://marc.info/?l=git> and other archival sites.
>
> +You don't need to be subscribed to the list to send mail to it, and
> +others on-list will generally CC you when replying (although some
> +forget this). It's adviced to subscribe to the list if you want to be
> +sure you're not missing follow-up discussion, or if your interest in
> +the project is wider than a one-off bug report, question or patch.
> +
>  The maintainer frequently sends the "What's cooking" reports that
>  list the current status of various development topics to the mailing
>  list.  The discussion following them give a good reference for
