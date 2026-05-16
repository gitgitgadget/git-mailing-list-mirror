Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF578F3A
	for <git@vger.kernel.org>; Sat, 16 May 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778942910; cv=none; b=qrLO03TvbH0rqY4amadAblBPIA4pGSeoI/Z4JU6HuzdhTIoXktUrStdPSziXE1A+onLf37O8fgxLFGYXvx2N+0rAeI+aEb5CsWUAeoe5YkzCVQCd0O5nKlHV+KVIykSoLeaTfTm8NkuAVaOMQJnAWq/nIwsVOfdE4r/eVwQRPSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778942910; c=relaxed/simple;
	bh=7FUQ695ckZEOoBytiRvSM1WEuFYDBWhx+cCqilT3vpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bi93SP0leifjaVg3wEp35HtJOkapRZoy5+/OathnWt5iA6CuqFSBFRaViPebtgFiRqDQCFo/bnHCisR9o5CKc+1vtYdvgoOqotgXkpdwD+XRKeaUQMqsO5XIk125q/wSgIBRbzuiOSG3KAKXGNvqaRuYly3kSbnnE9o2QQmgzDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcdI6kIR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcdI6kIR"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-911dfc86903so119841885a.3
        for <git@vger.kernel.org>; Sat, 16 May 2026 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778942908; x=1779547708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQuluWfeJtAYv5NjAqQwLHIhs495xrQU4kcr2yVp0Wg=;
        b=EcdI6kIRXgYw/kq7+gTBRzSzSlk7rl5ceRteE6kuJND3ZKTFImTmhkZovq2XItwAVY
         V1fdsm3F0q8WDwtKNvVLHOugPiuQgXPbP/NDhqIe2SA1IHhqjIsmOcPrqkfFFy43IhOf
         PtvgGs3I9AxEHCpVrzfhTJ8gNf/Vjn3TaiCaPmAFuN+SbFpVQvc0F7Bl+rIOuArtylhJ
         YFDtzG6a+nCjG15F1+ghZXcjtc89itb2XgJeK+LHT5WJmyAfiWypmDJj4XPCuPa0JAQk
         rI8jOYFuxb1XHAtt/RhSgE1Mug04tt6qHeQg388R2V9XYSVsx44CYnTwTVO2KHjv0G4w
         QMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778942908; x=1779547708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQuluWfeJtAYv5NjAqQwLHIhs495xrQU4kcr2yVp0Wg=;
        b=OaCntvus6GnBHRtF8+FTB7hAqRsZ+TS20A9bUZdJ95jHECzfXBkDdqOa7HbW2gXrPH
         gZq4t1ZqxZA/YHmNZ46BYXOtcuULTHuMthO20vu3/ggEEonx3Gw+g6E+QcYvPCgazCHw
         z+IgCawNvddFltOR29ZiWoI3mXYdG90yKF7md+GrbGTvn87IM9GK1bB1zVVfvcxpVHsT
         PfN/k7qBh81wEEgC1m0Q3zgq/+/P+0S5PSKSmtpZqgBazOuNT6dWR4ZIKeVl1W5+J7OO
         n0RN96BV15KC9LHRrnZ33nJmHPy6PYGLj38IzoGygnNMK1/ZCj5s7geA5SnHOgROzP7/
         5uRw==
X-Forwarded-Encrypted: i=1; AFNElJ8vrNvJGmyT4t6NhDo8MlPDErA8n5hppBu/jHC0+yoBEaxoZctWuEu472zEr//J9LqgRdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVtVUxu0etq8WUkAFICDtxzEg6Z+sipcdQU96ZpviP0sQpRuas
	P+9D17mZmbdzPzxZIjisZF8Mhyw60vX2edPFSecx+2R+KiKNUoscxdCGUgimVYHT
X-Gm-Gg: Acq92OFfZqt22k9yQpRGyVyb2+OlwF7t3biW/fyJxu9XSSyCNxvXbAdat0qENB+3S9+
	s1mDeW3Dln/D2jLEQER1j3t1d/ALuGvuqWe/RTUPAoz+F7fo5wqi4MqUMXjbRwnmlNQ+2kRr9Zz
	dCURFVrxV8MXTkZwRunuYUzU4g6tCGfvyq4Q9yOUhOzCVh803rH3/hkEOQL5QtImJ0oQJ/gn3Au
	KrpfQND7LnjZ82Mm8EA4gaq5BSo5fZFg2671hxfNeFitV+dEOqdkR1hXGomEutyONylCdGljXBK
	x5aUk8WmNUSVR0yJFjCI46pp/GKoq4iiByJyWqoHFFRbpX+dYp9QAv1xSpzMFZqe9LvZIWMmcX0
	GIkRJ0sM7t+Ge2yoaxw+9iLmuNb0M8ZhoQKtUw+Nt6tn1QUf3m1qRSky2DoQ1+IhS0Q7jsEFWlB
	VTk8c6IGDDpDg/xBJs0UNsRdCO5q8s8O0MQbRhv47kkntZpwMh1dBMtkZeNqGegnOW3RYYO92qI
	pI4gKseIQ==
