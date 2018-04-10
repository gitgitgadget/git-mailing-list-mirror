Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF9E1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 20:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbeDJUF0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 16:05:26 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:40405 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbeDJUFW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 16:05:22 -0400
Received: by mail-pf0-f174.google.com with SMTP id y66so9160293pfi.7
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 13:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a5VD71yA8yQo8Cpu/vYe51ZXyqNC/VqjNUQnYlY5oIA=;
        b=SDQXSjEY5pR79mYetXfyUQbSTikLGgT7FKnl8wY9lLBh4JPL1YRZ9SCoddw8OQZtld
         y7jADGKm9sdRA3vdPdzDrt+GndYRfXWev2OlxBdwFmD7SpnW0VzCVAwwhLIU7Lj01WA8
         xF5y4wc4W6vsf5+GdeoYGFhpFIaLyUyWCXLuCP+xwkgnArSPEfm4Yqw7BP2gYUme+ein
         PRxNk7uqZcuxxGFRo7vobdXRkd1pEnj4OG3hStz+3Fop95yJQv6fg1CqdR2xWabgaInT
         /cPQ/XDexx4gxRrXZDH6E00ItdU70j1rJHUnZDkl/YieSiJZ02PsGmm9OmX9c2hD1koP
         k8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a5VD71yA8yQo8Cpu/vYe51ZXyqNC/VqjNUQnYlY5oIA=;
        b=W+YLM8TrIeLDfvOAFf1k9Dw7MVHPg3sCyDKE2pJFMOn5VNy9TDHwAXx06btYDNLqEQ
         V5/ZlakaiJlKEMgfh+jIT9i55gVp8j0gN3gSDsxGlju02hINutbDPMC8KY8Ljdp3QdhP
         YlTGXCLWtw5/1tTRc8QvcWAmLhG57ZF7qua/Mmd2pYtMaR5ZjaCCQE27swEczDV6kYWj
         0Qz3buDPQSMABX1b3DRUIyNOF41LQcmU4G2FFS5OAkLFancBB/G+CZquwnt3+fcEzI2Q
         PMKcbtEKqgnHtxkwN0TWg2X5wcG2KfQcCLwOaIYslGGWvZzYvrZLJofH+XhyhCQIsgdj
         C7kw==
X-Gm-Message-State: ALQs6tA4oOyTMAZF2kjv68AntpBXM+AO/48d99nVhOoTpsKtyudc7VM9
        +kgVquKHbayqvmwYk17oCHDIc24T6tH9DAyHSec=
X-Google-Smtp-Source: AIpwx4/j9YDmvFf4AXEsdX2nBdbPHaPOWr90Abe0GjO/LbNgdQadE9OpqC+FKWVdoDYJFnW0zY80cIigQLDaGlQMssg=
X-Received: by 10.101.88.140 with SMTP id d12mr1256902pgu.408.1523390722258;
 Tue, 10 Apr 2018 13:05:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.178.66 with HTTP; Tue, 10 Apr 2018 13:05:21 -0700 (PDT)
In-Reply-To: <85c6d713-7e36-6068-f6d3-9b9144a4958d@gmail.com>
References: <20180410183224.10780-1-asheiduk@gmail.com> <20180410183224.10780-5-asheiduk@gmail.com>
 <CAN0heSrrPa5-ckjsonUh+3JpoAnaAT=efJT4Rp7uEn=UfWpC_g@mail.gmail.com> <85c6d713-7e36-6068-f6d3-9b9144a4958d@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 10 Apr 2018 22:05:21 +0200
Message-ID: <CAN0heSqsBjLAgWwZPoJq1h2m4hGHm5hZRkpDYVEkuiFJEhOhEg@mail.gmail.com>
Subject: Re: [PATCH 4/6] doc: added '-d' and '-q' for 'git push'
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 April 2018 at 21:38, Andreas Heiduk <asheiduk@gmail.com> wrote:
> Can I add "Reviewed-by: $YOU" to this one and 2/6?

Sure!
