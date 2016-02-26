From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] git-commit: add a commit.verbose config variable
Date: Thu, 25 Feb 2016 22:00:51 -0500
Message-ID: <CAPig+cQE6ytRKFjqRRLrPHCYqJuf52NKvy8sZs8rX3t5_kDRVg@mail.gmail.com>
References: <56CFBF19.6040004@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Pranit Bauva <pranit.bauva@zoho.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 04:01:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ8eH-0006rE-Vr
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 04:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbcBZDAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 22:00:54 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33405 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbcBZDAx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 22:00:53 -0500
Received: by mail-vk0-f45.google.com with SMTP id k196so66776397vka.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 19:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ps7LpSMlFVqx4L0DkJZ0UN5re42I9H81y0CeVVSvACU=;
        b=VTZ2YGfX7MOcpqlY8wkvsumlyQEwR0srfiGelq/f/uzs5C6HL28w4eOaYlIfLT5V6s
         Sjabb43E3nfo5axk0f1ijlNBrzwknvPClt9FBDgSpQTmns13c4VgNNI4D51Mt1iHRp2x
         OKiQ9xsCVmGPKfO+MVPlNa5In2vCXAgONaCtT82EgcX3JFiWPIPzM8giTZifgSI9mk8K
         0JGbfbLK9YVIOUBlAiYnYnVQPdbrES7Jwwn+clqfXmBf8UMBHuwdmGKHg+dFdznOGLgU
         pU35oCd+gVAu7f81AdRbrnHGx4OsquQJipahe1U0zCs0gtGcLBr49/8Y52F4QO5SSCGn
         wl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ps7LpSMlFVqx4L0DkJZ0UN5re42I9H81y0CeVVSvACU=;
        b=SIT5X1rn53WZLw51Ic40q3Re+O8zspY5UT8tCh+vpB/ZlD13JOvbBVzvFAbtMTzowK
         X1pZXKXBMDs9RLO6nOW4g+vnAvDs4uqhXoIsRPuUTvBoEH5o6BmKcJYprpbcZ8nqJL3P
         VupaKSGq2UPXc1C4t/G+jjOm7QZY/WNkbxjTPnxGeA1jieu7qrgEA42p8KOCmp5ejBM5
         pzphJfCtUQatEszAIBpz2uv/DFjNVS0Q90GuNuh6Xkj8OLza0ZaH/07rxOMyUrh+/utc
         D+kgCNb9QqnualCuwYdrpsgEVUX+IhXn1AHdeBg7KvUklsZzs0/TJhsM+ar5WaS5M8kh
         sHAQ==
X-Gm-Message-State: AG10YOQNTgWjJ+Ap3GIdorN/egCsAsbIqLEUr6oZl64vZ0lAWgEucvOHwY0sIHi0iZpMYkInut77j9qdYECJNg==
X-Received: by 10.31.41.14 with SMTP id p14mr39910892vkp.151.1456455651985;
 Thu, 25 Feb 2016 19:00:51 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 25 Feb 2016 19:00:51 -0800 (PST)
In-Reply-To: <56CFBF19.6040004@zoho.com>
X-Google-Sender-Auth: qDb_Qwoms60ns-HjCiug5ZtTFIw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287534>

Thanks for the submission. Review comments below...

On Thu, Feb 25, 2016 at 9:57 PM, Pranit Bauva <pranit.bauva@zoho.com> wrote:
> From c273a02fc9cab9305cedf6e37422e257a1cc3b1e Mon Sep 17 00:00:00 2001
> From: Pranit Bauva <pranit.bauva@zoho.com>
> Date: Fri, 26 Feb 2016 07:14:18 +0530
> Subject: [PATCH/RFC] git-commit: add a commit.verbose config variable

Drop these four lines. The first is only meaningful in your
repository, and the rest are picked up automatically by git-am from
the email envelope.

> Since many people always run the command with this option, and would
> prefer not to use the argument again and again but instead specify it in
> some config file.

This seems like a sentence fragment. I suppose you meant it as a
continuation of the patch subject? Better would be to write a full
sentence instead so that the reader doesn't have to guess at its
meaning.

> The variable `verbose` is changed instead of `s.verbose` as the method
> run_status() updates the `s.verbose` with the value of `verbose`. So in
> this way the change is reflected in both of them.

Talking about this in the commit message misleads the reader into
thinking that there is some potential oddity going on where a careful
decision needs to be made about which variable to set, when that's not
in fact the case. The 'verbose' member of wt_status is just one
consumer of the "verbose" flag, not the sole consumer. Another
consumer is found in builtin/commit.c:cmd_commit():

    if (verbose ||
        cleanup_mode == CLEANUP_SCISSORS)
            wt_status_truncate_message_at_cut_line(&sb);

So, it would not be correct for the configuration ever to set only
wt_status::verbose.

Consequently, it would be better to drop this paragraph altogether
from the commit message, so as to avoid confusing readers.

> Signed-off-by: Pranit Bauva <pranit.bauva@zoho.com>
> ---
>
> Notes:
>     This is a patch for the microproject of GSOC 2016. I have done the change
>     under careful consideration of where to place the line. I have to yet write
>     the tests for this. I have explored the config API and I am currently going
>     through the tests part. I have run the test locally by manually checking.
>     I currently learning about the test suite. I will update this patch
>     with some tests in some time.

Some tests to consider:

* commit.verbose unset
* commit.verbose=true
* commit.verbose=false
* --verbose overrides commit.verbose
* --no-verbose overrides commit.verbose

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 01cca0a..f7e9c09 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1110,6 +1110,11 @@ commit.template::
>         "`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
>         specified user's home directory.
>
> +commit.verbose::
> +       A boolean to specify whether to always include the verbose option

It's nice to see a documentation update included in the patch.

> +       with git-config.

I guess you meant "git-commit".

> +       See linkgit:git-commit[1]

Nit: It wouldn't hurt to fold this line into the line above.

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> @@ -290,7 +290,8 @@ configuration variable documented in linkgit:git-config[1].
>         what changes the commit has.
>         Note that this diff output doesn't have its
>         lines prefixed with '#'. This diff will not be a part
> -       of the commit message.
> +       of the commit message. If this option is used always, it can
> +       be set in the git-config with the boolean variable `commit.verbose`.

You could probably replace this entire added sentence with the simpler:

    Also see the `commit.verbose` configuration variable.

>  If specified twice, show in addition the unified diff between
>  what would be committed and the worktree files, i.e. the unstaged
> diff --git a/builtin/commit.c b/builtin/commit.c
> index b3bd2d4..68080fe 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1644,6 +1644,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>         status_format = STATUS_FORMAT_NONE; /* Ignore status.short */
>         s.colopts = 0;
>
> +       git_config_get_bool("commit.verbose", &verbose);

I haven't fully digested builtin/commit.c, but the placement of this
new code seems suspect. My expectation would have been to see
git_commit_config() updated to recognize the new "commit.verbose"
variable. Am I missing something?

>         if (get_sha1("HEAD", sha1))
>                 current_head = NULL;
>         else {
> --
> 2.1.4
