Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3664D257824
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696736; cv=none; b=SwLdyYESzpaumT74IVQesr+KJUhDRUDclGPmC8Bc4dYhrl4M2JqupvUmyUXmPHQXoXzVG9EMgqPq3Lvki4eoi6dYR18tGE/jP+xNlVdvULP2QHwwglyQtU1p/LOpHBEX0cQx/aPzxLu5THiGE4vL5SDGE6YpnRAR+59R/EzbPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696736; c=relaxed/simple;
	bh=LIyOhkNFvDxN79PDGE1BajfgLRRPmzUD0+iwA/Kho+4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=i6y+Ybz9dhmF9bSsZWobkNEEN/UsHCTT55h2ahKgyxPxhKo+F0XVtSca/OOBUqLayP7JPNn3/lpgm8zwKq/JN0HTQSETyf6svnLN/MA9XKKFI5tkyTYcmGXJHvVvPrKIl3ZMZEB3EcdOjPk6j6qotbXKJx713eYQQDAQTdlR4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iq2ZXaUz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq2ZXaUz"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69a5ecbbfb2so1653556a12.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783696733; x=1784301533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JeK+Kr5HbuG2SxREM0dhvBE5ZB1yO7GuqwzmGVJPdls=;
        b=iq2ZXaUz9h/E5cifOiuWEKqrgWGJ6twC1SbEQnbhGmmAxcs3suoqocUVVZwupQKpD0
         renJ02+xDjSsczU9Ed4ponzH8EGQLxkkMruIBCZ95WpbuZr66+ePVWet5Ve/Z5NcX/ya
         AptFTB94yuTj9/NdaJz3iQI5TtiKqNpmJXuXGDvX7YdldDwdnxJzVZGYy+lGZ78hw7iz
         50YCSrcmLDQ0dJXobGslEACJqVAl+EWwTT7HPQKVWo0MRe8ZvM0uefkd1vlp2KHe46Us
         uj8iL4XJGFDhHJksqNZ3b0gOLYca4USdZ+NY2tndBZl3BwjwjsoR9PAB5oTZtWZqYLsT
         NY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696733; x=1784301533;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JeK+Kr5HbuG2SxREM0dhvBE5ZB1yO7GuqwzmGVJPdls=;
        b=reNhMOAOw7/VqMGGP+ywwNoXHlrmIHmZ6ZgLjICJ6X9qFdBhuFBxnbNKfxqJ2E0nON
         IYFHVll2kiBG1eUppPOa/1Hcu2zqQ5NCpscw0Q0/J87gxgS/oRi92zPOIKVOKA1PP/pX
         UTbSBcuspB5iTua7TWZV23Qa9AicDVQNXKrvFji0F2OsLuG+YLfkhTUwWnh6IewhFDhn
         EpbRGYOUkKsuZJs1yuaizDOGqGwtNKuVKMKFBhPi7q3FKr+m7y6csoVu/hM+9YzCES7Z
         8FRUEZcQH/jfg001HHFwcf5Ctfc5QVt7UsGzKT6JN5rdxEnTR8FRev8acxHGkHWvZI0r
         ZsXA==
X-Forwarded-Encrypted: i=1; AHgh+RrDddSuN/wRAhv4Gx3tx0KFAGZG5Ios0zq9M3e2R+y4x8HmCYwxGyeg9azMO/MFMn9cUG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL1GgVZdtYnd1mZvvBsoa4yqMDDbYVr9So0Rp002LZrs7RZmZT
	n7kAondUMeLkKpyBlU9KD/9n5qLfCFcS/e5du2+Gn730kdwSM8Hm9+0/
X-Gm-Gg: AfdE7clhdmdJdMbFbUFRd+AJtHxGcTxMX76yO+GEmAkGtAKBeclJDAdZHvvyAAV6ZrB
	6sC4frLNwgsM4kSL4rUPVsjolSVhU9pY+yoiRVURnTutE/+dRFII22L0s2BugtS5sUlPk623Npw
	Bj4X4hb7dMH3zXsNquidxlDgLB2ROrytC3kRU/ivkKeUhR1HIthfb+K8RODwIIzDaAGayl2voBS
	N0TQiDldhfEYjpAdMB6WVwkj09lR9KIZT8iGnp5oIkQqMqf+RIs96ySmbSXc9ofZMtvoyzNmejR
	fvzFzQryKu7PBPv6lmyb/UWNFYHrDDhff026SwVOuUeioVuJn7XtQpoyQoD3GsHp6z21FdSnrTY
	mV00KprwxcUXIW+CA5FotyWMP0zZbqdNZdLEeQxh/NWk2/P92Dfmgw5TjSCTrt3W5DISlwq2gWd
	Q5Rqj9MC4ZwD9qya4HirDUHgkhB2IAywTfiZwWSoHdPglKxtHyfIYU6KJ0Dx8fmyU4gI4=
