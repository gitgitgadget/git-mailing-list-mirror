From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 2/2] pull --rebase: add --[no-]autostash flag
Date: Fri, 18 Mar 2016 00:24:13 -0400
Message-ID: <CAPig+cQHbGAB=XCVWtC1MuubWUFc0tT-+ZGD+hW18whJP_U0_Q@mail.gmail.com>
References: <1458233370-8343-1-git-send-email-mehul.jain2029@gmail.com>
	<1458233370-8343-2-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 05:24:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aglxU-0006tS-9A
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 05:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbcCREYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 00:24:16 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33883 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbcCREYO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 00:24:14 -0400
Received: by mail-vk0-f65.google.com with SMTP id e6so8611829vkh.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 21:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=k6D42RIXbZ7IhLH8vcR2t8tJBHFz+nkb5zbyvgzTocM=;
        b=R0U1Wmy/u32dTdcDEBZXkw8lzCRZnZc99/PFurNlPTqW6dP74ENiEABlEZNNY4eOTz
         aYVo1893QLyH4DJMnIX55k67By912W9n0lKN/kfhIunJAeeLs7yYMgffzZVcySwhR+1f
         m1AjhsuSFoEu1jFIiQ5KJlVmWzIBwIA8vojMj0USQXUkSztzUyhHcoT/lAWJUVcGIAO7
         IaE4FJfsFXRHwxM/6rpoAZYSeB3hQbR3eMFDPl+dMSUJ+HcAGbjeXnfi/YL0O/P5z+tj
         meOc74MYQNwpHlOvz9wIOQODY5gvIFj0kyUr+4pCu0eWZBpMpZpqPgYDgKfKXUseqWrE
         SXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=k6D42RIXbZ7IhLH8vcR2t8tJBHFz+nkb5zbyvgzTocM=;
        b=jqRI0TDTtlrHKsTFxN7sYPw5TeRY4RNHljxqBt/wdFIKE4Pfp/PqtUhTx8dt8e5Psd
         kyTc9LLNzr+/rX6JLmlfx0B6RbrZCiDbWr3i6mkqtyE6BBCENy8XbXLFKp+ohHKNXU1G
         GM6DCXXLYOIRGXbErYOEAGVmsUuvZ0mADYoP3RxSE5jRkECZ/eUcfWbQr22DOhMM/Cbj
         wdGqxB1ayhku3y/GCBmtfRyy5Glx3c+tAnoC9d6mYD361QRBnHvJx786ePuVd+EwKOda
         3OBLZmTJycmNKhinfObtSNv7mcUeOhzb4goY/pkrzgwi7GAAFcbM1ASFLsSpeDXwPz3U
         hoTg==
X-Gm-Message-State: AD7BkJK43UYyvypkHKulLVfNfg7mJhm3uU2qAoBYSrzSCPb2UTycGYiiXFKX1TMe61toEJyxD1PRLSVLDODyVA==
X-Received: by 10.31.47.135 with SMTP id v129mr15296435vkv.115.1458275053175;
 Thu, 17 Mar 2016 21:24:13 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 17 Mar 2016 21:24:13 -0700 (PDT)
In-Reply-To: <1458233370-8343-2-git-send-email-mehul.jain2029@gmail.com>
X-Google-Sender-Auth: ljV3_PZKpGJ-H4WuJhbeXIOMWvw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289181>

On Thu, Mar 17, 2016 at 12:49 PM, Mehul Jain <mehul.jain2029@gmail.com> wrote:
> If rebase.autoStash configuration variable is set, there is no way to
> override it for "git pull --rebase" from the command line.
>
> Teach "git pull --rebase" the --[no-]autostash command line flag which
> overrides the current value of rebase.autoStash, if set. As "git rebase"
> understands the --[no-]autostash option, it's just a matter of passing
> the option to underlying "git rebase" when "git pull --rebase" is called.
>
> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
> previous patches: http://thread.gmane.org/gmane.comp.version-control.git/287709
>
> Changes:
>         * Modified documentation

