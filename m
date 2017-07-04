Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58CF8202A7
	for <e@80x24.org>; Tue,  4 Jul 2017 08:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbdGDId7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 04:33:59 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36005 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbdGDId6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 04:33:58 -0400
Received: by mail-wr0-f193.google.com with SMTP id 77so46559094wrb.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/2d95Pv0ZNGIAMsrr/lQmwEfJBRLOC87AkYFFc6YP98=;
        b=gRrIQ3Q5kl+/isRWBXElnNSq3kqslLKKRL1eGLpfi3EDkLgff70CSmezlDklE/pe2s
         u924DJlcmAxFG08SRpEO2W6fbZhm2S+w4ForuEbY4tq4oBRpj4nWU7HnNfL9UqKEMxQz
         JJtGnRJMDiDABVCxwC75/KmuA7Ta5Ar4Z7RrjOE6olVyduFnkWcHrQnNz+ybqG1MXPZw
         fnYFUjLMWe/JsnmfYDeFv3or1cTooeVuMzKpndu1SVILWqfqQtaWGZeXMLJNA6ezHCBT
         ZZbvMDUeFmmIeX4Vw5hiK552UeJNa11l5mxEgwJ5a/oKqc6W6L1EfyzV5tMYdLVxiKaW
         3Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/2d95Pv0ZNGIAMsrr/lQmwEfJBRLOC87AkYFFc6YP98=;
        b=oZ5IhO4My+SsZz6l27tnu/9qayCgkcr83i5Meb0wtWmWNbHLT715tZXvHDFRz/+/zx
         wvPvpckAKlgazaTEGqNbvhtW/GrenQ/HJa2M32MYjDov3F5tSzSDgFKAFOr2P2gZCnrP
         e02QzAdFT4QzoRxZiyYINvIKa5XR54I2nw3QhGRh7RQp4s+PFB1iYqsgVJI3lKDovDoV
         nAqk6MYfWByf27LppnsWXqRDjVL8h0NOrpvin/vjzfn7XzULWe3GVJ4EdQ8FYbdjdLXM
         Mmd6aPNuUfuNVLFGzLd/zSOYOzB3Hyiok1ul22HFJMY/IWimBEqPNCvZK2OUI3KbWAmh
         8Lag==
X-Gm-Message-State: AKS2vOwTL9LKrN3aeGGPZIIJZt6x8JHgVKRbt4lW9RV2+/+8XRD2/8ux
        NDOcSZMvqwtES3fLfZg=
X-Received: by 10.223.172.15 with SMTP id v15mr40992430wrc.84.1499157236658;
        Tue, 04 Jul 2017 01:33:56 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id 199sm5392300wmu.0.2017.07.04.01.33.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jul 2017 01:33:55 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dSJHO-0003lU-GY; Tue, 04 Jul 2017 10:33:54 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?=C5=81ukasz?= Gryglicki <lukaszgryglicki@o2.pl>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] add --signoff flag to `git-merge` command.
References: <0102015d07e215ae-a711670e-8315-40b9-90cf-f95075525622-000000@eu-west-1.amazonses.com> <0102015d0c41db74-34ff8613-05e2-44bb-a05b-2624108c36c8-000000@eu-west-1.amazonses.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <0102015d0c41db74-34ff8613-05e2-44bb-a05b-2624108c36c8-000000@eu-west-1.amazonses.com>
Date:   Tue, 04 Jul 2017 10:33:54 +0200
Message-ID: <87tw2sbnyl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 04 2017, Łukasz Gryglicki jotted:

> add --signoff flag to `git-merge` command.

We'd usually say this as:

merge: add a --signoff flag

Or something like that.

> Some projects require every commit to be signed off.
> Our workflow is to create feature branches and require every commit to
> be signed off. When feature is finally approved we need to merge it into
> master. Merge itself is usually trivial and is done by
> `git merge origin/master`. Unfortunatelly this command have no --signoff
> flag, so we need to either add signoff line manually or use
> `git commit --amend -s` after the merge. First solution is not ideal
> because not all developers are familiar with exact sign-off syntax.
> The second solution works, but is obviously tedious.
> This patch adds --signoff support to git-merge command. It works just
> like --signoff in `git-commit` command.

