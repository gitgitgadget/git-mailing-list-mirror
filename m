Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AADE646
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708054337; cv=none; b=WMTWE4IstNgrxbfWG4iptuy+/3QsFWNDPWwuYFSf5042bgwCMSytGrV7fLvbjve1yV9E60s0ee2/xLGwA3JhU8wGSJypzALqylHmkiBjGyIaVFke1AswAOyW/GMZyMrq6CsTiLWyEgE51rLhWRc2oPXaxX3j3aVcEqfdlbLzWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708054337; c=relaxed/simple;
	bh=T9H1e0cW0Ipo4aHaPI6RL49mf/aSmguTwe7oF2AuKio=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fU5J63NMGA36z3zPlqwi3XgvPRVQ2io5A07q51GX7cTbGMnsFSMo+Dzpu/9vGxt6ngod2/49tcbED6jwjGpTECQAOCfXaXdF4ONV8MQIXduCWWKs1Mb75aueEYEEl1GjiPOqsho0etiJJzrUafkboQF7hrOk4dMAHYh9fd/Qngg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=pVfIZ+f8; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="pVfIZ+f8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708054331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2F0MQ1cF5XyLLMuVHVKlnNybUJQQUczk4Dj/OXDi9o=;
	b=pVfIZ+f8Jz5lRbnEx2SVoMXRHJ0HhLVTtvyzQvQHTJmCGgOV+RkpxxF/jTndtL6RAURkBJ
	tUwXcNJPG2GIDmJYqJUWMcAci/jmSUXK4FMujdMUmip32oQy6p9v4YISDMzKVQwHcbi0fB
	pp7uBgCc4mgDHIpFJFyCidfjNwPdZwIXm0wkrE6uIYVkVB7ZKoI6nQlB+lqsTrZmgBCZ1y
	gKG7YvNCSABAuNr8AU87fuNADoOZ3lw8uTbIcd9BB1X+8bCyQSD65dC/NduIHSIWUCBruQ
	W2thqf74yV+5UzCsvSk1kPQQ/L0quW1pHOY1BVQ5j71V824HidgVMKkdL+8/hQ==
Date: Fri, 16 Feb 2024 04:32:10 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
 <e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
 <xmqq8r3lnzp0.fsf@gitster.g>
 <2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
Message-ID: <ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-16 00:34, Rubén Justo wrote:
> On 15-feb-2024 14:13:31, Junio C Hamano wrote:
>> Rubén Justo <rjusto@gmail.com> writes:
>>> On 15-feb-2024 19:42:32, Dragan Simic wrote:
>>> Let me chime in just to say that maybe another terms could be 
>>> considered
>>> here;  like: "<branchname>" and "<newbranchname>" (maybe too long...) 
>>> or
>>> so.
>>> 
>>> I have no problem with the current terms, but "<branchname>" can be a
>>> sensible choice here as it is already being used for other commands
>>> where, and this may help overall, the consideration: "if ommited, the
>>> current branch is considered" also applies.
>> 
>> Actually, we should go in the opposite direction.  When the use of
>> names are localized in a narrower context, they can be shortened
>> without losing clarity.
> 
> I did not mean to have longer terms, sorry for that.
> 
> I was thinking more in the synopsis:
> 
>     'git branch' (--set-upstream-to=<upstream> | -u <upstream>) 
> [<branchname>]
>     'git branch' --unset-upstream [<branchname>]
>     'git branch' (-m | -M) [<branchname>] <new>
>     'git branch' (-c | -C) [<branchname>] <new>
>     'git branch' (-d | -D) [-r] <branchname>...
>     'git branch' --edit-description [<branchname>]
> 
> To have more uniformity in the terms, which can be beneficial to the
> user.

Here's what I think the example from above should eventually look like:

      'git branch' (--set-upstream-to=<upstream> | -u <upstream>) 
[<name>]
      'git branch' --unset-upstream [<name>]
      'git branch' (-m | -M) [<old>] <new>
      'git branch' (-c | -C) [<old>] <new>
      'git branch' (-d | -D) [-r] <name>...
      'git branch' --edit-description [<name>]

Though, it's something to be left for future patches, which will move
more argument descriptions to the respective command descriptions.

> We don't say that "--edit-description" defaults to the current branch;
> It is assumed.  Perhaps we can take advantage of that assumption in
> -m|-c too.

We don't say that yet, :) because the description of the command for
editing branch descriptions is detached from the description of its
arguments.  The plan is to move all of them together.

> Of course, there is no need (perhaps counterproductive) to say "branch"
> if the context makes it clear it is referring to a branch.
