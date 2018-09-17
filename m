Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9D111F404
	for <e@80x24.org>; Mon, 17 Sep 2018 19:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIRBLC (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 21:11:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38921 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRBLC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 21:11:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so7894670plp.6
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NQ4fI7F+8v6Tt8fGO2S2mFMEeAia35LytNxoNBIvxUo=;
        b=M3LV0Z1Kpx6ERI9XtAcJISbdzbklC1gMWJ7XGxhQ47GOlSlLKnBUkS1KO7vKIRUVqY
         7JujBlJmXD1oIK+FmjqZ3qZy9FFhgXL2+bJQcewnYbRshXXKH0nG2G99ZSmFjwSzK6Is
         Hoo+LVe22581LoAXMsF5kIHRaUtNCRmee9RgV/eKYkMCHR0mbcCcFz6e75FPwJI3N86G
         TDaJRlDDvWTVzz+TRBfV3nNXvJQrQWjUg5I9aDM49zzUYryVz4T3H0VVOpdFztZOUJRW
         Mip8jBbYGo+X+B5yJQ6zKhn/qeGbSlKclggMowRR/PSu07Hf3jHiVE/gbXTytWi2cH+u
         hhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQ4fI7F+8v6Tt8fGO2S2mFMEeAia35LytNxoNBIvxUo=;
        b=ia3fl9rjp8EeeFjTEgoWSEtSuzEwFX1JVKxnU10Z3alKfqG+l+FPGrpAQZGyluT5Nt
         2QdG+Zjt7AFU9w/Dh8jTbdPB3gQj6uPl1wUyVFDy2BhWO8BTObJ14NZjCn88eKkez8mW
         FwJ1XhL6TrjJd35P3az4zCWS6kylYvwPkOCG5Gs11D5X9P79I5meJiSld2wPUw+VJ23e
         lfpO3k+rK8vg/pbUjq8rIbP66ImtnsSkHDjNbfkOA7nlOTPqQ3x0N/TCv1yO60FWM+Vm
         8mdt6/GjwxBXnT9R8FcVhTZSdyTUWZGALnHS53lb2NplmyPhkpDWGojRZpSOJSQuQGPT
         8lFg==
X-Gm-Message-State: APzg51CuQRcz83UEDovICc+zhOR+glQDwRzi8nmymRlh6TDaE/NPobgz
        c5nPUMlZo+v/1RuLScSCUcA=
X-Google-Smtp-Source: ANB0VdancKAz/hkBtabBDh9hFuyWFacy54NFbRzAptlFg6CcSnUE07APRs0L0B0uVqFcphO9tHAQfw==
X-Received: by 2002:a17:902:6e01:: with SMTP id u1-v6mr26570475plk.13.1537213336537;
        Mon, 17 Sep 2018 12:42:16 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t15-v6sm25085085pfa.158.2018.09.17.12.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:42:15 -0700 (PDT)
Date:   Mon, 17 Sep 2018 12:42:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] doc/Makefile: drop doc-diff worktree and temporary
 files on "make clean"
Message-ID: <20180917194214.GG140909@aiede.svl.corp.google.com>
References: <20180830195546.GA22407@sigill.intra.peff.net>
 <20180831063318.33373-1-sunshine@sunshineco.com>
 <20180831063318.33373-4-sunshine@sunshineco.com>
 <20180917183258.GC140909@aiede.svl.corp.google.com>
 <xmqq36u77w7y.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36u77w7y.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Eric Sunshine wrote:

>>> +	'$(SHELL_PATH_SQ)' ./doc-diff --clean
>>
>> This means I need a copy of git in order to run "make clean".  That
>> was never required before.  It makes bootstrapping difficult --- do we
>> really need it?
>
> Gahh, you are absolutely right.  Also "doc-diff --clean", if I am
> reading the code correctly, requires us to be in a Git repository,
> not a tarball extract.
>
> Having to have Git installed, or be in a repository, in order to be
> able to run an optional "doc-diff" tool is fine.  Requiring either
> in order to run "make clean" is a different story.
>
> Thanks for spotting.  We can just prefix the line with '-'?  Or does
> the script badly misbehave (due to lack of CEILING_DIRECTORY) when
> run in a tarball extract inside somebody else's repository?

I'd rather that we revert this change altogether.  I have nothing
against a convenient command to do this kind of non build related
cleanup, but it shouldn't be spelled as "make clean".

That said, for my particular use, prefixing with '-' would work okay.

Thanks,
Jonathan