X-Received: by 2002:a05:6402:1f89:b0:69a:9355:ec35 with SMTP id 4fb4d7f45d1cf-69ab44b5e42mr5460842a12.41.1783696733467;
        Fri, 10 Jul 2026 08:18:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d786e7sm11958527a12.16.2026.07.10.08.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:18:53 -0700 (PDT)
Message-ID: <ed72dd31-5d68-4e78-9123-7061b388ecaa@gmail.com>
Date: Fri, 10 Jul 2026 16:18:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v18 2/7] branch: convert delete_branches() to a flags
 argument
Reply-To: phillip.wood@dunelm.org.uk
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <cdd4fea4a73e39a1f88127037d806c9b6182d01e.1782338106.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <cdd4fea4a73e39a1f88127037d806c9b6182d01e.1782338106.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/06/2026 22:55, Harald Nordgren via GitGitGadget wrote:
> 
> -static int delete_branches(int argc, const char **argv, int force, int kinds,
> -			   int quiet)
> +static int delete_branches(int argc, const char **argv, int kinds,
> +			   unsigned int flags)
>   {
>   	struct commit *head_rev = NULL;
>   	struct object_id oid;
> @@ -227,6 +233,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   	int i;
>   	int ret = 0;
>   	int remote_branch = 0;
> +	bool force;
> +	bool quiet = flags & DELETE_BRANCH_QUIET;

This means we have two sources of truth because we modify "flags" later. 
The idea of replacing the old function parameters with local variables 
only works if we're not passing the flags variable on to another 
function so I think we should replace all instances of "force" and 
"quiet" with flags & DELETE_BRANCH_FORCE/QUIET. That way we have a 
single source of truth and should avoid any future regressions like the 
one we saw in an earlier iteration.

Thanks

Phillip

>   	struct strbuf bname = STRBUF_INIT;
>   	enum interpret_branch_kind allowed_interpret;
>   	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
> @@ -241,7 +249,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   		remote_branch = 1;
>   		allowed_interpret = INTERPRET_BRANCH_REMOTE;
>   
> -		force = 1;
> +		flags |= DELETE_BRANCH_FORCE;
>   		break;
>   	case FILTER_REFS_BRANCHES:
>   		fmt = "refs/heads/%s";
> @@ -252,12 +260,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   	}
>   	branch_name_pos = strcspn(fmt, "%");
>   
> +	force = flags & DELETE_BRANCH_FORCE;
> +
>   	if (!force)
>   		head_rev = lookup_commit_reference(the_repository, &head_oid);
>   
>   	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
>   		char *target = NULL;
> -		int flags = 0;
> +		int ref_flags = 0;
>   
>   		copy_branchname(&bname, argv[i], allowed_interpret);
>   		free(name);
> @@ -279,7 +289,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   					     RESOLVE_REF_READING
>   					     | RESOLVE_REF_NO_RECURSE
>   					     | RESOLVE_REF_ALLOW_BAD_NAME,
> -					     &oid, &flags);
> +					     &oid, &ref_flags);
>   		if (!target) {
>   			if (remote_branch) {
>   				error(_("remote-tracking branch '%s' not found"), bname.buf);
> @@ -291,7 +301,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   									   | RESOLVE_REF_NO_RECURSE
>   									   | RESOLVE_REF_ALLOW_BAD_NAME,
>   									   &oid,
> -									   &flags);
> +									   &ref_flags);
>   				FREE_AND_NULL(virtual_name);
>   
>   				if (virtual_target)
> @@ -306,16 +316,16 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>   			continue;
>   		}
>   
> -		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
> +		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
>   		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
> -					force)) {
> +					flags)) {
>   			ret = 1;
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
> @@ -872,7 +882,9 @@ int cmd_branch(int argc,
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