X-Received: by 2002:a05:620a:4490:b0:911:6136:281e with SMTP id af79cd13be357-911cda50e46mr1210132885a.9.1778942907599;
        Sat, 16 May 2026 07:48:27 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba36e1acsm876467085a.3.2026.05.16.07.48.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 07:48:27 -0700 (PDT)
Message-ID: <6c189058-18f0-47cf-a663-d4d177282961@gmail.com>
Date: Sat, 16 May 2026 10:48:26 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/11] git-gui: support using repository parent dir as
 a worktree
To: Johannes Sixt <j6t@kdbg.org>
Cc: egg_mushroomcow@foxmail.com, bootaina702@gmail.com, git@vger.kernel.org
References: <50df7f28-c63c-4762-b542-b888ea3604c0@gmail.com>
 <20260514143322.865587-1-mlevedahl@gmail.com>
 <20260514143322.865587-10-mlevedahl@gmail.com>
 <4d25544d-1a7e-4407-9191-1fb05ff55244@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <4d25544d-1a7e-4407-9191-1fb05ff55244@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/16/26 4:14 AM, Johannes Sixt wrote:
> Am 14.05.26 um 16:33 schrieb Mark Levedahl:
>> git-gui, since 87cd09f43e ("git-gui: work from the .git dir",
>> 2010-01-23), has had the intent to allow starting from inside a
>> repository, then switching to the parent directory if that is a valid
>> worktree.
>>
>> This certainly hasn't worked since 2d92ab32fd ("rev-parse: make
>> --show-toplevel without a worktree an error", 2019-11-19) in git, but
>> breaking this git-gui feature was unintentional.
>>
>> Add a proc to test if the parent of the git repository is a valid
>> worktree, and set that directory as the worktree if so. Use invocations
>> of git rev-parse to assure all validity and safety checks included in
>> git-core are executed.
> BTW, missing sign-off.
>
>> ---
>>  git-gui.sh | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/git-gui.sh b/git-gui.sh
>> index a03eaa7..e326401 100755
>> --- a/git-gui.sh
>> +++ b/git-gui.sh
>> @@ -1100,6 +1100,23 @@ unset argv0dir
>>  ##
>>  ## repository setup
>>  
>> +proc is_parent_worktree {} {
>> +	# Directory 'parent' of a repository named 'parent/.git' might be the worktree
>> +	set ok 0
>> +	if {[file tail $::_gitdir] eq {.git}} {
>> +		set gitdir_parent [file join $::_gitdir {..}]
>> +		set expected_worktree [file normalize $gitdir_parent]
> We have [file dirname ...]. Is there a reason to avoid it?
>
>> +		catch {set git_worktree [git -C $gitdir_parent rev-parse --show-toplevel]}
>> +		if {[string compare $expected_worktree $git_worktree] == 0} {
> The purpose of this check should be explained in a comment. I think it is:
>
> For a repository with the database in a directory named .git we assume
> that the working tree is the directory containing .git. But
> configuration may point to a different worktree. Then we do not want to
> hold on to our assumption.
>
> However, whether [git -C elsewhere ...] uses the same gitdir that we
> have discovered so far cannot be told from this piece of code alone.
> Therefore, I think it is wrong to extract this check into a function.
>
> Also, I don't think we can use string comparison here. On Windows, the
> command returns the Windows style path, but Tcl my operate with a POSIX
> style path.
As you have correctly inferred, am trying to unambiguously establish that git running in
the parent directory is using  the child .git as the repository. I think this actually
requires two calls to git-revparse (--absolute-git-dir and --show-toplevel).
- the current git repo is valid to support a worktree. Will rework.

>> +			set ::_prefix {}
>> +			set ::_gitworktree $git_worktree
>> +			cd $git_worktree
> So many side-effects in a function whose name suggests that it only does
> some checks. Please, don't do that.
>
>> +			set ok 1
>> +		}
>> +	}
>> +	return $ok
>> +}
>> +
>>  proc is_gitvars_error {err} {
>>  	set havevars 0
>>  	set GIT_DIR {}
> In general, I am not a fan of commits that add new functions, but no
> call sites. Please squash this into 10/11. Ditto for is_gitvars_error in
> 06/11.
>
> -- Hannes
>

Next round should address all of your comments.
Mark
