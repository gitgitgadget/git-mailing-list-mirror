From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] pull --rebase: add --[no-]autostash flag
Date: Tue, 15 Mar 2016 17:43:27 -0400
Message-ID: <CAPig+cSnp+NsBAMib4pExKCLB5ocGsHWyO7qMU0E91WqE6a5_g@mail.gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1458061904-26516-1-git-send-email-mehul.jain2029@gmail.com>
	<1458061904-26516-2-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 22:43:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afwkX-0007BC-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 22:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752722AbcCOVn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 17:43:29 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33972 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbcCOVn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 17:43:28 -0400
Received: by mail-vk0-f51.google.com with SMTP id e185so38694039vkb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=4IB/sKZG4Mb0i36SwcfnMK4PfBJfo7VopeumIzNlS7o=;
        b=xev8NhSCvdbjpjGt5Ojx2OglxdyxkY+yshTMG8EXjl9Ky4KOyzveI8JPiBYqpEa2jj
         /NvFBbOHu8h9jDZDEDJrMP2EQNdMagsx6HhY1NbfMMd8d3jSesuwSB0BjPy/xZ7gmpzV
         OICX+fBV9rpkWQoTxxfjeLLqBtqEpDgCYHMNrttAGwQPGpBxwfCjrrjO/hXMylgAtRLy
         5b3+RHtrd64PJiDP6z/kFno8xpfvqjFdMZ8WJkn9/1yimV+oDPEsMQ+jqtjdh3h4TzzH
         P0xao7BpVmDR++kFHeeewaV1seZ1192q6633OLL8gKaGZ1AbI5sYrxNYJZ5pImTVmEQ9
         o8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4IB/sKZG4Mb0i36SwcfnMK4PfBJfo7VopeumIzNlS7o=;
        b=CsF6pgOKTrS5/llcQgQJKBKKkHXTq40aeQ9b6OQDT5FL1eeqoJOSjQ/HUPpm6AIAw/
         CXcYrBsyA0wz1nc4iS23Gup3N/SztTWPlAEB9BhrFY0ZEVdnobA5cm9rSMGcEnAyeJsq
         421h6e3vCNIaKI35fzD+3g5UVl+mcO6xQS/VCUhjj1n+w6qhySEo5KNudlPwwnv1G2Wa
         s+ByY7EvcV0FAyy6Ea91r83DH57Nfrxak6KvLAjyOxk8K9NL+Nb1JU8FvL8OqevSESzm
         YwLInP66+JSBsimrytEX93BLHsxceAE1PyEEsIyIMeqOba/JENEsej2KcKm/5AVsaRRF
         aGow==
X-Gm-Message-State: AD7BkJLVLosdsOLdxt98grVaNWcaJfl/ptLzD6jRPFdUsBAorNH4hNvlDz2UoLJFtXfGx2JHn/fcWndZhedvlA==
X-Received: by 10.31.8.142 with SMTP id 136mr435797vki.14.1458078207439; Tue,
 15 Mar 2016 14:43:27 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 15 Mar 2016 14:43:27 -0700 (PDT)
In-Reply-To: <1458061904-26516-2-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: n8qcgXQvqNNxyE9ulQwSrJQB5j0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288919>

On Tue, Mar 15, 2016 at 1:11 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> If rebase.autoStash configuration variable is set, there is no way to
> override it for "git pull --rebase" from the command line.
>
> Teach "git pull --rebase" the --[no-]autostash command line flag which
> overrides the current value of rebase.autoStash, if set. As "git rebase"
> understands the --[no-]autostash option, it's just a matter of passing
> the option to underlying "git rebase" when "git pull --rebase" is called.

The below comments may or may not be worth a re-roll (you decide)...

> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> @@ -128,6 +128,15 @@ unless you have read linkgit:git-rebase[1] carefully.
> +--autostash::
> +--no-autostash::
> +       Before starting rebase, stash local modifications away (see
> +       linkgit:git-stash.txt[1]) if needed, and apply the stash when
> +       done (this option is only valid when "--rebase" is used).
> ++
> +`--no-autostash` is useful to override the `rebase.autoStash`
> +configuration variable (see linkgit:git-config[1]).

The last couple sentences seem reversed. It feels odd to have the bit
about --rebase dropped dead in the middle of the description of
--autostash and --no-autostash. I'd have expected to see --autostash
and --no-autostash discussed together, and then, as a follow-on,
mention them being valid only with --rebase.

> diff --git a/builtin/pull.c b/builtin/pull.c
> @@ -851,12 +855,17 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                 if (is_null_sha1(orig_head) && !is_cache_unborn())
>                         die(_("Updating an unborn branch with changes added to the index."));
>
> -               if (config_autostash)
> +               if (opt_autostash == -1)

In patch 1/2, this changed from 'if (autostash)' to 'if
(config_autostash)'; it's a bit sad that patch 2/2 then has to touch
the same code to change it yet again, this time to 'if
(opt_autostash)'. Have you tried just keeping the original 'autostash'
variable and modifying its value based upon config_autostash and
opt_autostash instead? (Not saying that this would be better, but
interested in knowing if the result is as clean or cleaner or worse.)

> +                       opt_autostash = config_autostash;
> +
> +               if (!opt_autostash)
>                         die_on_unclean_work_tree(prefix);
>
>                 if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
>                         hashclr(rebase_fork_point);
> -       }
> +       } else
> +               if (opt_autostash != -1)
> +                        die(_("--[no-]autostash option is only valid with --rebase."));

How about formatting this as a normal 'else if'?

    } else if (opt_autostash != -1)

On the other hand, this error case hanging off the 'rebase'
conditional is somewhat more difficult to reason about than perhaps it
ought to be. It might be easier to see what's going on if you get the
error case out of the way early, and then handle the normal case. That
is, something like this:

    if (!opt_rebase && opt_autostash != -1)
        die(_("... is only valid with --rebase"));

    if (opt_rebase) {
        ...
    }

>         if (run_fetch(repo, refspecs))
>                 return 1;
