Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7564189
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014317; cv=none; b=dvMtWnOenzbsxWrbbJ56PCeiVOfRKzsnl2grfRcrIOQ0Ollu34OfLM3xEKbXkOc+OW81VZKtCqIvvHsv3orEIxbmkBpv+0o4BJ1y/3/sUpl2j93HLur+0a11mAgzpM241Ayv7JgG8cDc3lmz8+qJAjs84YzwLfPdI8e8g1qrjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014317; c=relaxed/simple;
	bh=w3b81BINy6cuywsBEmSWnMLiLapSFSJQeclqLuh5IrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeureMRG7ckDfKzuAwShUFGyNsq9NFwDTbtOU4o14/KHGFTywzFpHOXPhd64Y6PDPNBZj9dbOsWqnZfJj4/1msn24vud3hP4XyqkbKT8CUPySK/+QAkhYU0SsAAemDtSIK6cZd/Z1uKGIx1s8tll8cQsRJjPnjiLqQS71ArUsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLIrHqo+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLIrHqo+"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e92ce28278so1902268f8f.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014313; x=1758619113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JZqTsgfrN4Mdq/ciTuNp94ECK7776zy3znsgG/k5aUA=;
        b=WLIrHqo+CBoN1alrHBbbPOH/u5ruylZuJjSdMuxdOIBKC0ZApEv3/q/kK4RBnOONFO
         N/kgpjKhfKc4qzA2TwmSz4kptvWVaDsHl6n/haosrnxtZN3cRfhgPH4iLixEtv/+28Xv
         UOBkEwM/8kte5v8Pjz26bSzI11BzF6dF/g1vyaHZc8tyWDDIp0x3FzL51fdr3RpiFa77
         jBUqw9DvMjRTnBvqPW6jnVRI9dgtW5k4lb6i7Q90GbkcY/KE9KKUx7Ualkcg5pXvgcaK
         OVo8RQD/TpoG/9Z38EE/ejWaI0rm+a7RdSSWI1jeAexxcCw27IbA6XJEXySFZc46rixM
         lfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014313; x=1758619113;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZqTsgfrN4Mdq/ciTuNp94ECK7776zy3znsgG/k5aUA=;
        b=nUn2vpkLIH5wD9v/BnzsVvNedDS6mKt57fY0Hdbumq/czKOjK/xKSBdbXUwmBXkP0h
         GxwTQRvLgHqQRRhDgVRg4xziOyTMeQPOcsy5jR8pnOVMeKAuQUALd6O+1Dx/Rf+PuNDi
         DwtXR5K718OfCRi1IKxq2UvgCK9T2m37wTA4gFbMbdldHNHxbY04YlzINdLI+q2EXdOH
         Zv5Iqcq12koXEdmsI6QhcCV683bZrGP7hESi3Pr8JIJVhJ7TbYUgTiyoR1EXT7ss16F7
         lkZeHTa3ZduUGylAZ4XB48gCzmwXPpJiHdsnAnBtKRx2ZNVOxVtAdd2y5iJLwA1y0PN+
         pt6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUc0nXKqCv5dLyPVidvfAwKk5o6nrEWJ2rz8ZbNFt7giZd2YgqX9PV7pdrbssZzU3yuwYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTRQ2Y+tKzQTM6AIIreN13DacgErNn8e8jgUK5gxNtNCWvWC2W
	9SDg5G2AH+mykMFc74riTh0phXLqulzQRUMfAu2oFZRwgATMnUSlZxxX
X-Gm-Gg: ASbGnctx5Vvgx/+f9vFV1L+7h37cisIVH0/zTZ9FgNfMA5BBj/ri1NkIZfkfkqR9grb
	k0WZz4dijP22oHMLYBUFpINZcXDEewXdbuikHkZfLS28mOqE5bEVfgVnU1UlPQ8lsdNi4x88m7S
	Qly3lSvbTClBzqfJj1ELjUOGjhv4XiBIDkRxa7HTtsg4J3p2Zyp/B9ipegWczhDiZ83sQolVluc
	a+LiAWYAbSKXamAHoc3/atmTE8BCqaSXLSiKxly5aIZW+UhVaFm8nPRxnjB2D4E3FMABVDNtfBm
	GCYdjnei/M+5GbKOTklayDouVeKxv83jvEom+0dF2y01r+fcLr5D94yi35U6oEDQC/zXUc1jd+X
	t+NIVv2ijWLxIiBnHPry2snyhPL+kNK8f7WmSRBySLRi8xfpneakR97iTQDnoEI4MiQs03OLe8z
	U=
