Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0F1C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 16:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbiCaQ5p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240323AbiCaQ5n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 12:57:43 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69802325CB
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:55:54 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p8-20020a170902e74800b001564f2593a5so75819plf.2
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :content-transfer-encoding;
        bh=yxIsJaGJxVnP65heG926fG8gvtyyja/KgkiZkjHCRmI=;
        b=Tm/Dy/192Eg7iXcjHmO/5TP0SHkHv0jcW5YngyPd22A3fFFZ4fwmtWXr+n5TS5f7wv
         AmP9bP5E3iJr98HSe1a/iiseORJZzcRH5IzB8j58Rxpoy7ISlW9zQYXgAfInCUQOQII4
         eM7UubE7zYkC3edWjXTB2q0p8NJBPTEpnSTywuuFQpdnyhN//Qf28++QUYrmw0o38pI6
         5/Ji+Tso4JrXcNh5znFDbBeHzpCtmFd5eFkv1sNxg1JO+4xmUhWnIQrT8GBo7lwvDYNB
         7DxiYYQNQBO4UA0t2DopkNaltpHvBpDEq5KsZmySOEgyACCitfLMO327pHlFxgL02aXd
         lqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:content-transfer-encoding;
        bh=yxIsJaGJxVnP65heG926fG8gvtyyja/KgkiZkjHCRmI=;
        b=g7MEUsk/xGRGbYCqKXHyUStJEO5PWSwOVRJGIMTEwijciIM81WPDpSP6E3mmN1B8ej
         YGAb3V0hrSA7brXNviQrCN1ej3FK10iqGRPRl1l3FzgNFJiNcnlP48c8Ni6uPEjmjEI3
         fSvRaraIoG4dS20VznI9FDI24/PKivS7qjoi02JKp3Ixqb/uFl+PpSkjG9yxs2vGTZ2v
         uFWtwC2QU5CHoByEPSj0OzdVjX4msKbFdXc1J1hj/lOBvVC82WkPs9eLTC8xkKpbwmXn
         92dB6ExYZixIbyOAeBXxYVF5+U7JF1u6Wn6fvUkCt0I71TdjghFPxhVhFaoKQJMbqck3
         SVkw==
X-Gm-Message-State: AOAM532qyDlP9gQsSeCdgHA4xw/7GURxIgmOkd1aGyRTDsKrW00mwZil
        JVKOuPgcJ6Xl4UfBnAcCvleZ9NJqJ+7B8A==
X-Google-Smtp-Source: ABdhPJzQ8yZZAEITVJfgo2MQybjDO36zyCk9yoQBgdKHRHKSd8PP6mJYTAKQ0FDWYTDqVB4r8FjfLSzcMd+mkQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:dd46:b0:1b8:8:7303 with SMTP id
 u6-20020a17090add4600b001b800087303mr7057026pjv.197.1648745754386; Thu, 31
 Mar 2022 09:55:54 -0700 (PDT)
Date:   Thu, 31 Mar 2022 09:55:52 -0700
In-Reply-To: <xmqqee2i50h9.fsf@gitster.g>
Message-Id: <kl6ly20qrrhj.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqqee2i50h9.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Mar 2022, #07; Wed, 30)
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/branch-recurse-submodules-fix (2022-03-30) 4 commits
>  - branch: remove negative exit code
>  - branch --set-upstream-to: be consistent when advising
>  - branch: give submodule updating advice before exit
>  - branch: support more tracking modes when recursing
>
>  A handful of obvious clean-ups around a topic that is already in
>  'master'.
>
>  Will merge to 'next'.
>  source: <pull.1190.git.1648584079.gitgitgadget@gmail.com>
>

I'm planning on sending another version that incorporates the
suggestions from you and =C3=86var. Probably within the next 7 hours or so =
:)
