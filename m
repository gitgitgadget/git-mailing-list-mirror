Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A68FF9C2
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czos/cUs"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so7548868f8f.1
        for <git@vger.kernel.org>; Mon, 15 Jan 2024 02:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705313940; x=1705918740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MEFL/vi8JcK02hCZgEutbrcL8Om/GYQgNVfYg2if9L8=;
        b=czos/cUsbEMRVmvH1NRj6e3FkCnpiO+AEMD/yRWnFSaEn6Hpt7PkHrTuVmOrXjLUFU
         7mERfIzrOJpYoIoWSAYwjgOEICGk/YpcdM/CkDTxTDnrkEGxqdop6ZvpYMZJAJCv/Dhq
         q1QmMzZi2AjPey6sxNuUWtJpYisMGoquUqUUNNWdaH/c4oYpTC70+9S0GgyfVy1NQEpd
         cA2hJFc+lpmP6lHAj63T4F2aNCAanIHwjvV3jL4XemGGJ/R6KVVBf3vslZ43GLCflxOm
         gNmqJa54+18g1IwBmF3GMgpx9ZvvP4DRm20tEF2MfndCQE4bqQEZ+/mlG7jlsBWD57mW
         KIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705313940; x=1705918740;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEFL/vi8JcK02hCZgEutbrcL8Om/GYQgNVfYg2if9L8=;
        b=d2MelLNqqzGEWBs6EhZitPUJpWvc0O5cQT3jRU3WTkDcEtBHN3/T3rWpszqhXB5kyq
         jAK++ztaY7Y8dQhSLsXYviyAsZHjLvOoyacuYWCMxX+lc2uefWseUCMkZLDowjxoYev5
         V9PZgysfo7OYDJStMfN3K/QD/TOe9/c81S2RpTxlPvgPgwcUWFuFUdsr3v+hp+8drgd5
         nyFLSjJ0ChZiwhubj4QhpRKwjsEDsewcboy0ElMQ5ZXvo7enIAYhikOHtsKqT08W8jT3
         EvD+AJ6u3i8K0jec67vgF92suRkVz9dP2cwzw1OaQAEeiVwgYOGRZ/sLFA8MLB264VQ7
         NRwA==
X-Gm-Message-State: AOJu0YxQ6ZM9wbGhqCn7kFRSicdyUBAYrCZ+OCPqR3hpM/fZkFvKK2Bt
	VHnGwm60xYQMtvQOLTCk82E=
X-Google-Smtp-Source: AGHT+IHiX7YgAM0e8lwuPg3h2twst+6sa/SWBYJxJAyJ19xLnFfXz3eRMykIO0M3IJDL3kJ9sc91jw==
X-Received: by 2002:a5d:6790:0:b0:336:6dad:2c71 with SMTP id v16-20020a5d6790000000b003366dad2c71mr2899532wru.111.1705313940008;
        Mon, 15 Jan 2024 02:19:00 -0800 (PST)
Received: from [192.168.1.212] ([84.64.64.237])
        by smtp.gmail.com with ESMTPSA id d11-20020adfa34b000000b00336e15fbc85sm11510483wrb.82.2024.01.15.02.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 02:18:59 -0800 (PST)
Message-ID: <0d1f662d-fcdf-457c-8a7d-35e5e8d31dcd@gmail.com>
Date: Mon, 15 Jan 2024 10:18:59 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] clone: support cloning of filtered bundles
Content-Language: en-US
To: Nikolay Edigaryev <edigaryev@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Nikolay Edigaryev via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <pull.1644.git.git.1705231010118.gitgitgadget@gmail.com>
 <24b82309-34e9-49a0-983b-7e94dad3d06b@gmail.com>
 <CAFX5hXTCPt-rDrWZ-RN8S84o_FooY3Ck2H1kMYdHQGzuetPBSw@mail.gmail.com>
In-Reply-To: <CAFX5hXTCPt-rDrWZ-RN8S84o_FooY3Ck2H1kMYdHQGzuetPBSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Nikolay

On 14/01/2024 19:39, Nikolay Edigaryev wrote:
> Hello Phillip,
> 
>> As I understand it if you're cloning from a bundle file then then there
>> is no remote so how can we set a remote-specific config?
> 
> There is a remote, for more details see df61c88979 (clone: also
> configure url for bare clones, 2010-03-29), which has the following
> code:
> 
> strbuf_addf(&key, "remote.%s.url", remote_name);
> git_config_set(key.buf, repo);
> strbuf_reset(&key);
> 
> You can verify this by creating a bundle on Git 2.43.0 with "git create
> bundle bundle.bundle --all" and then cloning it with "git clone
> --bare /path/to/bundle.bundle", in my case the following repo-wide
> configuration file was created:
> 
> [core]
> repositoryformatversion = 0
> filemode = true
> bare = true
> ignorecase = true
> precomposeunicode = true
> [remote "origin"]
> url = /Users/edi/src/cirrus-cli/cli.bundle

