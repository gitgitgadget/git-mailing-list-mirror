Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02B3624
	for <git@vger.kernel.org>; Sat, 18 May 2024 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715991864; cv=none; b=o0m7gS80GolA3z+H5bRLDvwPAomepzY8v6t1BDAXzAyS+DcSgjXe9au9eskI/q1p4wXKX0wNi2k/1d9zdE/NeR7O68kCRBmF2wmFh2n5YJxxHbzysTCoEuf2UyCu9VU3f5kzilUgCteNbtLkS68jv2FPcnyXo1AIeLkARw9XBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715991864; c=relaxed/simple;
	bh=qr77/yEH07y2X+z1CDHxU3EwhKMJlJDWkuaPwyi68cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZWT7WwwWBovClEz/0y+YCJmhSj9LCeSjhols6Gt+/J09oOUDvTB43aPLwsPPQk4qrZiePpHF0EvHVtafVOHDiBkyhhn+X4TTcn3a89500sG6xkQKGtRSBewojfQP1ArGVDLzx9bSIf0Ohj8azBjA1I0qMGOC29C0hp988BU8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMq26VqT; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMq26VqT"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-622e32414ffso7599867b3.1
        for <git@vger.kernel.org>; Fri, 17 May 2024 17:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715991861; x=1716596661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jO3AQNV+hYWm0YX5CR4kBINUJr0bfiQNBU4G+IroTzA=;
        b=NMq26VqTk/j9xxcvmQueMq90gBepdMm0P24FwkgBh2UV+xUNG1zthirCLtUSt6DXMq
         BLvE2+5tB1m/DhzXL3s8gLz+fHQLqOVy1QoayBywyy5vvxp6thLxVjgqYuCcAlm7PYPS
         oXsm4b6epQiMIhU5sfeQayghID13VRRgB4hPXclWbjWoMaTvGgx2mXp7yL2tKbHTraTo
         HoY/kftLG7KEMEadkTSGdkD0J2gjBfxLTAgMubJdKQnTyMbQ7fz6RgJZFh2867eWWRb1
         cAQIx4w++eSO6NcSzXGDI1Fy6gZ+DKSvz3M38bahzwra/2q5M7dIQUoDajbj/AEfDhh2
         MYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715991861; x=1716596661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jO3AQNV+hYWm0YX5CR4kBINUJr0bfiQNBU4G+IroTzA=;
        b=HC7FxirZpfB4zBvp7oAQN3PCsFvoxZgdtGj6LTHl+iaB08mPXYO/1oQMZDy+Eb0Irk
         rJ1FsuOxTPsnyh4aADI+DTpHaqJ6RXYo2hiZGKRhaKlnfobCL13lN/diyyH9kM2+OF+F
         SRpXVNEsQLZLu05zsNJpEyvRSLR2/iYWGf90eUeAF6bPCr11/7UEtzG09kdik1H4FNyY
         V4qkFfehxVwW0G6VTQklPhSoJ792FbYmvjuZHf9VdRl7LJ7ZjMKRqt1aHvZF53Sg4zqb
         b5Ga3xjx8yxUjH1MB7moVusItwh7dQ/B+/rydNYtPRG3rWOjYa+ykWuYD38DOgWqV6J9
         qArA==
X-Forwarded-Encrypted: i=1; AJvYcCW0hWAKATYER5ll0vRIhSM5CmuEuMdMQbhvI7dobSUdEtl6BKEadGmF+iznLuyXjOiW+x1XgPfbhnm2Dr4GvnTbFGC0
X-Gm-Message-State: AOJu0Yy4oRy5edkPwYTfznVsU3eeUpK+6+xUmI5Nhm/iP4EqiRMUJRaV
	TZ3zinhdVbe7SZNpNub3rlxqxR7l+MFomur3M/jdYJEwxpqD7mtU
