Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE6D1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 21:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeKNH2G (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 02:28:06 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43035 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeKNH2G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 02:28:06 -0500
Received: by mail-ed1-f65.google.com with SMTP id e4so11789037edv.10
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 13:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=u1soURPpPbqUVEWBGd9HBzqj+Wey8pDpOjP62rB/vAg=;
        b=RZB9YkEi99bnil1tyJ5FyMZahVm5LG87Fi9YymqT4w7FUI6nt53/vFxjONR6I3G1mx
         XFvAlhonuxvk9PABWl8qsFm0OgGrirjOVZlsYmxyGhfVX/4B5bjSbKedzI0M8Axf8bJ2
         iSwo2b3U9ions5AP2Sm4yfUFqmwehF8+PqDaBO8/+h9DecuvcC54TO9hUsIZLReW+cK6
         zFAmAvohU29GlHA8Kwdu8IgyOiy137evL8MNANnYYvwYLuSUh+/6y+0JiX25DmFUTb+T
         Kk7japsGCqfX4ahNRIy/s9u+v67vaG8+TwSSx1Wrck7f1sWcWhawoAHGZbbLXQWwRv64
         PeBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=u1soURPpPbqUVEWBGd9HBzqj+Wey8pDpOjP62rB/vAg=;
        b=bG7f2q2DNnFXaYwyAtjPLkQ9gjQZ/rDM8TighPFHL6RZMWpMsELOOQeOAafB8hdsbG
         SLf738Q51IxBhSsJB0Du1A2bMTDeaEfRNw1ZW+u/OdIoz5H8WywK2zzywUAoUdT5mL7w
         ESIuWZPkOZzVQrcRJA4tv6xImAWXG7DPdjj1Zb9FWfI7Zc9z+gPPWH+8f+ED9vDguCbN
         HrfxHE7r6yMlQPREgXfDkCAW05X8W8g6eIzQ8/2S8WORiZhnrjoPmHum5MzyiuQdCbk3
         svjWUFaatdZVk2TlSI/ShCnuHCChibCnQgJm9w8nTCYqdy/P/zzhHSWsc32s8pRE8PbZ
         Jr4g==
X-Gm-Message-State: AGRZ1gLYUg7Iko5qV5lrQzxJQtEbXC8tMFGiayfrzSzDEMwfpVZU28Rf
        2J4bjOb6sXSHZg0wFUfipitNcKuz0i4=
X-Google-Smtp-Source: AJdET5f1M4A7bFsR2/zOgkKmVVCePttQgpJ0QPvSErHIzu0RKk7JWrZcM2GdmEghkBKP/VwmgheT9Q==
X-Received: by 2002:a50:d712:: with SMTP id t18-v6mr17743221edi.75.1542144482146;
        Tue, 13 Nov 2018 13:28:02 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id z2sm664613edd.4.2018.11.13.13.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 13:28:01 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Tanushree Tumane <tanushreetumane@gmail.com>, git@vger.kernel.org,
        pclouds@gmail.com
Subject: Re: [PATCH v4] commit: add a commit.allowEmpty config variable
References: <87d0rm7zeo.fsf@evledraar.gmail.com> <20181113155656.22975-1-tanushreetumane@gmail.com> <nycvar.QRO.7.76.6.1811132021390.39@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1811132021390.39@tvgsbejvaqbjf.bet>
Date:   Tue, 13 Nov 2018 22:27:58 +0100
Message-ID: <87zhuc1xcx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 13 2018, Johannes Schindelin wrote:

[Comments on the v4 patch also inline, found it easier to reply just to
this one]

> On Tue, 13 Nov 2018, Tanushree Tumane wrote:
>
>> From: tanushree27 <tanushreetumane@gmail.com>
>>
>> when we cherrypick an existing commit it doesn't change anything and
>> therefore it fails prompting to reset (skip commit) or commit using
>> --allow-empty attribute and then continue.
>
> This is a nice paragraph, but it might make sense to connect it to the
> commit's oneline somehow. I, for one, was surprised to see the oneline
> talk about `git commit` and the commit message about `git cherry-pick`.
>
> I could imagine that an introductory paragraph, talking about why one
> might want to commit empty commits, might be the best lead into the
> subject, and the paragraph about `cherry-pick` could follow (and be
> introduced by saying something along the lines that this config setting
> has more reach than just `git commit`; it also affects `git cherry-pick`)?

Agreed. I'm happy to see the test for-loop gone as I noted in
https://public-inbox.org/git/87d0rm7zeo.fsf@evledraar.gmail.com/ but as
noted in that v3 feedback the whole "why would anyone want this?"
explanation is still missing, and this still smells like a workaround
for a bug we should be fixing elsewhere in the sequencing code.

[The rest of this for Tanushree]

>>
>> Add commit.allowEmpty configuration variable as a convenience to skip
>> this process.
>>
>> Add tests to check the behavior introduced by this commit.
>>
>> This closes https://github.com/git-for-windows/git/issues/1854
>>
>> Signed-off-by: tanushree27 <tanushreetumane@gmail.com>
>> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
>> ---
>>  Documentation/config.txt     |  5 +++++
>>  Documentation/git-commit.txt |  3 ++-
>>  builtin/commit.c             |  8 ++++++++
>>  t/t3500-cherry.sh            | 10 ++++++++++
>>  4 files changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index c0727b7866..f3828518a5 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1467,6 +1467,11 @@ commit.verbose::
>>  	A boolean or int to specify the level of verbose with `git commit`.
>>  	See linkgit:git-commit[1].
>>
>> +commit.allowEmpty::
>> +	A boolean to specify whether empty commits are allowed with `git
>> +	commit`. See linkgit:git-commit[1].
>> +	Defaults to false.
>> +
>>  credential.helper::
>>  	Specify an external helper to be called when a username or
>>  	password credential is needed; the helper may consult external
>> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
>> index f970a43422..5d3bbf017a 100644
>> --- a/Documentation/git-commit.txt
>> +++ b/Documentation/git-commit.txt
>> @@ -176,7 +176,8 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>>  	Usually recording a commit that has the exact same tree as its
>>  	sole parent commit is a mistake, and the command prevents you
>>  	from making such a commit.  This option bypasses the safety, and
>> -	is primarily for use by foreign SCM interface scripts.
>> +	is primarily for use by foreign SCM interface scripts. See
>> +	`commit.allowEmpty` in linkgit:git-config[1].
>>
>>  --allow-empty-message::
>>         Like --allow-empty this command is primarily for use by foreign
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 67fa949204..4516309ac2 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -101,6 +101,7 @@ static int all, also, interactive, patch_interactive, only, amend, signoff;
>>  static int edit_flag = -1; /* unspecified */
>>  static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
>>  static int config_commit_verbose = -1; /* unspecified */
>> +static int config_commit_allow_empty = -1; /* unspecified */
>>  static int no_post_rewrite, allow_empty_message;
>>  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
>>  static char *sign_commit;
>> @@ -1435,6 +1436,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>>  		config_commit_verbose = git_config_bool_or_int(k, v, &is_bool);
>>  		return 0;
>>  	}
>> +	if (!strcmp(k, "commit.allowempty")) {
>> +		config_commit_allow_empty = git_config_bool(k, v);
>> +		return 0;
>> +	}
>>
>>  	status = git_gpg_config(k, v, NULL);
>>  	if (status)
>> @@ -1556,6 +1561,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>  	if (verbose == -1)
>>  		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
>>
>> +	if (config_commit_allow_empty >= 0)  /* if allowEmpty is allowed in config*/
>> +		allow_empty = config_commit_allow_empty;
>> +