Oh, thanks for clarifying that I didn't realize we set "origin" to point 
to the bundle. That means this patch creates a promisor remote config 
pointing to a bundle that does not contain the missing objects. As Junio 
said that doesn't make much sense to me as the point of the promisor 
config is to allow git to lazily fetch the missing objects.

Best Wishes

Phillip

>> I'm surprised that the proposed change does not require the user to pass
>> "--filter" to "git clone" as I expected that we'd want to check that the
>> filter on the command line was compatible with the filter used to create
>> the bundle. Allowing "git clone" to create a partial clone without the
>> user asking for it by passing the "--filter" option feels like is going
>> to end up confusing users.
> 
> Note that currently, when you clone a normal non-filtered bundle with a
> '--filter' argument specified, no filtering will take place and no error
> will be thrown. "promisor = true" and "partialclonefilter = ..." options
> will be set in the repo config, but no .promisor file will be created.
> This is even more confusing IMO, but that's how it currently on
> Git 2.43.0.
> 
> You have a good point, but I feel like completely preventing cloning of
> filtered bundles and requiring a '--filter' argument is very taxing. If
> you've already specified a '--filter' when creating a bundle (and thus
> your intent to use partially cloned data), why do it multiple times?
> 
> What I propose as an alternative here is to act based on the user's
> intent when cloning:
> 
> * when the user specifies no '--filter' argument, do nothing special,
>     allow cloning both types of bundles: normal and filtered (with the
>     logic from this patch)
> 
> * when the user does specify a '--filter' argument, either:
>    * throw an error explaining that filtering of filtered bundles is not
>      supported
>    * or compare the user's filter specification and the one that is
>      in the bundle and only throw an error if they mismatch
> 
> Let me know what you think about this (and perhaps you have a more
> concrete example in mind where this will have negative consequences)
> and I'll be happy to do a next iteration.
> 
> 
> On Sun, Jan 14, 2024 at 10:00 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Nikolay
>>
>> On 14/01/2024 11:16, Nikolay Edigaryev via GitGitGadget wrote:
>>> From: Nikolay Edigaryev <edigaryev@gmail.com>
>>>
>>> f18b512bbb (bundle: create filtered bundles, 2022-03-09) introduced an
>>> incredibly useful ability to create filtered bundles, which advances
>>> the partial clone/promisor support in Git and allows for archiving
>>> large repositories to object storages like S3 in bundles that are:
>>>
>>> * easy to manage
>>>     * bundle is just a single file, it's easier to guarantee atomic
>>>       replacements in object storages like S3 and they are faster to
>>>       fetch than a bare repository since there's only a single GET
>>>       request involved
>>> * incredibly tiny
>>>     * no indexes (which may be more than 10 MB for some repositories)
>>>       and other fluff, compared to cloning a bare repository
>>>     * bundle can be filtered to only contain the tips of refs neccessary
>>>       for e.g. code-analysis purposes
>>>
>>> However, in 86fdd94d72 (clone: fail gracefully when cloning filtered
>>> bundle, 2022-03-09) the cloning of such bundles was disabled, with a
>>> note that this behavior is not desired, and it the long-term this
>>> should be possible.
>>>
>>> The commit above states that it's not possible to have this at the
>>> moment due to lack of remote and a repository-global config that
>>> specifies an object filter, yet it's unclear why a remote-specific
>>> config can't be used instead, which is what this change does.
>>
>> As I understand it if you're cloning from a bundle file then then there
>> is no remote so how can we set a remote-specific config?
>>
>> I'm surprised that the proposed change does not require the user to pass
>> "--filter" to "git clone" as I expected that we'd want to check that the
>> filter on the command line was compatible with the filter used to create
>> the bundle. Allowing "git clone" to create a partial clone without the
>> user asking for it by passing the "--filter" option feels like is going
>> to end up confusing users.
>>
>>> +test_expect_success 'cloning from filtered bundle works' '
>>> +     git bundle create partial.bdl --all --filter=blob:none &&
>>> +     git clone --bare partial.bdl partial 2>err
>>
>> The redirection hides any error message which will make debugging test
>> failures harder. It would be nice to see this test check any config set
>> when cloning and that git commands can run successfully in the repository.
>>
>> Best Wishes
>>
>> Phillip
