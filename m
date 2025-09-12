Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA65C33A004
	for <git@vger.kernel.org>; Fri, 12 Sep 2025 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757703348; cv=none; b=icWruM4dVvIidXsY+OvEH8SphVFrhbDoPpmpyCOxgv0syzEJqqEZXYLg1VIyHeoLy383K/l6HEMuHd6gaPjjDRh5Gu5xp2R2mkqcKJbD4hQEOCumWfJHwZ1WqiyFd9KWfi3EAgOsOCHeYNgmnT/888/mglr4Wez4ZrFkUS6m1ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757703348; c=relaxed/simple;
	bh=GPW9Xn+J4jLZmoFBRXf4vn37Fc7fRUBlPv5Bi03G71Q=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SfPRwRc1SdQ56DswQuBt5t5qNyrAv0fmOJzu84LqwZqHwicfLmfYGPZFuuyTwUU1kmmqEHi6jAb72Thpot1y4vJz473zigmFs/CDxMIg8kOZmwzDdpFyctoVroE5+a/79G9RyzPDQR3LE8pZMODz5dvvpNwCUCNv3pKgssX5F34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjKpfo9T; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjKpfo9T"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so1306496f8f.2
        for <git@vger.kernel.org>; Fri, 12 Sep 2025 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757703345; x=1758308145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X3+dXm5/E1QGLfEPKgd3ALeTEg8Uywij8LxEen9ZajA=;
        b=AjKpfo9T7Xbqi4dYDZFdhlS2kRf8LeQw7pU/W137vZEU4c+I39bkae+F6/51BpXBOL
         FsivukiOnzU2x/yHIiafnQu897hRzurQa+65u3LNViP+BYi6sLQYjlTb8DaaaXxOH1SQ
         2X+PooW6tbkvfuBAbC8rHTdrrvHKq24CjKIf5sr3MAHhKDHlEGAB4hIM8QJ3bf1uwVXL
         fDG0TT+A5zuyJfz5UCqr6SAuCLo8ss57omKgV5xRtVWVl7qK0KWTFShsrGLZ2JQQVxAR
         AgmMaTJL28uvgWdzYq1J82larpbzIiSEa8bBNnvyV7mH6hfepZuAIdzB1ceiQ/Je0DZf
         7qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757703345; x=1758308145;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3+dXm5/E1QGLfEPKgd3ALeTEg8Uywij8LxEen9ZajA=;
        b=ddbrO3g3Vr/x0pBkjlPTG7Jw1RGljbEQiTXSfZSUx5jg9TLlms2GDLS8MzvpOlVCxv
         WxkvMoW57hIeP85mNteCqAI3EtNGG9/9xxL8b/3tY0hmdr7brxlHXpln57qlF6rJ9i5G
         qxUCg7tBU/j9lMo0ieR/sme52DR0eNPJle9K9/4lMvB8nwh6nR3GDTQBLTBONIaWGzTJ
         ECfy7KHXTteDwjjBMyLEhfnChcMjjlKSfgi92IoPU/7Rmv2JCRS51juIGcti3Gu7NNU1
         3iFGMRwU7n0UKf+I2HEwl7SUVUPp7yO01Duk5CRcnjM5BB8JtmY0fEDu1sPWTEDSvNFz
         ECoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Kne/NQGQspNbbyN3Xq7GglzBzmlyOUrWdrYsKSX0MsKnLD1D3/KqiOg0cdSo06fldy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwynE6mzWEQGk4j8+vtcAPHtHP5nL2TazTytybv4tbD7h1bs5KU
	sYTi+5MVbQIp78FFHCWGVORMOALF0gzkYeW7yUA/R4H0/yhNmDIQ4OXX
X-Gm-Gg: ASbGncuXESxskqKtOkzpH1wS15C8v33YPyzXaQ5fmbKW3mkNBwziVQL9fEiMB/RmmJ5
	FKgRg20wUsi0P6d+yV8j9KGS6AvkxcATUgEpkC6Epw1GKXboFKsIRGmXOwzhqbPxPZ4BrpYBEv6
	MENvVZ3qRn4kVYLmay/jTCi7jYgjB8NZW/TcVqgOurGbH+Zt1m3rDW4IhNkRVBlsQs6tzzjgGUl
	T1LiodHGpjGLo+vXUBKa+z1eBl/29riMswgvuOCO9NPw+8nNTbLQg0EjwMju3XBB7no/Hr1uJi3
	Lg29NkxZe8EbJd4qHa5AWVyLMTP81TUcxBvP3BN1nQMiqACYd3GexFHcGGygQ2sisnTAy2SBUA9
	l8FSbnzLZMqNkaJ57FziUV+WEqG9wzenDOvEj3WwJSOstyGVXbdNjYWPY3Y/BAgzcOmQyaN4FxO
	TWmgV4v6Z0pHwvWIPtszaZmp6wF9IyZ9Y=