X-Google-Smtp-Source: AGHT+IFknBnd+rxx7CQw+ZiO7Ga0lBCM1SqwwQLDxDAujgVY45AQ13yTJVO3TjgT0DGKhASvIDYOXQ==
X-Received: by 2002:a05:690c:386:b0:614:74ba:f91c with SMTP id 00721157ae682-622aff93dfamr353640297b3.19.1715991861513;
        Fri, 17 May 2024 17:24:21 -0700 (PDT)
Received: from ?IPV6:2603:6081:1e00:aaa2:a0c4:6d42:1d4b:391f? ([2603:6081:1e00:aaa2:a0c4:6d42:1d4b:391f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-622ce790e0bsm30340167b3.75.2024.05.17.17.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 17:24:21 -0700 (PDT)
Message-ID: <02d147ce-78d1-4fd9-b9b4-14b0662188c6@gmail.com>
Date: Fri, 17 May 2024 20:24:20 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re*: git log --name-only improvement: show old file name in
 rename
To: Junio C Hamano <gitster@pobox.com>
Cc: Ed Avis <ed.avis@qmaw.com>, Philip Oakley <philipoakley@iee.email>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <BL0PR11MB3460BEB60550854661B5178B9D800@BL0PR11MB3460.namprd11.prod.outlook.com>
 <xmqqsgf1i46l.fsf@gitster.c.googlers.com>
 <25ca66fb-82bc-7278-90e9-5e1999593068@iee.email>
 <xmqqh7vg2p4p.fsf@gitster.c.googlers.com>
 <BL0PR11MB34608AE271344D508676D17A9D9C0@BL0PR11MB3460.namprd11.prod.outlook.com>
 <c239ab15-4d48-4328-8bd5-8e2d77163e03@gmail.com>
 <xmqqv83cl97m.fsf_-_@gitster.g>
Content-Language: en-US
From: Nathan Faulkner <natedogith1@gmail.com>
In-Reply-To: <xmqqv83cl97m.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/17/2024 12:00 PM, Junio C Hamano wrote:
> Nathan Faulkner <natedogith1@gmail.com> writes:
> 
>> The documentation for --name-only says "Show only names of changed
>> files." I would interpret this to mean "output the names of all files
>> that changed", not "output the names of all files that changed, unless
>> git detected it as renamed".
> 
> Interesting observation, but we do show renamed files no?  Even when
> there is no content changes?  A quick experiment tells me it does,
> so "unless" is not quite correct.

It seems to me it's not showing the names of all files.  If a file was 
created and a separate file was deleted, but git happens to detect it as 
a rename, it will only show the created file even though from my 
perspective both files changed.

Though even for a true rename, I'd have expected --name-only to show all 
paths that changed (what you want if you're trying to find code owners 
or determine what needs to be rebuilt).

> diff --git c/Documentation/diff-options.txt w/Documentation/diff-options.txt
> index 0e9456957e..b9eaea32d9 100644
> --- c/Documentation/diff-options.txt
> +++ w/Documentation/diff-options.txt
> @@ -329,7 +329,8 @@ explained for the configuration variable `core.quotePath` (see
>   linkgit:git-config[1]).
>   
>   --name-only::
> -	Show only names of changed files. The file names are often encoded in UTF-8.
> +	Show only the name in the before-tree of changed files.
> +	The file names are often encoded in UTF-8.
>   	For more information see the discussion about encoding in the linkgit:git-log[1]
>   	manual page.
>   

That description sounds to me like it only shows files that existed in 
the from-commit, not any files that were created in the to-commit.

If the description is updated, it'd probably be a good idea to 
explicitly call out that --no-renames can be used to get the expected 
behavior of showing all files that changed.


This behavior can also lead to a situation where git diff --name-only 
stops reporting a file as changed when including a newer commit that 
doesn't involve the file.

$ echo '{}' > foo.json; git add .; git commit -m foo
$ rm foo.json; git add .; git commit -m delete
$ echo '{}' > bar.json; git add .; git commit -m bar

$ git diff --name-only HEAD~2 HEAD~1
foo.json
$ git diff --name-only HEAD~1 HEAD
bar.json
$ git diff --name-only HEAD~2 HEAD
bar.json

