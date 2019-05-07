Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 680451F45F
	for <e@80x24.org>; Tue,  7 May 2019 18:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfEGSbM (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 14:31:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36546 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfEGSbM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 14:31:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id 85so8730552pgc.3
        for <git@vger.kernel.org>; Tue, 07 May 2019 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xROSNGJ8EsjB1WBveEIbc0Ocr/kuAET6UvV8XZLi6BY=;
        b=Fuo09T7rfIGbWIBypK1P/LGiW3KKTz5pSAl9l1p0efLk2sKftTgP7gRAbCvoJPch62
         NguMs4FMJRwu3ED9nqjPft5VFOssQm1BpetZ0YwSnbSK/crjtVq3G0vCpm26bsPCIp+A
         kkYZZnA/RBPbDWlJ/T3xeKe/Ew+F5mlMhftUZRTmT+1jKsJKmqEbSX1yyDsQTUjpSd6T
         IA35IC/ht05EOWOTvlYoLQRxwtkJ1UsZOVFysTNM+uWfRQTx2235N+dRoe+gbVlBqeP7
         bifohWkpKo211TAB4MfmXU4lCu1lmK+eBG2y3XnGD3nGPK2lW8FSH5fNeQSJ5GNN3Vj3
         jKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xROSNGJ8EsjB1WBveEIbc0Ocr/kuAET6UvV8XZLi6BY=;
        b=NFYoMhPtIHsMfwEpuTzl0SOoX3hAkz8DtwRONuFiP0PU1eFt/T0LUPrPsWj/IF9eRk
         NLCAQailTCusDhLydv0q2YdZR7+tQa3xPjwvDvKY+ZEF0IQr6THa0iYJr9H11hzPRd2L
         ljdnolv0vsVKNN2UtXrPEr+k3Gg77YitAiE74i/9yzM+Vo8ms+/N4LOqDVsjTkBFs7Wb
         ONnuMWlunyzcvuZ7KlKG5PqwUdAKXl9T4k636nja30m9OPGD17b0zXmm0vwauDyObU3b
         AbggyjDSOzZfY2m31VaUKuqeGPwZ+hIEvQIj+Wt2/PEK4U0yvqoRuq9xuNQVwG5rEGf/
         TuFg==
X-Gm-Message-State: APjAAAU/JXJzzutE+GQzpdtXENv2fh4guVF0PPcppIDNDbyxYqAbXe4O
        MgeR8MUhDJZYMTwW6hhgbiE1UQ==
X-Google-Smtp-Source: APXvYqxMEhigghIzberZcoLNn69ExGuNmafIdMY6jOORZPdvZFzFCxQqD+KgHQe77xw2wGvXIuNMWQ==
X-Received: by 2002:a62:3501:: with SMTP id c1mr43720944pfa.184.1557253870530;
        Tue, 07 May 2019 11:31:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id r8sm18280097pfn.11.2019.05.07.11.31.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 11:31:09 -0700 (PDT)
Date:   Tue, 7 May 2019 11:31:04 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/16] Add new command 'restore'
Message-ID: <20190507183104.GB220818@google.com>
References: <20190411131218.19195-1-pclouds@gmail.com>
 <20190425094600.15673-1-pclouds@gmail.com>
 <20190507022127.GA220818@google.com>
 <CACsJy8DSVJuwNWfEcA1pv1vdoCn=EKTmhBncRtKLZedQiEj0AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DSVJuwNWfEcA1pv1vdoCn=EKTmhBncRtKLZedQiEj0AA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 05:36:56PM +0700, Duy Nguyen wrote:
> On Tue, May 7, 2019 at 9:21 AM Emily Shaffer <emilyshaffer@google.com> wrote:
> > I've got a usability comment, as we're giving restore a try within
> > Google for now.
> 
> Thanks. I thought I was the only guinea pig :D and obviously not a
> good one since I know too much (which is not a good thing as a
> tester).
> 
> > I found myself in a situation where I had accidentally
> > staged all my changes to tracked files (I think resulting from a stash
> > pop which generated a merge conflict?) and didn't see a good way to
> > unstage everything using restore.
> >
> > I tried out `git restore --staged *` and it tried to restore every build
> > artifact in my working tree, all of which should be ignored, made a lot of
> > noisy errors, and left me with my changes still staged.
> 
> For the record, "git restore --staged :/" should do the trick and it
> is documented as an example (but without --staged).

Yeah, this worked, and today I also noted `git restore --staged .`
works, as does Junio's suggestion on the other mail (`git restore
--staged revision.\*`), and quoting the * (`git restore --staged '*'`).
So maybe I didn't think outside the box enough before mailing :)

> 
> Either way. I think you raise a good point about "*" (or patterns
> matching more than expected in general). I need to sleep on it and see
> if the old way of handling pattern matching failure is still a good
> way to go.

I think it's worth considering, especially as `git reset HEAD *` and
`git reset HEAD` both work. (`git restore --staged` complains that it
hasn't got any paths, but reset seems to figure you just mean
everything.) It was a surprising failure to me coming away from years of
using reset.

> 
> > Finally explicitly naming each file which I needed to restore worked,
> > but I have very little interest in doing this for more than a handful of
> > files, especially since the output of `git status` is not easy to paste
> > into the command line (due to the "modified:" etc marker).
> 
> For just a couple files, you could also use "-p" to go through them
> and either "a" to restore all or "d" to skip the file. Maybe adding
> "-i/--interactive" to git-restore too, just like "git add". Hmm...
> -- 
> Duyh

Anyways, maybe it's not a particularly weighty complaint, since there
are still ways to mass unstage, and if I had just RTFM I would have
found them. :) It's a new workflow, after all, and the old one still
works, so it's probably not reasonable to expect it all to just work the
same way with s/reset HEAD/restore --staged/.

Thanks!
 - Emily
