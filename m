From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v7 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 11 Mar 2016 12:51:51 +0800
Message-ID: <CACRoPnRESpiNL_=rEgw7kRdKjek8Z=qVjPH=BEWsWeYn22YryQ@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457497100-13045-1-git-send-email-mehul.jain2029@gmail.com>
	<1457497100-13045-2-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 05:52:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeF3P-0007FU-Pp
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 05:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbcCKEvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 23:51:54 -0500
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34388 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbcCKEvx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 23:51:53 -0500
Received: by mail-lb0-f169.google.com with SMTP id xr8so135643317lbb.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 20:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=B82tYcGwJ4LvmWPlRZoIeKDth4P7JkHD/YOCBq90BRE=;
        b=KHyBN6YJuckyYkB61z5qimGY2PWubqrcO8YKsNUrrVtPZcOh3Vy3Zp4Bcjh58D7YCP
         lrK/Im5P+HFE0mdXO44QSbWohAUgdRiBMTJHhCUzPW0WCzGH06yhROpau4loArOnBm6S
         oZrQYBWwMMoOPqsYJi5za64exbfkNxpJ3LFeXVbv3WuiImfbTUDg27Q97/3O6mkQIeN0
         u7SPlyBysG0Oh2Ush/HLufGnZ+bJ1ewDCQO5qAifnXNk4TtTzTJcutsVwZX8kP3dK2Et
         EGZm2EohinOFrM8C4bAN3NKAemqhvoo6FcIX9lOymnGDI4X3lXSPmr9pcX3Znm0nbvfY
         /vhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=B82tYcGwJ4LvmWPlRZoIeKDth4P7JkHD/YOCBq90BRE=;
        b=ThZNMXUqQlXW6hYQJlKCP4vVMIDm6VvYEc1kU4FZ3889vkzhgtV2WgAnOcdH85FsTv
         7NgUS+98iGZ7K+iVDPEx6qLe8CVSqVvTm9mDAo/AF6zKsP03iqsE9RVlDEWu5BdmXfSr
         frUQMx1nPDGgZaTCqgco9CdFnsePQIlQ53b1yX28Xev6IDe4aUzhEeJdstc7ykpjJsrO
         wGs1XHSFUP68EO9BfYMhxHgS9LQ+IjfqS17OGnDGyAOyxrfh/ETLbOfgkjt7BDICaQSk
         nR85JTqeg4vyDNIV7UdeWem7AGYlVqR8wJVF26RyPMh+w0CI+q9pQ3n/IRx27lnvw7R6
         q0sg==
X-Gm-Message-State: AD7BkJKU5QjbqLBjf4odh7r1VGXchvzK6k1SN4Xz+DbKvVyRsqSnKgh7tl9YDihPiN5A7eKnGiYB/dy0QmiRZw==
X-Received: by 10.112.63.200 with SMTP id i8mr2403418lbs.5.1457671912060; Thu,
 10 Mar 2016 20:51:52 -0800 (PST)
Received: by 10.112.207.74 with HTTP; Thu, 10 Mar 2016 20:51:51 -0800 (PST)
In-Reply-To: <1457497100-13045-2-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288672>

On Wed, Mar 9, 2016 at 12:18 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> If rebase.autoStash configuration variable is set, there is no way to
> override it for "git pull --rebase" from the command line.
>
> Teach "git pull --rebase" the --[no-]autostash command line flag which
> overrides the current value of rebase.autoStash, if set. As "git rebase"
> understands the --[no-]autostash option, it's just a matter of passing
> the option to underlying "git rebase" when "git pull --rebase" is called.
>
> Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Paul Tan <pyokagan@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
> Previous patches: $gname287709
>
> Changes:
>         - Slight change is documentation.
>
>  Documentation/git-pull.txt |  9 +++++++++
>  builtin/pull.c             | 16 ++++++++++++++--
>  t/t5520-pull.sh            | 39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index a62a2a6..da89be6 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -128,6 +128,15 @@ unless you have read linkgit:git-rebase[1] carefully.
>  --no-rebase::
>         Override earlier --rebase.
>
> +--autostash::
> +--no-autostash::
> +       Before starting rebase, stash local modifications away (see
> +       linkgit:git-stash.txt[1]) if needed, and apply the stash when
> +       done (this option is only valid when "--rebase" is used).
> ++
> +`--no-autostash` is useful to override the `rebase.autoStash`
> +configuration variable (see linkgit:git-config[1]).
> +
>  Options related to fetching
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 8a318e9..a01058a 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -86,6 +86,7 @@ static char *opt_commit;
>  static char *opt_edit;
>  static char *opt_ff;
>  static char *opt_verify_signatures;
> +static int opt_autostash = -1;
>  static int config_autostash = -1;

Hmm, why can't config_autostash just default to 0?

>  static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
>  static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
> @@ -150,6 +151,8 @@ static struct option pull_options[] = {
>         OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
>                 N_("verify that the named commit has a valid GPG signature"),
>                 PARSE_OPT_NOARG),
> +       OPT_BOOL(0, "autostash", &opt_autostash,
> +               N_("automatically stash/stash pop before and after rebase")),
>         OPT_PASSTHRU_ARGV('s', "strategy", &opt_strategies, N_("strategy"),
>                 N_("merge strategy to use"),
>                 0),
> @@ -801,6 +804,10 @@ static int run_rebase(const unsigned char *curr_head,
>         argv_array_pushv(&args, opt_strategy_opts.argv);
>         if (opt_gpg_sign)
>                 argv_array_push(&args, opt_gpg_sign);
> +       if (opt_autostash == 1)
> +               argv_array_push(&args, "--autostash");
> +       else if (opt_autostash == 0)
> +               argv_array_push(&args, "--no-autostash");

The precise testing for specific values of -1, 0 and 1 throughout the
code makes me uncomfortable. Ordinarily, I would expect a simple

    argv_array_push(&args, opt_autostash ? "--autostash" : "--no-autostash");

Stepping back a bit, the only reason why we introduced opt_autostash =
-1 as a possible value is because we need to detect if
--[no-]autostash is being used with git-merge. I consider that a
kludge, because if git-merge supports --autostash as well (possibly in
the future), then we will not need this -1 value.

So, from that point of view, a -1 value is okay as a workaround, but
kludges, and hence the -1 value, should be gotten rid off as soon as
possible.

>
>         argv_array_push(&args, "--onto");
>         argv_array_push(&args, sha1_to_hex(merge_head));
> @@ -851,12 +858,17 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                 if (is_null_sha1(orig_head) && !is_cache_unborn())
>                         die(_("Updating an unborn branch with changes added to the index."));
>
> -               if (config_autostash != 1)
> +               if (opt_autostash == -1)
> +                       opt_autostash = config_autostash;

So, if config_autostash defaults to zero, we can be certain that
opt_autostash will be either true or false.

> +
> +               if (opt_autostash != 1)

And then we can do if (!opt_autostash) here, instead of making readers
wonder why we are testing for the value "1" specifically.

>                         die_on_unclean_work_tree(prefix);
>
>                 if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
>                         hashclr(rebase_fork_point);
> -       }
> +       } else
> +               if (opt_autostash != -1)
> +                        die(_("--[no-]autostash option is only valid with --rebase."));
>
>         if (run_fetch(repo, refspecs))
>                 return 1;

Thanks,
Paul
