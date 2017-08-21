Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2572B208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 16:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbdHUQm4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 12:42:56 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35727 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbdHUQmz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 12:42:55 -0400
Received: by mail-yw0-f182.google.com with SMTP id s187so9255927ywf.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 09:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=R6xvm3py0ANYN0n2nbdBf8PVQ4ClTcw8ZNZME7+gOQ8=;
        b=LVn804QjbSeZrYx6US6XVLgUNQjmDhCqOL5LiklDj2PZNwtDygP6N+JxFvvYy+nXgM
         BuJIByF3RiWybhgWPbvDMmsh2iav8OvAOXoznLfXO86sxO2RI9rA6ks19b03NeKXR0Wp
         01h8JvSY/SCNeswnhXNv2M3YmRRDSfReZLthJhyruOxaaeWja5PTHWPF8Ci9LZOkOGzM
         xx7QAQBe8sFUjGr+glff6FG5D82/ox5ai9vHU+9o5X0vOddJpVS8cOi3nkgoCZdDwH4F
         KGVfPw9NJYOUvBD06GJEUyqVKOHkGeVhviLXzAdquhA6mxlf0DYpPOzkr/MbfyE9aeTn
         Yfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=R6xvm3py0ANYN0n2nbdBf8PVQ4ClTcw8ZNZME7+gOQ8=;
        b=nSw/wawI3kjfdJoSTy/QwW2z6DfgpfSeRz3HJ90w06sIun7R2T6MVwfxfRGSQlPKT6
         hDA91KRLhkaPvaqQz0d8VDHIAA8AgYDBdQD4WK4kbGl9sBkr5w8cTTopQe7DitrVqWmD
         i9cJvqdcoLRuDAYobFYYvA/Wtd06WC7mDklsrvWCWUEEDv3de82ZSueSRXAYtnCckIuP
         FHoLJZjbnYGTyvs64czvyPgkTDG/f1WhDZ+tiJcQHDgxDP3sufjb9dp/w0rc/ot+p4N/
         ohMIKMcYHTw0g+83JKwmp1hP8jphYPT1TyvyNcBP3dipt5+Jn19h7aBCQfS4snbRHj70
         GoXw==
X-Gm-Message-State: AHYfb5g3DVaV75CDqwbLxO0OuuVZMNgzXduCOPT84x3cdD3JPLltOv8z
        IQhP0VaLiGiLgM9rbx0iS63X9U3LmKP2
X-Received: by 10.37.189.134 with SMTP id f6mr8939134ybh.244.1503333775010;
 Mon, 21 Aug 2017 09:42:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Mon, 21 Aug 2017 09:42:54 -0700 (PDT)
In-Reply-To: <20170821160514.GA1618@book.hvoigt.net>
References: <4283F0B0-BC1C-4ED1-8126-7E512D84484B@gmail.com>
 <CAGZ79kajWhEOtqZLrYSAVhM_ZLDiQd9DP9GeL+J=tqach5V65A@mail.gmail.com>
 <FCB6097F-9F8D-4FDD-A8CE-D936C9CE62E7@gmail.com> <CAGZ79kb-ReME6qbDy-Q12-d=B=f6odUW_D1bAmegP4AY2AyntQ@mail.gmail.com>
 <xmqqd17tei7m.fsf@gitster.mtv.corp.google.com> <CAGZ79kZdnJ+bATTxKBhsJnKaJWGqcBu3MOQ9eK7m4j3dJPNbTw@mail.gmail.com>
 <xmqq7ey0ddlk.fsf@gitster.mtv.corp.google.com> <CAGZ79kap-4k7n48dvBAv2pJjNy2s_LPHS-NdfQD0A-BbWqh4aQ@mail.gmail.com>
 <xmqqpobs9hjy.fsf@gitster.mtv.corp.google.com> <20170821160514.GA1618@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 21 Aug 2017 09:42:54 -0700
Message-ID: <CAGZ79kZvcY8hawq1qGfFLm1Ukb-wn8j0e_hN8gF5jrEY20o7YA@mail.gmail.com>
Subject: Re: Submodule regression in 2.14?
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 21, 2017 at 9:05 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Fri, Aug 18, 2017 at 11:51:13PM -0700, Junio C Hamano wrote:
>> As long as we are talking about idealized future world (well, at
>> least an idea of somebody's "ideal", not necessarily shared by
>> everybody), I wonder if there is even any need to have commits in
>> submodules in such a world.  To realize such a "monorepo" world, you
>> might be better off allowing a gitlink in the superproject to
>> directly point at a tree object in a submodule repository (making
>> them physically a single repository is an optional implementation
>> detail I choose to ignore in this discussion).
>
> IMO this is one step to far. One main use of submodules are shared
> repositories that are used by many superprojects. The reason you want to
> have commits in the submodule are so that you can push them
> independently and all other users can pick up the changes. You could get
> by by Using the superproject commits for the submodule once you push or
> something but those do not necessarily make sense in the context of the
> submodule.
>
> So I think it is important that there are commits in the submodule so
> its history makes sense independently for others.
>
> Or how would you push out the history in the submodule in your idea?
> Maybe I am missing something? What would be your use case with gitlinks
> pointing to trees?

Well there are still commits, but in the superproject the UX feels more
as if the submodules were special trees. So if you want to interact with
the submodule specifically, you could do things like

    git add /path/inside/sub
    # works seamlessly from the superproject tree

    git commit --submodule-commit-only
    # When the flag is not give, you may get an editor
    # asking for two commit messages, (sub+super)

    git fetch --submodule
    # When the flag is not given, we'd fetch superproject and
    # on-demand

    # You feel the superproject is in the way?
    git worktree add --for-submodule <path/to/sub> ...
    # The new submodule worktree puts the
    # submodule only UX first. so it feels like its own
    # repository, no need for specific flags.


>
> Cheers Heiko
