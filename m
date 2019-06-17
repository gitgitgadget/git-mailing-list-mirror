Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FCBB1F462
	for <e@80x24.org>; Mon, 17 Jun 2019 08:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfFQIjP (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jun 2019 04:39:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33661 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbfFQIjP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jun 2019 04:39:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so3964489wme.0
        for <git@vger.kernel.org>; Mon, 17 Jun 2019 01:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jzwszgpvrQEZuPQwq+1v+sEG7WEx8yCo9YID5EqLEtA=;
        b=ZZ0FsAp5+81EmHoACf+CvG63YgawfrZJ6wtcPcJji8RunzfKV6gRww/wpda14cKegM
         6PpUwWhZVZS5QWqbaVPu3IBrAELl4Uj1mHlpltkwzqQieZYlc7re8z160fFk0VCXwoJK
         5/owhjUss7BFdK8ex9/aMQXLb8DLvv1AptIFB+BIMhlrgvwCYSS0ZoEAs0X6njJgjCX2
         +eAqMpCPCUHIcEXcMetg3m2+CJn1dVYeOHVJlRnKrC9ipdwgHTC5ExfLWFLdun6SlhUn
         whVqntHI+p6T9L0xRKhv+2Nc94kn1PGr6ZSw73JKhCrs/RFdOTRgCYrkZZUCsNPSS/iM
         e0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jzwszgpvrQEZuPQwq+1v+sEG7WEx8yCo9YID5EqLEtA=;
        b=DYJG55/0S6fnwIv3v4bXn7bgvbzk7etVfJSpO/Hluhg7Tu+gHRT6ESs1smGdsDbqeT
         KSVx2xbagmHqirfOIZr9zleIao6AT7/eb/z+ygkHjpOZ/kx+Kw0IybKpqMIOd70/OvTP
         UfL7mjVRP9Fxjl9VJE+P0goECky000Gs58xqHb7VqXLiUUyfJcmvbTlJzPyD7GhP83bK
         llEtKZnvAFXyuCX/2iyRoSVEejH5BuTTv0/O1FL1NVy+Jpc+1GzxbJ7xf4t0zLu+xFBC
         p28Pwm9VF9donnJ2edjhZ91WkT5CywoIlKIcmoyIy5llWe50FycfYDqREBZB7sY4+aOM
         pSKA==
X-Gm-Message-State: APjAAAUHvPL2/bmtfTNjtzJSXfVIDYerh6OR9GUhiqNhmAf5XmATqEDS
        lco+3bmcpVNidzAf8tYell0=
X-Google-Smtp-Source: APXvYqx58MknJ7lhC8BZxZfZM2g4V+39RoQStij7F2o+nsbxoeDMoCo2THTSW1wiOGwa8GAAectzGw==
X-Received: by 2002:a1c:2e16:: with SMTP id u22mr17404012wmu.80.1560760751658;
        Mon, 17 Jun 2019 01:39:11 -0700 (PDT)
Received: from localhost (adsl-24.176.58.195.tellas.gr. [176.58.195.24])
        by smtp.gmail.com with ESMTPSA id l1sm11540541wmg.13.2019.06.17.01.39.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 01:39:10 -0700 (PDT)
Date:   Mon, 17 Jun 2019 09:39:09 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, phillip.wood123@gmail.com,
        martin.agren@gmail.com, jrnieder@gmail.com, gitster@pobox.com
Subject: Re: [GSoC][PATCH v4 0/4] [GSoC][PATCH 0/3] Teach cherry-pick/revert
 to skip commits
Message-ID: <20190617083909.GB15217@hank.intra.tgummerer.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616082040.9440-1-rohit.ashiwal265@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/16, Rohit Ashiwal wrote:
> Yet another iteration of my patch. We have changed the series a little bit. We
> now have a commit that rename `reset_for_rollback` to `reset_merge`. A lot of
> nit-picks were handled in this revision.

Thanks for your work!  I allowed myself to nitpick a bit more at this
stage :)

One other thing I wanted to point out here is range-diff, which can be
helpful to include for the benefit of reviewers that saw this series
before.  See 'man git-range-diff' or the --range-diff flag in 'git
format-patch' for more info on how it works.  It helps seeing at a
glance what changed between versions of a series.

For the benefit of other reviewers that might find it helpful, here's
one I generated between v3 and v4 of the series::

