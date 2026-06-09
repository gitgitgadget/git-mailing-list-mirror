Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5722280A56
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011292; cv=none; b=Kb42RfRXncjZfnbZmxG14i0Iku4J0yuzutqD17AKD8+4Ue7GFtwoGrFlW75kfupYJPjYZgLIDA6Lc7ZzNEnOgdj+dOfr41KGgLzpr9G5nuXE08B+1O3QTrW0KjxhFpr5mvboNqpu367z5oVyqHDqhfnSPWq73yncrQPLo6flhJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011292; c=relaxed/simple;
	bh=ifzr0j52/xqvhikPztrertfTdbSV88tWtmlS0n3iqaU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JgdEmWFfPdfLUVeSwefrU/pocsuWq+FWVNvYuP2VsF3PvaDxVWkfbsgzYgsRpuWe/awm7LdRUTAT1DRyqFo5fHVfYUHCc89D+BHJ/GY9VPQWXGrJq/6zxpypDetlIa0H2LvOGZ7LkJAJinbe4kzcifo+7axIbCYs9iJruY0G+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=St2qjtiD; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St2qjtiD"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so10100372a12.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781011289; x=1781616089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vuRshexJTUaHLq/enTCZ4yxq0npqHRzCCXVd+84c5rY=;
        b=St2qjtiDBi7zkp146Lu3+tDZzFPvMHmdz2GQ7wX2vR2syiT2lpP8gSqep6gydEdFEj
         3wGPOfkZTZtbk+3fSZZrEZ07p0YirfCsRYZOG22wVOuiajzfln46PeNB4+p7DP6vFwc2
         g6QEwuqhjxdIea/Jid/KgypU68QDogt/ycGqaYTK9UmH487m4RkVtdqqAwr0duCemfk6
         5NreBmvL7WnMYE2+Pn9tjfUidE5VFoZ0C2IGtP85usrToFO1BZcNMatdTatZ40EPUXm7
         t0tm69UzjFFkB3iVY1+1CfKy0i+jOndRNHHub2iFLoiLqjg5FWT4e+WMm4ksEwD7LG7t
         +F6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781011289; x=1781616089;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuRshexJTUaHLq/enTCZ4yxq0npqHRzCCXVd+84c5rY=;
        b=BmlshDA3bmLILvAV35EWoYrjOBCu1P4vGJoOmkVUrx1FLVM0XmUn5M41ReeUlIdrqD
         jLNHLUKSI4iMSoOyxnT+Os0zaLMDE4CR01A6t34uWkOL5HTdYEV5HD8+/P0SovTSqjK/
         kqZhshTMxSOPKSr28ct5ZC++6Jhuov36g7Jw1JkDcX24Gy5VEHo9+NkEvJbjVShm/FLL
         MJfXVOAnmNmHfr0W+fnunR4WJMUc5btBRJmusqC0E8qkES8IpXRBMH3gjJFpJefd6Ve1
         rYMF43aIbZUFBUe2EouGn8bVZkSCYmY4rGo2M+Cx2QnVnnk6g1qjTLBVeyNGgAiE7AFP
         bd3A==
X-Forwarded-Encrypted: i=1; AFNElJ/wEQDHv5hcRyFAEB6Oz6Uj6SGKu577sJZ64wVdGe2lDdRsSLM3vq17llfvv74HJBWwzIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3lhwqhLpxhZra/UIyECJ6SixETyNOK5ZN41zqE5iGYheAfGeF
	kMoUXIJkP07bjyOg+PS0o1mewIhgDRFdFsqnNEFs7bny2r+ceF9MaER+
X-Gm-Gg: Acq92OEp1tz1hX9zm+wJZORxk2qAOtpe9MCNKfbFXMTOwRDA69SRUqFOj6h3bXE20cw
	ZLfMP5EHJLlZdjR8tda2TEvqQxGo27GJ7JszI0xw2dG2K/wC9MBNcVKrqBjaZdvi37CbHCucxeK
	TtnTNEiULvRTS/06i1RaJGHz+6OKGRny9eA3klzR1nfsVMPXhXnLHNE6EJnKznIDkP1Cpm8NmPs
	ayDDuUfgQn1Dj9Fqww8+2CdwaaxKtEFWy+wS5GY0ZbFEQEU6pYu8h/OAg9CsfVpqiMXfZCGQtpH
	CC36DbI1HS+5nooAFf9Y/n5LU0+53LBK6qoNI50wR1RgvTzVoc48oZpixv96a3BQnssAfsCUoOK
	kLUI10W7XJ1Mb8uW2IMTivx7+kFWtj0nAUXqH/5GQlPMLe/6heLeRpvehMtdvWF7fKkXWjmnJ2P
	E+fFV5b17SXabQcRJ459P4DIgvyttWNKztoGNgObYe5JBIWEusmipJcbjxyJHiW0IhKiyESqh3X
	0Pse3kS2VTm4X/CjfWG+yeTiCg=
X-Received: by 2002:a17:906:4fcf:b0:bce:80db:77ef with SMTP id a640c23a62f3a-bf939b01f48mr140485466b.43.1781011288416;
        Tue, 09 Jun 2026 06:21:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1464sm1057628266b.55.2026.06.09.06.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 06:21:27 -0700 (PDT)
Message-ID: <1c56bf9c-8273-4499-87c8-16ddf0112dca@gmail.com>
Date: Tue, 9 Jun 2026 14:21:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v14 2/6] branch: let delete_branches warn instead of error
 on bulk refusal
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
 <7ef9502e01055fd5442550cf34d491fd21a9b971.1780999917.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <7ef9502e01055fd5442550cf34d491fd21a9b971.1780999917.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 09/06/2026 11:11, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a warn-only mode to delete_branches() and check_branch_commit()
