Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5361EC433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 17:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3941761050
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 17:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhKBRdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 13:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhKBRdp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 13:33:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E2BC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 10:31:10 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w1so169893edd.10
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KgzzrynJWGE33rt2QYOOyyhMFLyUZWXkoiv5wIPYjvk=;
        b=QzsEIr4Jk1n661/cIFw7W2ATDVUEk3LmqJYK4RSj/HUs6+qb9RS48R1/UqEVzMFH7d
         P9cbHOqv4Q/KT8C2AWE/2GYFNy2fhY2c5jaRqywpyERmfxNxUZjNpkV++YIAg0q0V9vk
         fC3SWGTCtqowvN12RsdJHY81cWpZKQVOYQ3egADdq+bHGILD3uuDEHLSycdMCf2uD6/c
         93FepiE3cpkWURgWoUuc29ktCn+NY4ZLRoQ8n2ZttgiKBmbfPXibbQjg3/dzAdiFY5Dl
         6cgeypwNPw4aNrfFC8xRcd63gyoJ+Hfxuvazy45QWY3NNVvQQTNNS1JCQ9jATUOf4qjb
         5PNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KgzzrynJWGE33rt2QYOOyyhMFLyUZWXkoiv5wIPYjvk=;
        b=j9ok6aEScnwN9VWI+KaePbUpQJV2nuz4GrXWQ2zhYYFC8dGVXdoKSdBnFojnNl76fz
         tQ+s8GWRDtfowtgrrkscVqzos+HUzhV4qlIN3BPAZ0VHASB6sFgexM5bDkaq6wmQbPSy
         EWGw6qmCHCaalCJumCYfdpiqIrby5H4bhmy/nkrjpNq00hinxn4p2imcQbHTyVma01in
         tpvIjCP58EkVp+3XZZRyU9XC21utmoztWrr9Y2a1fcoFacSDCR+kdj4KjrLegsl4OBom
         YUq17h+xoO+3x5raRJLD/3K8qR5aJ7gwxc7F8hqJhXD4b9Ar4XMImTsmz7bcgh42vj1Q
         gD9Q==
X-Gm-Message-State: AOAM530CUFJPGWhQUVxZBqUYYlsREh8J05PNlqnUlI26P+F3a7J3h1xR
        NrowJT1cjmgRobImtgJvEG72qZ0dUIQ=
X-Google-Smtp-Source: ABdhPJwzOvvR0EWR2Xbg7p+3ShFd4GfSscs4lHbPXBBHSow2Rl0iYPcSkLMvUGK9816mcqbqFC7goA==
X-Received: by 2002:a05:6402:278e:: with SMTP id b14mr3731339ede.321.1635874268707;
        Tue, 02 Nov 2021 10:31:08 -0700 (PDT)
Received: from gmail.com (ip5b40c175.dynamic.kabel-deutschland.de. [91.64.193.117])
        by smtp.gmail.com with ESMTPSA id ee7sm2059762edb.1.2021.11.02.10.31.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:31:08 -0700 (PDT)
Date:   Tue, 2 Nov 2021 18:26:44 +0100
From:   Federico Kircheis <federico.kircheis@gmail.com>
To:     git@vger.kernel.org
Subject: Re: git aliases and GIT_PREFIX
Message-ID: <20211102172644.cnsro5p3m6o6b6po@gmail.com>
References: <2e328484-d0e3-8801-61da-07544cc93eef@gmail.com>
 <nycvar.QRO.7.76.6.2111021520370.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2111021520370.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Sorry for the late reply.

On Tue, Nov 02, 2021 at 03:26:05PM +0100, Johannes Schindelin wrote:
>Hi Federico,
>
>On Thu, 28 Oct 2021, Federico Kircheis wrote:
>
>> today I reported what I believed to be a bug on
>>
>>  https://github.com/git-for-windows/git/issues/3496
>>
>> and learned about GIT_DIR when working with aliases and git worktree.
>>
>> It's annoying that GIT_DIR it is defined only if (as far as I've understood)
>> working from a worktrees or submodule, as it does not seem to be related to
>> those type of repositories.
>
>To clarify: `GIT_DIR` is set when executing an alias in a worktree other
>than the primary one (and probably also in submodules), but not when
>executing in a primary worktree.
>
>> This is also irritating because apparently working aliases breaks when being
>> executed from those repositories.
>
>To clarify: an alias that wants to switch to a different repository and
>execute Git commands there works well in a primary worktree. But when you
>switch to a different repository while executing an alias from a secondary
>worktree, it will fail because of `GIT_DIR` having been set.
>
>> I believe it would be better if GIT_DIR it's either always set or never
>> (could someone enlighten me why the variable is needed in first place?).

Yes, sorry if I was not clear, your clarification are what I meant to 
say.

>The fact that `GIT_DIR` is not set when calling an alias in a primary
>worktree suggests that the behavior in secondary worktrees is not by
>design. We should therefore be able to stop setting it there.
>
>The question is: what code is responsible for setting it only in some
>circumstances but not others?
>
>Federico, do you have any experience in debugging C code? If so, it would
>be good if you could take a crack at investigating this.
>
>Ciao,
>Johannes

Yes, I have some experience, but never looked at the git codebase.

On GitHub (https://github.com/git-for-windows/git/issues/3496) there is 
already an hint where those variables are set:

   https://github.com/git/git/blob/v2.33.1/git.c#L354

Or do you mean if I could investigate the test cases Ævar Arnfjörð 
Bjarmason mentioned?

