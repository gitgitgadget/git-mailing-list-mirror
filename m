Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C264320C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 20:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbdFLUEQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 16:04:16 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35803 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752509AbdFLUEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 16:04:15 -0400
Received: by mail-pf0-f169.google.com with SMTP id l89so55881073pfi.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 13:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rktkfoyVLRipgqEjkXNzdN9iUqsMO54vleK9ssfjDDk=;
        b=U67OHRbZ0EdB/hwe4zwrSMAyzcxLKX/1+ozT1Txin3TvLUpjFK/ctsF6iufZ8S65k+
         EvuWF17R1KUHWfAPRWoEQsvHoemGmP2OnqlVky9DfMppWFloOO98d1jAs7/MsaMR1Hzb
         C0fKLUBCLZw7nG6aDLZJAG1SYWdy5dvsduCtJkM+Vh5ELqhoSljWTiCsWl3doYETQNHw
         FDTGtdDG+dU2seC/Win7dHYtupyYvJxhEQEADDywKI0s86r2ctxSv21a7bNc4Zs77Teh
         v8YabH0u9YrutLaeow7vFIDamhhy66Fd8ZxYBMj3rtnEMa7h/M6jDK4lcv2vw5vSZfrF
         xkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rktkfoyVLRipgqEjkXNzdN9iUqsMO54vleK9ssfjDDk=;
        b=QsPxxR1tph6vHx3jAijEb/ZUnphqaKNtmqNylHBP6bXxO2gt+0QXuWLT3nr1YxWfdQ
         zWGhjjCBjH2lvnX9z+Iv5TcWO9FhTP65zFBlnNkd8fKe9QtjsxUYIpypVj9h4z4oMtQy
         kj3sEqIF1c+k5bO/nrlSgd4JsWYs/LIvpXEEQm+0iIpLnUhhph+1KeFHbk6YJTpB/P/H
         Q4tXa5iB0SN+cxa9wvtXCNashAuWHqIi5tkaN3KEN3crlwKem1d6D4OVJCERv4Wk0FH3
         mxDnF9pyrruvesucvklZNjanmp3/txLoz8Aedz/YSYJCPJHw0McRjVgq9DanHBLDc3tM
         e6Bw==
X-Gm-Message-State: AODbwcDmg/sL7lHoT+hLVwPDq9TVHqhhOwDl/1xWJWSfuUkjJwGxVMpT
        rI0lhkE88LSAvnWTqq/O53Rn
X-Received: by 10.99.52.1 with SMTP id b1mr58018271pga.91.1497297854341;
        Mon, 12 Jun 2017 13:04:14 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a1c6:b49e:dc41:58c])
        by smtp.gmail.com with ESMTPSA id g23sm20667865pfj.131.2017.06.12.13.04.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 13:04:14 -0700 (PDT)
Date:   Mon, 12 Jun 2017 13:04:09 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, sbeller@google.com,
        jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/32] repository object
Message-ID: <20170612130409.07725a75@twelve2.svl.corp.google.com>
In-Reply-To: <20170612191121.GB154599@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
        <20170608234100.188529-1-bmwill@google.com>
        <20170609174034.61889ae8@twelve2.svl.corp.google.com>
        <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
        <20170612120140.3da90194@twelve2.svl.corp.google.com>
        <20170612191121.GB154599@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 12 Jun 2017 12:11:21 -0700
Brandon Williams <bmwill@google.com> wrote:

> On 06/12, Jonathan Tan wrote:
> > On Sat, 10 Jun 2017 02:07:12 -0400
> > Jeff King <peff@peff.net> wrote:
> > 
> > > I do agree that "pass just what the sub-function needs" is a good rule
> > > of thumb. But the reason that these are globals in the first place is
> > > that there are a ton of them, and they are used at the lowest levels of
> > > call chains. So I have a feeling that we're always going to need some
> > > big object to hold all that context when doing multi-repo operations in
> > > a single process.
> > 
> > From my experience with the codebase, it seems that most of these config
> > variables are static (file-local). This means that the lowest levels of
> > call chains could probably get away with storing per-repo configs in a
> > static hashmap or associative array keyed by repo (if they cannot just
> > pass the config around).
> > 
> > Having said that, if it did come to the hashmap, I probably would prefer
> > just putting the config in the repo object too. So maybe that is the way
> > to go.
> 
> This is how the config is already handled.  A config_set is just a
> wrapper around a fancy hashmap.  Callers query using a string as a key
> and are returned the value for that config option.  I say fancy because
> it does stuff to handle multiple values, etc.

The hashmap I meant is one wrapping the one you describe:

  repo -> configset

Or equivalently:

  repo -> (string -> value(s))

> I'm not sure I know what you mean by config variables which are static,
> are you referring to the in-memory options which are populated by
> querying the config?  Those I wouldn't want to see placed in a
> 'repository object'.

Yes. I agree that I wouldn't want to see them placed in a repository
object, but after reading Peff's e-mail, I was thinking of what happens
if a file repeatedly invokes a config-sensitive function in another
file. For example:

 a.c
  for (i = 0; i < 100; i++) b_output(repo, x);

 b.c
  void b_output(struct repository *repo, int x)
  {
   /* print the configured "b.prefix" followed by x */
  }

We probably wouldn't want to parse the repo's configset every time
b_output() is invoked, but then, where to store our parsed "b.prefix"?
The only alternatives I see is to have a static hashmap in b.c (keyed by
repo, as described above), which would work if such a situation is rare
(or can be made rare), but if it is common, maybe we have no choice but
to put it in struct repository.
