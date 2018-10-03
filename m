Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 576191F453
	for <e@80x24.org>; Wed,  3 Oct 2018 14:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeJCVV4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 17:21:56 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37344 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbeJCVVz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 17:21:55 -0400
Received: by mail-io1-f68.google.com with SMTP id m16-v6so987735ioj.4
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 07:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gG1xDf6yosyRiz7ZkttLGvbI1Gvelt85jMzk3oSaddE=;
        b=MJvTmgiN7DzBeks2MvvVk199U7UR5J7agjxeD8W3+/4Wo31ScSRU1wZR3b2c0AdkJ5
         IsPyHjzNv7FpdOfVHQd2IuoHCG6L6FOjc26WBIprFbZ1hzuS7VqR5+DKek6zBwECsrVu
         mKOleW90tUuG4AVeZ7niLqlsGEqA5CxcDcCPLsZXcielBALAlVHwZVWQuMkYAZ/YaMKJ
         c8E4t5x7HoGPAo3Q49t17EckdsygbT4X62FhSF6fFcdrzgCdDBcoQp1gCPMAUFDxJW3i
         0Vuuosg9Rx42w0OrENDJIFtyLsKCkQD2VjgLWL7SS9WvBmoqoa9JS490+SobSMhNg3Tm
         LFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gG1xDf6yosyRiz7ZkttLGvbI1Gvelt85jMzk3oSaddE=;
        b=pDbtHJepe7ZEhgwCtz2oATgTj1pCFUmqU0L59Jyo5bNziUYrlvfHSGlbz6PCT2CU0O
         32TXGz5AlgphAkky50rpFBK0xAWeR39XNujteWFrP2s3FtiajDPXwyCc/SwY/u5/kXTi
         LP4MaHJatbaGcVtW3e8Sm2MCTe+VrQnbAILz122LC5mzuzMo2eI3kkRyXMNEaR/dstFf
         qN+3lUVTnGqTbOxoirSGevrEfqxjq9V+vTGBTGsP1DsuQNQwSZJCk6o8PZT8H3Sq9EBt
         Gh91JNCrPwCzZcxwBxPy2HFE0iFteUD0ZrBZVHOswVOfWF/c+e1pMn1m+jH9mDCiHCQv
         CmEA==
X-Gm-Message-State: ABuFfohRMB4ENxTayXFTqZvLlsHB2H3wL97AdmsK9LlMru3zl/6X/xL9
        Ocpcm9EvrbXGJG3w8pOQRM6s+BFCkLa5Rw3vFepPWg==
X-Google-Smtp-Source: ACcGV607PqE5ZK70pQ86rn1a0NiMMF59FsqzsAFVpNyydfxZYP6gpi4IiUXWt4paCO7IlBsZqWnd9VuHJXX1X4G4fp8=
X-Received: by 2002:a6b:8f93:: with SMTP id r141-v6mr1219437iod.118.1538577195915;
 Wed, 03 Oct 2018 07:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <87tvm3go42.fsf@evledraar.gmail.com> <20181003133650.GN23446@localhost>
 <87r2h7gmd7.fsf@evledraar.gmail.com>
In-Reply-To: <87r2h7gmd7.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 3 Oct 2018 16:32:48 +0200
Message-ID: <CACsJy8Dan1vRKYceBDVktC6FuzEiF4eHm+jE4gx09sTLL0ykyA@mail.gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 3, 2018 at 4:01 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> >> and change the
> >> need_to_gc() / cmd_gc() behavior so that we detect that the
> >> gc.writeCommitGraph=3Dtrue setting is on, but we have no commit graph,=
 and
> >> then just generate that without doing a full repack.
> >
> > Or just teach 'git clone' to run 'git commit-graph write ...'
>
> Then when adding something like the commit graph we'd need to patch both
> git-clone and git-gc, it's much more straightforward to make
> need_to_gc() more granular.

It is straightforward and misleading. If we organize the code well,
patching both would not take much more effort and it reduces wtf?
moments reading the code.
--=20
Duy
