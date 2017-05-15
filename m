Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31FBB201A4
	for <e@80x24.org>; Mon, 15 May 2017 00:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbdEOAc1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 20:32:27 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33156 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752849AbdEOAc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 20:32:26 -0400
Received: by mail-it0-f66.google.com with SMTP id l145so9805400ita.0
        for <git@vger.kernel.org>; Sun, 14 May 2017 17:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7OCp4VfVwXmNdHrYdTMqmC+6bBqQ4zDvg2s6PdRgScY=;
        b=rwwPLVxlpoD5krrPObw2BmG88dHLqccIhxo53S1H6zi13F1FyjwxKQZv9KjnRnxQpX
         ERJrPut0MXpS8+hyK8g8cv3rHvkgzZwuNyN5HBTIfqTJzbhroTrP0zgZQkkEq7ehlsfX
         BJfheluVNugma95odMfx80VdV1yRWu4arGHwVeYLhXzUfx8kLWDV4a6tBf0H6tokhlBh
         H/tA7PCQIccDsyFreiuJ3owbcVXjzvFSp05CMc2a9slPDdyYcm4/cWpZoabt5f81C+hr
         0Y78P7caJziQNzT66YO1P07wu09Yw/Slrf4cRurvfXqSTEaHm4LFLcooqbZMz69hDqEQ
         UdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7OCp4VfVwXmNdHrYdTMqmC+6bBqQ4zDvg2s6PdRgScY=;
        b=UmGnIsJEjmqkHrLr5FRNvNLjXlzmmSsS+nIEHNNc2tDTutz3zNtY0IzF3dVHHJLkJ9
         0UqGtAgbzNOmDFppqGQiJjU6kqApl5sJ4pHWOrwBFGicJetVnZnKpKvlhWHCK7x3vOk9
         ihehXKTNsHFTXEzGLi3LSN+JyGscpMOap3jZ1ZGHUb8KeYHWxaDKYnn1sGU6FKKCxtd2
         shOy22EvgVUzu6V9k88LE8M0V1wWL9mUIay0XmdgJMasHoo52P7knJKhMOr9xqpzbvR2
         KxjFuvarMVvYwPUUGTqugwjqJjd50uoGZwMCUxqGTTJKx2CS/0V+LSBFbji71AAeCabG
         OmHw==
X-Gm-Message-State: AODbwcCnBpVjQ5Exifc0iYEwwB7zk0OOmAAa9UxRDAMubxbUFJ8BQwX2
        za0U6CJyWL2/CkuUeosuvzGZ85ZnWg==
X-Received: by 10.36.233.66 with SMTP id f63mr3205809ith.46.1494808345156;
 Sun, 14 May 2017 17:32:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.38.6 with HTTP; Sun, 14 May 2017 17:31:54 -0700 (PDT)
In-Reply-To: <20170512203436.fcoqauphzvox2sgv@sigill.intra.peff.net>
References: <CANuW5x0pBwfQeha50mxN8pVQKm67u_b3UKTCQ8ZbJA6FUGvYbw@mail.gmail.com>
 <20170512203436.fcoqauphzvox2sgv@sigill.intra.peff.net>
From:   Josh Hagins <hagins.josh@gmail.com>
Date:   Sun, 14 May 2017 20:31:54 -0400
Message-ID: <CANuW5x2-gzHuPN9ox8hEgNUiTsEKeAqeZQXZZ=SMFbsfabXd1w@mail.gmail.com>
Subject: Re: [PATCH] config: complain about --local outside of a git repo
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

For context, the "user.name" bit was purely notional; I just wanted to
give a sample reproduction. Where I've actually been running into this
in real life is with oh-my-git, a GitHub-themed Powerline bash prompt:
https://github.com/arialdomartini/oh-my-git/blob/42c11f08540949b75bd513e6880a4ce6824a2bcc/base.sh#L52.

Since this command is invoked every time the prompt is build, I see
the error message after every single command I run outside of a Git
repository. While this is more indicative of a code smell in
oh-my-git, I figured that, as you said, BUG assertions should never
get hit in the wild. Thanks for the patch!

Cheers,
Josh

On Fri, May 12, 2017 at 4:34 PM, Jeff King <peff@peff.net> wrote:
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
>



-- 
Josh Hagins
