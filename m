Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC45523ABA7
	for <git@vger.kernel.org>; Sat, 16 May 2026 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778946141; cv=none; b=VNKlQZf7AopsjDAz71M7M/iPdbd5PXgC5pqIIZHdsHMInkr+auU+A4al7iTuwk9G3Ofyz51SVkY2j6q1S34na9H+f+CK77ksj+fuBeAQ4JZ3F65ViS+fZZMvqt9+nwj2sa18NdQSU63IPfDxQ+h4ToDZoT79rUVWj7za7k5KKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778946141; c=relaxed/simple;
	bh=+oFj1zwvtAEd0hXGhOJMOhtlohW0MtAVyZgXRwxuWQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoZdCpItPQ9rWHZ4Y54c0A96a6t4u0TtX9nXGiqyrC4bLPc7qMwJmzp4Ut1tE+ktLMhafVnFUhjCW0JITGPi2w1l9OjHI0Yx2jGm+5/PA9tJHEfCuVAQzBXNKFjzNwmRXNe51uLOBvIkpWFmVDaT5FjjyemskaJ1lx/30ILMOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cr14IhbN; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cr14IhbN"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-90d13fa59e8so113597985a.2
        for <git@vger.kernel.org>; Sat, 16 May 2026 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778946139; x=1779550939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FjSAyxmx9AtSG1QSEljgF/HNzxdg8sPZONo9+o5uYE=;
        b=Cr14IhbNRXKmGu65Dvpcnc0hh6Doj00Qu0xHXOVyMcelvbZrPk82Rx051Hcu27QIts
         1bCqNX3+BeSPOgf8B0R/5xf12xW1Q0I961wFor5/Sxf00Y5dMdKfZJ84Ld/RNfueFVOe
         3R5kYiRSwipEIH6Af/PLbttayxroqvseJqPFONKBKcPEbuqZ1IiwiOoeaFgj47fFdJBG
         XlXvztizdB23zNrBPnpMEdwEYLlCJ7mQ6dY6/J6EA71KsNUAnY2eJyDnUe5qDiL9xVH1
         3E35X71XLfMePOXO1csBHvtzOdcJxPwrlV2DRYycVjoD3cDk2KhEbXmi+9D6Nzr7LMLb
         DxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778946139; x=1779550939;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FjSAyxmx9AtSG1QSEljgF/HNzxdg8sPZONo9+o5uYE=;
        b=YGcQsdfG0eYKBdUs1rPuoxl1147G7y5DDEYEUwYqmZIFtmGsTBQLtZU4RpxG7moEzn
         7mKSxAbU1Wck2upItZ4kXMKYZOQ7VzQSajaM5wCKUr737TZ2uOQTRuM8LwKY04is3fNe
         BHfTImr1ZyfZ9KgmF7grGPt6quuAlheL/tciJRJnICKT3dOiR/mkXGOJ/v6UPuqQQqLU
         Abtzk05bL499SluSwVe6DM1C+XxF3fKOIdCMbTLjNOnm+jIQFibqTRMqvfpDJe74MquF
         iXLlSjzLw7EKDZky9Ii0PAKjAqsu5G8ZmNaaZ0pmrVFGmNwt3uWett8keI1paTg5Pg18
         9e/w==
X-Forwarded-Encrypted: i=1; AFNElJ8LV1kX1bGu12zxgbf1JWjHKttpNnc84HabNJhDROP2LrD4KprWacYNl6TNtdrTk+xHyrg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv9x9m8ThITee+UAuE4gxh77Em6eC0zJrQ67tMGri0QQrUv1SK
	eYzq0gB29bDc5XtxzY5a6NnMqLbAYS90QzKlBaIn1IdejYBc5nb5zjop
X-Gm-Gg: Acq92OGRBzc9Y7jkIbCoH9093nxm7NZviUNhihkcWCxHUWo8cBtFL25CUTtk+4SlYnn
	9th0oy5vxv/gaxbpiuhkeAYte0XTuFF9c8lMaJhxp5w1wTMxjoDdjeTMzJ8wGpEWw60nA/KrFqZ
	dZ3aQ0tfsudfa+duvWwBwtYia8ShV+EI+afsFsS5ju3nehhKwcSADH0//00SghwyRsaSjefCnL+
	ZzJ7hiTOXtch+QQx/zFhU+IPiU7WtE3z2uefUWnIcd0QPtx1ni9W23dDJdVr7Q/n4zAOlXUzsoB
	2oDf7iMtnNOxxyB/U0NDXw86himQSpp5/8cgURYR/fUIW6bulFHK+nfsGXXho4d+Jrpeoleircu
	PzfbLCuRRICt82BgkQXmIG+0aXvHowKwi+ubyQAamdZNG6IFZZn7y1HqoZvBSYjk5FskQcMFHZu
	WCLlxmpPIfgMQrUH0iEK1tN45MZavJ07VzQmQtvVgDh+4m+t0DojvgxBSNaZq+/QjXbRIC9YA=
X-Received: by 2002:a05:620a:40d3:b0:911:89d0:fb57 with SMTP id af79cd13be357-911cca9c2a9mr1360598985a.13.1778946138773;
        Sat, 16 May 2026 08:42:18 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910b785935bsm883801285a.0.2026.05.16.08.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 08:42:18 -0700 (PDT)
