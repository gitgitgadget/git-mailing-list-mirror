Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64E221FF2E
	for <git@vger.kernel.org>; Sat, 16 May 2026 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778941788; cv=none; b=EZoVv7e7v+UwUYiZOUDSDah4/FlxTXAHAeqZgx5vdfsZWb/+K0QQ+aqrKuFeE1eH1VRrigtx3q0Dne2RNBdbgiu5OPTHe0Qd0GEFsBZsVo7erSSAZ7WzMH7GzPHUkoonVSsuleFo/7RtDVwyfEEvAmrO3fHouH+ZEpqN6ffhdwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778941788; c=relaxed/simple;
	bh=TyJr7C34PC5UMvyRNkZ6FFU+Cr2OCK4k4BsV9EpsobY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GZe1B/DIYJ3kudk/39jW2FOaU+2/FGpWTs2j2BYLjPijoP6pGTLyuShcqSaGJz2UJRkPmexfkdQQ+AD3VNyiu5z0GMKndMgJcIQc9zau7BbkyKDvIxStJD/XEpQH+CQOCKP/lYMHMsOudln4TOOL8QtHz/1U6RXeI1dh7+qDCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvk4T56M; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvk4T56M"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8cb40149037so105775485a.2
        for <git@vger.kernel.org>; Sat, 16 May 2026 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778941785; x=1779546585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hrIy9EErMaURDM/3PC/PojVxbOktjlV/UfGKyd8Jtv8=;
        b=lvk4T56MaaTRDQz/ge5GLJgUb3fGY26v2h5+1tdMNTlPBJ0ZS/RAlQCQTXIcmOH3X1
         K42IckGdP3WscOrmDlm0zVDFYMI9tZZzdBCnbx/W3+51dimvpbTTEZWmYzody9LPVAH1
         bd/1q86DFdVwkMNE0IaUflMn4VS/ljZfE4HVrE0jAVWhYeXL2+rXlCN8YzrBtHj3IZQq
         GSUPafIs1SxzKQQzsU9zv8ndMsMp5hTKqtp8WiuVbUiubwYUX/SxW5nS18fWgA0Wbi5I
         guVj0Xj1cX1LpZXcEUYM0scFwUtZyfsaU1WXV+rWs5svNf03AVAt18hq48++WR4+aLWR
         c7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778941785; x=1779546585;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hrIy9EErMaURDM/3PC/PojVxbOktjlV/UfGKyd8Jtv8=;
        b=FVLSU6rQ8s/rEWODUz8R3kQcaWSWKsM30l+epcGLOtnHUgJ4KWJssigs/s3IpHewX8
         UJrV4DsnGwODVO4yBcxQysap6Cs3xhRwDgY+MZUyClYe27ryroUTvryjP4tEtDPcp/OW
         wZI0sQ/n0bMAOEoOgLgUOjzroQkwIG8qJ5PavAe8u7f3vtXa6yJiTAUyqNzmjN333VXI
         TdpDhHcWioovEu44g1EGoepMdSM9TaJXQ0YZBARfwNWEmGu6hRpLAhrTomTgcH7bQ3Dr
         vNq66u8RkVE1ZAywjGaZkI5twAkynL248NsPnd+OLQ8zeZUzKYDS+AO1s1NVxu30hMgm
         FqXg==
X-Forwarded-Encrypted: i=1; AFNElJ83tah5Jyq3UgWrZ9NdZAIASptHFuxFPoIFaAosWel6wnApsqSFunTTrD6VruAFVpM3quE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcKqT8lbtklbU5r/E9nJuFP0N2jkTow4DmpX5SZXQC5aoanpAc
	+DM3AG8KwAXM7focpaluJrjIvF1GpNb/4xYQhUscpHSn0Jlea465iRF4
