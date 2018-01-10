Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459A01FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 09:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965226AbeAJJ0w (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 04:26:52 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:40387 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965327AbeAJJ0p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 04:26:45 -0500
Received: by mail-oi0-f50.google.com with SMTP id u83so3971766oie.7
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 01:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xC84nYVzOtVr+OElxn7iV87xGLATbi1SIM6bq7RAt+E=;
        b=FyFYxo39waPcrXlv1rQEHlcbne8VuS0/nOIS1tcFf3rI6KpKKYN/isg4kre8o1wHfm
         pIsL4qv7FGtsOVCsQAUteUY+cv+6Nr0RhGNNBq1Fk98N1mj0IxpjQmQjZOyWZ6ue7Dai
         DprOypWpnNe3AKxSB3CqEYffLC/Md/mkuM4eK2iFP/7W14VTHZvA/QppprcG+sbKtsml
         8XY3DvLya1G9qz6qNpDmB+6XXzfYSkGz1elYDY+5PVDyCx77hFsYE9IRwMtiXMSAZzaJ
         RyHyp8BEcJHJCv2aZaBZ4pgQ/YrhLl043vqW7HbHVYOS1ZitJosnjYp6Q/VAOAl0GjX4
         dBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xC84nYVzOtVr+OElxn7iV87xGLATbi1SIM6bq7RAt+E=;
        b=suV9fFPWeWQ/GpL5ebRb2Swas5/yA0OJ09oWNIL01cF8dTOWWOa4nrhw4G7HTXp2VW
         Tc06e0gyiFVLirWNNelbPWtxwFF59uGjIvuZ09d7RWrcM3XViHnXbQBrg6MqpeXlOBPN
         wVxPTtyKrv6BBDlcy6K12PIvhYWZhIkgK3s3XGPfEpVCeyjbaJgo1zXAo5pvpHJvtC8W
         fiUJ9bdT6MNNf1k2oI4lC5xCfYrVPV9qpP7zXZPBHQemd+zcAuUdqVuw2ksYgXJX3J2K
         xeM2zrBpkI948rp0eqqCsN096+GFOoiMZg3bMZcsgS2aqdX7QwZwv+Liqz/m17T+jbHc
         euZA==
X-Gm-Message-State: AKGB3mICAV3dNqN8aR4gyRwDH27cCTbsWli1HghEcyHr5iHsRSEokuW0
        zlNf1j5RsaXohLmPcR3sVW/OQMBmZjtK6bBLQUI=
X-Google-Smtp-Source: ACJfBosm7wRO+Hk7XYJLfiF6vkzOXcJxj67zW6jqKz/fFmm2k4uDWnvSbAw23AV6D8wzRNgUb+UyqDfNCDoUgf2DeZw=
X-Received: by 10.202.252.3 with SMTP id a3mr9369669oii.252.1515576404399;
 Wed, 10 Jan 2018 01:26:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Wed, 10 Jan 2018 01:26:13 -0800 (PST)
In-Reply-To: <3a8169b4-1d7f-35dc-eb23-49afdaa3bf52@jeffhostetler.com>
References: <alpine.DEB.2.10.1712221829430.29746@alexmv-linux>
 <20171225103718.24443-1-pclouds@gmail.com> <b3e90960-d743-3299-ba43-150849b591d2@gmail.com>
 <20171226021150.GA10059@duynguyen.vn.dektech.internal> <xmqqh8scnip5.fsf@gitster.mtv.corp.google.com>
 <3a8169b4-1d7f-35dc-eb23-49afdaa3bf52@jeffhostetler.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 10 Jan 2018 16:26:13 +0700
Message-ID: <CACsJy8BgiDrr81FFM8-Wh2ufbPAaqVzncEp9ReB1N8hz8WtF1Q@mail.gmail.com>
Subject: Re: [PATCH] status: handle worktree renames
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 3, 2018 at 4:14 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> Also, does this introduce any new cases for reporting conflicts?
> I haven't really thought about it too much yet, but if there was a
> divergent rename in both branches of a merge, do we now have to handle
> showing possibly 4 pathnames for a file?  (merge-base, branch-a,
> branch-b, worktree)

It's an interesting question but unfortunately I don't have an answer
(I read your mail earlier but waited for so long because I didn't know
the answer then).
-- 
Duy
