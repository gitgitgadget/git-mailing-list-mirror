Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51C81F453
	for <e@80x24.org>; Tue, 29 Jan 2019 01:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfA2BBK (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 20:01:10 -0500
Received: from mail-io1-f44.google.com ([209.85.166.44]:34139 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfA2BBK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 20:01:10 -0500
Received: by mail-io1-f44.google.com with SMTP id b16so15223503ior.1
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 17:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OGF2z/5fatYAsU3yS7pkcKMEysw4cWYPOIH4oE7OJII=;
        b=XYhqXj50+JVrrZ3AjdxgT0A8XTjiNe0PdD6r/276BEaFrgs72Afx8DJuRi94NfepKp
         iEZlqiZhzicv4WbRcpZCqlID9bs/QRTTaeSxK72uFipjJ90AjSPbA9+1OwU5if9fLm0q
         acf9koR5zAw0P459hgfaX/gyks+QI+ZavB0A8LMFpjZWU5BtZjw1NqC6teped+OTwhEj
         +pjE7HQXufxEgyl4CsLkm9cIW/oEofy5pM/fpR2jiwUwLaoSMxLLPjOQpDh0ZWn0xgBZ
         njZN33QowMvKw68UT4Akd+vYgeKX8dHSD5VP11y1gAuwBMYFVN1PKINxV/RU+D5piI3F
         b0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OGF2z/5fatYAsU3yS7pkcKMEysw4cWYPOIH4oE7OJII=;
        b=J2axD6uyGK9lVFS6l1gR7Zq8dkAFxzP6/AV+kZoy+otUqEoWT95tS2RDr1kKXAxFh2
         yyD+6IMddlHSyOA4YvROJgxN6ZQHo+lnWzCYkOFTe1qmioUUKTBayg1CJ0XuVkPFYepZ
         Xw7TveKuIZZIL70VDCPQaleu5Dy0LXLApZkksqTPq8zdyvbp7/Y97lm2ZFw3bSJ/E/Di
         N8bhSbKKP8UV/Ha8/FAAUheJuauoG4mqDPkPQfh0EH3c4+zpRGfVUyRopvQHtyfZm87g
         L6kY8pcc5iAsOIfbDXs5P/6UWKIP1r1EbeY+tW56wlj+UF7BZD4Hye3zd3MTgaqMku1v
         W2nQ==
X-Gm-Message-State: AHQUAuYrlQlLuQhCPBuM9tTBgS3Uvw7QynWcl6ChAIfmv6DbogVMI2ya
        lle4YtybjqvITwvQhD5pNveRHeC3qWyZ0Sepqy8=
X-Google-Smtp-Source: AHgI3IalEzrwnidzOVsNrFpzaZynjOTX88FDJiH4Q/hZIl/QXP0Uf7Td3b8DQeDh2xVxVsIOYtCY1klTCdnlHYWRSkU=
X-Received: by 2002:a5d:9812:: with SMTP id a18mr11676100iol.236.1548723669494;
 Mon, 28 Jan 2019 17:01:09 -0800 (PST)
MIME-Version: 1.0
References: <etPan.5c4e6be4.2ca84d68.4d5@zdharma.org> <CACsJy8BMc9k3Q=P=2CaJ9yyXhc4C_BgGVO=S_J0_R8zDweahLQ@mail.gmail.com>
 <etPan.5c4f2017.992f4fd.4d5@zdharma.org>
In-Reply-To: <etPan.5c4f2017.992f4fd.4d5@zdharma.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 29 Jan 2019 08:00:43 +0700
Message-ID: <CACsJy8AjMamr3kNf67SkYxKrDPHWcf=W2eArMRMnX3H6hXWe7A@mail.gmail.com>
Subject: Re: There should be a `.gitbless; file, protecting files from git clean
To:     Sebastian Gniazdowski <psprint@zdharma.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 10:30 PM Sebastian Gniazdowski
<psprint@zdharma.org> wrote:
>
>
>
> On 28 stycznia 2019 at 06:05:31, Duy Nguyen (pclouds@gmail.com) wrote:
> > There's a patch that adds "precious" git attribute [1]. I was going to
> > resend once the backup-log [2] got reviewed but I might just send it
> > separately to handle the "git clean" case alone.
> >
> > [1] https://public-inbox.org/git/20181111095254.30473-1-pclouds@gmail.c=
om/
> > [2] https://public-inbox.org/git/20181209104419.12639-1-pclouds@gmail.c=
om/
>
>
> The backup log, if done properly, could allow to use git more freely, wit=
hout nerves that something will beak. I wonder if it could restore also the=
 state before an improper `git clea -dxf' call? I think the chances are low=
, because this would requrire to save untracked files, but it's worth askin=
g?

backup-log already saves untracked files for "git reset --hard"
support if I remember correctly. Adding support for "git clean" is not
that big a deal. It's just the matter whether to turn it on by default
(because there will be a lot of files being backed up). But now that I
think about it, if backup log is enabled, perhaps we allow "git clean
-dx" (without -f or -i) which will back up all deleted files, while
-fdx will not. Hmm...
--=20
Duy
