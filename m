Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 095DE1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 22:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeI1EsD (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 00:48:03 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37616 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeI1EsD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 00:48:03 -0400
Received: by mail-it1-f195.google.com with SMTP id m9-v6so478046ita.2
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 15:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kb/APN2Lsnxpm3gBGbXaRj9Er5BhycUSiDtsfDV5ADc=;
        b=cVVDgvYWcN4t6HgzQeBHaoDNDzMPSiyp7BgI7PFJ52MZ5n1Vn0W3DoRbzjzPhDoz5j
         Ye3nDV/rYVOoxBh4GHo8EMc+BpHNCM1g2a2wEP+zHhT3swVDpwUbqRGaGlkXkyuKOghs
         0MyR51geLHbD3MYE5q3veTbCHpDH9OOXD4bGF+dqsKpr77rMdobzSgqT+FJx4BLubbK4
         NB5GW5TI4Tp/+6TT+oKdQFHFHVnsa3GAJU9yIYV9U4RobR7YF0Pv3RZ46Ysl/z8IPMCG
         jdW6c6w6rXvscrziXmY6gdukIityhiO4JyBsT5Y+i8qo1WNZT7i8XxgyaFlpFtQ4T5Xx
         UVoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kb/APN2Lsnxpm3gBGbXaRj9Er5BhycUSiDtsfDV5ADc=;
        b=MO16rC9AUVFFaZRTU+GxNpUREQApGO/lkKSY5+BHQKx5K2q02J0hfk4FqOm1ThZqTf
         zIof7TKL9Rz28Ke1c1OYbRlufMRcoufRPTsc9/PahBLX9RhUq3FHtjt2KZyFYgcgdrbH
         LknOmiesYLJEV2OVbCuC1+mH9+DDUyiAJjRtUDCD/OAUUY6/OpALahq/j2j4YliMpN19
         Yn8SLu4MTIn8w4vBlUyVV1z/jfh6IpuHgrpnZKrtjPzixcyJOibxbhYWlVfN2aqw3/KR
         nPKkrlIVtjdQb5XSLzBZyGkQOGDctUWB9x/cstpO8mpzk5kJGWIUR/nY/gmoHuE9ldd7
         Bm0g==
X-Gm-Message-State: ABuFfoipt9TkIw0Q6IzYJfTQI5+7T8/jrx1RM58Fz+SsLP4SwPxKbfw9
        J5O1GwSRS1EQd4RGukvC5aA=
X-Google-Smtp-Source: ACcGV612zdG0Sdq6ci1JhHiBgRn0BEbLNo4qlmJZbg/OZ7GxfeiYmh8imDv/fSls5+aQf4gXY/eeFA==
X-Received: by 2002:a24:b60a:: with SMTP id g10-v6mr469932itf.55.1538087251895;
        Thu, 27 Sep 2018 15:27:31 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id h66-v6sm191910ita.22.2018.09.27.15.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:27:31 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:27:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] FYI / RFC: submodules: introduce repo-like workflow
Message-ID: <20180927222728.GD193497@aiede.svl.corp.google.com>
References: <20180927221603.148025-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927221603.148025-1-sbeller@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(dropping cc-s to my internal address that I don't use on this list
 and to git-core@google.com which bounces)
Hi,

Stefan Beller wrote:

> Internally we have rolled out this as an experiment for
> "submodules replacing the repo tool[1]". The repo tool is described as:
>
>     Repo unifies Git repositories when necessary, performs uploads to the
>     Gerrit revision control system, and automates parts of the Android
>     development workflow. Repo is not meant to replace Git, only to make
>     it easier to work with Git in the context of Android. The repo command
>     is an executable Python script that you can put anywhere in your path.
[...]
> Submodules can also be understood as unifying Git repositories, even more,
> in the superproject the submodules have relationships between their
> versions, which the repo tool only provides in releases.
>
> The repo tool does not provide these relationships between versions, but
> all the repositories (in case of Android think of ~1000 git repositories)
> are put in their place without depending on each other.
>
> This comes with a couple of advantages and disadvantages:

Thanks for describing this background.

[...]
> This changes the following commands in the superproject:
>
>   checkout -B/-b create branches in subs, too
>   checkout (-f): update branch in submodule (create if needed) and check
>                  it out; Pass the argument down literally if it is a branch
>                  name (e.g. "checkout -f master" will run a
>                             "checkout -f master" in the submodule as well)
>   clone: see checkout
>   reset --hard: see checkout

As you mentioned, I've been using this submodule.repoLike=true mode
for my own use for a while.  You did a nice job of explaining on how
it fits into a Gerrit-driven workflow; I'd like to add that I find it
pleasant in non-Gerrit-driven contexts as well.

The primary difference from repoLike=false is that this makes the
normal state to have branches checked out in submodules.  For example,
if I run

	git checkout --recurse-submodules -B master origin/master

then this will create and check out a "master" branch in all
submodules instead of only in the superproject.  This helps avoid some
issues in Git's submodule handling where submodule commits can be
pruned if they have not been checked out in a while because there is
no ref pointing to them.

Some next steps:

- now that we have a repository object, some of the implementation can
  be simplified and made more robust.  I expect that will also make
  these patches easier to review

- also in the direction of reviewability, at that point we may want to
  split this into multiple patches

- gitsubmodules.txt and config.txt should describe the new option, to
  help new users understand what this new repoLike workflow does

- there are some edge cases in the UX that get... messy that I should
  describe in another message

All that said, thanks for sending this out, and I'd be happy to hear
from any interested people --- feedback from anyone adventurous enough
to try this out would be very welcome.

Happy hacking,
Jonathan
