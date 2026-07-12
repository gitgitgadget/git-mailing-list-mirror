Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021B3770B
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 09:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783848525; cv=none; b=bSBo/u0SyITELu0cbFXCjdOJsrYppALgG6ozxTwEoR8IPu3Tlpm8lV5Qw21BAzW+KBhQj1+tkrMEwZEV9iLPlxsGCPHsTfpf56hr6ttM6hCt85XuRFvC7d8x8Wtd+sCVEtbC/yPd3V8hJFEsE7TRWbEBQcmAlZq0HsaVyRvKVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783848525; c=relaxed/simple;
	bh=127agWcR1dfSPS70NuNHALOvu6T7qmSA4NWukyUiWnM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Izcq7enP9O+on/PF4pm6p7h11v1S3Iuw0MsrgAO/jei8sk/dUJslkbd4tb6x23szw7xCrMICxXT5BlAM+w5Ijdq+UMNZJFVI9mLDpt1kSC6jpZVz/Zvz0DCLuwqQwqcY4Hua7OuTJtCb9KhAjI8Yg4xOUig8RtREVoPct/XM3mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbKJ5t+n; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbKJ5t+n"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c733f15aso22174505e9.0
        for <git@vger.kernel.org>; Sun, 12 Jul 2026 02:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783848522; x=1784453322; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3zsehVTn/vU2ZjB7y+cDuLQH1+7qFdG7HeM2T3lAK3k=;
        b=RbKJ5t+nVAKjRFG8ZcvkN6LdzYHl8fejI6aZ9NbgC5W3C3kmWdG5LDgwfpDskcVZVD
         Raw0EAFqSqV0x12+ZflDgiKB+6IJYcIbG61tLAtjxZWjkSqxldOwyxrzpl6/r63URL0c
         SOezyk6wUVKnSpuEhbOyu1iTta0ngzHvFZYv0t11bhKCEgsQEVUbZ3zr6k9wrM5lkbaK
         cz7IOf9rAey4hb7oJDrv+iLEQMgLA6qe0j5Dd7NNsJmRN3sV48envL+92kcDRz/IaakS
         SJ0f6saIoD5ykUzZAmtQR4M+elm6F4efqpcZINOA1MK8SCJyJa5IxCjpRob0ud6mtO99
         ROVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783848522; x=1784453322;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3zsehVTn/vU2ZjB7y+cDuLQH1+7qFdG7HeM2T3lAK3k=;
        b=rIJzR+EPNjPaxnsgnC+UgPLJx3ZrOAvE3HlhUbHBbdTsPMo6dCJUHFl3gK0Aau4W0n
         G1ZbfzDhwgU+FoHX+FILxd+g2b+HGU9hWCEunbZrecXZXZN7NVATkKuxPsgo+h56aXhw
         7qrwKoWdzP0DaOKXr7Ruz/Es4jszmftI4Gaph/aF4EWNI1D9Q9BZVeIKYVR/jdE+Goqk
         /njw+nHehzrRkmrIDDQL/K+VKjIrBhk1wzzZcy15GO5tm44oQ4lDxp3selSA4TRuUCYb
         4eyiQunUuDagL2d0FEIWAWt3Lp4s575XA7Mq37mXnLACJoOF3J8Y5CMCazgPnDIwqSDw
         ZRPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnI+J5UIEul41zBgkU+R7HKkvGLQbtfYwioDpQRt0busqW0O7pYqkumgH32eMXG+CKJ/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0yFASYsmoOFrJAH+LVwlgCD2nbmINjwOXweYb1nW6npq6iAPr
	m14K/6o75wkgy2e/U/odg8WF55VZmDqRMZEozuUyPg3ohMIcVkmBGpUG
X-Gm-Gg: AfdE7ckwKIP1Hvyi6AmOn1QzbFiGHJ1toHpWAok96fAMzwE32dnGU1U+Cp7ruoKpacW
	PCwZNKMfsRWo8ascKYfv0AtLxBpwtB9ApJa4w1Uhu2yTa/qQbpkOHPCHyC7XKlK+G+8OPqS8rij
	DANP9UTNJxxeCbFEvz8CQeekJx8w1dsatR3PFsAlBRkbTuzmnwKvdgqUGGJSnNkjgszN9ovmsCd
	i2yS6sOXt26smv6qmXbPazceaEcC12nkbZInmTHu+FxEpFUoLx7gkPThj6xgrNW74DpSgzvov6n
	WCcmJL0RWq+E7p9SCS7ghVFij5jHJI/9HYmCEz37/OAcRi+EhrX/iHl9mCI1i2lBPz2JVc40auc
	DShA2njo3H2Y8LYg3DCaPjqhIvg850Y182IEq92hY2bg+CzQP0h41hGbNFly9OGBLHEiUQArbKL
	FA0hi3InbEZveuMsUDzOKb+qTo82ZJLQG2kgAH11baurKNxV/FCssdUeqSkF2Drk0fY6KZs+TwS
	q1igVYyGnpkEiF3B74lU3GAzOhiKQiBJV3f/I4aPfsVdJBwha3aEoh5II1vGhbTK9mWHaIMFR0p
	WMz/IHB/dXn5QiTWZjV0xCOBpMnfGSpm4XH+4vKzUhNKq0pQrYqOMszIjkKu49TjVmiXKE4Choy
	CAuJx
