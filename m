Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6D7C43334
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 11:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbiFDLR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 07:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiFDLR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 07:17:57 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F8B97
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 04:17:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a15so4872440wrh.2
        for <git@vger.kernel.org>; Sat, 04 Jun 2022 04:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TDDZdBALgkWOzZ4xtp2VK7EjGDIk4OZq9sKNIQpBOq0=;
        b=gFsdK+mtlP5Wi1Mx4NAFjkhVfcjnuVZufSnPyWiNNDdhvb3E79SUNludVQN1U+EMgM
         spjW1PSTQcFkS8CEevlO+ETrMwPOYgiOveOzmOMZgF7G6KJA8YR7VJBGZiEQ+qeyt3Rl
         AP6gMTT7mqdgKkE5efj4l2vZZ4/bqg9S6m3S9ed34YWRFQnBmT28QyDAoe9pdDwcYnRv
         OSFw71AVJrLG82cKri7TVS0PY65B9Rd1m8TGYSuUJnpQXTC7ee5SdKfzIxd1SFrQ+oJN
         XPtHpX4zZIQt0S+CLx+Q51y2Wx0EueXMXCtmtCFzyHiUdzRIoKkjGGyoT0xvN6nS+hPX
         P7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TDDZdBALgkWOzZ4xtp2VK7EjGDIk4OZq9sKNIQpBOq0=;
        b=qk+FAoOuPnl+YyLeoeVBSYKUrP6HN7wev4nC5GBjOMM9/+2n89TDAlyhKrighdxRIN
         m7yel3OkRA/LD6brUwSD/TMMM65a+1dpbNxyCptyFdSs/k8FvsC0/d0K7vfJrLYaEeSL
         rt5lgUFKK+8qrKua4SVm0YymZd4yVE1R5m+ZaUbEUXbEA1r1cDWCXwQOQOQ15Uf10By/
         meixDn5FjW7YqAUuv6IaatlWuQ2D6s4jb8sPFqNdqcYiXUAyZ2THvUOM6RJzXg/eUDbf
         wK0z7GsGoOQ0y1ljxpd0CjwhReKxyXFeOropSvW6MLuXol2n73msvt4HM0sEQbJTXdAz
         4PTQ==
X-Gm-Message-State: AOAM5334Y06FZaLNjPJmf8cW6N4HwkfSJf7exGG+tfwMkWk1H1PX2Hrl
        PZti3XptgL0SD1qsA9/B4zuAVwol4T1xKucP
X-Google-Smtp-Source: ABdhPJwaQ0Zh65Yof3FsKtWum3r9LakqnqVw733vMfAIoJK9+U0oqmXPESdqRgnzQU+C1EdVtLzUUg==
X-Received: by 2002:adf:fc01:0:b0:20c:ff9a:2c53 with SMTP id i1-20020adffc01000000b0020cff9a2c53mr12099464wrr.142.1654341470879;
        Sat, 04 Jun 2022 04:17:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4309000000b002102af52a2csm12493884wrq.9.2022.06.04.04.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 04:17:50 -0700 (PDT)
Message-Id: <pull.1242.v2.git.1654341469.gitgitgadget@gmail.com>
In-Reply-To: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
References: <pull.1242.git.1653556865.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 04 Jun 2022 11:17:45 +0000
Subject: [PATCH v2 0/4] Die preserve ggg
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Philip Oakley <philipoakley@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This [2] short series is a follow up to GitGitGadget "Update the die()
preserve-merges messages to help some users (PR #1155)" [1].

Since v1: Additional patch to translate the user facing die message. Bring
the --abort preclusion to the start of the if && condition for clarity.
Clarify that the pull.rebase config is complementary to this particular
'die'. Updates to the commit messages.

v0: The first patch is a tidy up of the --preserve option to highlight that
it is now Deleted, rather than Deprecated.

In response to Avar's comments that the former error message merely
'tantilised without telling' the user what to do, it became obvious that the
underling problem was that the user was unable to git rebase --abort which
was also fatal, when a preserve-rebase was in progress.

Thus the main update is to allow the rebase --abort command, even when a
--preserve is in progress, to proceed. The --abort code was unchanged by the
removal of the preserve option, as the resetting and clean up of internal
state is common to the other rebase options.

The user facing fatal message now simply advises to abort, or downgrade to a
version that has preserve-merges to complete the rebase.

The final patch highlights that some IDEs still allow the setting of the
preserve-merges option as a pull config setup.

Philip Oakly

[1] GitLore ref pull.1155.git.1645526016.gitgitgadget@gmail.com
https://lore.kernel.org/git/pull.1155.git.1645526016.gitgitgadget@gmail.com/

[2]
https://lore.kernel.org/git/pull.1242.git.1653556865.gitgitgadget@gmail.com/t/#u

Philip Oakley (4):
  rebase.c: state preserve-merges has been removed
  rebase: help users when dying with `preserve-merges`
  rebase: note `preserve` merges may be a pull config option
  rebase: translate a die(preserve-merges) message

 builtin/rebase.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)


