Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94E377EDC
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363555; cv=none; b=JXDwCDANNwc9Jv+jxS2Dzoo4zeQbsOtSpG4qSfg5dqsRzzZxBEDBPOu8yytTg4ukxI34pEEnV1RfZs6X52wPCFSMfkdmcjR8hGzGJcvAomDAKpTPO52cx2fDFGD8pO8YWxyH4XlLTUwxaL2PTCeEZsyRUbGqaFUruoeXdQOhxb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363555; c=relaxed/simple;
	bh=0X+g+Jrl6fiYNW/uhNAQY1Wrj6ab1uHlJ8xOPMoW+Oo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dWtNLTneqIzzK6bUBWZMPGoWwoFrwz1mMPWZCs2BugbSr16wiF3++jRxFfU7IXXn6OlcmWRtozyRchrRWIP4QBfFsmL47PJNJdbeus/YbQtNg2rfmZN1s34AjegTkSmdPXJIjHxA9KWnz5a+cRKUbKwRlrBDVWaBVb7iUuP0sZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDkc9sxX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDkc9sxX"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-482f9309813so1211764f8f.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788363551; x=1788968351; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qH9eTjTIYI82TpXjQ6tVKF5LY71MrwnInOJQ6Kaxg3Y=;
        b=cDkc9sxXbpZOF0drP23pkEBvOJx1qYYV3q+aOCC+P9k+OKACe8xPnHXbfCt//Df970
         DxnjOwz/gWp/cImFUL1sucdyE+aO29ik/Kd8D98WnBStEBbdJ3lBtkK5Hx1O/BLfnqKj
         XzBrBz87yvHizU+cT/eorpO7U7tFAlDWmWt2l8f8hnfxs4nQNIRlQymx2aX66/51Vmgp
         T9MNR0Dblr5IOLDfKJwio5UTV6/79zqKAzT4eILdEtGb1RF4twZ9T6M7I9qh43Frl0Gw
         V9vIepKlULw3JsTZbEgJkS8Ehad3aQn+ILNPgCgn7pKLTyA+axX0pjNRPk4L1xy1TGCq
         T36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788363551; x=1788968351;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qH9eTjTIYI82TpXjQ6tVKF5LY71MrwnInOJQ6Kaxg3Y=;
        b=dvasHtpnK7i002dyVrHTs6MxbIA41JmBEtLUQFV8LEekUUs8xEohF+RISGR1A5Bx9t
         z3DZvH3dOaZKYSosIGqhYkMUM9gbyAKstDYwMhjca7lniFhl2RqhxXBPcDvoCNR5cyiG
         WbFlWvjEvYWkvVo+TLvVyVgRByx9u8AZbhZFTXWeTxCCCON43RjMN1TDwA2sDfT6jjtU
         IEvKO04AHhMnJ1h09etubMU5CSUbWpNSIst4HELv3NxCQGqqq55A/cdFAhiZkElzEUsj
         3eidmG7iaRRfoEXCtQgUDSzQII62dVIMK/vVQqKmGHjIaPXh4Zp/nvfVuq2JsvadGgkO
         98nQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzwcr86SDOtzXOv3vmrGNl2cmawebMzNAtnDMj+UpvJQQyUpPEXoEEC/tU1YAqeNg3iig=@vger.kernel.org
X-Gm-Message-State: AFuF++kye9C38K5zi06QtGyc24TIZ8aMBYSpZ+riJ/Lr7B7QcQA00eu8
	fZ+Z8YPwxbYIAuSnwVPI1jGK+NYoDNlnGoplmNPzQvI+DfYYygRgf4US
X-Gm-Gg: AYBFou1CQiZ00rpzby0bKnMXYYO4n/tPB7qEHFsFFoRaB9//UWifw9GArylmfqNTf/U
	3tOqIWiLUllALOY4+KQTWbAimkH2pqSSVA1K2KhWc5YaTghofY/GjduhtVl8lQi9asWaw8X7vPk
	fCLJgsCx/DktLs1547zbO7pkxERwUc26uW5Xz39YKtN8GOsBkJ0vQaF2y/bEbjrkUdNuEB4htx3
	wS/oFisoM7/wnJUF/JjRmJ6qWvk+6YgEA0giChXXijBz+TSlwPU1gpQQXsMi1RZGGtiESii/I2P
	L+CRHQ2RgygdUEGuJ6f/7FuWSk8t7kYEgq9upiuJDxPSGhekBceGV1e4FYJprRlbw2WNGzLIikd
	HekYhG7ko2EIKMtGGzxUeh7eYjPBtyMgODmQKKjANO3pHaw6Rbpt3/CuzTi+EczBywos/i07J7k
	9Nyg/HXStxkdatlv991M6ZLA7dCNLXVyBRR5eoX3J3xKNz8B6RDfdmI7yYPh7TLi6LI8zyoi4dY
	65MnpocnfhjyvV80jCtzb0brHuDdt+Fpu/xsionPcE=
X-Received: by 2002:a05:6000:186e:b0:47f:8b24:ef01 with SMTP id ffacd0b85a97d-48488deedd2mr10219111f8f.1.1788363550678;
        Wed, 02 Sep 2026 08:39:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eea5b4sm7275212f8f.27.2026.09.02.08.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 08:39:10 -0700 (PDT)
