Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 431E5202A5
	for <e@80x24.org>; Tue,  3 Oct 2017 15:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdJCPKn (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 11:10:43 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:47594 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751741AbdJCPKl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 11:10:41 -0400
Received: by mail-qt0-f173.google.com with SMTP id z50so8506991qtj.4
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 08:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f9mkZeCYL/64kb1bQ0Z6fb6wZNbBPzFLB6aEDdHFt4E=;
        b=lAroMuGCAuwZiXNtc5ouGgjGWPIqom5S8lYtxWW3A/Kee4j5kmpJSVQY6cB8nB1YsM
         MsyazwvDF7uDk16Xy+CKhMj241h8M0GTSS9Pf7IpvIN9pdI3PNmCRkKkcveY3ZZ32quK
         lhm4x5QG3U1e130dQIZ7ILGEGHJUeGOGfm2rf0cKSgoJNw2iNNdrTPrrFqg1A74iXMi1
         r64p4ySDoh+GdiSs62DNTvWYx2piJUUCb7Mf/UCmtfDKku0N1gh2QyPK5u01rykyR8nX
         mA/VlNMar+bOmB6gDwM5gdXqrtCe/W7Qii//4Qxk9UAfEjZ91WD1AB+kFYJK5EgPCyVS
         WPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f9mkZeCYL/64kb1bQ0Z6fb6wZNbBPzFLB6aEDdHFt4E=;
        b=rvi9TSnwHyG15+vE6/i0Jagl2Y7JEoDmHAUbtPH786DgI6Gj+iB+fmEbbnqaZaEcE0
         lkLOClakfqrhYDJnvLXEIbinZqmbSdwFMqErNMK0JtURg8fIQyDQGd8PFDbPLDy1BmGE
         uAOnwvN89r56O5Z3Lb69gnR4Aj+JEW2EzOw2UW8WCP1ZoHGXo0p8sC9dKaIU/18G2gol
         9UiAZHUgFpk9eNP/KTlKWqf/1weeL5C5tKCde0z/KXiG3uFWui3s9q1IEBJMNwnoOl0W
         HgJmV6VSKhp0uUYgE8eYcuge2c2xVyCXIXYLk7rpw0RdglFRATi2kDDOMS7hXN6w/Znx
         tUcw==
X-Gm-Message-State: AMCzsaWos9HeWVDb7B5G2aSi1L3Wmnv2SsBrmfp7NvmRvQoa/bLjjQDC
        aGLpKiKx6ExNXPmCmFPm/B6fuzerUXLCC5uP+jzdRw==
X-Google-Smtp-Source: AOwi7QCjDJ3t9jJ04Kc6bc9TYhggXsqT/svlIR5CCBruorocxYiDOJec1RYddLxGjO4CpL1bjb4BWcIuZ9IDgtzci9c=
X-Received: by 10.200.8.53 with SMTP id u50mr7937333qth.260.1507043440981;
 Tue, 03 Oct 2017 08:10:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Tue, 3 Oct 2017 08:10:40 -0700 (PDT)
In-Reply-To: <20171003123239.lisk43a2goxtxkro@sigill.intra.peff.net>
References: <20171002234517.GV19555@aiede.mtv.corp.google.com> <20171003123239.lisk43a2goxtxkro@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 3 Oct 2017 08:10:40 -0700
Message-ID: <CAGZ79kacfdgw27MjSMwiZO-sn2EgjeQdsEUoSs=b_K+ekA4rfA@mail.gmail.com>
Subject: Re: Security of .git/config and .git/hooks
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Loic Guelorget <loic@google.com>,
        Sitaram Chamarty <sitaramc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So once upon a time we compared Gits security model with a
web browser. A web browser lets you execute 3rd party code
(e.g. javascript) and it is supposedly safe to look at malicious sites.

Currently Git only promises to have the clone/fetch operation safe,
not the "here is a zip of my whole repo" case, which sounds more
like the web browser experience ("here is a site with js, even zipped
in transfer"). Tightening the security model of Git towards this seems
like a good idea to me.

>>  1. Introduce a (configurable) list of "safe" configuration items that
>>     can be set in .git/config and don't respect any others.
>
> A whitelist is obviously safer than a blacklist. Though I also feel like
> some of the options may give an unexpectedly wide attack surface. I.e.,
> I wouldn't be surprised if some innocent-looking option ends up being
> used in a tricky way to gain more access. E.g., submodule config
> pointing to paths outside of the repository.
>
> Do you plan to run in safe-mode all the time? What if safe-mode was a
> lot more extreme, and simply avoided reading repo-level config at all
> (except for check_repository_format(), which should be pretty innocent).
>
> I have a feeling there are some features (like submodules) that would
> simply be broken in safe-mode.

I would think that the essential submodule things would be "safe"
to look at. But e.g. submodule.<name>.update = "!rm -rf /" would be
not ok, hence the .update configuration would be in the unsafe space.

Any unsafe config option would need to be set outside the actual
repository (~/.config/git/<repo-id>/config ?)

>
>>  2. But what if I want to set a different pager per-repository?
>>     I think we could do this using configuration "profiles".
>>     My ~/.config/git/profiles/ directory would contain git-style
>>     config files for repositories to include.  Repositories could
>>     then contain
>>
>>       [include]
>>               path = ~/.config/git/profiles/fancy-log-pager
>>
>>     to make use of those settings.  The facility (1) would
>>     special-case this directory to allow it to set "unsafe" settings
>>     since files there are assumed not to be under the control of an
>>     attacker.
>
> You can do something quite similar already:
>
>   git config --global \
>     include.gitdir:/path/to/specific/repo.path
>     .gitconfig-fancy-log-pager
>
> The main difference is that the profile inclusion is done by path rather
> than riding along with the repository directory if it gets moved. In
> practice I doubt that matters much, and I think the security model for
> include.gitdir is a lot simpler.

I am not sure if this works so well for the submodule.<name>.update
config (that we want to deprecate anyway, but still)

>> For backward compatibility, this facility would be controlled by a
>> global configuration setting.  If that setting is not enabled, then
>> the current, less safe behavior would remain.
>
> Are config and symlinks everything we need to care about? I can't think
> of anything else, but Git really has quite a large attack surface when
> accessing a local repo. Right now the safest thing you can do is "git
> clone --no-local" an untrusted repo and then look only at the clone. Of
> course nobody _actually_ does that, so any "safe" mode seems like it
> would be an improvement. But would claiming to have a "safe" mode
> encourage people to use it to look at risky repositories, exacerbating
> any holes (e.g., exploiting a bug in the index format)? I don't know.

Good point. Though we only care about the case of breaking out and
executing untrusted code; most of the index exploits would rather
trigger a segfault or infinite lop (in my imagination at least).

>
> -Peff
