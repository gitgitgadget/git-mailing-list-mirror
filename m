Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA78D20248
	for <e@80x24.org>; Mon,  4 Mar 2019 14:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfCDOgi (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 09:36:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41147 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfCDOgi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 09:36:38 -0500
Received: by mail-wr1-f66.google.com with SMTP id n2so5796647wrw.8
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 06:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3SWXl/Rvuk6VTq+0IiMwVliNHx+ktzWGRgsrVpjoW8E=;
        b=Q3Tk7XkZk0V2ejC2LlTF2DPN9IWcAZgDVR2gPhaqS9pqGWL/OnrWkTH6tTq8FkL1Cd
         ZBrXdN5VoDP3Jz5SGBFHleRvLrijzeH+hrRCBkPeoQL2EFCmkGPr3JXSk927/Kx5Y5vR
         CvtkDAP1pFd/SxIZfFxLKyHpmELjBLpAKESuWbD8BquQYuGulDAjkVZAEHijGZtFq9v5
         KDGzIVK+4UD7P3vy66ogInTVd6XIF+SwGWKy4Bh7RIs6HxJtVqc6zJ0h8tnDcj3ovGtq
         907xiEuM1+l3of8h/s3OgIs3kk+LLamQzUbOnXlULe2lr6LTIvdLx1Ecq5xoz17KQ1pP
         HP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3SWXl/Rvuk6VTq+0IiMwVliNHx+ktzWGRgsrVpjoW8E=;
        b=GRD72+q2z+7D5T7LvVildvSbrDw/bx1XKzbjWRULW2Yugl0QwNhRCu+BD3KCvZr+Hi
         JJss3AtQ2xkcThl2ZnIK+/rh6uYyTU8qG19F55w7q/BpkNWM7DRCa5keHzMiq7kSJkHO
         32aQPPqhTRbSUYAH99NeiMWjm54W0WI2JEnOHbUKUtrj9Lcobd92Y51eMjInBErZ1/Cn
         CbtCeP51hoKHp0kPKO98pTDMWD871wYfOeKBDKNgi51mZx6j3k9m19Mcmnvgh650nrL8
         wZQALNQN+3028fSjx6elmEodS8Qo43saOTO2u8WN3pfMAlvPDwtbOxeaAsZA5uMV/Ya7
         tGvg==
X-Gm-Message-State: APjAAAXX4LJ3S6IHVqGohMVFd7zt3UKLbDrNBLpdxS+H+z4790RpJD5v
        go1ergIBEEGmYkofCTFFzVI=
X-Google-Smtp-Source: APXvYqwK0qSyz28B7BzxM4P5W/+Op6+VIDlfgEEvwLMAgr0uKzirKamQ86pUNImQpgaMttDry4N83Q==
X-Received: by 2002:adf:ce91:: with SMTP id r17mr12316052wrn.80.1551710196494;
        Mon, 04 Mar 2019 06:36:36 -0800 (PST)
Received: from szeder.dev (x4db46a68.dyn.telefonica.de. [77.180.106.104])
        by smtp.gmail.com with ESMTPSA id x74sm6810211wmf.22.2019.03.04.06.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 06:36:35 -0800 (PST)
Date:   Mon, 4 Mar 2019 15:36:33 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
Message-ID: <20190304143633.GC28939@szeder.dev>
References: <pull.152.git.gitgitgadget@gmail.com>
 <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
 <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
 <87sgwav8cp.fsf@evledraar.gmail.com>
 <20190226170400.GC19739@szeder.dev>
 <20190226174316.GD19606@sigill.intra.peff.net>
 <20190226193912.GD19739@szeder.dev>
 <20190226210101.GA27914@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226210101.GA27914@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 26, 2019 at 04:01:01PM -0500, Jeff King wrote:
> > +	{ set +x ; } 2>/dev/null 4>/dev/null
> 
> Ah, this is the magic. Doing:
> 
>   set +x 2>/dev/null
> 
> will still show it, but doing the redirection in a wrapping block means
> that it is applied before the command inside the block is run. Clever.

Yeah, clever, but unfortunately (and to me suprisingly) unportable:

  $ ksh
  $ set -x
  $ echo foo
  + echo foo
  foo
  $ set +x
  $ 

It doesn't show 'set +x', how convenient! :)
However:

  $ set -x
  $ echo foo 2>/dev/null
  + echo foo
  + 2> /dev/null
  foo
  $ { set +x; } 2>/dev/null
  + 2> /dev/null
  $ 

Apparently ksh, ksh93 and mksh show not only the executed commands
but any redirections as well.  It's already visible when running our
tests with ksh and '-x':

  $ ksh ./t9999-test.sh -x
  Initialized empty Git repository in /home/szeder/src/git/t/trash directory.t9999-test/.git/
  expecting success: 
          true
  
  + true
  + 2> /dev/null ok 1 - first
  
  # passed all 1 test(s)
  1..1

NetBSD's sh:

  # set -x
  # echo foo
  + echo foo
  foo
  # echo foo 2>/dev/null
  + echo foo 2>/dev/null
  foo
  # { set +x; } 2>/dev/null
  + using redirections: 2>/dev/null do


