From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 2/2] commit: add a commit.verbose config variable
Date: Sat, 19 Mar 2016 23:56:48 -0400
Message-ID: <CAPig+cShT2aPkoRK0pXPzbRbQqCU+O5uEqEr4oMkZ8LTwREaAA@mail.gmail.com>
References: <010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
	<010201538b98aaa4-ad08c159-4935-48f1-acdb-7c376da2c368-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 04:57:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahUUO-0004hM-OD
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 04:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015AbcCTD4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2016 23:56:50 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34347 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932953AbcCTD4t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2016 23:56:49 -0400
Received: by mail-vk0-f65.google.com with SMTP id e6so13253069vkh.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2016 20:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=RxhL6McYwjs2YzGQvO+FBbR6TnHD6xX2GGolyDMfm4Q=;
        b=oQfKvUYovxKcY7OX5Jzg9pE3ZnQu++0PWOogjeRau7cY6x77px3cdmtDWJMLCEab5v
         GYPE4txQ+DwRJ3dUtjmDx9HrTQxBrL0eRHx3CrQ1LvaYsT1if0aZ3A7FAFPpqP7ltc2K
         LsJqOuLdmmEL07TPhyPxA4nh4bXHyx+YhVQ3fMHz6F39v58fNOlN7duCNu60hhiNyrf/
         tYX3oD05lnULbazLmAibSyLz6KngN/O1sSH3Y49gIKJ8p/tsa00vYP7H7n2yf+QouAF3
         KcwX0UB8XPUpAYnoxy7tfxHlQ0qjYA0alKFPeEWi2PyqwmIA5r8rweiNoQHmfLChisbr
         lA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RxhL6McYwjs2YzGQvO+FBbR6TnHD6xX2GGolyDMfm4Q=;
        b=NE9NlcLfo/wQ8zniVrgNVe1a/j9kdTrwhEF77BIP2pdZPZIErJy4ErthTVKEBHo3GX
         HJCg1uIidHi/ItGT0Qp/U4X7VerDgtgo7KBfZpcQ1ws1kamrA0BEFHyhC602wwr0C05Q
         aFw20QLYiXpac0Pi7ejVXHNIgkVwhRjupsETto+DLT67oa1vGp64E1poVkS34fJwq/fz
         O8vtLvoVSlDCPn67m/su7/djtgUZXs0lV6OjRlV+qoWPDxCS8WCxjxv760uVkKwAGruS
         MXxIFyERc2VcPYmd9guCqC+7I1pG6vYk5PDTHUXLOcjlX1TkvUm3vZX1Vjc49Zhm9DQi
         RJfg==
X-Gm-Message-State: AD7BkJJ+gpsdYZ+QDZcPiQ4cdh5dXC+OB3THa82DN3GQ4DK2anlMSpV8XVi/8LyqDYd1QCsgo9eIIUGH1Ds+kw==
X-Received: by 10.31.47.135 with SMTP id v129mr26020685vkv.115.1458446208645;
 Sat, 19 Mar 2016 20:56:48 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sat, 19 Mar 2016 20:56:48 -0700 (PDT)
In-Reply-To: <010201538b98aaa4-ad08c159-4935-48f1-acdb-7c376da2c368-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: bFjkIOJSeS8-c27_ObIHPaHnMxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289329>

On Fri, Mar 18, 2016 at 5:19 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Add commit.verbose configuration variable as a convenience for those
> who always prefer --verbose.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/commit.c b/builtin/commit.c
> @@ -1654,6 +1661,14 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> +       if (verbose < 0) {
> +               if (config_verbose > -1)
> +                       verbose = config_verbose;
> +               else
> +                       verbose = 0;
> +       }

I think it's more common in this codebase to compare against -1
directly rather than <0, so:

    if (verbose == -1) {
        if (config_verbose != -1)
            verbose = config_verbose;
        else
            verbose = 0;
    }

Or, this might be easier to read:

    if (verbose == -1)
        verbose = config_verbose;

    if (verbose == -1)
        verbose = 0;

But, this likely isn't better:

    if (verbose == -1)
        verbose = config_verbose == -1 ? 0 : config_verbose;

Anyhow, probably not worth a re-roll.

> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> @@ -96,4 +96,59 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
> +test_expect_success 'commit.verbose true and --verbose' '
> +       (
> +               GIT_EDITOR=cat &&
> +               export GIT_EDITOR &&
> +               git -c commit.verbose=true commit --amend --verbose

Easier would be to write this as:

    GIT_EDITOR=cat git -c commit.verbose=true commit --amend --verbose

and then you wouldn't need the subhsell.

However, more intuitive would probably be to create another "editor"
similar to the 'check-for-diff' editor this script already uses. (The
'check-for-diff' editor is an obvious example about how to go about
such an undertaking.) You would need to invoke 'test_set_editor' in a
subshell for this particular test in order to avoid clobbering the
global editor used by this script. Or, have a preparatory patch which
ditches the global setting of the editor and has each test invoke
'test_set_editor' as needed (and only if needed).

Same comments apply to the other new tests which use a custom "editor".

> +       ) &&
> +       grep "^diff --git" .git/COMMIT_EDITMSG >out &&
> +       wc -l out | grep "1"
> +'
> +
> +test_expect_success 'commit.verbose true and -v -v' '
> +       (
> +               GIT_EDITOR=cat &&
> +               export GIT_EDITOR &&
> +               git -c commit.verbose=true commit --amend -v -v
> +       ) &&
> +       grep "# Changes not staged for commit" .git/COMMIT_EDITMSG >out &&
> +       wc -l out | grep "2"
> +'
> +
> +test_expect_success 'commit.verbose true and --no-verbose' '
> +       test_must_fail git -c commit.verbose=true commit --amend --no-verbose
> +'
> +
> +test_expect_success 'commit.verbose false and --verbose' '
> +       git -c commit.verbose=false commit --amend --verbose
> +'
> +
> +test_expect_success 'commit.verbose false and -v -v' '
> +       (
> +               GIT_EDITOR=cat &&
> +               export GIT_EDITOR &&
> +               git -c commit.verbose=false commit --amend -v -v
> +       ) &&
> +       grep "# Changes not staged for commit" .git/COMMIT_EDITMSG >out &&
> +       wc -l out | grep "2"
> +'
> +
> +test_expect_success 'commit.verbose false and --verbose omitted' '
> +       test_must_fail git -c commit.verbose=false commit --amend
> +'
> +
> +test_expect_success 'commit.verbose false and --no-verbose' '
> +       test_must_fail git -c commit.verbose=false commit --amend --no-verbose
> +'
> +
> +test_expect_success 'status ignores commit.verbose=true' '
> +       git -c commit.verbose=true status >actual &&
> +       ! grep "^diff --git" actual
> +'
> +
>  test_done