X-Google-Smtp-Source: AGHT+IF+lTENC3BiaahNAujuTcqHHe0sUmMraPYFLS3v2OuTqX21tRE6+GGz0DrTDLkvd3h7aa7mvw==
X-Received: by 2002:a05:6000:1865:b0:3ec:42ad:595 with SMTP id ffacd0b85a97d-3ec42ad06d6mr1559105f8f.4.1758014312815;
        Tue, 16 Sep 2025 02:18:32 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm15059639f8f.27.2025.09.16.02.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 02:18:31 -0700 (PDT)
Message-ID: <25836bc2-db3a-4761-b13d-c587728f4c3c@gmail.com>
Date: Tue, 16 Sep 2025 10:18:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] stash: honor stash.index in apply, pop modes
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Glen Choo <glencbz@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, John Cai <johncai86@gmail.com>,
 Denton Liu <liu.denton@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?=
 =?UTF-8?Q?mason?= <avarab@gmail.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
 <cover.1757982870.git.ben.knoble+github@gmail.com>
 <585e124467dcb1ec1de71fa72e749140d44dc367.1757982870.git.ben.knoble+github@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <585e124467dcb1ec1de71fa72e749140d44dc367.1757982870.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 16/09/2025 01:37, D. Ben Knoble wrote:
> With stash.index=true, git-stash(1) command now tries to reinstate the
> index by default in the "apply" and "pop" modes. Not doing so creates a
> common trap [1], [2]: "git stash apply" is not the reverse of "git stash
> push" because carefully staged indices are lost and have to be manually
> recreated. OTOH, this mode is not always desirable and may create more
> conflicts when applying stashes. As usual, "--no-index" will disable
> this behavior if you set "stash.index".

I don't have a strong opinion either way on the new config setting but I 
do think we should rationalize the new tests. Assuming we already have 
good coverage for "git stash pop --index" then all we need to do is 
check that "git -c stash.index=true stash pop", "git -c stash.index=true 
stash pop --no-index" and "git -c stash.index=false stash pop --index". 
We don't need an exhaustive list of tests that check the config setting 
in scenarios like "create twos stashes, drop the second one and apply 
the first". Tests like that add no new coverage for the changes in this 
patch and slow the test suite down.

Thanks