It would be nice to split this into a at least a couple of paragraphs,
and more closely follow the format suggested by
Documentation/SubmittingPatches.

> More details here:
> https://public-inbox.org/git/CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com/T/#u

These more details include my outstanding question in
87fueferd4.fsf@gmail.com which hasn't been answered yet.

> Signed-off-by: lukaszgryglicki <lukaszgryglicki@o2.pl>
> ---
>  Documentation/git-merge.txt  |  8 +++++
>  builtin/merge.c              |  4 +++
>  t/t9904-git-merge-signoff.sh | 75 ++++++++++++++++++++++++++++++++++++++++++++
>
>  3 files changed, 87 insertions(+)
>  create mode 100755 t/t9904-git-merge-signoff.sh
>
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 04fdd8cf086db..6b308ab6d0b52 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -64,6 +64,14 @@ OPTIONS
>  -------
>  include::merge-options.txt[]
>
> +--signoff::
> +	Add Signed-off-by line by the committer at the end of the commit
> +	log message.  The meaning of a signoff depends on the project,
> +	but it typically certifies that committer has
> +	the rights to submit this work under the same license and
> +	agrees to a Developer Certificate of Origin
> +	(see http://developercertificate.org/ for more information).
> +
>  -S[<keyid>]::
>  --gpg-sign[=<keyid>]::
>  	GPG-sign the resulting merge commit. The `keyid` argument is
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 900bafdb45d0b..78c36e9bf353b 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -70,6 +70,7 @@ static int continue_current_merge;
>  static int allow_unrelated_histories;
>  static int show_progress = -1;
>  static int default_to_upstream = 1;
> +static int signoff;
>  static const char *sign_commit;
>
>  static struct strategy all_strategy[] = {
> @@ -233,6 +234,7 @@ static struct option builtin_merge_options[] = {
>  	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
>  	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
>  	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
> +	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
>  	OPT_END()
>  };
>
> @@ -763,6 +765,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>  	strbuf_addch(&msg, '\n');
>  	if (0 < option_edit)
>  		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
> +	if (signoff)
> +		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
>  	write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
>  	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
>  			    git_path_merge_msg(), "merge", NULL))
> diff --git a/t/t9904-git-merge-signoff.sh b/t/t9904-git-merge-signoff.sh
> new file mode 100755
> index 0000000000000..f542f136f5dda
> --- /dev/null
> +++ b/t/t9904-git-merge-signoff.sh

The convention for adding new tests is not to add a new one after
whatever name sorts the highest, see "Naming Tests" in t/README.

I.e. this should be somewhere in t[6-7]* with the other merge tests.

> @@ -0,0 +1,75 @@
> +#!/bin/sh
> +
> +test_description='git merge --signoff
> +
> +This test runs git merge --signoff and makes sure that it works.
> +'
> +
> +. ./test-lib.sh
> +
> +# Setup test files
> +test_setup() {
> +	# A simples files to commit
> +	echo "1" >file1
> +	echo "2" >file2
> +	echo "3" >file3
> +	echo "4" >file4
> +
> +	# Expected commit message after merge --signoff
> +	cat >expected-signed <<EOF
> +Merge branch 'master' into other-branch
> +
> +Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
> +EOF
> +
> +	# Expected commit message after merge without --signoff (or with --no-signoff)
> +	cat >expected-unsigned <<EOF
> +Merge branch 'master' into other-branch
> +EOF
> +
> +	# Initial commit and feature branch to merge master into it.
> +	git commit --allow-empty -m "Initial empty commit"
> +	git checkout -b other-branch
> +	git add file1
> +	git commit -m other-branch

This setup function doesn't && its commands together, so a fail in any
one of these won't be detecten. Any reason you don't just add this to
the test_expect_success below, where we would detect this?

Also most of your commit/add etc. could probably be replaced with the
test_commit helper, see t/README.
