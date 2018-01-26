Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A06F1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeAZTLg (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:11:36 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40754 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751998AbeAZTLf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 14:11:35 -0500
Received: by mail-qt0-f196.google.com with SMTP id s39so3888958qth.7
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=72j58soZL0wMaGAIA9C8KPcBxAUrA8RYhBMRnMpTD7k=;
        b=DvRyDgtChux3QwZO9zzs1aGdWUVLHhx+2kYIN6z3aHOH/GR2CyElf6+x+Lkyu2TgEu
         eJm4EViUyy7Tz0vj4e3/HTEPHo/MvY9WzbIYCA/aTPN6gSmXmRTVM8qVz9A52gOQYIw8
         ArkGKJtCZLfN/ZTcF6z4ThZZ8xB9DlrOLGCPvgS7Hx1ikU2M2NegkcOTgf2DL+IWOaEa
         +PzTvU/ymb+6LeHUzhBPOiGfhDUFZ844OKVymt+nYNY1J58vC7WsHTm4mwNX4fFhNX7m
         zsJwrvrzXr+28aNS8HRUHAjb8PecY/xJJ7Lb41PC+5pvuMb1mlU146VaHISzPChvYI93
         VTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=72j58soZL0wMaGAIA9C8KPcBxAUrA8RYhBMRnMpTD7k=;
        b=ptkM1RCA0odbo31Tldsb48hg5vynRfV1xeflZAc8ozNiom5pMJadqdQGtQVjLBY362
         a4k8leDIUXvxLfkpJUzD7GKQBeGE34LTOib076/POWX1uXZ9gd0EAHQHj5ke06FyOmjA
         RcR2LLyLoGM+pXokPz1s3U/abQWbrIJ6AD0Qdz+/zuuPlQ4gxXEbmBV2Pmjr7rpsTCF6
         Dr3DY3OznqpJAEfOraqwITKPQIS2yhxGyIlO58wJNEDBEqbhbHW7+G9Pq1fa+KplSrr8
         HkBN1M5BBYgT1F63s1SYuSC7sebcZJlvTqTPgE3IqWMXQCZerQSteEhfljmSuaxiO5kW
         BnIA==
X-Gm-Message-State: AKwxytfgO7zQcnw58AUR6tVR95SopA6gxK3NRRTvkayZb7xDoYCFD7Mv
        4fKBE+hzd4WgydLTItG8KAnX3fDQpxB1VQ1x+tU=
X-Google-Smtp-Source: AH8x226xHRdJKH7OuLlBfwL57qIFXDJviF1dVx+H4kNvVoUvQZqaAn9b6vNkzWTc8xKBgW01R4FTnZ4fXMPJ+/cBY5Y=
X-Received: by 10.200.7.74 with SMTP id k10mr26357428qth.333.1516993894537;
 Fri, 26 Jan 2018 11:11:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 26 Jan 2018 11:11:33 -0800 (PST)
In-Reply-To: <20180126095520.919-3-pclouds@gmail.com>
References: <20180126095520.919-1-pclouds@gmail.com> <20180126095520.919-3-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 26 Jan 2018 14:11:33 -0500
X-Google-Sender-Auth: 72wk3hZyVuTX3icHkgvbLdLdwLc
Message-ID: <CAPig+cSjxiOTEKuOR9zGrY=Z_RoSBPHaiyNkzp-tXjSVNj3RHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rebase: add --show-patch
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 4:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> It is useful to see the full patch while resolving conflicts in a
> rebase. The only way to do it now is
>
>     less .git/rebase-*/patch
>
> which could turn out to be a lot longer to type [1] if you are in a
> linked worktree, or not at top-dir. On top of that, an ordinary user
> should not need to peek into .git directory. The new option is
> provided to examine the patch.
> [...]
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> @@ -840,6 +840,10 @@ To continue rebase after editing, run:
> +show-patch)
> +       cmt=3D"$(cat "$state_dir/stopped-sha")"
> +       exec git format-patch --subject-prefix=3D --stdout "${cmt}^!"
> +       ;;

What is the behavior if a rebase (or conflicted rebase) is not in
progress? Stated differently, do we only make it this far if
$state_dir/stopped_sha exists?
