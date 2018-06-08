Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED0381F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeFHWYd (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:24:33 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36882 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbeFHWYc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:24:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id d8-v6so14762510wro.4
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oYI15CHl/QwfS1RuhBrnVvwyyiluEAI1Q/1q7g4nWzc=;
        b=lqZQWZWeQMdMCTpT4zGdKYaQKRv59pNVvts7LXpdzY51PXFDe7JIcBg6xJDmjLt/KC
         /h5LNf+3A77y7qZeihYheCdE657RHUdWDGB/N2MVVtFR7rNjgNoL0ZKJe5EYdTHN5InI
         c9WVnxOkTB4RuVCWHDsHzARFhNdrzvc0vbO9lxcCR2vhhNnziOZSfaBcVLmJUwxuDAaz
         eb76v85KHm3Y/+5Rnl6q2Rjx7ZRM7WhvK38jyfb1saJSFy3Fd569wL0boDhiiG9H3Ioz
         FI8SvWmdf3GoKFw7Bg2trRmnbShAUSUL9J/mWA+bVvGwQR56biZsGYlVhOz5TKNFUNoL
         bcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oYI15CHl/QwfS1RuhBrnVvwyyiluEAI1Q/1q7g4nWzc=;
        b=qF2RfywH9T1WK5YZs0elcV9qZ2KhBny4Utwh3M3qNti+AKqlZgoTe7AoVqgRUgCGS7
         UL4Puk2gXAFDNRB/FkNETYFnzwaZgMszNFpoHQCS5ZRu/k+S3evyqsJzVbxb5cjxZsh8
         NYV57/GNYqFXKtqyv2gh2ktIXXPEZWvUFI8AoCXmdHbdPW1g1SOjrARpdrrZLC1lHsmv
         GUwBkj/SM5hmq0hcKPBRrPRSIBacqFQoXXHH3+tn2GKSTR8Pd4J79rf1P6OAyuoZqzUV
         ccSXTEO6lgWX85MrYp79sU87/byMmnn1SSpgD+VRMTH70Zv/7vX5+60w/iK5seklDfZK
         j4tg==
X-Gm-Message-State: APt69E0iFyxS0x7Ti7H1qSYSen3HAFhaxRTXobOs8XuZ1wvj+KO9nWLZ
        Md1/h0N31X0WJRuHAD7yNw8=
X-Google-Smtp-Source: ADUXVKL4Y2+DCTlLepCN44fRvGs/pq+kANpRMWkDYsJV8D6jBbueo8aEymEjH8gNUsIO89F+6/Ds5A==
X-Received: by 2002:adf:9a4c:: with SMTP id z70-v6mr6645820wrb.118.1528496671614;
        Fri, 08 Jun 2018 15:24:31 -0700 (PDT)
Received: from localhost.localdomain (x590e2083.dyn.telefonica.de. [89.14.32.131])
        by smtp.gmail.com with ESMTPSA id 12-v6sm4207486wmt.19.2018.06.08.15.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 15:24:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: Re: [PATCH v6 20/21] gc: automatically write commit-graph files
Date:   Sat,  9 Jun 2018 00:24:14 +0200
Message-Id: <20180608222414.11306-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.207.ga6211da864
In-Reply-To: <20180608135548.216405-21-dstolee@microsoft.com>
References: <20180606113611.87822-1-dstolee@microsoft.com> <20180608135548.216405-1-dstolee@microsoft.com> <20180608135548.216405-21-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> The commit-graph file is a very helpful feature for speeding up git
> operations. In order to make it more useful, make it possible to
> write the commit-graph file during standard garbage collection
> operations.
> 
> Add a 'gc.commitGraph' config setting that triggers writing a
> commit-graph file after any non-trivial 'git gc' command. Defaults to
> false while the commit-graph feature matures. We specifically do not
> want to have this on by default until the commit-graph feature is fully
> integrated with history-modifying features like shallow clones.

So I played around with an earlier version of this patch series a
while ago... and as I looked into my gitconfig today I was surprised
to have both 'core.commitGraph' and 'gc.commitGraph' config variables
set.  When I looked into it I came across this email from Ævar:

  https://public-inbox.org/git/87fu3peni2.fsf@evledraar.gmail.com/

  > Other than the question if 'gc.commitGraph' and 'core.commitGraph'
  > should be independent config variables, and the exact wording of the
  > git-gc docs, it looks good to me.

  Sans doc errors you pointed out in other places (you need to set
  core.commitGraph so it's read at all), I think it's very useful to have
  these split up. It's simliar to pack.useBitmaps & pack.writeBitmaps.

I think the comparison with pack bitmaps makes a lot of sense and I
have to say that I really like those 'useBitmaps' and 'writeBitmaps'
variable names, because it's clear right away which one is which,
without consulting the documentation.  I think having 'useCommitGraph'
and 'writeCommitGraph' variables would be a lot better than the same
variable name in two different sections, and I'm sure that then I
wouldn't have been caught off guard.

Yeah, I know, my timing sucks, with 'core.commitGraph' already out
there in the -rc releases...  sorry.

