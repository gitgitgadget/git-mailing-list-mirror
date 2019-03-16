Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3940320248
	for <e@80x24.org>; Sat, 16 Mar 2019 03:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfCPDnf (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 23:43:35 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:36819 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfCPDnf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 23:43:35 -0400
Received: by mail-io1-f42.google.com with SMTP id f6so10008187iop.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 20:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jfu0zvSqEkPuIdLMIwDAkOacSI92VCgH5enBpUEi/Zg=;
        b=hj4XtFxgDPiLL3lpgU/QXcRmbl1BEfLPVaRJoNr4VpaTaE7Ce1hBOXxWSwb873qNjh
         Uk2b14OMCtPUBCQQR+2atsqWTgfKTYo80WAJepN1chN6rjoOAq6kIleJa6LSUYpOUCOq
         2+6/xJI6oVCU7ng/vAb2lWyewDnH6QcGlbGJgeio8MxoYO4KgA0Vxnim/3XOZBb/yu9H
         PEGMXu82MY+sGFz7BQLqdaL04o9t8BWApju2Rk497zjeu/LT0O+XGhV4nfcglxC5h3hW
         DQgxUwMss2Uz622+lD5XqrpMgThTkvpOCwMNkD/nbHwzkq6OQ/q9MNnQcEgv739CP14A
         VhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jfu0zvSqEkPuIdLMIwDAkOacSI92VCgH5enBpUEi/Zg=;
        b=EN0MdKvE3jvlfCOUX1FuH1f8J8RtOGbmK0r4AbjIdGd6UiW/cTn3M1j0zHmYxStlnl
         oZBRo0x8Jy9Y3HGy49Qc0bLj3o1yRd4Ycq/Y3M9skw8S1eC/UjeG4xsJMwdMLPsJ7Db9
         WXvDi3HgObtzs4i4qf+pj9r90S8EOc+dfFSC84Ev9OglH/FFDEHh/hYqpr5C1bhWWxcd
         L9HIEG2fALZYpsjGxdzI8wd3qYXuXemcJYDk0M2jMJNDNDSHxa7lKqFJ3JA5K5XdL84g
         n8n5lxE+I4O5jxVMQlaoo5HTNqUoSiS8kQnxCPTPvj9d75sYevwiNkTEb3crpcCtBT0T
         hm0g==
X-Gm-Message-State: APjAAAUTBNtfFwnFR/r3iiIThqdTUIcm0dVbbpyZ2Hm5pviqs9zpEqxx
        OVFoFZ3+nejpl+rJh+mUabjb3T2kF9JVsVRqu219NA==
X-Google-Smtp-Source: APXvYqyRagTNnGhm/sUrwpd/JaR1BI0EXdqRvevH5V746OHKVwZIqi/OUvqprzRTSgCNjXUnBshywO6ZRE1aUL3AqDw=
X-Received: by 2002:a5d:9446:: with SMTP id x6mr3761018ior.236.1552707813950;
 Fri, 15 Mar 2019 20:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1903150809070.26709@localhost.localdomain>
 <CACsJy8DVRJ4DG6PEkFuzytOQJ7RX6GMaHd4BRQTR9N7Y9V6fqQ@mail.gmail.com>
 <alpine.LFD.2.21.1903150917360.27423@localhost.localdomain>
 <CACsJy8CspqxDhOZFF7ac_63TQXvsHjTBicEPtZaUSOmaQnzs4A@mail.gmail.com> <alpine.LFD.2.21.1903151027580.29322@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1903151027580.29322@localhost.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 16 Mar 2019 10:43:07 +0700
Message-ID: <CACsJy8AxBr1AUwsPb6FZkJ5Pn9AfooW04Gz4fsdjF6VcP87g3w@mail.gmail.com>
Subject: Re: "git clone --shallow-exclude ...", fatal: the remote end hung up unexpectedly
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 15, 2019 at 9:31 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>   also, i think "man git-clone" could really use a set of examples for
> shallow cloning. i'd offer to write it but i'm still figuring it out.

Cool. I'll give you a quick introduction to help with those examples :D

Side note: there's also narrow/lazy clone (or something with the
promisor) but I still haven't caught up with that. So none of that
here, but I think we should eventually have some examples/description.

A shallow clone is basically a repository with commit history cut
short. If you have a commit though, you have full content. It's not
cut by paths or anything.

"git clone --depth=X" the the normal way to do this. You get a
repository where all branches and tags have maximum X commits deep.
But since the main purpose of shallow clone is redude download,
--single-branch is made default when --depth is present, so you get
the default branch instead of all the branches (you would need
--no-single-branch for that). You could see these cut points with "git
log --decorate". I think they are marked "crafted" or something.

Once you have made a shallow clone, you could do everything like
usual. Local operations of course can only reach as far as the cut
points. Pull and push to a full clone are possible (it's even possible
to do so to another shallow clone).

When you "git fetch", the cut points remain the same, so you get more
recent commits and the history depth increases. If you do "git fetch
--depth=X" then the cut points are adjusted so that you only have
maximum X commits deep for all select branches, the same way a shallow
clone is made initially. "git fetch --unshallow" can be used to turn a
shallow clone into a complete one. And I'm pretty sure you could turn
a complete one to shallow with "git fetch --depth".

While --depth works fine most of the time, sometimes you want a
different way to define these shallow/cut points. --shallow-since and
--shallow-exclude are added as the result. --shallow-since cut the
history by a specific date (for all select branches).
--shallow-exclude cuts the history by a ref (often a tag). As I
mentioned before, it's mostly used to say "I want a shallow clone from
(but not including) v2.9.0".

And I think that's pretty much it. There's --update-shallow option but
I can't remember when that's needed. Shallow clones may also prevent
you from using some optional features. Pack bitmap is one of those and
I think probably commit graph too. It's not technical limitation, just
lack of time/effort to support them in shallow clones.
-- 
Duy