Message-ID: <fad43240-1089-4447-b97d-ee553c34eef1@gmail.com>
Date: Sat, 16 May 2026 11:42:17 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/11] git-gui: add gui and pick as explicit
 subcommands
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-12-mlevedahl@gmail.com>
 <e336544b-941d-43ed-890f-2b8950dbaf88@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <e336544b-941d-43ed-890f-2b8950dbaf88@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/16/26 4:18 AM, Johannes Sixt wrote:
> Am 14.05.26 um 16:33 schrieb Mark Levedahl:
>> git-gui accepts subcommands blame | browser | citool, and assumes the
>> subcommand is 'gui' if none is actually given, But, git gui also has a
>> repository picker (choose_repository::pick) that can create a new
>> repository + worktree, or choose an existing one, switch to that, and
>> the run the gui. The user has no direct control over invoking the
>> picker, instead the picker is triggered by failure in the repository /
>> worktree discover process: this includes being started in a directory
>> not controlled by git, which is probably the intended use case.
>>
>> The picker can appear when the user has no intention of creating a new
>> worktree, and the user cannot use the picker to create a new worktree
>> inside another.
>>
>> So, add two new explicit subcommands:
>>     gui  - Run the gui if repository/worktree discovery succeeds, or die
>>            with an error message, but never run the picker.
>>     pick - First run the picker, regardless, then start the gui in
>>            the chosen worktree.
>>
>> Nothing in this changes the prior behavior, the alternates above must be
>> explicitly selected to see any change.
> OK.
>
>> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
>> ---
>>  git-gui.sh | 22 ++++++++++++++++++++--
>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-gui.sh b/git-gui.sh
>> index 3a83dd5..c56aeef 100755
>> --- a/git-gui.sh
>> +++ b/git-gui.sh
>> @@ -1021,6 +1021,7 @@ proc load_config {include_global} {
>>  ##
>>  ## feature option selection
>>  
>> +set run_picker_on_error 1
>>  if {[regexp {^git-(.+)$} [file tail $argv0] _junk subcommand]} {
>>  	unset _junk
>>  } else {
>> @@ -1030,6 +1031,7 @@ if {$subcommand eq {gui.sh}} {
>>  	set subcommand gui
>>  }
>>  if {$subcommand eq {gui} && [llength $argv] > 0} {
>> +	set run_picker_on_error 0
>>  	set subcommand [lindex $argv 0]
>>  	set argv [lrange $argv 1 end]
>>  }
>> @@ -1047,6 +1049,7 @@ blame {
>>  	disable_option multicommit
>>  	disable_option branch
>>  	disable_option transport
>> +	set run_picker_on_error 0
>>  }
>>  citool {
>>  	enable_option singlecommit
>> @@ -1055,6 +1058,7 @@ citool {
>>  	disable_option multicommit
>>  	disable_option branch
>>  	disable_option transport
>> +	set run_picker_on_error 0
>>  
>>  	while {[llength $argv] > 0} {
>>  		set a [lindex $argv 0]
> Can we please use the available disable_option and enable_option feature
> instead of a new variable. Just for consistency around repository discovery.
>
>> @@ -1162,14 +1166,28 @@ proc pick_repo {} {
>>  	set picked 1
>>  }
>>  
>> +# run repository picker if explicitly requested
>> +switch -- $subcommand {
>> +	pick {
>> +		pick_repo
>> +		set subcommand gui
>> +		set run_picker_on_error 0
>> +	}
>> +}
>> +
> It just feels wrong to have a new pick_repo call before repository
> discovery. Can we not treat this case below as if regular repository
> discovery failed and then end up in the existing call of pick_repo?

So, your suggestion is to create an error inside the catch clause, assure GIT_VAR and
GIT_WORK_TREE are unset so we don't throw and error message and abort, and then fall
through to the existing pick_repo clause?

I think this makes code less understandable and more complicated. As written, the user
selects the repo, and now the standard discovery runs except that the picker cannot be re-run.

I like the current structure better.

>>  # find repository.
>>  if {[catch {
>>  	set _gitdir [git rev-parse --absolute-git-dir]
>>  } err]} {
>>  	if {[is_gitvars_error $err]} {
>>  		exit 1
>> -	} else {
>> +	}
>> +	if {$run_picker_on_error} {
>>  		pick_repo
>> +	} else {
>> +		catch {wm withdraw .}
>> +		error_popup [strcat [mc "Git directory not found:"] "\n\n$err"]
>> +		exit 1
>>  	}
>>  }
>>  
>> @@ -3051,7 +3069,7 @@ gui {
>>  	# fall through to setup UI for commits
>>  }
>>  default {
>> -	set err "[mc usage:] $argv0 \[{blame|browser|citool}\]"
>> +	set err "[mc usage:] $argv0 \[{blame|browser|citool|gui|pick}\]"
>>  	if {[tk windowingsystem] eq "win32"} {
>>  		wm withdraw .
>>  		tk_messageBox -icon error -message $err \
> We don't need to switch on the new subcommands?
>
> As a follow-up to my comment on 04/11: How relevant is it that variable
> $picked is set in a 'git gui pick' invocation?
>
> -- Hannes
>
Repeating, I need to understand what "picked" really does in the gui. Will definitely
address your question.

Mark