1:  8f29142755 ! 1:  99279e617c sequencer: add advice for revert
    @@ -25,8 +25,8 @@
     -		error(_("a cherry-pick or revert is already in progress"));
     -		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
     +	enum replay_action action;
    -+	const char *in_progress_advice;
     +	const char *in_progress_error = NULL;
    ++	const char *in_progress_advice = NULL;
     +
     +	if (!sequencer_get_last_command(r, &action)) {
     +		switch (action) {
    @@ -41,7 +41,7 @@
     +			_("try \"git cherry-pick (--continue | --abort | --quit)\"");
     +			break;
     +		default:
    -+			BUG(_("the control must not reach here"));
    ++			BUG(_("unexpected action in create_seq_dir"));
     +		}
     +	}
     +	if (in_progress_error) {
-:  ---------- > 2:  c64aabf2d2 sequencer: rename reset_for_rollback to reset_merge
2:  3bc8678df4 ! 3:  8b483815ca cherry-pick/revert: add --skip option
    @@ -27,7 +27,7 @@
     -'git cherry-pick' --continue
     -'git cherry-pick' --quit
     -'git cherry-pick' --abort
    -+'git cherry-pick' --continue | --skip | --abort | --quit
    ++'git cherry-pick' (--continue | --skip | --abort | --quit)
      
      DESCRIPTION
      -----------
    @@ -42,7 +42,7 @@
     -'git revert' --continue
     -'git revert' --quit
     -'git revert' --abort
    -+'git revert' --continue | --skip | --abort | --quit
    ++'git revert' (--continue | --skip | --abort | --quit)
      
      DESCRIPTION
      -----------
    @@ -97,10 +97,11 @@
      +++ b/sequencer.c
     @@
      
    - static int reset_for_rollback(const struct object_id *oid)
    + static int reset_merge(const struct object_id *oid)
      {
     -	const char *argv[4];	/* reset --merge <arg> + NULL */
    -+	struct argv_array argv = ARGV_ARRAY_INIT;	/* reset --merge <arg> + NULL */
    ++	int ret;
    ++	struct argv_array argv = ARGV_ARRAY_INIT;
      
     -	argv[0] = "reset";
     -	argv[1] = "--merge";
    @@ -112,34 +113,29 @@
     +	if (!is_null_oid(oid))
     +		argv_array_push(&argv, oid_to_hex(oid));
     +
    -+	return run_command_v_opt(argv.argv, RUN_GIT_CMD);
    ++	ret = run_command_v_opt(argv.argv, RUN_GIT_CMD);
    ++	argv_array_clear(&argv);
    ++
    ++	return ret;
      }
      
    --static int rollback_single_pick(struct repository *r)
    -+static int rollback_single_pick(struct repository *r, unsigned int is_skip)
    - {
    - 	struct object_id head_oid;
    - 
    - 	if (!file_exists(git_path_cherry_pick_head(r)) &&
    --	    !file_exists(git_path_revert_head(r)))
    -+	    !file_exists(git_path_revert_head(r)) && !is_skip)
    - 		return error(_("no cherry-pick or revert in progress"));
    - 	if (read_ref_full("HEAD", 0, &head_oid, NULL))
    - 		return error(_("cannot resolve HEAD"));
    --	if (is_null_oid(&head_oid))
    -+	if (is_null_oid(&head_oid) && !is_skip)
    - 		return error(_("cannot abort from a branch yet to be born"));
    - 	return reset_for_rollback(&head_oid);
    - }
    + static int rollback_single_pick(struct repository *r)
     @@
    - 		 * If CHERRY_PICK_HEAD or REVERT_HEAD indicates
    - 		 * a single-cherry-pick in progress, abort that.
    - 		 */
    --		return rollback_single_pick(r);
    -+		return rollback_single_pick(r, 0);
    - 	}
    - 	if (!f)
    - 		return error_errno(_("cannot open '%s'"), git_path_head_file());
    + 	return reset_merge(&head_oid);
    + }
    + 
    ++static int skip_single_pick(void)
    ++{
    ++	struct object_id head;
    ++
    ++	if (read_ref_full("HEAD", 0, &head, NULL))
    ++		return error(_("cannot resolve HEAD"));
    ++	return reset_merge(&head);
    ++}
    ++
    + int sequencer_rollback(struct repository *r, struct replay_opts *opts)
    + {
    + 	FILE *f;
     @@
      	return -1;
      }
    @@ -149,13 +145,35 @@
     +	enum replay_action action = -1;
     +	sequencer_get_last_command(r, &action);
     +
    ++	/*
    ++	 * opts->action tells us which subcommand requested to skip
    ++	 * the commit.
    ++	 */
     +	switch (opts->action) {
     +	case REPLAY_REVERT:
    ++		/*
    ++		 * If .git/REVERT_HEAD exists then we are sure that we are in
    ++		 * the middle of a revert and we allow to skip the commit.
    ++		 */
     +		if (!file_exists(git_path_revert_head(r))) {
    ++			/*
    ++			 * Check if the last instruction executed was related to
    ++			 * revert. If so, we are sure that a revert is in progress.
    ++			 *
    ++			 * NB: single commit revert is also counted in this
    ++			 * definition of "progress" (and was dealt with in the
    ++			 * previous check).
    ++			 */
     +			if (action == REPLAY_REVERT) {
    ++				/*
    ++				 * Check if the user has moved the HEAD, i.e.,
    ++				 * already committed. In this case, we would like
    ++				 * to advise instead of skipping.
    ++				 */
     +				if (!rollback_is_safe())
     +					goto give_advice;
     +				else
    ++					/* skip commit :) */
     +					break;
     +			}
     +			return error(_("no revert in progress"));
    @@ -173,10 +191,10 @@
     +		}
     +		break;
     +	default:
    -+		BUG("the control must not reach here");
    ++		BUG("unexpected action in sequencer_skip");
     +	}
     +
    -+	if (rollback_single_pick(r, 1))
    ++	if (skip_single_pick())
     +		return error(_("failed to skip the commit"));
     +	if (!is_directory(git_path_seq_dir()))
     +		return 0;
    @@ -289,7 +307,7 @@
     +	git commit -a &&
     +	test_path_is_missing .git/CHERRY_PICK_HEAD &&
     +	test_must_fail git cherry-pick --skip 2>advice &&
    -+	test_cmp expect advice
    ++	test_i18ncmp expect advice
     +'
     +
     +test_expect_success 'allow skipping commit but not abort for a new history' '
    @@ -303,7 +321,7 @@
     +	test_must_fail git cherry-pick anotherpick &&
     +	test_must_fail git cherry-pick --abort 2>advice &&
     +	git cherry-pick --skip &&
    -+	test_cmp expect advice
    ++	test_i18ncmp expect advice
     +'
     +
     +test_expect_success 'allow skipping stopped cherry-pick because of untracked file modifications' '
