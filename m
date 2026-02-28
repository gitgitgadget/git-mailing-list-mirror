Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C7FE54B
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772253539; cv=none; b=Vjg7uzbvb8x5ppH40IdORBYRtidyIK6v34lGFyRBCtaOgnPoybAlhvuba59h5l75NiOJwt+v6cWoTAzqf01UfJJs1HQ6BJtb5T42jn5qFclMmc339gwO6XtJEn9mt/DciEs7J8IJF1TF1Sz3tbm7u6262aVpnVhBrPAZ1mkNn7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772253539; c=relaxed/simple;
	bh=8oEJbV2DSJJnqYZsxiV501xEQR/37rZrZ3hmqPGEeHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siVjQUb7rkevNq6JWZMGodwQQPy538Z+CZL2ClFjSHYrHFcbQwd/bgwsCpDqUBz4whx65eQ+hT8vQrLwHqsnjc8FG5hqtN4P90PwXVET8dnsL9gQ5gjkSQK3E7FpQiNlQLdmOzpB44Mckjl++q7oYEDxVWUK0Xzu5mJmBUsoxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fr2IXhOl; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fr2IXhOl"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae3a007bd1so619925ad.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 20:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772253538; x=1772858338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x/LJiToEkGXe+v3iDmQdQwXJCbpdGC/gCwt4pwg+RAw=;
        b=fr2IXhOlseRc9MUJgZC+qMpfp6GqovUJ+8uhc+G8kdR4B2aRxjZG9VX0BR8uwxQ92E
         Y5fom/nx5qzchlwSi+8aFMMfE92r9J2zzgosMS4GP9aFnMcDZZ4ghwXjdAAilZi8ndTZ
         jzIWThFGVoGwCFjI9nc0t+vPTGHZIgEuC1zLxALfHLy4CxtyOEFcL9x8T3UG8ilOtZMq
         3ZYn/4q9wtoSpZQ9Fbq08Kn47fHD1U2gJ1khKokmHA5clczlxFiV6UvrCbMLreIPY4w+
         kX4aa9RTpIKigPiCmlQFeaTc1pAj6P2tLHnu5bjLmnE4GNLp/MAD/u0jDPPEucsnnv6I
         Y/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772253538; x=1772858338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/LJiToEkGXe+v3iDmQdQwXJCbpdGC/gCwt4pwg+RAw=;
        b=vXOZcGwGiddiQnx9Lv5WiR4wpt52zU0bPGspJ+XsrAK+LWL+ATBidi25LA4M5DLkMU
         K6gVV81rCaGpVMVG8ECGd5PAdzoHBxbKjwaRNyomy2TddjNCmU2d6NXPX9ef2gIVItZr
         jUYWYhmzjgqj9f+BqPicOCE1ZGtlxTowifftawlSB39Q+VUk6/nWM2P7k/gp4zieHBIS
         U89OY5FGzCTe4r5XYjzMhEw4WbJsbtkjh5K9g8Wxye4Edonh+GzV4QnSehT1Rh1s9uAI
         svX5tjm/Mif7tZl+FuRSW08VX+xzeC0SZAlZF5onI2w/MoO38lZ/CIPcd5BOYM7pavsA
         F0+A==
X-Gm-Message-State: AOJu0Yx8T039AeoiGoKZM0HFN796V0f5KdHRUZEfRhLkm5F/i1Mn+uxc
	PWuwLB6XXcXddvhkOZ1pOHOkj/rGGPHl5VZDXWsBJHXKTrZWakfJ8T2V
