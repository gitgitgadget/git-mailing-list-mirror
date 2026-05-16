Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB24218845
	for <git@vger.kernel.org>; Sat, 16 May 2026 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778941530; cv=none; b=GL1rAf7xvOC0gCYono9CynumrPU5LnxdAZEUPlOBdFOaqz+VLATQcWNewSXpjasPUnc5mCVZdQtkFryt+Z7epQ2o4psInX0rgC3EGwjSF7GdiZFlN6qv2DCxE+9jlTQj6p3aKRu+a2wQBA0kBfJIRPIskj+xPwU5jQzMgXkBxvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778941530; c=relaxed/simple;
	bh=P7eC+PhNeN/oizSLf47HlkPxP/7xaVou25EJH4Q1kU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCJWkgDSnd8TEKsOhkSON1ryP5iodpt1M1Ic1Caie/QhgJhrkxdS5nX4gdD8IUB+S2vhZ8YJn+lDUh2J6QKFXe1Dq1Euagpq9yW8IELT/MHvH4xVDMK6uYBCOgpkT9F2aATK08pJi25hBSk6pXuLyNdvEfhKI2o8NaPdwQ4jUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5M3ZLiU; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5M3ZLiU"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50fb8e9a4edso13194731cf.1
        for <git@vger.kernel.org>; Sat, 16 May 2026 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778941528; x=1779546328; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQDhUvhvxbZw3W3wFl5URbtXSosa0ItK3BCatHJYXlA=;
        b=U5M3ZLiUi4orE0Wp+Lzn+F47asDonM6oSfjMxd9RYeSgkUFDtuROX/lRk9TRmHyk2d
         kym849QLQLTrKf10333PrIzdN/1xqtkOU8gUPg8LjBr4hBRQ/VboCX7trMJv4wqaStZw
         iWc6OiqKqgxCPfl6zJk9j4Uhi4l6bacb7xmq1tpfkXM1/Y2qpr0U8Uh7EEUOB/CC8KTa
         XTxpm3u8JSihuWGbOYGIh0fucDIHXd2LjPDlhDIcJ/pqWfpqfjlvTTRNmL9llemcwUjx
         PabyBDdVMgXVL9b6864aDLdSsA5z/lLk4gCa+rwWqWj3oT7P9y41LNyrFRizPZ/3A25X
         KCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778941528; x=1779546328;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQDhUvhvxbZw3W3wFl5URbtXSosa0ItK3BCatHJYXlA=;
        b=poiz5+QxIJk6tQhU+cqPKm/IYkqiQxsrRfMAAs30YqU688L8ydxR0WReqcvUiFax8i
         x8CPhaMAk0OSwf8HGU4ZDO2DAr4KUxeIr/1svSFyc3syQvW609+e2QDkO42k09WPopEr
         xcrF8QdQDnf6ITSFnExALv9Hotv3Iy1furVDc2AfuXRr4rXQDkeDJ4OPgwL0UyoRaF5B
         WGz/3Dba+JSBXsGHpcOCiQxTuAZjnK6i7lAIuL+karNda6AuM+XmlFDAlxjosw/vmaDE
         YDsvV9Mgth+p2wgtl8v6LhsjD0zZ+d9wPqAR8wLrUIUU7WHKre3jCxaKmBSaYPWV5WkS
         jJYg==
X-Forwarded-Encrypted: i=1; AFNElJ+bYPU80AMGqe2m6VNMx4GmFZyagijuOcWsr0Lks7wGtYPp6GjY3C9bdnq6M/c1Q1y0uVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNcHJv4fB72RZ4jvuppECa19JnbjVNg9Q2AGLw3tYrF7inLT8
	9Cc26xOOPEjnbIIDMHpDSrZRluj+hu9NK/oy8E8heaF7m2ZMtCJ5YwFVrxVFto0a
X-Gm-Gg: Acq92OFSA9R3j6wjQmsCBrizsZb8IHgz1JBHHls2o9m14gLO6lVDoegZ8ydTZ7xGG4J
	O85eZvVrBzZWYVVQPU1RPv1pi6Lmck2Fx+eetKoi0aIRMS109poPAxM0dG9DK53MaZH6c1tlE0L
	SPKx8C4k0akyC+QO0CBZkkRj8Ay8wwZcnqXd3ZzrFolL1/dvQxO/xweougGVlQOX8enID33X9i2
	Q8zpVVj2PQ99sp1ADrYI+ycMe+Iaq6IpVKr0fNyv74BnDQ+SDTnGSCMiTknHrhyYequRD/IxkO1
	A/xtEXnfVS7BfGpm2OeQ2CcW/I+syfUCApL38/ecYhX2j+wtMfS6biV99u0TSgrD8/EDiGfd1OU
	KingCpDSFZI9vpJPTtMBk3hlsjqPbMSU1jiC2kdT4vj63emchINZfPD0PMYPzRLx4/tc9vj2DUo
	CoNqFQlXKsCPCm0nGSgcv38ceso4EfpXiF2o0LXSbWp9cvyaO3qHSpevdoB4XJ8b0yRiEjCIKs4
	XpusfrzGA==
