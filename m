Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C431F453
	for <e@80x24.org>; Wed, 19 Sep 2018 19:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeITBD5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 21:03:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34015 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeITBD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 21:03:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id j25-v6so10264519wmc.1
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=y4rXBPiobOX6M0f139TBAzIzP5UyktJd02ME36XiAls=;
        b=LgGn7FQUqtpo+vHBal+6uOIbDwSijZPQrYLDox+Jna26pKufUsFC/+292tkX2jta7X
         QWe/BCF2qXee23CobaEK6hfJRdVV6OVIB1cgbGEx2/NDDB1czTPp4p5NBb/l/+aISfNx
         N41mKYWLw/GcgScTp0B+E5GsJJUctBw+I8TUu4+C2o0zNAHxsVCcsDbMeYPLHCsmYTdM
         1paz6SApyJpBLfMq+MHyftzuQrVMv4FY+vkduc5dz+MBOjtKjhEFZs5SmqBvzTKVP7gR
         GCFgqraXBPwzwvFmjyTSa9uWw9AxRTGJV3394M2Tq+Y0Bh3t/YxQuj6JE4kFCQ4x/FbY
         QmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=y4rXBPiobOX6M0f139TBAzIzP5UyktJd02ME36XiAls=;
        b=uLkaQXIYquTmIkwH8nrEsAzjO+Q49daCBYNpu+vyQYJqdrYmTE63YdN3TWxik7nHD5
         sJRS5SAJ2sh2rASgJlWJ9bM4NOd30vT0m2QG8pufSIYHnRSO76x2QoP4oyqGjYAujyZ9
         0D5smfxGKl+AudSHrXEwxcaY6skKs3GNwMOiNF0VUlGojhINpuVO/vXGt/BxiT0d8fQn
         DRUJbEre4fHETjHjFsR5intgi0DzmTj5V4bAdwrBtVl/xPEaNvsGeI7paW11BLx4/e4M
         GH3eJlGPGaLTqVEQX8BaYw1n7w0E6Uml+5YdzNZHYREhZyx5/OY/Z0nZTeXMYydBPtkv
         Degw==
X-Gm-Message-State: APzg51DPK6KiZTo/FpSRyjqO7vlczR+V3j3ZhS51h+dQh+GHrYyaTT5M
        CboQhbCAYCvF01pbYe87dW8=
X-Google-Smtp-Source: ANB0VdbRsU21VEIKYDEsKHfvsp4+WLx1fQaxpfddlzcMGgribQxaTwhvVXbzuOIpVG1VraVQ+E0QuA==
X-Received: by 2002:a1c:7704:: with SMTP id t4-v6mr20609860wmi.136.1537385072112;
        Wed, 19 Sep 2018 12:24:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q16-v6sm15391879wrn.41.2018.09.19.12.24.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 12:24:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Antonio Ospite <ao2@ao2.it>, git@vger.kernel.org,
        Daniel =?utf-8?Q?G?= =?utf-8?Q?ra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: support reading .gitmodules when it's not in the working tree
References: <20180917140940.3839-1-ao2@ao2.it>
        <20180917140940.3839-10-ao2@ao2.it> <20180918171257.GC27036@localhost>
Date:   Wed, 19 Sep 2018 12:24:30 -0700
In-Reply-To: <20180918171257.GC27036@localhost> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Tue, 18 Sep 2018 19:12:57 +0200")
Message-ID: <xmqqfty547f5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> it appears that this patch (and its previous versions as well) is
> responsible for triggering occasional test failures in
> 't7814-grep-recurse-submodules.sh', more frequently, about once in
> every ten runs, on macOS on Travis CI, less frequently, about once in
> a couple of hundred runs on Linux on my machine.

I see that among Cc'ed are people who are more familiar with the
submodule code and where it wants to go.  Thanks for a report and
analysis.

