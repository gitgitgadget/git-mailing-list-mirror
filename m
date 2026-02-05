Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA433A9605
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300658; cv=none; b=NffmenOg4St/qcbXLEdiWV130j33+p/NYmjQ+0g835YktCKK1EadzZwsZk1yz1QsGFykonUKZP1UEH3J0bR6Jh9EpJ5zOAz+z9v3peAFnWLsDWqfPTpLfWI2kse7dnuwIn3QlTTB7BQE1tuwMse1UhQ/0YZ2vceawnOW0bXdj7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300658; c=relaxed/simple;
	bh=AvQutYRweT3EDZf+zPbskZU8nWmvQaerqCKdafWS0ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yy3UopfkMO4DXCidCmFHhpMJ4+mVHpu5JG8Ux9uQb6zcKFrm7ShDPaN+E3TBIizF2Gxlk5dokYA1h5Aiig8hZcaKFOZx7Bn9fksyXUE+7bzar/kUTLxNjnn3JnbgOyttBocjLGCaWGf7XsbzWcZ0g+0AH4ScaFszYAavkPEL0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnEXpJCO; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnEXpJCO"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5033a2c4b81so11417881cf.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770300657; x=1770905457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gid2W1ejkVr3FyZfs60re+ZSojWbE2gchdgTX+aZYD8=;
        b=VnEXpJCOY5jukE6xIuopXmX/iOD2EscfkJbe90vs3XwUtTq4en/7FKoDjWpMsJVoEI
         nkmhADmqV5OwDNtJyakaQK9fj+0xUeBopfvwosPZOfX0H91LXAoaLcbnXSOp42nc0QJA
         eKODa9WsgVsbzFOrWFak4IEE/QWgpmwqBWIR+isomelID6XgxoJkZowWaODKyYcbouSU
         TywcTwibO1+fS6REBndbpJ1ya6FjFTQWaQgn10CmVjP4q71qea2eYXe+7ogPyTpNbEP3
         0FSVTnxUbzcqaxh4s+LGLctlXJQQWz4ZTCpvopgqR96OB4dH3Vnzn93wHLxeZpfq4uDO
         gSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770300657; x=1770905457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gid2W1ejkVr3FyZfs60re+ZSojWbE2gchdgTX+aZYD8=;
        b=fZjawQjUOvXuM6oV+CRn06DwwKhsVTY/rVvmUJS2MdNnQ4TmJtPsqsAA5bhBKArjh6
         YRI61t3kI6dU0QIukbDnZSOe7Gt8UGhaWqBrykrs/wKxcdJRPtcNHWox6WsHwGBNLlKx
         M3Uvtx86RYoyjM1w2U1Wrq57CztXg5k1MtdKzGqKkKBZ0GxaO0zKUR/xFW+O3UQygUJh
         tV1JtIh08riWhXULbZeUKyR+5dAIzgkNC9OmenQakCArOq1/p7Rqi0aet2G0qdXCbNSg
         rbt5L41Dsz2vVf5a+1WlovYQVv4GqmVMzl1IR4/NB/DtpMAVgtXhhd4zLIVveG7HrhvM
         LJuA==
X-Gm-Message-State: AOJu0YyU8Ar6MMSraDYTH7x/Z6ZWOs9LV96YoQ6uu0N0P/Q6G5Kje236
	qktBer2np1C44Qh7RG9druwLDN2rspduoBWHfByVibZz+At3VhzC9sPmxAIQBw==
X-Gm-Gg: AZuq6aKOESNd2Yqirrkq4pg1+Do3sb3ubkMiZ1ec/AHF7206D25nVqh73UMRWvRCWZ3
	kMnTDCTmZgRQdhX4SI1QiyYtcmPLAWlcqfTSmZlwEh9B0zNgNjgIgNFyYLlmAMI043pNqvj7/Kg
	P1P+NPF3qtzJEzHMhisig6AAmfvYyrYcl8odQLq2McTgfDn7YmxdRGHtyOXa/KHSXIU1/BHCTV2
	yQudyS4nRCqQgxI9xwFW5u+qi/1P20gWceR6Qm5JGvOwGpkIQmLfLSm2L+IYaEkRvChyo4dCR3d
	FoJ7eOJiipEVanjw6zNg8bOyi1IzmNgkBM+09KPUJpwg9924u13EXH2ZGaNfpceOCKRk700GMMV
	dlawkMoxEh+A839xSwlBbeAIlyWvVVRiakWe3M7f45a7rm8sp8PnGawKdaqZxoOxH3aHXoB+i9J
	BgmlKfa9mDn+lsdh9zKIkz5lZ9CmCSoycWHmO8PgiHTOWwyuxtCj9GzOuJ6w==