X-Gm-Gg: ATEYQzyGg1lLyVhQLa6YPQF4BAivZOJtwGWSqd0w83Zub7bbAaslCarWdQUG/NRUKGj
	RvjAnbDE7d9r8PjNKcdruGfKK8dAmj+seS94mALT4MGi/Zaz+ewq6iuncGabosYy+nXXY9PgpJj
	5qcdT0CJlc+bS70f7rJUuvAi2OcQWKpL0bWOSxOPRE001AGlvOK6r3j9hoMtQNfFc+ClS6XonYN
	3tImyVpCpoNL8SJzGqoDBFi/2BZwcgXEjZfem0QBRkIF7BzQzUwH+hrtKzXCZqR4jl7M21SChmU
	d3rEFCmVwG+UX26/Rjxzn6J9Nd9aN8AQ9UVfkYQfnPlzTtyZZZYBLfy6G66Gk+5lyVutEtvA+mA
	pb6fg1VabJXrJXozPh9AhFT+Ar4v29nzU6m0Ttq3MZC5npbspaYomydRPEWE4NkMktl4d8AS5uA
	5cnqLJqVvCPu0eKBb/9IUk3cc0jOE=
X-Received: by 2002:a05:6a21:6d88:b0:393:fb84:dc4c with SMTP id adf61e73a8af0-395c3b42d45mr3716270637.6.1772253537599;
        Fri, 27 Feb 2026 20:38:57 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4aafsm6217908a12.4.2026.02.27.20.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 20:38:57 -0800 (PST)
Message-ID: <e6e7e272-4aec-461e-aebd-33ec0a324770@gmail.com>
Date: Sat, 28 Feb 2026 12:38:54 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] setup: improve error diagnosis for invalid .git files
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
References: <20260222102928.377519-1-a3205153416@gmail.com>
 <20260223074410.917523-1-a3205153416@gmail.com> <xmqqpl5rumy0.fsf@gitster.g>
 <bcf64540-fe84-4fcc-a969-6927f348608e@gmail.com> <xmqq4in1q152.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqq4in1q152.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Junio,

Thanks for pushing back on my previous suggestion.

> It sounds like saying "oh, this is too hard, let's punt and roll all
> failures from stat() into 'nothing there, move on'", which is how
> the code used to work before this patch X-<.

Yeah, that's why I said this idea was pretty dumb. XD

Regarding your question about how 'stat()' gets into the picture, I 
tried GDB debugging and simulated Windows behavior by 'GIT_DIR=nul' (I'm 
NOT sure if it's correct). Here is the back trace caught:

(gdb) print path
$1 = 0x555555a86dd0 "nul"
(gdb) bt
#0  read_gitfile_gently (path=0x555555a86dd0 "nul", return_error_code=0x0)
     at setup.c:936
#1  0x000055555589dea1 in setup_explicit_git_dir (
     gitdirenv=0x555555a86dd0 "nul", cwd=0x555555a58070 <cwd>,
     repo_fmt=0x7fffffffcbe0, nongit_ok=0x7fffffffccc4) at setup.c:1107
#2  0x000055555589fd53 in setup_git_directory_gently 
(nongit_ok=0x7fffffffccc4)
     at setup.c:1867
#3  0x00005555555c1383 in cmd_diff (argc=4, argv=0x555555a86ce0, 
prefix=0x0,
     repo=0x0) at builtin/diff.c:458
#4  0x0000555555575e30 in run_builtin (p=0x555555a48368 <commands+840>,
     argc=4, argv=0x555555a86ce0, repo=0x555555a7bdc0 <the_repo>) at 
git.c:506
#5  0x0000555555576354 in handle_builtin (args=0x7fffffffdc10) at git.c:780
#6  0x000055555557667e in run_argv (args=0x7fffffffdc10) at git.c:863
#7  0x0000555555576b44 in cmd_main (argc=4, argv=0x7fffffffdda0) at 
git.c:985
#8  0x00005555556a73bf in main (argc=5, argv=0x7fffffffdd98) at 
common-main.c:9

Sorry it might be a bit messy. It turns out that 
'setup_explicit_git_dir()' calls 'read_gitfile_gently()' right away to 
check whether GIT_DIR is actually a gitfile, right?

Since stat("nul") fails on windows, STAT_FAILED was caught and 
immediately triggered die(), blowing up corresponding CI tests.

Still, I don't know Windows well. These thoughts are just to stimulate 
discussions. （　´_ゝ`）

Thanks,

Yuchen


