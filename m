Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF8741F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 17:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfHLRqi (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 13:46:38 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:36144 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLRqi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 13:46:38 -0400
Received: by mail-pl1-f179.google.com with SMTP id g4so1675591plo.3
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 10:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DSvySmkbHthSR1K8NbELU0eyO/eguO4q1reLxwhIO34=;
        b=VSwG4ctuwZ3kJ3ITq0+Z+/mEBWcN4hG1PDhgylFQ8agNiGCv/vnG7RPfAHNAk3v9Hu
         +aD8IaBPlLT2AsAgtpGm+9FKMheUcvkyv1VL2HwW2SDmZUo3uEnIy5/Hgcaf2uQb1qg9
         L5QnVVn7wM6lueaACJo/ZCFGWyeQwPOH6hQvJBrloCJoXfHgGeQ4L7KsjBPyttjC5gTu
         5P52ocvlppb5jMAbO/oMb2Mux54jbWGXhEEzLPVxNkeVKILOmuMcpdZVvAKZcV93MPwc
         Dm1bTaW4lqNTr9StzSvPN4+yisUqVJnSxQyJGn6+xi8zSD8tDQBYilwjD1GAVKY3uGS6
         6JCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DSvySmkbHthSR1K8NbELU0eyO/eguO4q1reLxwhIO34=;
        b=VZLJ1Zv6ylrgHleveJXDVo1UPrhN/Laof5gR/jLUZSIhQoZxFn/YOXkOFHuEyKyvTT
         jhNIsjPz8uZLqQLBy4QKmZJaP7M4U5TCPlxJ0NVWSTD6bKGhASBE8YQuhuDDj3Xteg00
         FVKI1poUz4EnXJ4BPeNPPe333v/ZqzJ0/5CXPrBksza6Jws/5a4IEqR0uPntZJy42xS/
         kkICnwCF978VnI3lqMqquqWQQu1po48t7gY4QVaEzxVwgJPg2m0D0qhvhLbnA1+N3rqY
         rgEWwvLoFuROWki7JhJ5Y/+prGjep75rcpuCsAiJ1R2z+hZt+0qCiG1pDC8VDsyLxpuH
         c3WA==
X-Gm-Message-State: APjAAAW6fID409OA5KEnnYLRVHh64Lk+WeNaYktNIJXGW5tkbY/fBtjy
        /I2x9TNtRRXoAGYVHtvkXyM=
X-Google-Smtp-Source: APXvYqzo6qGdApN5ae10nnlVIIksgPMc/z90J67fD5iWxJiz1EdeMPlFzgpU3864ziLiMoP5JyHo2w==
X-Received: by 2002:a17:902:a409:: with SMTP id p9mr34267382plq.218.1565631997069;
        Mon, 12 Aug 2019 10:46:37 -0700 (PDT)
Received: from ar135.iitr.ac.in ([103.37.200.227])
        by smtp.gmail.com with ESMTPSA id n128sm62225581pfn.46.2019.08.12.10.46.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 10:46:36 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        rohit.ashiwal265@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCHl 1/6] rebase -i: add --ignore-whitespace flag
Date:   Mon, 12 Aug 2019 23:13:29 +0530
Message-Id: <20190812174329.13995-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <bdd867f3-62d6-eec2-9562-5dbe203f49b5@gmail.com>
References: <bdd867f3-62d6-eec2-9562-5dbe203f49b5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip

On Thu, 8 Aug 2019 17:44:38 +0100 Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
> [...]
> >   --ignore-whitespace::
> > +	This flag is either passed to the 'git apply' program
> > +	(see linkgit:git-apply[1]), or to 'git merge' program
> > +	(see linkgit:git-merge[1]) as `-Xignore-space-change`,
> > +	depending on which backend is selected by other options.
> 
> I think it would be better to document the effect of this option rather
> than the implementation detail. It is confusing at the moment as it
> talks about 'git merge' but we don't allow this option with merges.

Oh, it is just to indicate the user where to look for the definitions
as currently the behaviour of both the backends is not exactly the
same neither do they work optimally. Hope in future when they are in
harmony, then we can happily change it to match the then behaviour.

> [...]

Thanks
Rohit

