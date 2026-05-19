Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EF9344DAD
	for <git@vger.kernel.org>; Tue, 19 May 2026 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216348; cv=none; b=UiniU5OdK92RPvf+1aIha8aEkzkqh/mLXyvufrXYcOVy8Llo9oElZ29DZ45zLxGFN2bw3PHduSZNhqHsxSYXI2HxDTqt1uUdhhsnH9rY2fwmja3YQufaUGQSSS/RALYIeaLFZsVsYXow5+n7lSgnCzf3qWE0bFGEEQnC96JXa6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216348; c=relaxed/simple;
	bh=e1O0wyJZDOnwHs7HmVpwf4nPX6hojCMUe3qTq0WmLFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbG2VYx15zchX8Vl5R+sWBRrZXQkLpjHQTcS62Uou5FnG2m61hbAzd+6yywH/E/Imf6xVfqcDSmGkmlsKBz+ZbfU9x+w8QM1NmgGZsoqED7IA7oS6+kUns5ooMM7t+SRDWP0c66kMWK4RUjuXB0VkWF6l0aK+cbnNGia/hTMAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOjm6lP6; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOjm6lP6"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7cb343d343fso34166107b3.2
        for <git@vger.kernel.org>; Tue, 19 May 2026 11:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779216346; x=1779821146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vpoppdSE53UU1qcVqoHHR2YLSNjTQAd5whEBOQ/O5sM=;
        b=OOjm6lP6q4ATpICiuegafQU1KRGt2PJXm0UO0P/kbsDbX81/OsMeAF2gxARy8KPexK
         Xap9r280tomlYlZGIWN8t3FTrlnrG8BzoTm3uU77OHQC6z7cSLyCVSXuWo21FDr5EDV5
         jzEpJt1TyQznyhPR1Tt5Fixt6tiDbD+6pAW4jOOElbgLwiKD/DkMMices9xYkTdoAMpf
         5upKOsGInP4kJBBrKULQKdHqYiLRRs1vGpDX+dybNgcim8vZUeJcxL1oKoibJtu75gkC
         U6tC45gVuj8est1LpN+uLpEFUkFh8pHmHxzbn/FmbngqsVedtX7JzEPoDp0K3YTzgCj2
         Rp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216346; x=1779821146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpoppdSE53UU1qcVqoHHR2YLSNjTQAd5whEBOQ/O5sM=;
        b=eRJBs++jFLayWBFNf5+1y4w1LkDLfG7nEJhLOPYRi4PCcdGcSVroXvUwnf+dm42y1G
         G5FHNGVRmiqcSKyQYuk2KkPwItMeEAVbthq4HV2oKmIObjdiSg5kweahM9lre2r/hBpD
         RQPSWKcF+SQsSRhIsaWKNSLp5pOj7lYadYXqnhutOLMuSfZIXCWMz6DYEgklMPYgXdn7
         rG30oTOq7LyJ83vwgB3s8X/bjGWTMkEMr+kQRlSuy0yGx9EY9gX1FjaMEnFyOL8n+EQl
         Z3CKcDoQNe97fBun2vLvHmZ2e5UXQdstu80QY7+uHEKov6PeXvK5L9wU2Q1a98pZ/jhx
         Uk0g==
X-Forwarded-Encrypted: i=1; AFNElJ/82UpA4xIy7/bDmy9bPRUKn8x0pVh2Ya1sc/w4Zk2y++5bI1vMu3QJBBXDMHQ/azOCnv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zEy/mww7Jw8vet5DXGN7T+I0BqFMCuM646V0ej62JnYSYOrl
	8fS7Ot3T+oEaGpA1BmD69sGAchPY1YD3NhiD8CtITSESTr5cYXquIRUC
X-Gm-Gg: Acq92OEfW9QWRs01UezN21TmxNJBBVrp1ltLI55Jqj4iQ0qcguxBHgSH64ICWjuDg8G
	MOYjw/CT6RbDZrySfecKHtMbEjjwI6sbbXdIxGamY0Mnqh++0F5a75IRqREYSkho/FkmEw3BLfq
	afRpQeEhIsGaBUH+cY8dyUt3QOegBba5YxVeGuexf8TJ2JYyI7yR2UTFRRsL5COSfPFe9K8CYno
	fm9YZG9oLwnP5bC/DQAlcHczJX3jeoxM+ZiWqAh9BFDf/80hisbayRXuRwatWkGW+USugEdmKVW
	Jk6E/X8VlEx8w/13WFFPY6iMVGLNzq6m6POUZtgUx/9o+UxqavUZVJKMekUlaPhHmX4VmSOU9dr
	LKM9u2T9wSzPpl1f/AAVkK+eJrX55justxm45IpDVFBwOEr0nHMCrKcAyS4HPonVskbHOcjh2ox
	/MW6u8uSDG14sqA/cPUwfcPLegIHa+Wb87DI6AB8lOnNd8O8p1CNOJEeVdNhj+PRBmgVK0htw=
X-Received: by 2002:a05:690c:9688:b0:7d0:2b7:6b16 with SMTP id 00721157ae682-7d002b76d99mr28047507b3.46.1779216346550;
        Tue, 19 May 2026 11:45:46 -0700 (PDT)
Received: from ?IPV6:2600:4040:264b:4100:d17e:f99:a560:8cad? ([2600:4040:264b:4100:d17e:f99:a560:8cad])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cfbc6b97e9sm10456177b3.45.2026.05.19.11.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 11:45:46 -0700 (PDT)
Message-ID: <ffbbd733-2af9-4ff5-9354-cb2f333927a8@gmail.com>
Date: Tue, 19 May 2026 14:45:45 -0400
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
 <fad43240-1089-4447-b97d-ee553c34eef1@gmail.com>
 <3b16fbc6-074b-410d-861e-6f77794b02a0@kdbg.org>
Content-Language: en-US
From: Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <3b16fbc6-074b-410d-861e-6f77794b02a0@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/19/26 4:21 AM, Johannes Sixt wrote:
> Am 16.05.26 um 17:42 
>
>
> I think I would be happier with the structure
>
> if not subcommand pick
>     discover gitdir
>     if error
>         set subcommand pick
>
> if subcommand pick
>     pick_repo
>     set subcommand gui
>
> because this clarifies that pick_repo must erase all current traces of
> GIT_DIR and GIT_WORK_TREE from the envionment and must complete with a
> valid setup.
>
> With the structure in the proposed patch
>
> if subcommand pick
>     pick_repo
>     set subcommand gui
>
> discover gitdir
> if error
>     pick_repo
>
> we still need the same operation of pick_repo, but after it runs due to
> a pick command, we go into "discover gitdir" mode in an already modified
> environment, something that does not happen if pick_repo runs due to the
> error in the gitdir discovery.
>
> -- Hannes
>

What I have now is

if (enabled gitdir discovery) {
    discover gitdir
    maybe an error occurs and gitdir remains {}
}

if (enabled pick && gitdir eq {}) {
    unset GIT_DIR .. (just to be friendly, could throw an error instead...)
    pick
    discover gitdir to VALIDATE pick gave us a good thing
}

if no gitdir {
    error No Repository
}

then on to worktree discovery (which also validates what pick returns as pick may not have
done so).

So, we can independently enable normal discovery or pick, and with both enabled pick can
be used to recover from an error in normal discovery. Either way, there is only one block
of code running pick, it is not a separate proc invoked multiple places. I hope this
scratches your itch.

Still scrubbing things, should send out in a day or two.

Mark