X-Received: by 2002:a05:622a:1f96:b0:50f:ccdd:13f1 with SMTP id d75a77b69052e-5165a03f078mr122180701cf.16.1778941527735;
        Sat, 16 May 2026 07:25:27 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164df7bfa7sm69270241cf.21.2026.05.16.07.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 07:25:27 -0700 (PDT)
Message-ID: <a70e90a5-bcce-4935-b804-92fcc1fc28dd@gmail.com>
Date: Sat, 16 May 2026 10:25:26 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] git-gui: guard set/unset of GIT_DIR and
 GIT_WORK_TREE
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-4-mlevedahl@gmail.com>
 <d9af8b60-e354-4cfc-87b3-a3e708b362da@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <d9af8b60-e354-4cfc-87b3-a3e708b362da@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 11:58 AM, Johannes Sixt wrote:
> Am 14.05.26 um 16:33 schrieb Mark Levedahl:
>> git-gui unconditionally exports GIT_DIR and GIT_WORK_TREE to the
>> environment, and furthmore unconditionally unsets these in many places.
>> But, GIT_WORK_TREE should be set only if it is not {} as the empty
>> value, really meaning no work-tree is found, causes git to throw fatal
>> errors (git-gui gets the error from branch --show-current).  Fixing this
>> is required to allow blame and browser to operate from a repository
>> without a worktree.
>>
>> Establish a pair of functions to remove GIT_DIR and GIT_WORK_TREE from
>> the environment, avoiding any error if they do not exist. Also, add a
>> function to export these, but export GIT_WORK_TREE only if not empty.
> Good. But as I said in a parallel thread, I actually concur with your
> assessment in the coverletter of this patch series that GIT_WORK_TREE
> should be not set at all. At least in the modes that require a working tree.
>
>> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
>> ---
>>  git-gui.sh | 32 ++++++++++++++++++++++----------
>>  1 file changed, 22 insertions(+), 10 deletions(-)
>>
>> diff --git a/git-gui.sh b/git-gui.sh
>> index a951fcd..387cad6 100755
>> --- a/git-gui.sh
>> +++ b/git-gui.sh
>> @@ -1122,6 +1122,22 @@ unset argv0dir
>>  ##
>>  ## repository setup
>>  
>> +proc set_gitdir_vars {} {
>> +	global _gitdir _gitworktree env
>> +	if {$_gitdir ne {}} {
>> +		set env(GIT_DIR) $_gitdir
>> +	}
>> +	if {$_gitworktree ne {}} {
>> +		set env(GIT_WORK_TREE) $_gitworktree
>> +	}
>> +}
>> +
>> +proc unset_gitdir_vars {} {
>> +	global env
>> +	catch {unset env(GIT_DIR)}
>> +	catch {unset env(GIT_WORK_TREE)}
>> +}
>> +
>>  set picked 0
>>  if {[catch {
>>  		set _gitdir $env(GIT_DIR)
>> @@ -1207,8 +1223,8 @@ if {[lindex $_reponame end] eq {.git}} {
>>  	set _reponame [lindex $_reponame end]
>>  }
>>  
>> -set env(GIT_DIR) $_gitdir
>> -set env(GIT_WORK_TREE) $_gitworktree
>> +# Export the final paths
>> +set_gitdir_vars
>>  
>>  ######################################################################
>>  ##
>> @@ -2050,13 +2066,11 @@ proc do_gitk {revs {is_submodule false}} {
>>  			# TODO we could make life easier (start up faster?) for gitk
>>  			# by setting these to the appropriate values to allow gitk
>>  			# to skip the heuristics to find their proper value
>> -			unset env(GIT_DIR)
>> -			unset env(GIT_WORK_TREE)
>> +			unset_gitdir_vars
>>  		}
>>  		safe_exec_bg [concat $cmd $revs "--" "--"]
>>  
>> -		set env(GIT_DIR) $_gitdir
>> -		set env(GIT_WORK_TREE) $_gitworktree
>> +		set_gitdir_vars
>>  		cd $pwd
>>  
>>  		if {[info exists main_status]} {
>> @@ -2084,16 +2098,14 @@ proc do_git_gui {} {
>>  
>>  		# see note in do_gitk about unsetting these vars when
>>  		# running tools in a submodule
>> -		unset env(GIT_DIR)
>> -		unset env(GIT_WORK_TREE)
>> +		unset_gitdir_vars
>>  
>>  		set pwd [pwd]
>>  		cd $current_diff_path
>>  
>>  		safe_exec_bg [concat $exe gui]
>>  
>> -		set env(GIT_DIR) $_gitdir
>> -		set env(GIT_WORK_TREE) $_gitworktree
>> +		set_gitdir_vars
>>  		cd $pwd
>>  
>>  		set status_operation [$::main_status \
> After these changes, a 'global env' probably becomes stale and could be
> removed.
>
> -- Hannes
>
Will update to only ever set GIT_DIR, will still remove GIT_WORK_TREE on unset.

Mark
