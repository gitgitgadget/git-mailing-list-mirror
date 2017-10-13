Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29A1D1FF32
	for <e@80x24.org>; Fri, 13 Oct 2017 07:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbdJMHGB (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 03:06:01 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:52266 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbdJMHGA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 03:06:00 -0400
Received: by mail-qk0-f175.google.com with SMTP id b15so3944238qkg.9
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 00:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=g4qBslxG6Rk1T76livo0vuISOwJnAi46lEFSd1JYVj4=;
        b=KIf8dUeLJqBURJ8+sxAWt8v9wyGjVmmvT6C7ObtRBl0iV+BRujoJuFS9BiKwK80HNG
         xx/RWgHNZ35mOT+ygUDlvsJLVlGZYuJI5CHYzRTG28M5cxm7yQTBIWvszTAr6j2vOoeL
         dfZGoSY/u1R3BtFeduzdJ2htYNxBZ5eYv13VD0vrj0ar0SfaGP/wgUWo/3MpQPyrtmyi
         BQ4qkr/VtPTq38Be94MIAUBSdm20V7Lu5w6cEQ5zfARE6Lgn2AHvmZWgkTOQJMNSvXOL
         WuGJYC/DYexmhUwIH6H+pjRJWuMI1hEcu2mnsZplp6wrFEyoz2I8OoPfQD3DjSqdnz6O
         Q9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=g4qBslxG6Rk1T76livo0vuISOwJnAi46lEFSd1JYVj4=;
        b=ROMoXe4ijPzhFyYQuv+FP+9q6jIP9hLgKH1m7TNIH/2s9nAVnnfogZ+wHr2urd+zFP
         xwq7etV1yrhQrQudlF3fIhHzrlG1yvvxLoh9QcuPVODrNYf9ehxHqCLaZ0yNIvGiQqr2
         g5CR+ZSifsdaa//xbZ1JTp2XmY/rewuPKWwYCdf92hRbNIfMvMn84b6KUO7rZ82Vg/4z
         G473cN4cAw1SdnoGSip+KsKSCqWjaQ4vaQ34Zi+jDsOSO41470uAicSw9odat2X0+gGi
         LQcCulE+6FKbDdxvpEQq5KC/E3zPiKdM0xDx9pdXoSrQc2vxLxbdxSSfPnyBuP11BLxz
         CaEQ==
X-Gm-Message-State: AMCzsaXwgUp3lzuuBuj0b5zt4REoNURr82xisemreLnL2xp8jwyBep2N
        mqNZhBSZ7AJanx5J4LCGTzbi7pbxE2X6exJDqHg=
X-Google-Smtp-Source: AOwi7QA/jFwwcOgbwFf8gEi7AKVQfyDCwGVUup90bb60Mi6C3G4+o8YJN//Dq0U7J+HnDAL9S4SMPivCEXroTCnMdQU=
X-Received: by 10.55.197.152 with SMTP id k24mr599219qkl.178.1507878359795;
 Fri, 13 Oct 2017 00:05:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Fri, 13 Oct 2017 00:05:59 -0700 (PDT)
In-Reply-To: <20171013051132.3973-2-gitster@pobox.com>
References: <20171013051132.3973-1-gitster@pobox.com> <20171013051132.3973-2-gitster@pobox.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 13 Oct 2017 03:05:59 -0400
X-Google-Sender-Auth: YP1pvMKLGm-PlTWZkZW7KssavhE
Message-ID: <CAPig+cSey2M4jUE-VbdqyQjDWZL1PHfvei5VL1VE+KDxd82v6g@mail.gmail.com>
Subject: Re: [PATCH 1/3] branch: streamline "attr_only" handling in validate_new_branchname()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 1:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The function takes a parameter "attr_only" (which is a name that is
> hard to reason about, which will be corrected soon) and skips some
> checks when it is set.  Reorganize the conditionals to make it move

s/move/more/

> obvious that some checks are never made when this parameter is set.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