> The reason for the failure is memory corruption manifesting in various
> ways: segfault, malloc() or use after free() errors from libc, corrupt
> loose object, invalid ref, bogus output, etc.
> 
> Applying the following patch makes t7814 fail almost every time,
> though sometimes that loop has to iterate over 1000 times until that
> 'git grep' finally fails...  so good luck with debugging ;)
>
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> index 7184113b9b..93ae2e8e7c 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -337,6 +337,10 @@ test_expect_success 'grep --recurse-submodules should pass the pattern type alon
>  	test_must_fail git -c grep.patternType=fixed grep --recurse-submodules -e "(.|.)[\d]" &&
>  
>  	# Basic
> +	for i in $(seq 0 2000)
> +	do
> +		git grep --recurse-submodules 1 >/dev/null || return 1
> +	done &&
>  	git grep -G --recurse-submodules -e "(.|.)[\d]" >actual &&
>  	cat >expect <<-\EOF &&
>  	a:(1|2)d(3|4)
>
> On first look I didn't notice anything that is obviously wrong in this
> patch and could be responsible for the memory corruption, but there is
> one thing I found strange, though:
>
>
> On Mon, Sep 17, 2018 at 04:09:40PM +0200, Antonio Ospite wrote:
>> When the .gitmodules file is not available in the working tree, try
>> using the content from the index and from the current branch.
>
> "from the index and from the current branch" of which repository?
>
>> This
>> covers the case when the file is part of the repository but for some
>> reason it is not checked out, for example because of a sparse checkout.
>> 
>> This makes it possible to use at least the 'git submodule' commands
>> which *read* the gitmodules configuration file without fully populating
>> the working tree.
>> 
>> Writing to .gitmodules will still require that the file is checked out,
>> so check for that before calling config_set_in_gitmodules_file_gently.
>> 
>> Add a similar check also in git-submodule.sh::cmd_add() to anticipate
>> the eventual failure of the "git submodule add" command when .gitmodules
>> is not safely writeable; this prevents the command from leaving the
>> repository in a spurious state (e.g. the submodule repository was cloned
>> but .gitmodules was not updated because
>> config_set_in_gitmodules_file_gently failed).
>> 
>> Finally, add t7416-submodule-sparse-gitmodules.sh to verify that reading
>> from .gitmodules succeeds and that writing to it fails when the file is
>> not checked out.
>> 
>> Signed-off-by: Antonio Ospite <ao2@ao2.it>
>> ---
>
>> diff --git a/submodule-config.c b/submodule-config.c
>> index 61a555e920..bdb1d0e2c9 100644
>> --- a/submodule-config.c
>> +++ b/submodule-config.c
>
>> @@ -603,8 +604,21 @@ static void submodule_cache_check_init(struct repository *repo)
>>  static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
>>  {
>>  	if (repo->worktree) {
>> -		char *file = repo_worktree_path(repo, GITMODULES_FILE);
>> -		git_config_from_file(fn, file, data);
>> +		struct git_config_source config_source = { 0 };
>> +		const struct config_options opts = { 0 };
>> +		struct object_id oid;
>> +		char *file;
>> +
>> +		file = repo_worktree_path(repo, GITMODULES_FILE);
>> +		if (file_exists(file))
>> +			config_source.file = file;
>> +		else if (get_oid(GITMODULES_INDEX, &oid) >= 0)
>> +			config_source.blob = GITMODULES_INDEX;
>
> The repository used in t7814 contains nested submodules, which means
> that config_from_gitmodules() is invoked three times.
>
> Now, the first two of those calls look at the superproject and at
> 'submodule', and find the existing files '.../trash
> directory.t7814-grep-recurse-submodules/.gitmodules' and '.../trash
> directory.t7814-grep-recurse-submodules/submodule/.gitmodules',
> respectively.  So far so good.
>
> The third call, however, looks at the nested submodule at
> 'submodule/sub', which doesn't contain a '.gitmodules' file.  So this
> function goes on with the second condition and calls
> get_oid(GITMODULES_INDEX, &oid), which then appears to find the blob
> in the _superproject's_ index.
>
> I'm no expert on submodules, but my gut feeling says that this can't
> be right.  But if it _is_ right, then I would say that the commit
> message should explain in detail, why it is right.
>
> Anyway, even if it is indeed wrong, I'm not sure whether this is the
> root cause of the memory corruption.
>
>
>> +		else if (get_oid(GITMODULES_HEAD, &oid) >= 0)
>> +			config_source.blob = GITMODULES_HEAD;
>> +
>> +		config_with_options(fn, data, &config_source, &opts);
>> +
>>  		free(file);
>>  	}
>>  }