base-commit: c4f0e309ae745751d08727f24e8ff55e56355755
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1242%2FPhilipOakley%2Fdie_preserve_ggg-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1242/PhilipOakley/die_preserve_ggg-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1242

Range-diff vs v1:

 1:  0a4c81d8caf ! 1:  d60ec67cb06 rebase.c: state preserve-merges has been removed
     @@ Commit message
          Since feebd2d256 (rebase: hide --preserve-merges option, 2019-10-18)
          this option is now removed as stated in the subsequent release notes.
      
     -    Fix the option tip.
     +    Fix and reflow the option tip.
      
          Signed-off-by: Philip Oakley <philipoakley@iee.email>
      
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       			parse_opt_interactive),
       		OPT_SET_INT_F('p', "preserve-merges", &preserve_merges_selected,
      -			      N_("(DEPRECATED) try to recreate merges instead of "
     -+			      N_("(REMOVED) try to recreate merges instead of "
     - 				 "ignoring them"),
     +-				 "ignoring them"),
     ++			      N_("(REMOVED) was: try to recreate merges "
     ++				 "instead of ignoring them"),
       			      1, PARSE_OPT_HIDDEN),
       		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
     + 		OPT_CALLBACK_F(0, "empty", &options, "{drop,keep,ask}",
 2:  d0fb5410594 ! 2:  47f27187529 rebase: help users when dying with `preserve-merges`
     @@ Metadata
       ## Commit message ##
          rebase: help users when dying with `preserve-merges`
      
     -    Git will die if a "rebase --preserve-merges" is in progress.
     -    Users cannot --quit, --abort or --continue the rebase.
     +    Git would die if a "rebase --preserve-merges" was in progress.
     +    Users could neither --quit, --abort, nor --continue the rebase.
      
          Make the `rebase --abort` option available to allow users to remove
          traces of any preserve-merges rebase, even if they had upgraded
          during a rebase.
      
     -    One trigger was an unexpectedly difficult to resolve conflict, as
     +    One trigger case was an unexpectedly difficult to resolve conflict, as
          reported on the `git-users` group.
          (https://groups.google.com/g/git-for-windows/c/3jMWbBlXXHM)
      
     -    Tell the user the options to resolve the problem manually.
     +    Other potential use-cases include git-experts using the portable
     +    'Git on a stick' to help users with an older git version.
      
          Signed-off-by: Philip Oakley <philipoakley@iee.email>
      
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       		strbuf_addf(&buf, "%s/rewritten", merge_dir());
      -		if (is_directory(buf.buf)) {
      -			die("`rebase -p` is no longer supported");
     -+		if (is_directory(buf.buf) && !(action == ACTION_ABORT)) {
     ++		if (!(action == ACTION_ABORT) && is_directory(buf.buf)) {
      +			die("`rebase --preserve-merges` (-p) is no longer supported.\n"
      +			"Use `git rebase --abort` to terminate current rebase.\n"
     -+			"Or downgrade to v2.33, or earlier, to complete the rebase.\n");
     ++			"Or downgrade to v2.33, or earlier, to complete the rebase.");
       		} else {
       			strbuf_reset(&buf);
       			strbuf_addf(&buf, "%s/interactive", merge_dir());
 3:  ece3eecdc4d ! 3:  fe000f06207 rebase: note `preserve` merges may be a pull config option
     @@ Metadata
       ## Commit message ##
          rebase: note `preserve` merges may be a pull config option
      
     -    The `--preserve-merges` option was removed by v2.35.0. However
     -    users may not be aware that it is also a Pull option, and it is
     -    still offered by major IDE vendors such as Visual Studio.
     +    The `--preserve-merges` option was removed by v2.34.0. However
     +    users may not be aware that it is also a Pull configuration option,
     +    which is still offered by major IDE vendors such as Visual Studio.
      
          Extend the `--preserve-merges` die message to also direct users to
     -    the use of the `preserve` option in the `pull` config.
     +    the possible use of the `preserve` option in the `pull.rebase` config.
     +    This is an additional 'belt and braces' information statement.
      
          Signed-off-by: Philip Oakley <philipoakley@iee.email>
      
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
       	if (preserve_merges_selected)
      -		die(_("--preserve-merges was replaced by --rebase-merges"));
      +		die(_("--preserve-merges was replaced by --rebase-merges\n"
     -+			"Your `pull` configuration, may also invoke this option."));
     ++			"Note: Your `pull.rebase` configuration may also be  set to 'preserve',\n"
     ++			"which is no longer supported; use 'merges' instead"));
       
       	if (action != ACTION_NONE && total_argc != 2) {
       		usage_with_options(builtin_rebase_usage,
 -:  ----------- > 4:  ae02c6d5a6e rebase: translate a die(preserve-merges) message

-- 
gitgitgadget