X-Gm-Gg: Acq92OGDZUNY36CxxZV8uMCLfDWUltG2BtaSZtBDw96+jKPbYtwmfkth1RJPKyIivP1
	RhzMc3QshXzR02XA0B7eaijQEAiRR1oPwe98XvbqLBG+AbXJiPEJz0qOa/+MSFHSdFpRABZOUwF
	zzbFh0fv4DyIriB+dKB9NjJ8rqgyy8spOXc/3OzCtBR/DMfsY/cAtmSQX6i08Myg6HlIixEl8fS
	VV46hZ5akP3kfp/codB9G/+5EQTKmtv8ewyZd5xo6X13xPnzAvBy2puzOWPSEraNWM0K9fOcA4j
	6sKqkh2g80cdUO48ishbLNdjxZMAPt82GMhLeajgcCAbPPfPSokwa2L+OGzrJOyjUAuTV4MuZ3o
	wkaJTreGg5H1AeZUkHNRMARxaIhUNlA8EiAt0D8WTLCvfLiD+CvlaO9SwLZcW8z180DpqoKo65b
	H27m7mvgZkAap4VGQ2ULgKWK1ftg9lx17Io7odgMzXqvMtUrHA85wUXa97m84lusHv2tAr1XA=
X-Received: by 2002:a05:620a:170c:b0:8cf:db04:8a1e with SMTP id af79cd13be357-911cd75d7c8mr1245617185a.23.1778941785262;
        Sat, 16 May 2026 07:29:45 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba182535sm870190185a.8.2026.05.16.07.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 07:29:44 -0700 (PDT)
Message-ID: <d56431e8-79b5-428d-9bfa-e814e41af3c5@gmail.com>
Date: Sat, 16 May 2026 10:29:44 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] git-gui: put choose_repository::pick in a proc
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-5-mlevedahl@gmail.com>
 <7544deeb-163c-4444-833a-7b840a7caa4a@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <7544deeb-163c-4444-833a-7b840a7caa4a@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 11:59 AM, Johannes Sixt wrote:
> Am 14.05.26 um 16:33 schrieb Mark Levedahl:
>> git-gui includes a 'repository picker', which allows creating a new
>> repository + worktree, or selecting a worktree from a recent list.
>> git-gui runs the picker when a valid git repository is not found. All of
>> the code for this is embedded in the discovery process block, making the
>> latter more difficult to read, and also making things more difficult if
>> we want to have an explicit 'pick' subcommand to force this to run.
> OK, let's see how useful this becomes.
>
>> Let's move this invocation and supporting code to a separate proc,
>> aiding in subsequent refactoring. Assure GIT_DIR and GIT_WORK_TREE are
>> unset, configuration is loaded, ant that _gitdir is correctly set
> s/ant/and/
will fix
>> afterwards. As this is invoked before worktree discovery, later code
>> will set that anyway so need not be included here.
>>
>> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
>> ---
>>  git-gui.sh | 18 +++++++++++-------
>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/git-gui.sh b/git-gui.sh
>> index 387cad6..0b73c35 100755
>> --- a/git-gui.sh
>> +++ b/git-gui.sh
>> @@ -1139,6 +1139,16 @@ proc unset_gitdir_vars {} {
>>  }
>>  
>>  set picked 0
>> +proc pick_repo {} {
>> +	unset_gitdir_vars
>> +	load_config 1
>> +	apply_config
>> +	choose_repository::pick
>> +	set _gitdir [git rev-parse --absolute-git-dir]
>> +	set _prefix {}
>> +	set picked 1
>> +}
>> +
> So, this isn't intended as a plain move of code? Since we set _gitdir
> here, we could remove the corresonding lines from lib/choose_repository.tcl.
it should be a plain move.
> Is the variable "picked" only needed for this particular picker
> invocation? Then it should not be set in the function, but at the call site.
I need to better understand how "picked" is used to decide... will do before an update.
>>  if {[catch {
>>  		set _gitdir $env(GIT_DIR)
>>  		set _prefix {}
>> @@ -1149,13 +1159,7 @@ if {[catch {
>>  		set _gitdir [git rev-parse --git-dir]
>>  		set _prefix [git rev-parse --show-prefix]
>>  	} err]} {
>> -	load_config 1
>> -	apply_config
>> -	choose_repository::pick
>> -	if {![file isdirectory $_gitdir]} {
>> -		exit 1
>> -	}
>> -	set picked 1
>> +		pick_repo
> The indentation is off here.
will fix.

Mark
