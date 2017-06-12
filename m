Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC0301F8CF
	for <e@80x24.org>; Mon, 12 Jun 2017 18:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbdFLSEB (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 14:04:01 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35999 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdFLSEA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 14:04:00 -0400
Received: by mail-pg0-f44.google.com with SMTP id a70so48131682pge.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mLFyJq0X1+l41mqJ4CRbQlYyHpVVUsS8Bp+S+g1Qlks=;
        b=IlXpQB4uWkcDczXsIU0eGUxINOv2coh2Q/3FiEQ0H+vEt/u6hHnNeN6YQmasoedXT+
         u1yiw1tzb81ojOlk5Y/Qz6zvSth/yCWdtgmR1AmZYYNClk7XAYZlUonokxB22MpDpBXU
         Cu7fWjaZlwa52I7pL3AVYZxhZfxUuTgu17Tc7c0q/IyUoqO/792cXZek/tq58080TIGA
         X6Ou/BgOEG3VK3PhsTk0UpipvqRD1+PKYo/MSi/EAhMnWNHT+KymwZqkoisAeFOSdbL1
         uzyHP8d9ZNv0Gq7+u0WaWTAy3jACc2bP6wxyhIDBtKfRO5eUEtFqvdSEqs6OPyHJ/5q3
         XTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mLFyJq0X1+l41mqJ4CRbQlYyHpVVUsS8Bp+S+g1Qlks=;
        b=JLsubDQ9AuhXRxUiJpaVJHjy02+UQJXGcYHYikDXqM80itiMQ9Vy0VjjMdlqX4a3wE
         7yNK7xFul8jet2mysqi2GRMnhrvHH1nuKt75yCccREWBSg14B1y7+paEzu8/xH4oVsi9
         89Hk0OnIujqeznVwvMhGaqBZwE8aq3zJY/sQreN9765PJNlYy/fXpsVQwRHcx2im8QRN
         gJy+HGlo01PufvWHZtb2aDJeCp0ncpTLK2jtsbvC3B2ERh7++d5hujqGn/qIYq8RUc12
         4JFRak2jf7kOoV9EqusKR52O0+4hHRN/VaLbA4XpELztQTX5OEU5AG4IMHWo8+8qHeMC
         O6hA==
X-Gm-Message-State: AODbwcAggnHTCkZZLaLtqorWTi+uZCaM8oXg2ibv7X9LjND8WeG7+exE
        O+X5Cf4f3fSGYgeoqo4Gwg==
X-Received: by 10.99.1.88 with SMTP id 85mr60023709pgb.110.1497290639711;
        Mon, 12 Jun 2017 11:03:59 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9d75:7c5f:d212:fb28])
        by smtp.gmail.com with ESMTPSA id 18sm19228853pfo.92.2017.06.12.11.03.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 11:03:58 -0700 (PDT)
Date:   Mon, 12 Jun 2017 11:03:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Kevin Daudt <me@ikke.info>, Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>
Subject: Re: 'pu' broken at t5304 tonight
Message-ID: <20170612180357.GA154599@google.com>
References: <xmqq4lvo2x6i.fsf@gitster.mtv.corp.google.com>
 <20170610124836.GD27719@alpha.vpn.ikke.info>
 <20170610190510.GE27719@alpha.vpn.ikke.info>
 <CAP8UFD0nDaBCiWiho7zJtUZ3MpgPY97NQ0AXnGq7parQBi=sMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD0nDaBCiWiho7zJtUZ3MpgPY97NQ0AXnGq7parQBi=sMw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/11, Christian Couder wrote:
> On Sat, Jun 10, 2017 at 9:05 PM, Kevin Daudt <me@ikke.info> wrote:
> > On Sat, Jun 10, 2017 at 02:48:36PM +0200, Kevin Daudt wrote:
> 
> >> For me, this bisects to the latest merge:
> >>
> >> 2047eebd3 (Merge branch 'bw/repo-object' into pu, 2017-06-10), but
> >> neither of the parent of the merge break this test, so it looks like
> >> it's because of an interaction between the repo-object topic and another
> >> topic.
> >
> > Merging the repo-object with different other topic branches reveals this
> > topic to cause the bad interaction:
> >
> > b56c91004 (Merge branch 'nd/prune-in-worktree' into pu, 2017-06-10)
> >
> > Still investigating why it happens.
> 
> Yeah, 9570b25a97 (revision.c: --indexed-objects add objects from all
> worktrees, 2017-04-19) adds the following test to t5304-prune.sh but
> this fails if nd/prune-in-worktree is rebased on top of
> bw/repo-object:
> 
> test_expect_success 'prune: handle index in multiple worktrees' '
>        git worktree add second-worktree &&
>        echo "new blob for second-worktree" >second-worktree/blob &&
>        git -C second-worktree add blob &&
>        git prune --expire=now &&
>        git -C second-worktree show :blob >actual &&
>        test_cmp second-worktree/blob actual
> '

I think I discovered what is going on here (and its mostly my fault :D).

(e7a6a3b15 revision.c: --indexed-objects add objects from all worktrees)
queries each worktree's index to add object which are pending in the
per-worktree index's.  To do this is uses 'worktree_git_path' in order
to construct a path to the worktree's index file.  My series introduced
a change to how 'adjust_git_path' functioned, instead of checking if the
index file came from the environment before replacing with the result of
'get_index_file()', i change it to unconditionally do this replacing
which breaks the ability to get a path to a worktree's index.

So this breakage is definitely my fault, but you would still run into
this exact same issue if you had set 'GIT_INDEX_FILE' as no worktree's
would be able to find their index files as they would be overridden by
the envvar.

-- 
Brandon Williams