Phillip
> [1]: https://lore.kernel.org/git/CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com/
> [2]: https://lore.kernel.org/git/c5a811ac-8cd3-c389-ac6d-29020a648c87@gmail.com/
> 
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
>   Documentation/config/stash.adoc    |   5 +
>   builtin/stash.c                    |   9 +-
>   t/t3903-stash.sh                   | 155 +++++++++++++++++++++++++++++
>   t/t3904-stash-patch.sh             |  11 ++
>   t/t3905-stash-include-untracked.sh |  48 ++++++++-
>   5 files changed, 225 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config/stash.adoc b/Documentation/config/stash.adoc
> index ec1edaeba6..e556105a15 100644
> --- a/Documentation/config/stash.adoc
> +++ b/Documentation/config/stash.adoc
> @@ -1,3 +1,8 @@
> +stash.index::
> +	If this is set to true, `git stash apply` and `git stash pop` will
> +	behave as if `--index` was supplied. Defaults to false. See the
> +	descriptions in linkgit:git-stash[1].
> +
>   stash.showIncludeUntracked::
>   	If this is set to true, the `git stash show` command will show
>   	the untracked files of a stash entry.  Defaults to false. See
> diff --git a/builtin/stash.c b/builtin/stash.c
> index d9b478d1d1..8a0eef3c70 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -130,6 +130,7 @@ static struct strbuf stash_index_path = STRBUF_INIT;
>   static int show_stat = 1;
>   static int show_patch;
>   static int show_include_untracked;
> +static int use_index;
>   
>   /*
>    * w_commit is set to the commit containing the working tree
> @@ -662,7 +663,7 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
>   {
>   	int ret = -1;
>   	int quiet = 0;
> -	int index = 0;
> +	int index = use_index;
>   	struct stash_info info = STASH_INFO_INIT;
>   	struct option options[] = {
>   		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> @@ -759,7 +760,7 @@ static int pop_stash(int argc, const char **argv, const char *prefix,
>   		     struct repository *repo UNUSED)
>   {
>   	int ret = -1;
> -	int index = 0;
> +	int index = use_index;
>   	int quiet = 0;
>   	struct stash_info info = STASH_INFO_INIT;
>   	struct option options[] = {
> @@ -864,6 +865,10 @@ static int git_stash_config(const char *var, const char *value,
>   		show_include_untracked = git_config_bool(var, value);
>   		return 0;
>   	}
> +	if (!strcmp(var, "stash.index")) {
> +		use_index = git_config_bool(var, value);
> +		return 0;
> +	}
>   	return git_diff_basic_config(var, value, ctx, cb);
>   }
>   
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index b8936a653b..1d53a94165 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -111,6 +111,19 @@ setup_stash()
>   	test 1 = $(git show HEAD:file)
>   '
>   
> +test_expect_success 'apply stashed changes with stash.index' '
> +	test_config stash.index true &&
> +	git reset --hard HEAD^ &&
> +	echo 5 >other-file &&
> +	git add other-file &&
> +	test_tick &&
> +	git commit -m other-file &&
> +	git stash apply &&
> +	test 3 = $(cat file) &&
> +	test 2 = $(git show :file) &&
> +	test 1 = $(git show HEAD:file)
> +'
> +
>   test_expect_success 'apply stashed changes (including index)' '
>   	git reset --hard HEAD^ &&
>   	echo 6 >other-file &&
> @@ -150,6 +163,21 @@ setup_stash()
>   	test 1 = $(git show HEAD:file)
>   '
>   
> +test_expect_success 'drop top stash with stash.index' '
> +	test_config stash.index true &&
> +	git reset --hard &&
> +	git stash list >expected &&
> +	echo 7 >file &&
> +	git stash &&
> +	git stash drop &&
> +	git stash list >actual &&
> +	test_cmp expected actual &&
> +	git stash apply &&
> +	test 3 = $(cat file) &&
> +	test 2 = $(git show :file) &&
> +	test 1 = $(git show HEAD:file)
> +'
> +
>   test_expect_success 'drop middle stash' '
>   	git reset --hard &&
>   	echo 8 >file &&
> @@ -170,6 +198,27 @@ setup_stash()
>   	test 1 = $(git show HEAD:file)
>   '
>   
> +test_expect_success 'drop middle stash with stash.index' '
> +	test_config stash.index true &&
> +	git reset --hard &&
> +	echo 8 >file &&
> +	git stash &&
> +	echo 9 >file &&
> +	git stash &&
> +	git stash drop stash@{1} &&
> +	test 2 = $(git stash list | wc -l) &&
> +	git stash apply &&
> +	test 9 = $(cat file) &&
> +	test 1 = $(git show :file) &&
> +	test 1 = $(git show HEAD:file) &&
> +	git reset --hard &&
> +	git stash drop &&
> +	git stash apply &&
> +	test 3 = $(cat file) &&
> +	test 2 = $(git show :file) &&
> +	test 1 = $(git show HEAD:file)
> +'
> +
>   test_expect_success 'drop middle stash by index' '
>   	git reset --hard &&
>   	echo 8 >file &&
> @@ -236,6 +285,17 @@ setup_stash()
>   	test 0 = $(git stash list | wc -l)
>   '
>   
> +test_expect_success 'stash pop with stash.index' '
> +	test_config stash.index true &&
> +	git reset --hard &&
> +	setup_stash &&
> +	git stash pop &&
> +	test 3 = $(cat file) &&
> +	test 2 = $(git show :file) &&
> +	test 1 = $(git show HEAD:file) &&
> +	test 0 = $(git stash list | wc -l)
> +'
> +
>   cat >expect <<EOF
>   diff --git a/file2 b/file2
>   new file mode 100644
> @@ -328,6 +388,22 @@ setup_stash()
>   	test_must_be_empty output.out
>   '
>   
> +test_expect_success 'pop -q works and is quiet with stash.index' '
> +	# Added file, deleted file, modified file all staged for commit
> +	echo foo >new-file &&
> +	echo test >file &&
> +	git add new-file file &&
> +	git rm other-file &&
> +	git stash &&
> +
> +	test_config stash.index true &&
> +	git stash pop -q >output.out 2>&1 &&
> +	echo test >expect &&
> +	git show :file >actual &&
> +	test_cmp expect actual &&
> +	test_must_be_empty output.out
> +'
> +
>   test_expect_success 'pop -q --index works and is quiet' '
>   	echo foo >file &&
>   	git add file &&
> @@ -1178,6 +1254,19 @@ setup_stash()
>   	test_path_is_file bar
>   '
>   
> +test_expect_success 'stash -- <pathspec> stashes and restores the file with stash.index' '
> +	test_config stash.index true &&
> +	>foo &&
> +	>bar &&
> +	git add foo bar &&
> +	git stash push -- foo &&
> +	test_path_is_file bar &&
> +	test_path_is_missing foo &&
> +	git stash pop --no-index &&
> +	test_path_is_file foo &&
> +	test_path_is_file bar
> +'
> +
>   test_expect_success 'stash -- <pathspec> stashes in subdirectory' '
>   	mkdir sub &&
>   	>foo &&
> @@ -1194,6 +1283,24 @@ setup_stash()
>   	test_path_is_file bar
>   '
>   
> +test_expect_success 'stash -- <pathspec> stashes in subdirectory with stash.index' '
> +	test_config stash.index true &&
> +	rm -r sub &&
> +	mkdir sub &&
> +	>foo &&
> +	>bar &&
> +	git add foo bar &&
> +	(
> +		cd sub &&
> +		git stash push -- ../foo
> +	) &&
> +	test_path_is_file bar &&
> +	test_path_is_missing foo &&
> +	git stash pop --no-index &&
> +	test_path_is_file foo &&
> +	test_path_is_file bar
> +'
> +
>   test_expect_success 'stash with multiple pathspec arguments' '
>   	>foo &&
>   	>bar &&
> @@ -1209,6 +1316,22 @@ setup_stash()
>   	test_path_is_file extra
>   '
>   
> +test_expect_success 'stash with multiple pathspec arguments with stash.index' '
> +	test_config stash.index true &&
> +	>foo &&
> +	>bar &&
> +	>extra &&
> +	git add foo bar extra &&
> +	git stash push -- foo bar &&
> +	test_path_is_missing bar &&
> +	test_path_is_missing foo &&
> +	test_path_is_file extra &&
> +	git stash pop --no-index &&
> +	test_path_is_file foo &&
> +	test_path_is_file bar &&
> +	test_path_is_file extra
> +'
> +
>   test_expect_success 'stash with file including $IFS character' '
>   	>"foo bar" &&
>   	>foo &&
> @@ -1224,6 +1347,22 @@ setup_stash()
>   	test_path_is_file bar
>   '
>   
> +test_expect_success 'stash with file including $IFS character with stash.index' '
> +	test_config stash.index true &&
> +	>"foo bar" &&
> +	>foo &&
> +	>bar &&
> +	git add foo* &&
> +	git stash push -- "foo b*" &&
> +	test_path_is_missing "foo bar" &&
> +	test_path_is_file foo &&
> +	test_path_is_file bar &&
> +	git stash pop --no-index &&
> +	test_path_is_file "foo bar" &&
> +	test_path_is_file foo &&
> +	test_path_is_file bar
> +'
> +
>   test_expect_success 'stash with pathspec matching multiple paths' '
>   	echo original >file &&
>   	echo original >other-file &&
> @@ -1312,6 +1451,22 @@ setup_stash()
>   	test_path_is_file bar
>   '
>   
> +test_expect_success 'stash without verb with pathspec with stash.index' '
> +	test_config stash.index true &&
> +	>"foo bar" &&
> +	>foo &&
> +	>bar &&
> +	git add foo* &&
> +	git stash -- "foo b*" &&
> +	test_path_is_missing "foo bar" &&
> +	test_path_is_file foo &&
> +	test_path_is_file bar &&
> +	git stash pop --no-index &&
> +	test_path_is_file "foo bar" &&
> +	test_path_is_file foo &&
> +	test_path_is_file bar
> +'
> +
>   test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
>   	git reset &&
>   	>foo &&
> diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
> index ae313e3c70..fe402f6ab5 100755
> --- a/t/t3904-stash-patch.sh
> +++ b/t/t3904-stash-patch.sh
> @@ -42,6 +42,17 @@
>   	verify_state dir/foo work head
>   '
>   
> +test_expect_success 'git stash -p with stash.index' '
> +	test_config stash.index true &&
> +	set_state HEAD HEADfile_work HEADfile_index &&
> +	set_state dir/foo work index &&
> +	test_write_lines y n y | git stash save -p &&
> +	git reset --hard &&
> +	git stash apply &&
> +	verify_state HEAD HEADfile_work HEADfile_index &&
> +	verify_state dir/foo head index
> +'
> +
>   test_expect_success 'git stash -p --no-keep-index' '
>   	set_state HEAD HEADfile_work HEADfile_index &&
>   	set_state bar bar_work bar_index &&
> diff --git a/t/t3905-stash-include-untracked.sh b/t/t3905-stash-include-untracked.sh
> index 7704709054..5407f11030 100755
> --- a/t/t3905-stash-include-untracked.sh
> +++ b/t/t3905-stash-include-untracked.sh
> @@ -7,7 +7,7 @@
>   
>   . ./test-lib.sh
>   
> -test_expect_success 'stash save --include-untracked some dirty working directory' '
> +setup() {
>   	echo 1 >file &&
>   	git add file &&
>   	test_tick &&
> @@ -23,6 +23,10 @@
>   	git stash --include-untracked &&
>   	git diff-files --quiet &&
>   	git diff-index --cached --quiet HEAD
> +}
> +
> +test_expect_success 'stash save --include-untracked some dirty working directory' '
> +	setup
>   '
>   
>   test_expect_success 'stash save --include-untracked cleaned the untracked files' '
> @@ -108,6 +112,32 @@
>   	test_cmp untracked_expect untracked/untracked
>   '
>   
> +test_expect_success 'stash pop after save --include-untracked leaves files untracked again with stash.index' '
> +	git init repo &&
> +	test_when_finished rm -r repo &&
> +	(
> +		cd repo &&
> +		git config stash.index true &&
> +		setup &&
> +		cat >expect <<-EOF &&
> +		MM file
> +		?? HEAD
> +		?? actual
> +		?? expect
> +		?? file2
> +		?? untracked/
> +		EOF
> +
> +		git stash pop &&
> +		git status --porcelain >actual &&
> +		test_cmp expect actual &&
> +		echo 1 >expect_file2 &&
> +		test_cmp expect_file2 file2 &&
> +		echo untracked >untracked_expect &&
> +		test_cmp untracked_expect untracked/untracked
> +	)
> +'
> +
>   test_expect_success 'clean up untracked/ directory to prepare for next tests' '
>   	git clean --force --quiet -d
>   '
> @@ -221,6 +251,22 @@
>   	test_path_is_file bar
>   '
>   
> +test_expect_success 'stash push with $IFS character with stash.index' '
> +	test_config stash.index true &&
> +	>"foo bar" &&
> +	>foo &&
> +	>bar &&
> +	git add foo* &&
> +	git stash push --include-untracked -- "foo b*" &&
> +	test_path_is_missing "foo bar" &&
> +	test_path_is_file foo &&
> +	test_path_is_file bar &&
> +	git stash pop --no-index &&
> +	test_path_is_file "foo bar" &&
> +	test_path_is_file foo &&
> +	test_path_is_file bar
> +'
> +
>   test_expect_success 'stash previously ignored file' '
>   	cat >.gitignore <<-EOF &&
>   	ignored