This would be more helpful for reviewers if it went into a bit more
detail; "modified" alone doesn't say much. For instance, "... to keep
the description of --autostash and --no-autostash together rather than
splitting them apart with a tangential comment" or something.

>         * "git pull --[no-]autostash" case is handled bit early then before

Likewise, explaining why it's handled a bit earlier would help
reviewers. For instance, "... since getting the error handling case
out of the way early makes the following code easier to reason about"
or something.

Since this is now a patch series rather than a single patch, another
way to help reviewers is to use a cover letter (see git-format-patch
--cover-letter) where you'd explain the changes, and, importantly,
include an interdiff between the previous and current versions.

> diff --git a/builtin/pull.c b/builtin/pull.c
> @@ -86,6 +86,7 @@ static char *opt_commit;
> +static int opt_autostash = -1;
> @@ -801,6 +804,7 @@ static int run_rebase(const unsigned char *curr_head,
>         argv_array_pushv(&args, opt_strategy_opts.argv);
>         if (opt_gpg_sign)
>                 argv_array_push(&args, opt_gpg_sign);
> +       argv_array_push(&args, opt_autostash ? "--autostash" : "--no-autostash");

At this point, we know that opt_autostash can't be -1 (thus
incorrectly triggering use of --autostash) because the conditional in
cmd_pull() set it to the value of config_autostash (either 0 or 1) if
the user did not specify it on the command-line. Okay. Makes sense.

Would an assert(opt_autostash != -1) to document this be desirable? (I
don't feel strongly about it, and it's certainly not worth a re-roll.)

>         argv_array_push(&args, "--onto");
>         argv_array_push(&args, sha1_to_hex(merge_head));
> @@ -846,11 +850,17 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>         if (get_sha1("HEAD", orig_head))
>                 hashclr(orig_head);
>
> +       if (!opt_rebase && opt_autostash != -1)
> +               die(_("--[no-]autostash option is only valid with --rebase."));
> +
>         if (opt_rebase) {
>                 if (is_null_sha1(orig_head) && !is_cache_unborn())
>                         die(_("Updating an unborn branch with changes added to the index."));
>
> -               if (!config_autostash)
> +               if (opt_autostash == -1)
> +                       opt_autostash = config_autostash;
> +
> +               if (!opt_autostash)
>                         die_on_unclean_work_tree(prefix);
>
>                 if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index c952d5e..85d9bea 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -255,6 +255,45 @@ test_expect_success 'pull --rebase succeeds with dirty working directory and reb
>         test "$(cat new_file)" = dirty &&
>         test "$(cat file)" = "modified again"
>  '
> +test_expect_success 'pull --rebase: --autostash overrides rebase.autostash' '

Why do titles of some of the new test titles have a ":" after "rebase"
while other don't?

Also, how about normalizing the titles so that the reader knows in
which tests rebase.autostash is 'true' and in which it is 'false'?
Presently, it's difficult to decipher what's being tested based only
on the titles.

Finally, shouldn't you also be testing --autostash and --no-autostash
when rebase.autostash is not set?

> +       test_config rebase.autostash false &&
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       git pull --rebase --autostash . copy &&
> +       test_cmp_rev HEAD^ copy &&
> +       test "$(cat new_file)" = dirty &&
> +       test "$(cat file)" = "modified again"
> +'
> +
> +test_expect_success 'pull --rebase --autostash works with rebase.autostash set true' '
> +       test_config rebase.autostash true &&
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       git pull --rebase --autostash . copy &&
> +       test_cmp_rev HEAD^ copy &&
> +       test "$(cat new_file)" = dirty &&
> +       test "$(cat file)" = "modified again"
> +'
> +
> +test_expect_success 'pull --rebase: --no-autostash overrides rebase.autostash' '
> +       test_config rebase.autostash true &&
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
> +       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
> +'
> +
> +test_expect_success 'pull --rebase --no-autostash works with rebase.autostash set false' '
> +       test_config rebase.autostash false &&
> +       git reset --hard before-rebase &&
> +       echo dirty >new_file &&
> +       git add new_file &&
> +       test_must_fail git pull --rebase --no-autostash . copy 2>err &&
> +       test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
> +'
