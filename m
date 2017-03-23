Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EDF620958
	for <e@80x24.org>; Thu, 23 Mar 2017 16:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965557AbdCWQHZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 12:07:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:52329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965541AbdCWQHU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 12:07:20 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXI5V-1ceaws3nBV-00WEGR; Thu, 23
 Mar 2017 17:07:04 +0100
Date:   Thu, 23 Mar 2017 17:07:03 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2 0/3] rebase -i (reword): call the commit-msg hook again
In-Reply-To: <cover.1490194846.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1490285210.git.johannes.schindelin@gmx.de>
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:d77uVzFHiQGzlnraSqVMoPyLv7KtoyrSbCITrVQ9EjlgPS4MDHY
 m6NSKby+5WrGBDNhy1dWZkTl7mIxxjHUKw/DwkvDK6CiuP4cea3wHl+v7K9H9Xpl257Ora+
 jmxaT51ptlnzav0vWLiJgnTigE0JAGsp3Q4YEiyuIekPGIyLQIv785SabG2/fZcz0vEEXc5
 MrjUkW2eEFskS7rPtEHXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yeu2dRlPaUk=:zop6B7bHjfvLcSIRqWn94P
 7WefF72PfqZ4Lui1F1XsGuUxLK2aMDvwdnqmGvgbf3u6OlBYeu+muKhwb0jLDZk8/Gk1WC8h2
 /IHfYBh/7owF+rW6McA3091ESaSGi92E+FnUWuqRcs7aGWqF82gt1ayzopj1i8WZ/3P/fshuP
 d/HBl1maodEqh7TgX4jJfte8+tY6TVNJHZxapm35W9ZPTR8bSxeph0eo7eV+1pORFDEqPkZnU
 YvFyRB7hU2hXsN/g9AmwcqcxQ5An8eiyjkr+GCvtdiNStTcLwiosofW98a7z7ngLILW9nU0AZ
 nD3mUxtY8ENtPEXXUH6ybne6DW/DSiYA3IPMJMW8h+RGwHbtUUAqfHQ4JqZS+dMT49KUOTkXS
 O6BWaZ48RN955De0MBoCVpUclZjwIYMQ4laxvsgRF3MV2nrEsWoyDfeyVMX+2+mLYj3mKtCHo
 p6wVnCw9gk2U8bE40Pf9DAtHOzBwyqnTbDNjjKZeXYMeUojPuIXfvocV0Ao6N9QYftH5yGBik
 IAblcXiO58s8m0so4iL8AixoijY9RMK6hc8u7ogzWo7QUx5RVkT4khwgfZd0qkB6w3VwSRdZl
 +B5M4x+xhPr0EUAbeUe22pcZJQU4l/nUo6Aft8UrCJZnlRhXTiS4zqDqy7aOdbIVOsQ1OvZnP
 fLfvmtGk9+OyhfAHPRY6kL/zOSg2t17HupT5cJEWjHo980XXWmvRDvz2KqeouyWOQ95u4XxJS
 HX2J90BTSkzTDBOgo2LIb8+4Ee1LiPpLKhUMs56x4Od3Ujcu5T3G+sWka5W9lEYC1Vh/36MTS
 Y66M3FN1y93uj+jxLpct/r6X3Rf0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is actually not only the commit-msg, but also the prepare-commit-msg
hook...

Changes since v1:

- changed `int flags` to `unsigned int flags`

- uncuddled the if...else if... construct to not mix the "goto leave"
  logic with the one adding the VERIFY_MSG flag


Johannes Schindelin (3):
  t7504: document regression: reword no longer calls commit-msg
  sequencer: make commit options more extensible
  sequencer: allow the commit-msg hooks to run during a `reword`

 sequencer.c                | 54 ++++++++++++++++++++++++++--------------------
 t/t7504-commit-msg-hook.sh | 17 +++++++++++++++
 2 files changed, 48 insertions(+), 23 deletions(-)


base-commit: afd6726309f57f532b4b989a75c1392359c611cc
Published-As: https://github.com/dscho/git/releases/tag/reword-commit-msg-hook-v2
Fetch-It-Via: git fetch https://github.com/dscho/git reword-commit-msg-hook-v2

Interdiff vs v1:

 diff --git a/sequencer.c b/sequencer.c
 index 377af91c475..bc2fe48e65c 100644
 --- a/sequencer.c
 +++ b/sequencer.c
 @@ -621,7 +621,7 @@ N_("you have staged changes in your working tree\n"
   * author metadata.
   */
  static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 -			  int flags)
 +			  unsigned int flags)
  {
  	struct child_process cmd = CHILD_PROCESS_INIT;
  	const char *value;
 @@ -932,7 +932,7 @@ static void record_in_rewritten(struct object_id *oid,
  static int do_pick_commit(enum todo_command command, struct commit *commit,
  		struct replay_opts *opts, int final_fixup)
  {
 -	int flags = opts->edit ? EDIT_MSG : 0, allow = 0;
 +	unsigned int flags = opts->edit ? EDIT_MSG : 0, allow = 0;
  	const char *msg_file = opts->edit ? NULL : git_path_merge_msg();
  	unsigned char head[20];
  	struct commit *base, *next, *parent;
 @@ -995,13 +995,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
  			write_author_script(msg.message);
  		res = fast_forward_to(commit->object.oid.hash, head, unborn,
  			opts);
 -		if (res)
 -			goto leave;
 -		else if (command == TODO_REWORD)
 -			flags |= VERIFY_MSG;
 -		else
 +		if (res || command != TODO_REWORD)
  			goto leave;
  		flags |= EDIT_MSG | AMEND_MSG;
 +		if (command == TODO_REWORD)
 +			flags |= VERIFY_MSG;
  		msg_file = NULL;
  		goto fast_forward_edit;
  	}
 @@ -2164,7 +2162,7 @@ static int continue_single_pick(void)
  
  static int commit_staged_changes(struct replay_opts *opts)
  {
 -	int flags = ALLOW_EMPTY | EDIT_MSG;
 +	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
  
  	if (has_unstaged_changes(1))
  		return error(_("cannot rebase: You have unstaged changes."));

-- 
2.12.1.windows.1

