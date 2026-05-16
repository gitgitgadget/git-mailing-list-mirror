Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516723ABBF
	for <git@vger.kernel.org>; Sat, 16 May 2026 14:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778942332; cv=none; b=f8jNQ1NeqKa+k8CdhJ9o4aHhQEZRaKy4zoZKlHutihNRd9U/RQaqVIPxdjpKHgGt9RKgPPAMdJc8dwm8fxl5dzpiTy589KqGwMi89BbILpJw2WZc5SvSXJE3GEQvpcTozkPN0kJBlqR8CscnzQT9X47YrJTCGr+a5hS2C0qt+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778942332; c=relaxed/simple;
	bh=wvRmOLQLfdt4WZfY98d8C3EjEetpOLQmeKf1bv03EFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILV42D28pEeGHFrkjZWgHW/ovKiNp9Ve0no/MKrvQuP0y1ZcAn9UauqIOTRmyaP2vqjUwiGwdfOHBkZpGAFlDFjkdQJmSm9Xi8+uXotw/36wDonOLWCeMPWaoZvIz0Ij7qLeymX0OX4DQ/C4cGJaabXFyBwvjqP0sWBfg9Np2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRQ9koJ9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRQ9koJ9"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8c7154725easo13233826d6.0
        for <git@vger.kernel.org>; Sat, 16 May 2026 07:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778942330; x=1779547130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGa/SlrShZyCaaCULVlgyDBW31XkHSbKb+SYtDnjI+o=;
        b=NRQ9koJ9YfxpnVDZe/LR0L8ogRZndYoEon3MgPLBZPW62SEjQV1DzqwD+VmYXnvq+V
         dz0RQooldfWOvAdEdlTasSLSyafgnyIo2mNbg6sgw3jnfUb/SdRrHuZ95SFijBrfaDKR
         jLZue2uyIgrotWMdYzXTQIth/7ACkyHyj4WaPjvYKEKIYFNlJTnEWymbKHMYklxDQ+wk
         IEgOkjCnANh3yWZ313BJKfCG3jPLaR5EtfqQKNtQ1NvAkOxF20pf2GrmgX/223eJ+3JB
         fQQR8UvEu5/o9Wdr4kyBzuaL/1aKT7NOox1dGwGMx7vaPZZqBI7kMBEZqjCIXipYfx3/
         1BmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778942330; x=1779547130;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yGa/SlrShZyCaaCULVlgyDBW31XkHSbKb+SYtDnjI+o=;
        b=ILnCYmCBIV/WyDWK83+jfbira4LscxPyydO2WIMj+3zltzeTvSBzsgYiuLjlSjCPNq
         3Did2+h2KeBdG+48JZ1YcCjQkQ/SOYBaNnvCxn7PYlQ1Z+r+uzX95cENj/NFS1NJbGnC
         rsrAcm/LUObIUL2SGNLFq2MccYqY8p8h9ZdS0UpKuDBdVcf4PPtUdJCCf7wJ7ODtpa0J
         WQ9h9uA0hBwWbI2Vey1ChcU5pdL2s0FMTQ+CPCuPmlMZpC9bB9hKOy+HCDo+GHuXE/yd
         SnPXl9uRqg73FLhoIQHnaGK0WW4Pmhpndvul7FjdIuzoRgIpSI4hIpcihqIlN2MvsZYC
         hnaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+s9t3A+Pw9s5+m8Ja8JXL2fF0AVCaIkuxvN1USe18tKqy5fLdlWe7RdLAWjYYSCAHJas=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBn+pmLGnDekuUsBaa9Jb9KjojQToP+mcnBjSsItMDmilSZBH
	Yj6EOPZjc2HR2VMtQHrncV0xdZrU3tYtVxlaIH/N2UKZAqVtWGliDPZJ
X-Gm-Gg: Acq92OGvh4ePSGXdNvg+47D5BMfyEx/8viJAcuGSGQB6zLJSzRCbPj2y+jSHLuykARU
	esJRZkIVuhf458xAVIwrdxmUOx0GL/iqawOPWRf8CJsyIyC4SUwX5SidThTQNuTuP0Y3xCNaJJo
	1zoEO3wk+6ertSWx4X+zV3S7pyk79P/DCGCbaJn67pY4hhZGrBUdevxWiq4kphC1GGt9In37eXJ
	eavr6cLISKFkOV+RMnz7iRkRjKgI8+AxtT1Q+OBDa5pW0Gp7h2KiX+LdKVryLhA4n24n95oGIFw
	GKlxwjtIAv961fFn6xMZ8c/M2nSunflLUt41j+EXdzPjI0ccGUFZHIamGMz2YpIDQXEoEznbNTp
	r45yg+myynQcLYJt7iS05WaqLDQaK53KKO5DZ5o7oRN7qDBQmB/cuX/VtHpYz1l5iFrV5Ld3I6K
	DBecCXudtKMV3S6k49nX0sSCg/A8H9bisTOIXu1K/k0MrPGUTfb/oA+GMlQ8dg8Vg9QlXsdmk6o
	s5Bw03pYA==