X-Received: by 2002:a05:600c:4f8a:b0:493:9cb3:53fc with SMTP id 5b1f17b1804b1-493f87e72cdmr48491925e9.11.1783848522161;
        Sun, 12 Jul 2026 02:28:42 -0700 (PDT)
Received: from localhost (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f567eadfsm166613525e9.6.2026.07.12.02.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 02:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 12 Jul 2026 11:28:39 +0200
Message-Id: <DJWHIWVJ52UW.24D8DAKBNDMLB@gmail.com>
To: "Tian Yuchen" <cat@malon.dev>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>, <git@vger.kernel.org>
Cc: <cirnovskyv@gmail.com>, <szeder.dev@gmail.com>, "Christian Couder"
 <christian.couder@gmail.com>, "Ayush Chandekar" <ayu.chandekar@gmail.com>,
 "Olamide Caleb Bello" <belkid98@gmail.com>
Subject: Re: [PATCH v9 1/9] repository: introduce repo_config_values_clear()
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260708160300.8852-1-cat@malon.dev>
 <20260709161145.13349-1-cat@malon.dev>
 <20260709161145.13349-2-cat@malon.dev>
 <DJVWYOJNU0IW.1M107L4ABH54V@gmail.com>
 <95f46463-a6e7-4b35-8ff4-ac89cadd6437@malon.dev>
In-Reply-To: <95f46463-a6e7-4b35-8ff4-ac89cadd6437@malon.dev>

On Sat Jul 11, 2026 at 8:35 PM CEST, Tian Yuchen wrote:
> Hii Pablo,
>
> On 7/12/26 01:21, Pablo Sabater wrote:
>> On Thu Jul 9, 2026 at 6:11 PM CEST, Tian Yuchen wrote:
>>> As part of the ongoing libification effort, dynamically allocated
>>> global configuration variables are being moved into
>>> 'struct repo_config_values'. To prevent memory leaks, we need a
>>> destructor to free these heap-allocated variables when a repository
>>> instance is torn down.
>>>
>>> Introduce 'repo_config_values_clear()' in environment.c and invoke it
>>> from 'repo_clear()' in repository.c. As a starting point, update this
>>> new function to handle the cleanup of 'attributes_file'.
>>
>> Makes sense.
>>
>>>
>>> Note:
>>>
>>> Submodules are currently not supported by repo_config_values(), which
>>> explicitly BUG()s out if 'repo !=3D the_repository'. Since repo_clear()
>>> cleans up all repository instances, we must bypass them to prevent
>>> crashing.
>>>
>>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>>> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>>> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
>>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>>> ---
>>>   environment.c | 19 +++++++++++++++++++
>>>   environment.h |  9 +++++++++
>>>   repository.c  |  1 +
>>>   3 files changed, 29 insertions(+)
>>>
>>> diff --git a/environment.c b/environment.c
>>> index ba2c60103f..13677484de 100644
>>> --- a/environment.c
>>> +++ b/environment.c
>>> @@ -726,3 +726,22 @@ void repo_config_values_init(struct repo_config_va=
lues *cfg)
>>>   	cfg->sparse_expect_files_outside_of_patterns =3D 0;
>>>   	cfg->warn_on_object_refname_ambiguity =3D 1;
>>>   }
>>> +
>>> +void repo_config_values_clear(struct repository *repo)
>>> +{
>>> +	struct repo_config_values *cfg;
>>> +
>>> +	/*
>>> +	 * NEEDSWORK: Submodules are currently not supported by
>>> +	 * repo_config_values(), which explicitly BUG()s out if
>>> +	 * repo !=3D the_repository. Since repo_clear() cleans up all
>>> +	 * repository instances, we must bypass them here to prevent
>>> +	 * crashing.
>>> +	 */
>>> +	if (repo !=3D the_repository)
>>> +		return;
>>> +
>>> +	cfg =3D repo_config_values(repo);
>>> +
>>> +	FREE_AND_NULL(cfg->attributes_file);
>>> +}
>>> diff --git a/environment.h b/environment.h
>>> index 6f18286955..c4a6a45704 100644
>>> --- a/environment.h
>>> +++ b/environment.h
>>> @@ -135,6 +135,15 @@ int git_default_core_config(const char *var, const=
 char *value,
>>>
>>>   void repo_config_values_init(struct repo_config_values *cfg);
>>>
>>> +/*
>>> + * Frees memory allocated for dynamically loaded configuration values
>>> + * inside `repo_config_values`.
>>> + *
>>> + * As dynamically allocated variables are migrated into this struct,
>>> + * their FREE_AND_NULL() calls should be appended here.
>>> + */
>>> +void repo_config_values_clear(struct repository *repo);
>>
>> I think that I'm not comfortable having the _init() and the _clear()
>> functions with different signatures.
>>
>> _clear() takes struct repository to dodge a BUG().
>>
>> I would like to have both signatures equal, why can't we just do directl=
y:
>>
>>    void repo_config_values_clear(struct repo_config_values *cfg)
>>    {
>>    	FREE_AND_NULL(cfg->attributes_file);
>>    }
>>
>> and call from repo_clear():
>>
>>    repo_config_values_clear(&repo->config_values_private_)
>>
>
> I particularly agree with your point that the signatures of these two
> functions should be consistent. I missed it tbh...I will change it in
> the next reroll.
>
> However, I think it makes more sense to refactor to pass in 'struct
> repository', which is consistent with repo-settings.

Whatever the signature is as long as it's symmetrical, is fine by me. Howev=
er
having 'struct repository' on _init() just passes the problem that
_clear() had.

Let's look at initialize_repository():

	void initialize_repository(struct repository *repo)
	{
		if (repo->initialized)
			BUG("repository initialized already");
		repo->initialized =3D true;
	[snip]
		repo_config_values_init(&repo->config_values_private_);
	[snip]

if we change the _init() signature to receive 'struct repository', how do
we access our _private_ field? We cannot call repo_config_values() on
repo_config_values_init() because initialize_repository() is also called fo=
r
submodules (repo_init() -> initialize_repository()) so we would BUG() out.
We would have to access the _private_ field directly at _init().

With _clear() accessing directly the _private_ field we can forget about
the NEEDSWORK, it works for every repository.

>
>> I get that the workaround might be to not access directly to
>> &repo->config_values_private_ which repo_config_values() returns but for
>> example initialize_repository() access this _private_ field directly as
>> well.
>
> Now that we have used the _private_ suffix, if we can just define a
> _clear() to bypass the assertion of repo_config_values(), wouldn't this
> be self-deception? I'm not saying that the original lines are
> necessarily correct... but I do think that semantically speaking, it is
> inappropriate to pass in config_values_private_ to _clear().

I don't think it would be "self-deception": _init() and _clear() are the
start and end of this _private_ field's lifecycle so having them receive
'struct repo_config_values' directly sounds reasonable to me.

>
>> Also at repo_init(), initialize_repository() sets repo->initialized
>> before anything can fail and call repo_clear() but
>> repo_config_values_clear() should be able to free attributes_file even
>> just after a memset() (which happens before initialize_repository()).
>> But calling repo_config_values has a BUG() in case of
>> !repo->initialized are we comfortable with this assert?
>
> This goes back to the previous topic: Who is responsible for the call to
> _clear()? Who is responsible for filtering all those invalid usage of
> repo instances? Faced with a repo instance that was not initialized but
> was handed over to _clear() in some way, we have two concepts:
>
> - It doesn't matter. Since we always handle config_values_private_, it's
> NULL at this point, so we don't BUG() and continue.
>
> - The very existence of such a repo is a mistake. It shouldn't have
> appeared and shouldn't have been passed on to me. However, since this
> situation is relatively common at this point, we choose to return
> instead of BUG()ing it directly to temporarily avoid it. We will
> gradually tighten the conditions. When the invalid calls are eliminated
> in the end, such checks will no longer exist.
>
> Our consensus should at least be that this 'use of uninitialized repos'
> is bad, so they are just two different ways to solve unexpected
> situations. However, in my opinion, the difference between these two
> concepts lies in whether we are consciously moving the assertion
> downward. I think the latter line of thinking does this better.

Sounds reasonable, but I think I would go with the first thought of "It
doesn't matter...".

Having _clear() access directly removes the need for tightening the
conditions, because there would be none. The _clear() works for any repo
as long as it has gone through a memset().

I think that the ones that should ensure that we don't have a "bad
repository" should be the rest of the code and leave _clear() to just
clear.

>
>
>  >
>  > Even with the NEEDSWORK it is a silent return, what will happen when
>  > submodules are supported? If no one remembers to change it we will lea=
k
>  > the submodules silently.
>  >
>
> I will remember to change it ;)
>
> Regards, yuchen
>
>>> +
>>>   /*
>>>    * TODO: All the below state either explicitly or implicitly relies o=
n
>>>    * `the_repository`. We should eventually get rid of these and make t=
he
>>> diff --git a/repository.c b/repository.c
>>> index 187dd471c4..b31f1b7852 100644
>>> --- a/repository.c
>>> +++ b/repository.c
>>> @@ -388,6 +388,7 @@ void repo_clear(struct repository *repo)
>>>   	FREE_AND_NULL(repo->parsed_objects);
>>>
>>>   	repo_settings_clear(repo);
>>> +	repo_config_values_clear(repo);
>>>
>>>   	if (repo->config) {
>>>   		git_configset_clear(repo->config);
>>
>> Regards,
>> Pablo

Regards,
Pablo
