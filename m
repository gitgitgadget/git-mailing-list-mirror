Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67DCF1F404
	for <e@80x24.org>; Thu, 12 Apr 2018 23:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753355AbeDLXgf (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 19:36:35 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:36622 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeDLXge (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 19:36:34 -0400
Received: by mail-yb0-f181.google.com with SMTP id h18-v6so3108211ybm.3
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1ni2rci1D8dyHMirC72X99IAvNe8AwWEV98KKpjKuxI=;
        b=Lo0dLw0EZAsKoG3xRD/zH33bKBGp9DmsdgssrtKL7lCtI60JddAVV83+3/1rD0xskA
         Y+cE+zNtF2AVB9oK/Sx456/GjYOdrW0enGugW4ena5lDzYsRBPoDJ/gTUHMHxfcS5skr
         OxQ46wv8ciEtSx8FgxlqOZku56QJEG0nyc5ukjzjo1XEhaRe5oodo8dPFvXnBybGZy8r
         kwgP6H1whxttyMODlonfCTR7d77+TEsVaB9hkD3Qp57Uz2MiXUyiP52c4oSPtcsHr/Fa
         XHNGSfMvDdB8g0a3NrIjQoLZlX17Bzhx8wu8tkyQaWcsD79WrQ0gDrq8Ibew8+x3ZX9D
         LZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1ni2rci1D8dyHMirC72X99IAvNe8AwWEV98KKpjKuxI=;
        b=CLjZ4MaImsAhxH5ufT3aUdOIkwD7BFQvs8keRB66TVeYHu94wb2U7+YgI39SY1cQFn
         oU3G3wVqAb2pNXNdZLB1bcKZb5V/TlXWqj1DDfobag4DAHbZ7B2WwiZSR6bj/nTAprJ9
         pFb3gRUTTeMDdEaqzEwjJc3EgWJduISI3X4/23drZEnK81cO7XPjL+ei2/Gm1ZB7nXgY
         nrHiDBlySumnUXdA6yeHtjrYLZ3nK9cWLBzL24dFtZdsI4a+0eDDSxeNGcTvzY2TA7bw
         9yYK5Dqxhlpa9ECmyqorNGiR6vGn8h1h1WwgHnug9a12pCzeU8UzxM+GKQLqjF9TW7jf
         eaqQ==
X-Gm-Message-State: ALQs6tCFsQ01KahnVeGTGXNuyjAj3CzGCSJLhQlKBMNjsHTe8DAr4Wgl
        J8IQyj7jOJLd4nfEXG/1Hf4c/OqOezjwkonAWiElZw==
X-Google-Smtp-Source: AIpwx4+oOkDHc44TYbWr/BrbRzKpOTlscIOSli0QwcJWKIRIOhuhu1GodH2o/tS18ML/WtBsR071Z+tqXlm700ZIExE=
X-Received: by 2002:a25:8e09:: with SMTP id p9-v6mr2301778ybl.352.1523576193532;
 Thu, 12 Apr 2018 16:36:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Thu, 12 Apr 2018 16:36:32
 -0700 (PDT)
In-Reply-To: <20180412222047.5716-1-ao2@ao2.it>
References: <20180412222047.5716-1-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 12 Apr 2018 16:36:32 -0700
Message-ID: <CAGZ79kZbZ03D7ysaVXYkV3v0jO6K7kEOc9sT2zA+Xc6mqLNL9Q@mail.gmail.com>
Subject: Re: [RFC 00/10] Make .the gitmodules file path configurable
To:     Antonio Ospite <ao2@ao2.it>, Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio,

On Thu, Apr 12, 2018 at 3:20 PM, Antonio Ospite <ao2@ao2.it> wrote:
> Hi,
>
> vcsh[1] uses bare git repositories and detached work-trees to manage
> *distinct* sets of configuration files directly into $HOME.
>
> In general, submodules have worked perfectly fine with detached
> work-trees for some time[2,3,4].
>
> However when multiple repositories take turns using the same directory
> as their work-tree, and more than one of them want to use submodules,
> there could still be conflicts about the '.gitmodules' file because git
> hardcodes this path.
>
> For comparison, in case of '.gitignore' a similar conflict might arise,
> but git has alternative ways to specify exclude files, so vcsh solves
> this by setting core.excludesFile for each repository and track ignored
> files somewhere else (in ~/.gitignore.d/$VCSH_REPO_NAME).
>
> This is currently not possible with submodules configuration.

So far I agree w.r.t. Gits capabilities.

> So this series proposes a mechanism to set an alternative path for the
> submodules configuration file (from now on "gitmodules file").

That sounds interesting, so let's read on.

> Patches are based on fe0a9eaf31dd0c349ae4308498c33a5c3794b293.

... which is the current master branch by Junio.

> In commit 4c0eeafe4755 (cache.h: add GITMODULES_FILE macro)[5] the
> gitmodules file path definition was centralized, AFAIU this was done
> mainly to prevent typos, as checking a symbolic constant is something
> the compiler will do for us.

+cc Brandon author of said patch.

Digging up the discussion, this was indeed only done to prevent typos.
https://public-inbox.org/git/20170802172633.GA36159@google.com/

> Expanding on that change the first patch in the series makes the path
> customizable exposing a 'core.submodulesFile' configuration setting.

I guess the similarity to core.ignoreFile is desired here. Although these
mechanisms are very different.

> The new configuration setting can be used to set an *alternative*
> location for the gitmodules file; IMHO there is no need to provide
> *additional* locations like in the case of exclude files.

I think there *may* be a need for additional files.
Currently there is only the .gitmodules file and the configuration
in .git/config overriding settings from .gitmodules.

There was some discussion on the mailing list in the past, which
presented a intermediate layer in between these two places, in
a special ref, such that:
    base is in .gitmodules
    overwritten via refs/meta/submodules:.gitmodules
    overwritten via the .git/config

The intermediate would be a config file that is tracked on another
ref. This (a) decouples main project history from submodule history
and (b) makes it easier to distribute as it is part of the repository.

For example (a) is desired if you dig up an old project and the
submodules have all moved from one git hosting provider to another.
Another example would be when you fork a project with submodules
and don't want to mess with the main history but you just want to
adjust the submodule URLs. That is possible with such an intermediate
additional place.

For (b) you can imagine the fork that you want to distribute in your
community and you don't want to tell everyone to change the
submodule URLs, but instead you can provide them with a prepared
.gitmodules file, that they have to place into that special ref (which
can be done via fetching).

I digress as these ideas seem to be orthogonal to your patch series,
just FYI. prior discussion starting at:
https://public-inbox.org/git/1462317985-640-1-git-send-email-sbeller@google.com/
I recall there was a better discussion even prior to that, but have no
link handy.


> For instance vcsh could set the location to
> '~/.gitmodules.d/$VCSH_REPO_NAME' to avoid conflicts.
>
> Since the gitmodules file is meant to be checked in into the repository,
> the overridden file path should be relative to the work-tree; is there
> a way to enforce this constraint at run time (i.e. validate the config
> value), or is it enough to have it documented?

I think we'd want to check at run time, if we need this constraint.

Thanks,
Stefan
