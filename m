Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2A8C7EE29
	for <git@archiver.kernel.org>; Sun, 11 Jun 2023 02:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjFKCfX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 10 Jun 2023 22:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjFKCfW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 22:35:22 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2A610A
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 19:35:20 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6261cb1208eso25357866d6.0
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 19:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686450919; x=1689042919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fNf+I7loO19HS/FLfq68JrIOKRWv4jO0NGEI6eQ3Ro=;
        b=j6LReYOk6DelhkThZ/vLtv1kRFR+g/xVxvIwMjpm/2pZTsWmvMnfJdXyUKxW4xhNLc
         KrPb23jt00T/fy6jFmll+Y5U3MsCcndEpgpk4mCnQLwJ5EiqSqnyRGCBdRCXwpzfeq5a
         Sw2VYm+puNq33+c5LexRypXPnmHIRUt0tamPjGLVHwv/ZpOn6dU19sQ6sfhhq99plzNL
         h9YxFS5IsuEtzyUXDD373ixIbYcF2Hab8tL2h8TSNGYUiDbuoh5vgBKfcWa+rDQgM9Lc
         mf41BFixnD5Dx5MqRsy9Ns1k7p08Sp1NqQRMQBoYUY0y1nJY97CIPqhFw4kYet7qwdIg
         uKpQ==
X-Gm-Message-State: AC+VfDykt5t2IX581YAaPtM85RSjOAesqxoqfoh6zaVaqMPW9FhnCN31
        Tn6G+yZjjAPerMiXR9EAg24b93hARwUzqTiV/NanPADh
X-Google-Smtp-Source: ACHHUZ7VSuITkP7U/opjRKSQua4cdjLN134/LU5f/hTcJcBqMA6ZNNbWDqe8sHAjUFnY0ajKnZ5CTaQhYSJQi4G/SdA=
X-Received: by 2002:a05:6214:b69:b0:626:1741:f3f3 with SMTP id
 ey9-20020a0562140b6900b006261741f3f3mr11313191qvb.28.1686450918963; Sat, 10
 Jun 2023 19:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com> <5dc1e541d1606807e188015ce51da4f2c7f8ff5b.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <5dc1e541d1606807e188015ce51da4f2c7f8ff5b.1686428485.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 10 Jun 2023 22:35:08 -0400
Message-ID: <CAPig+cQ_A1i5NNmaLUmGt+h-J0PugrFX7jkKJ=dBDg3Ygk2hJQ@mail.gmail.com>
Subject: Re: [PATCH 23/25] completion: complete --diff-merges, its options and --no-diff-merges
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 10, 2023 at 4:24 PM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> The flgs --[no-]diff-merges only make sense for 'git log' and 'git

s/flgs/flags/

> show', so add a new variable __git_log_show_options for options only
> relevant to these two commands, and add them there. Also add
> __git_diff_merges_opts and list the accepted values for --diff-merges,
> and use it in _git_log and _git_show.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
