Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109661F89C
	for <e@80x24.org>; Fri, 20 Jan 2017 10:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751981AbdATKz7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 05:55:59 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:37068 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbdATKz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 05:55:57 -0500
Received: by mail-it0-f51.google.com with SMTP id r185so17119516ita.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 02:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wkkPG0vTshz1fuN6Iys3/lOR2pniFl2Uc078z3oft7Q=;
        b=RHs8sRIIKaJTedf3D+BI/yxfalEeUu8YBQQCf998q/UJBAf1NlQVDN4RAdTq0PPtkv
         LiR2A3RnmhBzCk9oMHz/SuGwKY+dhqtK/DeCb5ppAQZE6lWGkOTTq4uXI88aOavoUJZh
         2Se9Cvbo5aiVOnZQ5Mii2KVhrIFjb9dgN9DumeF5Nbl63dngVBis809PYL5PIvQmdtw5
         dfS0GoiBdGuG2/w4U7QANYUHdv6+qscSt7Mxldl668AKakLNeKlKhY6mgViuh6/b7pro
         8p5LAXhh1EXLB6MjGEpHRBHQV8roTYUEsa5Ss3mpYoJCDj8NJ9xgNtI97S5RCexgguk+
         vCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wkkPG0vTshz1fuN6Iys3/lOR2pniFl2Uc078z3oft7Q=;
        b=XXQBbfjcDUXeSlBWYAsu6oUrrsBsep85EGIgx/Dh70n69MDA7bpTH/wjJCXrCmeHyj
         46RX6lqhn8zT1PCCqYPbfTjTQNK3UKNGP/7vMtlMkxPSp2hIiuQ6qXq7vC2Aek4I820Q
         GWQOFy+IoUpsnIoQTmyrw8NvyGJT2ishcR9AZTsYWOKjAJ0+JKdzEtGtUZikNDQtiWov
         k8aSEZ+YuY7MjRzaCxYTVCvKElzUwi8h5xymi4l0wzNIaeTVRGN87BJr0j2VtoQCjabM
         wsbQEVL2+kN6+2DHU7bSzb9Li3ZS8qTwWWpCLUfgCLq0kLbLrR+so59IUpPXjTJDDSbv
         NncQ==
X-Gm-Message-State: AIkVDXLOGymjKtTHXPsndvWMdFiM4zcbTjnvVU0KFy342gKB3YvqC3pm5wuMM7cdiHRqQkfjLtn5reexsnpusA==
X-Received: by 10.36.122.131 with SMTP id a125mr2785333itc.3.1484909751949;
 Fri, 20 Jan 2017 02:55:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Fri, 20 Jan 2017 02:55:21 -0800 (PST)
In-Reply-To: <20170119172310.6meuj6ksxloeee2t@sigill.intra.peff.net>
References: <20170119122630.27645-1-pclouds@gmail.com> <20170119172310.6meuj6ksxloeee2t@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 20 Jan 2017 17:55:21 +0700
Message-ID: <CACsJy8A_LkRMZYfoJuYEUok4r7Tw0VuMwVkG_Kr1o1hFcAUWNw@mail.gmail.com>
Subject: Re: [PATCH] log: new option decorate reflog of remote refs
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 12:23 AM, Jeff King <peff@peff.net> wrote:
> I think it's a neat idea, but the actual option:
>
>> +--decorate-remote-reflog[=<n>]::
>> +     Decorate `<n>` most recent reflog entries on remote refs, up
>> +     to the specified number of entries. By default, only the most
>> +     recent reflog entry is decorated.
>
> seems weirdly limited and non-orthogonal. What happens when somebody
> wants to decorate other reflogs besides refs/remotes?
>
> We already have very flexible ref-selectors like --remotes, --branches,
> etc. The generalization of this would perhaps be something like:
>
>   git log --decorate-reflog --remotes --branches
>
> where "--decorate-reflog" applies to the next ref selector and then is
> reset, the same way --exclude is. And it includes those refs _only_ for
> decoration, not for traversal. So you could do:
>
>   git log --decorate-reflog --remotes --remotes
>
> if you wanted to see use those as traversal roots, too (if this is
> common, it might even merit another option for "decorate and show").
>
> That's just off the top of my head, so maybe there are issues. I was
> just surprised to see the "-remote" part in your option name.

Imposing order between options could cause confusion, I think, if you
remove --decorate-reflog leaving --remotes on by accident, now you get
--remotes with a new meaning. We could go with something like
--decodate-reflog=remote, but that clashes with the number of reflog
entries and we may need a separator, like --decorate-reflog=remote,3.
Or we could add something to --decorate= in addition to
short|full|auto|no. Something like --decorate=full,reflog or
--decorate=full,reflog=remote,entries=3 if I want 3 reflog entries.

My hesitant to go that far is because I suspect decorating reflog
won't be helpful for non-remotes. But I'm willing to make more changes
if it opens door to master.
-- 
Duy