X-Google-Smtp-Source: AGHT+IFL1qJYxV9Vsov2jtTK9KBbPMZD67zuogmgaGnrbLlSoPxlwTsum4DKMeKvv/KfZt0VQQBgAw==
X-Received: by 2002:a05:6000:2307:b0:3d1:6d7a:ab24 with SMTP id ffacd0b85a97d-3e76579311cmr4266148f8f.17.1757703344882;
        Fri, 12 Sep 2025 11:55:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:226:25e0:1d51:1977:518b:89cc? ([2a01:e0a:226:25e0:1d51:1977:518b:89cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607870cfsm7672680f8f.19.2025.09.12.11.55.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 11:55:44 -0700 (PDT)
Message-ID: <b4628cc8-3aad-4911-bcd1-6880d7707250@gmail.com>
Date: Fri, 12 Sep 2025 20:55:41 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gabriel Scherer <gabriel.scherer@gmail.com>
Subject: Re: [PATCH v3 10/11] contrib: remove "git-new-workdir"
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>,
 git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Todd Zullinger <tmz@pobox.com>
References: <20250512-pks-contrib-spring-cleanup-v3-10-32e151b0bfb0@pks.im>
 <5580aa89-09f1-426e-8483-c99481c998ab@gmail.com>
 <2b3c951b-0400-4cc5-b790-17ff77154ec2@app.fastmail.com>
 <e6003a2c-bc1b-4cf5-aae7-ef5aa9c82f10@gmail.com>
 <CALnO6CBDcDEXe3a_mpdwTi7ujL-fU5QrDeK704X+5bbkpNgb5w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CALnO6CBDcDEXe3a_mpdwTi7ujL-fU5QrDeK704X+5bbkpNgb5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/09/2025 20:14, D. Ben Knoble wrote:
>  From a quick glance, the old script symlinks various repository state
> together. You could probably get something equally useful out of
>
>      git clone --shared . ../new-worktree
>
> (Provide branch options, etc., as desired?)


Quick testing seems to indicate that --shared shares less than I would 
expect / am used to. For example, the remotes are not shared (unlike 
with `git worktree` and `new-workdir`).

I currently have 73 remotes configured for the repository I am creating 
workdirs for, and I am happy to keep them configured in a single place.

(The fact that the branch state is synchronized between all 
workdirs/worktrees is also a feature for my use-case, I don't have to 
constantly re-synchronize the work{dirs,trees} for my usage.)


> Alternatively, you could maintain the script yourself by e.g. copying
> it to somewhere on your $PATH or extracting the contrib/workdir
> history into a repo of your choice.


I have a naive question. 'workdir' is a script that has been around for 
a long while, and apparently causes no maintenance burden whatsoever. It 
was removed based on the impression that nobody was using it (let me 
quote the patch description at the end of the present email) -- I 
certainly understand that it is hard to gather information about this. 
My question: now that it is clear that some people are using it, what is 
the reason not to include it again in the contrib/ repository of git 
upstream? If Patrick is not interested in reverting this change, would I 
be welcome in sending a patch to do so?


I feel like I am making git developers relive the "workflow" xkcd comic 
(  https://xkcd.com/1172/ ). But I have the impression that 'git 
worktree' really has an interface limitation in the way 'checkout' is 
restricted; I would be happy to migrate to it if there was a way to 
disable this limitation. My use-case is to have several working 
directories for a single shared instance of a git directory, in such a 
way that I can work in each working directory independently of the 
others. In contrast 'worktree' puts limits/constraints, for a given 
workdir, depending on the state of the *other* workdirs, which would 
force me to have a global map in mind of the state of each workdir.


From: Patrick Steinhardt <ps@pks.im>
> The "git-new-workdir" command has been introduced to make it possible to
> have a separate working directory in a different place. The command thus
> predates git-worktree(1), which is what people use nowadays to create
> any such working directory. As such, the script doesn't really have much
> of a reason to exist nowadays anymore.
>
> It also doesn't seem like the script is still in use: the last time it
> has received an update was in e32afab7b03 (git-new-workdir: don't fail
> if the target directory is empty, 2014-11-26), more than a decade ago.
> Remove it as well as the tests that depend on it.

