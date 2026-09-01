Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D8739A054
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270154; cv=none; b=VFY5bwyAfhZszLfwSl9IJPz9am3dCvRVKr5M/1bpwtoMZNAiGkD8zvVw2r3g6diz+XzyreuXOiHErBxKWspZII0zOhzYIuz6lR0kscv0XCM5PXX1rMN6QVAKG1nvLqTD1sJhfLKtzkbyOkX8r1ZuGzX2DU/O0m3LKx4WilQamt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270154; c=relaxed/simple;
	bh=ujpTBYQlkHh3U++bmc3wlVk7dBoU07Jg8e+J+tReiuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPJtvmbZNHyVM/N9hOySDzOE0r2NNdSQnJXEagwBz8ct63B5asVLrFH9Ukf2IKARnFBT/5nr5H93+h0YXAYIDVQ0bwQR6VkLNkMTzYoTVjNh8y+cr2P1+D3TFtPZ5Jqvr7M4S1UGK74SHMv52jvyIzAY+dP1oC6MnadKkEQ5eO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvviSFJS; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvviSFJS"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so812010a12.1
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788270151; x=1788874951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vBkmU717wbpYkcW1PgEHKDxlMx9DLiT9jI5z/Ry+GeM=;
        b=gvviSFJSDMenQMvQoF0ypFC1sWEM17L6TEwUZvYIub1v0hsE/MukA4LTkH43jtEvOj
         YsrCimwa8YxeXXCkl4RVA1F9+GyeOx0CAQWiL12qkwoHSLX5WbLDvVeM5+4kLfauBweX
         0kHSp6uvQ2jRF4iPl31xlEHa1HvHkiAmehLZQLZRxXqicwLpXRJl0o7i9vI5ES7voNNq
         m8yJti35vd9IOAhBvubJFgf1WPomLToGtWbSPk4ATOwxtw9DwuSvxF9jkekPKtDb0JYv
         YQ+J77qsbaXx0JVm5UsvtagrYM/5IdgvK9RtG/XOJwRt2MdoGfWUg67bC84tCV+B/mw4
         9rBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270151; x=1788874951;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vBkmU717wbpYkcW1PgEHKDxlMx9DLiT9jI5z/Ry+GeM=;
        b=VUGGI6JFiyKn52o+e3CInFFJUIZvk+M0iSO8AHWt+jHEyDnnDiqpJqm3G92Om3DIjd
         I2+jNFjAhXRZycyyGG6D3ltDkM5z6GIWv42tHKsbz5qDoQUXtqzHYKpBmfhWG//GDnvH
         h53iPDQ9clfk7rmU/2gvo81aPGuxn4/22TPNd6CGhx5lIC3emWZf4wIoBNxYy2KZGBg2
         cDJLr3J2gCEwkbg8SNQXZPK2Ulr58JGeRsCH+QhRbSPx7CBsTrKZF0Ngtf10iVAcGgfA
         fpymXsR0KCbmtq4SxUGQm0HBeZ5tAn58vs7KRa2LWxZXBr5dxESbAX1vG9OfbKp7ByMg
         gqwA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6zXNHyOuINYQ35W041cnSYyr8i53u8CLpYKY8TXonpmBxTtImdY4+5lRA0M7fT2mPK14=@vger.kernel.org
X-Gm-Message-State: AFuF++k9rPbCg4D6NaU3xTF+uaeSIWdNd9fG2dXXQMj5uvbnD3FPcq59
	NTU8vStB7bRQ4j1n66JxDCmwHuzDnepfbPf+lVnyb1zu9TnhexaWrCuuANxEdQ==
X-Gm-Gg: AR+sD13FTxtbV8ihiyEjaAFCcys07CwuY/vydFwfKIy0Dd4Bh8fTefpiKaCLbBHAB9Y
	0PB/rrOW7N2TjfS6HZ7VZnaalCVVTpEl2OrNotVmZkOghhQ5DT2iAl48L6wYDlXBQjFR6LDEPkJ
	U+VNC1fK9oyaFfWkigxaW2P/kyOx8QU9xSUUHjBPaiBT2OVi+QPnS4m2N78WGEsFXVVV+JxdQP+
	7SkKstygEaElk+qNwyttb9Lumiqs4CkXFBzSQX4/ueq4eXfaWos0tW0+pawSc7OCAJXmOVNg7gx
	YgWiBs1Zk3QeXG0N2D4/n9XylDKIUCAtr+d99uD2f6tlehX4AvkTjeyxDo1V8LfYaupylkT247S
	OwvcFwVRDSOW36VX36Jh5FOtIxcrQdfknvxqOHVEn4BRlaDUlXZgMkYq6gsriohCvckVLj3CnIP
	vY1vSvYdZAAmJDJe7SCQn1nMw0v5LRkICGZDHV7qDsSJs2NDWU9zgLmLkgQ0GXBgtqvcGpnfLsr
	bsce5GsSyE+YRtmi5bZlZOcfAHoRmdwdHqmnd9gNmDF
