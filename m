Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76E0C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 09:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiCVJS3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbiCVJS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 05:18:28 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DDD47AE0
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 02:16:57 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 17-20020a9d0611000000b005b251571643so12133257otn.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 02:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0M1mhxv5lLwWSDVWExIfGmfVRm/0LYpYfn95E8iBPA4=;
        b=ppxcTD/gmEvIJflVtQlBp3EPfoVKNDA2CA5L4mLvXdASrgvG/dgmUj+pEBJwz3H+tg
         FcNDyuvRrO4vVYokh2rTm/E9usRTDvpsVSN4agrRVdntSfMWbWNVWzjWCLLlfvK18MqY
         GBaRe/XsSqoqVVKSbE+ZtXAghAahfi+NnFX1G6haqUInPDFPbeEXk9eRLzcca8nil90p
         9dKKzVCZLebRBy5OzKm/Rlt+uejiw45MUDlpJ46tQSqCZOr11mmNp/6ldO/w70IzcNbL
         voQJf/URQdmeu5rh0paFwkrv5nmDXce6wUUtpNCrqBIHmf7U2mO9PP0W6W1ePLvmVDcx
         rEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0M1mhxv5lLwWSDVWExIfGmfVRm/0LYpYfn95E8iBPA4=;
        b=6850G8JLm8x0bvUaLOVRcWc/oIMGvoYjOB2YrgpKj9OMmLZWKViMWLxx7DzAGN8Pg1
         0fQn8T8s0jk2A+wafN2/FzsMwk4/V74VGz/bWUR8kdxqxYrAbP3kjCfzngDbtbW514JV
         TfDX56U4vRQ4qgks9Q3n8Ehdo079g1FYZn71n6Asxu3sjBgg+wuidPUCWCJ1ateKYugg
         UbwYfqFiL7WQXsh52OeaynHxuColpsBBa9t8uSQb6auvQ0lYmKKwKVno3iwxPvSjpFeG
         jQBAOrffqTj1diBHbe1DAGcbvfMBX8pWI7cCzhKhJ5YP3QSocys87obYjx0DAVRzrGmR
         XkXA==
X-Gm-Message-State: AOAM530evuopoOcP+znAgPrmMQL7CpNeZifYLEgOgIHiP9C7fFISKxyG
        IcEAocWwBTpmphuusBYNYspRaOS8Yj0+WJKWbeVfUvwv
X-Google-Smtp-Source: ABdhPJzq8DDf3lxo06USKtTOQ5RnVUI6DG3UcsKKbDgb7lPAS7MbpNipOTp9fSa/XWopPpJuOXROSfOKHIAl/veHKMM=
X-Received: by 2002:a9d:6b89:0:b0:5c9:7b17:7cfc with SMTP id
 b9-20020a9d6b89000000b005c97b177cfcmr9627369otq.359.1647940616425; Tue, 22
 Mar 2022 02:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220312113136.26716-1-bagasdotme@gmail.com> <xmqqsfrlvfs8.fsf@gitster.g>
 <93d4b801-491c-694e-704c-fbe68f90b660@gmail.com>
In-Reply-To: <93d4b801-491c-694e-704c-fbe68f90b660@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Tue, 22 Mar 2022 17:16:44 +0800
Message-ID: <CAJyCBORBK+j4nnG-MWYksRcXJPPPpAhiqVagqUS=t1itCTWoWg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: simplify synopsis of git-repack(1)
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 22, 2022 at 3:11 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 14/03/22 02.00, Junio C Hamano wrote:
> > Bagas Sanjaya <bagasdotme@gmail.com> writes:
> >
> >> Simplify SYNOPSIS section to only mention [<options>...] placeholder.
> >> Redundant options list can now be avoided for aesthetic and clarity.
> >
> > The "git cmd --help" output is meant to be readable and useful, so
> > clarity is good, but I do not know much about aesthetics.
> >
>
> Sorry for the long delay. I wish I could just say "for the clarity"
> here.

Yes, that's what I meant to say. Certainly "aesthetics" is not as appropriate
to be under evaluation here.

-- 
Thanks & Regards,
Shaoxuan
