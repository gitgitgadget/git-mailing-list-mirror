Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E11E1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 16:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeIIVo4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 17:44:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52104 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbeIIVoz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 17:44:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so19124505wma.1
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 09:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VWGGH0wI+Qc+qc+5NE06fep+RlKwavCBpIzO9EAS23E=;
        b=hTjAJqsBkL5VOxZVpv3D5DNglF4bXKKufWFXIKItedlD5yamJb+O5jWaC/ljGyLsOE
         Yq2BIRgLh/9Z7vCVU+87VOjmYniIYgMU+br4tujfiZkee6vpD5Dp4eJaXmWHjX5J9lrw
         mF0RLSjxmM1RPBsysXWPVlvT9EixhXniyrAf02QCiWRauvE1Gd5s+AToqkslAwOD+ikD
         caZLSverU05+9/RToIaOMCxrdE9ffk7nnS/p5N3lujdwXLFIneoxEmjTRKnGu+sIKjck
         BHiqrqPb+HqiepPW9WgEEaN5LII0EI7POGvK3w2TnkBgPRUzUpr/N/5Q6pGngK0iw35H
         ayQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VWGGH0wI+Qc+qc+5NE06fep+RlKwavCBpIzO9EAS23E=;
        b=gQSnGP5YhyEWb+9QXhtJvZ23D2dM6Z0BJ5JSDvs6lnTg+KiLmmIL6Mcu6gS7VKWRwV
         PtmnWmgzgu0+GJ83n+C0dyuRXzoktkSOA3cWzbShriws+fjJ11s67OOP+HVg4k4kZ9Ge
         mIiMhCId5gIarIDMhiJdb/5SzkrERH3RoTLW3uUtn6cYGSuuOAboW6Jv4rAlHRA4Nwfx
         Nxn+6u4lXfiE3a1il77Lc9f/ViAzOkZvkj96Od7l4CK204KnX8RPl2d0timrihRBU0mg
         ZNDiT2s4/3IGZBu0wBxlzbp8hi3IH2QsWdaZjBMTwHlQQeDl6gF+e10PGjVFsqn+kZT+
         hjwA==
X-Gm-Message-State: APzg51CwqoSwmlwOkUSUE5OLUiUsQ38HSe6jCfNo7wwNqB3Tmz07plVl
        1upB8e5l0SSVPytTiZvTELE=
X-Google-Smtp-Source: ANB0VdagnO1pdPVZbOQlGHNx00bIX66h0fK2nC5qJoO21a1KAR+5HMNUI8vP/CNPTmxOw/BkcXDLNg==
X-Received: by 2002:a1c:888e:: with SMTP id k136-v6mr11276427wmd.6.1536512078455;
        Sun, 09 Sep 2018 09:54:38 -0700 (PDT)
Received: from localhost (x590c879a.dyn.telefonica.de. [89.12.135.154])
        by smtp.gmail.com with ESMTPSA id j66-v6sm18246195wrj.28.2018.09.09.09.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 09:54:37 -0700 (PDT)
Date:   Sun, 9 Sep 2018 18:54:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 17/21] range-diff: populate the man page
Message-ID: <20180909165431.GA17224@localhost>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
 <pull.1.v6.git.gitgitgadget@gmail.com>
 <8c5543a0667fffe0cb0684427f726fdfb75b28d0.1534159977.git.gitgitgadget@gmail.com>
 <87lg8a7wj2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lg8a7wj2.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 09, 2018 at 01:14:25PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Aug 13 2018, Johannes Schindelin via GitGitGadget wrote:
> 
> I realize this topic has long since landed, just seemed like a good
> thing to reply to to ask this question:
> 
> > [...]
> > +	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
> > [...]
> > +<range1> <range2>::
> > +	Compare the commits specified by the two ranges, where
> > +	`<range1>` is considered an older version of `<range2>`.
> > +
> > +<rev1>...<rev2>::
> > +	Equivalent to passing `<rev2>..<rev1>` and `<rev1>..<rev2>`.
> > +
> > +<base> <rev1> <rev2>::
> > +	Equivalent to passing `<base>..<rev1>` and `<base>..<rev2>`.
> > +	Note that `<base>` does not need to be the exact branch point
> > +	of the branches. Example: after rebasing a branch `my-topic`,
> > +	`git range-diff my-topic@{u} my-topic@{1} my-topic` would
> > +	show the differences introduced by the rebase.
> 
> I find myself using range-diff often by watching forced pushes to public
> repos to see what others are doing, e.g. just now:
> 
>      + 38b5f0fe72...718fbdedbc split-index-racy       -> szeder/split-index-racy  (forced update)

Heh, spying on my wip bugfixes :)

> And then I turn that into:
> 
>     # @{u} because I happen to be on 'master' and it's shorter to type
>     # than origin/master...
>     git range-diff @{u} 38b5f0fe72...718fbdedbc

I don't understand what you want with that @{u} or 'origin/master' in
the first place.  It's unnecessary, the three-dot notation on its own
works just fine.


> Only to get an error because it doesn't support that, but just:
> 
>     git range-diff @{u} 38b5f0fe72 718fbdedbc
> 
> I think it would be convenient given that "fetch" produces this output
> to support this sort of invocation as synonymous with the three-arg
> form. Then you can directly copy/paste that from terminals that have a
> convenient feature to highlight a continuous \S+ reason to copy/paste
> it.
> 
> I can patch it in, but maybe there's UI reasons not to do this that I'm
> missing, e.g. confusion with the existing <rev1>...<rev2> syntax. What
> do you think?