I had two comments on this hunk in my v3 feedback. It's fine to go for
something different (although I still think you should change it), but
for others following along you should at least say "I had such-and-such
feedback suggesting X, but decided to go for Y anyway because...".

>>  	if (dry_run)
>>  		return dry_run_commit(argc, argv, prefix, current_head, &s);
>>  	index_file = prepare_index(argc, argv, prefix, current_head, 0);
>> diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
>> index f038f34b7c..11504e2d9f 100755
>> --- a/t/t3500-cherry.sh
>> +++ b/t/t3500-cherry.sh
>> @@ -55,4 +55,14 @@ test_expect_success \
>>       expr "$(echo $(git cherry master my-topic-branch) )" : "+ [^ ]* - .*"
>>  '
>>
>> +
>> +# Tests for commit.allowEmpty config
>> +

Let's drop this comment. It's redundant to the test description.

>> +test_expect_success 'cherry-pick existing commit with commit.allowEmpty' '
>> +    test_tick &&
>> +	test_commit "first" &&
>> +	test_commit "second" &&
>> +	git -c commit.allowEmpty=true cherry-pick HEAD~1
>> +'

So now you've dropped any tests of "git commit" (even though you're
changing commit.c, and just testing revert.c. So again, if that's all we
want isn't this whole thing just a simple bugfix of:

diff --git a/builtin/commit.c b/builtin/commit.c
index 96d336ec3d..1a12cc559e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1546,6 +1546,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
        if (verbose == -1)
                verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;

+       if (whence == FROM_CHERRY_PICK)
+               allow_empty = allow_empty_message = 1;
+
        if (dry_run)
                return dry_run_commit(argc, argv, prefix, current_head, &s);
        index_file = prepare_index(argc, argv, prefix, current_head, 0);

Possibly dropping the allow_empty_message part, but it seems reasonable
that whether you're re-picking an empty commit or one with an empty
message cherry-pick should always work.

I see that fails various existing tests, and I'm going to stop digging
now, but that brings me back to the "let's explain this better" part of
the feedback. I.e. if we can't just fix it let's explain why it can't be
made a default because it breaks such-and-such, so we need the config
option.
