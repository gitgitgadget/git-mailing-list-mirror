Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81BE21F954
	for <e@80x24.org>; Mon, 20 Aug 2018 22:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbeHUBUq (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 21:20:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40927 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeHUBUq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 21:20:46 -0400
Received: by mail-wm0-f66.google.com with SMTP id y9-v6so961832wma.5
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+NDy9IAGuPoU4/M+85w++/OuIihQoj2hTTV0Ryqd0+k=;
        b=d0ydtX2rDjQI6TO8iqKR5RPHh36pis1ONDFnZvbaV26hm7o1NGjJbzDljIV6Q1lWVn
         oR92qr9wbOG5c9aCcFItVE+1HgbyUE69k+85vl7vVUZGRfiC4oMX+wYVGQVfN92IF4yN
         nYnLrRneJbsGxzJeiN47Ee4QFkNL6uEhIp/84eYkQs8Hp+g/9gpaaiTfVeTnNmHn+iZ0
         TpbxT18WPlx2qZcwI9WkrAEVriK1Q+SyxI45brt12iUR6efXh3LeAOWGgWolkgILYucZ
         O7xYCCjNHsF3Kus/2qp3kblHAI00m8+xSJ/j4oBbAwOhnwOyTWNlcR4i549lnrZAcewe
         gssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+NDy9IAGuPoU4/M+85w++/OuIihQoj2hTTV0Ryqd0+k=;
        b=YCtcr1gOD+v3NYm9mIkthBpE99ylfhyqDWBEUkgoN1WmiG/OZgi2adi8XpnZHb7qMw
         8ZYtyvxBDX3SvmugFWNTK0ppGfJS3r7Rf8wdu0P3MTqszOUiyk7C+bOm3TWOxwWQxEcv
         RaYGEIuTtg0LXOLVtjEqKZ/mwND2FZOdcerSPl4Tsni/fa3lXmbTNA7sOc6T1ryClIr3
         XhYe5++JJY282s6CqO4a70q8jKzC5VOmFMMJEEOMS62olPHiQjiMPeSs/tMcMh1UGjLr
         l1eRW5N7jarayQydyRkx1d2twtW2Dj/+t6BZIJnfThX1Rm5PJyBeK4zLtaBiU/m55x14
         i3sA==
X-Gm-Message-State: AOUpUlEi36Iax0CjyIPKUYoqyuH6CSngQPAP+G1nDhxnSdaHBAUDsbDw
        undtS0/6ABVeXjA6u5C1pow=
X-Google-Smtp-Source: AA+uWPzH5fbbcw1VQ/9W2TdUcanpJH9+S//Up8nwXHOUCNpmwQQiApi1BgcwS2ecU3oX9Y7QsUetAg==
X-Received: by 2002:a1c:4143:: with SMTP id o64-v6mr28551892wma.123.1534802602851;
        Mon, 20 Aug 2018 15:03:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 88-v6sm3124582wrf.95.2018.08.20.15.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 15:03:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule: add config for where gitdirs are located
References: <20180816024733.GB127655@aiede.svl.corp.google.com>
        <20180816181940.46114-1-bmwill@google.com>
Date:   Mon, 20 Aug 2018 15:03:21 -0700
In-Reply-To: <20180816181940.46114-1-bmwill@google.com> (Brandon Williams's
        message of "Thu, 16 Aug 2018 11:19:40 -0700")
Message-ID: <xmqq1sasbsra.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Introduce the config "submodule.<name>.gitdirpath" which is used to
> indicate where a submodule's gitdir is located inside of a repository's
> "modules" directory.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>
> Maybe something like this on top?  Do you think we should disallow
> "../" in this config, even though it is a repository local
> configuration and not shipped in .gitmodules?

Sounds sensible to start strict and loosen later if/when necessary.

If we disallow "../", shouldn't we also reject an absolute path
(meaning, you can only specify a subdirectory of $GIT_DIR/modules/
in the super-project)?