X-Received: by 2002:a17:906:4ed4:b0:c25:6c9a:88bc with SMTP id a640c23a62f3a-c25b3d8a1d8mr460578066b.19.1788270150769;
        Tue, 01 Sep 2026 06:42:30 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee2851csm602524966b.14.2026.09.01.06.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 06:42:29 -0700 (PDT)
Message-ID: <7dbebce0-1814-4b0b-8167-6a464d893612@gmail.com>
Date: Tue, 1 Sep 2026 14:42:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] checkout: separate autostash conflict advice from
 branch-switch message
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2364.git.git.1784993669.gitgitgadget@gmail.com>
 <pull.2364.v3.git.git.1788256199679.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2364.v3.git.git.1788256199679.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 01/09/2026 10:49, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> "git checkout -m" stashes the user's local changes when it cannot
> perform the checkout, and then applies the stash.  When applying the
> stash results in conflicts, the advice on how to deal with them is
> printed directly on top of the branch-switch message ("Switched to
> branch ..."), making the two hard to tell apart.  Print a blank line
> in between so that the advice and the branch-switch message are
> visually distinct.
> 
> To make this possible, "git stash apply", "pop" and "branch" now exit
> with status 2 when applying the stash entry resulted in conflicts, in
> which case the stash entry is left in place; other failures exit with
> status 1, as before.  The exit statuses are documented in the "git
> stash" documentation.

Other commands such as merge-tree and merge strategies use 1 to indicate 
conflicts and another non-zero exit code for errors. That matches the 
way grep and diff use the exit code to distinguish differences from 
errors. It is confusing if we start using a different convention here. 
I've left a few comments below, but the exit code is my main concern. It 
would be nice to separate out the stash changes into a separate commit 
as well.

> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
> index 50bb89f483..3e41ffcf43 100644
> --- a/Documentation/git-stash.adoc
> +++ b/Documentation/git-stash.adoc
> @@ -426,6 +426,15 @@ include::includes/cmd-config-section-all.adoc[]
>   :git-stash: 1
>   include::config/stash.adoc[]
>   
> +EXIT STATUS
> +-----------
> +
> +The `git stash` subcommands exit with status 0 on success and non-zero
> +on failure.  The subcommands that apply a stash entry, i.e. `apply`,
> +`pop` and `branch`, exit with status 2 when applying the stash entry
> +resulted in conflicts, in which case the stash entry is left in place.
> +Other failures exit with status 1 (usage errors exit with status 129).

Thanks for documenting this, I think we'd be better to avoid giving 
specific exit codes for errors and say "a non-zero exit code other than 
1" unless we have a good way of enforcing that.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 72c52571f8..86c7ac4ffa 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -10,6 +10,7 @@
>   #include "object-name.h"
>   #include "parse-options.h"
>   #include "refs.h"
> +#include "stash.h"
>   #include "lockfile.h"
>   #include "cache-tree.h"
>   #include "unpack-trees.h"
> @@ -640,8 +641,9 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
>   		die(_("could not write index"));
>   }
>   
> -static int do_apply_stash(const char *prefix, struct stash_info *info,
> -			  int index, int quiet,
> +static enum stash_apply_result do_apply_stash(const char *prefix,
> +					      struct stash_info *info,
> +					      int index, int quiet,
>   			  const char *label_ours, const char *label_theirs,
>   			  const char *label_base)

The indentation is strange here

>   {
> @@ -716,11 +718,12 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>   	clean = merge_ort_nonrecursive(&o, head, merge, merge_base);
>   
>   	/*
> -	 * If 'clean' >= 0, reverse the value for 'ret' so 'ret' is 0 when the
> -	 * merge was clean, and nonzero if the merge was unclean or encountered
> -	 * an error.
> +	 * Translate the value of 'clean' so 'ret' is STASH_APPLY_CLEAN
> +	 * when the merge was clean, STASH_APPLY_CONFLICT when it was
> +	 * unclean, and a negative value if it encountered an error.
>   	 */
> -	ret = clean >= 0 ? !clean : clean;
> +	ret = clean >= 0 ? (clean ? STASH_APPLY_CLEAN : STASH_APPLY_CONFLICT)
> +			 : clean;

Nested ternary operators are not particularly readable, if we stick with 
an exit code of 1 for conflicts the original code does not need to be 
modified.

>   
>   	if (ret < 0)
>   		rollback_lock_file(&lock);
> @@ -739,7 +742,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>   
>   	if (has_index) {
>   		if (reset_tree(&index_tree, 0, 0))
> -			ret = -1;
> +			ret = STASH_APPLY_ERROR;

This seems a bit pointless when we're still returning -1 implicitly 
everywhere else where we have "return error(...).


>   	} else {
>   		unstage_changes_unless_new(&c_tree);
>   	}
> @@ -2492,9 +2495,13 @@ int cmd_stash(int argc,
>   	strbuf_addf(&stash_index_path, "%s.stash.%" PRIuMAX, index_file,
>   		    (uintmax_t)pid);
>   
> -	if (fn)
> -		return !!fn(argc, argv, prefix, repo);
> -	else if (!argc)
> +	if (fn) {
> +		ret = fn(argc, argv, prefix, repo);
> +
> +		if (ret < 0)
> +			return 1;
> +		return ret;

Looking at the callers of do_apply_stash(), apply_stash() returns the 
result of do_apply_stash(), pop_stash() and branch_stash() return the 
result of do_drop_stash() if do_apply_stash() returns 0. do_drop_stash() 
always returns 0 so we're safe, but that analysis should be in the 
commit message.


> @@ -4832,13 +4837,15 @@ static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
>   		strvec_push(&store.args, stash_oid);
>   		if (run_command(&store))
>   			ret = error(_("cannot store %s"), stash_oid);
> -		else if (attempt_apply)
> +		else if (attempt_apply && ret == STASH_APPLY_CONFLICT)
>   			fprintf(stderr,
>   				_("Your local changes are stashed, however applying them\n"
>   				  "resulted in conflicts.  You can either resolve the conflicts\n"
>   				  "and then discard the stash with \"git stash drop\", or, if you\n"
>   				  "do not want to resolve them now, run \"git reset --hard\" and\n"
>   				  "apply the local changes later by running \"git stash pop\".\n"));

We only print this if we know there were conflicts - good.

> +		else if (attempt_apply)
> +			ret = error(_("could not apply autostash"));

We know we've saved the stash so we should tell the user that we have, 
rather than leaving when wondering what's happened to their stashed changes.

The rest of the changes in this file look good.

> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index da27a6599a..93e8e98216 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1797,7 +1797,7 @@ test_expect_success 'apply with custom conflict labels' '
>   	echo stashed >conflict-file &&
>   	git stash push -m "stashed" &&
>   	test_commit label-upstream conflict-file upstream-content &&
> -	test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
> +	test_expect_code 2 git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
>   	test_grep "^<<<<<<< UP" conflict-file &&
>   	test_grep "^||||||| Stash base" conflict-file &&
>   	test_grep "^>>>>>>> STASH" conflict-file
> @@ -1809,11 +1809,33 @@ test_expect_success 'apply with empty conflict labels' '
>   	echo stashed >conflict-file &&
>   	git stash push -m "stashed" &&
>   	test_commit empty-label-upstream conflict-file upstream-content &&
> -	test_must_fail git stash apply --label-ours= --label-theirs= &&
> +	test_expect_code 2 git stash apply --label-ours= --label-theirs= &&
>   	test_grep "^<<<<<<<$" conflict-file &&
>   	test_grep "^>>>>>>>$" conflict-file
>   '
>   
> +test_expect_success 'apply exits 2 on conflicts and keeps the stash entry' '

Aren't we testing that above?

> +	git reset --hard initial &&
> +	test_commit exit-code-base conflict-file base-content &&

We've just reset to a known starting point that has paths file and 
other-file, so why do we need to create a new commit in order to stash 
something?

> +	echo stashed >conflict-file &&
> +	git stash push -m stashed &&
> +	test_commit exit-code-upstream conflict-file upstream-content &&
> +	test_expect_code 2 git stash apply &&
> +	git stash list >list &&
> +	test_grep stashed list
> +'
> +
> +test_expect_success 'pop exits 2 on conflicts and keeps the stash entry' '

This is good, we should be checking "stash branch" as well.

> diff --git a/t/t7201-co.sh b/t/t7201-co.sh
> index 0ddd1ad7aa..9ea9462914 100755
> --- a/t/t7201-co.sh
> +++ b/t/t7201-co.sh
> @@ -236,10 +236,18 @@ test_expect_success 'checkout -m creates a recoverable stash on conflict' '
>   	test_must_fail git checkout side 2>stderr &&
>   	test_grep "Your local changes" stderr &&
>   	git checkout -m side >actual 2>&1 &&
> -	test_grep "resulted in conflicts" actual &&
> -	test_grep "git stash drop" actual &&
> -	test_grep "git stash pop" actual &&
> -	test_grep "The following paths have local changes" actual &&
> +	cat >expect <<-EOF &&
> +	Your local changes are stashed, however applying them
> +	resulted in conflicts.  You can either resolve the conflicts
> +	and then discard the stash with "git stash drop", or, if you
> +	do not want to resolve them now, run "git reset --hard" and
> +	apply the local changes later by running "git stash pop".
> +
> +	Switched to branch ${SQ}side${SQ}
> +	The following paths have local changes:
> +	M	one
> +	EOF
> +	test_cmp expect actual &&

Nice, it is much easier to see what we're checking now

Thanks

Phillip

