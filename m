Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD84C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 23:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbiLBXcW convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 2 Dec 2022 18:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiLBXcV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 18:32:21 -0500
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8BE784B
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 15:32:20 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id t17so6290297pjo.3
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 15:32:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KUqm920QfiNzRhYSo1LCfNK3YEyfDzDuRLLi9PnU+M=;
        b=tsjFcVd+PRBTcZKqNxSpZjHFMXSwtfRkTkahPekcjbN5GoHGnFDq+eeRIDw395Vnyc
         GOFdsdM1R0n7k7+Of0ZM4Bi221LH4ykisCA9k8vPvi4OwGY6olgXNeqBiORM7B3WIbd9
         d4wWqpjr9YgErwElKHbeY271Xxf5SaNxWpKdJAyColY3fWx9s575Aj4pTGoqT41jJT+E
         +Rc9aiFXtEbRgQ+LzUmFbU4fqRQeSXCcLZDgcmu1qTFMWmgZaFZFlNitANZTIlSyHVMW
         G1KvrKZ+pi+45rAq9/P1Syk+ov1xdsUM0cqgKAHprOmVCaLff5WFPYilRat5zlITMGy8
         sYNg==
X-Gm-Message-State: ANoB5pn9acwMH1cA+80htzhq/nj5578gEiGoufNrzH0IfxbxEKPs1rhv
        SHZQygKn+NBAVQVpGVovC8VXmXHxw7a4afkREHI=
X-Google-Smtp-Source: AA0mqf5JcYWqOij3aWqOKnJlNW2P88ccNiear6g3/0Zd7et3LwSz9KMpdM7+4dyNzG4clzUcFrOEGN4g8GZz4TGlVGY=
X-Received: by 2002:a17:90a:898b:b0:218:bbfb:72e1 with SMTP id
 v11-20020a17090a898b00b00218bbfb72e1mr60534573pjn.64.1670023939503; Fri, 02
 Dec 2022 15:32:19 -0800 (PST)
MIME-Version: 1.0
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org> <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de>
In-Reply-To: <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 2 Dec 2022 18:32:07 -0500
Message-ID: <CAPig+cQBsr30Sr6djCN5_982-nrrhduTcMK2PMJLTXHvsdmYAQ@mail.gmail.com>
Subject: Re: [PATCH 2/1] t3920: support CR-eating grep
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 2, 2022 at 11:51 AM René Scharfe <l.s.r@web.de> wrote:
> grep(1) converts CRLF line endings to CR on current MinGW:

Did you mean s/to CR/to LF/ ?
