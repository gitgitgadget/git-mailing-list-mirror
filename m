Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ABD81F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 17:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfJ3R6W (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 13:58:22 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39274 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfJ3R6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 13:58:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id t12so1322621plo.6
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eMxf2T3kqMaO3LESHirqyR2vYMj6IZa0XYFfYRWe3o4=;
        b=cnHULELQWuK7Ti6VUdW9gIUIZKGV74yGFCdBazC8KO0o5O6XuOaz4pe1N2zrQfxP/a
         D2gAhJacSFY+vR3WLmEIL/cTItcNT7UN/ZR+B60GYg5DQVNCyjktR7fxAJLYFxFdPfAp
         HD///5jPt1lJdsZ/hxqRSQnNAqsT1jqt4+yK082+fFAdJwFek16C5EAQM/VFTU97dt6s
         elbSOz6T0sx3BZTaNBTvxIHvCOfMAByvixKlr0b1dhtZJX9Fq82IiJrE7+9uAiSEAW4f
         UeAIby/Rxc2IootQFcjf/yR6wubUDaiA9dE7LElZWAcwEeQHVUSR5J51REZbn43o4W+Z
         8ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eMxf2T3kqMaO3LESHirqyR2vYMj6IZa0XYFfYRWe3o4=;
        b=Aw19eUNxDuyNLBZSZJmYP2SpK/IsBtNTZKZT8jDsViufyE+ZHokVUGbTacyKlLrCEz
         kVwEzBG7Dd5xUFt4MeS8IKbRfV8xNmR8pxe9Tx3sK+OEUkILPVGzwijToMhiBXO+BWka
         TKcKbCsafRH44cl+s5nLGQrzpvRlzMExfUMbccpEe6aDglD4PWtLikOh18a8xnqj67GB
         8+2k3DsxFckogsUAq+8HdeFKFzcsDgXe26JjB2039sDA2WudWdiX6/C+w+0gz1ycbviF
         MEE/lCEQbic9oTM+7AJ7q+pH1UAHDDPuYN7eYDNS8leM8Dk+XUFtL69s/b252EMsR/Y/
         qzDQ==
X-Gm-Message-State: APjAAAVu7VSipvepTbnL09UDKBylqsM9XgFK7uAwTQDEtFHWn3B5G2vG
        irghGfVh3rAoLtkh/M04uQA=
X-Google-Smtp-Source: APXvYqyzEBQ/Z1qeBUoFX8jFtywel4SFaInvHhjjqBoXqv4fMna9bCyzK1ceWnk6CWYiNhpo7bVNeg==
X-Received: by 2002:a17:902:8a90:: with SMTP id p16mr1394110plo.220.1572458300839;
        Wed, 30 Oct 2019 10:58:20 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id 19sm544493pfh.2.2019.10.30.10.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 10:58:19 -0700 (PDT)
Date:   Wed, 30 Oct 2019 10:58:17 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Danh Doan <congdanhqx@gmail.com>
Subject: Re: [PATCH v3] submodule: teach set-url subcommand
Message-ID: <20191030175817.GA5120@generichostname>
References: <d8841c6009c91ac921d30b35ed9a441c87b332e2.1572337964.git.liu.denton@gmail.com>
 <f5f44812af2b43fe3f7ea837f8b07c4747eedcc0.1572368447.git.liu.denton@gmail.com>
 <xmqqtv7q3hhp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtv7q3hhp.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Oct 30, 2019 at 02:54:58PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Currently, in the event that a submodule's upstream URL changes, users
> > have to manually alter the URL in the .gitmodules file then run
> > `git submodule sync`. Let's make that process easier.
> 
> Right now, submodule.<name>.url might be the only thing that gets
> synched down to .git/config of the submodule; we may not learn any
> more things that needs "edit in .gitmodules and then run sync".  Can
> we sately say that "sync" is now obsolete and what it has been used
> for can now be done with "set-url"?  In other words, does "set-url"
> makes "sync" unnecessary and deprecated?

"sync" isn't deprecated quite yet. If upstream edits the .gitmodules and
we pull in the change, then we still need to run "sync" to update our
.git/config.

> 
> Or is it expected that we would learn more things end users can edit
> in .gitmodules and run sync to propagate necessary pieces of
> information down?  If so, do we want to add an extra command like
> set-url for each of these new things, or do we tell users "if you
> are editing url, use set-url, otherwise edit .gitmodules and run
> sync"?  If the former, that would make the set of subcommands quite
> noisy, and if the latter, the users need to learn two things,
> i.e. it is not making it easier but harder to learn the system.

I was running under the assumption that we weren't planning on adding
new information to .gitmodules. I don't think we'll be making changes to
the submodule file format without careful thought so _if_ that ever
comes up, we should discuss it then but I don't think it's a discussion
that's going to happen any time soon, if ever.

Either way, though, the sync workflow isn't going away so users still
need to know how to do that (unfortunately). We'll just add a
convenience function on top to make people's lives easier but it's not
strictly _necessary_ to use "set-url".

> 
> There is nothing _wrong_ to introduce the new subcommand per-se, but
> given that the URL should not change that often, and due to above
> concerns, I am not sure if I want to back this change.

I think it changes often enough to cause problems. Seems like at least
936 people on StackOverflow agree with me[1].

I think that the problem is that it's a common enough use-case but not
common enough that people often forget to "sync" after editing the
.gitmodules. I know that it's bitten me the few times I've done this and
I've had to go back to that SO post each time.

[1]: https://stackoverflow.com/questions/913701/how-to-change-the-remote-repository-for-a-git-submodule
