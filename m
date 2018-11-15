Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90EB11F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 20:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbeKPGMe (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 01:12:34 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:45855 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeKPGMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 01:12:33 -0500
Received: by mail-ed1-f50.google.com with SMTP id d39so14478531edb.12
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 12:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGqqwVgAKHscZTAhW8mU0MiNEZ4qoSKPt8RsUO71TBI=;
        b=PNgdbjuXrmAUdFHU56h9KCTw4q4Qci0qo9j631Lnjvx0Q/jPWMzXJaM7m20MRbM5/s
         PF7BpS5AaJ9dhtFGAFnjNT/vcw4toCgOU3kUaOGkxQWRTSK+omAxNQ9QH7SXUg4xTvx/
         ypGFANLB1nQG95Jq0mYxU6plvUnqZKaVSjWy3Bp1wtUfyK7TAOt2xMb5Cx/YcCmrWcGr
         OIAprv2eaJaLIxQag6M1H0ne1p22FvamLMuvMSnJtEC0GvcasEOXvPTStR6LQzGK2YS1
         yqp+urDE6hRSs4XL7hC0JJkH4uad10cJMIX+wVFv14E8LgrYW8INYXMg212i7glYIfsS
         q8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGqqwVgAKHscZTAhW8mU0MiNEZ4qoSKPt8RsUO71TBI=;
        b=tngqmoELW1mazWILzLgmyjimOkY4oICUdvZIsu8lBFUxzb138L6P9bHkvwQ6i165oB
         iZph4JeeikCQXdJg1Jxt4u1q5SXfReLiUzNn7QNAzb6LDzHDxoETn+qAezMzAvUo8MQk
         TvsFTKkFLvdu8HQhghjfioXVgfihFoOaXjYwBfPlLXRLW4X3pXjDadpNDCdfjaXsUoKU
         1ERBVmQ2JK2N/Hb8jPLSkr+1dq3MMvfHIv426FB+EaTk0O4NdkQorCWubZXFwemukNxY
         dcXbETWpOVUu6C7X8iYrmyaErDEBAu6cfApxwaXmFG4VD6D4KjCoahmh4JHAVpYXOnRK
         M2ag==
X-Gm-Message-State: AGRZ1gIerNh1TBW6vR8HL9W/i7HJnyYwAkzc+qvdusKSd1dy+MKe/8zc
        cMtkZfGW0yXWPEiLxapcAKqZOfzsJs2rvNW2wyzKlU1Ts32uDA==
X-Google-Smtp-Source: AJdET5cT4ynUdwn/NjkLojPbvyOCpEjwvsD/9cM7MSs33RSmKaDqozNhiOlrzWqHZdbPwgwVzb35diW7FessSkpyi9A=
X-Received: by 2002:a50:adcf:: with SMTP id b15-v6mr6712828edd.215.1542312198012;
 Thu, 15 Nov 2018 12:03:18 -0800 (PST)
MIME-Version: 1.0
References: <CAGw6cBvLDNtYT6vfHcxmX0S_SS1vmYVCEkSD_ixah6cGKJ4H9w@mail.gmail.com>
 <CAGw6cBvaC+TEOM9Tjdbs5zkz2hzW4649=4rsAo58cNOVHOQS=Q@mail.gmail.com>
 <CAGZ79ka=tkKYNkPmSjhomcfAPbEg6PQPSRtpe3uq2B45fNoyjg@mail.gmail.com>
 <CAGw6cBvJSswpvrMwKU9b+ANEHO4tWjWVhLL54nUyod2NoHJe1w@mail.gmail.com> <CAGw6cBth+j+vAjhrQutxBXAkuJrBfHKG4GdCu1jpvAAXOwudEA@mail.gmail.com>
In-Reply-To: <CAGw6cBth+j+vAjhrQutxBXAkuJrBfHKG4GdCu1jpvAAXOwudEA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 15 Nov 2018 12:03:06 -0800
Message-ID: <CAGZ79kYiWnciitwTQCXR5bHOj7nhHWr40xBiS5sPCH5W4_yQ5w@mail.gmail.com>
Subject: Re: Confusing behavior with ignored submodules and `git commit -a`
To:     Michael Forney <mforney@mforney.org>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 10:05 PM Michael Forney <mforney@mforney.org> wrote:
>
> +bmwill
>
> On 2018-11-14, Michael Forney <mforney@mforney.org> wrote:
> > On 2018-10-25, Stefan Beller <sbeller@google.com> wrote:
> >> I guess reverting that commit is not a good idea now, as
> >> I would expect something to break.
> >>
> >> Maybe looking through the series 614ea03a71
> >> (Merge branch 'bw/submodule-config-cleanup', 2017-08-26)
> >> to understand why it happened in the context would be a good start.
> >
> > Thanks, that's a good idea. I'll take a look through that series.
>
> Interesting. If I build git from master after reverting 55568086, I do
> indeed observe the issue it claims to fix (unable to add ignored
> submodules). However, if I build from 9ef23f91fc (the immediate parent
> of 55568086), I do not see the issue.
>
> Investigating this further, it seems that 55568086 addresses an issue
> that does not appear until later on in the series in ff6f1f564c
> (submodule-config: lazy-load a repository's .gitmodules file). Perhaps
> this was a result of reordering commits during a rebase. In other
> words, I get correct behavior until 55568086, and in
> 55568086..ff6f1f564c^ if I revert 55568086.
>
> Looking at ff6f1f564c, I don't really see anything that might be
> related to git-add, git-reset, or git-diff, so I'm guessing that this
> only worked before because the submodule config wasn't getting loaded
> during `git add` or `git reset`. Now that the config is loaded
> automatically, submodule.<name>.ignore started taking effect where it
> shouldn't.
>
> Unfortunately, this doesn't really get me much closer to finding a fix.

Maybe selectively unloading or overwriting the config?

Or we can change is_submodule_ignored() in diff.c
to be only applied selectively whether we are running the
right command? For this approach we'd have to figure out the
set of commands to which the ignore config should apply or
not (and come up with a more concise documentation then)

This approach sounds appealing to me as it would cover
new commands as well and we'd only have a central point
where the decision for ignoring is made.

Stefan