> so a bulk caller can report branches that are not fully merged as a
> short warning and carry on, rather than erroring with the longer
> "use 'git branch -D'" advice that the plain "git branch -d" path
> emits. Existing callers are unaffected.

There is no mention here of the conversion to use a flags argument which 
should be a separate preparatory commit
  > @@ -189,20 +189,33 @@ static int branch_merged(int kind, const char 
*name,
>   	return merged;
>   }
>   
> +enum delete_branch_flags {
> +	DELETE_BRANCH_FORCE = (1 << 0),
> +	DELETE_BRANCH_QUIET = (1 << 1),
> +	DELETE_BRANCH_WARN_ONLY = (1 << 2),
> +};
> +
>   static int check_branch_commit(const char *branchname, const char *refname,
>   			       const struct object_id *oid, struct commit *head_rev,
> -			       int kinds, int force)
> +			       int kinds, unsigned int flags)
>   {
> +	int force = flags & DELETE_BRANCH_FORCE;

This is missing "!!" to keep the value the same (alternatively we could 
perhaps convert "force" to a bool, though I haven't looked too closely 
at how it is used in the rest of the function). Apart from that this 
good, unlike the conversion below it means the rest of the function sees 
the same variables in the same state as it did before the conversion. It 
would be a good idea to follow this pattern for the new flag.

	bool warn = flags & DELETE_BRANCH_WARN_ONLY;

and then just use "warn" later. It is a common pattern in our code to 
take a flags argument and split it out into various boolean variables at 
the start of the function to avoid a lot of awkward bit masks in the 
main body of the function.

> @@ -217,8 +230,8 @@ static void delete_branch_config(const char *branchname)
>   	strbuf_release(&buf);
>   }
>   
> -static int delete_branches(int argc, const char **argv, int force, int kinds,
> -			   int quiet)
> +static int delete_branches(int argc, const char **argv, int kinds,
> +			   unsigned int flags)
>   {
>   	struct commit *head_rev = NULL;
>   	struct object_id oid;
> @@ -227,6 +240,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   	int i;
>   	int ret = 0;
>   	int remote_branch = 0;
> +	int force, quiet;

We should initialize these here using flags so that the rest of the code 
sees the same variables and values as it did before the conversion.

>   	struct strbuf bname = STRBUF_INIT;
>   	enum interpret_branch_kind allowed_interpret;
>   	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
> @@ -241,7 +255,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   		remote_branch = 1;
>   		allowed_interpret = INTERPRET_BRANCH_REMOTE;
>   
> -		force = 1;
> +		flags |= DELETE_BRANCH_FORCE;
>   		break;
>   	case FILTER_REFS_BRANCHES:
>   		fmt = "refs/heads/%s";
> @@ -252,12 +266,15 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   	}
>   	branch_name_pos = strcspn(fmt, "%");
>   
> +	force = flags & DELETE_BRANCH_FORCE;
> +	quiet = flags & DELETE_BRANCH_QUIET;
> +
>   	if (!force)
>   		head_rev = lookup_commit_reference(the_repository, &head_oid);
>   
>   	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
>   		char *target = NULL;
> -		int flags = 0;
> +		int ref_flags = 0;

This is sensible so we don't shadow the new function argument but this 
added complexity is a good reason to split the flags change into its own 
commit before adding the warning flag.

I'll take a look at the other patches later this week - there is no need 
to send a new version before I've commented on the rest of the series.

Thanks

Phillip

>   
>   		copy_branchname(&bname, argv[i], allowed_interpret);
>   		free(name);
> @@ -279,7 +296,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   					     RESOLVE_REF_READING
>   					     | RESOLVE_REF_NO_RECURSE
>   					     | RESOLVE_REF_ALLOW_BAD_NAME,
> -					     &oid, &flags);
> +					     &oid, &ref_flags);
>   		if (!target) {
>   			if (remote_branch) {
>   				error(_("remote-tracking branch '%s' not found"), bname.buf);
> @@ -291,7 +308,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   									   | RESOLVE_REF_NO_RECURSE
>   									   | RESOLVE_REF_ALLOW_BAD_NAME,
>   									   &oid,
> -									   &flags);
> +									   &ref_flags);
>   				FREE_AND_NULL(virtual_name);
>   
>   				if (virtual_target)
> @@ -306,16 +323,17 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   			continue;
>   		}
>   
> -		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
> +		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
>   		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
> -					force)) {
> -			ret = 1;
> +					flags)) {
> +			if (!(flags & DELETE_BRANCH_WARN_ONLY))
> +				ret = 1;
>   			goto next;
>   		}
>   
>   		item = string_list_append(&refs_to_delete, name);
> -		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
> -				    : (flags & REF_ISSYMREF) ? target
> +		item->util = xstrdup((ref_flags & REF_ISBROKEN) ? "broken"
> +				    : (ref_flags & REF_ISSYMREF) ? target
>   				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
>   
>   	next:
> @@ -872,7 +890,9 @@ int cmd_branch(int argc,
>   	if (delete) {
>   		if (!argc)
>   			die(_("branch name required"));
> -		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
> +		ret = delete_branches(argc, argv, filter.kind,
> +				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
> +				      (quiet ? DELETE_BRANCH_QUIET : 0));
>   		goto out;
>   	} else if (show_current) {
>   		print_current_branch_name();

