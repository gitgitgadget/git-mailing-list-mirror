Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9241F576
	for <e@80x24.org>; Fri,  2 Feb 2018 11:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeBBLXD (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 06:23:03 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:42601 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750805AbeBBLXC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 06:23:02 -0500
Received: by mail-qt0-f178.google.com with SMTP id c2so30400497qtn.9
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 03:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=hhh2Th7RXROwGqMsU3a35ff5YKb1tD4na3lq3t/hdSw=;
        b=h7iMgiadJAzWpJg8PbaJGB3w+ICqsvLW2o4YLSyVyJq9hG4BazTr+xJ4s50t/cBNI3
         yfWuucj88pzLJojSnqauDowgdXWZXyMDCbjz/W6LkVvaUx1xgf5uu63xBxFlYFvcCRuy
         +XZHH56NYrtjVK8CaCiVgPcbEw+VekjdgBn2I8UaziAmwAXYS1EHQoxSE6g/OYMs8Ahn
         FbM7bgvHnaaKMJGkj84mPjyRorG3zJDDjOoGq8fP/kSkBsyY5zqz5HxJm44UEBCKgUoU
         D+42SkzG+ufN3rbzpWSb54ONqJ8H9HUUf8TyMaiI5n0QUM8uITJ9cH6ZNUTxrWucLjQl
         ipHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=hhh2Th7RXROwGqMsU3a35ff5YKb1tD4na3lq3t/hdSw=;
        b=IF0lLye8pGXEXIG1KquV/dzLxVb/Ed4XfaxooUUrxtAcZmr+6L3Kh6JgTXHL20LC7m
         8myNE64B2Oi4KvgslBN3X2DS+jHqkL/+CavFmgP/a1mN02vIVbxII6nHcrEM1fNL0veM
         jWtD5xpox4Tz44p3fa3TCkRrMOB4U+KIrwdUwQOxsG25QqN/BkDg//WPQTytkEwHeqh+
         llA0kOs301Xv5eqWczy7wDNW31SwZ5NGLRCKeYluUhYcifAoj5Mg/NcBodnpGPWQpd4v
         AaiAuLf/VkQXqd34TLjq12nMU0d/XKNU8PvygizJ+jZG1UG+w3X9KfxdJrFcML0q2qZk
         XDIw==
X-Gm-Message-State: AKwxytdFqbLLhp00htD0uu4iTNEmM8tqqV48bAsv3Kp1X2Qcq+AUCrnF
        4W1iNrexQmR3GsBSbuiWglAIjN/++Xyi7hPgiaE=
X-Google-Smtp-Source: AH8x225FtUXfmVvhAYNTn1tEJ38XrDl9vbZkPwKOHoOuP9maVWKRd3BVROuZp+QLsE4iMjx6/EbMotxEFVYQNfaLH9w=
X-Received: by 10.200.15.218 with SMTP id f26mr64443953qtk.237.1517570581158;
 Fri, 02 Feb 2018 03:23:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 2 Feb 2018 03:23:00 -0800 (PST)
In-Reply-To: <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-4-pclouds@gmail.com>
 <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Feb 2018 06:23:00 -0500
X-Google-Sender-Auth: yfVcV2B7A-8ufA6oyAOtCAvqPJI
Message-ID: <CAPig+cRYL6-jEgsQoiQokNSd0zq5zoFkMHBA0Vp9kqa0LvMnsA@mail.gmail.com>
Subject: Re: [PATCH 3/7] worktree move: new command
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 4:15 AM, Eric Sunshine <sunshine@sunshineco.com> wro=
te:
> On Wed, Jan 24, 2018 at 4:53 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> +static int move_worktree(int ac, const char **av, const char *prefix)
>> +{
>> +       [...]
>> +       worktrees =3D get_worktrees(0);
>> +       wt =3D find_worktree(worktrees, prefix, av[0]);
>> +       if (!wt)
>> +               die(_("'%s' is not a working tree"), av[0]);
>
> This is still leaking 'worktrees'[1]. You probably want
> free_worktrees() immediately after the find_worktree() invocation.

Sorry, free_worktrees() after the last use of 'wt' since you still
need to access its fields, which would be the end of the function.
