Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE7B1F453
	for <e@80x24.org>; Tue, 18 Sep 2018 17:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbeIRWqe (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 18:46:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36003 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbeIRWqe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 18:46:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id j192-v6so3756113wmj.1
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 10:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hj5Mulr5K7L5m6ck4Us9TbGAH8E+rpVkJdk4WbLC9nk=;
        b=rwdSmPugmcDFoWdzZ8PuNkCJ93DAlzud39TAG74+PEyR8psTeeqebBfAlM5sGHNB2i
         es8qvi5Z0pR+QnVuZDGaPe6r3CDacjnK4QXsLgsuAW4Qikbh88CO1uLNq3QDKJ9oDuAI
         Z/1vxpJNmXBGNhnUsq5h3EqxJz4lDPseIrxQLtfLCViI6Xyhuue1g1MHblAVY88LH4Fs
         TORAFOuzeBMunfRcVaxAh1qBj+dtbYih2Qrk86VVrVKk0uImOXd6P36EchzRbKn6Lsbw
         zVKL8Ag7kWjRjz1h3lfpQK5HN/9MgTCbuelmLQqak8UCSmXZnxxQ3/fby6VXmmOQNqhH
         haQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hj5Mulr5K7L5m6ck4Us9TbGAH8E+rpVkJdk4WbLC9nk=;
        b=Jeal2wfCS1AKf2SK3vnVqhsp13/axGnvj92RskdyDw5nW5sNDhHAUHCQWPBsQ25KaM
         HWBKMLrvxmswI06Ub4EcdIGIaciLaHDkhj6jZ2KVyVawYajrUlRoFLX0QFkgbPBT7kbU
         S8W5BY/e+OzJPtxN6KmwqgEvBtu2uWe9l8+UxgOBJDVjq5opSFmA9HOpFeYy1tvQMUA6
         +NKeNFHv6o9iGmUP1uONZtc2umWEcOL/dqt/CEFRwakdMiopB4p5O/5ySQIaabQbbwLp
         UpFQ/fVI9ci7554aT73R1o2//XBy6HjjFrLq5zmNMIv7FjHI0/R30VG4YmOnoMY2RuyX
         SmBw==
X-Gm-Message-State: APzg51CeFHgI8SUm1mpDTAYrKZcMuHksVbk8EbBBMoFd5ptktxvDWAOZ
        LJLjGvNIgH9mxOtTsqj2EFA=
X-Google-Smtp-Source: ANB0VdamMg8Far7M+41rnBlUPzy8akrSY7vaT6fK3Doi+g0Yt2T3g3gR6WKZYOqWkbkm4rzaDwAKdw==
X-Received: by 2002:a1c:230f:: with SMTP id j15-v6mr17662975wmj.124.1537290781202;
        Tue, 18 Sep 2018 10:13:01 -0700 (PDT)
Received: from localhost (x590dd623.dyn.telefonica.de. [89.13.214.35])
        by smtp.gmail.com with ESMTPSA id z141-v6sm3188141wmc.3.2018.09.18.10.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 10:13:00 -0700 (PDT)
Date:   Tue, 18 Sep 2018 19:12:57 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Daniel =?utf-8?B?R3Jhw7Fh?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: support reading .gitmodules when it's
 not in the working tree
Message-ID: <20180918171257.GC27036@localhost>
References: <20180917140940.3839-1-ao2@ao2.it>
 <20180917140940.3839-10-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180917140940.3839-10-ao2@ao2.it>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Antonio,

it appears that this patch (and its previous versions as well) is
responsible for triggering occasional test failures in
't7814-grep-recurse-submodules.sh', more frequently, about once in
every ten runs, on macOS on Travis CI, less frequently, about once in
a couple of hundred runs on Linux on my machine.

The reason for the failure is memory corruption manifesting in various
ways: segfault, malloc() or use after free() errors from libc, corrupt
loose object, invalid ref, bogus output, etc.

Applying the following patch makes t7814 fail almost every time,
though sometimes that loop has to iterate over 1000 times until that
'git grep' finally fails...  so good luck with debugging ;)

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 7184113b9b..93ae2e8e7c 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -337,6 +337,10 @@ test_expect_success 'grep --recurse-submodules should pass the pattern type alon
 	test_must_fail git -c grep.patternType=fixed grep --recurse-submodules -e "(.|.)[\d]" &&
 
 	# Basic
