Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D00A31F404
	for <e@80x24.org>; Fri,  7 Sep 2018 06:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbeIGLT5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 07:19:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39583 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbeIGLT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 07:19:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so6527811pff.6
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 23:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HAyI7vosgXGdg9Lqg696j7u0GQm1Nr3BZTwf8CpI+og=;
        b=FWVo1DbZLmxCtzqrlX6Ecsb/rb/X53t8sOt5DoLxmn+hYI8S7UL5MF3untqoAP+Y7U
         qBJQR0/dUcu0nY6SV0r5x5nrXrUil4prM9SQTJ2uazsA+nV5ID8Tjab8Wf0p2DjEywoH
         LBJtHNhyTMzpQVmb0GEtvpWzTb0PSMfsd7Laq2AJqxftHP42Y5Ug+9GbpfCUCgMGKLe1
         xhaG3HxobA0OT2decncIWgpzgmf8RJcvCf+GEKILk368g8EMdNf218itbm1Khn1mbkbB
         QoU587QC+LKj6n9GdAV5kAgWU+BKUOiMWLktZBHdUyTEotZgucx9zknhbr/svGjYBhJJ
         /SiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HAyI7vosgXGdg9Lqg696j7u0GQm1Nr3BZTwf8CpI+og=;
        b=nj2KMuU5cb8fRW2V82ftU2OWiMSrcBufP8Xt0QstMuijowzatDAcGlEhGocws5qnL4
         cIrZj6OJhF/jRPRi+s//J5DN+qyr+KRRkmNEUWGKijvZD2w11G9+Cg3s2x6hryC1pqpj
         OylmgICJkBVjZWOjkFS/B9pf0+4r26TsF/TLHp6PouiEsWSge+t041oA/lvrE+4N3LuH
         3Pv28CYO+sGP7uYAunW/T7jeZ824veKR41paDKMcB8HGTuWgrXi822pJl8RTdHMKTyGV
         MyS+SoeJsvupuyIeofg8TXbuSrO0MO4l3SNWSy+Rx9EOBzEZjjh9PW7w3WlEy0Z7pnyF
         nuJw==
X-Gm-Message-State: APzg51BjyiFM4XPmKVDRLgnOGkKuoTniBFBB3KCf7d/S2rKdghPejOMU
        0ZRYNxhoVybxblxYBPEZDsA=
X-Google-Smtp-Source: ANB0VdZNFtksfEiw5Ru6KWh3Of5bizLCQ0QDsMRRvgTwpa2AteTlRTs8CI2jQovs7AQoNBpYJna/hg==
X-Received: by 2002:a63:8442:: with SMTP id k63-v6mr6640416pgd.388.1536302429680;
        Thu, 06 Sep 2018 23:40:29 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m20-v6sm19445676pfg.61.2018.09.06.23.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 23:40:28 -0700 (PDT)
Date:   Thu, 6 Sep 2018 23:40:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: allow --recurse-submodules as an synonym for
 --submodule
Message-ID: <20180907064026.GB172953@aiede.svl.corp.google.com>
References: <20180905225828.17782-1-sbeller@google.com>
 <20180905231258.GD120842@aiede.svl.corp.google.com>
 <xmqqefe6z5ws.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefe6z5ws.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> It seems like various commands are gaining --recurse-submodules options
>> taking different kinds of arguments:
>>
>> - clone takes --recurse-submodules=<pathspec>
>> - fetch takes --recurse-submodules=<mode>
>> - after this patch, diff takes --recurse-submodules=<mode>
>>
>> Is there a unifying principle?  Can Documentation/gitsubmodules.txt
>> say a word or two about what kind of argument values the user should
>> expect to be accepted by these options?
>
> I am not sure if the above is rhetorical.  The only thing such a
> document can say about status-quo is that the user cannot make an
> educated guess, as there is no consistency.  Some take an option to
> clarify which subset of submodules to act on, others take an option
> to specify what variant of operation to be made on the submodules.

It's not rhetorical: I really do want to find out what our plan is for
the future of --recurse-submodules.

One possibility (A) would be "accept pathspec everywhere", as you
mentioned.  For a command like fetch that already accepts <mode>, that
is problematic and would involve a migration.  If we already have to
migrate fetch, migrating diff as well does not seem too bad.

Another possibility (B) would be "accept pathspec in clone only".  A
clone is a bit of a special case in that it is setting up the set of
active submodules; perhaps we want other commands to always respect
that set of active submodules without a method for overriding and only
acting on a subset.  After all, "git checkout <branch>" doesn't have a
way to only checkout <branch> on a subset of the worktree; why should
"git checkout --recurse-submodules <branch>" be any different?

When I think about it this way, I suspect that (B) will provide a
better experience than (A), so this diff change doesn't seem like a
step in the wrong direction.  Except: it took me a long time to think
this through.  Some documentation really would help, since it would
mean that the next person can understand what the *intention* behind
these options are and save some time thinking through other not-chosen
alternatives.

Hmm?

Thanks,
Jonathan
