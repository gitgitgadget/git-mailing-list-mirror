Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2D86201A7
	for <e@80x24.org>; Fri, 12 May 2017 22:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756394AbdELWby (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 18:31:54 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34831 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbdELWbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 18:31:53 -0400
Received: by mail-io0-f193.google.com with SMTP id o12so6997069iod.2
        for <git@vger.kernel.org>; Fri, 12 May 2017 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CyXaa3M+0hmCSTuxWE6KfTmFGP6qpx9miY8UzQMuNbg=;
        b=Py7DRcvM4B31Dv75ivssMbFz2R5mZmU+c2pntsNHNXT3uM2H35CQpYMAcgfs8ZOCEy
         0jHzWOyIXXGxyUPVVz9z0HTbzTCvAFEx0/prunmgxXaf9mNFFIKsFC9QkOl9F93zfp4l
         QZ/WmplQK2PK83wGnjUGuQpW2crZ39WoFxA54Pe7uUhvbuKODh/MsntPeKQ++5+KJOr8
         3hgXq0L44JwN5pr5zf+1xJ6Dp5qtJb+SDibuluDxMD2LqI5DTkbRH/nIgVQRFf13zuDt
         jIEQ4Z9Ttqb0SwJbi65CyLqWFLZB/kNK439OXyUB1V2jkgS3Lo6/H+8utkUiGclYxijE
         JE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CyXaa3M+0hmCSTuxWE6KfTmFGP6qpx9miY8UzQMuNbg=;
        b=QRnN822NhmWW+xnffN4pOn1KX/6S1/pfPdcYrwFI+E635CfJ90yXyoAMCAwaMbJtUj
         Z+TO4sqaW/r+Ts6pBOZ893FRhbUxISOn5G5APzJDLMTKv0RChN0BIgI2N+YtHbpZ0B0T
         3l3gJm5RG2maq4dwUe29x6uacQJjkUCygG69N8GJeAgDSvOlv6Li2Fi2PP/1KBTU9zoV
         oBy9u6/0mRuL6NH2RP8Z1ZlaepOySr0fLhTLnFASHR2NF440WWYSybiR86XKmSCUMn8D
         XsKHOf7w3A/Yx1lMeAKT59VOobSk366B+foBFmTElMpHxOapUP7KW83Pg8f8PKng083R
         KPoQ==
X-Gm-Message-State: AODbwcAF5kFoJSq1ecO9xM7LLSLluAXu0uewz07/dpSRkphFAzo/oJ5K
        qfGKsHq7Ut4tcXzlnfcwQNf1KDxqFg==
X-Received: by 10.107.138.21 with SMTP id m21mr6348097iod.80.1494628312358;
 Fri, 12 May 2017 15:31:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 12 May 2017 15:31:31 -0700 (PDT)
In-Reply-To: <20170512203436.fcoqauphzvox2sgv@sigill.intra.peff.net>
References: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
 <20170512203436.fcoqauphzvox2sgv@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 13 May 2017 00:31:31 +0200
Message-ID: <CACBZZX5rasExB9jN0RmZ9zcSTbc9qOEZ2VoqRFt8C09vW9mkfQ@mail.gmail.com>
Subject: Re: [PATCH] config: complain about --local outside of a git repo
To:     Jeff King <peff@peff.net>
Cc:     Josh Hagins <hagins.josh@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 12, 2017 at 10:34 PM, Jeff King <peff@peff.net> wrote:
> On Fri, May 12, 2017 at 10:19:59AM -0400, Josh Hagins wrote:
>
>> Since upgrading to Git 2.13.0 I'm seeing this error message whenever
>> `git config --local <whatever>` is called outside a Git repository.
>> For example, note the difference in behavior between Git 2.13 and
>> Apple Git:
>>
>>     $ pwd
>>     /Users/jhagins
>>     $ /usr/bin/git --version
>>     git version 2.11.0 (Apple Git-81)
>>     $ /usr/bin/git config --local --get user.name
>>     $ /usr/local/bin/git --version
>>     git version 2.13.0
>>     $ /usr/local/bin/git config --local --get user.name
>>     fatal: BUG: setup_git_env called without repository
>>
>> Apple Git outputs nothing, as expected. The summarized release notes
>> published by GitHub specifically mentioned that instances of this
>> error message should be reported, so here you go!
>
> Thanks for reporting. All the developers have been running with this
> change for months, but I knew as soon as it was released into the wild
> that somebody would find a new corner case. :)
>
> I think dying is the right thing here; you are asking for "--local" but
> there is no local repository. But we should never hit a BUG assertion.
> Patch is below.
>
> I'm not sure exactly what you wanted to accomplish with --local. If you
> just want to know if user.name is set anywhere (and you may or may not
> be in a git repo), then just "git config --get user.name" would work. If
> you want to know if you're in a local repo and if so whether the
> variable is set, you'd need to use two commands, like:
>
>   git rev-parse --git-dir >/dev/null 2>&1 &&
>   git config --local --get user.name
>
> -- >8 --
> Subject: [PATCH] config: complain about --local outside of a git repo
>
> The "--local" option instructs git-config to read or modify
> the repository-level config. This doesn't make any sense if
> you're not actually in a repository.
>
> Older versions of Git would blindly try to read or write
> ".git/config". For reading, this would result in a quiet
> failure, since there was no config to read (and thus no
> matching config value). Writing would generally fail
> noisily, since ".git" was unlikely to exist. But since
> b1ef400ee (setup_git_env: avoid blind fall-back to ".git",
> 2016-10-20), we catch this in the call to git_pathdup() and
> die("BUG").
>
> Dying is the right thing to do, but we should catch the
> problem early and give a more human-friendly error message.
>
> Note that even without --local, git-config will sometimes
> default to using local repository config. These cases are
> already protected by a similar check.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/config.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index 3a554ad50..ad7c6a19c 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -496,6 +496,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>                 usage_with_options(builtin_config_usage, builtin_config_options);
>         }
>
> +       if (use_local_config && nongit)
> +               die(_("--local only be used inside a git repository"));
> +
>         if (given_config_source.file &&
>                         !strcmp(given_config_source.file, "-")) {
>                 given_config_source.file = NULL;
> --
> 2.13.0.452.g0afc8e12b

It would be better to have a test for edge cases that are currently
only being discovered by users in the wild.