+	for i in $(seq 0 2000)
+	do
+		git grep --recurse-submodules 1 >/dev/null || return 1
+	done &&
 	git grep -G --recurse-submodules -e "(.|.)[\d]" >actual &&
 	cat >expect <<-\EOF &&
 	a:(1|2)d(3|4)


On first look I didn't notice anything that is obviously wrong in this
patch and could be responsible for the memory corruption, but there is
one thing I found strange, though:


On Mon, Sep 17, 2018 at 04:09:40PM +0200, Antonio Ospite wrote:
> When the .gitmodules file is not available in the working tree, try
> using the content from the index and from the current branch.

"from the index and from the current branch" of which repository?

> This
> covers the case when the file is part of the repository but for some
> reason it is not checked out, for example because of a sparse checkout.
> 
> This makes it possible to use at least the 'git submodule' commands
> which *read* the gitmodules configuration file without fully populating
> the working tree.
> 
> Writing to .gitmodules will still require that the file is checked out,
> so check for that before calling config_set_in_gitmodules_file_gently.
> 
> Add a similar check also in git-submodule.sh::cmd_add() to anticipate
> the eventual failure of the "git submodule add" command when .gitmodules
> is not safely writeable; this prevents the command from leaving the
> repository in a spurious state (e.g. the submodule repository was cloned
> but .gitmodules was not updated because
> config_set_in_gitmodules_file_gently failed).
> 
> Finally, add t7416-submodule-sparse-gitmodules.sh to verify that reading
> from .gitmodules succeeds and that writing to it fails when the file is
> not checked out.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---

> diff --git a/submodule-config.c b/submodule-config.c
> index 61a555e920..bdb1d0e2c9 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c

> @@ -603,8 +604,21 @@ static void submodule_cache_check_init(struct repository *repo)
>  static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
>  {
>  	if (repo->worktree) {
> -		char *file = repo_worktree_path(repo, GITMODULES_FILE);
> -		git_config_from_file(fn, file, data);
> +		struct git_config_source config_source = { 0 };
> +		const struct config_options opts = { 0 };
> +		struct object_id oid;
> +		char *file;
> +
> +		file = repo_worktree_path(repo, GITMODULES_FILE);
> +		if (file_exists(file))
> +			config_source.file = file;
> +		else if (get_oid(GITMODULES_INDEX, &oid) >= 0)
> +			config_source.blob = GITMODULES_INDEX;

The repository used in t7814 contains nested submodules, which means
that config_from_gitmodules() is invoked three times.

Now, the first two of those calls look at the superproject and at
'submodule', and find the existing files '.../trash
directory.t7814-grep-recurse-submodules/.gitmodules' and '.../trash
directory.t7814-grep-recurse-submodules/submodule/.gitmodules',
respectively.  So far so good.

The third call, however, looks at the nested submodule at
'submodule/sub', which doesn't contain a '.gitmodules' file.  So this
function goes on with the second condition and calls
get_oid(GITMODULES_INDEX, &oid), which then appears to find the blob
in the _superproject's_ index.

I'm no expert on submodules, but my gut feeling says that this can't
be right.  But if it _is_ right, then I would say that the commit
message should explain in detail, why it is right.

Anyway, even if it is indeed wrong, I'm not sure whether this is the
root cause of the memory corruption.


> +		else if (get_oid(GITMODULES_HEAD, &oid) >= 0)
> +			config_source.blob = GITMODULES_HEAD;
> +
> +		config_with_options(fn, data, &config_source, &opts);
> +
>  		free(file);
>  	}
>  }
