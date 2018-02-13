Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643381F576
	for <e@80x24.org>; Tue, 13 Feb 2018 10:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbeBMKZ6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 05:25:58 -0500
Received: from mail-ot0-f175.google.com ([74.125.82.175]:32781 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754169AbeBMKZw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 05:25:52 -0500
Received: by mail-ot0-f175.google.com with SMTP id q9so16888731oti.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 02:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/rRIJa28E87G+jRMgYxlvmy1ZUbe3q+1VyA0vyAvkgw=;
        b=gJW6mXKJQaZROKoTjWxT4ehhVWZICt9umveEtP/0uLZ3I+a7ltsd+xhQGO3EUKvRz1
         DtePittDV3B/O6ZcHTqnVDQgGjuYYzYMPxdcnsEK9bHNYJOsKEQsyIKqItw7ryOaxpQl
         +9gGehrdP+6UPcTurvC0GalN7BeSSnX7n8DlcAcWGBmrpP9bxHBCQFEFV/kYY3KpRV+Q
         XAfKwUKRU+di9I544tX9zRXIKyxIlPHuw7itcWbQKWKoyGywgyEPwvn7a+oT6WkMF2Xx
         OQtWhYXT3buX+HjkvB6i9E0kvLBbLpjZh7NDePfTaZsgjCu3W5oKc5stzJYQHoCLRi0I
         TWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/rRIJa28E87G+jRMgYxlvmy1ZUbe3q+1VyA0vyAvkgw=;
        b=s0BvWbvya/W3ZClKyp7YlZfNOAocE9rKHdiwrAFKL92ZGIIaAzYvk5NZv9/ErbH13i
         MeM7fmLoPigbnWvUDRpbGKyyWfDBbXkWijQ2nV8+xbWnck6urNE+V0EHpY6PjmLapl2d
         EfMyVnsarJX3bSdUHChsksfh2tFKAwnVXp2YSyU800nJLsIIB4Oy38/N8G5QyKqezG31
         dRYDa7xUwNgGxD5Hi7gc3UT6TozRpfIHo97sIzfqy/giFtzVcisGXY3ooh189pJLdRRJ
         XI0py7CqR39o8RLUjmNuJPCkFihO6sZTitzV7YsDyZbi9YAf8+NdUgZrm8JlufO7Lo2z
         v/sA==
X-Gm-Message-State: APf1xPA/CYMrYU5+wUSXCsCqgW9vp3ib5gJeEcf3OhvYf5UAZHfWZY0P
        PD2mjzVl4h5/azNAFZpJFwrQaqKkoTrV3fN1q+s=
X-Google-Smtp-Source: AH8x224JWhN+FHvbj2T6T7xs3OjASbreRisdIG4/BevaXVT3BrJO2PX0ktdJ8/44fa7y+YnGXgDtOfNQC/LKtSBM4IU=
X-Received: by 10.157.14.67 with SMTP id n3mr474940otd.337.1518517551565; Tue,
 13 Feb 2018 02:25:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Tue, 13 Feb 2018 02:25:21 -0800 (PST)
In-Reply-To: <ad9a12af60cdc6ff747337c4116fe41860f82701.1518365675.git.martin.agren@gmail.com>
References: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
 <ad9a12af60cdc6ff747337c4116fe41860f82701.1518365675.git.martin.agren@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 13 Feb 2018 17:25:21 +0700
Message-ID: <CACsJy8BPy_D4pg3n+c6eL_W=9eqeA++V4TOhp3PgOo_++YGhVw@mail.gmail.com>
Subject: Re: [PATCH 2/3] config: respect `pager.config` in list/get-mode only
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 11, 2018 at 11:40 PM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
> Similar to de121ffe5 (tag: respect `pager.tag` in list-mode only,
> 2017-08-02), use the DELAY_PAGER_CONFIG-mechanism to only respect
> `pager.config` when we are listing or "get"ing config.
>
> Some getters give at most one line of output, but it is much easier to
> document and understand that we page all of --get[-*] and --list, than
> to divide the (current and future) getters into "pages" and "doesn't".

I realize modern pagers like 'less' can automatically exit if the
output is less than a screen. But are we sure it's true for all
pagers? It would be annoying to have a pager waiting for me to exit
when I only want to check one config item out (which prints one line).
Trading one-time convenience at reading the manual with constantly
pressing 'q' does not seem justified.
--=20
Duy