X-Received: by 2002:a05:622a:1915:b0:4ee:19d6:fadd with SMTP id d75a77b69052e-5061c0d5365mr84319281cf.4.1770300656787;
        Thu, 05 Feb 2026 06:10:56 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521bffb41sm42398336d6.4.2026.02.05.06.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 06:10:56 -0800 (PST)
Message-ID: <36bae79b-576f-48f1-b31c-15c3a1f4bce7@gmail.com>
Date: Thu, 5 Feb 2026 09:10:55 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] [RFC] config-batch: a new builtin for tools
 querying config
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.2033.git.1770214803.gitgitgadget@gmail.com>
 <xmqq5x8cnm93.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq5x8cnm93.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/2026 6:04 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This RFC explores a new git config-batch builtin that allows tools to
>> interact with Git's config data with multiple queries using a single
>> process. This is an orthogonal alternative to the effort to create a stable,
>> linkable config API. Both approaches have different strengths.
> 
> Just a few random thoughts before diving into the patches.
> 
>> My main motivation is the performance of git-credential-manager on Windows
>> platforms as it can call git config get dozens of times. At 150-200ms per
>> execution, that adds up significantly, leading to multiple seconds just to
>> load a credential that already exists. I believe that there are other
>> benefits to having this interface available, but I can't recall any
>> specifics at the moment.
> 
> So this would be "credential-manager gets started, and instead of
> having to spawn 'git config' many times, spawn a single instance of
> 'git config --batch' and talk with it".  Would it be beneficial to
> further think about a long-running 'git config --server' that can be
> contacted by a credential-manager (or other processes) whose lifetime
> is totally independent, possibly over local transport mechanisms
> like named pipes, or is it a key to keep the mechanism and design
> simple to limit the number of customer this service supports to only
> one at a time and we would prefer to keep it that way?

I could imagine a world where we have this approach, similar to the
fsmonitor server. I should do more research and refresh my memory on that
I/O model, if only to potentially reuse some of the parsing logic.

But this would be an interesting potential direction, saving the process
start-up time entirely.

The one big difficulty that I see is that the config will need to be
refreshed proactively by the server, potentially by watching the config
files themselves (including any files included along the way) and also any
changes to repo state, such as the current branch. Any repo state that
could impact the 'includeIf' logic would need to be checked carefully. 

>> One thing that I think would be valuable to include is a reload command that
>> signals that the git config-batch process should reload the configset into
>> memory due to config manipulations in other processes, especially while git
>> config-batch doesn't have all capabilities from git config. I'll include
>> that in the first version for review, if this RFC leads to positive support.
> 
> Can "git config --batch" write/modify configuration, and if so, when
> does it make its modification available to the outside world?  Would
> we have a "flush" command, or it would pretty much be immediate?

The 'set' command in this series calls methods that reach into
repo_config_set_multivar_in_file_gently() which updates the config file as
part of that call, including using the .lock file technique to avoid
concurrent writes. Looking closely, it appears we do the right thing by
parsing the existing file so we only update the new values while allowing
any concurrent writes to the file to be respected, even if they disagree
with our current view of the config.

Such assignments also update our in-memory view _of those keys_ but it may
be a good time to automatically refresh the entire set of config values.

> Can we do without an explicit "reload" command by noticing when
> the configuration files are updated and automatically reload?

This would be an interesting approach, especially for the server concept.

> I am trying to figure out how more than one "git config --batch"
> processes can coordinate with each other with minimum overhead.  It
> is not a goal to have multiple such processes, but it would be a
> goal to support multiple clients each of which would benefit from
> having access to the configuration data service (which is why I
> brought up a single and shared long-running daemon as a possible
> alternative earlier).

You're right to bring up these concerns. While 'git config-batch' is
intended to be relatively short-lived, users could build tools that keep
it alive for a long time. Thus, it is important to consider these
automatically-refreshing scenarios. And if we are automatically
refreshing, then should we instead consider a client/server model?

I have some things to explore at the highest levels. I will likely start
by exploring brian's 'git config -l -z' suggestion to see if that solves
the short-term need. But I will consider these other ideas to see where
they lead in terms of complexity and potential applications.

Thanks,
-Stolee

