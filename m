Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B566720C11
	for <e@80x24.org>; Tue, 28 Nov 2017 06:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbdK1GCi (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 01:02:38 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45771 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751406AbdK1GCh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 01:02:37 -0500
Received: by mail-qk0-f193.google.com with SMTP id d125so35692851qkc.12
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 22:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YelJnTHv/BWvdx07k3ojiYSiuNp4kL3zA+HB1Iy+be0=;
        b=YoQfVVt8uR51OMLNHQUI1rchVIdI3/InKd7O5nR0sJrffWUXn5Kb6ZaLvXjkAq7TkH
         2BDMkI5+SOU5bW7fyFTObByJjosNxnsR7TCQ7DP4vKFJ7Zzison5IVtb+l1VRh9BbzXY
         iltyDNkeKl8T7sVcOPtMcizsJt0KRVyHfChnmUc/lNaiWHJxjkDgaI3uQcT3T+X84C9h
         vJUJh/og9zZQkKr6i5ar2mz1Gk4UV9QDQC+3dlmcCyxRPLEJ2KUGovO1QX4LTBBDMFf/
         qV1R2oS1oAs25mv64ZzgOksR9OfHZo2is/v0oVnOu4XePT02k2rCBwGKQnwdgiiYzWHg
         NxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YelJnTHv/BWvdx07k3ojiYSiuNp4kL3zA+HB1Iy+be0=;
        b=KjIKTNN4DdPp2nFL57XoOuZa8HsXt8tafhsiOx3J9VYB+Pn1eGLsox2DBs25lk4M4U
         jmvFVfmu5cnFhCIPWnMqs1Zs0w+lZ6Uyg+h3U9NmGzfu+nISamQ9FeIfo/f12xQNenX5
         4S7mWxB0ZCF2hey1dKYRN/jumI4bnz6GX6B5ndDV1zKFLt7xVTxCBsH3/1Lbta6GJblz
         CUX3wBMkXkTRs/a598V0eFz1God0PcrJtpEvYCU5RUz+1jHhIciQaj5zu92J6TFzFC/j
         UJTbL9pYAt6ZKdmPdnCS6FvShHduQvMr+708bSHfOSPTWTNChuxVH+cC3s4dpLl2wafZ
         VOLQ==
X-Gm-Message-State: AJaThX5KTGME0pXzHVDq+l+sc1L5F6kdO3FHH6HCYBH5deZ27zryhlNF
        yJo3TPvhfYo26buZcQKELbMpuTWOR2xNBEzDlfY=
X-Google-Smtp-Source: AGs4zMaArX5M4QttKQf8k5rQ4lNZle9of2bgzL9U+5xiYKFAm3U/AlRzv6sDzjhNbnkaSUURP/xFQ2VcULmq1qk4BdY=
X-Received: by 10.55.90.4 with SMTP id o4mr49047818qkb.296.1511848956785; Mon,
 27 Nov 2017 22:02:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Mon, 27 Nov 2017 22:02:36 -0800 (PST)
In-Reply-To: <xmqqy3mr6ocp.fsf@gitster.mtv.corp.google.com>
References: <20883815-0d9b-a4d8-cc93-0eb8b918551f@gmail.com>
 <20171127173621.6707-1-kaartic.sivaraam@gmail.com> <xmqq7eub85rz.fsf@gitster.mtv.corp.google.com>
 <CAPig+cT3jbZ=VRWpggw_tvegAGnjGQ0Mxp8m2DdKKPhfKTVEWA@mail.gmail.com> <xmqqy3mr6ocp.fsf@gitster.mtv.corp.google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Nov 2017 01:02:36 -0500
X-Google-Sender-Auth: qjZ9ZuW0drUR7sFVH4_JiFuCnxk
Message-ID: <CAPig+cRuR2cE9RtdOfvgzGbPVLBEtb38v24Myh9rn4zKk525yA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] builtin/worktree: enhance worktree removal
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 27, 2017 at 11:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> I had envisioned a simple 'goto remove_control_info' rather than extra
>> nesting or refactoring, but that's a minor point.
>
> Yes, use of goto is also a good way to avoid having to worry about
> the future evolution of the codeflow in this function.
>
> So perhaps
>
>         if (the directory is no longer there)
>                 goto cleanup;
>         if (the worktree does not validate)
>                 return -1;
>         ... the original code to (carefully) remove the
>         ... worktree itself
>
>         cleanup:
>
>         ... remove control info
>         ... free resources held in variables
>         ... return from the function
>
> is what we want?

Yes, that's what I had in mind.