Message-ID: <1c3f07e0-63c0-483d-8e46-e4edbdd6991a@gmail.com>
Date: Wed, 2 Sep 2026 16:39:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/5] commit: clarify FROM_REBASE_PICK and
 is_from_rebase() names
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
 <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
 <bd361679b9144682d664e8cfcf9fc2cbd8511b4d.1788301481.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <bd361679b9144682d664e8cfcf9fc2cbd8511b4d.1788301481.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 01/09/2026 23:24, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> Commit 430b75f7209c (commit: give correct advice for empty commit during
> a rebase, 2019-12-06) introduced a FROM_REBASE_PICK enum value and an
> is_from_rebase() function.  Those names failed to convey that they were
> specifically about hitting a commit that becomes empty when rebasing.
> Clarify their names now.
> 
> While at it, change `whence == FROM_REBASE_NOW_EMPTY` to use
> `is_from_rebase_now_empty(whence)`.

This looks good, the new names are much clearer

Thanks

Phillip

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   builtin/commit.c | 14 +++++++-------
>   sequencer.c      |  2 +-
>   wt-status.h      |  6 +++---
>   3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 28f6174503..17cc27e53e 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -520,7 +520,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
>   			die(_("cannot do a partial commit during a merge."));
>   		else if (is_from_cherry_pick(whence))
>   			die(_("cannot do a partial commit during a cherry-pick."));
> -		else if (is_from_rebase(whence))
> +		else if (is_from_rebase_now_empty(whence))
>   			die(_("cannot do a partial commit during a rebase."));
>   	}
>   
> @@ -893,7 +893,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   	 */
>   	else if (whence == FROM_MERGE)
>   		hook_arg1 = "merge";
> -	else if (is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) {
> +	else if (is_from_cherry_pick(whence) || is_from_rebase_now_empty(whence)) {
>   		hook_arg1 = "commit";
>   		hook_arg2 = "CHERRY_PICK_HEAD";
>   	}
> @@ -1086,7 +1086,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>   		if (amend)
>   			fputs(_(empty_amend_advice), stderr);
>   		else if (is_from_cherry_pick(whence) ||
> -			 whence == FROM_REBASE_PICK) {
> +			 is_from_rebase_now_empty(whence)) {
>   			fputs(_(empty_cherry_pick_advice), stderr);
>   			if (whence == FROM_CHERRY_PICK_SINGLE)
>   				fputs(_(empty_cherry_pick_advice_single), stderr);
> @@ -1333,7 +1333,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   			die(_("You are in the middle of a merge -- cannot amend."));
>   		else if (is_from_cherry_pick(whence))
>   			die(_("You are in the middle of a cherry-pick -- cannot amend."));
> -		else if (whence == FROM_REBASE_PICK)
> +		else if (is_from_rebase_now_empty(whence))
>   			die(_("You are in the middle of a rebase -- cannot amend."));
>   	}
>   	if (fixup_message && squash_message)
> @@ -1353,7 +1353,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   	if (amend && !use_message && !fixup_message)
>   		use_message = "HEAD";
>   	if (!use_message && !is_from_cherry_pick(whence) &&
> -	    !is_from_rebase(whence) && renew_authorship)
> +	    !is_from_rebase_now_empty(whence) && renew_authorship)
>   		die(_("--reset-author can be used only with -C, -c or --amend."));
>   	if (use_message) {
>   		use_message_buffer = read_commit_message(use_message);
> @@ -1362,7 +1362,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
>   			author_message_buffer = use_message_buffer;
>   		}
>   	}
> -	if ((is_from_cherry_pick(whence) || whence == FROM_REBASE_PICK) &&
> +	if ((is_from_cherry_pick(whence) || is_from_rebase_now_empty(whence)) &&
>   	    !renew_authorship) {
>   		author_message = "CHERRY_PICK_HEAD";
>   		author_message_buffer = read_commit_message(author_message);
> @@ -1887,7 +1887,7 @@ int cmd_commit(int argc,
>   		if (!reflog_msg)
>   			reflog_msg = is_from_cherry_pick(whence)
>   					? "commit (cherry-pick)"
> -					: is_from_rebase(whence)
> +					: is_from_rebase_now_empty(whence)
>   					? "commit (rebase)"
>   					: "commit";
>   		commit_list_insert(current_head, &parents);
> diff --git a/sequencer.c b/sequencer.c
> index 65afd100d9..d336c309ca 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6956,7 +6956,7 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
>   		    !repo_get_oid(r, "REBASE_HEAD", &rebase_head) &&
>   		    !repo_get_oid(r, "CHERRY_PICK_HEAD", &cherry_pick_head) &&
>   		    oideq(&rebase_head, &cherry_pick_head))
> -			*whence = FROM_REBASE_PICK;
> +			*whence = FROM_REBASE_NOW_EMPTY;
>   		else
>   			*whence = FROM_CHERRY_PICK_SINGLE;
>   
> diff --git a/wt-status.h b/wt-status.h
> index e9fe32e98c..2143f50b49 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -41,7 +41,7 @@ enum commit_whence {
>   	FROM_MERGE,      /* commit came from merge */
>   	FROM_CHERRY_PICK_SINGLE, /* commit came from cherry-pick */
>   	FROM_CHERRY_PICK_MULTI, /* commit came from a sequence of cherry-picks */
> -	FROM_REBASE_PICK /* commit came from a pick/reword/edit */
> +	FROM_REBASE_NOW_EMPTY /* rebase applied a pick that became empty */
>   };
>   
>   static inline int is_from_cherry_pick(enum commit_whence whence)
> @@ -50,9 +50,9 @@ static inline int is_from_cherry_pick(enum commit_whence whence)
>   		whence == FROM_CHERRY_PICK_MULTI;
>   }
>   
> -static inline int is_from_rebase(enum commit_whence whence)
> +static inline int is_from_rebase_now_empty(enum commit_whence whence)
>   {
> -	return whence == FROM_REBASE_PICK;
> +	return whence == FROM_REBASE_NOW_EMPTY;
>   }
>   
>   struct wt_status_change_data {