X-Received: by 2002:a0c:c58c:0:b0:8ab:46b6:4f3 with SMTP id 6a1803df08f44-8ca0f6b6ab7mr94798486d6.35.1778942329629;
        Sat, 16 May 2026 07:38:49 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b2dc41fsm84447776d6.25.2026.05.16.07.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 07:38:49 -0700 (PDT)
Message-ID: <62ed0001-5769-47f7-b31d-4948d498555c@gmail.com>
Date: Sat, 16 May 2026 10:38:48 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] git-gui: use rev-parse exclusively to find a
 repository
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-8-mlevedahl@gmail.com>
 <d8844726-0b08-4035-946e-c5ada0759f32@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <d8844726-0b08-4035-946e-c5ada0759f32@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/26 12:06 PM, Johannes Sixt wrote:
> Am 14.05.26 um 16:33 schrieb Mark Levedahl:
>> git-gui attempts to use env(GIT_DIR) directly as the git repository,
>> accepting GIT_DIR if it is a directory. Only if that fails is git
>> rev-parse used to discover the repository.  But, this avoids all of
>> git-core's validity checking on a repository, thus possibly deferring an
>> error to a later step, possibly unexpected. Repository validation should
>> be part of initial setup so that later processing does not need error
>> trapping for configuration errors.
> OK. If the user gave us GIT_DIR with our without GIT_WORK_TREE, then
> that combination better be workable.
>
>> Let's just invoke rev-parse so all error checking is done. Stop here if
>> the user set GIT_DIR or GIT_WORK_TREE. Otherwise, continue the existing
>> behavior and show the repository picker.
> OK. But the paragraph is confusing, because a big "If an error occurs"
> is missing after the first sentence.
will fix.
>> Also, remove a later check on whether _gitdir is a directory: that code
>> cannot be reached without rev-parse having validating the repository.
> Good.
>
>> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
>> ---
>>  git-gui.sh | 24 +++++++++---------------
>>  1 file changed, 9 insertions(+), 15 deletions(-)
>>
>> diff --git a/git-gui.sh b/git-gui.sh
>> index 2e2ddc0..81789dd 100755
>> --- a/git-gui.sh
>> +++ b/git-gui.sh
>> @@ -374,6 +374,7 @@ set _gitdir {}
>>  set _gitworktree {}
>>  set _isbare {}
>>  set _githtmldir {}
>> +set _prefix {}
>>  set _reponame {}
>>  set _shellpath {@@SHELL_PATH@@}
>>  
>> @@ -1167,19 +1168,18 @@ proc pick_repo {} {
>>  	set picked 1
>>  }
>>  
>> +# find repository.
>>  if {[catch {
>> -		set _gitdir $env(GIT_DIR)
>> -		set _prefix {}
>> -		}]
>> -	&& [catch {
>> -		# beware that from the .git dir this sets _gitdir to .
>> -		# and _prefix to the empty string
>> -		set _gitdir [git rev-parse --absolute-git-dir]
>> -		set _prefix [git rev-parse --show-prefix]
>> -	} err]} {
>> +	set _gitdir [git rev-parse --absolute-git-dir]
> Please do also set _prefix. It should fix the bug that the file chooser
> uses an empty prefix after
>
> cd lib
> GIT_DIR=$PWD/../.git GIT_WORK_TREE=$PWD/.. ../git-gui.sh browser master .
>
> (this is an old bug.)
>
> Please keep the additional indentation of the catch body.
>
>> +} err]} {
>> +	if {[is_gitvars_error $err]} {
>> +		exit 1
>> +	} else {
>>  		pick_repo
>> +	}
> Treat the 'if' as an early exist without an else, and we don't need the
> previously strange indentation of 'pick_repo'.
>
>>  }
>>  
>> +
>>  # Use object format as hash algorithm (either "sha1" or "sha256")
>>  set hashalgorithm [git rev-parse --show-object-format]
>>  if {$hashalgorithm eq "sha1"} {
>> @@ -1191,12 +1191,6 @@ if {$hashalgorithm eq "sha1"} {
>>  	exit 1
>>  }
>>  
>> -if {![file isdirectory $_gitdir]} {
>> -	catch {wm withdraw .}
>> -	error_popup [strcat [mc "Git directory not found:"] "\n\n$_gitdir"]
>> -	exit 1
>> -}
>> -
>>  # _gitdir exists, so try loading the config
>>  load_config 0
>>  apply_config

will fix all.

Mark