3:  a3cd17540b ! 4:  98618e08f4 cherry-pick/revert: advise using --skip
    @@ -42,8 +42,8 @@
      +++ b/sequencer.c
     @@
      	enum replay_action action;
    - 	const char *in_progress_advice;
      	const char *in_progress_error = NULL;
    + 	const char *in_progress_advice = NULL;
     +	unsigned int advise_skip = file_exists(git_path_revert_head(r)) ||
     +				file_exists(git_path_cherry_pick_head(r));
      
    @@ -62,7 +62,7 @@
     +			_("try \"git cherry-pick (--continue | %s--abort | --quit)\"");
      			break;
      		default:
    - 			BUG(_("the control must not reach here"));
    + 			BUG(_("unexpected action in create_seq_dir"));
     @@
      	}
      	if (in_progress_error) {
    @@ -80,7 +80,7 @@
      --- a/t/t3510-cherry-pick-sequence.sh
      +++ b/t/t3510-cherry-pick-sequence.sh
     @@
    - 	test_cmp expect advice
    + 	test_i18ncmp expect advice
      '
      
     +test_expect_success 'selectively advise --skip while launching another sequence' '
    @@ -92,7 +92,7 @@
     +	EOF
     +	test_must_fail git cherry-pick picked..yetanotherpick &&
     +	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
    -+	test_cmp expect advice &&
    ++	test_i18ncmp expect advice &&
     +	cat >expect <<-EOF &&
     +	error: cherry-pick is already in progress
     +	hint: try "git cherry-pick (--continue | --abort | --quit)"
    @@ -100,7 +100,7 @@
     +	EOF
     +	git reset --merge &&
     +	test_must_fail git cherry-pick picked..yetanotherpick 2>advice &&
    -+	test_cmp expect advice
    ++	test_i18ncmp expect advice
     +'
     +
      test_expect_success 'allow skipping commit but not abort for a new history' '

> Rohit Ashiwal (4):
>   sequencer: add advice for revert
>   sequencer: rename reset_for_rollback to reset_merge
>   cherry-pick/revert: add --skip option
>   cherry-pick/revert: advise using --skip
> 
>  Documentation/git-cherry-pick.txt |   4 +-
>  Documentation/git-revert.txt      |   4 +-
>  Documentation/sequencer.txt       |   4 +
>  builtin/commit.c                  |  13 +--
>  builtin/revert.c                  |   5 ++
>  sequencer.c                       | 139 ++++++++++++++++++++++++++----
>  sequencer.h                       |   1 +
>  t/t3510-cherry-pick-sequence.sh   | 122 ++++++++++++++++++++++++++
>  8 files changed, 266 insertions(+), 26 deletions(-)
> 
> -- 
> 2.21.0
> 
