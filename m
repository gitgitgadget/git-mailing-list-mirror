Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C841FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 22:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdBMWP6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 17:15:58 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36444 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbdBMWP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 17:15:57 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so566746wmd.3
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 14:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AAcMDanDdbGAV0ChVKXAYYeUXceF/0g3DoEmo/md+zQ=;
        b=fy8d9u78lzRQMPyehp7qfAL1tmwfiA2kZs2/ruehEYLZM5jcvoi+fhQ3HaIK9BM1xv
         D75JAtF6xu4oMXIdymAvmO0r77ErPFG9ESoLC45/b1Vxm1VPbjlsRlTu3Cfim0W41hhp
         ts1Ky5lTdd74ilvFWVawNo6Qs4MGTbqsiPpqsDZ+JnVWTVlZm5C+/jPN9PUJdz38EyIH
         5JYuB2Ni16NSATWsD1HYSrZxhmrxy21+mA91XgQIScwbiB3rZjQieJh1K+ZFwSpAg4h9
         kZZF7ya9Aro5mZzrDJLNdfn9+DB9vdmHG970BjHBkUcLLO3d6/bIYSB2Fdiy+yy/l/DV
         hvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AAcMDanDdbGAV0ChVKXAYYeUXceF/0g3DoEmo/md+zQ=;
        b=j5mMPUOFPZSb4g6umtEX82Yf+IOLQFINkg/tNzTxJP1InCEbNfYyli/kRqEyl6Nc7p
         6FBpWuYIT/n6GPuMhGp0wzXmTj80+Uo5RuMbuZUF6pEjmgHMmG33bvTcobff4DtJrCR/
         fFfPwR6KDz8emu97CtZ/ViHHzsr70YY0bK2yeVtMPC7hdYKs0LCxEFQq9At2uba+scbS
         pIyVdLDQI8vq1tCQ4U6qplr9GHDNUSQV9x1a6bhe/Shh0zez9Wksbg+krQL0BvEuuiTT
         1BH4K3FmosOxP+mpt6Ck8AUk+AiqQKQ2E2qqOJizDHAJ1cMCUKXV4Au9FmT+rZrySPv/
         53vg==
X-Gm-Message-State: AMke39lIFK7R1vj2FiYeka8uId4ldwMOZHL8ca5/5nyaxFnZnrqgTC7wFRPvNUTCWMXa/A==
X-Received: by 10.28.126.11 with SMTP id z11mr426527wmc.13.1487024156362;
        Mon, 13 Feb 2017 14:15:56 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id g71sm6984804wmc.9.2017.02.13.14.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Feb 2017 14:15:55 -0800 (PST)
Date:   Mon, 13 Feb 2017 22:16:30 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=D8yvind_A_=2E?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 2/5] stash: introduce push verb
Message-ID: <20170213221630.GC652@hank>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-3-t.gummerer@gmail.com>
 <vpqlgtaz09q.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vpqlgtaz09q.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/13, Matthieu Moy wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Introduce a new git stash push verb in addition to git stash save.  The
> > push verb is used to transition from the current command line arguments
> > to a more conventional way, in which the message is given as an argument
> > to the -m option.
> 
> Sorry if this has been discussed before, but I find 'push' rather
> confusing here. It took me a while to understand that it meant "opposite
> of pop", because in the context of Git, "push" usually means "send to
> remote repository".

There wasn't much of a discussion about it, but it was pretty much the
only thing that came to my mind, and nobody complained or suggested
anything different, so I just went with it.  No other verb came to my
mind yet, but if someone has a better suggestion, I'd be happy to
change.

> Unfortunately, I didn't come up with a better name. "create" is already
> taken ...
> 
> Another think to have in mind: changing the option name to break
> backward compatibility is something we can't do often, so if there's
> anything else we should change about the UI, we should do it now. I
> don't have anything particular in mind, just thinking aloud.

Now that you mention this, there actually is one inconsistency that I
introduced, which I shouldn't have.  git stash push works with
--include-untracked and --all to decide whether or not to include
untracked files, and if also ignored files should be included.  I also
added a --include-untracked {untracked,all} argument to git stash
create, which is clearly inconsistent.

There really should only be one way.  I'd be fine with either way, but
I think using --include-untracked and --all is the better choice,
because it's easy to understand, and also makes it easier to switch
git stash without a verb over to use push_stash internally.

> -- 
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/
